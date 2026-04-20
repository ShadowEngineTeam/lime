#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#include <system/System.h>


namespace lime {


	char* System::GetDeviceModel () {

		struct utsname systemInfo;
		uname (&systemInfo);
		return strdup(systemInfo.machine);

	}


	char* System::GetDeviceVendor () {

		return strdup("Apple");

	}


	char* System::GetPlatformLabel () {

		return strdup("iOS");

	}


	char* System::GetPlatformName () {

		return strdup("iOS");

	}


	char* System::GetPlatformVersion () {

		NSString *version = [[UIDevice currentDevice] systemVersion];
		return strdup([version UTF8String]);

	}


}
