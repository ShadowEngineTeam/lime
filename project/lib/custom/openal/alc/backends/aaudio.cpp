#include "config.h"

#include "aaudio.h"

#include <algorithm>
#include <cstring>
#include <memory>
#include <mutex>
#include <thread>

#include <dlfcn.h>

#include "alnumeric.h"
#include "alstring.h"
#include "core/device.h"
#include "gsl/gsl"
#include "ringbuffer.h"

#include <aaudio/AAudio.h>

#if HAVE_CXXMODULES
import logging;
#else
#include "core/logging.h"
#endif


namespace {

using namespace std::string_view_literals;

[[nodiscard]] constexpr auto GetDeviceName() noexcept { return "AAudio Default"sv; }

[[nodiscard]] auto AAudioResultToString(aaudio_result_t const result) -> const char*
{ return AAudio_convertResultToText(result); }

/* A handful of AAudioStreamBuilder setters were added after AAudio's initial
 * API 26 introduction (setUsage in 28, setSampleRateConversionQuality in
 * 30). Referencing them directly fails to compile when targeting an older
 * minSdkVersion, since Clang's availability annotations in the NDK headers
 * turn that into a hard error, and the associated enum constants aren't even
 * declared in that case. Both are resolved dynamically here instead, so this
 * keeps compiling against any minSdkVersion and simply skips the call
 * (falling back to AAudio's own defaults) on API levels/headers that lack
 * them.
 */
using AAudioSetUsageFn = void(*)(AAudioStreamBuilder*, int32_t);
using AAudioSetSRCQualityFn = void(*)(AAudioStreamBuilder*, int32_t);

/* Mirrors aaudio_usage_t / aaudio_sample_rate_conversion_quality_t values
 * that may not be declared by an older/targeted NDK header. */
constexpr auto kUsageGame = int32_t{14};      // AAUDIO_USAGE_GAME (API 28+)
constexpr auto kSRCQualityNone = int32_t{0};  // AAUDIO_SAMPLE_RATE_CONVERSION_QUALITY_NONE (API 30+)
constexpr auto kSRCQualityHigh = int32_t{4};  // AAUDIO_SAMPLE_RATE_CONVERSION_QUALITY_HIGH (API 30+)

[[nodiscard]] auto GetSetUsageFn() -> AAudioSetUsageFn
{
    static auto *const fn = reinterpret_cast<AAudioSetUsageFn>(
        dlsym(RTLD_DEFAULT, "AAudioStreamBuilder_setUsage"));
    return fn;
}

[[nodiscard]] auto GetSetSampleRateConversionQualityFn() -> AAudioSetSRCQualityFn
{
    static auto *const fn = reinterpret_cast<AAudioSetSRCQualityFn>(
        dlsym(RTLD_DEFAULT, "AAudioStreamBuilder_setSampleRateConversionQuality"));
    return fn;
}

void SetUsageGame(AAudioStreamBuilder *const builder)
{
    if(auto *const setUsage = GetSetUsageFn())
        setUsage(builder, kUsageGame);
}

void SetSampleRateConversionQuality(AAudioStreamBuilder *const builder, bool const high)
{
    if(auto *const setQuality = GetSetSampleRateConversionQualityFn())
        setQuality(builder, high ? kSRCQualityHigh : kSRCQualityNone);
}

struct AAudioStreamDeleter {
    void operator()(AAudioStream *const stream) const noexcept
    {
        if(stream)
        {
            AAudioStream_requestStop(stream);
            AAudioStream_close(stream);
        }
    }
};
using AAudioStreamPtr = std::unique_ptr<AAudioStream, AAudioStreamDeleter>;

struct AAudioStreamBuilderDeleter {
    void operator()(AAudioStreamBuilder *const builder) const noexcept
    { if(builder) AAudioStreamBuilder_delete(builder); }
};
using AAudioStreamBuilderPtr = std::unique_ptr<AAudioStreamBuilder, AAudioStreamBuilderDeleter>;

[[nodiscard]] auto CreateStreamBuilder() -> AAudioStreamBuilderPtr
{
    auto *builder = static_cast<AAudioStreamBuilder*>(nullptr);
    if(const auto result = AAudio_createStreamBuilder(&builder); result != AAUDIO_OK)
        throw al::backend_exception{al::backend_error::DeviceError,
            "Failed to create stream builder: {}", AAudioResultToString(result)};
    return AAudioStreamBuilderPtr{builder};
}

/* Maps an already-negotiated DevFmtType back to the aaudio_format_t that
 * produced it, for rebuilding a stream with known-good settings (as opposed
 * to the initial open, which may leave this unspecified and let AAudio
 * choose). Returns AAUDIO_FORMAT_UNSPECIFIED for a type AAudio can't
 * represent directly.
 */
[[nodiscard]] constexpr auto ToAAudioFormat(DevFmtType const type) noexcept -> aaudio_format_t
{
    switch(type)
    {
    case DevFmtByte:
    case DevFmtUByte:
    case DevFmtShort:
    case DevFmtUShort:
        return AAUDIO_FORMAT_PCM_I16;
    case DevFmtInt:
    case DevFmtUInt:
#ifdef AAUDIO_FORMAT_PCM_I32
        return AAUDIO_FORMAT_PCM_I32;
#else
        return AAUDIO_FORMAT_UNSPECIFIED;
#endif
    case DevFmtFloat:
        return AAUDIO_FORMAT_PCM_FLOAT;
    }
    return AAUDIO_FORMAT_UNSPECIFIED;
}


struct AAudioPlayback final : BackendBase {
    explicit AAudioPlayback(gsl::not_null<DeviceBase*> const device) : BackendBase{device} { }
    ~AAudioPlayback() override
    {
        /* Make sure no recovery attempt is still touching this object's
         * members before it gets destroyed.
         */
        if(mRecoveryThread.joinable())
            mRecoveryThread.join();
    }

    AAudioStreamPtr mStream;
    /* Guards mStream against a race between normal start()/stop() calls
     * (invoked by the ALC layer under its own device lock) and the async
     * recovery thread spawned from errorCallback(), which runs without
     * that lock since the backend has no access to it.
     */
    std::mutex mStreamMutex;
    std::thread mRecoveryThread;

    static auto dataCallbackC(AAudioStream *stream, void *userData, void *audioData,
        int32_t numFrames) -> aaudio_data_callback_result_t;
    auto dataCallback(AAudioStream *stream, void *audioData, int32_t numFrames)
        -> aaudio_data_callback_result_t;

    static void errorCallbackC(AAudioStream *stream, void *userData, aaudio_result_t error);
    void errorCallback(aaudio_result_t error);
    void recoverFromDisconnect();

    void open(std::string_view name) override;
    auto reset() -> bool override;
    void start() override;
    void stop() override;
};

auto AAudioPlayback::dataCallbackC(AAudioStream *const stream, void *const userData,
    void *const audioData, int32_t const numFrames) -> aaudio_data_callback_result_t
{
    return static_cast<AAudioPlayback*>(userData)->dataCallback(stream, audioData, numFrames);
}

auto AAudioPlayback::dataCallback(AAudioStream *const stream, void *const audioData,
    int32_t const numFrames) -> aaudio_data_callback_result_t
{
    mDevice->renderSamples(audioData, gsl::narrow_cast<uint32_t>(numFrames),
        gsl::narrow_cast<uint32_t>(AAudioStream_getChannelCount(stream)));
    return AAUDIO_CALLBACK_RESULT_CONTINUE;
}

void AAudioPlayback::errorCallbackC(AAudioStream* /*stream*/, void *const userData,
    aaudio_result_t const error)
{ static_cast<AAudioPlayback*>(userData)->errorCallback(error); }

void AAudioPlayback::errorCallback(aaudio_result_t const error)
{
    if(error == AAUDIO_ERROR_DISCONNECTED)
    {
        /* AAudio reports ANY output route change (e.g. a headphone
         * plug/unplug switching the default device) as a disconnect, not
         * just a genuine loss of the audio subsystem. Per Android's
         * guidance, the stream must be stopped/closed from a different
         * thread than the one this callback fires on to avoid a deadlock,
         * so hand off to a separate thread that tries to transparently
         * open a replacement stream with the same settings before falling
         * back to tearing down the whole OpenAL device. The thread is
         * tracked (not detached) and joined in the destructor, since it
         * touches this object's members.
         */
        if(mRecoveryThread.joinable())
            mRecoveryThread.join();
        mRecoveryThread = std::thread{[this] { recoverFromDisconnect(); }};
        return;
    }
    ERR("Error was {}", AAudioResultToString(error));
}

void AAudioPlayback::recoverFromDisconnect()
{
    auto const streamlock = std::lock_guard{mStreamMutex};

    /* The old stream is already disconnected on AAudio's side; just drop
     * it (the deleter requests-stop and closes it).
     */
    mStream = nullptr;

    try {
        /* Rebuild using the settings already negotiated in reset(), rather
         * than re-running format/rate/channel negotiation from scratch;
         * the goal is an invisible swap, not a full renegotiation.
         */
        auto builder = CreateStreamBuilder();
        AAudioStreamBuilder_setDirection(builder.get(), AAUDIO_DIRECTION_OUTPUT);
        AAudioStreamBuilder_setPerformanceMode(builder.get(), AAUDIO_PERFORMANCE_MODE_LOW_LATENCY);
        AAudioStreamBuilder_setSharingMode(builder.get(), AAUDIO_SHARING_MODE_EXCLUSIVE);
        SetUsageGame(builder.get());
        SetSampleRateConversionQuality(builder.get(), false);
        AAudioStreamBuilder_setSampleRate(builder.get(),
            gsl::narrow_cast<int32_t>(mDevice->mSampleRate));
        AAudioStreamBuilder_setChannelCount(builder.get(),
            gsl::narrow_cast<int32_t>(mDevice->channelsFromFmt()));
        AAudioStreamBuilder_setFormat(builder.get(), ToAAudioFormat(mDevice->FmtType));
        AAudioStreamBuilder_setDataCallback(builder.get(), &AAudioPlayback::dataCallbackC, this);
        AAudioStreamBuilder_setErrorCallback(builder.get(), &AAudioPlayback::errorCallbackC, this);

        auto *streamPtr = static_cast<AAudioStream*>(nullptr);
        if(const auto result = AAudioStreamBuilder_openStream(builder.get(), &streamPtr);
            result != AAUDIO_OK)
            throw al::backend_exception{al::backend_error::DeviceError,
                "Failed to reopen stream after disconnect: {}", AAudioResultToString(result)};
        mStream = AAudioStreamPtr{streamPtr};

        const auto bufferCapacity = AAudioStream_getBufferCapacityInFrames(mStream.get());
        AAudioStream_setBufferSizeInFrames(mStream.get(),
            std::min(gsl::narrow_cast<int32_t>(mDevice->mBufferSize), bufferCapacity));

        if(const auto result = AAudioStream_requestStart(mStream.get()); result != AAUDIO_OK)
            throw al::backend_exception{al::backend_error::DeviceError,
                "Failed to start reopened stream: {}", AAudioResultToString(result)};

        TRACE("Recovered from AAudio disconnect with a replacement stream");
    }
    catch(al::backend_exception &e) {
        /* The route change genuinely can't be recovered from (no output
         * device at all, format no longer supported, etc). Give up and let
         * the ALC layer know the device is really gone.
         */
        ERR("Failed to recover from AAudio disconnect: {}", e.what());
        mStream = nullptr;
        mDevice->handleDisconnect("AAudio stream was disconnected: {}",
            AAudioResultToString(AAUDIO_ERROR_DISCONNECTED));
    }
}

void AAudioPlayback::open(std::string_view name)
{
    if(name.empty())
        name = GetDeviceName();
    else if(name != GetDeviceName())
        throw al::backend_exception{al::backend_error::NoDevice, "Device name \"{}\" not found",
            name};

    /* Open a throwaway stream just to confirm AAudio can actually produce
     * output on this device before committing to it as the active backend.
     */
    auto builder = CreateStreamBuilder();
    AAudioStreamBuilder_setDirection(builder.get(), AAUDIO_DIRECTION_OUTPUT);
    AAudioStreamBuilder_setPerformanceMode(builder.get(), AAUDIO_PERFORMANCE_MODE_LOW_LATENCY);

    auto *stream = static_cast<AAudioStream*>(nullptr);
    const auto result = AAudioStreamBuilder_openStream(builder.get(), &stream);
    if(result != AAUDIO_OK)
        throw al::backend_exception{al::backend_error::DeviceError, "Failed to create stream: {}",
            AAudioResultToString(result)};
    AAudioStream_requestStop(stream);
    AAudioStream_close(stream);

    mDeviceName = name;
}

auto AAudioPlayback::reset() -> bool
{
    auto builder = CreateStreamBuilder();
    AAudioStreamBuilder_setDirection(builder.get(), AAUDIO_DIRECTION_OUTPUT);
    AAudioStreamBuilder_setPerformanceMode(builder.get(), AAUDIO_PERFORMANCE_MODE_LOW_LATENCY);
    /* Request exclusive access to the MMAP buffer for the lowest possible
     * latency. This is only a request; AAudio silently falls back to shared
     * mode if exclusive access can't be granted (device already in use,
     * unsupported HAL, etc), so it's always safe to ask. Exclusive streams
     * are more prone to being disconnected (e.g. if another app needs the
     * device), but that's already handled via the error callback below.
     */
    AAudioStreamBuilder_setSharingMode(builder.get(), AAUDIO_SHARING_MODE_EXCLUSIVE);
    SetUsageGame(builder.get());
    /* Ask AAudio not to resample or remix behind our back; OpenAL adapts to
     * whatever the stream actually ends up giving us.
     */
    SetSampleRateConversionQuality(builder.get(), false);
    AAudioStreamBuilder_setDataCallback(builder.get(), &AAudioPlayback::dataCallbackC, this);
    AAudioStreamBuilder_setErrorCallback(builder.get(), &AAudioPlayback::errorCallbackC, this);

    if(mDevice->mFlags.test(DeviceFlag::FrequencyRequest))
    {
        SetSampleRateConversionQuality(builder.get(), true);
        AAudioStreamBuilder_setSampleRate(builder.get(),
            gsl::narrow_cast<int32_t>(mDevice->mSampleRate));
    }
    if(mDevice->mFlags.test(DeviceFlag::ChannelsRequest))
    {
        /* Only request mono or stereo explicitly; leave anything else
         * unspecified so AAudio reports back whatever the device natively
         * supports.
         */
        AAudioStreamBuilder_setChannelCount(builder.get(),
            (mDevice->FmtChans==DevFmtMono) ? 1
            : (mDevice->FmtChans==DevFmtStereo) ? 2 : AAUDIO_UNSPECIFIED);
    }
    if(mDevice->mFlags.test(DeviceFlag::SampleTypeRequest))
        AAudioStreamBuilder_setFormat(builder.get(), ToAAudioFormat(mDevice->FmtType));

    auto *streamPtr = static_cast<AAudioStream*>(nullptr);
    auto result = AAudioStreamBuilder_openStream(builder.get(), &streamPtr);
    /* If the specific combination of format/rate/channels can't be
     * satisfied, relax the most specific request first and retry, rather
     * than dropping everything to unspecified in one shot. This gives the
     * best chance of keeping whichever explicit setting still matters (e.g.
     * an explicitly requested sample rate survives a format mismatch).
     * Other failures (permissions, device unavailable, etc) aren't
     * format-related and shouldn't be retried this way. These are local to
     * this attempt; the device's own requested-setting flags are left
     * untouched since other code may still rely on them.
     */
    auto haveFormatReq = mDevice->mFlags.test(DeviceFlag::SampleTypeRequest);
    auto haveRateReq = mDevice->mFlags.test(DeviceFlag::FrequencyRequest);
    auto haveChansReq = mDevice->mFlags.test(DeviceFlag::ChannelsRequest);
    while(result == AAUDIO_ERROR_INVALID_FORMAT)
    {
        if(haveFormatReq)
        {
            AAudioStreamBuilder_setFormat(builder.get(), AAUDIO_FORMAT_UNSPECIFIED);
            haveFormatReq = false;
        }
        else if(haveRateReq)
        {
            AAudioStreamBuilder_setSampleRate(builder.get(), AAUDIO_UNSPECIFIED);
            haveRateReq = false;
        }
        else if(haveChansReq)
        {
            AAudioStreamBuilder_setChannelCount(builder.get(), AAUDIO_UNSPECIFIED);
            haveChansReq = false;
        }
        else
            break;
        result = AAudioStreamBuilder_openStream(builder.get(), &streamPtr);
    }
    if(result != AAUDIO_OK)
        throw al::backend_exception{al::backend_error::DeviceError, "Failed to create stream: {}",
            AAudioResultToString(result)};

    {
        auto const streamlock = std::lock_guard{mStreamMutex};
        mStream = AAudioStreamPtr{streamPtr};
    }

    const auto bufferCapacity = AAudioStream_getBufferCapacityInFrames(mStream.get());
    AAudioStream_setBufferSizeInFrames(mStream.get(),
        std::min(gsl::narrow_cast<int32_t>(mDevice->mBufferSize), bufferCapacity));

    const auto gotChannels = AAudioStream_getChannelCount(mStream.get());
    if(std::cmp_not_equal(gotChannels, mDevice->channelsFromFmt()))
    {
        if(gotChannels >= 2)
            mDevice->FmtChans = DevFmtStereo;
        else if(gotChannels == 1)
            mDevice->FmtChans = DevFmtMono;
        else
            throw al::backend_exception{al::backend_error::DeviceError,
                "Got unhandled channel count: {}", gotChannels};
    }
    setDefaultWFXChannelOrder();

    switch(AAudioStream_getFormat(mStream.get()))
    {
    case AAUDIO_FORMAT_PCM_I16:
        mDevice->FmtType = DevFmtShort;
        break;
    case AAUDIO_FORMAT_PCM_FLOAT:
        mDevice->FmtType = DevFmtFloat;
        break;
#ifdef AAUDIO_FORMAT_PCM_I32
    case AAUDIO_FORMAT_PCM_I32:
        mDevice->FmtType = DevFmtInt;
        break;
#endif
    default:
        throw al::backend_exception{al::backend_error::DeviceError,
            "Got unhandled sample format: {}", int{AAudioStream_getFormat(mStream.get())}};
    }
    mDevice->mSampleRate = gsl::narrow_cast<unsigned>(AAudioStream_getSampleRate(mStream.get()));

    /* Never update in chunks smaller than 10ms, using the reported burst
     * size as a floor for the practical minimum period.
     */
    mDevice->mUpdateSize = std::max(mDevice->mSampleRate/100u,
        gsl::narrow_cast<unsigned>(AAudioStream_getFramesPerBurst(mStream.get())));
    mDevice->mBufferSize = std::max(mDevice->mUpdateSize*2u,
        gsl::narrow_cast<unsigned>(AAudioStream_getBufferSizeInFrames(mStream.get())));

    /* AAudio can silently downgrade sharing mode, performance mode, or any
     * unspecified parameter from what was requested, so log what was
     * actually granted to make that visible for debugging.
     */
    TRACE("Got stream: sharing={} perfmode={} rate={} channels={} bufsize={}/{} burst={}",
        (AAudioStream_getSharingMode(mStream.get())==AAUDIO_SHARING_MODE_EXCLUSIVE)
            ? "exclusive" : "shared",
        (AAudioStream_getPerformanceMode(mStream.get())==AAUDIO_PERFORMANCE_MODE_LOW_LATENCY)
            ? "low-latency" : "none",
        mDevice->mSampleRate, gotChannels, mDevice->mBufferSize, bufferCapacity,
        AAudioStream_getFramesPerBurst(mStream.get()));

    return true;
}

void AAudioPlayback::start()
{
    auto const streamlock = std::lock_guard{mStreamMutex};
    if(const auto result = AAudioStream_requestStart(mStream.get()); result != AAUDIO_OK)
        throw al::backend_exception{al::backend_error::DeviceError, "Failed to start stream: {}",
            AAudioResultToString(result)};
}

void AAudioPlayback::stop()
{
    auto const streamlock = std::lock_guard{mStreamMutex};
    if(const auto result = AAudioStream_requestStop(mStream.get()); result != AAUDIO_OK)
        ERR("Failed to stop stream: {}", AAudioResultToString(result));
}


struct AAudioCapture final : BackendBase {
    explicit AAudioCapture(gsl::not_null<DeviceBase*> const device) : BackendBase{device} { }
    ~AAudioCapture() override = default;

    AAudioStreamPtr mStream;
    RingBufferPtr<std::byte> mRing;

    static auto dataCallbackC(AAudioStream *stream, void *userData, void *audioData,
        int32_t numFrames) -> aaudio_data_callback_result_t;
    auto dataCallback(void *audioData, int32_t numFrames) -> aaudio_data_callback_result_t;

    static void errorCallbackC(AAudioStream *stream, void *userData, aaudio_result_t error);
    void errorCallback(aaudio_result_t error);

    void open(std::string_view name) override;
    void start() override;
    void stop() override;
    void captureSamples(std::span<std::byte> outbuffer) override;
    auto availableSamples() -> std::size_t override;
};

auto AAudioCapture::dataCallbackC(AAudioStream* /*stream*/, void *const userData,
    void *const audioData, int32_t const numFrames) -> aaudio_data_callback_result_t
{ return static_cast<AAudioCapture*>(userData)->dataCallback(audioData, numFrames); }

auto AAudioCapture::dataCallback(void *const audioData, int32_t const numFrames)
    -> aaudio_data_callback_result_t
{
    std::ignore = mRing->write(std::span{static_cast<const std::byte*>(audioData),
        gsl::narrow_cast<uint32_t>(numFrames)*mRing->getElemSize()});
    return AAUDIO_CALLBACK_RESULT_CONTINUE;
}

void AAudioCapture::errorCallbackC(AAudioStream* /*stream*/, void *const userData,
    aaudio_result_t const error)
{ static_cast<AAudioCapture*>(userData)->errorCallback(error); }

void AAudioCapture::errorCallback(aaudio_result_t const error)
{
    if(error == AAUDIO_ERROR_DISCONNECTED)
        mDevice->handleDisconnect("AAudio stream was disconnected: {}",
            AAudioResultToString(error));
    else
        ERR("Error was {}", AAudioResultToString(error));
}

void AAudioCapture::open(std::string_view name)
{
    if(name.empty())
        name = GetDeviceName();
    else if(name != GetDeviceName())
        throw al::backend_exception{al::backend_error::NoDevice, "Device name \"{}\" not found",
            name};

    auto builder = CreateStreamBuilder();
    AAudioStreamBuilder_setDirection(builder.get(), AAUDIO_DIRECTION_INPUT);
    AAudioStreamBuilder_setPerformanceMode(builder.get(), AAUDIO_PERFORMANCE_MODE_LOW_LATENCY);
    /* Request exclusive access for the lowest round-trip latency; falls
     * back to shared mode automatically if it can't be granted.
     */
    AAudioStreamBuilder_setSharingMode(builder.get(), AAUDIO_SHARING_MODE_EXCLUSIVE);
    SetSampleRateConversionQuality(builder.get(), true);
    AAudioStreamBuilder_setSampleRate(builder.get(),
        gsl::narrow_cast<int32_t>(mDevice->mSampleRate));
    AAudioStreamBuilder_setDataCallback(builder.get(), &AAudioCapture::dataCallbackC, this);
    AAudioStreamBuilder_setErrorCallback(builder.get(), &AAudioCapture::errorCallbackC, this);

    switch(mDevice->FmtChans)
    {
    case DevFmtMono:
        AAudioStreamBuilder_setChannelCount(builder.get(), 1);
        break;
    case DevFmtStereo:
        AAudioStreamBuilder_setChannelCount(builder.get(), 2);
        break;
    case DevFmtQuad:
    case DevFmtX51:
    case DevFmtX61:
    case DevFmtX71:
    case DevFmtX714:
    case DevFmtX7144:
    case DevFmtX3D71:
    case DevFmtAmbi3D:
        throw al::backend_exception{al::backend_error::DeviceError, "{} capture not supported",
            DevFmtChannelsString(mDevice->FmtChans)};
    }

    /* Unsigned 8-bit capture would need software conversion; not handled
     * here yet, so reject it up front along with other unsupported types.
     */
    switch(mDevice->FmtType)
    {
    case DevFmtShort:
        AAudioStreamBuilder_setFormat(builder.get(), AAUDIO_FORMAT_PCM_I16);
        break;
    case DevFmtFloat:
        AAudioStreamBuilder_setFormat(builder.get(), AAUDIO_FORMAT_PCM_FLOAT);
        break;
    case DevFmtInt:
#ifdef AAUDIO_FORMAT_PCM_I32
        AAudioStreamBuilder_setFormat(builder.get(), AAUDIO_FORMAT_PCM_I32);
        break;
#endif
    case DevFmtByte:
    case DevFmtUByte:
    case DevFmtUShort:
    case DevFmtUInt:
        throw al::backend_exception{al::backend_error::DeviceError,
            "{} capture samples not supported", DevFmtTypeString(mDevice->FmtType)};
    }

    auto *streamPtr = static_cast<AAudioStream*>(nullptr);
    if(const auto result = AAudioStreamBuilder_openStream(builder.get(), &streamPtr);
        result != AAUDIO_OK)
        throw al::backend_exception{al::backend_error::DeviceError, "Failed to create stream: {}",
            AAudioResultToString(result)};
    mStream = AAudioStreamPtr{streamPtr};

    const auto frameSize = mDevice->channelsFromFmt() * mDevice->bytesFromFmt();
    /* Keep at least 100ms of capture buffered up. */
    mRing = RingBuffer<std::byte>::Create(std::max(mDevice->mBufferSize, mDevice->mSampleRate/10u),
        gsl::narrow_cast<unsigned>(frameSize), false);

    TRACE("Got stream: sharing={} perfmode={} rate={} channels={}",
        (AAudioStream_getSharingMode(mStream.get())==AAUDIO_SHARING_MODE_EXCLUSIVE)
            ? "exclusive" : "shared",
        (AAudioStream_getPerformanceMode(mStream.get())==AAUDIO_PERFORMANCE_MODE_LOW_LATENCY)
            ? "low-latency" : "none",
        AAudioStream_getSampleRate(mStream.get()), AAudioStream_getChannelCount(mStream.get()));

    mDeviceName = name;
}

void AAudioCapture::start()
{
    if(const auto result = AAudioStream_requestStart(mStream.get()); result != AAUDIO_OK)
        throw al::backend_exception{al::backend_error::DeviceError, "Failed to start stream: {}",
            AAudioResultToString(result)};
}

void AAudioCapture::stop()
{
    if(const auto result = AAudioStream_requestStop(mStream.get()); result != AAUDIO_OK)
        ERR("Failed to stop stream: {}", AAudioResultToString(result));
}

auto AAudioCapture::availableSamples() -> std::size_t
{ return mRing->readSpace(); }

void AAudioCapture::captureSamples(std::span<std::byte> const outbuffer)
{ std::ignore = mRing->read(outbuffer); }

} // namespace

auto AAudioBackendFactory::init() -> bool { return true; }

auto AAudioBackendFactory::querySupport(BackendType const type) -> bool
{ return type == BackendType::Playback || type == BackendType::Capture; }

auto AAudioBackendFactory::enumerate(BackendType const type) -> std::vector<std::string>
{
    switch(type)
    {
    case BackendType::Playback:
    case BackendType::Capture:
        return std::vector{std::string{GetDeviceName()}};
    }
    return {};
}

auto AAudioBackendFactory::createBackend(gsl::not_null<DeviceBase*> const device,
    BackendType const type) -> BackendPtr
{
    if(type == BackendType::Playback)
        return BackendPtr{new AAudioPlayback{device}};
    if(type == BackendType::Capture)
        return BackendPtr{new AAudioCapture{device}};
    return BackendPtr{};
}

auto AAudioBackendFactory::getFactory() -> BackendFactory&
{
    static AAudioBackendFactory factory{};
    return factory;
}
