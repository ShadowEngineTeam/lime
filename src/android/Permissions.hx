package android;

import lime._internal.backend.android.JNICache;

using StringTools;

/**
 * Utility class for handling Android permissions via JNI.
 */
#if android
class Permissions
{
	/**
	 * Retrieves the list of permissions granted to the application.
	 *
	 * @return An array of granted permissions.
	 */
	public static function getGrantedPermissions():Array<String>
	{
		final getGrantedPermissionsJNI:Null<Dynamic> = JNICache.createStaticMethod('org/haxe/extension/Tools', 'getGrantedPermissions',
			'()[Ljava/lang/String;');

		if (getGrantedPermissionsJNI != null)
		{
			final permissions:Null<Array<String>> = getGrantedPermissionsJNI();

			if (permissions != null)
				return permissions;
		}

		return [];
	}

	/**
	 * Requests a specific permission from the user via a dialog.
	 *
	 * @param permissions The permissions to request. This should be in the format ['android.permission.PERMISSION_NAME'].
	 * @param requestCode The request code to associate with this permission request.
	 */
	public static function requestPermissions(permissions:Array<String>, requestCode:Int = 1):Void
	{
		final requestPermissionsJNI:Null<Dynamic> = JNICache.createStaticMethod('org/haxe/extension/Tools', 'requestPermissions', '([Ljava/lang/String;I)V');

		if (requestPermissionsJNI != null)
		{
			final nativePermissions:Array<String> = [];

			for (permission in permissions)
				nativePermissions.push(permission.startsWith('android.permission.') ? permission : 'android.permission.$permission');

			requestPermissionsJNI(nativePermissions, requestCode);
		}
	}
}
#end
