package lime.graphics;

import lime.graphics.bgfx.BGFX;
import lime.ui.Window;

/**
	Render context state for a window rendered through bgfx.

	The bgfx API itself is global — use `lime.graphics.bgfx.BGFX` (also
	available through the `api` field). This object tracks the window that
	owns the backbuffer, and handles resizing.
**/
@:access(lime.ui.Window)
class BGFXRenderContext
{
	public var window(default, null):Window;

	/**
		Convenience access to the BGFX API class.
	**/
	public var api(get, never):Class<BGFX>;

	@:noCompletion private var __resetFlags:Int;

	@:noCompletion private function new(window:Window, resetFlags:Int)
	{
		this.window = window;
		__resetFlags = resetFlags;
	}

	/**
		Resize the backbuffer (call when the window size changes).
	**/
	public function resize(width:Int, height:Int):Void
	{
		BGFX.reset(width, height, __resetFlags);
	}

	/**
		Present the current frame.
	**/
	public inline function frame():Int
	{
		return BGFX.frame();
	}

	@:noCompletion private function get_api():Class<BGFX>
	{
		return BGFX;
	}
}
