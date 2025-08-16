package lime._internal.backend.android;

import lime.system.JNI;

#if android
#if !lime_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
class JNIUtil
{
    /**
	 * Retrieves the absolute path from a given File object.
	 *
	 * @param handle A File object for which to retrieve the absolute path.
	 *
	 * @return The absolute path of the File object.
	 */
	public static function getAbsolutePath(handle:Null<Dynamic>):String
	{
		if (handle != null)
		{
			final getAbsolutePathMemberJNI:Null<Dynamic> = JNICache.createMemberMethod('java/io/File', 'getAbsolutePath', '()Ljava/lang/String;');

			if (getAbsolutePathMemberJNI != null)
			{
				final getAbsolutePathJNI:Null<Dynamic> = JNI.callMember(getAbsolutePathMemberJNI, handle, []);

				if (getAbsolutePathJNI != null)
					return getAbsolutePathJNI;
			}
		}

		return '';
	}
}
#end