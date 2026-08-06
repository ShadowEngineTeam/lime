package lime.media;

#if lime_miniaudio
import lime._internal.backend.native.NativeCFFI;
#end
import lime.utils.Log;

#if lime_miniaudio
@:access(lime._internal.backend.native.NativeCFFI)
#end
@:access(lime.media.OpenALAudioContext)
class AudioContext
{
	public var custom:Dynamic;
	#if (!lime_doc_gen || lime_openal)
	public var openal(default, null):OpenALAudioContext;
	#end
	#if (!lime_doc_gen || lime_miniaudio)
	public var maEngine(default, null):Int;
	#end
	public var type(default, null):AudioContextType;

	public function new(type:AudioContextType = null)
	{
		#if (lime_miniaudio && !NO_MINIAUDIO)
		if (type == null) type = MINIAUDIO;
		#else
		if (type == null) type = OPENAL;
		#end

		if (type == CUSTOM)
		{
			this.type = CUSTOM;
		}
		#if lime_miniaudio
		else if (type == MINIAUDIO)
		{
			#if (lime_cffi && lime_miniaudio && !macro)
			NativeCFFI.lime_miniaudio_backend_init();
			// 0 = take the device's native sample rate, which is what the OpenAL config does by
			// not setting a frequency. Forcing 44100 on a 48k device just adds an OS-side resample.
			maEngine = NativeCFFI.lime_miniaudio_backend_engine_init(0, 0, 0, 0);
			#end
			this.type = MINIAUDIO;
		}
		#end
		#if lime_openal
		else if (type == OPENAL)
		{
			openal = new OpenALAudioContext();

			#if lime_miniaudio
			// on miniaudio builds an explicitly requested OpenAL context is fully initialized here,
			// so that OpenAL-based code (e.g. hxvlc) can run alongside the miniaudio backend
			var device = openal.openDevice();

			if (device != null)
			{
				var ctx = openal.createContext(device);
				openal.makeContextCurrent(ctx);
				openal.processContext(ctx);
			}
			#end

			this.type = OPENAL;
		}
		#end
	}
}
