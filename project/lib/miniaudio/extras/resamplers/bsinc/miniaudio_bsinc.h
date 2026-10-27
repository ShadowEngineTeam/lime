/*
 * bsinc24 resampler for miniaudio, backported from OpenAL Soft (`resampler = bsinc24`).
 *
 * Derived from OpenAL Soft's core/bsinc_tables.cpp, core/mixer/mixer_c.cpp (do_bsinc) and
 * alc/alu.cpp (BsincPrepare).
 *   OpenAL cross platform audio library, Copyright (C) 1999-2007 by authors.
 *   Licensed under the GNU Library General Public License, version 2 or later (LGPL-2.0+).
 * This file is therefore LGPL-2.0+, unlike the rest of miniaudio (public domain / MIT-0).
 *
 * What it is: a 24-point band-limited (Kaiser-windowed sinc) resampler. The filter is chosen
 * per resample ratio from a table of 16 scales x 32 phases, bilinearly interpolating between
 * scales and phases. When down-sampling the filter grows (up to 48 points) and the cutoff is
 * lowered so content above the output Nyquist is filtered instead of aliased.
 *
 * Differences from OpenAL Soft (none affect the filter response):
 *   - Table is generated at runtime on first use instead of at compile time (same math).
 *   - Read position is a Q32.32 fixed point value instead of Q16, so long streams do not drift.
 *   - Streaming/history handling is done here, since miniaudio calls the resampler in chunks.
 *
 * Usage (include after miniaudio.h, from exactly one translation unit):
 *
 *     #include <extras/resamplers/bsinc/miniaudio_bsinc.h>
 *     decoderConfig.resampling    = ma_bsinc24_resampler_config_init(ma_format_unknown, 0, 0, 0);
 *     deviceConfig.resampling     = ma_bsinc24_resampler_config_init(ma_format_unknown, 0, 0, 0);
 *     engineConfig.pitchResampling = ma_bsinc24_resampler_config_init(ma_format_unknown, 0, 0, 0);
 *
 * Supports ma_format_f32 and ma_format_s16, any channel count.
 */
#ifndef miniaudio_bsinc_h
#define miniaudio_bsinc_h

#include <math.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

/* ---- Filter design constants (OpenAL Soft: core/bsinc_defs.h, bsinc_tables.cpp) ---------- */
#define MA_BSINC_SCALE_COUNT   16
#define MA_BSINC_PHASE_BITS    5
#define MA_BSINC_PHASE_COUNT   (1 << MA_BSINC_PHASE_BITS)
#define MA_BSINC_PADDING       48     /* MaxResamplerPadding: widest filter (m <= 48). */

/* bsinc24: 23rd order filter (24-point), 60 dB drop at Nyquist, scaling up to 2x (47th order). */
#define MA_BSINC24_REJECTION   60.0
#define MA_BSINC24_ORDER       23.0
#define MA_BSINC24_MAX_SCALE   2.0

typedef struct
{
    double scaleBase;
    float  scaleRange;
    ma_uint32 m[MA_BSINC_SCALE_COUNT];            /* padded coefficient count per scale */
    ma_uint32 filterOffset[MA_BSINC_SCALE_COUNT];
    float* pTab;
    size_t tabSize;
} ma_bsinc_table;

/* ---- Table generation -------------------------------------------------------------------- */

static double ma_bsinc_bessel_i0(double x)
{
    double x2 = x / 2.0, term = 1.0, sum = 1.0, last;
    int k = 1;
    do {
        double y = x2 / k;
        ++k;
        last = sum;
        term *= y * y;
        sum += term;
    } while (sum != last);
    return sum;
}

static double ma_bsinc_sinc(double x)
{
    if (!(x > 2.220446049250313e-16 || x < -2.220446049250313e-16)) {
        return 1.0;
    }
    return sin(3.14159265358979323846 * x) / (3.14159265358979323846 * x);
}

static double ma_bsinc_kaiser(double beta, double k, double i0beta)
{
    if (!(k >= -1.0 && k <= 1.0)) {
        return 0.0;
    }
    return ma_bsinc_bessel_i0(beta * sqrt(1.0 - k*k)) / i0beta;
}

static double ma_bsinc_kaiser_width(double rejection, double order)
{
    if (rejection > 21.19) {
        return (rejection - 7.95) / (2.285 * 3.14159265358979323846 * 2.0 * order);
    }
    return 5.79 / (3.14159265358979323846 * 2.0) / order;
}

static double ma_bsinc_kaiser_beta(double rejection)
{
    if (rejection > 50.0)  { return 0.1102 * (rejection - 8.7); }
    if (rejection >= 21.0) { return 0.5842 * pow(rejection - 21.0, 0.4) + 0.07886 * (rejection - 21.0); }
    return 0.0;
}

static int ma_bsinc_build_table(ma_bsinc_table* pT, double rejection, double order, double maxScale)
{
    const double beta       = ma_bsinc_kaiser_beta(rejection);
    const double scaleBase  = ma_bsinc_kaiser_width(rejection, order) / 2.0;
    const double scaleLimit = 1.0 / maxScale;
    const double baseA      = (order + 1.0) / 2.0;
    double a[MA_BSINC_SCALE_COUNT];
    ma_uint32 mUnpadded[MA_BSINC_SCALE_COUNT];
    size_t totalSize = 0;
    ma_uint32 pointsMax;
    int si, pi, i;
    double* filter;           /* [scale][phase][pointsMax] */
    size_t idx = 0;
    double i0beta;

    for (si = 0; si < MA_BSINC_SCALE_COUNT; ++si) {
        double scale = scaleBase + (1.0 - scaleBase) * ((double)(si + 1) / (double)MA_BSINC_SCALE_COUNT);
        double v = baseA / scale;
        a[si] = v < baseA * maxScale ? v : baseA * maxScale;
        mUnpadded[si] = (ma_uint32)ceil(a[si]) * 2u;
        totalSize += 4u * MA_BSINC_PHASE_COUNT * ((mUnpadded[si] + 3u) & ~3u);
    }
    pointsMax = (mUnpadded[0] + 3u) & ~3u;
    if (pointsMax > MA_BSINC_PADDING) {
        return 0;
    }

    filter = (double*)calloc((size_t)MA_BSINC_SCALE_COUNT * MA_BSINC_PHASE_COUNT * pointsMax, sizeof(double));
    pT->pTab = (float*)malloc(sizeof(float) * totalSize);
    if (filter == NULL || pT->pTab == NULL) {
        free(filter); free(pT->pTab); pT->pTab = NULL;
        return 0;
    }
    #define MA_BSINC_F(s, p, i) filter[((size_t)(s) * MA_BSINC_PHASE_COUNT + (size_t)(p)) * pointsMax + (size_t)(i)]

    i0beta = ma_bsinc_bessel_i0(beta);

    /* Kaiser-windowed sinc coefficients for each scale and phase. */
    for (si = 0; si < MA_BSINC_SCALE_COUNT; ++si) {
        const double m = (double)mUnpadded[si];
        const double l = floor(m * 0.5) - 1.0;
        const size_t o = (pointsMax - mUnpadded[si]) / 2u;
        const double scale = scaleBase + (1.0 - scaleBase) * ((double)(si + 1) / (double)MA_BSINC_SCALE_COUNT);

        /* Cutoff selection: see the long comment in OpenAL Soft's bsinc_tables.cpp. The transition
         * band is allowed to wrap around Nyquist so the cutoff stays high when down-sampling. */
        const double maxCutoff = (0.5 - scaleBase) * scale;
        const double width     = scaleBase * (scaleLimit > scale ? scaleLimit : scale);
        const double c2        = (scale - width) * 0.5;
        const double cutoff2   = (maxCutoff < c2 ? maxCutoff : c2) * 2.0;

        for (pi = 0; pi < MA_BSINC_PHASE_COUNT; ++pi) {
            const double phase = l + (double)pi / (double)MA_BSINC_PHASE_COUNT;
            for (i = 0; i < (int)mUnpadded[si]; ++i) {
                const double x = (double)i - phase;
                MA_BSINC_F(si, pi, o + (size_t)i) = ma_bsinc_kaiser(beta, x / a[si], i0beta) * cutoff2 * ma_bsinc_sinc(cutoff2 * x);
            }
        }
    }

    for (si = 0; si < MA_BSINC_SCALE_COUNT; ++si) {
        const size_t m = (mUnpadded[si] + 3u) & ~3u;
        const size_t o = (pointsMax - m) / 2u;
        const size_t last = MA_BSINC_PHASE_COUNT - 1;

        /* Filter + phase delta for each phase. */
        for (pi = 0; pi < MA_BSINC_PHASE_COUNT; ++pi) {
            for (i = 0; i < (int)m; ++i) {
                pT->pTab[idx++] = (float)MA_BSINC_F(si, pi, o + i);
            }
            if ((size_t)pi < last) {
                for (i = 0; i < (int)m; ++i) {
                    pT->pTab[idx++] = (float)(MA_BSINC_F(si, pi + 1, o + i) - MA_BSINC_F(si, pi, o + i));
                }
            } else {
                /* Delta target for the last phase is the first phase offset by one coefficient. */
                pT->pTab[idx++] = (float)(0.0 - MA_BSINC_F(si, pi, o));
                for (i = 1; i < (int)m; ++i) {
                    pT->pTab[idx++] = (float)(MA_BSINC_F(si, 0, o + i - 1) - MA_BSINC_F(si, pi, o + i));
                }
            }
        }

        /* Scale delta + scale-phase delta for each phase. */
        if (si < MA_BSINC_SCALE_COUNT - 1) {
            for (pi = 0; pi < MA_BSINC_PHASE_COUNT; ++pi) {
                for (i = 0; i < (int)m; ++i) {
                    pT->pTab[idx++] = (float)(MA_BSINC_F(si + 1, pi, o + i) - MA_BSINC_F(si, pi, o + i));
                }
                if ((size_t)pi < last) {
                    for (i = 0; i < (int)m; ++i) {
                        pT->pTab[idx++] = (float)((MA_BSINC_F(si + 1, pi + 1, o + i) - MA_BSINC_F(si + 1, pi, o + i)) -
                                                  (MA_BSINC_F(si,     pi + 1, o + i) - MA_BSINC_F(si,     pi, o + i)));
                    }
                } else {
                    pT->pTab[idx++] = (float)((0.0 - MA_BSINC_F(si + 1, pi, o)) - (0.0 - MA_BSINC_F(si, pi, o)));
                    for (i = 1; i < (int)m; ++i) {
                        pT->pTab[idx++] = (float)((MA_BSINC_F(si + 1, 0, o + i - 1) - MA_BSINC_F(si + 1, pi, o + i)) -
                                                  (MA_BSINC_F(si,     0, o + i - 1) - MA_BSINC_F(si,     pi, o + i)));
                    }
                }
            }
        } else {
            /* The last scale has no scale-related deltas. */
            size_t count = (size_t)MA_BSINC_PHASE_COUNT * m * 2u;
            memset(pT->pTab + idx, 0, count * sizeof(float));
            idx += count;
        }
    }
    #undef MA_BSINC_F
    free(filter);

    pT->scaleBase  = scaleBase;
    pT->scaleRange = (float)(1.0 / (1.0 - scaleBase));
    pT->tabSize    = totalSize;
    for (si = 0; si < MA_BSINC_SCALE_COUNT; ++si) {
        pT->m[si] = (mUnpadded[si] + 3u) & ~3u;
    }
    pT->filterOffset[0] = 0;
    for (si = 1; si < MA_BSINC_SCALE_COUNT; ++si) {
        pT->filterOffset[si] = pT->filterOffset[si - 1] + pT->m[si - 1] * 4u * MA_BSINC_PHASE_COUNT;
    }
    return idx == totalSize;
}

/* Shared, immutable, built once on first use (thread-safe via C++11 static init). */
static const ma_bsinc_table* ma_bsinc24_get_table(void)
{
    struct holder {
        ma_bsinc_table t; int ok;
        holder() { memset(&t, 0, sizeof(t)); ok = ma_bsinc_build_table(&t, MA_BSINC24_REJECTION, MA_BSINC24_ORDER, MA_BSINC24_MAX_SCALE); }
    };
    static const holder h;
    return h.ok ? &h.t : NULL;
}

/* ---- Resampling backend ------------------------------------------------------------------ */

typedef struct
{
    ma_format format;
    ma_uint32 channels;
    ma_uint32 rateIn, rateOut;
    const ma_bsinc_table* pTable;
    /* BsincState (OpenAL Soft core/mixer/defs.h) */
    float sf;                 /* scale interpolation factor */
    ma_uint32 m, l;           /* coefficient count, left offset */
    const float* pFilter;
    uint64_t step;            /* input frames per output frame, Q32.32 */
    uint64_t pos;             /* read position in [history | input], Q32.32 */
    float* pHist;             /* MA_BSINC_PADDING frames * channels */
    float* pScratch;          /* (MA_BSINC_PADDING + inputFrames) * channels */
    size_t scratchFrames;
} ma_bsinc_resampler;

/* OpenAL Soft alc/alu.cpp: BsincPrepare(), computed from the exact ratio instead of a Q16 increment. */
static void ma_bsinc_prepare(ma_bsinc_resampler* s)
{
    const ma_bsinc_table* t = s->pTable;
    const double ratio = (double)s->rateIn / (double)s->rateOut;
    size_t si = MA_BSINC_SCALE_COUNT - 1;
    float sf = 0.0f;

    if (ratio > 1.0) {
        sf = (float)(1.0 / ratio) - (float)t->scaleBase;
        sf = (float)MA_BSINC_SCALE_COUNT * sf * t->scaleRange - 1.0f;
        if (sf < 0.0f) { sf = 0.0f; }
        si = (size_t)sf;
        sf -= (float)si;
        /* Fit to this diagonally-symmetric curve to reduce transition ripple between scales. */
        sf = 1.0f - sqrtf(1.0f - sf*sf);
    }

    s->sf      = sf;
    s->m       = t->m[si];
    s->l       = (s->m / 2u) - 1u;
    s->pFilter = t->pTab + t->filterOffset[si];
    s->step    = (uint64_t)(ratio * 4294967296.0 + 0.5);
}

static ma_result ma_bsinc_get_heap_size(void* pUserData, const ma_resampler_config* pConfig, size_t* pHeapSize)
{
    (void)pUserData; (void)pConfig;
    *pHeapSize = 0;   /* Everything is malloc'd; the shared table is static. */
    return MA_SUCCESS;
}

static ma_result ma_bsinc_init(void* pUserData, const ma_resampler_config* pConfig, void* pHeap, ma_resampling_backend** ppBackend)
{
    ma_bsinc_resampler* s;
    (void)pUserData; (void)pHeap;

    if (pConfig->format != ma_format_f32 && pConfig->format != ma_format_s16) { return MA_INVALID_ARGS; }
    if (pConfig->channels == 0 || pConfig->sampleRateIn == 0 || pConfig->sampleRateOut == 0) { return MA_INVALID_ARGS; }

    s = (ma_bsinc_resampler*)calloc(1, sizeof(*s));
    if (s == NULL) { return MA_OUT_OF_MEMORY; }

    s->pTable = ma_bsinc24_get_table();
    s->pHist  = (float*)calloc((size_t)MA_BSINC_PADDING * pConfig->channels, sizeof(float));
    if (s->pTable == NULL || s->pHist == NULL) { free(s->pHist); free(s); return MA_OUT_OF_MEMORY; }

    s->format   = pConfig->format;
    s->channels = pConfig->channels;
    s->rateIn   = pConfig->sampleRateIn;
    s->rateOut  = pConfig->sampleRateOut;
    s->pos      = (uint64_t)MA_BSINC_PADDING << 32;   /* aligned with the first real input frame */
    ma_bsinc_prepare(s);

    *ppBackend = s;
    return MA_SUCCESS;
}

static void ma_bsinc_uninit(void* pUserData, ma_resampling_backend* pBackend, const ma_allocation_callbacks* pAlloc)
{
    ma_bsinc_resampler* s = (ma_bsinc_resampler*)pBackend;
    (void)pUserData; (void)pAlloc;
    if (s == NULL) { return; }
    free(s->pHist); free(s->pScratch); free(s);
}

/* Filter kernel: OpenAL Soft core/mixer/mixer_c.cpp, do_bsinc(). */
static inline float ma_bsinc_kernel(const ma_bsinc_resampler* s, const float* vals, uint32_t frac32, size_t stride, ma_uint32 c)
{
    const size_t m   = s->m;
    const unsigned pi = frac32 >> (32 - MA_BSINC_PHASE_BITS);
    const float pf   = (float)(frac32 & ((1u << (32 - MA_BSINC_PHASE_BITS)) - 1u)) * (1.0f / (float)(1u << (32 - MA_BSINC_PHASE_BITS)));
    const float* fil = s->pFilter + 2u * pi * m;
    const float* phd = fil + m;
    const float* scd = fil + MA_BSINC_PHASE_COUNT * 2u * m;
    const float* spd = scd + m;
    const float sf   = s->sf;
    float r = 0.0f;
    size_t j;
    for (j = 0; j < m; ++j) {
        r += (fil[j] + sf*scd[j] + pf*(phd[j] + sf*spd[j])) * vals[j*stride + c];
    }
    return r;
}

static ma_result ma_bsinc_process(void* pUserData, ma_resampling_backend* pBackend, const void* pIn, ma_uint64* pInCount, void* pOut, ma_uint64* pOutCount)
{
    ma_bsinc_resampler* s = (ma_bsinc_resampler*)pBackend;
    const ma_uint32 ch = s->channels;
    const size_t inFrames = pIn != NULL ? (size_t)*pInCount : 0;
    const size_t total = (size_t)MA_BSINC_PADDING + inFrames;
    const ma_uint64 outCap = *pOutCount;
    ma_uint64 produced = 0;
    size_t consumed, i;
    int64_t n;
    (void)pUserData;

    /* Build a contiguous float buffer: [history | new input]. */
    if (s->scratchFrames < total) {
        float* p = (float*)realloc(s->pScratch, total * ch * sizeof(float));
        if (p == NULL) { return MA_OUT_OF_MEMORY; }
        s->pScratch = p; s->scratchFrames = total;
    }
    memcpy(s->pScratch, s->pHist, (size_t)MA_BSINC_PADDING * ch * sizeof(float));
    if (s->format == ma_format_f32) {
        if (inFrames > 0) { memcpy(s->pScratch + (size_t)MA_BSINC_PADDING * ch, pIn, inFrames * ch * sizeof(float)); }
    } else {
        float* d = s->pScratch + (size_t)MA_BSINC_PADDING * ch;
        const ma_int16* src = (const ma_int16*)pIn;
        for (i = 0; i < inFrames * ch; ++i) { d[i] = src[i] * (1.0f / 32768.0f); }
    }

    while (produced < outCap) {
        n = (int64_t)(s->pos >> 32);
        if ((size_t)(n - (int64_t)s->l) + s->m > total) { break; }   /* need more input */

        {
            const float* vals = s->pScratch + (size_t)(n - (int64_t)s->l) * ch;
            const uint32_t frac32 = (uint32_t)(s->pos & 0xFFFFFFFFu);
            ma_uint32 c;
            for (c = 0; c < ch; ++c) {
                float r = ma_bsinc_kernel(s, vals, frac32, ch, c);
                if (pOut != NULL) {
                    if (s->format == ma_format_f32) {
                        ((float*)pOut)[produced * ch + c] = r;
                    } else {
                        float v = r * 32768.0f;
                        v = v > 32767.0f ? 32767.0f : (v < -32768.0f ? -32768.0f : v);
                        ((ma_int16*)pOut)[produced * ch + c] = (ma_int16)lrintf(v);
                    }
                }
            }
        }
        ++produced;
        s->pos += s->step;
    }

    /* Consume only as much input as the next output needs, then slide the history window. */
    n = (int64_t)(s->pos >> 32);
    {
        int64_t need = n - (int64_t)s->l + (int64_t)s->m - (int64_t)MA_BSINC_PADDING;
        if (need < 0) { need = 0; }
        consumed = (size_t)need > inFrames ? inFrames : (size_t)need;
    }
    if (consumed > 0) {
        memcpy(s->pHist, s->pScratch + consumed * ch, (size_t)MA_BSINC_PADDING * ch * sizeof(float));
        s->pos -= (uint64_t)consumed << 32;
    }

    *pInCount  = (ma_uint64)consumed;
    *pOutCount = produced;
    return MA_SUCCESS;
}

static ma_result ma_bsinc_set_rate(void* pUserData, ma_resampling_backend* pBackend, ma_uint32 rateIn, ma_uint32 rateOut)
{
    ma_bsinc_resampler* s = (ma_bsinc_resampler*)pBackend;
    (void)pUserData;
    if (rateIn == 0 || rateOut == 0) { return MA_INVALID_ARGS; }
    s->rateIn = rateIn; s->rateOut = rateOut;
    ma_bsinc_prepare(s);   /* O(1): the table is shared, so changing rate (e.g. pitch) is cheap. */
    return MA_SUCCESS;
}

static ma_uint64 ma_bsinc_get_input_latency(void* pUserData, const ma_resampling_backend* pBackend)
{
    (void)pUserData;
    return ((const ma_bsinc_resampler*)pBackend)->m / 2u;   /* look-ahead needed before the first output */
}

static ma_uint64 ma_bsinc_get_output_latency(void* pUserData, const ma_resampling_backend* pBackend)
{
    (void)pUserData; (void)pBackend;
    return 0;
}

static ma_result ma_bsinc_reset(void* pUserData, ma_resampling_backend* pBackend)
{
    ma_bsinc_resampler* s = (ma_bsinc_resampler*)pBackend;
    (void)pUserData;
    memset(s->pHist, 0, (size_t)MA_BSINC_PADDING * s->channels * sizeof(float));
    s->pos = (uint64_t)MA_BSINC_PADDING << 32;
    return MA_SUCCESS;
}

static ma_resampling_backend_vtable g_ma_bsinc24_resampling_vtable =
{
    ma_bsinc_get_heap_size, ma_bsinc_init, ma_bsinc_uninit, ma_bsinc_process, ma_bsinc_set_rate,
    ma_bsinc_get_input_latency, ma_bsinc_get_output_latency, ma_bsinc_reset
};

/* Drop-in replacement for ma_resampler_config_init(..., ma_resample_algorithm_linear). */
static inline ma_resampler_config ma_bsinc24_resampler_config_init(ma_format format, ma_uint32 channels, ma_uint32 sampleRateIn, ma_uint32 sampleRateOut)
{
    ma_resampler_config config = ma_resampler_config_init(format, channels, sampleRateIn, sampleRateOut, ma_resample_algorithm_custom);
    config.pBackendVTable   = &g_ma_bsinc24_resampling_vtable;
    config.pBackendUserData = NULL;
    return config;
}

#endif /* miniaudio_bsinc_h */
