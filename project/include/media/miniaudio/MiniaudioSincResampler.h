#ifndef LIME_MEDIA_MINIAUDIO_MINI_SINC_RESAMPLER_H
#define LIME_MEDIA_MINIAUDIO_MINI_SINC_RESAMPLER_H

#include <miniaudio.h>

namespace lime {

    // Sets *pConfig to a ma_resample_algorithm_custom config backed by a high-quality
    // bsinc24-style windowed-sinc resampler: Blackman-Harris window, 24 taps per side,
    // an interpolated polyphase table, and a rate-tracking anti-alias cutoff.
    // The format/channels/rates fields are left as the default (unknown/0) and get
    // resolved by the data converter before the backend is initialized.
    ma_result miniaudio_sinc_resampler_init_config(ma_resampler_config* pConfig);

}

#endif