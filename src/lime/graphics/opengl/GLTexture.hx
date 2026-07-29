package lime.graphics.opengl;

#if (!lime_doc_gen || lime_opengl || lime_opengles)
#if ((lime_opengl || lime_opengles) && !doc_gen)
import lime.graphics.opengl.GL;

@:forward(id)
abstract GLTexture(GLObject) from GLObject to GLObject
{
	@:from private static function fromInt(id:Int):GLTexture
	{
		return GLObject.fromInt(TEXTURE, id);
	}
}
#else
typedef GLTexture = Dynamic;
#end
#end
