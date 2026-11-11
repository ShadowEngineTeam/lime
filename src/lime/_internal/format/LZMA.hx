package lime._internal.format;

import haxe.io.Bytes;

import lime._internal.backend.native.NativeCFFI;
import lime.utils.UInt8Array;

@:access(lime._internal.backend.native.NativeCFFI)
class LZMA
{
	public static function compress(bytes:Bytes):Bytes
	{
		#if (lime_cffi && !macro)
		var result:Bytes = Bytes.alloc(0);

		if (NativeCFFI.lime_lzma_compress(bytes, result))
		{
			return result;
		}

		return null;
		#else
		return null;
		#end
	}

	public static function decompress(bytes:Bytes):Bytes
	{
		#if (lime_cffi && !macro)
		var result:Bytes = Bytes.alloc(0);

		if (NativeCFFI.lime_lzma_decompress(bytes, result))
		{
			return result;
		}

		return null;
		#else
		return null;
		#end
	}
}
