#pragma once

// 24-tap band-limited (Kaiser-windowed sinc) resampler for miniaudio.
//
// Replaces OpenAL Soft's `resampler=bsinc24`, which miniaudio has no equivalent for (it only ships a
// linear resampler). Plugged in through miniaudio's `ma_resample_algorithm_custom` hook.
//
// Include AFTER <miniaudio.h>. Header-only, include from exactly one translation unit.
//
// Notes:
//  - Upsampling: 24 taps (12 per side), cutoff just below the input Nyquist.
//  - Downsampling: the kernel is widened (and the cutoff lowered) by the ratio so content above the
//    output Nyquist is filtered instead of aliased. Ratios above kMaxScale are clamped.
//  - Supports f32 and s16. State is kept per instance; the kernel table is rebuilt only when the rate
//    pair changes.
//  - Tunables are the constants below.

#include <math.h>
#include <stdlib.h>
#include <string.h>

namespace lime
{
	namespace bsinc
	{
		static const int kHalfTaps = 12;		 // 24 taps at 1:1
		static const int kPhases = 256;			 // fractional-position resolution (linearly interpolated)
		static const int kMaxScale = 8;			 // widest supported downsample ratio
		static const double kBeta = 6.0;		 // Kaiser beta (~60 dB stopband)
		static const double kCutoff = 0.90;		 // fraction of the limiting Nyquist kept in the passband

		struct State
		{
			ma_format format;
			ma_uint32 channels;
			ma_uint32 rateIn;
			ma_uint32 rateOut;
			int H;		 // half kernel width in input frames
			int L;		 // 2 * H
			double step; // input frames advanced per output frame
			double p;	 // read position inside [history | input]
			float *table; // (kPhases + 1) rows of L weights
			float *hist;  // L frames * channels
		};

		static double besselI0(double x)
		{
			double sum = 1.0, term = 1.0, q = x * x * 0.25;
			for (int k = 1; k < 40; ++k)
			{
				term *= q / ((double)k * (double)k);
				sum += term;
				if (term < sum * 1e-12)
					break;
			}
			return sum;
		}

		static void buildTable(State *s)
		{
			const double ratio = (double)s->rateIn / (double)s->rateOut;
			double scale = ratio > 1.0 ? ratio : 1.0;
			int H = (int)ceil(kHalfTaps * scale);
			if (H > kHalfTaps * kMaxScale)
				H = kHalfTaps * kMaxScale;

			const int L = H * 2;
			const bool resize = (H != s->H) || s->table == NULL;

			if (resize)
			{
				free(s->table);
				free(s->hist);
				s->table = (float *)malloc(sizeof(float) * (kPhases + 1) * L);
				s->hist = (float *)calloc((size_t)L * s->channels, sizeof(float));
				s->H = H;
				s->L = L;
				s->p = (double)L;
			}

			s->step = ratio;

			// cutoff in cycles per input sample
			const double fc = 0.5 * kCutoff * (ratio > 1.0 ? 1.0 / ratio : 1.0);
			const double i0beta = besselI0(kBeta);

			for (int ph = 0; ph <= kPhases; ++ph)
			{
				const double frac = (double)ph / (double)kPhases;
				float *row = s->table + (size_t)ph * L;
				double sum = 0.0;

				for (int j = 0; j < L; ++j)
				{
					const double x = frac + (double)(H - 1 - j);
					const double u = x / (double)H;
					double w = 0.0;

					if (fabs(u) < 1.0)
					{
						const double y = 2.0 * fc * x;
						const double sinc = fabs(y) < 1e-9 ? 1.0 : sin(M_PI * y) / (M_PI * y);
						w = 2.0 * fc * sinc * besselI0(kBeta * sqrt(1.0 - u * u)) / i0beta;
					}

					row[j] = (float)w;
					sum += w;
				}

				// unity DC gain for every phase
				if (sum != 0.0)
					for (int j = 0; j < L; ++j)
						row[j] = (float)(row[j] / sum);
			}
		}

		static ma_result onGetHeapSize(void *, const ma_resampler_config *, size_t *pHeapSize)
		{
			*pHeapSize = 0; // state is malloc'd (table size depends on the rate pair, which can change)
			return MA_SUCCESS;
		}

		static ma_result onInit(void *, const ma_resampler_config *cfg, void *, ma_resampling_backend **ppBackend)
		{
			if (cfg->format != ma_format_f32 && cfg->format != ma_format_s16)
				return MA_INVALID_ARGS;
			if (cfg->channels == 0 || cfg->sampleRateIn == 0 || cfg->sampleRateOut == 0)
				return MA_INVALID_ARGS;

			State *s = (State *)calloc(1, sizeof(State));
			if (!s)
				return MA_OUT_OF_MEMORY;

			s->format = cfg->format;
			s->channels = cfg->channels;
			s->rateIn = cfg->sampleRateIn;
			s->rateOut = cfg->sampleRateOut;
			buildTable(s);

			*ppBackend = s;
			return MA_SUCCESS;
		}

		static void onUninit(void *, ma_resampling_backend *b, const ma_allocation_callbacks *)
		{
			State *s = (State *)b;
			if (!s)
				return;
			free(s->table);
			free(s->hist);
			free(s);
		}

		static inline float readSample(const State *s, const void *in, long long idx, ma_uint32 c)
		{
			if (idx < s->L)
				return s->hist[(size_t)idx * s->channels + c];

			const size_t i = (size_t)(idx - s->L) * s->channels + c;
			if (s->format == ma_format_f32)
				return ((const float *)in)[i];
			return ((const ma_int16 *)in)[i] * (1.0f / 32768.0f);
		}

		static ma_result onProcess(void *, ma_resampling_backend *b, const void *pIn, ma_uint64 *pInCount, void *pOut, ma_uint64 *pOutCount)
		{
			State *s = (State *)b;
			const long long inCount = pIn ? (long long)*pInCount : 0;
			const ma_uint64 outCap = *pOutCount;
			const int H = s->H, L = s->L;
			const ma_uint32 ch = s->channels;

			ma_uint64 produced = 0;

			while (produced < outCap)
			{
				const long long n = (long long)floor(s->p);
				if (n + H + 1 > (long long)L + inCount)
					break; // need more input

				const double f = (s->p - (double)n) * kPhases;
				int ph = (int)f;
				if (ph >= kPhases)
					ph = kPhases - 1;
				const float a = (float)(f - ph);
				const float *r0 = s->table + (size_t)ph * L;
				const float *r1 = r0 + L;

				for (ma_uint32 c = 0; c < ch; ++c)
				{
					float acc = 0.0f;
					const long long base = n - H + 1;
					for (int j = 0; j < L; ++j)
						acc += (r0[j] + (r1[j] - r0[j]) * a) * readSample(s, pIn, base + j, c);

					if (pOut)
					{
						if (s->format == ma_format_f32)
							((float *)pOut)[produced * ch + c] = acc;
						else
						{
							float v = acc * 32768.0f;
							v = v > 32767.0f ? 32767.0f : (v < -32768.0f ? -32768.0f : v);
							((ma_int16 *)pOut)[produced * ch + c] = (ma_int16)lrintf(v);
						}
					}
				}

				++produced;
				s->p += s->step;
			}

			// consume only as much input as the next output needs, then slide the history window
			const long long n = (long long)floor(s->p);
			long long consumed = n + H + 1 - L;
			if (consumed < 0)
				consumed = 0;
			if (consumed > inCount)
				consumed = inCount;

			if (consumed > 0)
			{
				float *nh = (float *)malloc(sizeof(float) * (size_t)L * ch);
				if (!nh)
					return MA_OUT_OF_MEMORY;

				for (int i = 0; i < L; ++i)
					for (ma_uint32 c = 0; c < ch; ++c)
						nh[(size_t)i * ch + c] = readSample(s, pIn, (long long)i + consumed, c);

				free(s->hist);
				s->hist = nh;
				s->p -= (double)consumed;
			}

			*pInCount = (ma_uint64)consumed;
			*pOutCount = produced;
			return MA_SUCCESS;
		}

		static ma_result onSetRate(void *, ma_resampling_backend *b, ma_uint32 rateIn, ma_uint32 rateOut)
		{
			State *s = (State *)b;
			if (rateIn == 0 || rateOut == 0)
				return MA_INVALID_ARGS;
			if (rateIn == s->rateIn && rateOut == s->rateOut)
				return MA_SUCCESS;
			s->rateIn = rateIn;
			s->rateOut = rateOut;
			buildTable(s);
			return MA_SUCCESS;
		}

		static ma_uint64 onGetInputLatency(void *, const ma_resampling_backend *b)
		{
			return (ma_uint64)((const State *)b)->H;
		}

		static ma_uint64 onGetOutputLatency(void *, const ma_resampling_backend *b)
		{
			const State *s = (const State *)b;
			return (ma_uint64)((double)s->H / s->step);
		}

		static ma_result onReset(void *, ma_resampling_backend *b)
		{
			State *s = (State *)b;
			memset(s->hist, 0, sizeof(float) * (size_t)s->L * s->channels);
			s->p = (double)s->L;
			return MA_SUCCESS;
		}

		static ma_resampling_backend_vtable vtable = {
			onGetHeapSize, onInit, onUninit, onProcess, onSetRate,
			onGetInputLatency, onGetOutputLatency, onReset};

		// Drop-in replacement for ma_resampler_config_init(..., ma_resample_algorithm_linear).
		static inline ma_resampler_config config(ma_format format = ma_format_unknown, ma_uint32 channels = 0, ma_uint32 rateIn = 0, ma_uint32 rateOut = 0)
		{
			ma_resampler_config c = ma_resampler_config_init(format, channels, rateIn, rateOut, ma_resample_algorithm_custom);
			c.pBackendVTable = &vtable;
			c.pBackendUserData = NULL;
			return c;
		}
	}
}
