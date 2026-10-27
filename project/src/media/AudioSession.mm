#import <AVFAudio/AVFAudio.h>
#include <media/ios_audio_session.h>

static id sInterruptionObserver = nil;

void Lime_IOSAudioSessionInitialize(void)
{
    NSError *error = nil;
    AVAudioSession *session = [AVAudioSession sharedInstance];

    [session setCategory:AVAudioSessionCategoryPlayback
                    mode:AVAudioSessionModeDefault
                 options:AVAudioSessionCategoryOptionAllowBluetoothA2DP
                   error:&error];
    if (error) { NSLog(@"Lime iOS session: setCategory failed: %@", error); error = nil; }

    // period_size=480 at 48kHz, like the old alconfig defaults
    [session setPreferredSampleRate:48000.0 error:&error];
    if (error) { NSLog(@"Lime iOS session: setPreferredSampleRate failed: %@", error); error = nil; }
    [session setPreferredIOBufferDuration:480.0/48000.0 error:&error];
    if (error) { NSLog(@"Lime iOS session: setPreferredIOBufferDuration failed: %@", error); error = nil; }

    if (@available(iOS 17.0, *))
        [session setPrefersInterruptionOnRouteDisconnect:NO error:nil];
    if (@available(iOS 14.5, *))
        [session setPrefersNoInterruptionsFromSystemAlerts:YES error:nil];

    [session setActive:YES error:&error];
    if (error) { NSLog(@"Lime iOS session: setActive failed: %@", error); }

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
                Lime_IOSAudioSessionSetActive(false);
            } else if (type == AVAudioSessionInterruptionTypeEnded) {
                NSNumber *optionsValue = notification.userInfo[AVAudioSessionInterruptionOptionKey];
                AVAudioSessionInterruptionOptions options =
                    optionsValue ? (AVAudioSessionInterruptionOptions)optionsValue.unsignedIntegerValue : 0;
                if (options & AVAudioSessionInterruptionOptionShouldResume)
                    Lime_IOSAudioSessionSetActive(true);
            }
        }];
    }
}

void Lime_IOSAudioSessionSetActive(bool active)
{
    NSError *error = nil;
    AVAudioSession *session = [AVAudioSession sharedInstance];

    if (active) {
        [session setActive:YES error:&error];
        if (error) { NSLog(@"Lime iOS session: setActive(YES) failed: %@", error); error = nil; }
        Lime_SetIOSAudioDeviceActive(true);   // starts the miniaudio device, from MiniAudioBindings.cpp
    } else {
        Lime_SetIOSAudioDeviceActive(false);  // stops the miniaudio device first
        [session setActive:NO
                withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation
                      error:&error];
        if (error) { NSLog(@"Lime iOS session: setActive(NO) failed: %@", error); }
    }
}
