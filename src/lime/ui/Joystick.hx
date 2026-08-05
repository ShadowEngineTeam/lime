package lime.ui;

import lime._internal.backend.native.NativeCFFI;
import lime.app.Event;
import lime.system.CFFI;

@:access(lime._internal.backend.native.NativeCFFI)
class Joystick
{
	public static var devices = new Map<Int, Joystick>();
	public static var onConnect = new Event<Joystick->Void>();

	public var connected(default, null):Bool;
	public var guid(get, never):String;
	public var id(default, null):Int;
	public var name(get, never):String;
	public var numAxes(get, never):Int;
	public var numButtons(get, never):Int;
	public var numHats(get, never):Int;
	public var onAxisMove = new Event<Int->Float->Void>();
	public var onButtonDown = new Event<Int->Void>();
	public var onButtonUp = new Event<Int->Void>();
	public var onDisconnect = new Event<Void->Void>();
	public var onHatMove = new Event<Int->JoystickHatPosition->Void>();

	public function new(id:Int)
	{
		this.id = id;
		connected = true;
	}

	public function rumble(lowFrequencyRumble:Float, highFrequencyRumble:Float, duration:Int):Void
	{
		#if (lime_cffi && !macro)
		NativeCFFI.lime_joystick_rumble(this.id, lowFrequencyRumble, highFrequencyRumble, duration);
		#end
	}

	public function setLED(red:Int, green:Int, blue:Int):Void
	{
		#if (lime_cffi && !macro)
		NativeCFFI.lime_joystick_set_led(this.id, red, green, blue);
		#end
	}

	@:noCompletion private static function __connect(id:Int):Void
	{
		if (!devices.exists(id))
		{
			var joystick = new Joystick(id);
			devices.set(id, joystick);
			onConnect.dispatch(joystick);
		}
	}

	@:noCompletion private static function __disconnect(id:Int):Void
	{
		var joystick = devices.get(id);
		if (joystick != null)
			joystick.connected = false;
		devices.remove(id);
		if (joystick != null)
			joystick.onDisconnect.dispatch();
	}

	@:noCompletion private static function __getDeviceData():Dynamic
	{
		return null;
	}

	// Get & Set Methods
	@:noCompletion private inline function get_guid():String
	{
		#if (lime_cffi && !macro)
		return NativeCFFI.lime_joystick_get_device_guid(this.id);
		#else
		return null;
		#end
	}

	@:noCompletion private inline function get_name():String
	{
		#if (lime_cffi && !macro)
		return NativeCFFI.lime_joystick_get_device_name(this.id);
		#else
		return null;
		#end
	}

	@:noCompletion private inline function get_numAxes():Int
	{
		#if (lime_cffi && !macro)
		return NativeCFFI.lime_joystick_get_num_axes(this.id);
		#else
		return 0;
		#end
	}

	@:noCompletion private inline function get_numButtons():Int
	{
		#if (lime_cffi && !macro)
		return NativeCFFI.lime_joystick_get_num_buttons(this.id);
		#else
		return 0;
		#end
	}

	@:noCompletion private inline function get_numHats():Int
	{
		#if (lime_cffi && !macro)
		return NativeCFFI.lime_joystick_get_num_hats(this.id);
		#else
		return 0;
		#end
	}
}
