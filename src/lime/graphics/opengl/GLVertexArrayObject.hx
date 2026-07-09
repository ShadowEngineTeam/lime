package lime.graphics.opengl;

#if (!lime_doc_gen || lime_webgl)
#if (lime_webgl && !doc_gen)
@:native("WebGLVertexArrayObject")
extern class GLVertexArrayObject {}
#else
typedef GLVertexArrayObject = Dynamic;
#end
#end
