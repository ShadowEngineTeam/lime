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

			if (Context.defined("js"))
			{
				Compiler.define("html5");
				Compiler.define("web");
				Compiler.define("lime-canvas");
				Compiler.define("lime-dom");
				Compiler.define("lime-howlerjs");
				Compiler.define("lime-webgl");
			}
			else
			{
				Compiler.define("native");

				var cffi = (!Context.defined("nocffi") && !Context.defined("eval"));

				if (Context.defined("ios") || Context.defined("android"))
				{
					Compiler.define("mobile");
					if (cffi) Compiler.define("lime-opengles");
				}
				else
				{
					Compiler.define("desktop");
					if (cffi) Compiler.define("lime-opengl");
				}

				if (cffi)
				{
					Compiler.define("lime-cffi");

					Compiler.define("lime-openal");
					Compiler.define("lime-cairo");
					Compiler.define("lime-harfbuzz");
				}
				else
				{
					Compiler.define("disable-cffi");
				}
			}
		}

		if (Context.defined("android") && Context.defined("extension-androidtools"))
			Context.fatalError("The haxelib 'extension-androidtools' is already included in this Lime. Please remove it from the project file to compile.", (macro null).pos);
	}
}
#end
