package lime._internal.backend.native;

#if (cpp && !macro && (android || ios) && HXCPP_PGO == "generate")
import haxe.io.Path;
import lime.system.System;
import sys.FileSystem;
#if android
import lime.system.JNI;
#end

/**
	`HXCPP_PGO=generate` on Android and iOS: the instrumented program cannot write its counts
	to the build machine, so they are written on the device, where `lime build` copies them
	back from before a `HXCPP_PGO=use` build.

	The system kills a mobile app in the background rather than letting it exit, which would lose
	the counts, so they are also written each time the app loses focus.
**/
@:cppFileCode('
#include <string.h>
extern "C" void __llvm_profile_set_filename(const char *);
extern "C" int __llvm_profile_write_file(void);
extern "C" void __llvm_profile_reset_counters(void);

#if defined(__aarch64__)
#define LIME_PGO_ABI "arm64-v8a"
#elif defined(__arm__)
#define LIME_PGO_ABI "armeabi-v7a"
#elif defined(__x86_64__)
#define LIME_PGO_ABI "x86_64"
#else
#define LIME_PGO_ABI "x86"
#endif
')
@:access(lime.system.System)
class NativePgo
{
	private static var started:Bool = false;

	public static function start():Void
	{
		if (started) return;
		started = true;

		var dir:String = getDirectory();
		if (dir == null) return;

		dir = Path.join([dir, "pgo", abi()]);
		try
		{
			FileSystem.createDirectory(dir);
		}
		catch (e:Dynamic)
		{
			trace("HXCPP_PGO: cannot create " + dir + ": " + e);
			return;
		}

		// %m merges the counts of every run of the same program into one file; the runtime keeps the
		// pointer rather than a copy, hence strdup
		var file:String = Path.join([dir, "default_%m.profraw"]);
		untyped __cpp__("__llvm_profile_set_filename(strdup({0}.utf8_str()))", file);
		trace("HXCPP_PGO: counts go to " + dir);
	}

	/** Writes the counts so far and starts counting again, so nothing is counted twice. **/
	public static function write():Void
	{
		if (!started) return;
		untyped __cpp__("if (__llvm_profile_write_file() == 0) __llvm_profile_reset_counters()");
	}

	private static function abi():String
	{
		#if ios
		return "";
		#else
		return untyped __cpp__("::String(LIME_PGO_ABI)");
		#end
	}

	private static function getDirectory():String
	{
		#if android
		// The app's folder in external storage: adb can read it from a release build
		try
		{
			var getContext:Dynamic = JNI.createStaticMethod("org/libsdl/app/SDLActivity", "getContext", "()Landroid/content/Context;");
			var getExternalFilesDir:Dynamic = JNI.createMemberMethod("android/content/Context", "getExternalFilesDir",
				"(Ljava/lang/String;)Ljava/io/File;");
			var getAbsolutePath:Dynamic = JNI.createMemberMethod("java/io/File", "getAbsolutePath", "()Ljava/lang/String;");
			return getAbsolutePath(getExternalFilesDir(getContext(), null));
		}
		catch (e:Dynamic)
		{
			trace("HXCPP_PGO: cannot find the app's external files folder: " + e);
			return null;
		}
		#else
		// Documents, which the build copies back with devicectl or simctl
		return System.documentsDirectory;
		#end
	}
}
#end
