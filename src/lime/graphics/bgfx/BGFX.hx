package lime.graphics.bgfx;

#if (!lime_doc_gen || lime_cffi)
import lime._internal.backend.native.NativeCFFI;
import lime.graphics.bgfx.BGFXVertexLayout;
import lime.ui.Window;
import lime.utils.ArrayBufferView;
import lime.utils.DataPointer;
import lime.utils.UInt8Array;

/**
	Haxe access to the bgfx rendering library (https://github.com/bkaradzic/bgfx).

	This mirrors the bgfx C++ API. All object handles (buffers, textures,
	shaders, programs, uniforms, frame buffers) are `Int` values wrapping
	bgfx's 16-bit handles; `BGFX.INVALID_HANDLE` (0xFFFF) marks failure.

	64-bit flag fields (render state, texture flags) are passed as two
	`Int` values (`hi`, `lo`); the constants below are provided pre-split.

	bgfx is initialized once per process, for the primary window:

	```haxe
	BGFX.init (window, AUTO, BGFX.RESET_VSYNC);
	```

	Rendering submits draw calls into views and finishes each frame with
	`BGFX.frame ()`.
**/
@:access(lime._internal.backend.native.NativeCFFI)
@:access(lime.ui.Window)
class BGFX
{
	public static inline var INVALID_HANDLE = 0xFFFF;

	// BGFX_RESET_*
	public static inline var RESET_NONE = 0x00000000;
	public static inline var RESET_MSAA_X2 = 0x00000010;
	public static inline var RESET_MSAA_X4 = 0x00000020;
	public static inline var RESET_MSAA_X8 = 0x00000030;
	public static inline var RESET_MSAA_X16 = 0x00000040;
	public static inline var RESET_VSYNC = 0x00000080;
	public static inline var RESET_MAXANISOTROPY = 0x00000100;
	public static inline var RESET_FULLSCREEN = 0x00000001;
	public static inline var RESET_HIDPI = 0x00020000;

	// BGFX_CLEAR_*
	public static inline var CLEAR_NONE = 0x0000;
	public static inline var CLEAR_COLOR = 0x0001;
	public static inline var CLEAR_DEPTH = 0x0002;
	public static inline var CLEAR_STENCIL = 0x0004;

	// BGFX_DEBUG_*
	public static inline var DEBUG_NONE = 0x00000000;
	public static inline var DEBUG_WIREFRAME = 0x00000001;
	public static inline var DEBUG_STATS = 0x00000004;
	public static inline var DEBUG_TEXT = 0x00000008;

	// BGFX_DISCARD_*
	public static inline var DISCARD_NONE = 0x00;
	public static inline var DISCARD_ALL = 0xFF;

	// BGFX_BUFFER_*
	public static inline var BUFFER_NONE = 0x0000;
	public static inline var BUFFER_ALLOW_RESIZE = 0x0800;
	public static inline var BUFFER_INDEX32 = 0x1000;

	// BGFX_STATE_* — 64-bit, split into (hi, lo) pairs
	public static inline var STATE_WRITE_R_LO = 0x00000001;
	public static inline var STATE_WRITE_G_LO = 0x00000002;
	public static inline var STATE_WRITE_B_LO = 0x00000004;
	public static inline var STATE_WRITE_A_LO = 0x00000008;
	public static inline var STATE_WRITE_RGB_LO = 0x00000007;
	public static inline var STATE_WRITE_Z_HI = 0x00000040;

	public static inline var STATE_DEPTH_TEST_LESS_LO = 0x00000010;
	public static inline var STATE_DEPTH_TEST_LEQUAL_LO = 0x00000020;
	public static inline var STATE_DEPTH_TEST_EQUAL_LO = 0x00000030;
	public static inline var STATE_DEPTH_TEST_GEQUAL_LO = 0x00000040;
	public static inline var STATE_DEPTH_TEST_GREATER_LO = 0x00000050;
	public static inline var STATE_DEPTH_TEST_NOTEQUAL_LO = 0x00000060;
	public static inline var STATE_DEPTH_TEST_NEVER_LO = 0x00000070;
	public static inline var STATE_DEPTH_TEST_ALWAYS_LO = 0x00000080;

	// blend function components (already shifted, all in the low word)
	public static inline var STATE_BLEND_ZERO_LO = 0x00001000;
	public static inline var STATE_BLEND_ONE_LO = 0x00002000;
	public static inline var STATE_BLEND_SRC_COLOR_LO = 0x00003000;
	public static inline var STATE_BLEND_INV_SRC_COLOR_LO = 0x00004000;
	public static inline var STATE_BLEND_SRC_ALPHA_LO = 0x00005000;
	public static inline var STATE_BLEND_INV_SRC_ALPHA_LO = 0x00006000;
	public static inline var STATE_BLEND_DST_ALPHA_LO = 0x00007000;
	public static inline var STATE_BLEND_INV_DST_ALPHA_LO = 0x00008000;
	public static inline var STATE_BLEND_DST_COLOR_LO = 0x00009000;
	public static inline var STATE_BLEND_INV_DST_COLOR_LO = 0x0000A000;
	public static inline var STATE_BLEND_SRC_ALPHA_SAT_LO = 0x0000B000;
	public static inline var STATE_BLEND_FACTOR_LO = 0x0000C000;
	public static inline var STATE_BLEND_INV_FACTOR_LO = 0x0000D000;

	public static inline var STATE_CULL_CW_HI = 0x00000010;
	public static inline var STATE_CULL_CCW_HI = 0x00000020;

	// blend equations, RGB and alpha combined (BGFX_STATE_BLEND_EQUATION(v) =
	// v | v << 3; the alpha field crosses into the high word)
	public static inline var STATE_BLEND_EQUATION_ADD_HI = 0x00000000;
	public static inline var STATE_BLEND_EQUATION_ADD_LO = 0x00000000;
	public static inline var STATE_BLEND_EQUATION_SUB_HI = 0x00000000;
	public static inline var STATE_BLEND_EQUATION_SUB_LO = 0x90000000;
	public static inline var STATE_BLEND_EQUATION_REVSUB_HI = 0x00000001;
	public static inline var STATE_BLEND_EQUATION_REVSUB_LO = 0x20000000;
	public static inline var STATE_BLEND_EQUATION_MIN_HI = 0x00000001;
	public static inline var STATE_BLEND_EQUATION_MIN_LO = 0xB0000000;
	public static inline var STATE_BLEND_EQUATION_MAX_HI = 0x00000002;
	public static inline var STATE_BLEND_EQUATION_MAX_LO = 0x40000000;

	public static inline var STATE_PT_TRISTRIP_HI = 0x00010000;
	public static inline var STATE_PT_LINES_HI = 0x00020000;
	public static inline var STATE_PT_LINESTRIP_HI = 0x00030000;
	public static inline var STATE_PT_POINTS_HI = 0x00040000;

	public static inline var STATE_MSAA_HI = 0x01000000;

	// BGFX_STATE_DEFAULT = WRITE_RGB|WRITE_A|WRITE_Z|DEPTH_TEST_LESS|CULL_CW|MSAA
	public static inline var STATE_DEFAULT_HI = 0x01000050;
	public static inline var STATE_DEFAULT_LO = 0x0000001F;

	// common 2D state: RGBA write, no depth, no cull
	public static inline var STATE_2D_HI = 0x00000000;
	public static inline var STATE_2D_LO = 0x0000000F;

	// BGFX_TEXTURE_* — 64-bit, split into (hi, lo)
	public static inline var TEXTURE_NONE = 0x00000000;
	public static inline var TEXTURE_MSAA_SAMPLE_HI = 0x00000008;
	public static inline var TEXTURE_RT_HI = 0x00000010;
	public static inline var TEXTURE_BLIT_DST_HI = 0x00000100;
	public static inline var TEXTURE_READ_BACK_HI = 0x00000200;
	public static inline var TEXTURE_SRGB_HI = 0x00002000;

	// BGFX_SAMPLER_* (32-bit, passed as texture flags low word or setTexture flags)
	public static inline var SAMPLER_NONE = 0x00000000;
	public static inline var SAMPLER_U_CLAMP = 0x00000002;
	public static inline var SAMPLER_V_CLAMP = 0x00000008;
	public static inline var SAMPLER_UV_CLAMP = 0x0000000A;
	public static inline var SAMPLER_MIN_POINT = 0x00000040;
	public static inline var SAMPLER_MAG_POINT = 0x00000100;
	public static inline var SAMPLER_MIP_POINT = 0x00000400;
	public static inline var SAMPLER_POINT = 0x00000540;

	/** Use as `flags` in setTexture to keep the flags from texture creation. **/
	public static inline var SAMPLER_INHERIT = -1; // UINT32_MAX

	// stencil state (packed 32-bit, pass to setStencil; see bgfx defines.h).
	// ref value lives in bits 0-7, read mask in bits 8-15. There is no write
	// mask in bgfx (always full 8 bits).
	public static inline var STENCIL_NONE = 0x00000000;
	public static inline var STENCIL_TEST_LESS = 0x00010000;
	public static inline var STENCIL_TEST_LEQUAL = 0x00020000;
	public static inline var STENCIL_TEST_EQUAL = 0x00030000;
	public static inline var STENCIL_TEST_GEQUAL = 0x00040000;
	public static inline var STENCIL_TEST_GREATER = 0x00050000;
	public static inline var STENCIL_TEST_NOTEQUAL = 0x00060000;
	public static inline var STENCIL_TEST_NEVER = 0x00070000;
	public static inline var STENCIL_TEST_ALWAYS = 0x00080000;

	public static inline var STENCIL_FUNC_REF_SHIFT = 0;
	public static inline var STENCIL_FUNC_RMASK_SHIFT = 8;
	public static inline var STENCIL_OP_FAIL_S_SHIFT = 20;
	public static inline var STENCIL_OP_FAIL_Z_SHIFT = 24;
	public static inline var STENCIL_OP_PASS_Z_SHIFT = 28;

	// op codes, shift into one of the three STENCIL_OP_*_SHIFT fields
	public static inline var STENCIL_OP_ZERO = 0;
	public static inline var STENCIL_OP_KEEP = 1;
	public static inline var STENCIL_OP_REPLACE = 2;
	public static inline var STENCIL_OP_INCR = 3;
	public static inline var STENCIL_OP_INCRSAT = 4;
	public static inline var STENCIL_OP_DECR = 5;
	public static inline var STENCIL_OP_DECRSAT = 6;
	public static inline var STENCIL_OP_INVERT = 7;

	/**
		Build a blend function state value (low word) from source and
		destination factors, applied to both color and alpha.
		Equivalent to BGFX_STATE_BLEND_FUNC.
	**/
	public static inline function blendFunction(src:Int, dst:Int):Int
	{
		return blendFunctionSeparate(src, dst, src, dst);
	}

	/**
		Equivalent to BGFX_STATE_BLEND_FUNC_SEPARATE.
	**/
	public static inline function blendFunctionSeparate(srcRGB:Int, dstRGB:Int, srcA:Int, dstA:Int):Int
	{
		return (srcRGB | (dstRGB << 4)) | ((srcA | (dstA << 4)) << 8);
	}

	public static var initialized(default, null):Bool = false;

	public static var rendererType(get, never):BGFXRendererType;

	/**
		Initialize bgfx against a lime window. Must be called once, before
		any other BGFX call, on the main thread.
	**/
	public static function init(window:Window, rendererType:BGFXRendererType = AUTO, resetFlags:Int = RESET_VSYNC):Bool
	{
		return __init(window.__backend.handle, window.__width, window.__height, rendererType, resetFlags);
	}

	// used by NativeWindow during window creation, before window.__backend is assigned
	@:noCompletion private static function __init(handle:Dynamic, width:Int, height:Int, rendererType:BGFXRendererType, resetFlags:Int):Bool
	{
		if (initialized) return true;
		#if (lime_cffi && !macro)
		initialized = NativeCFFI.lime_bgfx_init(handle, width, height, rendererType, resetFlags);
		#end
		return initialized;
	}

	public static function shutdown():Void
	{
		#if (lime_cffi && !macro)
		if (initialized) NativeCFFI.lime_bgfx_shutdown();
		#end
		initialized = false;
	}

	public static inline function reset(width:Int, height:Int, flags:Int = RESET_VSYNC):Void
	{
		NativeCFFI.lime_bgfx_reset(width, height, flags);
	}

	/** Advance to the next frame; returns the frame number. **/
	public static inline function frame(capture:Bool = false):Int
	{
		return NativeCFFI.lime_bgfx_frame(capture);
	}

	public static inline function touch(viewId:Int):Void
	{
		NativeCFFI.lime_bgfx_touch(viewId);
	}

	public static inline function setDebug(flags:Int):Void
	{
		NativeCFFI.lime_bgfx_set_debug(flags);
	}

	public static inline function dbgTextClear():Void
	{
		NativeCFFI.lime_bgfx_dbg_text_clear();
	}

	public static inline function dbgTextPrint(x:Int, y:Int, attr:Int, text:String):Void
	{
		NativeCFFI.lime_bgfx_dbg_text_print(x, y, attr, text);
	}

	private static inline function get_rendererType():BGFXRendererType
	{
		return NativeCFFI.lime_bgfx_get_renderer_type();
	}

	public static inline function getCapsMaxTextureSize():Int
	{
		return NativeCFFI.lime_bgfx_get_caps_max_texture_size();
	}

	public static inline function getCapsHomogeneousDepth():Bool
	{
		return NativeCFFI.lime_bgfx_get_caps_homogeneous_depth();
	}

	public static inline function getCapsOriginBottomLeft():Bool
	{
		return NativeCFFI.lime_bgfx_get_caps_origin_bottom_left();
	}

	// views

	public static inline function setViewRect(viewId:Int, x:Int, y:Int, width:Int, height:Int):Void
	{
		NativeCFFI.lime_bgfx_set_view_rect(viewId, x, y, width, height);
	}

	public static inline function setViewScissor(viewId:Int, x:Int = 0, y:Int = 0, width:Int = 0, height:Int = 0):Void
	{
		NativeCFFI.lime_bgfx_set_view_scissor(viewId, x, y, width, height);
	}

	public static inline function setViewClear(viewId:Int, flags:Int, rgba:Int = 0x000000FF, depth:Float = 1.0, stencil:Int = 0):Void
	{
		NativeCFFI.lime_bgfx_set_view_clear(viewId, flags, rgba, depth, stencil);
	}

	public static inline function setViewMode(viewId:Int, mode:BGFXViewMode):Void
	{
		NativeCFFI.lime_bgfx_set_view_mode(viewId, mode);
	}

	/** `view` and `proj` are 4x4 float32 matrices (either may be null). **/
	public static inline function setViewTransform(viewId:Int, view:ArrayBufferView, proj:ArrayBufferView):Void
	{
		var viewPointer:DataPointer = view != null ? view : 0;
		var projPointer:DataPointer = proj != null ? proj : 0;
		NativeCFFI.lime_bgfx_set_view_transform(viewId, viewPointer, projPointer);
	}

	public static inline function setViewFrameBuffer(viewId:Int, frameBuffer:Int):Void
	{
		NativeCFFI.lime_bgfx_set_view_frame_buffer(viewId, frameBuffer);
	}

	// buffers

	public static inline function createVertexBuffer(data:ArrayBufferView, layout:BGFXVertexLayout, flags:Int = BUFFER_NONE):Int
	{
		return NativeCFFI.lime_bgfx_create_vertex_buffer(data, data.byteLength, layout.handle, flags);
	}

	public static inline function destroyVertexBuffer(handle:Int):Void
	{
		NativeCFFI.lime_bgfx_destroy_vertex_buffer(handle);
	}

	public static inline function createDynamicVertexBuffer(num:Int, layout:BGFXVertexLayout, flags:Int = BUFFER_NONE):Int
	{
		return NativeCFFI.lime_bgfx_create_dynamic_vertex_buffer(num, layout.handle, flags);
	}

	public static inline function updateDynamicVertexBuffer(handle:Int, startVertex:Int, data:ArrayBufferView):Void
	{
		NativeCFFI.lime_bgfx_update_dynamic_vertex_buffer(handle, startVertex, data, data.byteLength);
	}

	public static inline function destroyDynamicVertexBuffer(handle:Int):Void
	{
		NativeCFFI.lime_bgfx_destroy_dynamic_vertex_buffer(handle);
	}

	public static inline function createIndexBuffer(data:ArrayBufferView, flags:Int = BUFFER_NONE):Int
	{
		return NativeCFFI.lime_bgfx_create_index_buffer(data, data.byteLength, flags);
	}

	public static inline function destroyIndexBuffer(handle:Int):Void
	{
		NativeCFFI.lime_bgfx_destroy_index_buffer(handle);
	}

	public static inline function createDynamicIndexBuffer(num:Int, flags:Int = BUFFER_NONE):Int
	{
		return NativeCFFI.lime_bgfx_create_dynamic_index_buffer(num, flags);
	}

	public static inline function updateDynamicIndexBuffer(handle:Int, startIndex:Int, data:ArrayBufferView):Void
	{
		NativeCFFI.lime_bgfx_update_dynamic_index_buffer(handle, startIndex, data, data.byteLength);
	}

	public static inline function destroyDynamicIndexBuffer(handle:Int):Void
	{
		NativeCFFI.lime_bgfx_destroy_dynamic_index_buffer(handle);
	}

	/**
		Allocate a transient (single-frame) vertex buffer, copy `numVertices`
		vertices from `data` and bind it to `stream` for the next submit.
		Returns the number of vertices actually allocated (0 on failure).
	**/
	public static inline function setTransientVertexBuffer(stream:Int, data:ArrayBufferView, numVertices:Int, layout:BGFXVertexLayout):Int
	{
		return NativeCFFI.lime_bgfx_set_transient_vertex_buffer(stream, data, numVertices, layout.handle);
	}

	/**
		Allocate a transient (single-frame) index buffer, copy `numIndices`
		indices from `data` and bind it for the next submit. Returns the
		number of indices actually allocated (0 on failure).
	**/
	public static inline function setTransientIndexBuffer(data:ArrayBufferView, numIndices:Int, index32:Bool = false):Int
	{
		return NativeCFFI.lime_bgfx_set_transient_index_buffer(data, numIndices, index32);
	}

	// shaders + programs

	/** `data` points to a compiled bgfx shader binary (shaderc output). **/
	public static inline function createShader(data:ArrayBufferView):Int
	{
		return NativeCFFI.lime_bgfx_create_shader(data, data.byteLength);
	}

	public static inline function destroyShader(handle:Int):Void
	{
		NativeCFFI.lime_bgfx_destroy_shader(handle);
	}

	public static inline function createProgram(vertexShader:Int, fragmentShader:Int, destroyShaders:Bool = false):Int
	{
		return NativeCFFI.lime_bgfx_create_program(vertexShader, fragmentShader, destroyShaders);
	}

	public static inline function destroyProgram(handle:Int):Void
	{
		NativeCFFI.lime_bgfx_destroy_program(handle);
	}

	// uniforms

	public static inline function createUniform(name:String, type:BGFXUniformType, num:Int = 1):Int
	{
		return NativeCFFI.lime_bgfx_create_uniform(name, type, num);
	}

	public static inline function destroyUniform(handle:Int):Void
	{
		NativeCFFI.lime_bgfx_destroy_uniform(handle);
	}

	public static inline function setUniform(handle:Int, data:ArrayBufferView, num:Int = 1):Void
	{
		NativeCFFI.lime_bgfx_set_uniform(handle, data, num);
	}

	// textures

	/** Pass `data = null` (with `size = 0`) to create an uninitialized texture. **/
	public static inline function createTexture2D(width:Int, height:Int, hasMips:Bool, numLayers:Int, format:BGFXTextureFormat, flagsHi:Int = 0,
			flagsLo:Int = 0, ?data:ArrayBufferView):Int
	{
		var pointer:DataPointer = (data != null) ? data : 0;
		return NativeCFFI.lime_bgfx_create_texture_2d(width, height, hasMips, numLayers, format, flagsHi, flagsLo, pointer,
			data != null ? data.byteLength : 0);
	}

	public static inline function updateTexture2D(handle:Int, layer:Int, mip:Int, x:Int, y:Int, width:Int, height:Int, data:ArrayBufferView,
			pitch:Int = 0):Void
	{
		NativeCFFI.lime_bgfx_update_texture_2d(handle, layer, mip, x, y, width, height, data, data.byteLength, pitch);
	}

	public static inline function destroyTexture(handle:Int):Void
	{
		NativeCFFI.lime_bgfx_destroy_texture(handle);
	}

	/**
		Read texture data back into `data` (texture must be created with
		TEXTURE_READ_BACK). Returns the frame number when data is available.
	**/
	public static inline function readTexture(handle:Int, data:ArrayBufferView, mip:Int = 0):Int
	{
		return NativeCFFI.lime_bgfx_read_texture(handle, data, mip);
	}

	// frame buffers

	public static inline function createFrameBuffer(width:Int, height:Int, format:BGFXTextureFormat, flagsHi:Int = TEXTURE_RT_HI, flagsLo:Int = 0):Int
	{
		return NativeCFFI.lime_bgfx_create_frame_buffer(width, height, format, flagsHi, flagsLo);
	}

	public static inline function getFrameBufferTexture(handle:Int, attachment:Int = 0):Int
	{
		return NativeCFFI.lime_bgfx_get_frame_buffer_texture(handle, attachment);
	}

	/**
		Creates a framebuffer from existing texture handles (created with
		`TEXTURE_RT`). The textures stay owned by the caller. Pass -1 for
		`depthStencil` to attach only the color target.
	**/
	public static inline function createFrameBufferFromTextures(color:Int, depthStencil:Int = -1):Int
	{
		return NativeCFFI.lime_bgfx_create_frame_buffer_from_textures(color, depthStencil);
	}

	public static inline function destroyFrameBuffer(handle:Int):Void
	{
		NativeCFFI.lime_bgfx_destroy_frame_buffer(handle);
	}

	// draw state + submission

	public static inline function setState(stateHi:Int, stateLo:Int, rgba:Int = 0):Void
	{
		NativeCFFI.lime_bgfx_set_state(stateHi, stateLo, rgba);
	}

	public static inline function setStencil(fstencil:Int, bstencil:Int = 0):Void
	{
		NativeCFFI.lime_bgfx_set_stencil(fstencil, bstencil);
	}

	public static inline function setScissor(x:Int, y:Int, width:Int, height:Int):Int
	{
		return NativeCFFI.lime_bgfx_set_scissor(x, y, width, height);
	}

	/** `data` points to `num` 4x4 float32 model matrices; returns cache index. **/
	public static inline function setTransform(data:ArrayBufferView, num:Int = 1):Int
	{
		return NativeCFFI.lime_bgfx_set_transform(data, num);
	}

	public static inline function setVertexBuffer(stream:Int, handle:Int, startVertex:Int = 0, numVertices:Int = -1):Void
	{
		NativeCFFI.lime_bgfx_set_vertex_buffer(stream, handle, startVertex, numVertices);
	}

	public static inline function setDynamicVertexBuffer(stream:Int, handle:Int, startVertex:Int = 0, numVertices:Int = -1):Void
	{
		NativeCFFI.lime_bgfx_set_dynamic_vertex_buffer(stream, handle, startVertex, numVertices);
	}

	/**
		Allocates a transient vertex buffer that can be rebound for several
		draws within the same frame via `setTransientVertexBufferSlot`.
		Returns a slot id, or -1 when it does not fit (all-or-nothing).
		Slots are frame-scoped: `frame()` invalidates them all.
	**/
	public static inline function allocTransientVertexBufferSlot(data:ArrayBufferView, numVertices:Int, layout:BGFXVertexLayout):Int
	{
		return NativeCFFI.lime_bgfx_alloc_transient_vertex_buffer_slot(data, numVertices, layout.handle);
	}

	public static inline function setTransientVertexBufferSlot(stream:Int, slot:Int):Void
	{
		NativeCFFI.lime_bgfx_set_transient_vertex_buffer_slot(stream, slot);
	}

	/**
		Creates a reusable layout handle from a `BGFXVertexLayout`, for binding
		buffers with a different layout than they were created with.
	**/
	public static inline function createVertexLayoutHandle(layout:BGFXVertexLayout):Int
	{
		return NativeCFFI.lime_bgfx_create_vertex_layout_handle(layout.handle);
	}

	public static inline function destroyVertexLayoutHandle(handle:Int):Void
	{
		NativeCFFI.lime_bgfx_destroy_vertex_layout_handle(handle);
	}

	/** Binds a vertex buffer, overriding its creation layout with `layoutHandle`. **/
	public static inline function setVertexBufferWithLayout(stream:Int, handle:Int, startVertex:Int, numVertices:Int, layoutHandle:Int):Void
	{
		NativeCFFI.lime_bgfx_set_vertex_buffer_layout(stream, handle, startVertex, numVertices, layoutHandle);
	}

	/** Binds a dynamic vertex buffer, overriding its creation layout with `layoutHandle`. **/
	public static inline function setDynamicVertexBufferWithLayout(stream:Int, handle:Int, startVertex:Int, numVertices:Int, layoutHandle:Int):Void
	{
		NativeCFFI.lime_bgfx_set_dynamic_vertex_buffer_layout(stream, handle, startVertex, numVertices, layoutHandle);
	}

	public static inline function setIndexBuffer(handle:Int, firstIndex:Int = 0, numIndices:Int = -1):Void
	{
		NativeCFFI.lime_bgfx_set_index_buffer(handle, firstIndex, numIndices);
	}

	public static inline function setDynamicIndexBuffer(handle:Int, firstIndex:Int = 0, numIndices:Int = -1):Void
	{
		NativeCFFI.lime_bgfx_set_dynamic_index_buffer(handle, firstIndex, numIndices);
	}

	public static inline function setTexture(stage:Int, sampler:Int, texture:Int, flags:Int = SAMPLER_INHERIT):Void
	{
		NativeCFFI.lime_bgfx_set_texture(stage, sampler, texture, flags);
	}

	public static inline function submit(viewId:Int, program:Int, depth:Int = 0, discardFlags:Int = DISCARD_ALL):Void
	{
		NativeCFFI.lime_bgfx_submit(viewId, program, depth, discardFlags);
	}

	public static inline function discard(flags:Int = DISCARD_ALL):Void
	{
		NativeCFFI.lime_bgfx_discard(flags);
	}

	public static inline function blit(viewId:Int, dst:Int, dstX:Int, dstY:Int, src:Int, srcX:Int = 0, srcY:Int = 0, width:Int = 0xFFFF,
			height:Int = 0xFFFF):Void
	{
		NativeCFFI.lime_bgfx_blit(viewId, dst, dstX, dstY, src, srcX, srcY, width, height);
	}

	public static inline function requestScreenShot(frameBuffer:Int, path:String):Void
	{
		NativeCFFI.lime_bgfx_request_screen_shot(frameBuffer, path);
	}

	// runtime shader compilation (LIME_BGFX_SHADERC, desktop targets)

	/**
		Whether this lime build includes the runtime shader compiler.
	**/
	public static inline function shadercAvailable():Bool
	{
		return NativeCFFI.lime_bgfx_shaderc_available();
	}

	/**
		Compile bgfx shader source (.sc dialect) at runtime.

		`type` is "v", "f" or "c". `varyingDef` is the contents of the
		varying.def.sc describing the shader's inputs/outputs. When `platform`
		or `profile` are null they are derived from the active renderer.

		Returns the compiled shader binary (feed to `createShader`), or null
		on failure — check `getShaderCompileMessages` for the error log.
	**/
	public static function compileShader(source:String, type:String, ?platform:String, ?profile:String, varyingDef:String = "", includeDir:String = "",
			debug:Bool = false):UInt8Array
	{
		if (platform == null) platform = defaultShaderPlatform();
		if (profile == null) profile = defaultShaderProfile();

		var bytes = NativeCFFI.lime_bgfx_compile_shader(source, type, platform, profile, varyingDef, includeDir, debug, haxe.io.Bytes.alloc(0));
		return bytes != null ? UInt8Array.fromBytes(bytes) : null;
	}

	/**
		Warnings/errors from the most recent `compileShader` call.
	**/
	public static function getShaderCompileMessages():String
	{
		#if hl
		var bytes = NativeCFFI.lime_bgfx_get_shader_compile_messages();
		return bytes == null ? "" : @:privateAccess String.fromUTF8(bytes);
		#else
		var result:Dynamic = NativeCFFI.lime_bgfx_get_shader_compile_messages();
		return result == null ? "" : Std.string(result);
		#end
	}

	/**
		The shaderc platform name matching the current renderer/host.
	**/
	public static function defaultShaderPlatform():String
	{
		return switch (rendererType)
		{
			case DIRECT3D11, DIRECT3D12: "windows";
			case METAL: #if (ios || tvos) "ios" #else "osx" #end;
			case OPENGLES: "android";
			default: #if windows "windows" #elseif mac "osx" #else "linux" #end;
		}
	}

	/**
		The shaderc profile matching the current renderer.
	**/
	public static function defaultShaderProfile():String
	{
		return switch (rendererType)
		{
			case DIRECT3D11, DIRECT3D12: "s_5_0";
			case METAL: "metal";
			case VULKAN: "spirv";
			case WEBGPU: "wgsl";
			case OPENGLES: "300_es";
			default: "140";
		}
	}
}
#end
