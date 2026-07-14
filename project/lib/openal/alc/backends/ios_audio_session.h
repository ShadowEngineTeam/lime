#pragma once

#ifdef __cplusplus
extern "C" {
#endif
void OpenAL_IOSAudioSessionInitialize(void);
void OpenAL_IOSAudioSessionSetActive(bool active);
#ifdef __cplusplus
}
#endif