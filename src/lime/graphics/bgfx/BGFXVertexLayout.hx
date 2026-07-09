package lime.graphics.bgfx;

#if (!lime_doc_gen || lime_cffi)
import lime._internal.backend.native.NativeCFFI;
import lime.system.CFFIPointer;

/**
	A bgfx vertex layout (`bgfx::VertexLayout`), describing the structure of
	one vertex stream. Build it with `begin` / `add` / `skip` / `end` before
	creating vertex buffers with it.
**/
@:access(lime._internal.backend.native.NativeCFFI)
class BGFXVertexLayout
{
	@:noCompletion public var handle(default, null):CFFIPointer;

	public var stride(get, never):Int;

	public function new()
	{
		handle = NativeCFFI.lime_bgfx_vertex_layout_create();
	}

	public function begin(rendererType:BGFXRendererType = AUTO):BGFXVertexLayout
	{
		NativeCFFI.lime_bgfx_vertex_layout_begin(handle, rendererType);
		return this;
	}

	public function add(attrib:BGFXAttrib, num:Int, type:BGFXAttribType, normalized:Bool = false, asInt:Bool = false):BGFXVertexLayout
	{
		NativeCFFI.lime_bgfx_vertex_layout_add(handle, attrib, num, type, normalized, asInt);
		return this;
	}

	public function skip(num:Int):BGFXVertexLayout
	{
		NativeCFFI.lime_bgfx_vertex_layout_skip(handle, num);
		return this;
	}

	public function end():BGFXVertexLayout
	{
		NativeCFFI.lime_bgfx_vertex_layout_end(handle);
		return this;
	}

	private function get_stride():Int
	{
		return NativeCFFI.lime_bgfx_vertex_layout_get_stride(handle);
	}
}

/**
	Renderer types, mirroring `bgfx::RendererType` of the vendored bgfx
	(values are cast directly by the native bindings; keep in sync when
	updating bgfx). `AUTO` is bgfx's `Count`, which selects the platform's
	preferred renderer.
**/
enum abstract BGFXRendererType(Int) from Int to Int
{
	var NOOP = 0;
	var AGC = 1;
	var DIRECT3D11 = 2;
	var DIRECT3D12 = 3;
	var GNM = 4;
	var METAL = 5;
	var NVN = 6;
	var OPENGLES = 7;
	var OPENGL = 8;
	var VULKAN = 9;
	var WEBGPU = 10;
	var AUTO = 11;
}

/**
	Vertex attribute semantics (matches `bgfx::Attrib`).
**/
enum abstract BGFXAttrib(Int) from Int to Int
{
	var POSITION = 0;
	var NORMAL = 1;
	var TANGENT = 2;
	var BITANGENT = 3;
	var COLOR0 = 4;
	var COLOR1 = 5;
	var COLOR2 = 6;
	var COLOR3 = 7;
	var INDICES = 8;
	var WEIGHT = 9;
	var TEXCOORD0 = 10;
	var TEXCOORD1 = 11;
	var TEXCOORD2 = 12;
	var TEXCOORD3 = 13;
	var TEXCOORD4 = 14;
	var TEXCOORD5 = 15;
	var TEXCOORD6 = 16;
	var TEXCOORD7 = 17;
}

/**
	Vertex attribute data types, mirroring `bgfx::AttribType` of the
	vendored bgfx (cast directly; keep in sync when updating bgfx).
**/
enum abstract BGFXAttribType(Int) from Int to Int
{
	var INT8 = 0;
	var UINT8 = 1;
	var UINT10 = 2;
	var INT16 = 3;
	var UINT16 = 4;
	var HALF = 5;
	var FLOAT = 6;
}

/**
	Uniform types (matches `bgfx::UniformType`).
**/
enum abstract BGFXUniformType(Int) from Int to Int
{
	var SAMPLER = 0;
	var VEC4 = 2;
	var MAT3 = 3;
	var MAT4 = 4;
}

/**
	View sorting modes (matches `bgfx::ViewMode`).
**/
enum abstract BGFXViewMode(Int) from Int to Int
{
	var DEFAULT = 0;
	var SEQUENTIAL = 1;
	var DEPTH_ASCENDING = 2;
	var DEPTH_DESCENDING = 3;
}

/**
	Common texture formats, mirroring `bgfx::TextureFormat` of the vendored
	bgfx (cast directly; keep in sync when updating bgfx).
**/
enum abstract BGFXTextureFormat(Int) from Int to Int
{
	var BC1 = 0;
	var BC2 = 1;
	var BC3 = 2;
	var BC4 = 3;
	var BC5 = 4;
	var BC6H = 5;
	var BC7 = 6;
	// signed BCn formats added to the vendored bgfx (everything after BC7
	// shifted +3 relative to upstream)
	var BC4S = 7;
	var BC5S = 8;
	var BC6HS = 9;
	var ASTC4x4 = 27;
	var ASTC5x4 = 28;
	var ASTC5x5 = 29;
	var ASTC6x5 = 30;
	var ASTC6x6 = 31;
	var ASTC8x5 = 32;
	var ASTC8x6 = 33;
	var ASTC8x8 = 34;
	var ASTC10x5 = 35;
	var ASTC10x6 = 36;
	var ASTC10x8 = 37;
	var ASTC10x10 = 38;
	var ASTC12x10 = 39;
	var ASTC12x12 = 40;
	var R8 = 44;
	var R16F = 51;
	var R32F = 55;
	var RG8 = 56;
	var RGB8 = 68;
	var BGRA8 = 73;
	var RGBA8 = 74;
	var RGBA8S = 77;
	var RGBA16F = 81;
	var RGBA32F = 85;
	var D16 = 95;
	var D24 = 96;
	var D24S8 = 97;
	var D32 = 98;
	var D16F = 99;
	var D24F = 100;
	var D32F = 101;
	var D0S8 = 102;
}
#end
