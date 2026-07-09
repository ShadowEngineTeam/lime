#include <system/CFFI.h>
#include <system/CFFIPointer.h>
#include <ui/Window.h>

#include <bgfx/bgfx.h>

#include <cstdlib>
#include <cstring>


namespace lime {


	static inline uint64_t ToUInt64 (int hi, int lo) {

		return ((uint64_t)(uint32_t)hi << 32) | (uint64_t)(uint32_t)lo;

	}


	static inline const bgfx::Memory* BGFXCopyMem (double data, int size) {

		if (!data || size <= 0) return 0;
		return bgfx::copy ((const void*)(uintptr_t)data, (uint32_t)size);

	}


	void gc_bgfx_vertex_layout (value handle) {

		bgfx::VertexLayout* layout = (bgfx::VertexLayout*)val_data (handle);
		delete layout;

	}


	void hl_gc_bgfx_vertex_layout (HL_CFFIPointer* handle) {

		bgfx::VertexLayout* layout = (bgfx::VertexLayout*)handle->ptr;
		delete layout;

	}


	// lifecycle


	// returns the bgfx renderer enum for a name, RendererType::Count for
	// "auto"/"default", or -1 when the name is not recognized
	static int ParseRendererName (const char* name) {

		char lower[16];
		size_t length = strlen (name);
		if (length >= sizeof (lower)) return -1;

		for (size_t i = 0; i <= length; i++) {

			char c = name[i];
			lower[i] = (c >= 'A' && c <= 'Z') ? (char)(c + 32) : c;

		}

		if (!strcmp (lower, "noop")) return bgfx::RendererType::Noop;
		if (!strcmp (lower, "d3d11") || !strcmp (lower, "direct3d11")) return bgfx::RendererType::Direct3D11;
		if (!strcmp (lower, "d3d12") || !strcmp (lower, "direct3d12")) return bgfx::RendererType::Direct3D12;
		if (!strcmp (lower, "metal") || !strcmp (lower, "mtl")) return bgfx::RendererType::Metal;
		if (!strcmp (lower, "opengles") || !strcmp (lower, "gles")) return bgfx::RendererType::OpenGLES;
		if (!strcmp (lower, "opengl") || !strcmp (lower, "gl")) return bgfx::RendererType::OpenGL;
		if (!strcmp (lower, "vulkan") || !strcmp (lower, "vk")) return bgfx::RendererType::Vulkan;
		if (!strcmp (lower, "webgpu") || !strcmp (lower, "wgpu")) return bgfx::RendererType::WebGPU;
		//if (!strcmp (lower, "auto") || !strcmp (lower, "default")) return bgfx::RendererType::Count;

		return -1;

	}


	static bool BGFXInit (Window* window, int width, int height, int rendererType, int resetFlags) {

		if (!window) return false;

		bgfx::RendererType::Enum type = (bgfx::RendererType::Enum)rendererType;

		// BGFX_DEFAULT_PLATFORM overrides any requested renderer (debug/user
		// knob, same idea as ANGLE_DEFAULT_PLATFORM); unrecognized values
		// are ignored
		const char* envName = getenv ("BGFX_DEFAULT_PLATFORM");

		if (envName && envName[0]) {

			int envType = ParseRendererName (envName);
			if (envType >= 0) type = (bgfx::RendererType::Enum)envType;

		}

		if (bgfx::RendererType::Count == type) {

			// default renderer: Metal on Apple, Vulkan everywhere else
			#ifdef __APPLE__
			type = bgfx::RendererType::Metal;
			#else
			type = bgfx::RendererType::Vulkan;
			#endif

		}

		bgfx::Init init;
		init.type = type;

		// BGFX_DEBUG_DEVICE=1 enables the native validation layers (D3D debug
		// layer / VK validation) and routes their messages into bgfx trace
		const char* envDebug = getenv ("BGFX_DEBUG_DEVICE");
		if (envDebug && envDebug[0] && envDebug[0] != '0') init.debug = true;

		// if the requested renderer is unavailable or fails to create,
		// rendererCreate tries the remaining compiled-in renderers in score
		// order (the requested type only gets scoring priority): GLES on
		// Android, GL/GLES on Linux, D3D11/D3D12 on Windows, GL on macOS
		init.fallback = true;
		init.resolution.width = (uint32_t)width;
		init.resolution.height = (uint32_t)height;
		init.resolution.reset = (uint32_t)resetFlags;

		// note: resolution.maxFrameLatency = 1 gives the lowest input latency,
		// but collapses to half rate when GPU frames run close to the vsync
		// budget (no queue slack); leave the default and expose a knob later

		init.platformData.nwh = window->GetNativeWindowHandle ();
		init.platformData.ndt = window->GetNativeDisplayHandle ();

		if (!bgfx::init (init)) return false;

		// force the reported 2D limit to 16384 regardless of the driver
		// (3D is clamped to 4096 inside isTextureValid); prevents black
		// boxes from oversized texture allocations
		const_cast<bgfx::Caps*> (bgfx::getCaps ())->limits.maxTextureSize = 16384;

		return true;

	}


	bool lime_bgfx_init (value window, int width, int height, int rendererType, int resetFlags) {

		return BGFXInit ((Window*)val_data (window), width, height, rendererType, resetFlags);

	}


	HL_PRIM bool HL_NAME(hl_bgfx_init) (HL_CFFIPointer* window, int width, int height, int rendererType, int resetFlags) {

		return BGFXInit ((Window*)window->ptr, width, height, rendererType, resetFlags);

	}


	void lime_bgfx_shutdown () {

		bgfx::shutdown ();

	}


	HL_PRIM void HL_NAME(hl_bgfx_shutdown) () {

		bgfx::shutdown ();

	}


	void lime_bgfx_reset (int width, int height, int flags) {

		bgfx::reset ((uint32_t)width, (uint32_t)height, (uint32_t)flags);

	}


	HL_PRIM void HL_NAME(hl_bgfx_reset) (int width, int height, int flags) {

		bgfx::reset ((uint32_t)width, (uint32_t)height, (uint32_t)flags);

	}


	// transient vertex buffer slots: allocate once, rebind for several draws
	// within the same frame (bgfx transient allocations are frame-scoped)

	static const int MAX_TVB_SLOTS = 32;
	static bgfx::TransientVertexBuffer s_tvbSlots[MAX_TVB_SLOTS];
	static uint32_t s_tvbSlotVertices[MAX_TVB_SLOTS];
	static int s_tvbSlotCount = 0;


	int lime_bgfx_frame (bool capture) {

		s_tvbSlotCount = 0;
		return (int)bgfx::frame (capture);

	}


	HL_PRIM int HL_NAME(hl_bgfx_frame) (bool capture) {

		s_tvbSlotCount = 0;
		return (int)bgfx::frame (capture);

	}


	static int BGFXAllocTransientVertexBufferSlot (double data, int numVertices, bgfx::VertexLayout* layout) {

		if (s_tvbSlotCount >= MAX_TVB_SLOTS) return -1;

		uint32_t avail = bgfx::getAvailTransientVertexBuffer ((uint32_t)numVertices, *layout);
		if (avail < (uint32_t)numVertices) return -1;

		int slot = s_tvbSlotCount++;
		bgfx::allocTransientVertexBuffer (&s_tvbSlots[slot], (uint32_t)numVertices, *layout);
		memcpy (s_tvbSlots[slot].data, (const void*)(uintptr_t)data, (size_t)numVertices * layout->getStride ());
		s_tvbSlotVertices[slot] = (uint32_t)numVertices;

		return slot;

	}


	static void BGFXSetTransientVertexBufferSlot (int stream, int slot) {

		if (slot < 0 || slot >= s_tvbSlotCount) return;
		bgfx::setVertexBuffer ((uint8_t)stream, &s_tvbSlots[slot], 0, s_tvbSlotVertices[slot]);

	}


	int lime_bgfx_alloc_transient_vertex_buffer_slot (double data, int numVertices, value layout) {

		return BGFXAllocTransientVertexBufferSlot (data, numVertices, (bgfx::VertexLayout*)val_data (layout));

	}


	HL_PRIM int HL_NAME(hl_bgfx_alloc_transient_vertex_buffer_slot) (double data, int numVertices, HL_CFFIPointer* layout) {

		return BGFXAllocTransientVertexBufferSlot (data, numVertices, (bgfx::VertexLayout*)layout->ptr);

	}


	void lime_bgfx_set_transient_vertex_buffer_slot (int stream, int slot) {

		BGFXSetTransientVertexBufferSlot (stream, slot);

	}


	HL_PRIM void HL_NAME(hl_bgfx_set_transient_vertex_buffer_slot) (int stream, int slot) {

		BGFXSetTransientVertexBufferSlot (stream, slot);

	}


	void lime_bgfx_touch (int viewId) {

		bgfx::touch ((bgfx::ViewId)viewId);

	}


	HL_PRIM void HL_NAME(hl_bgfx_touch) (int viewId) {

		bgfx::touch ((bgfx::ViewId)viewId);

	}


	void lime_bgfx_set_debug (int flags) {

		bgfx::setDebug ((uint32_t)flags);

	}


	HL_PRIM void HL_NAME(hl_bgfx_set_debug) (int flags) {

		bgfx::setDebug ((uint32_t)flags);

	}


	void lime_bgfx_dbg_text_clear () {

		bgfx::dbgTextClear ();

	}


	HL_PRIM void HL_NAME(hl_bgfx_dbg_text_clear) () {

		bgfx::dbgTextClear ();

	}


	void lime_bgfx_dbg_text_print (int x, int y, int attr, HxString text) {

		bgfx::dbgTextPrintf ((uint16_t)x, (uint16_t)y, (uint8_t)attr, "%s", text.__s);

	}


	HL_PRIM void HL_NAME(hl_bgfx_dbg_text_print) (int x, int y, int attr, hl_vstring* text) {

		bgfx::dbgTextPrintf ((uint16_t)x, (uint16_t)y, (uint8_t)attr, "%s", text ? hl_to_utf8 (text->bytes) : "");

	}


	int lime_bgfx_get_renderer_type () {

		return (int)bgfx::getRendererType ();

	}


	HL_PRIM int HL_NAME(hl_bgfx_get_renderer_type) () {

		return (int)bgfx::getRendererType ();

	}


	int lime_bgfx_get_caps_max_texture_size () {

		const bgfx::Caps* caps = bgfx::getCaps ();
		return caps ? (int)caps->limits.maxTextureSize : 0;

	}


	HL_PRIM int HL_NAME(hl_bgfx_get_caps_max_texture_size) () {

		const bgfx::Caps* caps = bgfx::getCaps ();
		return caps ? (int)caps->limits.maxTextureSize : 0;

	}


	bool lime_bgfx_get_caps_homogeneous_depth () {

		const bgfx::Caps* caps = bgfx::getCaps ();
		return caps ? caps->homogeneousDepth : false;

	}


	HL_PRIM bool HL_NAME(hl_bgfx_get_caps_homogeneous_depth) () {

		const bgfx::Caps* caps = bgfx::getCaps ();
		return caps ? caps->homogeneousDepth : false;

	}


	bool lime_bgfx_get_caps_origin_bottom_left () {

		const bgfx::Caps* caps = bgfx::getCaps ();
		return caps ? caps->originBottomLeft : false;

	}


	HL_PRIM bool HL_NAME(hl_bgfx_get_caps_origin_bottom_left) () {

		const bgfx::Caps* caps = bgfx::getCaps ();
		return caps ? caps->originBottomLeft : false;

	}


	// views


	void lime_bgfx_set_view_rect (int viewId, int x, int y, int width, int height) {

		bgfx::setViewRect ((bgfx::ViewId)viewId, (uint16_t)x, (uint16_t)y, (uint16_t)width, (uint16_t)height);

	}


	HL_PRIM void HL_NAME(hl_bgfx_set_view_rect) (int viewId, int x, int y, int width, int height) {

		bgfx::setViewRect ((bgfx::ViewId)viewId, (uint16_t)x, (uint16_t)y, (uint16_t)width, (uint16_t)height);

	}


	void lime_bgfx_set_view_scissor (int viewId, int x, int y, int width, int height) {

		bgfx::setViewScissor ((bgfx::ViewId)viewId, (uint16_t)x, (uint16_t)y, (uint16_t)width, (uint16_t)height);

	}


	HL_PRIM void HL_NAME(hl_bgfx_set_view_scissor) (int viewId, int x, int y, int width, int height) {

		bgfx::setViewScissor ((bgfx::ViewId)viewId, (uint16_t)x, (uint16_t)y, (uint16_t)width, (uint16_t)height);

	}


	void lime_bgfx_set_view_clear (int viewId, int flags, int rgba, double depth, int stencil) {

		bgfx::setViewClear ((bgfx::ViewId)viewId, (uint16_t)flags, (uint32_t)rgba, (float)depth, (uint8_t)stencil);

	}


	HL_PRIM void HL_NAME(hl_bgfx_set_view_clear) (int viewId, int flags, int rgba, double depth, int stencil) {

		bgfx::setViewClear ((bgfx::ViewId)viewId, (uint16_t)flags, (uint32_t)rgba, (float)depth, (uint8_t)stencil);

	}


	void lime_bgfx_set_view_mode (int viewId, int mode) {

		bgfx::setViewMode ((bgfx::ViewId)viewId, (bgfx::ViewMode::Enum)mode);

	}


	HL_PRIM void HL_NAME(hl_bgfx_set_view_mode) (int viewId, int mode) {

		bgfx::setViewMode ((bgfx::ViewId)viewId, (bgfx::ViewMode::Enum)mode);

	}


	void lime_bgfx_set_view_transform (int viewId, double view, double proj) {

		bgfx::setViewTransform ((bgfx::ViewId)viewId, (const void*)(uintptr_t)view, (const void*)(uintptr_t)proj);

	}


	HL_PRIM void HL_NAME(hl_bgfx_set_view_transform) (int viewId, double view, double proj) {

		bgfx::setViewTransform ((bgfx::ViewId)viewId, (const void*)(uintptr_t)view, (const void*)(uintptr_t)proj);

	}


	void lime_bgfx_set_view_frame_buffer (int viewId, int handle) {

		bgfx::FrameBufferHandle fb = { (uint16_t)handle };
		bgfx::setViewFrameBuffer ((bgfx::ViewId)viewId, fb);

	}


	HL_PRIM void HL_NAME(hl_bgfx_set_view_frame_buffer) (int viewId, int handle) {

		bgfx::FrameBufferHandle fb = { (uint16_t)handle };
		bgfx::setViewFrameBuffer ((bgfx::ViewId)viewId, fb);

	}


	// vertex layout


	value lime_bgfx_vertex_layout_create () {

		bgfx::VertexLayout* layout = new bgfx::VertexLayout ();
		return CFFIPointer (layout, gc_bgfx_vertex_layout);

	}


	HL_PRIM HL_CFFIPointer* HL_NAME(hl_bgfx_vertex_layout_create) () {

		bgfx::VertexLayout* layout = new bgfx::VertexLayout ();
		return HLCFFIPointer (layout, (hl_finalizer)hl_gc_bgfx_vertex_layout);

	}


	void lime_bgfx_vertex_layout_begin (value handle, int rendererType) {

		bgfx::RendererType::Enum type = rendererType == (int)bgfx::RendererType::Count
			? bgfx::getRendererType ()
			: (bgfx::RendererType::Enum)rendererType;
		((bgfx::VertexLayout*)val_data (handle))->begin (type);

	}


	HL_PRIM void HL_NAME(hl_bgfx_vertex_layout_begin) (HL_CFFIPointer* handle, int rendererType) {

		bgfx::RendererType::Enum type = rendererType == (int)bgfx::RendererType::Count
			? bgfx::getRendererType ()
			: (bgfx::RendererType::Enum)rendererType;
		((bgfx::VertexLayout*)handle->ptr)->begin (type);

	}


	void lime_bgfx_vertex_layout_add (value handle, int attrib, int num, int type, bool normalized, bool asInt) {

		((bgfx::VertexLayout*)val_data (handle))->add ((bgfx::Attrib::Enum)attrib, (uint8_t)num, (bgfx::AttribType::Enum)type, normalized, asInt);

	}


	HL_PRIM void HL_NAME(hl_bgfx_vertex_layout_add) (HL_CFFIPointer* handle, int attrib, int num, int type, bool normalized, bool asInt) {

		((bgfx::VertexLayout*)handle->ptr)->add ((bgfx::Attrib::Enum)attrib, (uint8_t)num, (bgfx::AttribType::Enum)type, normalized, asInt);

	}


	void lime_bgfx_vertex_layout_skip (value handle, int num) {

		((bgfx::VertexLayout*)val_data (handle))->skip ((uint8_t)num);

	}


	HL_PRIM void HL_NAME(hl_bgfx_vertex_layout_skip) (HL_CFFIPointer* handle, int num) {

		((bgfx::VertexLayout*)handle->ptr)->skip ((uint8_t)num);

	}


	void lime_bgfx_vertex_layout_end (value handle) {

		((bgfx::VertexLayout*)val_data (handle))->end ();

	}


	HL_PRIM void HL_NAME(hl_bgfx_vertex_layout_end) (HL_CFFIPointer* handle) {

		((bgfx::VertexLayout*)handle->ptr)->end ();

	}


	int lime_bgfx_vertex_layout_get_stride (value handle) {

		return (int)((bgfx::VertexLayout*)val_data (handle))->getStride ();

	}


	HL_PRIM int HL_NAME(hl_bgfx_vertex_layout_get_stride) (HL_CFFIPointer* handle) {

		return (int)((bgfx::VertexLayout*)handle->ptr)->getStride ();

	}


	// buffers


	int lime_bgfx_create_vertex_buffer (double data, int size, value layout, int flags) {

		const bgfx::Memory* mem = BGFXCopyMem (data, size);
		if (!mem) return bgfx::kInvalidHandle;
		return bgfx::createVertexBuffer (mem, *(bgfx::VertexLayout*)val_data (layout), (uint16_t)flags).idx;

	}


	HL_PRIM int HL_NAME(hl_bgfx_create_vertex_buffer) (double data, int size, HL_CFFIPointer* layout, int flags) {

		const bgfx::Memory* mem = BGFXCopyMem (data, size);
		if (!mem) return bgfx::kInvalidHandle;
		return bgfx::createVertexBuffer (mem, *(bgfx::VertexLayout*)layout->ptr, (uint16_t)flags).idx;

	}


	void lime_bgfx_destroy_vertex_buffer (int handle) {

		bgfx::VertexBufferHandle h = { (uint16_t)handle };
		bgfx::destroy (h);

	}


	HL_PRIM void HL_NAME(hl_bgfx_destroy_vertex_buffer) (int handle) {

		bgfx::VertexBufferHandle h = { (uint16_t)handle };
		bgfx::destroy (h);

	}


	int lime_bgfx_create_dynamic_vertex_buffer (int num, value layout, int flags) {

		return bgfx::createDynamicVertexBuffer ((uint32_t)num, *(bgfx::VertexLayout*)val_data (layout), (uint16_t)flags).idx;

	}


	HL_PRIM int HL_NAME(hl_bgfx_create_dynamic_vertex_buffer) (int num, HL_CFFIPointer* layout, int flags) {

		return bgfx::createDynamicVertexBuffer ((uint32_t)num, *(bgfx::VertexLayout*)layout->ptr, (uint16_t)flags).idx;

	}


	void lime_bgfx_update_dynamic_vertex_buffer (int handle, int startVertex, double data, int size) {

		const bgfx::Memory* mem = BGFXCopyMem (data, size);
		if (!mem) return;
		bgfx::DynamicVertexBufferHandle h = { (uint16_t)handle };
		bgfx::update (h, (uint32_t)startVertex, mem);

	}


	HL_PRIM void HL_NAME(hl_bgfx_update_dynamic_vertex_buffer) (int handle, int startVertex, double data, int size) {

		const bgfx::Memory* mem = BGFXCopyMem (data, size);
		if (!mem) return;
		bgfx::DynamicVertexBufferHandle h = { (uint16_t)handle };
		bgfx::update (h, (uint32_t)startVertex, mem);

	}


	void lime_bgfx_destroy_dynamic_vertex_buffer (int handle) {

		bgfx::DynamicVertexBufferHandle h = { (uint16_t)handle };
		bgfx::destroy (h);

	}


	HL_PRIM void HL_NAME(hl_bgfx_destroy_dynamic_vertex_buffer) (int handle) {

		bgfx::DynamicVertexBufferHandle h = { (uint16_t)handle };
		bgfx::destroy (h);

	}


	int lime_bgfx_create_index_buffer (double data, int size, int flags) {

		const bgfx::Memory* mem = BGFXCopyMem (data, size);
		if (!mem) return bgfx::kInvalidHandle;
		return bgfx::createIndexBuffer (mem, (uint16_t)flags).idx;

	}


	HL_PRIM int HL_NAME(hl_bgfx_create_index_buffer) (double data, int size, int flags) {

		const bgfx::Memory* mem = BGFXCopyMem (data, size);
		if (!mem) return bgfx::kInvalidHandle;
		return bgfx::createIndexBuffer (mem, (uint16_t)flags).idx;

	}


	void lime_bgfx_destroy_index_buffer (int handle) {

		bgfx::IndexBufferHandle h = { (uint16_t)handle };
		bgfx::destroy (h);

	}


	HL_PRIM void HL_NAME(hl_bgfx_destroy_index_buffer) (int handle) {

		bgfx::IndexBufferHandle h = { (uint16_t)handle };
		bgfx::destroy (h);

	}


	int lime_bgfx_create_dynamic_index_buffer (int num, int flags) {

		return bgfx::createDynamicIndexBuffer ((uint32_t)num, (uint16_t)flags).idx;

	}


	HL_PRIM int HL_NAME(hl_bgfx_create_dynamic_index_buffer) (int num, int flags) {

		return bgfx::createDynamicIndexBuffer ((uint32_t)num, (uint16_t)flags).idx;

	}


	void lime_bgfx_update_dynamic_index_buffer (int handle, int startIndex, double data, int size) {

		const bgfx::Memory* mem = BGFXCopyMem (data, size);
		if (!mem) return;
		bgfx::DynamicIndexBufferHandle h = { (uint16_t)handle };
		bgfx::update (h, (uint32_t)startIndex, mem);

	}


	HL_PRIM void HL_NAME(hl_bgfx_update_dynamic_index_buffer) (int handle, int startIndex, double data, int size) {

		const bgfx::Memory* mem = BGFXCopyMem (data, size);
		if (!mem) return;
		bgfx::DynamicIndexBufferHandle h = { (uint16_t)handle };
		bgfx::update (h, (uint32_t)startIndex, mem);

	}


	void lime_bgfx_destroy_dynamic_index_buffer (int handle) {

		bgfx::DynamicIndexBufferHandle h = { (uint16_t)handle };
		bgfx::destroy (h);

	}


	HL_PRIM void HL_NAME(hl_bgfx_destroy_dynamic_index_buffer) (int handle) {

		bgfx::DynamicIndexBufferHandle h = { (uint16_t)handle };
		bgfx::destroy (h);

	}


	// transient buffers (alloc + copy + bind in one call)


	static int BGFXSetTransientVertexBuffer (int stream, double data, int numVertices, bgfx::VertexLayout* layout) {

		#ifdef LIME_BGFX_TRACE
		fprintf (stderr, "tvb stream=%d num=%d stride=%d data=%p\n", stream, numVertices, (int)layout->getStride (), (void*)(uintptr_t)data);
		fflush (stderr);
		#endif

		// all-or-nothing: partial pool allocations both render broken data
		// and (with asserts compiled out) can step past the pool's end
		uint32_t avail = bgfx::getAvailTransientVertexBuffer ((uint32_t)numVertices, *layout);
		if (avail < (uint32_t)numVertices) return 0;

		bgfx::TransientVertexBuffer tvb;
		bgfx::allocTransientVertexBuffer (&tvb, avail, *layout);
		memcpy (tvb.data, (const void*)(uintptr_t)data, (size_t)avail * layout->getStride ());
		bgfx::setVertexBuffer ((uint8_t)stream, &tvb, 0, avail);

		#ifdef LIME_BGFX_TRACE
		fprintf (stderr, "tvb ok avail=%u\n", avail);
		fflush (stderr);
		#endif

		return (int)avail;

	}


	int lime_bgfx_set_transient_vertex_buffer (int stream, double data, int numVertices, value layout) {

		return BGFXSetTransientVertexBuffer (stream, data, numVertices, (bgfx::VertexLayout*)val_data (layout));

	}


	HL_PRIM int HL_NAME(hl_bgfx_set_transient_vertex_buffer) (int stream, double data, int numVertices, HL_CFFIPointer* layout) {

		return BGFXSetTransientVertexBuffer (stream, data, numVertices, (bgfx::VertexLayout*)layout->ptr);

	}


	static int BGFXSetTransientIndexBuffer (double data, int numIndices, bool index32) {

		#ifdef LIME_BGFX_TRACE
		fprintf (stderr, "tib num=%d data=%p\n", numIndices, (void*)(uintptr_t)data);
		fflush (stderr);
		#endif

		// all-or-nothing (see BGFXSetTransientVertexBuffer)
		uint32_t avail = bgfx::getAvailTransientIndexBuffer ((uint32_t)numIndices, index32);
		if (avail < (uint32_t)numIndices) return 0;

		bgfx::TransientIndexBuffer tib;
		bgfx::allocTransientIndexBuffer (&tib, avail, index32);
		memcpy (tib.data, (const void*)(uintptr_t)data, (size_t)avail * (index32 ? 4 : 2));
		bgfx::setIndexBuffer (&tib, 0, avail);

		#ifdef LIME_BGFX_TRACE
		fprintf (stderr, "tib ok avail=%u\n", avail);
		fflush (stderr);
		#endif

		return (int)avail;

	}


	int lime_bgfx_set_transient_index_buffer (double data, int numIndices, bool index32) {

		return BGFXSetTransientIndexBuffer (data, numIndices, index32);

	}


	HL_PRIM int HL_NAME(hl_bgfx_set_transient_index_buffer) (double data, int numIndices, bool index32) {

		return BGFXSetTransientIndexBuffer (data, numIndices, index32);

	}


	// shaders + programs


	int lime_bgfx_create_shader (double data, int size) {

		const bgfx::Memory* mem = BGFXCopyMem (data, size);
		if (!mem) return bgfx::kInvalidHandle;
		return bgfx::createShader (mem).idx;

	}


	HL_PRIM int HL_NAME(hl_bgfx_create_shader) (double data, int size) {

		const bgfx::Memory* mem = BGFXCopyMem (data, size);
		if (!mem) return bgfx::kInvalidHandle;
		return bgfx::createShader (mem).idx;

	}


	void lime_bgfx_destroy_shader (int handle) {

		bgfx::ShaderHandle h = { (uint16_t)handle };
		bgfx::destroy (h);

	}


	HL_PRIM void HL_NAME(hl_bgfx_destroy_shader) (int handle) {

		bgfx::ShaderHandle h = { (uint16_t)handle };
		bgfx::destroy (h);

	}


	int lime_bgfx_create_program (int vsh, int fsh, bool destroyShaders) {

		bgfx::ShaderHandle v = { (uint16_t)vsh };
		bgfx::ShaderHandle f = { (uint16_t)fsh };
		return bgfx::createProgram (v, f, destroyShaders).idx;

	}


	HL_PRIM int HL_NAME(hl_bgfx_create_program) (int vsh, int fsh, bool destroyShaders) {

		bgfx::ShaderHandle v = { (uint16_t)vsh };
		bgfx::ShaderHandle f = { (uint16_t)fsh };
		return bgfx::createProgram (v, f, destroyShaders).idx;

	}


	void lime_bgfx_destroy_program (int handle) {

		bgfx::ProgramHandle h = { (uint16_t)handle };
		bgfx::destroy (h);

	}


	HL_PRIM void HL_NAME(hl_bgfx_destroy_program) (int handle) {

		bgfx::ProgramHandle h = { (uint16_t)handle };
		bgfx::destroy (h);

	}


	// uniforms


	int lime_bgfx_create_uniform (HxString name, int type, int num) {

		return bgfx::createUniform (name.__s, (bgfx::UniformType::Enum)type, (uint16_t)num).idx;

	}


	HL_PRIM int HL_NAME(hl_bgfx_create_uniform) (hl_vstring* name, int type, int num) {

		return bgfx::createUniform (name ? hl_to_utf8 (name->bytes) : "", (bgfx::UniformType::Enum)type, (uint16_t)num).idx;

	}


	void lime_bgfx_destroy_uniform (int handle) {

		bgfx::UniformHandle h = { (uint16_t)handle };
		bgfx::destroy (h);

	}


	HL_PRIM void HL_NAME(hl_bgfx_destroy_uniform) (int handle) {

		bgfx::UniformHandle h = { (uint16_t)handle };
		bgfx::destroy (h);

	}


	void lime_bgfx_set_uniform (int handle, double data, int num) {

		bgfx::UniformHandle h = { (uint16_t)handle };
		bgfx::setUniform (h, (const void*)(uintptr_t)data, (uint16_t)num);

	}


	HL_PRIM void HL_NAME(hl_bgfx_set_uniform) (int handle, double data, int num) {

		bgfx::UniformHandle h = { (uint16_t)handle };
		bgfx::setUniform (h, (const void*)(uintptr_t)data, (uint16_t)num);

	}


	// textures


	int lime_bgfx_create_texture_2d (int width, int height, bool hasMips, int numLayers, int format, int flagsHi, int flagsLo, double data, int size) {

		const bgfx::Memory* mem = BGFXCopyMem (data, size);
		return bgfx::createTexture2D ((uint16_t)width, (uint16_t)height, hasMips, (uint16_t)numLayers, (bgfx::TextureFormat::Enum)format, ToUInt64 (flagsHi, flagsLo), mem).idx;

	}


	HL_PRIM int HL_NAME(hl_bgfx_create_texture_2d) (int width, int height, bool hasMips, int numLayers, int format, int flagsHi, int flagsLo, double data, int size) {

		const bgfx::Memory* mem = BGFXCopyMem (data, size);
		return bgfx::createTexture2D ((uint16_t)width, (uint16_t)height, hasMips, (uint16_t)numLayers, (bgfx::TextureFormat::Enum)format, ToUInt64 (flagsHi, flagsLo), mem).idx;

	}


	void lime_bgfx_update_texture_2d (int handle, int layer, int mip, int x, int y, int width, int height, double data, int size, int pitch) {

		const bgfx::Memory* mem = BGFXCopyMem (data, size);
		if (!mem) return;
		bgfx::TextureHandle h = { (uint16_t)handle };
		bgfx::updateTexture2D (h, (uint16_t)layer, (uint8_t)mip, (uint16_t)x, (uint16_t)y, (uint16_t)width, (uint16_t)height, mem, pitch > 0 ? (uint16_t)pitch : UINT16_MAX);

	}


	HL_PRIM void HL_NAME(hl_bgfx_update_texture_2d) (int handle, int layer, int mip, int x, int y, int width, int height, double data, int size, int pitch) {

		const bgfx::Memory* mem = BGFXCopyMem (data, size);
		if (!mem) return;
		bgfx::TextureHandle h = { (uint16_t)handle };
		bgfx::updateTexture2D (h, (uint16_t)layer, (uint8_t)mip, (uint16_t)x, (uint16_t)y, (uint16_t)width, (uint16_t)height, mem, pitch > 0 ? (uint16_t)pitch : UINT16_MAX);

	}


	void lime_bgfx_destroy_texture (int handle) {

		bgfx::TextureHandle h = { (uint16_t)handle };
		bgfx::destroy (h);

	}


	HL_PRIM void HL_NAME(hl_bgfx_destroy_texture) (int handle) {

		bgfx::TextureHandle h = { (uint16_t)handle };
		bgfx::destroy (h);

	}


	int lime_bgfx_read_texture (int handle, double data, int mip) {

		bgfx::TextureHandle h = { (uint16_t)handle };
		return (int)bgfx::readTexture (h, (void*)(uintptr_t)data, (uint8_t)mip);

	}


	HL_PRIM int HL_NAME(hl_bgfx_read_texture) (int handle, double data, int mip) {

		bgfx::TextureHandle h = { (uint16_t)handle };
		return (int)bgfx::readTexture (h, (void*)(uintptr_t)data, (uint8_t)mip);

	}


	// frame buffers


	int lime_bgfx_create_frame_buffer (int width, int height, int format, int flagsHi, int flagsLo) {

		return bgfx::createFrameBuffer ((uint16_t)width, (uint16_t)height, (bgfx::TextureFormat::Enum)format, ToUInt64 (flagsHi, flagsLo)).idx;

	}


	static int BGFXCreateFrameBufferFromTextures (int color, int depthStencil) {

		bgfx::TextureHandle handles[2];
		handles[0] = { (uint16_t)color };
		uint8_t num = 1;

		if (depthStencil >= 0) {

			handles[num++] = { (uint16_t)depthStencil };

		}

		// textures stay owned by the caller (destroyTexture is separate)
		return (int)bgfx::createFrameBuffer (num, handles, false).idx;

	}


	int lime_bgfx_create_frame_buffer_from_textures (int color, int depthStencil) {

		return BGFXCreateFrameBufferFromTextures (color, depthStencil);

	}


	HL_PRIM int HL_NAME(hl_bgfx_create_frame_buffer_from_textures) (int color, int depthStencil) {

		return BGFXCreateFrameBufferFromTextures (color, depthStencil);

	}


	HL_PRIM int HL_NAME(hl_bgfx_create_frame_buffer) (int width, int height, int format, int flagsHi, int flagsLo) {

		return bgfx::createFrameBuffer ((uint16_t)width, (uint16_t)height, (bgfx::TextureFormat::Enum)format, ToUInt64 (flagsHi, flagsLo)).idx;

	}


	int lime_bgfx_get_frame_buffer_texture (int handle, int attachment) {

		bgfx::FrameBufferHandle h = { (uint16_t)handle };
		return bgfx::getTexture (h, (uint8_t)attachment).idx;

	}


	HL_PRIM int HL_NAME(hl_bgfx_get_frame_buffer_texture) (int handle, int attachment) {

		bgfx::FrameBufferHandle h = { (uint16_t)handle };
		return bgfx::getTexture (h, (uint8_t)attachment).idx;

	}


	void lime_bgfx_destroy_frame_buffer (int handle) {

		bgfx::FrameBufferHandle h = { (uint16_t)handle };
		bgfx::destroy (h);

	}


	HL_PRIM void HL_NAME(hl_bgfx_destroy_frame_buffer) (int handle) {

		bgfx::FrameBufferHandle h = { (uint16_t)handle };
		bgfx::destroy (h);

	}


	// draw state + submission


	void lime_bgfx_set_state (int stateHi, int stateLo, int rgba) {

		bgfx::setState (ToUInt64 (stateHi, stateLo), (uint32_t)rgba);

	}


	HL_PRIM void HL_NAME(hl_bgfx_set_state) (int stateHi, int stateLo, int rgba) {

		bgfx::setState (ToUInt64 (stateHi, stateLo), (uint32_t)rgba);

	}


	void lime_bgfx_set_stencil (int fstencil, int bstencil) {

		bgfx::setStencil ((uint32_t)fstencil, (uint32_t)bstencil);

	}


	HL_PRIM void HL_NAME(hl_bgfx_set_stencil) (int fstencil, int bstencil) {

		bgfx::setStencil ((uint32_t)fstencil, (uint32_t)bstencil);

	}


	int lime_bgfx_set_scissor (int x, int y, int width, int height) {

		return (int)bgfx::setScissor ((uint16_t)x, (uint16_t)y, (uint16_t)width, (uint16_t)height);

	}


	HL_PRIM int HL_NAME(hl_bgfx_set_scissor) (int x, int y, int width, int height) {

		return (int)bgfx::setScissor ((uint16_t)x, (uint16_t)y, (uint16_t)width, (uint16_t)height);

	}


	int lime_bgfx_set_transform (double data, int num) {

		return (int)bgfx::setTransform ((const void*)(uintptr_t)data, (uint16_t)num);

	}


	HL_PRIM int HL_NAME(hl_bgfx_set_transform) (double data, int num) {

		return (int)bgfx::setTransform ((const void*)(uintptr_t)data, (uint16_t)num);

	}


	void lime_bgfx_set_vertex_buffer (int stream, int handle, int startVertex, int numVertices) {

		bgfx::VertexBufferHandle h = { (uint16_t)handle };
		bgfx::setVertexBuffer ((uint8_t)stream, h, (uint32_t)startVertex, (uint32_t)numVertices);

	}


	HL_PRIM void HL_NAME(hl_bgfx_set_vertex_buffer) (int stream, int handle, int startVertex, int numVertices) {

		bgfx::VertexBufferHandle h = { (uint16_t)handle };
		bgfx::setVertexBuffer ((uint8_t)stream, h, (uint32_t)startVertex, (uint32_t)numVertices);

	}


	void lime_bgfx_set_dynamic_vertex_buffer (int stream, int handle, int startVertex, int numVertices) {

		bgfx::DynamicVertexBufferHandle h = { (uint16_t)handle };
		bgfx::setVertexBuffer ((uint8_t)stream, h, (uint32_t)startVertex, (uint32_t)numVertices);

	}


	HL_PRIM void HL_NAME(hl_bgfx_set_dynamic_vertex_buffer) (int stream, int handle, int startVertex, int numVertices) {

		bgfx::DynamicVertexBufferHandle h = { (uint16_t)handle };
		bgfx::setVertexBuffer ((uint8_t)stream, h, (uint32_t)startVertex, (uint32_t)numVertices);

	}


	// vertex layout handles: allow binding a buffer with a different layout
	// than it was created with (bgfx resolves attributes at bind time)


	int lime_bgfx_create_vertex_layout_handle (value layout) {

		return (int)bgfx::createVertexLayout (*(bgfx::VertexLayout*)val_data (layout)).idx;

	}


	HL_PRIM int HL_NAME(hl_bgfx_create_vertex_layout_handle) (HL_CFFIPointer* layout) {

		return (int)bgfx::createVertexLayout (*(bgfx::VertexLayout*)layout->ptr).idx;

	}


	void lime_bgfx_destroy_vertex_layout_handle (int handle) {

		bgfx::VertexLayoutHandle h = { (uint16_t)handle };
		bgfx::destroy (h);

	}


	HL_PRIM void HL_NAME(hl_bgfx_destroy_vertex_layout_handle) (int handle) {

		bgfx::VertexLayoutHandle h = { (uint16_t)handle };
		bgfx::destroy (h);

	}


	void lime_bgfx_set_vertex_buffer_layout (int stream, int handle, int startVertex, int numVertices, int layoutHandle) {

		bgfx::VertexBufferHandle h = { (uint16_t)handle };
		bgfx::VertexLayoutHandle l = { (uint16_t)layoutHandle };
		bgfx::setVertexBuffer ((uint8_t)stream, h, (uint32_t)startVertex, (uint32_t)numVertices, l);

	}


	HL_PRIM void HL_NAME(hl_bgfx_set_vertex_buffer_layout) (int stream, int handle, int startVertex, int numVertices, int layoutHandle) {

		bgfx::VertexBufferHandle h = { (uint16_t)handle };
		bgfx::VertexLayoutHandle l = { (uint16_t)layoutHandle };
		bgfx::setVertexBuffer ((uint8_t)stream, h, (uint32_t)startVertex, (uint32_t)numVertices, l);

	}


	void lime_bgfx_set_dynamic_vertex_buffer_layout (int stream, int handle, int startVertex, int numVertices, int layoutHandle) {

		bgfx::DynamicVertexBufferHandle h = { (uint16_t)handle };
		bgfx::VertexLayoutHandle l = { (uint16_t)layoutHandle };
		bgfx::setVertexBuffer ((uint8_t)stream, h, (uint32_t)startVertex, (uint32_t)numVertices, l);

	}


	HL_PRIM void HL_NAME(hl_bgfx_set_dynamic_vertex_buffer_layout) (int stream, int handle, int startVertex, int numVertices, int layoutHandle) {

		bgfx::DynamicVertexBufferHandle h = { (uint16_t)handle };
		bgfx::VertexLayoutHandle l = { (uint16_t)layoutHandle };
		bgfx::setVertexBuffer ((uint8_t)stream, h, (uint32_t)startVertex, (uint32_t)numVertices, l);

	}


	void lime_bgfx_set_index_buffer (int handle, int firstIndex, int numIndices) {

		bgfx::IndexBufferHandle h = { (uint16_t)handle };
		bgfx::setIndexBuffer (h, (uint32_t)firstIndex, (uint32_t)numIndices);

	}


	HL_PRIM void HL_NAME(hl_bgfx_set_index_buffer) (int handle, int firstIndex, int numIndices) {

		bgfx::IndexBufferHandle h = { (uint16_t)handle };
		bgfx::setIndexBuffer (h, (uint32_t)firstIndex, (uint32_t)numIndices);

	}


	void lime_bgfx_set_dynamic_index_buffer (int handle, int firstIndex, int numIndices) {

		bgfx::DynamicIndexBufferHandle h = { (uint16_t)handle };
		bgfx::setIndexBuffer (h, (uint32_t)firstIndex, (uint32_t)numIndices);

	}


	HL_PRIM void HL_NAME(hl_bgfx_set_dynamic_index_buffer) (int handle, int firstIndex, int numIndices) {

		bgfx::DynamicIndexBufferHandle h = { (uint16_t)handle };
		bgfx::setIndexBuffer (h, (uint32_t)firstIndex, (uint32_t)numIndices);

	}


	void lime_bgfx_set_texture (int stage, int sampler, int texture, int flags) {

		bgfx::UniformHandle s = { (uint16_t)sampler };
		bgfx::TextureHandle t = { (uint16_t)texture };
		bgfx::setTexture ((uint8_t)stage, s, t, (uint32_t)flags);

	}


	HL_PRIM void HL_NAME(hl_bgfx_set_texture) (int stage, int sampler, int texture, int flags) {

		bgfx::UniformHandle s = { (uint16_t)sampler };
		bgfx::TextureHandle t = { (uint16_t)texture };
		bgfx::setTexture ((uint8_t)stage, s, t, (uint32_t)flags);

	}


	void lime_bgfx_submit (int viewId, int program, int depth, int discardFlags) {

		bgfx::ProgramHandle p = { (uint16_t)program };
		bgfx::submit ((bgfx::ViewId)viewId, p, (uint32_t)depth, (uint8_t)discardFlags);

	}


	HL_PRIM void HL_NAME(hl_bgfx_submit) (int viewId, int program, int depth, int discardFlags) {

		bgfx::ProgramHandle p = { (uint16_t)program };
		bgfx::submit ((bgfx::ViewId)viewId, p, (uint32_t)depth, (uint8_t)discardFlags);

	}


	void lime_bgfx_discard (int flags) {

		bgfx::discard ((uint8_t)flags);

	}


	HL_PRIM void HL_NAME(hl_bgfx_discard) (int flags) {

		bgfx::discard ((uint8_t)flags);

	}


	void lime_bgfx_blit (int viewId, int dst, int dstX, int dstY, int src, int srcX, int srcY, int width, int height) {

		bgfx::TextureHandle d = { (uint16_t)dst };
		bgfx::TextureHandle s = { (uint16_t)src };
		bgfx::blit ((bgfx::ViewId)viewId, d, 0, (uint16_t)dstX, (uint16_t)dstY, 0, s, 0, (uint16_t)srcX, (uint16_t)srcY, 0, (uint16_t)width, (uint16_t)height, 1);

	}


	HL_PRIM void HL_NAME(hl_bgfx_blit) (int viewId, int dst, int dstX, int dstY, int src, int srcX, int srcY, int width, int height) {

		bgfx::TextureHandle d = { (uint16_t)dst };
		bgfx::TextureHandle s = { (uint16_t)src };
		bgfx::blit ((bgfx::ViewId)viewId, d, 0, (uint16_t)dstX, (uint16_t)dstY, 0, s, 0, (uint16_t)srcX, (uint16_t)srcY, 0, (uint16_t)width, (uint16_t)height, 1);

	}


	void lime_bgfx_request_screen_shot (int frameBuffer, HxString path) {

		bgfx::FrameBufferHandle fb = { (uint16_t)frameBuffer };
		bgfx::requestScreenShot (fb, path.__s);

	}


	HL_PRIM void HL_NAME(hl_bgfx_request_screen_shot) (int frameBuffer, hl_vstring* path) {

		bgfx::FrameBufferHandle fb = { (uint16_t)frameBuffer };
		bgfx::requestScreenShot (fb, path ? hl_to_utf8 (path->bytes) : "");

	}


	DEFINE_PRIME5 (lime_bgfx_init);
	DEFINE_PRIME0v (lime_bgfx_shutdown);
	DEFINE_PRIME3v (lime_bgfx_reset);
	DEFINE_PRIME1 (lime_bgfx_frame);
	DEFINE_PRIME1v (lime_bgfx_touch);
	DEFINE_PRIME1v (lime_bgfx_set_debug);
	DEFINE_PRIME0v (lime_bgfx_dbg_text_clear);
	DEFINE_PRIME4v (lime_bgfx_dbg_text_print);
	DEFINE_PRIME0 (lime_bgfx_get_renderer_type);
	DEFINE_PRIME0 (lime_bgfx_get_caps_max_texture_size);
	DEFINE_PRIME0 (lime_bgfx_get_caps_homogeneous_depth);
	DEFINE_PRIME0 (lime_bgfx_get_caps_origin_bottom_left);
	DEFINE_PRIME5v (lime_bgfx_set_view_rect);
	DEFINE_PRIME5v (lime_bgfx_set_view_scissor);
	DEFINE_PRIME5v (lime_bgfx_set_view_clear);
	DEFINE_PRIME2v (lime_bgfx_set_view_mode);
	DEFINE_PRIME3v (lime_bgfx_set_view_transform);
	DEFINE_PRIME2v (lime_bgfx_set_view_frame_buffer);
	DEFINE_PRIME0 (lime_bgfx_vertex_layout_create);
	DEFINE_PRIME2v (lime_bgfx_vertex_layout_begin);
	DEFINE_PRIME6v (lime_bgfx_vertex_layout_add);
	DEFINE_PRIME2v (lime_bgfx_vertex_layout_skip);
	DEFINE_PRIME1v (lime_bgfx_vertex_layout_end);
	DEFINE_PRIME1 (lime_bgfx_vertex_layout_get_stride);
	DEFINE_PRIME4 (lime_bgfx_create_vertex_buffer);
	DEFINE_PRIME1v (lime_bgfx_destroy_vertex_buffer);
	DEFINE_PRIME3 (lime_bgfx_create_dynamic_vertex_buffer);
	DEFINE_PRIME4v (lime_bgfx_update_dynamic_vertex_buffer);
	DEFINE_PRIME1v (lime_bgfx_destroy_dynamic_vertex_buffer);
	DEFINE_PRIME3 (lime_bgfx_create_index_buffer);
	DEFINE_PRIME1v (lime_bgfx_destroy_index_buffer);
	DEFINE_PRIME2 (lime_bgfx_create_dynamic_index_buffer);
	DEFINE_PRIME4v (lime_bgfx_update_dynamic_index_buffer);
	DEFINE_PRIME1v (lime_bgfx_destroy_dynamic_index_buffer);
	DEFINE_PRIME4 (lime_bgfx_set_transient_vertex_buffer);
	DEFINE_PRIME3 (lime_bgfx_set_transient_index_buffer);
	DEFINE_PRIME2 (lime_bgfx_create_shader);
	DEFINE_PRIME1v (lime_bgfx_destroy_shader);
	DEFINE_PRIME3 (lime_bgfx_create_program);
	DEFINE_PRIME1v (lime_bgfx_destroy_program);
	DEFINE_PRIME3 (lime_bgfx_create_uniform);
	DEFINE_PRIME1v (lime_bgfx_destroy_uniform);
	DEFINE_PRIME3v (lime_bgfx_set_uniform);
	DEFINE_PRIME9 (lime_bgfx_create_texture_2d);
	DEFINE_PRIME10v (lime_bgfx_update_texture_2d);
	DEFINE_PRIME1v (lime_bgfx_destroy_texture);
	DEFINE_PRIME3 (lime_bgfx_read_texture);
	DEFINE_PRIME5 (lime_bgfx_create_frame_buffer);
	DEFINE_PRIME2 (lime_bgfx_create_frame_buffer_from_textures);
	DEFINE_PRIME2 (lime_bgfx_get_frame_buffer_texture);
	DEFINE_PRIME1v (lime_bgfx_destroy_frame_buffer);
	DEFINE_PRIME3v (lime_bgfx_set_state);
	DEFINE_PRIME2v (lime_bgfx_set_stencil);
	DEFINE_PRIME4 (lime_bgfx_set_scissor);
	DEFINE_PRIME2 (lime_bgfx_set_transform);
	DEFINE_PRIME3 (lime_bgfx_alloc_transient_vertex_buffer_slot);
	DEFINE_PRIME2v (lime_bgfx_set_transient_vertex_buffer_slot);
	DEFINE_PRIME4v (lime_bgfx_set_vertex_buffer);
	DEFINE_PRIME4v (lime_bgfx_set_dynamic_vertex_buffer);
	DEFINE_PRIME1 (lime_bgfx_create_vertex_layout_handle);
	DEFINE_PRIME1v (lime_bgfx_destroy_vertex_layout_handle);
	DEFINE_PRIME5v (lime_bgfx_set_vertex_buffer_layout);
	DEFINE_PRIME5v (lime_bgfx_set_dynamic_vertex_buffer_layout);
	DEFINE_PRIME3v (lime_bgfx_set_index_buffer);
	DEFINE_PRIME3v (lime_bgfx_set_dynamic_index_buffer);
	DEFINE_PRIME4v (lime_bgfx_set_texture);
	DEFINE_PRIME4v (lime_bgfx_submit);
	DEFINE_PRIME1v (lime_bgfx_discard);
	DEFINE_PRIME9v (lime_bgfx_blit);
	DEFINE_PRIME2v (lime_bgfx_request_screen_shot);


	#define _TCFFIPOINTER _DYN

	DEFINE_HL_PRIM (_BOOL, hl_bgfx_init, _TCFFIPOINTER _I32 _I32 _I32 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_shutdown, _NO_ARG);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_reset, _I32 _I32 _I32);
	DEFINE_HL_PRIM (_I32, hl_bgfx_frame, _BOOL);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_touch, _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_set_debug, _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_dbg_text_clear, _NO_ARG);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_dbg_text_print, _I32 _I32 _I32 _STRING);
	DEFINE_HL_PRIM (_I32, hl_bgfx_get_renderer_type, _NO_ARG);
	DEFINE_HL_PRIM (_I32, hl_bgfx_get_caps_max_texture_size, _NO_ARG);
	DEFINE_HL_PRIM (_BOOL, hl_bgfx_get_caps_homogeneous_depth, _NO_ARG);
	DEFINE_HL_PRIM (_BOOL, hl_bgfx_get_caps_origin_bottom_left, _NO_ARG);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_set_view_rect, _I32 _I32 _I32 _I32 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_set_view_scissor, _I32 _I32 _I32 _I32 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_set_view_clear, _I32 _I32 _I32 _F64 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_set_view_mode, _I32 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_set_view_transform, _I32 _F64 _F64);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_set_view_frame_buffer, _I32 _I32);
	DEFINE_HL_PRIM (_TCFFIPOINTER, hl_bgfx_vertex_layout_create, _NO_ARG);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_vertex_layout_begin, _TCFFIPOINTER _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_vertex_layout_add, _TCFFIPOINTER _I32 _I32 _I32 _BOOL _BOOL);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_vertex_layout_skip, _TCFFIPOINTER _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_vertex_layout_end, _TCFFIPOINTER);
	DEFINE_HL_PRIM (_I32, hl_bgfx_vertex_layout_get_stride, _TCFFIPOINTER);
	DEFINE_HL_PRIM (_I32, hl_bgfx_create_vertex_buffer, _F64 _I32 _TCFFIPOINTER _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_destroy_vertex_buffer, _I32);
	DEFINE_HL_PRIM (_I32, hl_bgfx_create_dynamic_vertex_buffer, _I32 _TCFFIPOINTER _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_update_dynamic_vertex_buffer, _I32 _I32 _F64 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_destroy_dynamic_vertex_buffer, _I32);
	DEFINE_HL_PRIM (_I32, hl_bgfx_create_index_buffer, _F64 _I32 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_destroy_index_buffer, _I32);
	DEFINE_HL_PRIM (_I32, hl_bgfx_create_dynamic_index_buffer, _I32 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_update_dynamic_index_buffer, _I32 _I32 _F64 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_destroy_dynamic_index_buffer, _I32);
	DEFINE_HL_PRIM (_I32, hl_bgfx_set_transient_vertex_buffer, _I32 _F64 _I32 _TCFFIPOINTER);
	DEFINE_HL_PRIM (_I32, hl_bgfx_set_transient_index_buffer, _F64 _I32 _BOOL);
	DEFINE_HL_PRIM (_I32, hl_bgfx_create_shader, _F64 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_destroy_shader, _I32);
	DEFINE_HL_PRIM (_I32, hl_bgfx_create_program, _I32 _I32 _BOOL);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_destroy_program, _I32);
	DEFINE_HL_PRIM (_I32, hl_bgfx_create_uniform, _STRING _I32 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_destroy_uniform, _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_set_uniform, _I32 _F64 _I32);
	DEFINE_HL_PRIM (_I32, hl_bgfx_create_texture_2d, _I32 _I32 _BOOL _I32 _I32 _I32 _I32 _F64 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_update_texture_2d, _I32 _I32 _I32 _I32 _I32 _I32 _I32 _F64 _I32 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_destroy_texture, _I32);
	DEFINE_HL_PRIM (_I32, hl_bgfx_read_texture, _I32 _F64 _I32);
	DEFINE_HL_PRIM (_I32, hl_bgfx_create_frame_buffer, _I32 _I32 _I32 _I32 _I32);
	DEFINE_HL_PRIM (_I32, hl_bgfx_create_frame_buffer_from_textures, _I32 _I32);
	DEFINE_HL_PRIM (_I32, hl_bgfx_get_frame_buffer_texture, _I32 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_destroy_frame_buffer, _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_set_state, _I32 _I32 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_set_stencil, _I32 _I32);
	DEFINE_HL_PRIM (_I32, hl_bgfx_set_scissor, _I32 _I32 _I32 _I32);
	DEFINE_HL_PRIM (_I32, hl_bgfx_set_transform, _F64 _I32);
	DEFINE_HL_PRIM (_I32, hl_bgfx_alloc_transient_vertex_buffer_slot, _F64 _I32 _TCFFIPOINTER);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_set_transient_vertex_buffer_slot, _I32 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_set_vertex_buffer, _I32 _I32 _I32 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_set_dynamic_vertex_buffer, _I32 _I32 _I32 _I32);
	DEFINE_HL_PRIM (_I32, hl_bgfx_create_vertex_layout_handle, _TCFFIPOINTER);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_destroy_vertex_layout_handle, _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_set_vertex_buffer_layout, _I32 _I32 _I32 _I32 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_set_dynamic_vertex_buffer_layout, _I32 _I32 _I32 _I32 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_set_index_buffer, _I32 _I32 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_set_dynamic_index_buffer, _I32 _I32 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_set_texture, _I32 _I32 _I32 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_submit, _I32 _I32 _I32 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_discard, _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_blit, _I32 _I32 _I32 _I32 _I32 _I32 _I32 _I32 _I32);
	DEFINE_HL_PRIM (_VOID, hl_bgfx_request_screen_shot, _I32 _STRING);


}
