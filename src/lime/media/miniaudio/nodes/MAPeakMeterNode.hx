package lime.media.miniaudio.nodes;

#if (!lime_doc_gen || lime_miniaudio)
import lime._internal.backend.native.NativeCFFI;

/**
	A pass-through node attached to the engine's endpoint that measures the peak level of the audio going through it.
**/
@:access(lime._internal.backend.native.NativeCFFI)
@:forward
abstract MAPeakMeterNode(MANode) from MANode to MANode
{
	public static function init(pEngine:MAEngine):MAPeakMeterNode
	{
		#if (lime_cffi && lime_miniaudio && !macro)
		return NativeCFFI.lime_ma_peak_meter_node_init(pEngine);
		#else
		return null;
		#end
	}

	public function uninit():Void
	{
		#if (lime_cffi && lime_miniaudio && !macro)
		NativeCFFI.lime_ma_peak_meter_node_uninit(this);
		#end
	}

	/**
		Returns the highest absolute sample (0 to 1 for unclipped audio) on `channel` in the last processed block.
	**/
	public function get_peak(channel:Int):Float
	{
		#if (lime_cffi && lime_miniaudio && !macro)
		return NativeCFFI.lime_ma_peak_meter_node_get_peak(this, channel);
		#else
		return 0.0;
		#end
	}

	@:noCompletion @:op(A == B) private static inline function equalsPointer(a:MAPeakMeterNode, b:MAPeakMeterNode):Bool
	{
		return a.get() == b.get();
	}

	@:noCompletion @:op(A != B) private static inline function notEqualsPointer(a:MAPeakMeterNode, b:MAPeakMeterNode):Bool
	{
		return a.get() != b.get();
	}
}
#end
