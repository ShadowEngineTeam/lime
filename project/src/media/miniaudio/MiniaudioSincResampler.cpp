/*
    bsinc24-style windowed-sinc resampling backend for miniaudio 0.11.x.

    Implements the ma_resampling_backend_vtable contract with a Blackman-Harris windowed
    sinc kernel (24 taps per side, 49 taps total -- twice the tap count of the "bsinc24"
    alsoft/libsoxr kernel SEAL asks for), evaluated through an interpolated polyphase table.

    Design notes
    ============
    - Polyphase table with phase interpolation. The table holds a fixed SINC_PHASE_COUNT+1
      kernel rows sampled at fractional offsets f = i/SINC_PHASE_COUNT, plus a companion
      table of row-to-row deltas. An output frame whose fractional position falls between
      two rows uses `coef[t] + pf * delta[t]`, so the effective phase resolution is limited
      by interpolation error rather than by the row count. This is what makes the kernel
      "bsinc" rather than plain tabulated sinc, and it is the main quality difference from
      a nearest-row lookup: a nearest-row table needs ~16x the rows for the same error.
    - The table size is fixed and independent of the rate pair, so onSetRate() never
      reallocates and the heap layout is decided once in onGetHeapSize().
    - Anti-alias cutoff. When downsampling the kernel cutoff tracks sampleRateOut/sampleRateIn
      so the stopband stays below the new Nyquist. The cutoff is quantized *downwards* to
      SINC_CUTOFF_STEPS steps: rounding down always over-filters slightly (a little HF loss)
      and never under-filters (which would alias), and it means onSetRate() only rebuilds the
      transcendental-heavy table when the quantized step actually moves. Upsampling pins the
      cutoff at SINC_ROLLOFF, so pitch changes that stay above 1.0 never rebuild at all.
    - Streaming. The backend keeps a per-channel ring of the last SINC_RING_SIZE input samples.
      An output frame at input-time position `k` needs input samples [k-24, k+24], so input
      must lead by 24 frames ("look-ahead" latency, reported via onGetInputLatency).
    - The 32.32 fixed-point timer `position` holds the input time of the next output frame
      and is rate-independent in the integer part, so onSetRate() keeps history and timer.
    - Passthrough fast-path when sampleRateIn == sampleRateOut. It still feeds the ring and
      advances the timer, so switching to and from a resampling ratio mid-stream (which the
      pitch path does) stays continuous instead of convolving against stale history.
    - onProcess() mirrors the stateful two-pass semantics of the built-in linear backend:
      *pFrameCountIn/Out are caps, actual counts are written back; pFramesIn == NULL
      synthesizes zeros; pFramesOut == NULL is a dry-run that still advances the stream.

    The heap layout (one contiguous allocation from miniaudio's resampler heap) is:
        [ma_sinc_backend state] [coefficient rows] [delta rows] [history rings]
*/

#include <media/miniaudio/MiniaudioSincResampler.h>

#include <math.h>
#include <memory.h>

#ifndef MA_PI /* defined in miniaudio's implementation section, not visible here */
#define MA_PI 3.14159265358979323846f
#endif

namespace lime {

    #define SINC_TAP_COUNT 24    /* taps per side (49 taps total), "bsinc24" */
    #define SINC_TAP_SPAN  (2 * SINC_TAP_COUNT + 1)
    #define SINC_RING_SIZE 64    /* power of two >= SINC_TAP_SPAN + look-ahead */
    #define SINC_PHASE_BITS 7
    #define SINC_PHASE_COUNT (1 << SINC_PHASE_BITS) /* interpolated, so this can stay small */
    #define SINC_PHASE_SHIFT (32 - SINC_PHASE_BITS)
    #define SINC_CUTOFF_STEPS 32 /* quantization of the anti-alias cutoff, see notes above */
    #define SINC_ROLLOFF 0.99f

    typedef struct {
        ma_format format;
        ma_uint32 channels;
        ma_uint32 sampleRateIn;
        ma_uint32 sampleRateOut;
        ma_uint32 cutoffStep;  /* quantized cutoff the table was built for, 0 = not built */
        ma_uint64 advance;     /* 32.32 fixed point: input frames per output frame */
        ma_uint64 position;    /* 32.32 fixed point: input time of the next output frame */
        ma_uint64 inputCount;  /* absolute count of input frames fed (ring write index) */
        float* pTable;         /* (SINC_PHASE_COUNT + 1) * SINC_TAP_SPAN coefficients */
        float* pDelta;         /* SINC_PHASE_COUNT * SINC_TAP_SPAN row-to-row deltas */
        float* pRing;          /* channels * SINC_RING_SIZE history, planar */
    } ma_sinc_backend;

    static ma_uint64 ma_sinc_min64(ma_uint64 a, ma_uint64 b) { return a < b ? a : b; }

    /* 4-term Blackman-Harris window, x in [-1, 1]. Shifted form: the alternating signs of the
       textbook definition become all-positive once the argument is centered on the peak. */
    static float ma_sinc_blackman_harris(float x)
    {
        const float a0 = 0.35875f;
        const float a1 = 0.48829f;
        const float a2 = 0.14128f;
        const float a3 = 0.01168f;
        float px;

        if (x <= -1.0f || x >= 1.0f) {
            return 0.0f;
        }

        px = MA_PI * x;
        return a0 + a1 * cosf(px) + a2 * cosf(2.0f * px) + a3 * cosf(3.0f * px);
    }

    static float ma_sinc_sinc(float x)
    {
        float px;

        if (x == 0.0f) {
            return 1.0f;
        }

        px = MA_PI * x;
        return sinf(px) / px;
    }

    /* Quantized anti-alias cutoff for a rate pair. Rounds down so we never under-filter. */
    static ma_uint32 ma_sinc_cutoff_step(ma_uint32 sampleRateIn, ma_uint32 sampleRateOut)
    {
        float ratio;
        ma_uint32 step;

        if (sampleRateIn == 0 || sampleRateOut >= sampleRateIn) {
            return SINC_CUTOFF_STEPS; /* upsampling: cutoff is pinned, table is ratio independent */
        }

        ratio = (float)sampleRateOut / (float)sampleRateIn;
        step = (ma_uint32)(ratio * SINC_CUTOFF_STEPS);

        if (step < 1) {
            step = 1;
        }
        if (step > SINC_CUTOFF_STEPS) {
            step = SINC_CUTOFF_STEPS;
        }

        return step;
    }

    /* Builds SINC_PHASE_COUNT+1 normalized kernel rows and the deltas between them.
       Only called when the quantized cutoff changes, never on every rate tweak. */
    static void ma_sinc_build_table(ma_sinc_backend* pResampler, ma_uint32 cutoffStep)
    {
        const float cutoff = SINC_ROLLOFF * ((float)cutoffStep / (float)SINC_CUTOFF_STEPS);
        const float windowScale = 1.0f / (float)(SINC_TAP_COUNT + 1);
        ma_uint32 iPhase;

        for (iPhase = 0; iPhase <= SINC_PHASE_COUNT; iPhase++) {
            float* pRow = pResampler->pTable + (size_t)iPhase * SINC_TAP_SPAN;
            float f = (float)iPhase / (float)SINC_PHASE_COUNT;
            float sum = 0.0f;
            ma_int32 t;

            for (t = -(ma_int32)SINC_TAP_COUNT; t <= (ma_int32)SINC_TAP_COUNT; t++) {
                float d = (float)t - f;
                float c = cutoff * ma_sinc_sinc(cutoff * d) * ma_sinc_blackman_harris(d * windowScale);
                pRow[t + SINC_TAP_COUNT] = c;
                sum += c;
            }

            /* Normalize each row to unit DC gain so the interpolated kernel stays flat. */
            if (sum > 0.0f) {
                float inv = 1.0f / sum;
                ma_uint32 iTap;
                for (iTap = 0; iTap < SINC_TAP_SPAN; iTap++) {
                    pRow[iTap] *= inv;
                }
            }
        }

        for (iPhase = 0; iPhase < SINC_PHASE_COUNT; iPhase++) {
            const float* pRow = pResampler->pTable + (size_t)iPhase * SINC_TAP_SPAN;
            const float* pNext = pRow + SINC_TAP_SPAN;
            float* pDeltaRow = pResampler->pDelta + (size_t)iPhase * SINC_TAP_SPAN;
            ma_uint32 iTap;

            for (iTap = 0; iTap < SINC_TAP_SPAN; iTap++) {
                pDeltaRow[iTap] = pNext[iTap] - pRow[iTap];
            }
        }

        pResampler->cutoffStep = cutoffStep;
    }

    static void ma_sinc_update_rate(ma_sinc_backend* pResampler)
    {
        ma_uint32 cutoffStep;

        pResampler->advance = ((ma_uint64)pResampler->sampleRateIn << 32) / pResampler->sampleRateOut;

        cutoffStep = ma_sinc_cutoff_step(pResampler->sampleRateIn, pResampler->sampleRateOut);
        if (cutoffStep != pResampler->cutoffStep) {
            ma_sinc_build_table(pResampler, cutoffStep);
        }
    }

    static ma_result ma_sinc_resampler_get_heap_size(void* pUserData, const ma_resampler_config* pConfig, size_t* pHeapSizeInBytes)
    {
        size_t size;

        (void)pUserData;

        if (pHeapSizeInBytes == NULL || pConfig == NULL) {
            return MA_INVALID_ARGS;
        }

        if (pConfig->format != ma_format_f32 && pConfig->format != ma_format_s16) {
            return MA_INVALID_ARGS;
        }

        if (pConfig->channels == 0 || pConfig->sampleRateIn == 0 || pConfig->sampleRateOut == 0) {
            return MA_INVALID_ARGS;
        }

        size = sizeof(ma_sinc_backend);
        size = (size + 7) & ~(size_t)7;
        size += (size_t)(SINC_PHASE_COUNT + 1) * SINC_TAP_SPAN * sizeof(float); /* coefficient rows */
        size += (size_t)SINC_PHASE_COUNT * SINC_TAP_SPAN * sizeof(float);       /* delta rows */
        size += (size_t)pConfig->channels * SINC_RING_SIZE * sizeof(float);     /* history rings */

        *pHeapSizeInBytes = size;
        return MA_SUCCESS;
    }

    static ma_result ma_sinc_resampler_init(void* pUserData, const ma_resampler_config* pConfig, void* pHeap, ma_resampling_backend** ppBackend)
    {
        ma_sinc_backend* pResampler;
        size_t offset;

        (void)pUserData;

        if (pConfig == NULL || pHeap == NULL || ppBackend == NULL) {
            return MA_INVALID_ARGS;
        }

        if (pConfig->format != ma_format_f32 && pConfig->format != ma_format_s16) {
            return MA_INVALID_ARGS;
        }

        if (pConfig->channels == 0 || pConfig->sampleRateIn == 0 || pConfig->sampleRateOut == 0) {
            return MA_INVALID_ARGS;
        }

        pResampler = (ma_sinc_backend*)pHeap;
        memset(pResampler, 0, sizeof(*pResampler));

        pResampler->format = pConfig->format;
        pResampler->channels = pConfig->channels;
        pResampler->sampleRateIn = pConfig->sampleRateIn;
        pResampler->sampleRateOut = pConfig->sampleRateOut;

        offset = (sizeof(ma_sinc_backend) + 7) & ~(size_t)7;
        pResampler->pTable = (float*)((ma_uint8*)pHeap + offset);
        offset += (size_t)(SINC_PHASE_COUNT + 1) * SINC_TAP_SPAN * sizeof(float);
        pResampler->pDelta = (float*)((ma_uint8*)pHeap + offset);
        offset += (size_t)SINC_PHASE_COUNT * SINC_TAP_SPAN * sizeof(float);
        pResampler->pRing = (float*)((ma_uint8*)pHeap + offset);
        memset(pResampler->pRing, 0, (size_t)pResampler->channels * SINC_RING_SIZE * sizeof(float));

        pResampler->position = 0;
        pResampler->inputCount = 0;
        pResampler->cutoffStep = 0; /* forces the first build */

        ma_sinc_update_rate(pResampler);

        *ppBackend = pResampler;
        return MA_SUCCESS;
    }

    static void ma_sinc_resampler_uninit(void* pUserData, ma_resampling_backend* pBackend, const ma_allocation_callbacks* pAllocationCallbacks)
    {
        (void)pUserData;
        (void)pBackend;
        (void)pAllocationCallbacks;
        /* Nothing to do. The heap is owned by miniaudio. */
    }

    /* Writes one input frame into the ring at the current write index. pFrames may be NULL,
       which feeds silence (miniaudio uses that to drain the tail of a stream). */
    static void ma_sinc_push_frame(ma_sinc_backend* pResampler, const void* pFrames)
    {
        const ma_uint64 slot = pResampler->inputCount & (SINC_RING_SIZE - 1);
        const ma_uint32 channelCount = pResampler->channels;
        ma_uint32 ch;

        if (pFrames == NULL) {
            for (ch = 0; ch < channelCount; ch++) {
                pResampler->pRing[ch * SINC_RING_SIZE + slot] = 0.0f;
            }
        } else if (pResampler->format == ma_format_f32) {
            const float* pIn = (const float*)pFrames;
            for (ch = 0; ch < channelCount; ch++) {
                pResampler->pRing[ch * SINC_RING_SIZE + slot] = pIn[ch];
            }
        } else {
            const ma_int16* pIn = (const ma_int16*)pFrames;
            for (ch = 0; ch < channelCount; ch++) {
                pResampler->pRing[ch * SINC_RING_SIZE + slot] = (float)pIn[ch] * (1.0f / 32768.0f);
            }
        }

        pResampler->inputCount += 1;
    }

    static ma_result ma_sinc_resampler_process(void* pUserData, ma_resampling_backend* pBackend, const void* pFramesIn, ma_uint64* pFrameCountIn, void* pFramesOut, ma_uint64* pFrameCountOut)
    {
        ma_sinc_backend* pResampler;
        ma_uint64 inCap;
        ma_uint64 outCap;
        ma_bool32 isF32;
        ma_uint32 channelCount;
        size_t bytesPerFrame;
        const ma_uint8* pIn;
        ma_uint8* pOut;
        ma_uint64 framesIn = 0;
        ma_uint64 framesOut = 0;

        (void)pUserData;

        if (pBackend == NULL) {
            return MA_INVALID_ARGS;
        }

        if (pFrameCountIn == NULL && pFrameCountOut == NULL) {
            return MA_INVALID_ARGS;
        }

        pResampler = (ma_sinc_backend*)pBackend;
        inCap = (pFrameCountIn != NULL) ? *pFrameCountIn : 0;
        outCap = (pFrameCountOut != NULL) ? *pFrameCountOut : 0;
        isF32 = (pResampler->format == ma_format_f32);
        channelCount = pResampler->channels;
        bytesPerFrame = channelCount * (isF32 ? sizeof(float) : sizeof(ma_int16));
        pIn = (const ma_uint8*)pFramesIn;
        pOut = (ma_uint8*)pFramesOut;

        /* Passthrough when the rates match. Still tracks the ring and the timer so that a
           later switch to a resampling ratio (the pitch path does this) has valid history. */
        if (pResampler->sampleRateIn == pResampler->sampleRateOut) {
            ma_uint64 n = ma_sinc_min64(inCap, outCap);
            ma_uint64 i;

            for (i = 0; i < n; i++) {
                ma_sinc_push_frame(pResampler, (pIn != NULL) ? (pIn + i * bytesPerFrame) : NULL);
            }

            if (pOut != NULL) {
                if (pIn != NULL) {
                    memcpy(pOut, pIn, (size_t)(n * bytesPerFrame));
                } else {
                    memset(pOut, 0, (size_t)(n * bytesPerFrame));
                }
            }

            pResampler->position += n << 32;

            if (pFrameCountIn != NULL) *pFrameCountIn = n;
            if (pFrameCountOut != NULL) *pFrameCountOut = n;
            return MA_SUCCESS;
        }

        while (framesOut < outCap) {
            ma_uint64 k = pResampler->position >> 32;
            ma_uint32 frac;
            ma_uint32 phase;
            float phaseFrac;
            const float* pCoef;
            const float* pDelta;
            ma_uint32 startSlot;
            ma_uint32 run1;
            ma_uint32 ch;

            /* Feed input until the look-ahead is satisfied or we run out of input. */
            while (pResampler->inputCount < (k + SINC_TAP_COUNT + 1) && framesIn < inCap) {
                ma_sinc_push_frame(pResampler, (pIn != NULL) ? (pIn + framesIn * bytesPerFrame) : NULL);
                framesIn += 1;
            }

            if (pResampler->inputCount <= (k + SINC_TAP_COUNT)) {
                break; /* Ran out of input data. */
            }

            frac = (ma_uint32)(pResampler->position & 0xFFFFFFFFu);
            phase = frac >> SINC_PHASE_SHIFT;
            phaseFrac = (float)(frac & ((1u << SINC_PHASE_SHIFT) - 1u)) * (1.0f / (float)(1u << SINC_PHASE_SHIFT));
            pCoef = pResampler->pTable + (size_t)phase * SINC_TAP_SPAN;
            pDelta = pResampler->pDelta + (size_t)phase * SINC_TAP_SPAN;

            /* The tap window is contiguous in the ring apart from at most one wrap, so walk
               it as two straight runs instead of masking every tap. */
            startSlot = (ma_uint32)((k - SINC_TAP_COUNT) & (SINC_RING_SIZE - 1));
            run1 = SINC_RING_SIZE - startSlot;
            if (run1 > SINC_TAP_SPAN) {
                run1 = SINC_TAP_SPAN;
            }

            for (ch = 0; ch < channelCount; ch++) {
                const float* pRing = pResampler->pRing + ch * SINC_RING_SIZE;
                const float* pSrc = pRing + startSlot;
                float acc = 0.0f;
                ma_uint32 t;

                for (t = 0; t < run1; t++) {
                    acc += pSrc[t] * (pCoef[t] + phaseFrac * pDelta[t]);
                }

                pSrc = pRing;
                for (t = run1; t < SINC_TAP_SPAN; t++) {
                    acc += pSrc[t - run1] * (pCoef[t] + phaseFrac * pDelta[t]);
                }

                if (pOut != NULL) {
                    if (isF32) {
                        ((float*)pOut)[ch] = acc;
                    } else {
                        ma_int32 v;
                        if (acc > 1.0f) {
                            acc = 1.0f;
                        } else if (acc < -1.0f) {
                            acc = -1.0f;
                        }
                        v = (ma_int32)(acc * 32768.0f);
                        if (v > 32767) {
                            v = 32767;
                        } else if (v < -32768) {
                            v = -32768;
                        }
                        ((ma_int16*)pOut)[ch] = (ma_int16)v;
                    }
                }
            }

            if (pOut != NULL) {
                pOut += bytesPerFrame;
            }

            framesOut += 1;
            pResampler->position += pResampler->advance;
        }

        if (pFrameCountIn != NULL) *pFrameCountIn = framesIn;
        if (pFrameCountOut != NULL) *pFrameCountOut = framesOut;

        return MA_SUCCESS;
    }

    static ma_result ma_sinc_resampler_set_rate(void* pUserData, ma_resampling_backend* pBackend, ma_uint32 sampleRateIn, ma_uint32 sampleRateOut)
    {
        ma_sinc_backend* pResampler;

        (void)pUserData;

        if (pBackend == NULL) {
            return MA_INVALID_ARGS;
        }

        if (sampleRateIn == 0 || sampleRateOut == 0) {
            return MA_INVALID_ARGS;
        }

        pResampler = (ma_sinc_backend*)pBackend;

        if (pResampler->sampleRateIn == sampleRateIn && pResampler->sampleRateOut == sampleRateOut) {
            return MA_SUCCESS;
        }

        /* The timer is expressed in input frames and the history is rate-independent, so both
           are kept. Only `advance` always changes; the table is rebuilt only when the quantized
           anti-alias cutoff moves, which keeps pitch sweeps off the transcendental path. */
        pResampler->sampleRateIn = sampleRateIn;
        pResampler->sampleRateOut = sampleRateOut;
        ma_sinc_update_rate(pResampler);

        return MA_SUCCESS;
    }

    static ma_uint64 ma_sinc_resampler_get_input_latency(void* pUserData, const ma_resampling_backend* pBackend)
    {
        (void)pUserData;

        if (pBackend == NULL) {
            return 0;
        }

        return SINC_TAP_COUNT + 1; /* look-ahead held back */
    }

    static ma_uint64 ma_sinc_resampler_get_output_latency(void* pUserData, const ma_resampling_backend* pBackend)
    {
        const ma_sinc_backend* pResampler;

        (void)pUserData;

        if (pBackend == NULL) {
            return 0;
        }

        pResampler = (const ma_sinc_backend*)pBackend;
        return ma_sinc_resampler_get_input_latency(NULL, pBackend) * pResampler->sampleRateOut / pResampler->sampleRateIn;
    }

    static ma_result ma_sinc_resampler_get_required_input_frame_count(void* pUserData, const ma_resampling_backend* pBackend, ma_uint64 outputFrameCount, ma_uint64* pInputFrameCount)
    {
        const ma_sinc_backend* pResampler;
        ma_uint64 endPos;
        ma_uint64 needed;

        (void)pUserData;

        if (pInputFrameCount == NULL) {
            return MA_INVALID_ARGS;
        }

        *pInputFrameCount = 0;

        if (pBackend == NULL) {
            return MA_INVALID_ARGS;
        }

        if (outputFrameCount == 0) {
            return MA_SUCCESS;
        }

        pResampler = (const ma_sinc_backend*)pBackend;

        if (pResampler->sampleRateIn == pResampler->sampleRateOut) {
            *pInputFrameCount = outputFrameCount;
            return MA_SUCCESS;
        }

        /* The last output frame sits at position + (outputFrameCount-1)*advance and needs
           input up to floor(position) + SINC_TAP_COUNT. Report the shortfall relative to what
           has already been fed -- the compare has to happen before the subtract, these are
           unsigned and the resampler is routinely already ahead of what is being asked for. */
        endPos = pResampler->position + (outputFrameCount - 1) * pResampler->advance;
        needed = (endPos >> 32) + SINC_TAP_COUNT + 1;

        if (needed > pResampler->inputCount) {
            *pInputFrameCount = needed - pResampler->inputCount;
        }

        return MA_SUCCESS;
    }

    static ma_result ma_sinc_resampler_get_expected_output_frame_count(void* pUserData, const ma_resampling_backend* pBackend, ma_uint64 inputFrameCount, ma_uint64* pOutputFrameCount)
    {
        const ma_sinc_backend* pResampler;
        ma_uint64 available;
        ma_uint64 endPos;

        (void)pUserData;

        if (pOutputFrameCount == NULL) {
            return MA_INVALID_ARGS;
        }

        *pOutputFrameCount = 0;

        if (pBackend == NULL) {
            return MA_INVALID_ARGS;
        }

        pResampler = (const ma_sinc_backend*)pBackend;

        if (pResampler->sampleRateIn == pResampler->sampleRateOut) {
            *pOutputFrameCount = inputFrameCount;
            return MA_SUCCESS;
        }

        /* Frames that will be readable once inputFrameCount more have been fed, accounting for
           the history already buffered and the look-ahead that is held back. */
        available = pResampler->inputCount + inputFrameCount;
        if (available <= SINC_TAP_COUNT) {
            return MA_SUCCESS;
        }

        endPos = (available - SINC_TAP_COUNT) << 32;
        if (endPos > pResampler->position) {
            *pOutputFrameCount = (endPos - pResampler->position + pResampler->advance - 1) / pResampler->advance;
        }

        return MA_SUCCESS;
    }

    static ma_result ma_sinc_resampler_reset(void* pUserData, ma_resampling_backend* pBackend)
    {
        ma_sinc_backend* pResampler;

        (void)pUserData;

        if (pBackend == NULL) {
            return MA_INVALID_ARGS;
        }

        pResampler = (ma_sinc_backend*)pBackend;
        memset(pResampler->pRing, 0, (size_t)pResampler->channels * SINC_RING_SIZE * sizeof(float));
        pResampler->position = 0;
        pResampler->inputCount = 0;

        return MA_SUCCESS;
    }

    static ma_resampling_backend_vtable g_ma_sinc_resampler_vtable =
    {
        ma_sinc_resampler_get_heap_size,
        ma_sinc_resampler_init,
        ma_sinc_resampler_uninit,
        ma_sinc_resampler_process,
        ma_sinc_resampler_set_rate,
        ma_sinc_resampler_get_input_latency,
        ma_sinc_resampler_get_output_latency,
        ma_sinc_resampler_get_required_input_frame_count,
        ma_sinc_resampler_get_expected_output_frame_count,
        ma_sinc_resampler_reset
    };

    ma_result miniaudio_sinc_resampler_init_config(ma_resampler_config* pConfig)
    {
        if (pConfig == NULL) {
            return MA_INVALID_ARGS;
        }

        *pConfig = ma_resampler_config_init(ma_format_f32, 2, 0, 0, ma_resample_algorithm_custom);
        pConfig->pBackendVTable = &g_ma_sinc_resampler_vtable;
        pConfig->pBackendUserData = NULL;

        return MA_SUCCESS;
    }

}
