package lime.graphics.opengl;

#if (!lime_doc_gen || lime_webgl)
#if (lime_webgl && !doc_gen)
@:native("WebGLTransformFeedback")
extern class GLTransformFeedback {}
#else
typedef GLTransformFeedback = Dynamic;
#end
#end
