#define MINIAUDIO_IMPLEMENTATION
#include <miniaudio.h>
#include <miniaudio_libopus.h>
#include <miniaudio_libvorbis.h>

#include <media/miniaudio/MiniaudioBackend.h>
#include <media/miniaudio/MiniaudioSincResampler.h>

#include <utils/File.h>
#include <utils/Bytes.h>

#include <hx/CFFI.h>

#include <stdio.h>
#include <inttypes.h>
#include <stdlib.h>
#include <memory.h>
#include <math.h>

namespace lime {

    #define ENGINE_VECTOR_STARTING_CAPACITY 4
    #define SOUND_VECTOR_STARTING_CAPACITY 32

    typedef enum {
        MA_BACKEND_SOUND_DATA_SOURCE_TYPE_INTERNAL = 0, // the data source is managed internally by miniaudio (this happens when we init from a file)
        MA_BACKEND_SOUND_DATA_SOURCE_TYPE_DECODER = 1,
        MA_BACKEND_SOUND_DATA_SOURCE_TYPE_AUDIO_BUFFER = 2
    } MABackendSoundDataSourceType;

    typedef struct {
        uint32_t soundIndex;
    } MABackendEndCallbackData;

    // Output stage. SEAL sets "output-limiter" = "true"; this deliberately does NOT use a limiter,
    // and the reason is measured rather than aesthetic.
    //
    // A limiter derives one gain for the whole master bus, so any element that peaks pulls the
    // entire mix down with it. On the real game mix (Inst peaks at 1.03 on its own, Inst+Voices
    // at 1.43) a correct 5ms look-ahead limiter ends up engaged 72% of the song at up to -3.1dB.
    // That is audible exactly the way it was reported: the vocals come in and the instrumental
    // ducks underneath them.
    //
    // The thing actually worth preventing is clipping, and only 0.02% of samples exceed 0 dBFS.
    // A soft knee handles those in place, with no gain shared between elements: measured on the
    // same mix it touches 0.319% of samples, peaks at 0.9992, and leaves the other 99.68%
    // bit-identical. No ducking, no pumping, no look-ahead latency, and no state to get wrong.
    #define MA_SOFTCLIP_KNEE 0.8f

    // Ramp applied to per-sound volume changes. Long enough to remove the click from a hard
    // mute/unmute, short enough that ducking still reads as instant.
    #define MA_VOLUME_SMOOTH_MS 10

    typedef struct {
        ma_context context;
        ma_device device;
        ma_resource_manager resourceManager;
        ma_engine engine;
        bool locked;
    } MABackendEngine;

    typedef struct {
        float stopTime;
        // loops and startFrameOffset are written from the main thread (set_loops/set_time/reset)
        // and read -- and in the case of loops, decremented -- from the audio thread inside the
        // end callback. startFrameOffset especially has to be atomic: a plain 64-bit store is not
        // tearing-free on 32-bit targets, and a half-written value here is a seek to garbage.
        MA_ATOMIC(4, ma_int32) loops;
        MA_ATOMIC(8, ma_uint64) startFrameOffset;
        MABackendEndCallbackData endCallbackData;
        ma_sound sound;
        MABackendSoundDataSourceType dataSourceType;
        union {
            ma_decoder decoder;
            ma_audio_buffer audioBuffer;
        } dataSource;
        bool locked;
    } MABackendSound;

    // Elements are allocated individually and only the pointer array grows, so element
    // addresses are stable for life. That is load bearing, not a style choice: ma_sound is a
    // live node inside the engine's node graph, ma_decoder/ma_audio_buffer addresses are handed
    // to ma_sound_init_from_data_source, endCallbackData is held by ma_sound_set_end_callback,
    // and ma_device holds a MABackendEngine* as its user data. A flat array that realloc'd on
    // growth would silently relocate all of those out from under miniaudio.
    typedef struct {
        uint32_t capacity;

        void** ptr;
    } Vector;

    Vector engineVector = {0, NULL};
    Vector soundVector = {0, NULL};

    static bool vec_init(Vector* vec, uint32_t capacity, size_t elementSize) {
        vec->capacity = 0;
        vec->ptr = (void**)malloc(sizeof(void*) * capacity);

        if (vec->ptr == NULL) return false;

        for (uint32_t i = 0; i < capacity; i++) {
            vec->ptr[i] = calloc(1, elementSize);

            if (vec->ptr[i] == NULL) return i > 0; // keep whatever did get allocated
            vec->capacity = i + 1;
        }

        return true;
    }

    static bool vec_expand(Vector* vec, size_t elementSize) {
        uint32_t initialCapacity = vec->capacity;
        uint32_t newCapacity = initialCapacity > 0 ? initialCapacity * 2 : 1;

        void** ptr = (void**)realloc(vec->ptr, sizeof(void*) * newCapacity);

        if (ptr == NULL) return false;
        vec->ptr = ptr;

        for (uint32_t i = initialCapacity; i < newCapacity; i++) {
            vec->ptr[i] = calloc(1, elementSize);

            if (vec->ptr[i] == NULL) break;
            vec->capacity = i + 1;
        }

        return vec->capacity > initialCapacity;
    }

    static void vec_free(Vector* vec) {
        for (uint32_t i = 0; i < vec->capacity; i++) {
            free(vec->ptr[i]);
        }

        free(vec->ptr);
        vec->ptr = NULL;
        vec->capacity = 0;
    }

    #define vec_access(vec, type, idx) (*(type*)(vec).ptr[idx])

    // sets `out` to an unused slot, or to ~0U if the vector could not grow
    #define vec_get_unlocked(vec, type, out) { \
            out = ~0U; \
            for (uint32_t i = 0; i < vec.capacity; i++) { \
                if (!vec_access(vec, type, i).locked) { \
                    out = i; \
                    break; \
                } \
            } \
            if (out == ~0U) { \
                uint32_t previousCapacity = vec.capacity; \
                if (vec_expand(&vec, sizeof(type))) out = previousCapacity; \
            } \
        }

    static inline bool check_sound_index(uint32_t soundIndex, const char* functionName) {
        // an index of -1 (the "not initialized" sentinel on the Haxe side) arrives here as
        // 0xFFFFFFFF and is caught by the range check
        if (soundIndex >= soundVector.capacity || !vec_access(soundVector, MABackendSound, soundIndex).locked) {
            fprintf(stderr, "[lime miniaudio backend]: ERROR: invalid sound index %u passed to %s\n", soundIndex, functionName);
            return false;
        }
        return true;
    }

    static inline bool check_engine_index(uint32_t engineIndex, const char* functionName) {
        if (engineIndex >= engineVector.capacity || !vec_access(engineVector, MABackendEngine, engineIndex).locked) {
            fprintf(stderr, "[lime miniaudio backend]: ERROR: invalid engine index %u passed to %s\n", engineIndex, functionName);
            return false;
        }
        return true;
    }

    ma_result ma_File_onOpen(ma_vfs* pVFS, const char* pFilePath, ma_uint32 openMode, ma_vfs_file* pFile) {
        *pFile = NULL;

        if (openMode & MA_OPEN_MODE_READ) {
            if (openMode & MA_OPEN_MODE_WRITE)
                *pFile = File(pFilePath, "rb+").handle;
            else *pFile = File(pFilePath, "rb").handle;
        } else if (openMode & MA_OPEN_MODE_WRITE)
            *pFile = File(pFilePath, "wb").handle;

        if (!(*pFile)) return MA_IO_ERROR;

        return MA_SUCCESS;
    }

    ma_result ma_File_onClose(ma_vfs* pVFS, ma_vfs_file file) {
        File f(file);
        f.Close();

        return MA_SUCCESS;
    }

    ma_result ma_File_onRead(ma_vfs* pVFS, ma_vfs_file file, void* pDst, size_t sizeInBytes, size_t* pBytesRead) {
        File f(file);
        *pBytesRead = f.Read(pDst, sizeInBytes);

        if (*pBytesRead < sizeInBytes) return MA_AT_END;

        return MA_SUCCESS;
    }

    ma_result ma_File_onWrite(ma_vfs* pVFS, ma_vfs_file file, const void* pSrc, size_t sizeInBytes, size_t* pBytesWritten) {
        File f(file);
        *pBytesWritten = f.Write(pSrc, sizeInBytes);

        if (*pBytesWritten < sizeInBytes) return MA_IO_ERROR;

        return MA_SUCCESS;
    }

    ma_result ma_File_onSeek(ma_vfs* pVFS, ma_vfs_file file, ma_int64 offset, ma_seek_origin origin) {
        File f(file);

        int corigin;

        switch (origin) {
            case ma_seek_origin_start:
                corigin = SEEK_SET;
                break;
            case ma_seek_origin_end:
                corigin = SEEK_END;
                break;
            case ma_seek_origin_current:
                corigin = SEEK_CUR;
                break;
            default:
                return MA_INVALID_ARGS;
        }

        if (f.Seek(offset, corigin) == -1) return MA_IO_ERROR;

        return MA_SUCCESS;
    }

    ma_result ma_File_onTell(ma_vfs* pVFS, ma_vfs_file file, ma_int64* pCursor) {
        File f(file);

        *pCursor = f.Tell();

        if (*pCursor == -1) return MA_IO_ERROR;

        return MA_SUCCESS;
    }

    ma_result ma_File_onInfo(ma_vfs* pVFS, ma_vfs_file file, ma_file_info* pInfo) {
        File f(file);

        int64_t current = f.Tell();

        if (f.Seek(0, SEEK_END) == -1) return MA_IO_ERROR;

        int64_t size = f.Tell();

        if (size < 0) return MA_IO_ERROR;

        pInfo->sizeInBytes = (ma_uint64)size;

        if (f.Seek(current < 0 ? 0 : current, SEEK_SET) == -1) return MA_IO_ERROR;

        return MA_SUCCESS;
    }

    ma_vfs_callbacks vfscb;

    ma_decoding_backend_vtable* pCustomDecodingBackends[] = {
        ma_decoding_backend_libvorbis,
        ma_decoding_backend_libopus
    };

    void miniaudio_backend_sound_end_callback(void* pUserData, ma_sound* pSound) {
        MABackendEndCallbackData* endCallbackData = (MABackendEndCallbackData*)pUserData;

        if (endCallbackData->soundIndex >= soundVector.capacity) return;

        MABackendSound* pBackendSound = &vec_access(soundVector, MABackendSound, endCallbackData->soundIndex);

        // this runs on the audio thread, so no logging here; bail if the slot has been released
        // and possibly handed to a different sound since the callback was registered
        if (!pBackendSound->locked) return;

        ma_int32 loops = ma_atomic_load_i32(&pBackendSound->loops);

        // nothing to do when the sound is finished: miniaudio already called ma_sound_stop() on
        // it in the ma_sound_at_end() branch that fires this callback
        if (loops < 1) return;

        ma_atomic_exchange_i32(&pBackendSound->loops, loops - 1);

        ma_uint64 startFrameOffset = ma_atomic_load_64(&pBackendSound->startFrameOffset);

        // ma_sound_start() seeks an at-end sound back to frame 0 itself, so only queue a seek
        // when the loop point is somewhere else -- otherwise every loop of a streamed compressed
        // source pays for two full seeks instead of one. A seek queued here is not lost: it lands
        // in pSound->seekTarget and the mixer applies it on the next processing step.
        if (startFrameOffset != 0) {
            ma_sound_seek_to_pcm_frame(pSound, startFrameOffset);
        }

        ma_sound_start(pSound);
    }

    void miniaudio_backend_init() {
        if (engineVector.ptr != NULL || soundVector.ptr != NULL) {
            // creating a second MINIAUDIO AudioContext would otherwise leak the live vectors
            // and orphan every sound and engine still in them
            fprintf(stderr, "[lime miniaudio backend]: WARNING: already initialized, ignoring\n");
            return;
        }

        if (!vec_init(&engineVector, ENGINE_VECTOR_STARTING_CAPACITY, sizeof(MABackendEngine))
            || !vec_init(&soundVector, SOUND_VECTOR_STARTING_CAPACITY, sizeof(MABackendSound))) {
            fprintf(stderr, "[lime miniaudio backend]: ERROR: failed to allocate the engine/sound vectors\n");
            vec_free(&engineVector);
            vec_free(&soundVector);
            return;
        }

        vfscb.onOpen = ma_File_onOpen;
        vfscb.onClose = ma_File_onClose;
        vfscb.onRead = ma_File_onRead;
        vfscb.onWrite = ma_File_onWrite;
        vfscb.onSeek = ma_File_onSeek;
        vfscb.onTell = ma_File_onTell;
        vfscb.onInfo = ma_File_onInfo;
    }

    void miniaudio_backend_uninit() {
        for (uint32_t i = 0; i < soundVector.capacity; i++) {
            if (vec_access(soundVector, MABackendSound, i).locked) {
                miniaudio_backend_sound_uninit(i);
            }
        }
        for (uint32_t i = 0; i < engineVector.capacity; i++) {
            if (vec_access(engineVector, MABackendEngine, i).locked) {
                miniaudio_backend_engine_uninit(i);
            }
        }
        vec_free(&soundVector);
        vec_free(&engineVector);
    }

    // Soft knee applied in place. Below the knee the sample is untouched; above it the excess is
    // compressed through tanh, which is C1-continuous at the knee and asymptotes to full scale, so
    // the output can never exceed 1.0 no matter how hot the mix gets.
    static void miniaudio_backend_softclip_process(float* pFrames, ma_uint32 frameCount, uint32_t channels) {
        const ma_uint32 sampleCount = frameCount * channels;

        for (ma_uint32 i = 0; i < sampleCount; i++) {
            float x = pFrames[i];
            float a = fabsf(x);

            if (a > MA_SOFTCLIP_KNEE) {
                float over = (a - MA_SOFTCLIP_KNEE) / (1.0f - MA_SOFTCLIP_KNEE);
                float y = MA_SOFTCLIP_KNEE + (1.0f - MA_SOFTCLIP_KNEE) * tanhf(over);

                pFrames[i] = x < 0.0f ? -y : y;
            }
        }
    }

    static void miniaudio_backend_device_data_callback(ma_device* pDevice, void* pFramesOut, const void* pFramesIn, ma_uint32 frameCount) {
        MABackendEngine* pBackendEngine = (MABackendEngine*)pDevice->pUserData;

        if (pBackendEngine != NULL) {
            ma_engine_read_pcm_frames(&pBackendEngine->engine, pFramesOut, frameCount, NULL);

            // the device format is always f32 here
            miniaudio_backend_softclip_process((float*)pFramesOut, frameCount, pDevice->playback.channels);
        }
    }

    static void miniaudio_backend_get_backend_priority_list(ma_backend* pBackends, ma_uint32* pBackendCount) {
        // Matches the SEAL (Shadow Engine AL) "drivers" default config, minus backends this miniaudio version does not ship
        #if defined(_WIN32)
            const ma_backend backends[] = { ma_backend_wasapi, ma_backend_dsound, ma_backend_winmm, ma_backend_null }; // SEAL: "wasapi,dsound,winmm,null"
        #elif defined(__linux__) && !defined(__ANDROID__)
            const ma_backend backends[] = { ma_backend_pulseaudio, ma_backend_alsa, ma_backend_jack, ma_backend_null }; // SEAL: "pipewire,pulse,alsa,jack,oss,null" (no pipewire/oss in miniaudio 0.11)
        #elif defined(__APPLE__)
            const ma_backend backends[] = { ma_backend_coreaudio, ma_backend_null }; // SEAL: "sdl3,null"
        #elif defined(__ANDROID__)
            const ma_backend backends[] = { ma_backend_aaudio, ma_backend_opensl, ma_backend_null }; // SEAL: "aaudio,null" (SDK >= 30) / "opensl,null" (SDK < 30)
        #else
            const ma_backend backends[] = { ma_backend_null };
        #endif

        const ma_uint32 count = sizeof(backends) / sizeof(backends[0]);
        for (ma_uint32 i = 0; i < count; i++) {
            pBackends[i] = backends[i];
        }
        *pBackendCount = count;
    }

    int32_t miniaudio_backend_engine_init(uint32_t sampleRate, uint32_t channels, uint32_t periodSizeInFrames, uint32_t gainSmoothTimeInFrames) {
        uint32_t unlockedIndex;
        vec_get_unlocked(engineVector, MABackendEngine, unlockedIndex);

        if (unlockedIndex == ~0U) {
            fprintf(stderr, "[lime miniaudio backend]: ERROR: failed to reserve an engine slot\n");
            return -1;
        }

        MABackendEngine* pEngine = &vec_access(engineVector, MABackendEngine, unlockedIndex);

        if (channels == 0) channels = 2;               // SEAL: "channels" = "stereo"
        if (periodSizeInFrames == 0) periodSizeInFrames = 480; // SEAL: "period_size" = "480"
        // sampleRate 0 means "use the device's native rate", which is what SEAL does by not
        // setting a frequency at all. Forcing a rate here would only push an extra resample
        // into the OS mixer, outside the bsinc24 path.

        ma_context_config contextConfig = ma_context_config_init();
        contextConfig.threadPriority = ma_thread_priority_highest; // SEAL: "rt-prio" = "15"

        ma_backend backends[8];
        ma_uint32 backendCount = 0;
        miniaudio_backend_get_backend_priority_list(backends, &backendCount);

        if (ma_context_init(backends, backendCount, &contextConfig, &pEngine->context) != MA_SUCCESS) {
            fprintf(stderr, "[lime miniaudio backend]: ERROR: failed to initialize an ma_context (no compatible audio backend found)\n");
            return -1;
        }

        ma_device_config deviceConfig = ma_device_config_init(ma_device_type_playback);
        deviceConfig.playback.format = ma_format_f32;  // SEAL: "sample-type" = "float32"
        deviceConfig.playback.channels = channels;     // SEAL: "channels" = "stereo"
        deviceConfig.sampleRate = sampleRate;
        deviceConfig.periodSizeInFrames = periodSizeInFrames; // SEAL: "period_size" = "480"
        deviceConfig.periods = 2;                      // SEAL: "periods" = "2"
        deviceConfig.dataCallback = miniaudio_backend_device_data_callback;
        deviceConfig.pUserData = pEngine;
        deviceConfig.noPreSilencedOutputBuffer = MA_TRUE;
        deviceConfig.noClip = MA_FALSE; // final safety net behind the soft knee

        if (ma_device_init(&pEngine->context, &deviceConfig, &pEngine->device) != MA_SUCCESS) {
            fprintf(stderr, "[lime miniaudio backend]: ERROR: failed to initialize an ma_device\n");
            ma_context_uninit(&pEngine->context);
            return -1;
        }

        // the device may not have honoured the requested rate/channels, and when sampleRate was
        // 0 it picked the native rate, so everything downstream follows the device from here on
        sampleRate = pEngine->device.sampleRate;
        channels = pEngine->device.playback.channels;

        ma_resource_manager_config rmConfig = ma_resource_manager_config_init();
        rmConfig.ppCustomDecodingBackendVTables = pCustomDecodingBackends;
        rmConfig.customDecodingBackendCount = 2;
        rmConfig.pVFS = &vfscb;

        // SEAL: "resampler" = "bsinc24" (libsoxr). miniaudio ships only a linear resampler, so
        // attach a high-quality polyphase windowed-sinc backend for the 44.1k -> device rate path.
        ma_resampler_config resamplingConfig;
        if (miniaudio_sinc_resampler_init_config(&resamplingConfig) != MA_SUCCESS) {
            fprintf(stderr, "[lime miniaudio backend]: ERROR: failed to build the sinc resampler config\n");
            ma_device_uninit(&pEngine->device);
            ma_context_uninit(&pEngine->context);
            return -1;
        }
        rmConfig.resampling = resamplingConfig;

        if (ma_resource_manager_init(&rmConfig, &pEngine->resourceManager) != MA_SUCCESS) {
            fprintf(stderr, "[lime miniaudio backend]: ERROR: failed to initialize an ma_resource_manager\n");
            ma_device_uninit(&pEngine->device);
            ma_context_uninit(&pEngine->context);
            return -1;
        }

        ma_engine_config engineConfig = ma_engine_config_init();
        engineConfig.sampleRate = sampleRate;
        engineConfig.channels = channels;

        // Without this, ma_sound_set_volume() writes a hard gain step into the waveform, which is
        // an audible click every time a volume changes. Games retrigger volume constantly -- FNF
        // mutes and unmutes the vocal stem on every note hit and miss -- so the default of 0 turns
        // into continuous crackling on whichever sound is being ducked.
        //
        // Note this is NOT gainSmoothTimeInFrames below: that one only feeds the spatializer's
        // gainer, and spatialization is disabled on every sound we create, so it never applies.
        engineConfig.defaultVolumeSmoothTimeInPCMFrames = sampleRate * MA_VOLUME_SMOOTH_MS / 1000;
        engineConfig.periodSizeInFrames = 0; // let the engine derive the processing size from the device's period
        engineConfig.gainSmoothTimeInFrames = gainSmoothTimeInFrames;
        engineConfig.pContext = &pEngine->context;
        engineConfig.pDevice = &pEngine->device;
        engineConfig.pResourceManager = &pEngine->resourceManager;
        engineConfig.resourceManagerResampling = resamplingConfig; // used if the engine ever owns the RM
        engineConfig.pitchResampling = resamplingConfig;           // node/pitch path, SEAL: "resampler" = "bsinc24"

        if (ma_engine_init(&engineConfig, &pEngine->engine) != MA_SUCCESS) {
            ma_resource_manager_uninit(&pEngine->resourceManager);
            ma_device_uninit(&pEngine->device);
            ma_context_uninit(&pEngine->context);
            fprintf(stderr, "[lime miniaudio backend]: ERROR: failed to initialize an ma_engine\n");
            return -1;
        }

        pEngine->locked = true;

        return unlockedIndex;
    }

    void miniaudio_backend_engine_uninit(uint32_t engineIndex) {
        if (!check_engine_index(engineIndex, "engine_uninit")) return;

        MABackendEngine* pEngine = &vec_access(engineVector, MABackendEngine, engineIndex);

        // Every live sound is a node inside this engine's graph and ma_sound_uninit() has to
        // detach it while that graph still exists. AudioManager.shutdown() calls this before
        // miniaudio_backend_uninit(), so without this loop the sounds left in soundVector would
        // afterwards be torn down against an engine that has already been destroyed.
        for (uint32_t i = 0; i < soundVector.capacity; i++) {
            MABackendSound* pSound = &vec_access(soundVector, MABackendSound, i);

            if (pSound->locked && ma_sound_get_engine(&pSound->sound) == &pEngine->engine) {
                miniaudio_backend_sound_uninit(i);
            }
        }

        ma_device_uninit(&pEngine->device); // stops the audio thread first
        ma_engine_uninit(&pEngine->engine);
        ma_resource_manager_uninit(&pEngine->resourceManager);
        ma_context_uninit(&pEngine->context);
        pEngine->locked = false;
    }

    void miniaudio_backend_engine_start(uint32_t engineIndex) {
        if (!check_engine_index(engineIndex, "engine_start")) return;

        if (ma_device_start(&vec_access(engineVector, MABackendEngine, engineIndex).device) != MA_SUCCESS) {
            fprintf(stderr, "[lime miniaudio backend]: WARNING: failed start an ma_device with index %d\n", engineIndex);
        }
    }

    void miniaudio_backend_engine_stop(uint32_t engineIndex) {
        if (!check_engine_index(engineIndex, "engine_stop")) return;

        if (ma_device_stop(&vec_access(engineVector, MABackendEngine, engineIndex).device) != MA_SUCCESS) {
            fprintf(stderr, "[lime miniaudio backend]: WARNING: failed stop an ma_device with index %d\n", engineIndex);
        }
    }

    int32_t miniaudio_backend_sound_init_from_file(uint32_t engineIndex, float offset, const char* path) {
        if (!check_engine_index(engineIndex, "sound_init_from_file")) return -1;

        uint32_t unlockedIndex;
        vec_get_unlocked(soundVector, MABackendSound, unlockedIndex);

        if (unlockedIndex == ~0U) {
            fprintf(stderr, "[lime miniaudio backend]: ERROR: failed to reserve a sound slot\n");
            return -1;
        }

        // NO_SPATIALIZATION by default: OpenAL never spatializes stereo buffers, so leaving
        // miniaudio's spatializer on would narrow every stereo sound. sound_set_position()
        // turns it back on for the sounds that actually ask to be positioned.
        if (ma_sound_init_from_file(&vec_access(engineVector, MABackendEngine, engineIndex).engine, path, MA_SOUND_FLAG_STREAM | MA_SOUND_FLAG_NO_SPATIALIZATION, NULL, NULL, &vec_access(soundVector, MABackendSound, unlockedIndex).sound) != MA_SUCCESS) {
            fprintf(stderr, "[lime miniaudio backend]: ERROR: failed to initialize an ma_sound at path %s\n", path);
            return -1;
        }

        uint32_t sampleRate;
        if (ma_sound_get_data_format(&vec_access(soundVector, MABackendSound, unlockedIndex).sound, NULL, NULL, &sampleRate, NULL, 0) != MA_SUCCESS) {
            fprintf(stderr, "[lime miniaudio backend]: WARNING: failed to get data format of an ma_sound with index %d\n", unlockedIndex);
            sampleRate = 0;
        }

        uint64_t frameOffset = sampleRate == 0 ? 0 : (uint64_t)(offset * sampleRate / 1000.0);

        if (ma_sound_seek_to_pcm_frame(&vec_access(soundVector, MABackendSound, unlockedIndex).sound, frameOffset) != MA_SUCCESS) {
            fprintf(stderr, "[lime miniaudio backend]: WARNING: failed to seek an ma_sound with index %d to pcm frame offset %" PRId64 "\n", unlockedIndex, frameOffset);
        }

        vec_access(soundVector, MABackendSound, unlockedIndex).startFrameOffset = frameOffset;
        vec_access(soundVector, MABackendSound, unlockedIndex).dataSourceType = MA_BACKEND_SOUND_DATA_SOURCE_TYPE_INTERNAL;
        vec_access(soundVector, MABackendSound, unlockedIndex).stopTime = 0;
        vec_access(soundVector, MABackendSound, unlockedIndex).loops = 0;
        vec_access(soundVector, MABackendSound, unlockedIndex).endCallbackData = {unlockedIndex};
        vec_access(soundVector, MABackendSound, unlockedIndex).locked = true;

        if (ma_sound_set_end_callback(&vec_access(soundVector, MABackendSound, unlockedIndex).sound, miniaudio_backend_sound_end_callback, &vec_access(soundVector, MABackendSound, unlockedIndex).endCallbackData) != MA_SUCCESS) {
            fprintf(stderr, "[lime miniaudio backend]: WARNING: failed to set the end callback for an ma_sound with index %d\n", unlockedIndex);
        }

        return unlockedIndex;
    }

    int32_t miniaudio_backend_sound_init_from_bytes(uint32_t engineIndex, float offset, bool stream, value bytes) {
        if (!check_engine_index(engineIndex, "sound_init_from_bytes")) return -1;

        uint32_t unlockedIndex;
        vec_get_unlocked(soundVector, MABackendSound, unlockedIndex);

        if (unlockedIndex == ~0U) {
            fprintf(stderr, "[lime miniaudio backend]: ERROR: failed to reserve a sound slot\n");
            return -1;
        }

        // buffer_size() is the length that pairs with val_to_buffer()/buffer_data(). val_array_size()
        // happens to agree on the hxcpp side, where BytesData is an Array<UInt8>, but it reads the
        // wrong field for a neko buffer.
        cffiByteBuffer byteBuffer = val_to_buffer(bytes);

        if (byteBuffer == NULL) {
            fprintf(stderr, "[lime miniaudio backend]: ERROR: sound_init_from_bytes expected a byte buffer\n");
            return -1;
        }

        const void* byteData = buffer_data(byteBuffer);
        int byteCount = buffer_size(byteBuffer);

        if (byteData == NULL || byteCount <= 0) {
            fprintf(stderr, "[lime miniaudio backend]: ERROR: sound_init_from_bytes was given an empty byte buffer\n");
            return -1;
        }

        ma_data_source* pDataSource = NULL;

        if (stream) {
            ma_decoder_config decoderConfig = ma_decoder_config_init(ma_format_unknown, 0, 0);

            decoderConfig.ppCustomBackendVTables = pCustomDecodingBackends;
            decoderConfig.customBackendCount = 2;

            if (ma_decoder_init_memory(byteData, (size_t)byteCount, &decoderConfig, &vec_access(soundVector, MABackendSound, unlockedIndex).dataSource.decoder) != MA_SUCCESS) {
                fprintf(stderr, "[lime miniaudio backend]: ERROR: failed to create an ma_decoder for bytes\n");
                return -1;
            }

            pDataSource = &vec_access(soundVector, MABackendSound, unlockedIndex).dataSource.decoder;
            vec_access(soundVector, MABackendSound, unlockedIndex).dataSourceType = MA_BACKEND_SOUND_DATA_SOURCE_TYPE_DECODER;
        } else {
            ma_decoder_config decoderConfig = ma_decoder_config_init(ma_format_unknown, 0, 0);

            decoderConfig.ppCustomBackendVTables = pCustomDecodingBackends;
            decoderConfig.customBackendCount = 2;

            uint64_t pcmFrameCount;
            void* pPcmFrames;

            // we cant avoid allocating memory here, creating a lot of non-streamed sounds is not intended
            if (ma_decode_memory(byteData, (size_t)byteCount, &decoderConfig, &pcmFrameCount, &pPcmFrames) != MA_SUCCESS) {
                fprintf(stderr, "[lime miniaudio backend]: ERROR: failed to decode bytes when creating a non-streamed ma_sound\n");
                return -1;
            }

            ma_audio_buffer_config audioBufferConfig = ma_audio_buffer_config_init(decoderConfig.format, decoderConfig.channels, pcmFrameCount, pPcmFrames, NULL);
            audioBufferConfig.sampleRate = decoderConfig.sampleRate;

            if (ma_audio_buffer_init(&audioBufferConfig, &vec_access(soundVector, MABackendSound, unlockedIndex).dataSource.audioBuffer) != MA_SUCCESS) {
                ma_free(pPcmFrames, NULL);
                fprintf(stderr, "[lime miniaudio backend]: ERROR: failed to init an ma_audio_buffer for decoded bytes\n");
                return -1;
            }

            vec_access(soundVector, MABackendSound, unlockedIndex).dataSource.audioBuffer.ownsData = MA_TRUE; // hijack this so that the audio buffer will free the memory allocated in ma_decode_memory

            pDataSource = &vec_access(soundVector, MABackendSound, unlockedIndex).dataSource.audioBuffer;
            vec_access(soundVector, MABackendSound, unlockedIndex).dataSourceType = MA_BACKEND_SOUND_DATA_SOURCE_TYPE_AUDIO_BUFFER;
        }

        // note that MA_SOUND_FLAG_STREAM is useless here, as it is a resource manager flag, ma_decoder does streaming automatically
        if (ma_sound_init_from_data_source(&vec_access(engineVector, MABackendEngine, engineIndex).engine, pDataSource, MA_SOUND_FLAG_NO_SPATIALIZATION, NULL, &vec_access(soundVector, MABackendSound, unlockedIndex).sound) != MA_SUCCESS) {
            switch (vec_access(soundVector, MABackendSound, unlockedIndex).dataSourceType) {
                case MA_BACKEND_SOUND_DATA_SOURCE_TYPE_DECODER:
                    ma_decoder_uninit(&vec_access(soundVector, MABackendSound, unlockedIndex).dataSource.decoder);
                    break;
                case MA_BACKEND_SOUND_DATA_SOURCE_TYPE_AUDIO_BUFFER:
                    ma_audio_buffer_uninit(&vec_access(soundVector, MABackendSound, unlockedIndex).dataSource.audioBuffer);
                    break;
                case MA_BACKEND_SOUND_DATA_SOURCE_TYPE_INTERNAL:
                    break;
            }
            fprintf(stderr, "[lime miniaudio backend]: ERROR: failed to initialize an ma_sound from bytes\n");
            return -1;
        }

        uint32_t sampleRate;
        if (ma_sound_get_data_format(&vec_access(soundVector, MABackendSound, unlockedIndex).sound, NULL, NULL, &sampleRate, NULL, 0) != MA_SUCCESS) {
            fprintf(stderr, "[lime miniaudio backend]: WARNING: failed to get data format of an ma_sound with index %d\n", unlockedIndex);
            sampleRate = 0;
        }

        uint64_t frameOffset = sampleRate == 0 ? 0 : (uint64_t)(offset * sampleRate / 1000.0);

        if (ma_sound_seek_to_pcm_frame(&vec_access(soundVector, MABackendSound, unlockedIndex).sound, frameOffset) != MA_SUCCESS) {
            fprintf(stderr, "[lime miniaudio backend]: WARNING: failed to seek an ma_sound with index %d to pcm frame offset %" PRId64 "\n", unlockedIndex, frameOffset);
        }

        vec_access(soundVector, MABackendSound, unlockedIndex).startFrameOffset = frameOffset;
        vec_access(soundVector, MABackendSound, unlockedIndex).stopTime = 0;
        vec_access(soundVector, MABackendSound, unlockedIndex).loops = 0;
        vec_access(soundVector, MABackendSound, unlockedIndex).endCallbackData = {unlockedIndex};
        vec_access(soundVector, MABackendSound, unlockedIndex).locked = true;

        if (ma_sound_set_end_callback(&vec_access(soundVector, MABackendSound, unlockedIndex).sound, miniaudio_backend_sound_end_callback, &vec_access(soundVector, MABackendSound, unlockedIndex).endCallbackData) != MA_SUCCESS) {
            fprintf(stderr, "[lime miniaudio backend]: WARNING: failed to set the end callback for an ma_sound with index %d\n", unlockedIndex);
        }

        return unlockedIndex;
    }

    int32_t miniaudio_backend_sound_init_from_audio_buffer(uint32_t engineIndex, float offset, uint32_t sampleRate, uint32_t channels, uint32_t format, value pcmFrames, uint32_t pcmFrameCount) {
        if (!check_engine_index(engineIndex, "sound_init_from_audio_buffer")) return -1;

        uint32_t unlockedIndex;
        vec_get_unlocked(soundVector, MABackendSound, unlockedIndex);

        if (unlockedIndex == ~0U) {
            fprintf(stderr, "[lime miniaudio backend]: ERROR: failed to reserve a sound slot\n");
            return -1;
        }

        cffiByteBuffer frameBuffer = val_to_buffer(pcmFrames);

        if (frameBuffer == NULL) {
            fprintf(stderr, "[lime miniaudio backend]: ERROR: sound_init_from_audio_buffer expected a byte buffer\n");
            return -1;
        }

        // the ma_audio_buffer aliases this memory instead of copying it, so an overlong frame
        // count is not a one-off misread -- it reads past the end for the entire life of the sound
        ma_uint32 bytesPerFrame = ma_get_bytes_per_frame((ma_format)format, channels);
        int availableBytes = buffer_size(frameBuffer);

        if (bytesPerFrame == 0 || (int64_t)pcmFrameCount * bytesPerFrame > (int64_t)availableBytes) {
            fprintf(stderr, "[lime miniaudio backend]: ERROR: %u pcm frames of format %u x %u channels need %" PRId64 " bytes, but only %d were provided\n",
                pcmFrameCount, format, channels, (int64_t)pcmFrameCount * bytesPerFrame, availableBytes);
            return -1;
        }

        ma_audio_buffer_config audioBufferConfig = ma_audio_buffer_config_init((ma_format)format, channels, pcmFrameCount, buffer_data(frameBuffer), NULL);
        audioBufferConfig.sampleRate = sampleRate;

        if (ma_audio_buffer_init(&audioBufferConfig, &vec_access(soundVector, MABackendSound, unlockedIndex).dataSource.audioBuffer) != MA_SUCCESS) {
            fprintf(stderr, "[lime miniaudio backend]: ERROR: failed to init an ma_audio_buffer for pcm frames\n");
            return -1;
        }

        vec_access(soundVector, MABackendSound, unlockedIndex).dataSourceType = MA_BACKEND_SOUND_DATA_SOURCE_TYPE_AUDIO_BUFFER;

        if (ma_sound_init_from_data_source(&vec_access(engineVector, MABackendEngine, engineIndex).engine, &vec_access(soundVector, MABackendSound, unlockedIndex).dataSource.audioBuffer, MA_SOUND_FLAG_NO_SPATIALIZATION, NULL, &vec_access(soundVector, MABackendSound, unlockedIndex).sound) != MA_SUCCESS) {
            ma_audio_buffer_uninit(&vec_access(soundVector, MABackendSound, unlockedIndex).dataSource.audioBuffer);
            fprintf(stderr, "[lime miniaudio backend]: ERROR: failed to initialize an ma_sound from pcm frames\n");
            return -1;
        }

        uint64_t frameOffset = sampleRate == 0 ? 0 : (uint64_t)(offset * sampleRate / 1000.0);

        if (ma_sound_seek_to_pcm_frame(&vec_access(soundVector, MABackendSound, unlockedIndex).sound, frameOffset) != MA_SUCCESS) {
            fprintf(stderr, "[lime miniaudio backend]: WARNING: failed to seek an ma_sound with index %d to pcm frame offset %" PRId64 "\n", unlockedIndex, frameOffset);
        }

        vec_access(soundVector, MABackendSound, unlockedIndex).startFrameOffset = frameOffset;
        vec_access(soundVector, MABackendSound, unlockedIndex).stopTime = 0;
        vec_access(soundVector, MABackendSound, unlockedIndex).loops = 0;
        vec_access(soundVector, MABackendSound, unlockedIndex).endCallbackData = {unlockedIndex};
        vec_access(soundVector, MABackendSound, unlockedIndex).locked = true;

        if (ma_sound_set_end_callback(&vec_access(soundVector, MABackendSound, unlockedIndex).sound, miniaudio_backend_sound_end_callback, &vec_access(soundVector, MABackendSound, unlockedIndex).endCallbackData) != MA_SUCCESS) {
            fprintf(stderr, "[lime miniaudio backend]: WARNING: failed to set the end callback for an ma_sound with index %d\n", unlockedIndex);
        }

        return unlockedIndex;
    }

    void miniaudio_backend_sound_uninit(uint32_t soundIndex) {
        if (!check_sound_index(soundIndex, "uninit")) return;

        ma_sound_set_end_callback(&vec_access(soundVector, MABackendSound, soundIndex).sound, NULL, NULL);
        ma_sound_uninit(&vec_access(soundVector, MABackendSound, soundIndex).sound);

        switch (vec_access(soundVector, MABackendSound, soundIndex).dataSourceType) {
            case MA_BACKEND_SOUND_DATA_SOURCE_TYPE_DECODER:
                ma_decoder_uninit(&vec_access(soundVector, MABackendSound, soundIndex).dataSource.decoder);
                break;
            case MA_BACKEND_SOUND_DATA_SOURCE_TYPE_AUDIO_BUFFER:
                ma_audio_buffer_uninit(&vec_access(soundVector, MABackendSound, soundIndex).dataSource.audioBuffer);
                break;
            case MA_BACKEND_SOUND_DATA_SOURCE_TYPE_INTERNAL: break;
        }

        vec_access(soundVector, MABackendSound, soundIndex).locked = false;
    }

    // "no scheduled stop" is (ma_uint64)-1, the value ma_node_init puts in stateTimes[stopped].
    // 0 is NOT a clear: it is an absolute global time in the past, so the node reads as stopped
    // for every future time range and the sound is silently gated off for good.
    static void miniaudio_backend_sound_clear_stop_time(MABackendSound* pSound) {
        ma_sound_set_stop_time_in_pcm_frames(&pSound->sound, ~(ma_uint64)0);
    }

    // Stop times are absolute engine times, so the configured length has to be anchored to the
    // moment playback actually begins. Anchoring it at set_length() time instead would start the
    // clock while the sound is still paused, and a length set before the first play() would have
    // already elapsed by the time anything is audible.
    static void miniaudio_backend_sound_apply_stop_time(MABackendSound* pSound) {
        if (pSound->stopTime <= 0) {
            miniaudio_backend_sound_clear_stop_time(pSound);
            return;
        }

        uint64_t currentTime = ma_engine_get_time_in_milliseconds(ma_sound_get_engine(&pSound->sound));
        ma_sound_set_stop_time_in_milliseconds(&pSound->sound, currentTime + (uint64_t)pSound->stopTime);
    }

    void miniaudio_backend_sound_start(uint32_t soundIndex) {
        if (!check_sound_index(soundIndex, "start")) return;

        MABackendSound* pSound = &vec_access(soundVector, MABackendSound, soundIndex);

        miniaudio_backend_sound_apply_stop_time(pSound);

        if (ma_sound_start(&pSound->sound) != MA_SUCCESS) {
            fprintf(stderr, "[lime miniaudio backend]: WARNING: failed to start a sound with index %d\n", soundIndex);
        }
    }

    void miniaudio_backend_sound_stop(uint32_t soundIndex) {
        if (!check_sound_index(soundIndex, "stop")) return;

        MABackendSound* pSound = &vec_access(soundVector, MABackendSound, soundIndex);

        if (ma_sound_stop(&pSound->sound) != MA_SUCCESS) {
            fprintf(stderr, "[lime miniaudio backend]: WARNING: failed to stop a sound with index %d\n", soundIndex);
        }

        // drop the scheduled stop so a stale one cannot fire after the sound is restarted
        miniaudio_backend_sound_clear_stop_time(pSound);
    }

    void miniaudio_backend_sound_reset(uint32_t soundIndex, float offset) {
        if (!check_sound_index(soundIndex, "reset")) return;

        miniaudio_backend_sound_stop(soundIndex);

        uint32_t sampleRate;
        if (ma_sound_get_data_format(&vec_access(soundVector, MABackendSound, soundIndex).sound, NULL, NULL, &sampleRate, NULL, 0) != MA_SUCCESS) {
            fprintf(stderr, "[lime miniaudio backend]: WARNING: failed to get data format of an ma_sound with index %d\n", soundIndex);
            return;
        }

        uint64_t frameOffset = sampleRate == 0 ? 0 : (uint64_t)(offset * sampleRate / 1000.0);

        if (ma_sound_seek_to_pcm_frame(&vec_access(soundVector, MABackendSound, soundIndex).sound, frameOffset) != MA_SUCCESS) {
            fprintf(stderr, "[lime miniaudio backend]: WARNING: failed to seek an ma_sound with index %d to pcm frame offset %" PRId64 "\n", soundIndex, frameOffset);
        }

        ma_atomic_exchange_64(&vec_access(soundVector, MABackendSound, soundIndex).startFrameOffset, frameOffset);
    }

    float miniaudio_backend_sound_get_time(uint32_t soundIndex, float offset) {
        if (!check_sound_index(soundIndex, "get_time")) return 0;

        uint32_t sampleRate;
        if (ma_sound_get_data_format(&vec_access(soundVector, MABackendSound, soundIndex).sound, NULL, NULL, &sampleRate, NULL, 0) != MA_SUCCESS || sampleRate == 0) {
            fprintf(stderr, "[lime miniaudio backend]: WARNING: failed to get data format of an ma_sound with index %d\n", soundIndex);
            return 0;
        }

        uint64_t cursorPcmFrames = 0;

        if (ma_sound_get_cursor_in_pcm_frames(&vec_access(soundVector, MABackendSound, soundIndex).sound, &cursorPcmFrames) != MA_SUCCESS) {
            fprintf(stderr, "[lime miniaudio backend]: WARNING: failed to get cursor of an ma_sound with index %d\n", soundIndex);
        }

        float time = (float)(cursorPcmFrames * 1000) / (float)sampleRate - offset;

        return time < 0 ? 0 : time;
    }

    void miniaudio_backend_sound_set_time(uint32_t soundIndex, float offset, float t) {
        if (!check_sound_index(soundIndex, "set_time")) return;

        uint32_t sampleRate;
        if (ma_sound_get_data_format(&vec_access(soundVector, MABackendSound, soundIndex).sound, NULL, NULL, &sampleRate, NULL, 0) != MA_SUCCESS || sampleRate == 0) {
            fprintf(stderr, "[lime miniaudio backend]: WARNING: failed to get data format of an ma_sound with index %d\n", soundIndex);
            return;
        }

        int64_t targetFrame = (int64_t)((t + offset) * sampleRate / 1000.0);

        if (targetFrame < 0) targetFrame = 0;

        if (ma_sound_seek_to_pcm_frame(&vec_access(soundVector, MABackendSound, soundIndex).sound, (uint64_t)targetFrame) != MA_SUCCESS) {
            fprintf(stderr, "[lime miniaudio backend]: WARNING: failed to seek an ma_sound with index %d to pcm frame offset %" PRId64 "\n", soundIndex, targetFrame);
        }

        ma_atomic_exchange_64(&vec_access(soundVector, MABackendSound, soundIndex).startFrameOffset, (ma_uint64)targetFrame);
    }

    float miniaudio_backend_sound_get_volume(uint32_t soundIndex) {
        if (!check_sound_index(soundIndex, "get_volume")) return 0;

        return ma_sound_get_volume(&vec_access(soundVector, MABackendSound, soundIndex).sound);
    }

    void miniaudio_backend_sound_set_volume(uint32_t soundIndex, float v) {
        if (!check_sound_index(soundIndex, "set_volume")) return;

        ma_sound_set_volume(&vec_access(soundVector, MABackendSound, soundIndex).sound, v);
    }

    float miniaudio_backend_sound_get_pitch(uint32_t soundIndex) {
        if (!check_sound_index(soundIndex, "get_pitch")) return 1;

        return ma_sound_get_pitch(&vec_access(soundVector, MABackendSound, soundIndex).sound);
    }

    void miniaudio_backend_sound_set_pitch(uint32_t soundIndex, float p) {
        if (!check_sound_index(soundIndex, "set_pitch")) return;

        ma_sound_set_pitch(&vec_access(soundVector, MABackendSound, soundIndex).sound, p);
    }

    ma_vec3f miniaudio_backend_sound_get_position(uint32_t soundIndex) {
        if (!check_sound_index(soundIndex, "get_position")) {
            ma_vec3f result;
            result.x = 0;
            result.y = 0;
            result.z = 0;
            return result;
        }

        return ma_sound_get_position(&vec_access(soundVector, MABackendSound, soundIndex).sound);
    }

    void miniaudio_backend_sound_set_position(uint32_t soundIndex, float x, float y, float z) {
        if (!check_sound_index(soundIndex, "set_position")) return;

        // sounds start with spatialization off to match OpenAL's handling of stereo buffers,
        // so a non-origin position has to switch it back on (and the origin switches it off)
        ma_sound_set_spatialization_enabled(&vec_access(soundVector, MABackendSound, soundIndex).sound, (x != 0 || y != 0 || z != 0) ? MA_TRUE : MA_FALSE);

        ma_sound_set_position(&vec_access(soundVector, MABackendSound, soundIndex).sound, x, y, z);
    }

    float miniaudio_backend_sound_get_length(uint32_t soundIndex, float offset) {
        if (!check_sound_index(soundIndex, "get_length")) return 0;

        MABackendSound* pSound = &vec_access(soundVector, MABackendSound, soundIndex);

        uint64_t lengthPcmFrames = 0;
        if (ma_sound_get_length_in_pcm_frames(&pSound->sound, &lengthPcmFrames) != MA_SUCCESS) {
            // common for a streamed decoder over a format with no cheap length, do not fall
            // through with lengthPcmFrames still 0 -- that would report a length of -offset
            fprintf(stderr, "[lime miniaudio backend]: WARNING: failed to get length of an ma_sound with index %d\n", soundIndex);
            return pSound->stopTime;
        }

        uint32_t sampleRate;
        if (ma_sound_get_data_format(&pSound->sound, NULL, NULL, &sampleRate, NULL, 0) != MA_SUCCESS || sampleRate == 0) {
            fprintf(stderr, "[lime miniaudio backend]: WARNING: failed to get data format of an ma_sound with index %d\n", soundIndex);
            return pSound->stopTime;
        }

        float length = (float)(lengthPcmFrames * 1000) / (float)sampleRate - offset;

        if (pSound->stopTime < length && pSound->stopTime > 0) length = pSound->stopTime;

        return length < 0 ? 0 : length; // an offset past the end must not report a negative length
    }

    void miniaudio_backend_sound_set_length(uint32_t soundIndex, float offset, float length) {
        if (!check_sound_index(soundIndex, "set_length")) return;

        MABackendSound* pSound = &vec_access(soundVector, MABackendSound, soundIndex);

        pSound->stopTime = length;

        // only anchor it now if the sound is already running; otherwise sound_start() does it,
        // so that a length configured before playback is measured from when playback begins
        if (ma_sound_is_playing(&pSound->sound)) {
            miniaudio_backend_sound_apply_stop_time(pSound);
        }
    }

    int32_t miniaudio_backend_sound_get_loops(uint32_t soundIndex) {
        if (!check_sound_index(soundIndex, "get_loops")) return 0;

        return ma_atomic_load_i32(&vec_access(soundVector, MABackendSound, soundIndex).loops);
    }

    void miniaudio_backend_sound_set_loops(uint32_t soundIndex, int32_t loops) {
        if (!check_sound_index(soundIndex, "set_loops")) return;

        ma_atomic_exchange_i32(&vec_access(soundVector, MABackendSound, soundIndex).loops, loops);
    }

    bool miniaudio_backend_sound_is_playing(uint32_t soundIndex) {
        if (!check_sound_index(soundIndex, "is_playing")) return false;

        return ma_sound_is_playing(&vec_access(soundVector, MABackendSound, soundIndex).sound) == MA_TRUE ? true : false;
    }

    value miniaudio_backend_sound_readback_pcm(uint32_t soundIndex) {
        if (!check_sound_index(soundIndex, "readback_pcm")) return alloc_null();

        ma_audio_buffer* pAudioBuffer = NULL;
        value obj = alloc_empty_object();

        switch (vec_access(soundVector, MABackendSound, soundIndex).dataSourceType) {
            case MA_BACKEND_SOUND_DATA_SOURCE_TYPE_INTERNAL:
            case MA_BACKEND_SOUND_DATA_SOURCE_TYPE_DECODER:
                fprintf(stderr, "[lime miniaudio backend]: WARNING: ma_sound with index %d is streamed and does not support readback\n", soundIndex);
                return alloc_null();
            case MA_BACKEND_SOUND_DATA_SOURCE_TYPE_AUDIO_BUFFER:
                pAudioBuffer = &vec_access(soundVector, MABackendSound, soundIndex).dataSource.audioBuffer;

                alloc_field(obj, val_id("format"), alloc_int(pAudioBuffer->ref.format));
                alloc_field(obj, val_id("channels"), alloc_int(pAudioBuffer->ref.channels));
                alloc_field(obj, val_id("sampleRate"), alloc_int(pAudioBuffer->ref.sampleRate));
                alloc_field(obj, val_id("pcmFrameCount"), alloc_int((int)pAudioBuffer->ref.sizeInFrames));
                alloc_field(obj, val_id("pcmFrames"), cffi::alloc_pointer((void*)pAudioBuffer->ref.pData));

                break;
        }

        return obj;
    }

}
