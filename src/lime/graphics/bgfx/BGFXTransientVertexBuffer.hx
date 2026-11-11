package lime.graphics.bgfx;

#if (!lime_doc_gen || lime_bgfx)
import haxe.io.Bytes;
import lime._internal.backend.native.NativeCFFI;
import lime.system.CFFIPointer;
import lime.utils.ArrayBufferView;
import lime.utils.DataPointer;
import lime.utils.UInt8Array;

@:access(lime._internal.backend.native.NativeCFFI)
abstract BGFXTransientVertexBuffer(CFFIPointer) from CFFIPointer to CFFIPointer
{
	public var data(get, set):ArrayBufferView;

	public function new(handle)
	{
		this = handle;
	}

	private function get_data():ArrayBufferView
	{
		#if (lime_cffi && lime_bgfx && !macro)
		var data:ArrayBufferView = new UInt8Array(Bytes.alloc(0));
		return NativeCFFI.lime_bgfx_get_transient_vertex_buffer_data(this, data) ? data : null;
		#else
		return null;
		#end
	}

	private function set_data(value:ArrayBufferView):ArrayBufferView
	{
		#if (lime_cffi && lime_bgfx && !macro)
		NativeCFFI.lime_bgfx_set_transient_vertex_buffer_data(this, DataPointer.fromArrayBufferView(value), value != null ? value.byteLength : 0);
		#end
		return value;
	}
}
#end
