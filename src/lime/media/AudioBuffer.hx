package lime.media;

import haxe.Int64;
import haxe.io.Bytes;
import haxe.io.Path;
import lime._internal.backend.native.NativeCFFI;
import lime._internal.format.Base64;
import lime.app.Future;
import lime.app.Promise;
import lime.media.openal.AL;
import lime.media.openal.ALBuffer;
import lime.net.HTTPRequest;
import lime.utils.Log;
import lime.utils.UInt8Array;

/**
	The `AudioBuffer` class represents a buffer of audio data that can be played back using an `AudioSource`.
	It supports a variety of audio formats and platforms, providing a consistent API for loading and managing audio data.

	Depending on the platform, the audio backend may differ, but the class provides a unified interface for accessing
	audio data, whether it's stored in memory, loaded from a file, or streamed.

	@see lime.media.AudioSource
**/
@:access(lime._internal.backend.native.NativeCFFI)
@:access(lime.utils.Assets)
class AudioBuffer
{
	/**
		The number of bits per sample in the audio data.
	**/
	public var bitsPerSample(get, never):Int;

	/**
		The number of audio channels (e.g., 1 for mono, 2 for stereo).
	**/
	public var channels:Int;

	/**
		The raw audio data stored as a `UInt8Array`.
	**/
	public var data:UInt8Array;

	/**
		The format the raw audio data is stored in.
	**/
	public var dataFormat:AudioFormat;

	/**
		The sample rate of the audio data, in Hz.
	**/
	public var sampleRate:Int;

	/**
		The source of the audio data. This can be an `Audio`, `Sound`, or other platform-specific object.
	**/
	public var src(get, set):Dynamic;

	@:noCompletion private var __srcBuffer:#if lime_cffi ALBuffer #else Dynamic #end;
	@:noCompletion private var __srcCustom:Dynamic;


	public function new() {}

	public function dispose():Void {}

	public static function fromBase64(base64String:String):AudioBuffer
	{
		if (base64String == null) return null;

		#if (lime_cffi && !macro)
		var base64StringSplit = base64String.split(",");
		var base64StringNoEncoding = base64StringSplit[base64StringSplit.length - 1];
		var decoder:AudioDecoder = AudioDecoder.fromBytes(Base64.decode(base64StringNoEncoding));

		if (decoder != null)
		{
			var buffer:AudioBuffer = new AudioBuffer();
			buffer.sampleRate = decoder.sampleRate;
			buffer.channels = decoder.channels;
			buffer.dataFormat = S16;
			buffer.data = UInt8Array.fromBytes(decoder.decode(Int64.toInt(decoder.total()), buffer.dataFormat));
			return buffer;
		}
		#end

		return null;
	}

	public static function fromBytes(bytes:Bytes):AudioBuffer
	{
		if (bytes == null) return null;

		#if (lime_cffi && !macro)
		var decoder:AudioDecoder = AudioDecoder.fromBytes(bytes);

		if (decoder != null)
		{
			var buffer:AudioBuffer = new AudioBuffer();
			buffer.sampleRate = decoder.sampleRate;
			buffer.channels = decoder.channels;
			buffer.dataFormat = S16;
			buffer.data = UInt8Array.fromBytes(decoder.decode(Int64.toInt(decoder.total()), buffer.dataFormat));
			return buffer;
		}
		#end

		return null;
	}

	public static function fromFile(path:String):AudioBuffer
	{
		if (path == null) return null;

		#if (lime_cffi && !macro)
		var decoder:AudioDecoder = AudioDecoder.fromFile(path);

		if (decoder != null)
		{
			var buffer:AudioBuffer = new AudioBuffer();
			buffer.sampleRate = decoder.sampleRate;
			buffer.channels = decoder.channels;
			buffer.dataFormat = S16;
			buffer.data = UInt8Array.fromBytes(decoder.decode(Int64.toInt(decoder.total()), buffer.dataFormat));
			return buffer;
		}
		#end

		return null;
	}

	public static function fromFiles(paths:Array<String>):AudioBuffer
	{
		var buffer = null;

		for (path in paths)
		{
			buffer = AudioBuffer.fromFile(path);
			if (buffer != null) break;
		}

		return buffer;
	}

	public static function loadFromFile(path:String):Future<AudioBuffer>
	{
		var request = new HTTPRequest<AudioBuffer>();
		return request.load(path).then(function(buffer)
		{
			if (buffer != null)
			{
				return Future.withValue(buffer);
			}
			else
			{
				return cast Future.withError("");
			}
		});
	}

	public static function loadFromFiles(paths:Array<String>):Future<AudioBuffer>
	{
		return new Future(fromFiles.bind(paths), true);
	}

	public static function __getCodec(bytes:Bytes):String
	{
		var signature:String = null;
		try
		{
			signature = bytes.getString(0, 4);
		}
		catch (e:Dynamic) {}

		switch (signature)
		{
			case "OggS":
				return "audio/ogg";
			case "fLaC":
				return "audio/flac";
			case "RIFF" if (bytes.getString(8, 4) == "WAVE"):
				return "audio/wav";
			default:
				switch ([bytes.get(0), bytes.get(1), bytes.get(2)])
				{
					case [73, 68, 51] | [255, 251, _] | [255, 250, _] | [255, 243, _]: return "audio/mp3";
					default:
				}
		}

		Log.error("Unsupported sound format");
		return null;
	}

	@:noCompletion private function get_bitsPerSample():Int
	{
		return switch (dataFormat)
		{
			case S16: 16;
			case F32: 32;
			default: 0;
		}
	}

	@:noCompletion private function get_src():Dynamic
	{
		return __srcCustom;
	}

	@:noCompletion private function set_src(value:Dynamic):Dynamic
	{
		return __srcCustom = value;
	}
}
