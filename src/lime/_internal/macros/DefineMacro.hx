package lime._internal.macros;

#if macro
import haxe.macro.Compiler;
import haxe.macro.Context;

class DefineMacro
{
	public static function run():Void
	{
		if (!Context.defined("tools"))
		{
			Compiler.define("lime-shadow");
			Compiler.define("native");

			var cffi = !Context.defined("nocffi");
			var mobile = Context.defined("ios") || Context.defined("android");

			Compiler.define(mobile ? "mobile" : "desktop");

			// One renderer per build: bgfx, unless OpenGL is asked for with lime-opengl or
			// lime-opengles. The one that is not chosen stays off. A define cannot be taken back
			// here, and one that is set counts as true whatever its value, so asking for both is
			// an error instead.
			//
			// Only C++ builds render. Lime's own tools run on Neko, which binds every native
			// function it declares when it starts: with no renderer defined they work with a
			// Lime binary of either kind.
			if (cffi && Context.defined("cpp"))
			{
				var opengl = Context.defined("lime_opengl") || Context.defined("lime_opengles");

				if (opengl && Context.defined("lime_bgfx"))
				{
					Context.fatalError("lime-bgfx is defined together with lime-opengl or lime-opengles, but a Lime build has one renderer. Define only one of them.",
						(macro null).pos);
				}

				if (!opengl)
				{
					Compiler.define("lime-bgfx");
				}
				else if (mobile)
				{
					Compiler.define("lime-opengles");
				}
				else
				{
					Compiler.define("lime-opengl");
				}
			}

			if (cffi)
			{
				Compiler.define("lime-cairo");
				Compiler.define("lime-harfbuzz");
				Compiler.define("lime-miniaudio");

				Compiler.define("lime-cffi");
			}
			else
			{
				Compiler.define("disable-cffi");
			}
		}

		if (Context.defined("android") && Context.defined("extension-androidtools"))
			Context.fatalError("The haxelib 'extension-androidtools' is already included in this Lime. Please remove it from the project file to compile.",
				(macro null).pos);
	}
}
#end
