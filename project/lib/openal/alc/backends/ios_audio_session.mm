#import <AVFAudio/AVFAudio.h>
#include "ios_audio_session.h"
#include "coreaudio.h"

static id sInterruptionObserver = nil;

void OpenAL_IOSAudioSessionInitialize(void)
{
    NSError *error = nil;
    AVAudioSession *session = [AVAudioSession sharedInstance];

    [session setCategory:AVAudioSessionCategoryPlayback
                    mode:AVAudioSessionModeDefault
                 options:AVAudioSessionCategoryOptionAllowBluetoothA2DP
                   error:&error];
    if (error) { NSLog(@"OpenAL iOS session: setCategory failed: %@", error); error = nil; }

    // Match alsoft.conf defaults: period_size=480.
    [session setPreferredSampleRate:48000.0 error:&error];
    if (error) { NSLog(@"OpenAL iOS session: setPreferredSampleRate failed: %@", error); error = nil; }
    [session setPreferredIOBufferDuration:480.0/48000.0 error:&error];
    if (error) { NSLog(@"OpenAL iOS session: setPreferredIOBufferDuration failed: %@", error); error = nil; }

    if (@available(iOS 17.0, *))
        [session setPrefersInterruptionOnRouteDisconnect:NO error:nil];
    if (@available(iOS 14.5, *))
        [session setPrefersNoInterruptionsFromSystemAlerts:YES error:nil];

    [session setActive:YES error:&error];
    if (error) { NSLog(@"OpenAL iOS session: setActive failed: %@", error); }

    if (sInterruptionObserver == nil) {
        sInterruptionObserver = [[NSNotificationCenter defaultCenter]
            addObserverForName:AVAudioSessionInterruptionNotification
                        object:session
                         queue:[NSOperationQueue mainQueue]
                    usingBlock:^(NSNotification *notification) {
            NSNumber *typeValue = notification.userInfo[AVAudioSessionInterruptionTypeKey];
            if (typeValue == nil) return;
            AVAudioSessionInterruptionType type = (AVAudioSessionInterruptionType)typeValue.unsignedIntegerValue;

            if (type == AVAudioSessionInterruptionTypeBegan) {
                OpenAL_IOSAudioSessionSetActive(false);
            } else if (type == AVAudioSessionInterruptionTypeEnded) {
                NSNumber *optionsValue = notification.userInfo[AVAudioSessionInterruptionOptionKey];
                AVAudioSessionInterruptionOptions options =
                    optionsValue ? (AVAudioSessionInterruptionOptions)optionsValue.unsignedIntegerValue : 0;
                if (options & AVAudioSessionInterruptionOptionShouldResume)
                    OpenAL_IOSAudioSessionSetActive(true);
            }
        }];
    }
}

void OpenAL_IOSAudioSessionSetActive(bool active)
{
    NSError *error = nil;
    AVAudioSession *session = [AVAudioSession sharedInstance];

    if (active) {
        [session setActive:YES error:&error];
        if (error) { NSLog(@"OpenAL iOS session: setActive(YES) failed: %@", error); error = nil; }
        OpenAL_SetIOSAudioUnitActive(true);   // starts the RemoteIO unit, from coreaudio.cpp
    } else {
        OpenAL_SetIOSAudioUnitActive(false);  // stops the RemoteIO unit first
        [session setActive:NO
                withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation
                      error:&error];
        if (error) { NSLog(@"OpenAL iOS session: setActive(NO) failed: %@", error); }
    }
}