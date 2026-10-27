#include <media/AudioSession.h>

#import <TargetConditionals.h>
#import <Foundation/Foundation.h>
#import <AVFAudio/AVFAudio.h>


namespace lime {


	// Ported from FunkinCrew/Funkin source/funkin/external/apple/project/src/AudioSession.mm
	void AudioSession_Initialize () {

		#if TARGET_OS_IOS
		AVAudioSession *session = [AVAudioSession sharedInstance];

		NSError *error = nil;

		[session setCategory:AVAudioSessionCategoryPlayback mode:AVAudioSessionModeDefault options:AVAudioSessionCategoryOptionAllowBluetoothA2DP error:&error];

		if (@available(iOS 17.0, *)) {

			[session setPrefersInterruptionOnRouteDisconnect:false error:nil];

		}

		if (@available(iOS 14.5, *)) {

			[session setPrefersNoInterruptionsFromSystemAlerts:true error:nil];

		}

		if (error)
			NSLog(@"Unable to set category of audio session: %@", error);
		else
			[session setActive:YES error:nil];
		#endif

	}


	void AudioSession_SetActive (bool active) {

		#if TARGET_OS_IOS
		AVAudioSession *session = [AVAudioSession sharedInstance];

		NSError *error = nil;

		[session setActive:active error:&error];

		if (error)
			NSLog(@"Unable to set active of audio session: %@", error);
		#endif

	}


}
