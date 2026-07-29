package lime.graphics.opengl;

#if (!lime_doc_gen || lime_opengl || lime_opengles)
#if ((lime_opengl || lime_opengles) && !doc_gen)
import lime._internal.backend.native.NativeCFFI;
import lime.system.CFFIPointer;

@:access(lime._internal.backend.native.NativeCFFI)
abstract GLSync(CFFIPointer) from CFFIPointer to CFFIPointer {}
#else
typedef GLSync = Dynamic;
#end
#end
