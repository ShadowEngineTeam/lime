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
		return NativeCFFI.lime_lzma_compress(bytes, Bytes.alloc(0));
		#else
		return null;
		#end
	}

	public static function decompress(bytes:Bytes):Bytes
	{
		#if (lime_cffi && !macro)
		return NativeCFFI.lime_lzma_decompress(bytes, Bytes.alloc(0));
		#else
		return null;
		#end
	}
}
