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
		Describes a bgfx render context (Direct3D, Metal or Vulkan under the hood)
	**/
	var BGFX = "bgfx";

	/**
		Describes a custom render context
	**/
	var CUSTOM = "custom";
}
