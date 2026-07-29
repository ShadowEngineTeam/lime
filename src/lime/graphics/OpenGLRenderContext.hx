package lime.graphics;

#if (!lime_doc_gen || lime_opengl)
#if (lime_doc_gen || (sys && lime_cffi && !doc_gen))
import lime._internal.backend.native.NativeOpenGLRenderContext;

/**
	The `OpenGLRenderContext` allows access to OpenGL features when OpenGL is the render
	context type of the `Window`.

	Support for desktop OpenGL-specific features is currently sparse, but the
	`OpenGLRenderContext` provides the platform for us to add additional desktop specific
	features.

	You can convert from `lime.graphics.RenderContext` or `lime.graphics.opengl.GL`, and
	can convert to `lime.graphics.OpenGLES3RenderContext` or
	`lime.graphics.OpenGLES2RenderContext` directly if desired:

	```haxe
	var gl:OpenGLRenderContext = window.context;
	var gl:OpenGLRenderContext = GL;

	var gles3:OpenGLES3RenderContext = gl;
	var gles2:OpenGLES2RenderContext = gl;
	```
**/
@:access(lime.graphics.RenderContext)
@:forward()
@:transitive
abstract OpenGLRenderContext(NativeOpenGLRenderContext) from NativeOpenGLRenderContext to NativeOpenGLRenderContext
{
	@:from private static function fromRenderContext(context:RenderContext):OpenGLRenderContext
	{
		return context.gl;
	}
}
#else
@:forward()
@:transitive
abstract OpenGLRenderContext(Dynamic) from Dynamic to Dynamic
{
	@:from private static function fromRenderContext(context:RenderContext):OpenGLRenderContext
	{
		return null;
	}
}
#end
#end
