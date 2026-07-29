package lime.graphics.opengl;

#if (!lime_doc_gen || lime_opengl || lime_opengles)
#if ((lime_opengl || lime_opengles) && !doc_gen)
import lime.graphics.opengl.GL;

@:forward(id)
abstract GLQuery(GLObject) from GLObject to GLObject
{
	@:from private static function fromInt(id:Int):GLQuery
	{
		return GLObject.fromInt(QUERY, id);
	}
}
#else
typedef GLQuery = Dynamic;
#end
#end
