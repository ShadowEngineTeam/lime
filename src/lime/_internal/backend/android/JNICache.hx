package lime._internal.backend.android;

import lime.system.JNI;

/**
 * A utility class for caching JNI method and field references.
 *
 * Lookups that fail resolve to `null` and are cached as such, so a missing
 * class, method or field degrades to a no-op at the call site instead of
 * throwing or handing back a reference wrapping a null handle.
 */
#if android
class JNICache
{
	@:noCompletion
	private static var staticMethodCache:Map<String, Dynamic> = [];

	@:noCompletion
	private static var memberMethodCache:Map<String, Dynamic> = [];

	@:noCompletion
	private static var staticFieldCache:Map<String, JNIStaticField> = [];

	@:noCompletion
	private static var memberFieldCache:Map<String, JNIMemberField> = [];

	/**
	 * Retrieves or creates a cached static method reference.
	 *
	 * @param className The name of the Java class containing the method.
	 * @param methodName The name of the method.
	 * @param signature The method signature in JNI format.
	 * @param cache Whether to cache the result (default true).
	 * @return A dynamic reference to the static method, or `null` if it couldn't be resolved.
	 */
	public static function createStaticMethod(className:String, methodName:String, signature:String, cache:Bool = true):Null<Dynamic>
	{
		className = transformClassName(className);

		if (!cache)
			return JNI.createStaticMethod(className, methodName, signature, false, true);

		final key:String = '$className::$methodName::$signature';

		if (!staticMethodCache.exists(key))
			staticMethodCache.set(key, JNI.createStaticMethod(className, methodName, signature, false, true));

		return staticMethodCache.get(key);
	}

	/**
	 * Retrieves or creates a cached member method reference.
	 *
	 * @param className The name of the Java class containing the method.
	 * @param methodName The name of the method.
	 * @param signature The method signature in JNI format.
	 * @param cache Whether to cache the result (default true).
	 * @return A dynamic reference to the member method, or `null` if it couldn't be resolved.
	 */
	public static function createMemberMethod(className:String, methodName:String, signature:String, cache:Bool = true):Null<Dynamic>
	{
		className = transformClassName(className);

		if (!cache)
			return JNI.createMemberMethod(className, methodName, signature, false, true);

		final key:String = '$className::$methodName::$signature';

		if (!memberMethodCache.exists(key))
			memberMethodCache.set(key, JNI.createMemberMethod(className, methodName, signature, false, true));

		return memberMethodCache.get(key);
	}

	/**
	 * Retrieves or creates a cached static field reference.
	 *
	 * @param className The name of the Java class containing the field.
	 * @param fieldName The name of the field.
	 * @param signature The field signature in JNI format.
	 * @param cache Whether to cache the result (default true).
	 * @return A reference to the static field, or `null` if it couldn't be resolved.
	 */
	public static function createStaticField(className:String, fieldName:String, signature:String, cache:Bool = true):Null<JNIStaticField>
	{
		className = transformClassName(className);

		if (!cache)
			return validateStaticField(JNI.createStaticField(className, fieldName, signature));

		final key:String = '$className::$fieldName::$signature';

		if (!staticFieldCache.exists(key))
			staticFieldCache.set(key, validateStaticField(JNI.createStaticField(className, fieldName, signature)));

		return staticFieldCache.get(key);
	}

	/**
	 * Retrieves or creates a cached member field reference.
	 *
	 * @param className The name of the Java class containing the field.
	 * @param fieldName The name of the field.
	 * @param signature The field signature in JNI format.
	 * @param cache Whether to cache the result (default true).
	 * @return A reference to the member field, or `null` if it couldn't be resolved.
	 */
	public static function createMemberField(className:String, fieldName:String, signature:String, cache:Bool = true):Null<JNIMemberField>
	{
		className = transformClassName(className);

		if (!cache)
			return validateMemberField(JNI.createMemberField(className, fieldName, signature));

		final key:String = '$className::$fieldName::$signature';

		if (!memberFieldCache.exists(key))
			memberFieldCache.set(key, validateMemberField(JNI.createMemberField(className, fieldName, signature)));

		return memberFieldCache.get(key);
	}

	/**
	 * Normalizes a class name the same way `JNI` does, so that the dotted and
	 * slashed spellings of one class share a single cache entry.
	 */
	@:noCompletion
	private static inline function transformClassName(className:String):String
	{
		@:privateAccess
		return JNI.transformClassName(className);
	}

	/**
	 * `JNI` wraps the raw handle unconditionally, so a failed lookup comes back
	 * as a non-null reference around a null handle. Unwrap that to `null`.
	 */
	@:noCompletion
	private static inline function validateStaticField(field:JNIStaticField):Null<JNIStaticField>
	{
		@:privateAccess
		return (field != null && field.field != null) ? field : null;
	}

	/**
	 * @see `validateStaticField`
	 */
	@:noCompletion
	private static inline function validateMemberField(field:JNIMemberField):Null<JNIMemberField>
	{
		@:privateAccess
		return (field != null && field.field != null) ? field : null;
	}
}
#end
