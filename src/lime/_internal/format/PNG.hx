package lime._internal.format;

import haxe.io.Bytes;
import lime._internal.backend.native.NativeCFFI;
import lime.graphics.Image;
import lime.graphics.ImageBuffer;
import lime.utils.UInt8Array;
@:access(lime._internal.backend.native.NativeCFFI)
@:access(lime.graphics.ImageBuffer)
class PNG
{
	public static function decodeBytes(bytes:Bytes):Image
	{
		#if (lime_cffi && !macro)
		var buffer = NativeCFFI.lime_png_decode_bytes(bytes, new ImageBuffer(new UInt8Array(Bytes.alloc(0))));

		if (buffer != null)
		{
			return new Image(buffer);
		}
		#end

		return null;
	}

	public static function decodeFile(path:String):Image
	{
		#if (lime_cffi && !macro)
		var buffer = NativeCFFI.lime_png_decode_file(path, new ImageBuffer(new UInt8Array(Bytes.alloc(0))));

		if (buffer != null)
		{
			return new Image(buffer);
		}
		#end

		return null;
	}

	public static function encode(image:Image):Bytes
	{
		if (image.premultiplied || image.format != RGBA32)
		{
			// TODO: Handle encode from different formats

			image = image.clone();
			image.premultiplied = false;
			image.format = RGBA32;
		}

		#if (lime_cffi && !macro)
		return NativeCFFI.lime_image_encode(image.buffer, 0, 0, Bytes.alloc(0));
		#end

		return null;
	}
}
