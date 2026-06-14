#import "SDL_uikitaudiosession.h"
#import <TargetConditionals.h>
#import <Foundation/Foundation.h>
#import <AVFAudio/AVFAudio.h>

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>

static id sAudioInterruptionObserver = nil;

static void SDL_AudioSession_RegisterInterruptionObserver(void)
{
	if (sAudioInterruptionObserver != nil) {
		return;
	}

	AVAudioSession *session = [AVAudioSession sharedInstance];

	sAudioInterruptionObserver =
		[[NSNotificationCenter defaultCenter] addObserverForName:AVAudioSessionInterruptionNotification
		                                                  object:session
		                                                   queue:[NSOperationQueue mainQueue]
		                                              usingBlock:^(NSNotification *notification) {
			NSNumber *typeValue = notification.userInfo[AVAudioSessionInterruptionTypeKey];
			if (typeValue == nil) {
				return;
			}

			AVAudioSessionInterruptionType type = (AVAudioSessionInterruptionType)typeValue.unsignedIntegerValue;

			// On Began iOS has already deactivated our session; nothing to do.
			// On Ended iOS does NOT reactivate for us, so re-focus the session
			// when the system says it is safe to resume.
			if (type == AVAudioSessionInterruptionTypeEnded) {
				NSNumber *optionsValue = notification.userInfo[AVAudioSessionInterruptionOptionKey];
				AVAudioSessionInterruptionOptions options =
					optionsValue ? (AVAudioSessionInterruptionOptions)optionsValue.unsignedIntegerValue : 0;

				if (options & AVAudioSessionInterruptionOptionShouldResume) {
					SDL_AudioSession_SetActive(true);
				}
			}
		}];
}
#endif

void SDL_AudioSession_Initialize(void)
{
    #if TARGET_OS_IOS
	AVAudioSession *session = [AVAudioSession sharedInstance];
	NSError *error = nil;

	[session setCategory:AVAudioSessionCategoryPlayback
	                mode:AVAudioSessionModeDefault
	             options:AVAudioSessionCategoryOptionAllowBluetoothA2DP
	               error:&error];

	if (@available(iOS 17.0, *)) {
		[session setPrefersInterruptionOnRouteDisconnect:NO error:nil];
	}

	if (@available(iOS 14.5, *)) {
		[session setPrefersNoInterruptionsFromSystemAlerts:YES error:nil];
	}

	if (error) {
		NSLog(@"Unable to set category of audio session: %@", error);
	} else {
		[session setActive:YES error:nil];
	}

	SDL_AudioSession_RegisterInterruptionObserver();
    #endif
}

void SDL_AudioSession_SetActive(bool active)
{
    #if TARGET_OS_IOS
	AVAudioSession *session = [AVAudioSession sharedInstance];
	NSError *error = nil;

	[session setActive:active error:&error];

	if (error) {
		NSLog(@"Unable to set active of audio session: %@", error);
	}
    #endif
}