package android.media;

import lime._internal.backend.android.JNICache;
import lime.app.Event;
import lime.system.JNI;

/**
 * Utility class for managing volume and audio focus.
 */
#if android
class AudioManager
{
	/**
	 * Constant representing the stream type that can be used for changing volume of that stream: voice call.
	 */
	public static final STREAM_VOICE_CALL:Int = 0;

	/**
	 * Constant representing the stream type that can be used for changing volume of that stream: system sounds.
	 */
	public static final STREAM_SYSTEM:Int = 1;

	/**
	 * Constant representing the stream type that can be used for changing volume of that stream: phone ring.
	 */
	public static final STREAM_RING:Int = 2;

	/**
	 * Constant representing the stream type that can be used for changing volume of that stream: music playback.
	 */
	public static final STREAM_MUSIC:Int = 3;

	/**
	 * Constant representing the stream type that can be used for changing volume of that stream: alarm.
	 */
	public static final STREAM_ALARM:Int = 4;

	/**
	 * Constant representing the stream type that can be used for changing volume of that stream: notification.
	 */
	public static final STREAM_NOTIFICATION:Int = 5;

	/**
	 * Constant representing the stream type that can be used for changing volume of that stream: phone calls when connected to bluetooth.
	 */
	public static final STREAM_BLUETOOTH_SCO:Int = 6;

	/**
	 * Constant representing the stream type that can be used for changing volume of that stream: enforced system sounds.
	 */
	public static final STREAM_SYSTEM_ENFORCED:Int = 7;

	/**
	 * Constant representing the stream type that can be used for changing volume of that stream: DTMF Tones.
	 */
	public static final STREAM_DTMF:Int = 8;

	/**
	 * Constant representing the stream type that can be used for changing volume of that stream: tts transmitted through the speaker.
	 */
	public static final STREAM_TTS:Int = 9;

	/**
	 * Constant representing the stream type that can be used for changing volume of that stream: accessibility prompts.
	 */
	public static final STREAM_ACCESSIBILITY:Int = 10;

	/**
	 * Constant representing the stream type that can be used for changing volume of that stream: virtual assistant.
	 */
	public static final STREAM_ASSISTANT:Int = 11;

	/**
	 * Constant representing the direction of volume adjustment: raise the volume.
	 */
	public static final ADJUST_RAISE:Int = 1;

	/**
	 * Constant representing the direction of volume adjustment: lower the volume.
	 */
	public static final ADJUST_LOWER:Int = -1;

	/**
	 * Constant representing the direction of volume adjustment: same volume.
	 */
	public static final ADJUST_SAME:Int = 0;

	/**
	 * Constant representing the direction of volume adjustment: mute the volume.
	 */
	public static final ADJUST_MUTE:Int = -100;

	/**
	 * Constant representing the direction of volume adjustment: unmute the volume.
	 */
	public static final ADJUST_UNMUTE:Int = 100;

	/**
	 * Constant representing the direction of volume adjustment: toggle mute state.
	 */
	public static final ADJUST_TOGGLE_MUTE:Int = 101;

	/**
	 * Constant representing the flags for volume adjustment: show ui.
	 */
	public static final FLAG_SHOW_UI:Int = 1 << 0;

	/**
	 * Constant representing the flags for volume adjustment: include ringer modes.
	 */
	public static final FLAG_ALLOW_RINGER_MODES:Int = 1 << 1;

	/**
	 * Constant representing the flags for volume adjustment: play sound when changing volume.
	 */
	public static final FLAG_PLAY_SOUND:Int = 1 << 2;

	/**
	 * Constant representing the flags for volume adjustment: remove any sound and vibrate.
	 */
	public static final FLAG_REMOVE_SOUND_AND_VIBRATE:Int = 1 << 3;

	/**
	 * Constant representing the flags for volume adjustment: vibrate if going into the vibrate ringer mode.
	 */
	public static final FLAG_VIBRATE:Int = 1 << 4;

	/**
	 * Constant representing the flags for audio focus status: nothing changed.
	 */
	public static final AUDIOFOCUS_NONE:Int = 0;

	/**
	 * Constant representing the flags for audio focus status: gain of audio focus.
	 */
	public static final AUDIOFOCUS_GAIN:Int = 1;

	/**
	 * Constant representing the flags for audio focus status: gain of temporary audio focus.
	 */
	public static final AUDIOFOCUS_GAIN_TRANSIENT:Int = 2;

	/**
	 * Constant representing the flags for audio focus status: gain of temporary audio focus with ducking another app.
	 */
	public static final AUDIOFOCUS_GAIN_TRANSIENT_MAY_DUCK:Int = 3;

	/**
	 * Constant representing the flags for audio focus status: gain of exclusive temporary audio focus.
	 */
	public static final AUDIOFOCUS_GAIN_TRANSIENT_EXCLUSIVE:Int = 4;

	/**
	 * Constant representing the flags for audio focus status: loss of audio focus.
	 */
	public static final AUDIOFOCUS_LOSS:Int = -1;

	/**
	 * Constant representing the flags for audio focus status: loss of temporary audio focus.
	 */
	public static final AUDIOFOCUS_LOSS_TRANSIENT:Int = -2;

	/**
	 * Constant representing the flags for audio focus status: loss of temporary audio focus with ducking another app.
	 */
	public static final AUDIOFOCUS_LOSS_TRANSIENT_CAN_DUCK:Int = -3;

	/**
	 * Constant representing the flags for audio focus change result: unable to change focus.
	 */
	public static final AUDIOFOCUS_REQUEST_FAILED:Int = 0;

	/**
	 * Constant representing the flags for audio focus change result: focus was changed successfully.
	 */
	public static final AUDIOFOCUS_REQUEST_GRANTED:Int = 1;

	/**
	 * Constant representing the flags for audio focus change result: focus was changed successfully but delayed.
	 */
	public static final AUDIOFOCUS_REQUEST_DELAYED:Int = 2;

	/**
	 * Event that is triggered when the audio focus changes.
	 *
	 * Listeners receive one of the `AUDIOFOCUS_GAIN`/`AUDIOFOCUS_LOSS` constants.
	 */
	public static var onFocusChangeEvent(default, null):Event<Int->Void> = new Event<Int->Void>();

	/**
	 * The listener handed to the native side.
	 *
	 * It has to be the same instance for both requesting and abandoning focus,
	 * otherwise the abandon call refers to a listener that was never registered.
	 */
	@:noCompletion
	static var focusChangeListener:Null<OnAudioFocusChangeListener> = null;

	/**
	 * Starts reporting the activity's audio focus changes through `onFocusChangeEvent`.
	 *
	 * The activity already requests and abandons audio focus around its own
	 * lifecycle, so this only subscribes to what it receives. Call it once before
	 * listening to `onFocusChangeEvent`.
	 *
	 * `requestAudioFocus` is not needed for this, and taking focus separately will
	 * override the activity's own request.
	 */
	public static function init():Void
	{
		final initAudioFocusCallBackJNI:Null<Dynamic> = JNICache.createStaticMethod('org/haxe/extension/Tools', 'initAudioFocusCallBack',
			'(Lorg/haxe/lime/HaxeObject;)V');

		if (initAudioFocusCallBackJNI != null)
		{
			if (focusChangeListener == null)
				focusChangeListener = new OnAudioFocusChangeListener();

			initAudioFocusCallBackJNI(focusChangeListener);
		}
	}

	/**
	 * Adjusts the volume of a specified audio stream.
	 *
	 * @param streamType The type of audio stream to adjust (e.g., STREAM_MUSIC).
	 * @param direction The direction to adjust the volume (e.g., ADJUST_RAISE, ADJUST_LOWER).
	 * @param flags Additional operation flags (e.g., FLAG_SHOW_UI).
	 */
	public static function adjustStreamVolume(streamType:Int, direction:Int, flags:Int):Void
	{
		final adjustStreamVolumeJNI:Null<Dynamic> = JNICache.createStaticMethod('org/haxe/extension/Tools', 'adjustStreamVolume', '(III)V');

		if (adjustStreamVolumeJNI != null)
			adjustStreamVolumeJNI(streamType, direction, flags);
	}

	/**
	 * Retrieves the current volume index for a specified audio stream.
	 *
	 * @param streamType The type of audio stream (e.g., STREAM_MUSIC).
	 *
	 * @return The current volume index for the specified stream, or 0 if an error occurs.
	 */
	public static function getStreamVolume(streamType:Int):Int
	{
		final getStreamVolumeJNI:Null<Dynamic> = JNICache.createStaticMethod('org/haxe/extension/Tools', 'getStreamVolume', '(I)I');

		if (getStreamVolumeJNI != null)
			return getStreamVolumeJNI(streamType);

		return 0;
	}

	/**
	 * Requests audio focus for a given stream and duration, and sets up a callback for focus changes.
	 *
	 * Focus changes are dispatched through `onFocusChangeEvent`.
	 *
	 * @param streamType The type of audio stream for which focus is requested.
	 * @param durationHint The duration of the audio focus request (e.g., AUDIOFOCUS_GAIN).
	 *
	 * @return The result of the audio focus request (e.g., AUDIOFOCUS_REQUEST_GRANTED or AUDIOFOCUS_REQUEST_FAILED).
	 */
	public static function requestAudioFocus(streamType:Int, durationHint:Int):Int
	{
		final requestAudioFocusJNI:Null<Dynamic> = JNICache.createStaticMethod('org/haxe/extension/Tools', 'requestAudioFocus',
			'(Lorg/haxe/lime/HaxeObject;II)I');

		if (requestAudioFocusJNI != null)
		{
			if (focusChangeListener == null)
				focusChangeListener = new OnAudioFocusChangeListener();

			return requestAudioFocusJNI(focusChangeListener, streamType, durationHint);
		}

		return AUDIOFOCUS_REQUEST_FAILED;
	}

	/**
	 * Abandons the audio focus previously acquired through `requestAudioFocus`.
	 *
	 * @return The result of the abandon audio focus request (e.g., AUDIOFOCUS_REQUEST_GRANTED or AUDIOFOCUS_REQUEST_FAILED).
	 */
	public static function abandonAudioFocus():Int
	{
		if (focusChangeListener == null)
			return AUDIOFOCUS_REQUEST_FAILED;

		final abandonAudioFocusJNI:Null<Dynamic> = JNICache.createStaticMethod('org/haxe/extension/Tools', 'abandonAudioFocus',
			'(Lorg/haxe/lime/HaxeObject;)I');

		if (abandonAudioFocusJNI != null)
			return abandonAudioFocusJNI(focusChangeListener);

		return AUDIOFOCUS_REQUEST_FAILED;
	}
}

/**
 * Listener class for handling audio focus changes.
 */
@:keep
@:noCompletion
private class OnAudioFocusChangeListener #if !macro implements JNISafety #end
{
	public function new():Void {}

	#if !macro
	@:runOnMainThread
	#end
	public function onAudioFocusChange(focusChange:Int):Void
	{
		if (AudioManager.onFocusChangeEvent != null)
			AudioManager.onFocusChangeEvent.dispatch(focusChange);
	}
}
#end
