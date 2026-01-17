#import "SDL_uikitaudiosession.h"
#import <TargetConditionals.h>
#import <Foundation/Foundation.h>
#import <AVFAudio/AVFAudio.h>

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
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
