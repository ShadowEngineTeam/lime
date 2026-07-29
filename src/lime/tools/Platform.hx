package lime.tools;

enum abstract Platform(String) from hxp.HostPlatform
{
	var ANDROID = "android";
	var IOS = "ios";
	var LINUX = "linux";
	var MAC = "mac";
	var WINDOWS = "windows";
	var CUSTOM = null;

	@:op(A == B) @:commutative
	private inline function equalsHostPlatform(hostPlatform:hxp.HostPlatform):Bool
	{
		return this == hostPlatform;
	}
}
