package lime.graphics.opengl.ext;

@:keep
@:noCompletion class ARB_texture_compression_bptc
{
	public var COMPRESSED_RGB_BPTC_SIGNED_FLOAT_ARB = 0x8E8E;
	public var COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT_ARB = 0x8E8F;
	public var COMPRESSED_RGBA_BPTC_UNORM_ARB = 0x8E8C;
	public var COMPRESSED_SRGB_ALPHA_BPTC_UNORM_ARB = 0x8E8D;
	public var COMPRESSED_TEXTURE_FORMATS_ARB = 0x86A3;
	public var NUM_COMPRESSED_TEXTURE_FORMATS_ARB = 0x86A2;
	public var TEXTURE_COMPRESSED_ARB = 0x86A1;
	public var TEXTURE_COMPRESSED_IMAGE_SIZE_ARB = 0x86A0;
	public var TEXTURE_COMPRESSION_HINT_ARB = 0x84EF;

	@:noCompletion private function new() {}
}
