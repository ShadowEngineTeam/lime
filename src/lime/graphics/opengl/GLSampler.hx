package lime.graphics.opengl;

#if (!lime_doc_gen || lime_opengl || lime_opengles)
#if ((lime_opengl || lime_opengles) && !doc_gen)
import lime.graphics.opengl.GL;

@:forward(id)
abstract GLSampler(GLObject) from GLObject to GLObject
{
	@:from private static function fromInt(id:Int):GLSampler
	{
		return GLObject.fromInt(SAMPLER, id);
	}
}
#else
typedef GLSampler = Dynamic;
#end
#end
