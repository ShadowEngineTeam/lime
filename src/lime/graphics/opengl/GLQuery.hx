package lime.graphics.opengl;

#if (!lime_doc_gen || lime_webgl)
#if (lime_webgl && !doc_gen)
@:native("WebGLQuery")
extern class GLQuery {}
#else
typedef GLQuery = Dynamic;
#end
#end
