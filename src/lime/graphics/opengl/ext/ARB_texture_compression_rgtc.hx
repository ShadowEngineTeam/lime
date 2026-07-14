package lime.graphics.opengl.ext;

@:keep
@:noCompletion class ARB_texture_compression_rgtc
{
	public var COMPRESSED_RED_RGTC1_ARB = 0x8DBB;
	public var COMPRESSED_SIGNED_RED_RGTC1_ARB = 0x8DBC;
	public var COMPRESSED_RED_GREEN_RGTC2_ARB = 0x8DBD;
	public var COMPRESSED_SIGNED_RED_GREEN_RGTC2_ARB = 0x8DBE;
	public var COMPRESSED_TEXTURE_FORMATS_ARB = 0x86A3;
	public var NUM_COMPRESSED_TEXTURE_FORMATS_ARB = 0x86A2;
	public var TEXTURE_COMPRESSED_ARB = 0x86A1;
	public var TEXTURE_COMPRESSED_IMAGE_SIZE_ARB = 0x86A0;
	public var TEXTURE_COMPRESSION_HINT_ARB = 0x84EF;

	@:noCompletion private function new() {}
}