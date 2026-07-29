package lime.graphics;

import haxe.io.Bytes;
import lime.graphics.cairo.CairoSurface;
import lime.utils.UInt8Array;

/**
	`ImageBuffer` is a simple object for storing image data.

	For higher-level operations, use the `Image` class.
**/
@:allow(lime.graphics.Image)
class ImageBuffer
{
	/**
		The number of bits per pixel in this image data
	**/
	public var bitsPerPixel:Int;

	/**
		The data for this image, represented as a `UInt8Array`
	**/
	public var data:UInt8Array;

	/**
		The `PixelFormat` for this image data
	**/
	public var format:PixelFormat;

	/**
		The height of this image data
	**/
	public var height:Int;

	/**
		Whether the image data has premultiplied alpha
	**/
	public var premultiplied:Bool;

	/**
		The data for this image
	**/
	public var src(get, set):Dynamic;

	/**
		The stride, or number of data values (in bytes) per row in the image data
	**/
	public var stride(get, never):Int;

	/**
		Whether this image data is transparent
	**/
	public var transparent:Bool;

	/**
		The width of this image data
	**/
	public var width:Int;

	@:noCompletion private var __srcCustom:Dynamic;
	@:noCompletion private var __srcImage:Dynamic;


	/**
		Creates a new `ImageBuffer` instance
		@param	data	(Optional) Initial `UInt8Array` data
		@param	width	(Optional) An initial `width` value
		@param	height	(Optional) An initial `height` value
		@param	bitsPerPixel	(Optional) The `bitsPerPixel` of the data (default is 32)
		@param	format	(Optional) The `PixelFormat` of this image buffer
	**/
	public function new(data:UInt8Array = null, width:Int = 0, height:Int = 0, bitsPerPixel:Int = 32, format:PixelFormat = null)
	{
		this.data = data;
		this.width = width;
		this.height = height;
		this.bitsPerPixel = bitsPerPixel;
		this.format = (format == null ? RGBA32 : format);
		premultiplied = false;
		transparent = true;
	}

	/**
		Creates a duplicate of this `ImageBuffer`

		If the current `ImageBuffer` has `data` or `src` information, this will be
		cloned as well.
		@return	A new `ImageBuffer` with duplicate values
	**/
	public function clone():ImageBuffer
	{
		var buffer = new ImageBuffer(data, width, height, bitsPerPixel);

		if (data != null)
		{
			var bytes = Bytes.alloc(data.byteLength);
			bytes.blit(0, buffer.data.buffer, 0, data.byteLength);
			buffer.data = new UInt8Array(bytes);
		}

		buffer.bitsPerPixel = bitsPerPixel;
		buffer.format = format;
		buffer.premultiplied = premultiplied;
		buffer.transparent = transparent;
		return buffer;
	}

	// Get & Set Methods
	@:noCompletion private function get_src():Dynamic
	{
		return __srcCustom;
	}

	@:noCompletion private function set_src(value:Dynamic):Dynamic
	{
		__srcCustom = value;
		return value;
	}

	@:noCompletion private function get_stride():Int
	{
		return width * Std.int(bitsPerPixel / 8);
	}
}
