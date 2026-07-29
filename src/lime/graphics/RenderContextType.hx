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
		Describes an OpenGL render context
	**/
	var OPENGL = "opengl";

	/**
		Describes an OpenGL ES render context
	**/
	var OPENGLES = "opengles";

	/**
		Describes a custom render context
	**/
	var CUSTOM = "custom";
}
