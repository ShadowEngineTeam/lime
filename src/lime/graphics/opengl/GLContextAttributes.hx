package lime.graphics.opengl;

#if (!lime_doc_gen || lime_opengl || lime_opengles)
typedef GLContextAttributes =
{
	alpha:Bool,
	depth:Bool,
	stencil:Bool,
	antialias:Bool,
	premultipliedAlpha:Bool,
	preserveDrawingBuffer:Bool
}
#end
