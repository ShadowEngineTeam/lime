package lime.graphics;

/**
	An enum for possible render context types
**/
enum abstract RenderContextType(String) from String to String
{
	/**
		Describes a Cairo render context
	**/
	var CAIRO = "cairo";

	/**
		Describes an HTML5 canvas render context
	**/
	var CANVAS = "canvas";

	/**
		Describes an HTML5 DOM render context
	**/
	var DOM = "dom";

	/**
		Describes a WebGL render context
	**/
	var WEBGL = "webgl";

	/**
		Legacy identifiers: no native GL context exists anymore (BGFX replaced
		it), but frameworks still compare against these as "hardware renderer"
		tags. `window.context.type` never carries these values.
	**/
	var OPENGL = "opengl";

	var OPENGLES = "opengles";

	/**
		Describes a bgfx render context (Direct3D, Metal or Vulkan under the hood)
	**/
	var BGFX = "bgfx";

	/**
		Describes a custom render context
	**/
	var CUSTOM = "custom";
}
