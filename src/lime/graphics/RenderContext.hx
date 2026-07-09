package lime.graphics;

import lime.app.Event;
import lime.ui.Window;

/**
	The `RenderContext` provides access to rendering for a Lime `Window`.

	Native targets always render through bgfx (`context.bgfx`); html5 uses
	WebGL, canvas or DOM contexts.
**/
class RenderContext
{
	/**
		Additional information about the current context
	**/
	public var attributes(default, null):RenderContextAttributes;

	/**
		Access to the current bgfx render context, if available
	**/
	#if (!lime_doc_gen || native)
	public var bgfx(default, null):BGFXRenderContext;
	#end

	/**
		Access to the current Cairo render context, if available
	**/
	#if (!lime_doc_gen || native)
	public var cairo(default, null):CairoRenderContext;
	#end

	/**
		Access to the current HTML5 canvas render context, if available
	**/
	#if (!lime_doc_gen || (js && html5))
	public var canvas2D(default, null):Canvas2DRenderContext;
	#end

	/**
		Access to the current HTML5 DOM render context, if available
	**/
	#if (!lime_doc_gen || (js && html5))
	public var dom(default, null):DOMRenderContext;
	#end

	/**
		The type of the current `RenderContext`
	**/
	public var type(default, null):RenderContextType;

	public var version(default, null):String;

	/**
		Access to the current WebGL render API, if available
	**/
	#if (!lime_doc_gen || (js && html5))
	public var webgl(default, null):WebGLRenderContext;
	#end

	/**
		Access to the current WebGL 2 render API, if available
	**/
	#if (!lime_doc_gen || (js && html5))
	public var webgl2(default, null):WebGL2RenderContext;
	#end
	public var window(default, null):Window;

	@:noCompletion private function new() {}
}
