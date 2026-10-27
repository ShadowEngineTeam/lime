#pragma once

#ifdef __cplusplus
extern "C" {
#else
#include <stdbool.h>
#endif
void Lime_IOSAudioSessionInitialize(void);
void Lime_IOSAudioSessionSetActive(bool active);
void Lime_SetIOSAudioDeviceActive(bool active);
#ifdef __cplusplus
}
#endif
