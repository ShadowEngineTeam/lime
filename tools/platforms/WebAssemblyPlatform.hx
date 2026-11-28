package;

import hxp.HXML;
import hxp.Log;
import hxp.NDLL;
import hxp.Path;
import hxp.System;

import lime.tools.AssetHelper;
import lime.tools.CPPHelper;
import lime.tools.DeploymentHelper;
import lime.tools.HXProject;
import lime.tools.Icon;
import lime.tools.IconHelper;
import lime.tools.PlatformTarget;
import lime.tools.ProjectHelper;

import sys.FileSystem;
import sys.io.File;

class WebAssemblyPlatform extends PlatformTarget
{
	private static final FLAGS:Array<String> = ["-Dwebassembly", "-Dwasm", "-Demscripten", "-Dstatic_link"];

	private var applicationDirectory:String;
	private var outputFile:String;

	public function new(command:String, _project:HXProject, targetFlags:Map<String, String>)
	{
		super(command, _project, targetFlags);

		var defaults:HXProject = createDefaultProject();
		defaults.window.allowHighDPI = true;

		defaults.merge(project);

		project = defaults;

		targetDirectory = Path.combine(project.app.path, project.config.getString("webassembly.output-directory", "webassembly"));
		applicationDirectory = targetDirectory + "/bin/";
		outputFile = applicationDirectory + project.app.file + ".js";
	}

	public override function build():Void
	{
		var sdkPath:String = getSDKPath();

		if (sdkPath == null)
		{
			Log.error("You must define EMSDK with the path to your Emscripten SDK.");
			return;
		}

		project.path(sdkPath);
		project.path(Path.combine(sdkPath, "upstream/emscripten"));

		var hxml = targetDirectory + "/haxe/" + buildType + ".hxml";
		var haxeArgs:Array<String> = [hxml, "-D", "webassembly", "-D", "wasm", "-D", "emscripten", "-D", "static_link"];

		if (Log.verbose)
		{
			haxeArgs.push("-D");
			haxeArgs.push("verbose");
		}

		System.runCommand("", "haxe", haxeArgs);

		if (noOutput)
			return;

		var flags:Array<String> = FLAGS.concat(["-DEMSDK=" + sdkPath]);

		CPPHelper.compile(project, targetDirectory + "/obj", flags);
		CPPHelper.compile(project, targetDirectory + "/obj", flags, "BuildMain.xml");

		for (extension in [".js", ".wasm", ".wasm.map"])
		{
			var source = targetDirectory + "/obj/" + project.app.file + (project.debug ? "-debug" : "") + extension;

			if (FileSystem.exists(source))
			{
				System.copyFile(source, applicationDirectory + project.app.file + extension);
			}
		}
	}

	public override function deploy():Void
	{
		DeploymentHelper.deploy(project, targetFlags, targetDirectory, "WebAssembly");
	}

	public override function display():Void
	{
		if (project.targetFlags.exists("output-file"))
		{
			Sys.println(outputFile);
		}
		else
		{
			Sys.println(getDisplayHXML().toString());
		}
	}

	private override function getDisplayHXML():HXML
	{
		var path = targetDirectory + "/haxe/" + buildType + ".hxml";

		// try to use the existing .hxml file. however, if the project file was
		// modified more recently than the .hxml, then the .hxml cannot be
		// considered valid anymore. it may cause errors in editors like vscode.
		if (FileSystem.exists(path)
			&& (project.projectFilePath == null
				|| !FileSystem.exists(project.projectFilePath)
				|| (FileSystem.stat(path).mtime.getTime() > FileSystem.stat(project.projectFilePath).mtime.getTime())))
		{
			return File.getContent(path);
		}
		else
		{
			var context = project.templateContext;
			var hxml = HXML.fromString(context.HAXE_FLAGS);
			hxml.addClassName(context.APP_MAIN);
			hxml.cpp = "_";
			hxml.noOutput = true;
			return hxml;
		}
	}

	public override function rebuild():Void
	{
		var sdkPath:String = getSDKPath();
		var commands:Array<String> = FLAGS.copy();

		if (sdkPath != null)
		{
			commands.push("-DEMSDK=" + sdkPath);
		}

		CPPHelper.rebuild(project, [commands]);
	}

	public override function run():Void
	{
		var sdkPath:String = getSDKPath();

		if (sdkPath != null)
		{
			project.path(Path.combine(sdkPath, "upstream/emscripten"));
		}

		System.runCommand(applicationDirectory, "emrun", ["--port", Std.string(project.config.getInt("webassembly.port", 3000)), "index.html"]);
	}

	public override function update():Void
	{
		AssetHelper.processLibraries(project, targetDirectory);

		if (project.targetFlags.exists("xml"))
		{
			project.haxeflags.push("--xml " + targetDirectory + "/types.xml");
		}

		if (project.targetFlags.exists("json"))
		{
			project.haxeflags.push("--json " + targetDirectory + "/types.json");
		}

		var context = project.templateContext;

		context.OUTPUT_DIR = targetDirectory;
		context.CPP_DIR = targetDirectory + "/obj";
		context.WIN_BACKGROUND = StringTools.hex(project.window.background, 6);

		var contextNDLLs:Array<Dynamic> = context.ndlls;

		for (i in 0...project.ndlls.length)
		{
			contextNDLLs[i].path = NDLL.getLibraryPath(project.ndlls[i], "Emscripten", "lib", ".a", project.debug);
		}

		System.mkdir(targetDirectory);
		System.mkdir(targetDirectory + "/obj");
		System.mkdir(targetDirectory + "/haxe");
		System.mkdir(applicationDirectory);

		context.favicons = [];

		var icons = project.icons;

		if (icons.length == 0)
		{
			icons = [new Icon(System.findTemplate(project.templatePaths, "default/icon.svg"))];
		}

		if (IconHelper.createIcon(icons, 192, 192, Path.combine(applicationDirectory, "favicon.png")))
		{
			context.favicons.push({rel: "icon", type: "image/png", href: "./favicon.png"});
		}

		ProjectHelper.recursiveSmartCopyTemplate(project, "haxe", targetDirectory + "/haxe", context);
		ProjectHelper.recursiveSmartCopyTemplate(project, "cpp/hxml", targetDirectory + "/haxe", context);
		ProjectHelper.recursiveSmartCopyTemplate(project, "webassembly/cpp", targetDirectory + "/obj", context);
		ProjectHelper.recursiveSmartCopyTemplate(project, "webassembly/template", applicationDirectory, context);

		copyProjectAssets(applicationDirectory);
	}

	private function getSDKPath():String
	{
		if (project.defines.exists("EMSDK"))
		{
			return project.defines.get("EMSDK");
		}

		if (project.environment.exists("EMSDK"))
		{
			return project.environment.get("EMSDK");
		}

		return null;
	}

	public override function install():Void {}

	public override function trace():Void {}

	public override function uninstall():Void {}
}
