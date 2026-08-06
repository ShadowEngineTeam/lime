package lime._internal.backend.native;

import lime.app.Application;
import lime.math.Vector4;
import lime.media.MiniaudioFormat;
import lime.media.AudioSource;
import lime.media.AudioManager;
import lime._internal.backend.native.NativeCFFI;

import haxe.io.Bytes;
import haxe.io.BytesData;

typedef MiniaudioAudioSourceReadbackData = {
	var format:MiniaudioFormat;
	var channels:Int;
	var sampleRate:Int;
	var pcmFrameCount:Int;
	final pcmFrames:BytesData;
}

#if (lime_cffi && lime_miniaudio && !macro)
@:include("hx/GC.h")
#end
@:access(lime._internal.backend.native.NativeCFFI)
class NativeMiniaudioAudioSource
{
	private var parent:AudioSource;
	private var soundIndex:Int;
	private var stream:Bool;
	private var completed:Bool;
	private var paused:Bool;
	private var rootedPcmFrames:BytesData;

	public function new(parent:AudioSource, stream:Bool)
	{
		this.parent = parent;
		soundIndex = -1;
		this.stream = stream;
		completed = false;
		paused = true;
	}

	private function checkCallback(_):Void
	{
		if (!isPlaying() && !paused && !completed) {
			parent.onComplete.dispatch();
			completed = true;
		}
	}

	public function dispose():Void
	{
		#if (lime_cffi && lime_miniaudio && !macro)
		if (soundIndex != -1)
		{
			NativeCFFI.lime_miniaudio_backend_sound_uninit(soundIndex);
			soundIndex = -1; // the slot is free for reuse now, never touch it again from here
		}
		if (stream && parent.data != null) {
			untyped __cpp__("hx::GCRemoveRoot((hx::Object**)(&{0}.mPtr))", parent.data);
		}
		if (rootedPcmFrames != null) {
			untyped __cpp__("hx::GCRemoveRoot((hx::Object**)(&{0}.mPtr))", rootedPcmFrames);
			rootedPcmFrames = null;
		}
		#end
		if (Application.current.onUpdate.has(checkCallback)) {
			Application.current.onUpdate.remove(checkCallback);
		}
	}

	public function init():Void
	{
	}

	public function initFromFile(path:String)
	{
		#if (lime_cffi && lime_miniaudio && !macro)
		soundIndex = NativeCFFI.lime_miniaudio_backend_sound_init_from_file(AudioManager.context.maEngine, parent.offset, cpp.ConstCharStar.fromString(path));
		#end
		if (soundIndex != -1 && !Application.current.onUpdate.has(checkCallback)) {
			Application.current.onUpdate.add(checkCallback);
		}
	}

	public function initFromBytes():Void
	{
		#if (lime_cffi && lime_miniaudio && !macro)
		if (stream) {
			untyped __cpp__("hx::GCAddRoot((hx::Object**)(&{0}.mPtr))", parent.data); // root the handle field (heap-stable address); rooting getData()'s temporary would register a dead stack address
		}
		soundIndex = NativeCFFI.lime_miniaudio_backend_sound_init_from_bytes(AudioManager.context.maEngine, parent.offset, stream, parent.data.getData());
		#end
		if (soundIndex != -1 && !Application.current.onUpdate.has(checkCallback)) {
			Application.current.onUpdate.add(checkCallback);
		}
	}

	public function initFromAudioBuffer(sampleRate:Int, channels:Int, format:MiniaudioFormat, pcmFrames:BytesData, pcmFrameCount:Int):Void
	{
		#if (lime_cffi && lime_miniaudio && !macro)
		rootedPcmFrames = pcmFrames;
		untyped __cpp__("hx::GCAddRoot((hx::Object**)(&{0}.mPtr))", rootedPcmFrames); // the ma_audio_buffer references this memory without copying it, so GC must not collect or move it (root the field, not the param -- the param is a stack local, so its address becomes invalid once this function returns)
		soundIndex = NativeCFFI.lime_miniaudio_backend_sound_init_from_audio_buffer(AudioManager.context.maEngine, parent.offset, sampleRate, channels, format, pcmFrames, pcmFrameCount);
		#end
		if (soundIndex != -1 && !Application.current.onUpdate.has(checkCallback)) {
			Application.current.onUpdate.add(checkCallback);
		}
	}

	public function play():Void
	{
		completed = false; // restarting if completed
		paused = false;
		#if (lime_cffi && lime_miniaudio && !macro)
		if (soundIndex != -1)
		{
			NativeCFFI.lime_miniaudio_backend_sound_start(soundIndex);
		}
		#end
	}

	public function pause():Void
	{
		paused = true;
		#if (lime_cffi && lime_miniaudio && !macro)
		if (soundIndex != -1)
		{
			NativeCFFI.lime_miniaudio_backend_sound_stop(soundIndex);
		}
		#end
	}

	public function stop():Void
	{
		paused = true;
		#if (lime_cffi && lime_miniaudio && !macro)
		if (soundIndex != -1)
		{
			NativeCFFI.lime_miniaudio_backend_sound_reset(soundIndex, parent.offset);
		}
		#end
	}

	public function getCurrentTime():Float
	{
		#if (lime_cffi && lime_miniaudio && !macro)
		if (soundIndex != -1)
		{
			return NativeCFFI.lime_miniaudio_backend_sound_get_time(soundIndex, parent.offset);
		}
		#end
		return 0;
	}

	public function setCurrentTime(value:Float):Float
	{
		#if (lime_cffi && lime_miniaudio && !macro)
		if (soundIndex != -1)
		{
			NativeCFFI.lime_miniaudio_backend_sound_set_time(soundIndex, parent.offset, value);
		}
		#end
		return value;
	}

	public function getGain():Float
	{
		#if (lime_cffi && lime_miniaudio && !macro)
		if (soundIndex != -1)
		{
			return NativeCFFI.lime_miniaudio_backend_sound_get_volume(soundIndex);
		}
		#end
		return 0;
	}

	public function setGain(value:Float):Float
	{
		#if (lime_cffi && lime_miniaudio && !macro)
		if (soundIndex != -1)
		{
			NativeCFFI.lime_miniaudio_backend_sound_set_volume(soundIndex, value);
		}
		#end
		return value;
	}

	public function getLength():Float
	{
		#if (lime_cffi && lime_miniaudio && !macro)
		if (soundIndex != -1)
		{
			return NativeCFFI.lime_miniaudio_backend_sound_get_length(soundIndex, parent.offset);
		}
		#end
		return 0;
	}

	public function setLength(value:Float):Float
	{
		#if (lime_cffi && lime_miniaudio && !macro)
		if (soundIndex != -1)
		{
			NativeCFFI.lime_miniaudio_backend_sound_set_length(soundIndex, parent.offset, value);
		}
		#end
		return value;
	}

	public function getLoops():Int
	{
		#if (lime_cffi && lime_miniaudio && !macro)
		if (soundIndex != -1)
		{
			return NativeCFFI.lime_miniaudio_backend_sound_get_loops(soundIndex);
		}
		#end
		return 0;
	}

	public function setLoops(value:Int):Int
	{
		#if (lime_cffi && lime_miniaudio && !macro)
		if (soundIndex != -1)
		{
			NativeCFFI.lime_miniaudio_backend_sound_set_loops(soundIndex, value);
		}
		#end
		return value;
	}

	public function getPitch():Float
	{
		#if (lime_cffi && lime_miniaudio && !macro)
		if (soundIndex != -1)
		{
			return NativeCFFI.lime_miniaudio_backend_sound_get_pitch(soundIndex);
		}
		#end
		return 0;
	}

	public function setPitch(value:Float):Float
	{
		#if (lime_cffi && lime_miniaudio && !macro)
		if (soundIndex != -1)
		{
			NativeCFFI.lime_miniaudio_backend_sound_set_pitch(soundIndex, value);
		}
		#end
		return value;
	}

	public function getPosition():Vector4
	{
		#if (lime_cffi && lime_miniaudio && !macro)
		if (soundIndex != -1)
		{
			var pos:Array<Float> = NativeCFFI.lime_miniaudio_backend_sound_get_position(soundIndex);
			return new Vector4(pos[0], pos[1], pos[2], 0.0);
		}
		#end
		return new Vector4();
	}

	public function setPosition(value:Vector4):Vector4
	{
		#if (lime_cffi && lime_miniaudio && !macro)
		if (soundIndex != -1)
		{
			NativeCFFI.lime_miniaudio_backend_sound_set_position(soundIndex, value.x, value.y, value.z);
		}
		#end
		return value;
	}

	public function isPlaying():Bool
	{
		#if (lime_cffi && lime_miniaudio && !macro)
		if (soundIndex != -1)
		{
			return NativeCFFI.lime_miniaudio_backend_sound_is_playing(soundIndex);
		}
		#end
		return false;
	}

	public function readbackPcm():MiniaudioAudioSourceReadbackData
	{
		if (stream) {
			lime.utils.Log.error("ma_sound with index " + soundIndex + " is streamed and does not support readback");
			return null;
		}

		var cppReadbackData:Dynamic = null;
		#if (lime_cffi && lime_miniaudio && !macro)
		if (soundIndex != -1)
		{
			cppReadbackData = NativeCFFI.lime_miniaudio_backend_sound_readback_pcm(soundIndex);
		}
		#end

		if (cppReadbackData == null)
		{
			lime.utils.Log.error("ma_sound with index " + soundIndex + " does not support readback");
			return null;
		}

		var readbackData:MiniaudioAudioSourceReadbackData = {
			format: cppReadbackData.format,
			channels: cppReadbackData.channels,
			sampleRate: cppReadbackData.sampleRate,
			pcmFrameCount: cppReadbackData.pcmFrameCount,
			pcmFrames: new BytesData()
		};

		var byteCount = readbackData.pcmFrameCount * readbackData.format.getBytesPerFrame(readbackData.channels);

		#if (lime_cffi && lime_miniaudio && !macro)
		cpp.NativeArray.setUnmanagedData(readbackData.pcmFrames, cppReadbackData.pcmFrames, byteCount);
		#end

		return readbackData;
	}

	public function getLatency():Float
	{
		return 0;
	}
}
