package lime.media;

import lime.utils.Log;
#if lime_miniaudio
import lime.media.miniaudio.MAEngine;
import lime.media.miniaudio.MAEngineConfig;
#if lime_miniaudio_debug_output
import lime.media.miniaudio.MAHelpers;
import lime.media.miniaudio.MALog;
import lime.media.miniaudio.MALogLevel;
#end
#end

@:allow(lime._internal.backend.native.NativeApplication)
class AudioManager
{
	#if lime_miniaudio_debug_output
	@:noCompletion
	private static function onLog(level:MALogLevel, pMessage:String):Void
	{
		Log.println('${MAHelpers.log_level_to_string(level)}: ${pMessage}');
	}
	#end

	@:noCompletion
	private static var resumeOnFocus:Bool = false;

	@:noCompletion
	private static var active:Bool = true;

	#if lime_miniaudio
	#if lime_miniaudio_debug_output
	public static var log:MALog;
	#end
	public static var engine:MAEngine;
	#end

	public static function init():Void
	{
		#if lime_miniaudio
		if (engine == null)
		{
			#if lime_miniaudio_debug_output
			if (log == null)
			{
				log = MALog.init();

				if (log != null)
				{
					log.register_callback(onLog);
				}
				else
				{
					Log.error("Unable to create MiniAudio engine log config for Native!");
				}
			}
			#end

			final config:MAEngineConfig = MAEngineConfig.init();

			#if lime_miniaudio_debug_output
			config.pLog = log;
			#end

			engine = MAEngine.init(config);

			if (engine == null)
			{
				Log.error("Unable to create MiniAudio engine for Native!");
			}
		}
		#end
	}

	public static function shutdown():Void
	{
		#if lime_miniaudio
		if (engine != null)
		{
			engine.stop();
			engine.uninit();
			engine = null;
		}

		#if lime_miniaudio_debug_output
		if (log != null)
		{
			log.uninit();
			log = null;
		}
		#end
		#end
	}

	public static function resume():Void
	{
		if (active)
			return;

		#if lime_miniaudio
		engine.start();
		#end

		active = true;
	}

	public static function suspend():Void
	{
		if (!active)
			return;

		#if lime_miniaudio
		engine.stop();
		#end

		active = false;
	}

	@:noCompletion
	private static function onActivate():Void
	{
		if (resumeOnFocus)
		{
			resumeOnFocus = false;

			AudioManager.resume();
		}
	}

	@:noCompletion
	private static function onDeactivate():Void
	{
		resumeOnFocus = resumeOnFocus || AudioManager.active;

		AudioManager.suspend();
	}
}
