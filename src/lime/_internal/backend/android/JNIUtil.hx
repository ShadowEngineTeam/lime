package lime._internal.backend.android;

import lime.system.JNI;

/**
 * Small helpers shared by the `android` JNI wrappers.
 */
#if android
class JNIUtil
{
	/**
	 * Retrieves the absolute path from a given File object.
	 *
	 * @param handle A File object for which to retrieve the absolute path.
	 *
	 * @return The absolute path of the File object, or an empty string.
	 */
	public static function getAbsolutePath(handle:Null<Dynamic>):String
	{
		if (handle != null)
		{
			final getAbsolutePathMemberJNI:Null<Dynamic> = JNICache.createMemberMethod('java/io/File', 'getAbsolutePath', '()Ljava/lang/String;');

			if (getAbsolutePathMemberJNI != null)
			{
				final path:Null<String> = JNI.callMember(getAbsolutePathMemberJNI, handle, []);

				if (path != null)
					return path;
			}
		}

		return '';
	}
}
#end
