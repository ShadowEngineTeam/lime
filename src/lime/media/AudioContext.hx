package lime.media;

import lime.utils.Log;

@:access(lime.media.OpenALAudioContext)
class AudioContext
{
	public var custom:Dynamic;
	#if (!lime_doc_gen || lime_openal)
	public var openal(default, null):OpenALAudioContext;
	#end
	public var type(default, null):AudioContextType;

	public function new(type:AudioContextType = null)
	{
		if (type != CUSTOM)
		{
			#if lime_openal
			openal = new OpenALAudioContext();
			this.type = OPENAL;
			#end
		}
		else
		{
			this.type = CUSTOM;
		}
	}
}
