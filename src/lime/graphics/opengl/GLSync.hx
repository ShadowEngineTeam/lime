package lime.graphics.opengl;

#if (!lime_doc_gen || lime_webgl)
#if (lime_webgl && !doc_gen)
@:native("WebGLSync")
extern class GLSync {}
#else
typedef GLSync = Dynamic;
#end
#end
