#import "SDL_uikitaudiosession.h"
#import <TargetConditionals.h>
#import <Foundation/Foundation.h>
#import <AVFAudio/AVFAudio.h>

#if TARGET_OS_IOS
#include "SDL_internal.h"
#include "../../events/SDL_keyboard_c.h"
#import <UIKit/UIKit.h>

static id sAudioInterruptionObserver = nil;

static void SDL_AudioSession_NotifyFocusChange(bool focused)
{
	int count = 0;
	SDL_Window **windows = SDL_GetWindows(&count);
	if (windows == NULL) {
		return;
	}

	for (int i = 0; i < count; i++) {
		SDL_SetKeyboardFocus(focused ? windows[i] : NULL);
	}

	SDL_free(windows);
}

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

			if (type == AVAudioSessionInterruptionTypeBegan) {
				// iOS has already deactivated/stopped our audio unit for us.
				// Drop focus so lime's AudioManager state (and "active" flag)
				// stays in sync with reality.
				SDL_AudioSession_NotifyFocusChange(false);
			} else if (type == AVAudioSessionInterruptionTypeEnded) {
				NSNumber *optionsValue = notification.userInfo[AVAudioSessionInterruptionOptionKey];
				AVAudioSessionInterruptionOptions options =
					optionsValue ? (AVAudioSessionInterruptionOptions)optionsValue.unsignedIntegerValue : 0;

				if (options & AVAudioSessionInterruptionOptionShouldResume) {
					SDL_AudioSession_SetActive(true);
					SDL_AudioSession_NotifyFocusChange(true);
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
