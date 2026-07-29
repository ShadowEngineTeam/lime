package lime.utils;

import lime.utils.ArrayBufferView;

@:transitive
@:forward
@:arrayAccess
abstract UInt8ClampedArray(ArrayBufferView) from ArrayBufferView to ArrayBufferView
{
	public inline static var BYTES_PER_ELEMENT:Int = 1;

	public var length(get, never):Int;

	public inline function new<T>(?elements:Int, ?buffer:ArrayBuffer, ?array:Array<T>, #if openfl ?vector:openfl.Vector<Int>, #end ?view:ArrayBufferView,
			?byteoffset:Int = 0, ?len:Null<Int>)
	{
		if (elements != null)
		{
			this = new ArrayBufferView(elements, Uint8Clamped);
		}
		else if (array != null)
		{
			this = new ArrayBufferView(0, Uint8Clamped).initArray(array);
		#if openfl
		}
		else if (vector != null)
		{
			this = new ArrayBufferView(0, Uint8Clamped).initArray(untyped (vector).__array);
		#end
		}
		else if (view != null)
		{
			this = new ArrayBufferView(0, Uint8Clamped).initTypedArray(view);
		}
		else if (buffer != null)
		{
			this = new ArrayBufferView(0, Uint8Clamped).initBuffer(buffer, byteoffset, len);
		}
		else
		{
			throw "Invalid constructor arguments for UInt8ClampedArray";
		}
	}

	// Public API
	public inline function subarray(begin:Int, end:Null<Int> = null):UInt8ClampedArray
		return this.subarray(begin, end);

	// non spec haxe conversions
	inline public static function fromBytes(bytes:haxe.io.Bytes, ?byteOffset:Int = 0, ?len:Int):UInt8ClampedArray
	{
		return new UInt8ClampedArray(bytes, byteOffset, len);
	}

	inline public function toBytes():haxe.io.Bytes
	{
		return this.buffer;
	}

	// Internal
	inline function get_length()
		return this.length;

	@:noCompletion
	@:arrayAccess
	extern public inline function __get(idx:Int)
	{
		return ArrayBufferIO.getUint8(this.buffer, this.byteOffset + idx);
	}

	@:noCompletion
	@:arrayAccess
	extern public inline function __set(idx:Int, val:UInt)
	{
		ArrayBufferIO.setUint8Clamped(this.buffer, this.byteOffset + idx, val);
		return val;
	}

	inline function toString()
		return this != null ? 'UInt8ClampedArray [byteLength:${this.byteLength}, length:${this.length}]' : null;
}
