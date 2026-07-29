package lime.utils;

import lime.utils.ArrayBufferView;

@:transitive
@:forward
abstract Float64Array(ArrayBufferView) from ArrayBufferView to ArrayBufferView
{
	public inline static var BYTES_PER_ELEMENT:Int = 8;

	public var length(get, never):Int;

	public inline function new<T>(?elements:Int, ?buffer:ArrayBuffer, ?array:Array<T>, #if openfl ?vector:openfl.Vector<Float>, #end ?view:ArrayBufferView,
			?byteoffset:Int = 0, ?len:Null<Int>)
	{
		if (elements != null)
		{
			this = new ArrayBufferView(elements, Float64);
		}
		else if (array != null)
		{
			this = new ArrayBufferView(0, Float64).initArray(array);
		#if openfl
		}
		else if (vector != null)
		{
			this = new ArrayBufferView(0, Float64).initArray(untyped (vector).__array);
		#end
		}
		else if (view != null)
		{
			this = new ArrayBufferView(0, Float64).initTypedArray(view);
		}
		else if (buffer != null)
		{
			this = new ArrayBufferView(0, Float64).initBuffer(buffer, byteoffset, len);
		}
		else
		{
			throw "Invalid constructor arguments for Float64Array";
		}
	}

	// Public API
	public inline function subarray(begin:Int, end:Null<Int> = null):Float64Array
		return this.subarray(begin, end);

	// non spec haxe conversions
	inline public static function fromBytes(bytes:haxe.io.Bytes, ?byteOffset:Int = 0, ?len:Int):Float64Array
	{
		return new Float64Array(bytes, byteOffset, len);
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
	extern public inline function __get(idx:Int):Float
	{
		return ArrayBufferIO.getFloat64(this.buffer, this.byteOffset + (idx * BYTES_PER_ELEMENT));
	}

	@:noCompletion
	@:arrayAccess
	extern public inline function __set(idx:Int, val:Float):Float
	{
		ArrayBufferIO.setFloat64(this.buffer, this.byteOffset + (idx * BYTES_PER_ELEMENT), val);
		return val;
	}

	inline function toString()
		return this != null ? 'Float64Array [byteLength:${this.byteLength}, length:${this.length}]' : null;
}
