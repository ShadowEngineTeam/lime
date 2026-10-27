/*
 * Output limiter for miniaudio, backported from OpenAL Soft (`output-limiter = true`).
 *
 * Derived from OpenAL Soft's core/mastering.cpp (Compressor) and alc/alc.cpp (CreateDeviceLimiter).
 *   OpenAL cross platform audio library, Copyright (C) 1999-2007 by authors.
 *   Licensed under the GNU Library General Public License, version 2 or later (LGPL-2.0+).
 * This file is therefore LGPL-2.0+, unlike the rest of miniaudio (public domain / MIT-0).
 * See extras/resamplers/bsinc/COPYING for the license text.
 *
 * A feed-forward, look-ahead compressor in the log domain with automated knee, attack, release,
 * make-up gain and clipping reduction, configured as a limiter exactly like OpenAL Soft's device
 * limiter: 1ms look-ahead, 2ms hold, 0dB threshold (f32 output), infinite ratio, 20ms attack and
 * 200ms release (both automated).
 *
 * Usage (include after miniaudio.h, from exactly one translation unit):
 *
 *     ma_mastering_limiter *limiter = ma_mastering_limiter_create(channels, sampleRate, 0.0f);
 *     ma_mastering_limiter_process(limiter, pFramesInterleavedF32, frameCount);
 *     ma_mastering_limiter_destroy(limiter);
 */
#ifndef miniaudio_mastering_h
#define miniaudio_mastering_h

#include <math.h>
#include <stdlib.h>
#include <string.h>

#define MA_MASTERING_LINE_SIZE 1024u

typedef struct
{
	float values[MA_MASTERING_LINE_SIZE];
	unsigned int expiries[MA_MASTERING_LINE_SIZE];
	unsigned int lowerIndex;
	unsigned int upperIndex;
	unsigned int length;
} ma_mastering_sliding_hold;

typedef struct
{
	unsigned int channels;
	unsigned int lookAhead;
	int autoKnee, autoAttack, autoRelease, autoPostGain, autoDeclip;
	float preGain;
	float postGain;
	float threshold;
	float slope;
	float knee;
	float attack;
	float release;
	float sideChain[MA_MASTERING_LINE_SIZE * 2];
	float crestFactor[MA_MASTERING_LINE_SIZE];
	ma_mastering_sliding_hold *hold;
	float *delay; /* channels * MA_MASTERING_LINE_SIZE, NULL without look-ahead */
	float *lines; /* channels * MA_MASTERING_LINE_SIZE, deinterleaved scratch */
	float crestCoeff;
	float gainEstimate;
	float adaptCoeff;
	float lastPeakSq;
	float lastRmsSq;
	float lastRelease;
	float lastAttack;
	float lastGainDev;
} ma_mastering_limiter;

static inline float ma_mastering_lerpf(float a, float b, float mu)
{
	return a + (b - a) * mu;
}

static inline float ma_mastering_clampf(float v, float lo, float hi)
{
	return v < lo ? lo : (v > hi ? hi : v);
}

/* Sliding window maximum (descending maxima), based on Richard Harter's ascending minima algorithm. */
static float ma_mastering_update_sliding_hold(ma_mastering_sliding_hold *hold, unsigned int i, float in)
{
	const unsigned int mask = MA_MASTERING_LINE_SIZE - 1;
	unsigned int lowerIndex = hold->lowerIndex;
	unsigned int upperIndex = hold->upperIndex;

	if (i >= hold->expiries[upperIndex])
		upperIndex = (upperIndex + 1) & mask;

	if (in >= hold->values[upperIndex])
	{
		hold->values[upperIndex] = in;
		hold->expiries[upperIndex] = i + hold->length;
		lowerIndex = upperIndex;
	}
	else
	{
		for (;;)
		{
			int found = 0;

			do
			{
				if (!(in >= hold->values[lowerIndex]))
				{
					found = 1;
					break;
				}
			} while (lowerIndex--);

			if (found)
				break;

			lowerIndex = mask;
		}

		lowerIndex = (lowerIndex + 1) & mask;
		hold->values[lowerIndex] = in;
		hold->expiries[lowerIndex] = i + hold->length;
	}

	hold->lowerIndex = lowerIndex;
	hold->upperIndex = upperIndex;

	return hold->values[upperIndex];
}

static void ma_mastering_shift_sliding_hold(ma_mastering_sliding_hold *hold, unsigned int n)
{
	unsigned int i;

	if (hold->lowerIndex < hold->upperIndex)
	{
		for (i = 0; i <= hold->lowerIndex; ++i)
			hold->expiries[i] -= n;
		for (i = hold->upperIndex; i < MA_MASTERING_LINE_SIZE; ++i)
			hold->expiries[i] -= n;
	}
	else
	{
		for (i = hold->upperIndex; i <= hold->lowerIndex; ++i)
			hold->expiries[i] -= n;
	}
}

static inline void ma_mastering_limiter_destroy(ma_mastering_limiter *comp)
{
	if (comp == NULL)
		return;

	free(comp->hold);
	free(comp->delay);
	free(comp->lines);
	free(comp);
}

/* OpenAL Soft's CreateDeviceLimiter() + Compressor::Create(). thresholdDb is 0 for f32 output. */
static inline ma_mastering_limiter *ma_mastering_limiter_create(unsigned int channels, unsigned int sampleRate, float thresholdDb)
{
	const float lookAheadTime = 0.001f;
	const float holdTime = 0.002f;
	const float preGainDb = 0.0f;
	const float postGainDb = 0.0f;
	const float kneeDb = 0.0f;
	const float attackTime = 0.02f;
	const float releaseTime = 0.2f;
	const float rate = (float)sampleRate;
	unsigned int lookAhead, holdLen;
	ma_mastering_limiter *comp;

	if (channels == 0 || sampleRate == 0)
		return NULL;

	lookAhead = (unsigned int)ma_mastering_clampf(roundf(lookAheadTime * rate), 0.0f, (float)(MA_MASTERING_LINE_SIZE - 1));
	holdLen = (unsigned int)ma_mastering_clampf(roundf(holdTime * rate), 0.0f, (float)(MA_MASTERING_LINE_SIZE - 1));

	comp = (ma_mastering_limiter *)calloc(1, sizeof(ma_mastering_limiter));
	if (comp == NULL)
		return NULL;

	comp->channels = channels;
	comp->autoKnee = 1;
	comp->autoAttack = 1;
	comp->autoRelease = 1;
	comp->autoPostGain = 1;
	comp->autoDeclip = 1;
	comp->lookAhead = lookAhead;
	comp->preGain = powf(10.0f, preGainDb / 20.0f);
	comp->postGain = (float)(log(10.0) / 20.0 * postGainDb);
	comp->threshold = (float)(log(10.0) / 20.0 * thresholdDb);
	comp->knee = (float)fmax(0.0, log(10.0) / 20.0 * kneeDb);
	comp->attack = fmaxf(1.0f, attackTime * rate);
	comp->release = fmaxf(1.0f, releaseTime * rate);

	/* Knee width automation treats the compressor as a limiter. */
	comp->slope = -1.0f;

	if (lookAhead > 0)
	{
		/* A 1-sample hold is useless, and the sliding hold doesn't handle it. */
		if (holdLen > 1)
		{
			comp->hold = (ma_mastering_sliding_hold *)calloc(1, sizeof(ma_mastering_sliding_hold));
			if (comp->hold == NULL)
				goto fail;

			comp->hold->values[0] = -INFINITY;
			comp->hold->expiries[0] = holdLen;
			comp->hold->length = holdLen;
		}

		comp->delay = (float *)calloc((size_t)channels * MA_MASTERING_LINE_SIZE, sizeof(float));
		if (comp->delay == NULL)
			goto fail;
	}

	comp->lines = (float *)calloc((size_t)channels * MA_MASTERING_LINE_SIZE, sizeof(float));
	if (comp->lines == NULL)
		goto fail;

	comp->crestCoeff = expf(-1.0f / (0.200f * rate)); // 200ms
	comp->gainEstimate = comp->threshold * -0.5f * comp->slope;
	comp->adaptCoeff = expf(-1.0f / (2.0f * rate)); // 2s

	return comp;

fail:
	ma_mastering_limiter_destroy(comp);
	return NULL;
}

static void ma_mastering_gain_compressor(ma_mastering_limiter *comp, unsigned int samplesToDo)
{
	const float threshold = comp->threshold;
	const float slope = comp->slope;
	const float attack = comp->attack;
	const float release = comp->release;
	const float c_est = comp->gainEstimate;
	const float a_adp = comp->adaptCoeff;
	float postGain = comp->postGain;
	float knee = comp->knee;
	float t_att = attack;
	float t_rel = release - attack;
	float a_att = expf(-1.0f / t_att);
	float a_rel = expf(-1.0f / t_rel);
	float y_1 = comp->lastRelease;
	float y_L = comp->lastAttack;
	float c_dev = comp->lastGainDev;
	unsigned int i;

	for (i = 0; i < samplesToDo; ++i)
	{
		const float input = comp->sideChain[i];
		const float lookAhead = comp->sideChain[i + comp->lookAhead];
		float knee_h, x_over, y_G, y2_crest, x_L;

		if (comp->autoKnee)
			knee = fmaxf(0.0f, 2.5f * (c_dev + c_est));
		knee_h = 0.5f * knee;

		/* Static compression curve. */
		x_over = lookAhead - threshold;
		y_G = (x_over <= -knee_h) ? 0.0f
			: (fabsf(x_over) < knee_h) ? (x_over + knee_h) * (x_over + knee_h) / (2.0f * knee)
			: x_over;

		y2_crest = comp->crestFactor[i];
		if (comp->autoAttack)
		{
			t_att = 2.0f * attack / y2_crest;
			a_att = expf(-1.0f / t_att);
		}
		if (comp->autoRelease)
		{
			t_rel = 2.0f * release / y2_crest - t_att;
			a_rel = expf(-1.0f / t_rel);
		}

		/* Smooth decoupled peak detector. */
		x_L = -slope * y_G;
		y_1 = fmaxf(x_L, ma_mastering_lerpf(x_L, y_1, a_rel));
		y_L = ma_mastering_lerpf(y_1, y_L, a_att);

		c_dev = ma_mastering_lerpf(-(y_L + c_est), c_dev, a_adp);

		if (comp->autoPostGain)
		{
			if (comp->autoDeclip)
				c_dev = fmaxf(c_dev, input - y_L - threshold - c_est);

			postGain = -(c_dev + c_est);
		}

		comp->sideChain[i] = expf(postGain - y_L);
	}

	comp->lastRelease = y_1;
	comp->lastAttack = y_L;
	comp->lastGainDev = c_dev;
}

/* Compressor::process() on comp->lines (channels x samplesToDo, samplesToDo <= MA_MASTERING_LINE_SIZE). */
static void ma_mastering_process_lines(ma_mastering_limiter *comp, unsigned int samplesToDo)
{
	float *sideChain = comp->sideChain + comp->lookAhead;
	unsigned int c, i;

	if (comp->preGain != 1.0f)
	{
		for (c = 0; c < comp->channels; ++c)
			for (i = 0; i < samplesToDo; ++i)
				comp->lines[c * MA_MASTERING_LINE_SIZE + i] *= comp->preGain;
	}

	/* Multichannel compression is linked via the absolute maximum of all channels. */
	memset(sideChain, 0, samplesToDo * sizeof(float));
	for (c = 0; c < comp->channels; ++c)
	{
		const float *line = comp->lines + c * MA_MASTERING_LINE_SIZE;

		for (i = 0; i < samplesToDo; ++i)
			sideChain[i] = fmaxf(sideChain[i], fabsf(line[i]));
	}

	if (comp->autoAttack || comp->autoRelease)
	{
		/* Squared crest factor: instantaneous squared peak and squared RMS, both 200ms release. */
		const float a_crest = comp->crestCoeff;
		float y2_peak = comp->lastPeakSq;
		float y2_rms = comp->lastRmsSq;

		for (i = 0; i < samplesToDo; ++i)
		{
			const float x2 = ma_mastering_clampf(sideChain[i] * sideChain[i], 0.000001f, 1000000.0f);

			y2_peak = fmaxf(x2, ma_mastering_lerpf(x2, y2_peak, a_crest));
			y2_rms = ma_mastering_lerpf(x2, y2_rms, a_crest);
			comp->crestFactor[i] = y2_peak / y2_rms;
		}

		comp->lastPeakSq = y2_peak;
		comp->lastRmsSq = y2_rms;
	}

	if (comp->hold != NULL)
	{
		for (i = 0; i < samplesToDo; ++i)
			sideChain[i] = ma_mastering_update_sliding_hold(comp->hold, i, logf(fmaxf(0.000001f, sideChain[i])));
		ma_mastering_shift_sliding_hold(comp->hold, samplesToDo);
	}
	else
	{
		for (i = 0; i < samplesToDo; ++i)
			sideChain[i] = logf(fmaxf(0.000001f, sideChain[i]));
	}

	ma_mastering_gain_compressor(comp, samplesToDo);

	if (comp->delay != NULL)
	{
		/* Look-ahead delay: output = previous tail + current head, keep the current tail. */
		const unsigned int lookAhead = comp->lookAhead;
		float tmp[MA_MASTERING_LINE_SIZE];

		for (c = 0; c < comp->channels; ++c)
		{
			float *line = comp->lines + c * MA_MASTERING_LINE_SIZE;
			float *delay = comp->delay + c * MA_MASTERING_LINE_SIZE;

			if (samplesToDo >= lookAhead)
			{
				memcpy(tmp, line + samplesToDo - lookAhead, lookAhead * sizeof(float));
				memmove(line + lookAhead, line, (samplesToDo - lookAhead) * sizeof(float));
				memcpy(line, delay, lookAhead * sizeof(float));
				memcpy(delay, tmp, lookAhead * sizeof(float));
			}
			else
			{
				memcpy(tmp, delay, lookAhead * sizeof(float));
				memcpy(delay, tmp + samplesToDo, (lookAhead - samplesToDo) * sizeof(float));
				memcpy(delay + lookAhead - samplesToDo, line, samplesToDo * sizeof(float));
				memcpy(line, tmp, samplesToDo * sizeof(float));
			}
		}
	}

	for (c = 0; c < comp->channels; ++c)
	{
		float *line = comp->lines + c * MA_MASTERING_LINE_SIZE;

		for (i = 0; i < samplesToDo; ++i)
			line[i] *= comp->sideChain[i];
	}

	memmove(comp->sideChain, comp->sideChain + samplesToDo, comp->lookAhead * sizeof(float));
}

/* Limits interleaved f32 frames in place. Safe to call from the audio thread (no allocations). */
static inline void ma_mastering_limiter_process(ma_mastering_limiter *comp, float *pFrames, ma_uint64 frameCount)
{
	const unsigned int channels = comp->channels;

	while (frameCount > 0)
	{
		const unsigned int todo = frameCount > MA_MASTERING_LINE_SIZE ? MA_MASTERING_LINE_SIZE : (unsigned int)frameCount;
		unsigned int c, i;

		for (i = 0; i < todo; ++i)
			for (c = 0; c < channels; ++c)
				comp->lines[c * MA_MASTERING_LINE_SIZE + i] = pFrames[i * channels + c];

		ma_mastering_process_lines(comp, todo);

		for (i = 0; i < todo; ++i)
			for (c = 0; c < channels; ++c)
				pFrames[i * channels + c] = comp->lines[c * MA_MASTERING_LINE_SIZE + i];

		pFrames += (size_t)todo * channels;
		frameCount -= todo;
	}
}

#endif
