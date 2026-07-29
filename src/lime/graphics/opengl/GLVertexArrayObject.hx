package lime.graphics.opengl;

#if (!lime_doc_gen || lime_opengl || lime_opengles)
#if ((lime_opengl || lime_opengles) && !doc_gen)
import lime.graphics.opengl.GL;

@:forward(id)
abstract GLVertexArrayObject(GLObject) from GLObject to GLObject
{
	@:from private static function fromInt(id:Int):GLVertexArrayObject
	{
		return GLObject.fromInt(VERTEX_ARRAY_OBJECT, id);
	}
}
#else
typedef GLVertexArrayObject = Dynamic;
#end
#end
