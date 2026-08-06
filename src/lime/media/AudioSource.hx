package lime.media;

import lime.app.Event;
import lime.media.openal.AL;
import lime.media.openal.ALSource;
import lime.math.Vector4;
import lime.utils.UInt8Array;
import lime._internal.backend.native.NativeMiniaudioAudioSource;
import lime._internal.backend.native.NativeMiniaudioAudioSource.MiniaudioAudioSourceReadbackData;
import lime._internal.backend.native.NativeOpenALAudioSource;

import haxe.io.Bytes;
import haxe.io.BytesData;

/**
	The `AudioSource` class provides a way to control audio playback in a Lime application.
	It allows for playing, pausing, and stopping audio, as well as controlling various
	audio properties such as gain, pitch, and looping.

	Depending on the platform, the audio backend may vary, but the API remains consistent.

	@see lime.media.AudioBuffer
**/
class AudioSource
{
	/**
		An event that is dispatched when the audio playback is complete.
	**/
	public var onComplete = new Event<Void->Void>();

	/**
		The audio data, if passed as bytes in the constructor.
	**/
	public var data:Bytes = null;

	/**
		The `AudioBuffer` associated with this `AudioSource`.
	**/
	public var buffer:AudioBuffer;

	/**
		The current playback position of the audio, in milliseconds.
	**/
	public var currentTime(get, set):Float;

	/**
		The gain (volume) of the audio. A value of `1.0` represents the default volume.
	**/
	public var gain(get, set):Float;

	/**
		The length of the audio, in milliseconds.
	**/
	public var length(get, set):Float;

	/**
		The number of times the audio will loop. A value of `0` means the audio will not loop.
	**/
	public var loops(get, set):Int;

	/**
		The pitch of the audio. A value of `1.0` represents the default pitch.
	**/
	public var pitch(get, set):Float;

	/**
		The offset within the audio buffer to start playback, in milliseconds.
	**/
	public var offset:Float;

	/**
		The 3D position of the audio source, represented as a `Vector4`.
	**/
	public var position(get, set):Vector4;

	/**
		The estimated output latency, in miliseconds, for this `AudioSource`. If not possible to retrieve will return `0`.
	**/
	public var latency(get, never):Float;

	@:noCompletion private var __backend:AudioSourceBackend;

	/**
		Creates a new `AudioSource` instance.
		@param buffer The `AudioBuffer` to associate with this `AudioSource`.
		@param offset The starting offset within the audio buffer, in milliseconds.
		@param length The length of the audio to play, in milliseconds. If `null`, the full buffer is used.
		@param loops The number of times to loop the audio. `0` means no looping.

		Note: when the current `AudioManager` context uses the miniaudio backend, the `AudioBuffer`-based
		API is not available. Use `AudioSource.fromBytes()` or `AudioSource.fromFile()` instead.
	**/
	public function new(buffer:AudioBuffer = null, offset:Float = 0, length:Null<Int> = null, loops:Int = 0)
	{
		this.buffer = buffer;
		this.offset = offset;

		__backend = createBackend(false);

		// the miniaudio backend cannot receive property changes before it is initialized,
		// so the static factories apply these after initializing the backend
		if (!isMiniaudio())
		{
			if (length != null && length != 0)
			{
				this.length = length;
			}

			this.loops = loops;
		}

		if (buffer != null)
		{
			if (isMiniaudio())
			{
				lime.utils.Log.error("AudioSource was created with an AudioBuffer, but the miniaudio backend cannot play AudioBuffers. Use AudioSource.fromBytes() or AudioSource.fromFile() instead.");
			}
			else
			{
				init();
			}
		}
	}

	/**
		Creates a new `AudioSource` instance from raw audio bytes.
		@param bytes the bytes of an audio file.
			NOTE: messing with Bytes object after it is passed here, like resizing, pushing etc., may cause undefined behaviour because of reallocation, unless `stream` is set to `false`
		@param stream wheather audio data should be streamed. takes effect only if initializing from bytes. creating an `AudioSource` with this set to `false` is EXPENSIVE, use only if you need readback.
		@param offset The starting offset within the audio buffer, in milliseconds.
		@param length The length of the audio to play, in milliseconds. If `null`, the whole audio data is used.
		@param loops The number of times to loop the audio. `0` means no looping.
	**/
	public static function fromBytes(bytes:Bytes, stream:Bool = true, offset:Float = 0, length:Null<Int> = null, loops:Int = 0):AudioSource
	{
		var source = new AudioSource(null, offset, length, loops);
		source.data = bytes;
		source.__backend = source.createBackend(stream);

		if (source.isMiniaudio())
		{
			source.initFromBytes();
			if (!stream)
			{
				source.data = null;
			}
		}
		else
		{
			lime.utils.Log.error("AudioSource.fromBytes() requires the miniaudio backend (the current AudioManager context type must be MINIAUDIO)");
		}

		if (length != null && length != 0)
		{
			source.length = length;
		}

		source.loops = loops;

		return source;
	}

	/**
		Creates a new `AudioSource` instance from a file path.
		@param path The path to an audio file.
		@param stream wheather audio data should be streamed.
		@param offset The starting offset within the audio buffer, in milliseconds.
		@param length The length of the audio to play, in milliseconds. If `null`, the whole audio data is used.
		@param loops The number of times to loop the audio. `0` means no looping.
	**/
	public static function fromFile(path:String, stream:Bool = true, offset:Float = 0, length:Null<Int> = null, loops:Int = 0):AudioSource
	{
		var source = new AudioSource(null, offset, length, loops);
		source.__backend = source.createBackend(stream);

		if (source.isMiniaudio())
		{
			source.initFromFile(path);
		}
		else
		{
			lime.utils.Log.error("AudioSource.fromFile() requires the miniaudio backend (the current AudioManager context type must be MINIAUDIO)");
		}

		if (length != null && length != 0)
		{
			source.length = length;
		}

		source.loops = loops;

		return source;
	}

	/**
		Creates a new `AudioSource` instance from raw pcm data in an `AudioBuffer`.
		Works with both the miniaudio and the OpenAL backend.
		@param buffer The `AudioBuffer` containing the pcm data.
		@param offset The starting offset within the audio buffer, in milliseconds.
		@param length The length of the audio to play, in milliseconds. If `null`, the whole audio data is used.
		@param loops The number of times to loop the audio. `0` means no looping.
	**/
	public static function fromAudioBuffer(buffer:AudioBuffer, offset:Float = 0, length:Null<Int> = null, loops:Int = 0):AudioSource
	{
		var source = new AudioSource(null, offset, length, loops);
		source.buffer = buffer;
		source.__backend = source.createBackend(false);

		if (buffer == null)
		{
			lime.utils.Log.error("AudioSource.fromAudioBuffer() was called with a null AudioBuffer");
			return source;
		}

		if (source.isMiniaudio())
		{
			var format:MiniaudioFormat = switch (buffer.dataFormat)
			{
				case S16: S16;
				case F32: F32;
				default: S16;
			}
			var bytesPerFrame = buffer.channels * (buffer.bitsPerSample / 8.0);

			if (bytesPerFrame <= 0 || buffer.data == null)
			{
				lime.utils.Log.error("AudioSource.fromAudioBuffer() was given an AudioBuffer with no usable data (channels: "
					+ buffer.channels + ", bitsPerSample: " + buffer.bitsPerSample + ")");
			}
			else
			{
				source.__backend.initFromAudioBuffer(buffer.sampleRate, buffer.channels, format, buffer.data.toBytes().getData(),
					Std.int(buffer.data.length / bytesPerFrame));
			}
		}
		else
		{
			source.init();
		}

		if (length != null && length != 0)
		{
			source.length = length;
		}

		source.loops = loops;

		return source;
	}

	/**
		Releases any resources used by this `AudioSource`.
	**/
	public function dispose():Void
	{
		__backend.dispose();
	}

	@:noCompletion private function init():Void
	{
		__backend.init();
	}

	@:noCompletion private function initFromBytes():Void
	{
		__backend.initFromBytes();
	}

	@:noCompletion private function initFromFile(path:String):Void
	{
		__backend.initFromFile(path);
	}

	@:noCompletion private function createBackend(stream:Bool):AudioSourceBackend
	{
		if (isMiniaudio())
		{
			return new NativeMiniaudioAudioSource(this, stream);
		}

		return new NativeOpenALAudioSource(this);
	}

	@:noCompletion private function isMiniaudio():Bool
	{
		return AudioManager.context != null && AudioManager.context.type == MINIAUDIO;
	}

	/**
		Starts or resumes audio playback.
	**/
	public function play():Void
	{
		__backend.play();
	}

	/**
		Pauses audio playback.
	**/
	public function pause():Void
	{
		__backend.pause();
	}

	/**
		Stops audio playback and resets the playback position to the beginning.
	**/
	public function stop():Void
	{
		__backend.stop();
	}

	/**
		Reads back pcm frames from the source.
		note that streaming must have been turned off and the `AudioSource` must have been created from bytes in order for this to work.
	**/
	public function readbackPcm():MiniaudioAudioSourceReadbackData
	{
		return __backend.readbackPcm();
	}

	// Get & Set Methods
	@:noCompletion private function get_currentTime():Float
	{
		return __backend.getCurrentTime();
	}

	@:noCompletion private function set_currentTime(value:Float):Float
	{
		return __backend.setCurrentTime(value);
	}

	@:noCompletion private function get_gain():Float
	{
		return __backend.getGain();
	}

	@:noCompletion private function set_gain(value:Float):Float
	{
		return __backend.setGain(value);
	}

	@:noCompletion private function get_length():Float
	{
		return __backend.getLength();
	}

	@:noCompletion private function set_length(value:Float):Float
	{
		return __backend.setLength(value);
	}

	@:noCompletion private function get_loops():Int
	{
		return __backend.getLoops();
	}

	@:noCompletion private function set_loops(value:Int):Int
	{
		return __backend.setLoops(value);
	}

	@:noCompletion private function get_pitch():Float
	{
		return __backend.getPitch();
	}

	@:noCompletion private function set_pitch(value:Float):Float
	{
		return __backend.setPitch(value);
	}

	@:noCompletion private function get_position():Vector4
	{
		return __backend.getPosition();
	}

	@:noCompletion private function set_position(value:Vector4):Vector4
	{
		return __backend.setPosition(value);
	}

	@:noCompletion private function get_latency():Float
	{
		return __backend.getLatency();
	}
}

@:noCompletion private typedef AudioSourceBackend = {
	public function init():Void;
	public function initFromBytes():Void;
	public function initFromFile(path:String):Void;
	public function initFromAudioBuffer(sampleRate:Int, channels:Int, format:MiniaudioFormat, pcmFrames:BytesData, pcmFrameCount:Int):Void;
	public function dispose():Void;
	public function play():Void;
	public function pause():Void;
	public function stop():Void;
	public function getCurrentTime():Float;
	public function setCurrentTime(value:Float):Float;
	public function getGain():Float;
	public function setGain(value:Float):Float;
	public function getLength():Float;
	public function setLength(value:Float):Float;
	public function getLoops():Int;
	public function setLoops(value:Int):Int;
	public function getPitch():Float;
	public function setPitch(value:Float):Float;
	public function getPosition():Vector4;
	public function setPosition(value:Vector4):Vector4;
	public function getLatency():Float;
	public function isPlaying():Bool;
	public function readbackPcm():MiniaudioAudioSourceReadbackData;
};
