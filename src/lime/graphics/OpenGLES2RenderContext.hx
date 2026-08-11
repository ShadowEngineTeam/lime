package lime.graphics;

#if (!lime_doc_gen || lime_opengl || lime_opengles)
#if (doc_gen || (sys && lime_cffi))
import lime._internal.backend.native.NativeOpenGLRenderContext;
import lime.graphics.opengl.GL;

/**
	The `OpenGLES2RenderContext` allows access to OpenGL ES 2 features when OpenGL or
	OpenGL ES is the render context type of the `Window`.

	This forwards to the same underlying context as `OpenGLRenderContext`; the separate
	type is kept so existing code continues to compile, and to document intent at the call
	site. It used to enumerate the OpenGL ES 2 subset by hand so that native and WebGL
	could share a surface, which is no longer a target here, and holding this type in
	preference to `OpenGLRenderContext` silently cost access to everything newer.

	You can convert from `lime.graphics.RenderContext`, `lime.graphics.OpenGLRenderContext`,
	`lime.graphics.OpenGLES3RenderContext` and `lime.graphics.opengl.GL`:

	```haxe
	var gles2:OpenGLES2RenderContext = window.context;
	var gles2:OpenGLES2RenderContext = gl;
	var gles2:OpenGLES2RenderContext = GL;
	```
**/
@:access(lime.graphics.RenderContext)
@:forward()
@:transitive
abstract OpenGLES2RenderContext(NativeOpenGLRenderContext) from NativeOpenGLRenderContext to NativeOpenGLRenderContext
{
	@:from private static function fromRenderContext(context:RenderContext):OpenGLES2RenderContext
	{
		return context.gles2;
	}

	@:from private static function fromGL(gl:Class<GL>):OpenGLES2RenderContext
	{
		return GL.context;
	}
}
#else
@:forward()
@:transitive
abstract OpenGLES2RenderContext(Dynamic) from Dynamic to Dynamic
{
	@:from private static function fromRenderContext(context:RenderContext):OpenGLES2RenderContext
	{
		return null;
	}

	@:from private static function fromGL(gl:Class<GL>):OpenGLES2RenderContext
	{
		return null;
	}
}
#end
#end
