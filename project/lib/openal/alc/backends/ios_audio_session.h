#pragma once

#ifdef __cplusplus
extern "C" {
#else
#include <stdbool.h>
#endif
void OpenAL_IOSAudioSessionInitialize(void);
void OpenAL_IOSAudioSessionSetActive(bool active);
void OpenAL_SetIOSAudioUnitActive(bool active);
#ifdef __cplusplus
}
#endif