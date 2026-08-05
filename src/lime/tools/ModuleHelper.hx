package lime.tools;

#if !macro
import hxp.*;

import lime.tools.Dependency;
import lime.tools.HXProject;
import lime.tools.ModuleData;

import sys.io.File;
import sys.FileSystem;

class ModuleHelper
{
	public static function addModuleSource(source:String, moduleData:ModuleData, include:Array<String>, exclude:Array<String>, packageName:String = null)
	{
		if (!FileSystem.exists(source))
		{
			Log.error("Could not find module source \"" + source + "\"");
			return;
		}

		moduleData.haxeflags.push("-cp " + source);

		var path = source;

		if (packageName != null && packageName.length > 0)
		{
			path = Path.combine(source, StringTools.replace(packageName, ".", "/"));
		}

		parseModuleSource(source, moduleData, include, exclude, path);
	}

	public static function buildModules(project:HXProject, tempDirectory:String, outputDirectory:String):Void
	{
		tempDirectory = Path.combine(tempDirectory, "lib");
		outputDirectory = Path.combine(outputDirectory, "lib");

		System.mkdir(tempDirectory);
		System.mkdir(outputDirectory);

		var importName:String;
		var hxmlPath:String;
		var importPath:String;
		var outputPath:String;
		var moduleImport:String;
		var hxml:String;

		for (module in project.modules)
		{
			if (module.classNames.length > 0)
			{
				importName = "Module" + module.name.charAt(0).toUpperCase() + module.name.substr(1);

				hxmlPath = Path.combine(tempDirectory, module.name + ".hxml");
				importPath = Path.combine(tempDirectory, importName + ".hx");

				outputPath = Path.combine(outputDirectory, module.name);

				moduleImport = "package;\n\nimport " + module.classNames.join(";\nimport ") + ";";

				hxml = "-cp " + tempDirectory;
				hxml += "\n" + module.haxeflags.join("\n");

				for (haxelib in project.haxelibs)
				{
					hxml += "\n-cp " + Haxelib.getPath(haxelib);
				}

				for (key in project.haxedefs.keys())
				{
					if (key != "no-compilation")
					{
						var value = project.haxedefs.get(key);

						if (value == null || value == "")
						{
							hxml += "\n-D " + key;
						}
						else
						{
							hxml += "\n-D " + key + "=" + value;
						}
					}
				}

				hxml += "\n-D html";
				hxml += "\n--no-inline";
				hxml += "\n-dce no";
				var includeTypes = module.classNames.concat(module.includeTypes);
				var excludeTypes = module.excludeTypes;

				for (otherModule in project.modules)
				{
					if (otherModule != module)
					{
						excludeTypes = excludeTypes.concat(ArrayTools.getUnique(includeTypes, otherModule.classNames));
						excludeTypes = excludeTypes.concat(ArrayTools.getUnique(includeTypes, otherModule.includeTypes));
					}
				}

				if (excludeTypes.length > 0)
				{
					// order by short filters first, so they match earlier
					haxe.ds.ArraySort.sort(excludeTypes, shortFirst);
					hxml += "\n--macro lime.tools.ModuleHelper.exclude(['" + excludeTypes.join("','") + "'])";
				}

				// order by short filters first, so they match earlier
				haxe.ds.ArraySort.sort(includeTypes, shortFirst);
				hxml += "\n--macro lime.tools.ModuleHelper.expose(['" + includeTypes.join("','") + "'])";
				// hxml += "\n--macro lime.tools.ModuleHelper.generate()";

				hxml += "\n" + importName;

				File.saveContent(importPath, moduleImport);
				File.saveContent(hxmlPath, hxml);

				System.runCommand("", "haxe", [hxmlPath]);

				patchFile(outputPath);
			}
		}
	}

	private static function parseModuleSource(source:String, moduleData:ModuleData, include:Array<String>, exclude:Array<String>, currentPath:String):Void
	{
		var files = FileSystem.readDirectory(currentPath);
		var filePath:String, className:String, packageName:String;

		for (file in files)
		{
			filePath = Path.combine(currentPath, file);

			if (FileSystem.isDirectory(filePath))
			{
				packageName = StringTools.replace(filePath, source, "");
				packageName = StringTools.replace(packageName, "\\", "/");

				while (StringTools.startsWith(packageName, "/"))
					packageName = packageName.substr(1);

				packageName = StringTools.replace(packageName, "/", ".");

				if (StringTools.filter(packageName, include, exclude))
				{
					parseModuleSource(source, moduleData, include, exclude, filePath);
				}
			}
			else
			{
				if (Path.extension(file) != "hx")
					continue;

				className = StringTools.replace(filePath, source, "");
				className = StringTools.replace(className, "\\", "/");

				while (StringTools.startsWith(className, "/"))
					className = className.substr(1);

				className = StringTools.replace(className, "/", ".");
				className = StringTools.replace(className, ".hx", "");

				if (StringTools.filter(className, include, exclude))
				{
					moduleData.classNames.push(className);
				}
			}
		}
	}

	public static function patchFile(outputPath:String):Void
	{
		var replaceString = "var $hxClasses = {}";
		var replacement = "if (!$hx_exports.$hxClasses) $hx_exports.$hxClasses = {};\nvar $hxClasses = $hx_exports.$hxClasses";

		System.replaceText(outputPath, replaceString, replacement);
	}

	public static function updateProject(project:HXProject):Void
	{
		var excludeTypes = [];
		var suffix = "";
		var hasModules = false;

		for (module in project.modules)
		{
			project.dependencies.push(new Dependency("./lib/" + module.name + suffix, null));

			excludeTypes = ArrayTools.concatUnique(excludeTypes, module.classNames);
			excludeTypes = ArrayTools.concatUnique(excludeTypes, module.excludeTypes);
			excludeTypes = ArrayTools.concatUnique(excludeTypes, module.includeTypes);

			hasModules = true;
		}

		if (excludeTypes.length > 0)
		{
			// order by short filters first, so they match earlier
			haxe.ds.ArraySort.sort(excludeTypes, shortFirst);
			project.haxeflags.push("--macro lime.tools.ModuleHelper.exclude(['" + excludeTypes.join("','") + "'])");
		}

		// if (hasModules) {
		//
		// project.haxeflags.push ("--macro lime.tools.ModuleHelper.generate()");
		//
		// }
	}

	public static function shortFirst(a, b):Int
	{
		if (a.length < b.length)
			return -1;
		else if (a.length > b.length)
			return 1;
		return 0;
	}
}
#else
import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Type;
import haxe.macro.Expr;
import haxe.macro.JSGenApi;

using haxe.macro.Tools;

using Lambda;
using StringTools;

class ModuleHelper
{
	public static function exclude(types:Array<String>):Void
	{
		for (type in types)
		{
			Compiler.exclude(type);
			Compiler.addMetadata("@:native(\"$hx_exports." + type + "\")", type);
		}
	}

	public static function expose(classNames:Array<String>):Void
	{
		for (className in classNames)
		{
			Compiler.addMetadata("@:expose('" + className + "')", className);
		}
	}

	public static function generate()
	{
		// Compiler.setCustomJSGenerator(function(api) new Generator(api).generate());
	}
}
#end
