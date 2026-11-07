package lime.tools;

import hxp.Log;
import hxp.Path;
import hxp.System;
import sys.FileSystem;

/**
	`-D HXCPP_PGO=generate|use` for lime builds: hxcpp builds the program from the counts of its
	own runs, and this moves those counts between where the program writes them and where hxcpp
	reads them.

	- Windows: MSVC writes `*.pgc` beside the program in `bin/`, hxcpp reads them from `obj/`.
	- Linux and macOS: the counts go straight to `obj/pgo`; nothing to do.
	- Android: the program writes to its external files folder, `pgo/<abi>`, read back with adb
	  into `obj/pgo/<abi>`, one set per architecture.
	- iOS: the program writes to its Documents folder, `pgo`, read back with devicectl (device)
	  or simctl (simulator) into the build folder of that architecture.
**/
class PgoHelper
{
	/** "generate", "use" or null. A debug build ignores it, as hxcpp does. **/
	public static function getMode(project:HXProject):String
	{
		if (project.debug) return null;
		var mode:String = project.haxedefs.get("HXCPP_PGO");
		if (mode == null) mode = project.environment.get("HXCPP_PGO");
		return (mode == "generate" || mode == "use") ? mode : null;
	}

	public static function androidDeviceDirectory(project:HXProject):String
	{
		return "/sdcard/Android/data/" + project.meta.packageName + "/files/pgo";
	}

	/** Before a use build: copies the counts from the device into `obj/pgo/<abi>`. **/
	public static function pullAndroid(project:HXProject, deviceID:String, objDirectory:String):Void
	{
		var temp:String = Path.combine(objDirectory, "pgo-device");
		if (FileSystem.exists(temp)) System.removeDirectory(temp);
		System.mkdir(temp);

		if (!AndroidHelper.adb(deviceID, ["pull", androidDeviceDirectory(project) + "/.", temp]))
		{
			Log.warn("HXCPP_PGO: could not read the counts from the device; using the ones already in " + Path.combine(objDirectory, "pgo"));
			return;
		}

		var count:Int = 0;
		for (abi in FileSystem.readDirectory(temp))
		{
			if (FileSystem.isDirectory(Path.combine(temp, abi)))
				count += collect(Path.combine(temp, abi), Path.combine(objDirectory, "pgo/" + abi));
		}
		System.removeDirectory(temp);
		Log.info("", " - \x1b[1mPGO:\x1b[0m copied " + count + " count file(s) from the device");
	}

	/** After a generate build is installed: counts from an earlier build no longer fit. **/
	public static function clearAndroid(project:HXProject, deviceID:String):Void
	{
		AndroidHelper.adb(deviceID, ["shell", "rm", "-rf", androidDeviceDirectory(project)]);
	}

	/**
		Before a use build: copies the counts from the device or the simulator into the hxcpp
		build folder of that architecture, `<app>/haxe/build/Release-iphoneos-arm64/pgo` and so on.
	**/
	public static function pullIOS(project:HXProject, targetDirectory:String):Void
	{
		var buildDirectory:String = Path.combine(targetDirectory, project.app.file + "/haxe/build");
		var temp:String = Path.combine(targetDirectory, "pgo-device");
		if (FileSystem.exists(temp)) System.removeDirectory(temp);
		System.mkdir(temp);

		var dest:String;
		if (project.targetFlags.exists("simulator"))
		{
			var simulator:String = XCodeHelper.getSimulatorID(project);
			var container:String = simulator == null ? null : StringTools.trim(System.runProcess("", "xcrun",
				["simctl", "get_app_container", simulator, project.meta.packageName, "data"], true, true, true));
			if (container == null || container == "" || !FileSystem.exists(container + "/Documents/pgo"))
			{
				Log.warn("HXCPP_PGO: no counts in the simulator; run the generate build there first");
				return;
			}
			collect(container + "/Documents/pgo", temp);
			var arch:String = System.hostArchitecture == ARM64 ? "arm64-sim" : "x64";
			dest = Path.combine(buildDirectory, "Release-iphonesim-" + arch + "/pgo");
		}
		else
		{
			var device:String = IOSHelper.findDeviceUUIDWithFilters(["Platform == 'iOS'", "State == 'connected'"]);
			if (device == null || device == "")
				device = IOSHelper.findDeviceUUIDWithFilters(["Platform == 'iOS'", "State == 'available (paired)'"]);
			if (device == null || device == "")
			{
				Log.warn("HXCPP_PGO: no iOS device found to read the counts from");
				return;
			}
			var code:Int = System.runCommand("", "xcrun", [
				"devicectl", "device", "copy", "from",
				"--device", StringTools.trim(device),
				"--domain-type", "appDataContainer",
				"--domain-identifier", project.meta.packageName,
				"--source", "Documents/pgo",
				"--destination", temp
			], true, true);
			if (code != 0)
			{
				Log.warn("HXCPP_PGO: could not read the counts from the device");
				return;
			}
			dest = Path.combine(buildDirectory, "Release-iphoneos-arm64/pgo");
		}

		var count:Int = collect(temp, dest);
		System.removeDirectory(temp);
		Log.info("", " - \x1b[1mPGO:\x1b[0m copied " + count + " count file(s) to " + dest);
	}

	/**
		Copies every `.profraw` below `from` into `to`, keeping the names: the program merges each
		run into the same file, so a newer copy replaces the older one.
	**/
	private static function collect(from:String, to:String):Int
	{
		var count:Int = 0;
		if (!FileSystem.exists(from)) return 0;
		for (name in FileSystem.readDirectory(from))
		{
			var path:String = Path.combine(from, name);
			if (FileSystem.isDirectory(path))
			{
				count += collect(path, to);
			}
			else if (StringTools.endsWith(name, ".profraw"))
			{
				System.mkdir(to);
				System.copyFile(path, Path.combine(to, name));
				count++;
			}
		}
		return count;
	}
}
