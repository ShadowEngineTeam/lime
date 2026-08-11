package lime.graphics;

#if (!lime_doc_gen || lime_opengl || lime_opengles)
#if (lime_doc_gen || (sys && lime_cffi && !doc_gen))
import lime._internal.backend.native.NativeOpenGLRenderContext;
import lime.graphics.opengl.GL;

/**
	The `OpenGLES3RenderContext` allows access to OpenGL ES 3 features when OpenGL or
	OpenGL ES is the render context type of the `Window`, and the current context supports
	GLES3 features.

	This forwards to the same underlying context as `OpenGLRenderContext`; the separate
	type is kept so existing code continues to compile, and to document intent at the call
	site. It no longer restricts the visible API: when this abstract maintained its own
	list of members, every entry point had to be declared in five places by hand, and the
	list drifted from the backend. Guard on the context `version` or on `getExtension`
	rather than on which of these types you hold.

	You can convert from `lime.graphics.RenderContext`, `lime.graphics.OpenGLRenderContext`,
	`lime.graphics.opengl.GL`, and can convert to `lime.graphics.OpenGLES2RenderContext`
	directly if desired:

	```haxe
	var gles3:OpenGLES3RenderContext = window.context;
	var gles3:OpenGLES3RenderContext = gl;
	var gles3:OpenGLES3RenderContext = GL;

	var gles2:OpenGLES2RenderContext = gles3;
	```
**/
@:access(lime.graphics.RenderContext)
@:forward()
@:transitive
abstract OpenGLES3RenderContext(NativeOpenGLRenderContext) from NativeOpenGLRenderContext to NativeOpenGLRenderContext
{
	@:from private static function fromRenderContext(context:RenderContext):OpenGLES3RenderContext
	{
		return context.gles3;
	}

	@:from private static function fromGL(gl:Class<GL>):OpenGLES3RenderContext
	{
		return GL.context;
	}
}
#else
@:forward()
@:transitive
abstract OpenGLES3RenderContext(Dynamic) from Dynamic to Dynamic
{
	@:from private static function fromRenderContext(context:RenderContext):OpenGLES3RenderContext
	{
		return null;
	}

	@:from private static function fromGL(gl:Class<GL>):OpenGLES3RenderContext
	{
		return null;
	}
}
#end
#end
