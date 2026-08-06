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

			if (Context.defined("ios") || Context.defined("android"))
			{
				Compiler.define("mobile");

				if (cffi)
				{
					Compiler.define("lime-opengles");
				}
			}
			else
			{
				Compiler.define("desktop");

				if (cffi)
				{
					Compiler.define("lime-opengl");
				}
			}

			if (cffi)
			{
				Compiler.define("lime-openal");
				Compiler.define("lime-miniaudio");
				Compiler.define("lime-cairo");
				Compiler.define("lime-harfbuzz");

				Compiler.define("lime-cffi");
			}
			else
			{
				Compiler.define("disable-cffi");
			}
		}

		if (Context.defined("android") && Context.defined("extension-androidtools"))
			Context.fatalError("The haxelib 'extension-androidtools' is already included in this Lime. Please remove it from the project file to compile.", (macro null).pos);
	}
}
#end
