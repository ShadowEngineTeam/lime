package android.os;

import lime._internal.backend.android.JNICache;

/**
 * Various info about the current build, extracted from system properties.
 */
#if android
class Build
{
	/**
	 * Tag for logging purposes.
	 */
	public static final TAG:String = 'Build';

	/**
	 * Value used when a build property is unknown.
	 */
	public static final UNKNOWN:String = 'unknown';

	/**
	 * The name of the underlying board, like 'goldfish'.
	 */
	public static var BOARD(get, never):String;

	@:noCompletion
	static function get_BOARD():String
	{
		final field:Null<Dynamic> = JNICache.createStaticField('android/os/Build', 'BOARD', 'Ljava/lang/String;');

		return field != null ? field.get() : '';
	}

	/**
	 * The system bootloader version number.
	 */
	public static var BOOTLOADER(get, never):String;

	@:noCompletion
	static function get_BOOTLOADER():String
	{
		final field:Null<Dynamic> = JNICache.createStaticField('android/os/Build', 'BOOTLOADER', 'Ljava/lang/String;');

		return field != null ? field.get() : '';
	}

	/**
	 * The consumer-visible brand with which the product/hardware will be associated, if any.
	 */
	public static var BRAND(get, never):String;

	@:noCompletion
	static function get_BRAND():String
	{
		final field:Null<Dynamic> = JNICache.createStaticField('android/os/Build', 'BRAND', 'Ljava/lang/String;');

		return field != null ? field.get() : '';
	}

	/**
	 * The name of the industrial design.
	 */
	public static var DEVICE(get, never):String;

	@:noCompletion
	static function get_DEVICE():String
	{
		final field:Null<Dynamic> = JNICache.createStaticField('android/os/Build', 'DEVICE', 'Ljava/lang/String;');

		return field != null ? field.get() : '';
	}

	/**
	 * Either a changelist number, or a label like 'M4-rc20'.
	 */
	public static var ID(get, never):String;

	@:noCompletion
	static function get_ID():String
	{
		final field:Null<Dynamic> = JNICache.createStaticField('android/os/Build', 'ID', 'Ljava/lang/String;');

		return field != null ? field.get() : '';
	}

	/**
	 * The name of the overall product.
	 */
	public static var PRODUCT(get, never):String;

	@:noCompletion
	static function get_PRODUCT():String
	{
		final field:Null<Dynamic> = JNICache.createStaticField('android/os/Build', 'PRODUCT', 'Ljava/lang/String;');

		return field != null ? field.get() : '';
	}

	/**
	 * The manufacturer of the product/hardware.
	 */
	public static var MANUFACTURER(get, never):String;

	@:noCompletion
	static function get_MANUFACTURER():String
	{
		final field:Null<Dynamic> = JNICache.createStaticField('android/os/Build', 'MANUFACTURER', 'Ljava/lang/String;');

		return field != null ? field.get() : '';
	}

	/**
	 * The name of the hardware (from the kernel command line or /proc).
	 */
	public static var HARDWARE(get, never):String;

	@:noCompletion
	static function get_HARDWARE():String
	{
		final field:Null<Dynamic> = JNICache.createStaticField('android/os/Build', 'HARDWARE', 'Ljava/lang/String;');

		return field != null ? field.get() : '';
	}

	/**
	 * The end-user-visible name for the end product.
	 */
	public static var MODEL(get, never):String;

	@:noCompletion
	static function get_MODEL():String
	{
		final field:Null<Dynamic> = JNICache.createStaticField('android/os/Build', 'MODEL', 'Ljava/lang/String;');

		return field != null ? field.get() : '';
	}

	/**
	 * The SKU of the device as set by the original design manufacturer (ODM).
	 * This is a runtime-initialized property set during startup to configure device services.
	 * If no value is set, this is reported as ``UNKNOWN``.
	 *
	 * The ODM SKU may have multiple variants for the same system SKU in case a manufacturer produces variants of the same design.
	 * For example, the same build may be released with variations in physical keyboard and/or display hardware, each with a different ODM SKU.
	 */
	public static var ODM_SKU(get, never):String;

	@:noCompletion
	static function get_ODM_SKU():String
	{
		if (VERSION.SDK_INT >= VERSION_CODES.S)
		{
			final field:Null<Dynamic> = JNICache.createStaticField('android/os/Build', 'ODM_SKU', 'Ljava/lang/String;');

			return field != null ? field.get() : UNKNOWN;
		}

		return UNKNOWN;
	}

	/**
	 * The SKU of the hardware (from the kernel command line).
	 * The SKU is reported by the bootloader to configure system software features.
	 * If no value is supplied by the bootloader, this is reported as ``UNKNOWN``.
	 */
	public static var SKU(get, never):String;

	@:noCompletion
	static function get_SKU():String
	{
		if (VERSION.SDK_INT >= VERSION_CODES.S)
		{
			final field:Null<Dynamic> = JNICache.createStaticField('android/os/Build', 'SKU', 'Ljava/lang/String;');

			return field != null ? field.get() : UNKNOWN;
		}

		return UNKNOWN;
	}

	/**
	 * The manufacturer of the device's primary system-on-chip.
	 */
	public static var SOC_MANUFACTURER(get, never):String;

	@:noCompletion
	static function get_SOC_MANUFACTURER():String
	{
		if (VERSION.SDK_INT >= VERSION_CODES.S)
		{
			final field:Null<Dynamic> = JNICache.createStaticField('android/os/Build', 'SOC_MANUFACTURER', 'Ljava/lang/String;');

			return field != null ? field.get() : UNKNOWN;
		}

		return UNKNOWN;
	}

	/**
	 * The model name of the device's primary system-on-chip.
	 */
	public static var SOC_MODEL(get, never):String;

	@:noCompletion
	static function get_SOC_MODEL():String
	{
		if (VERSION.SDK_INT >= VERSION_CODES.S)
		{
			final field:Null<Dynamic> = JNICache.createStaticField('android/os/Build', 'SOC_MODEL', 'Ljava/lang/String;');

			return field != null ? field.get() : UNKNOWN;
		}

		return UNKNOWN;
	}

	/**
	 * Comma-separated tags describing the build, like "unsigned,debug".
	 */
	public static var TAGS(get, never):String;

	@:noCompletion
	static function get_TAGS():String
	{
		final field:Null<Dynamic> = JNICache.createStaticField('android/os/Build', 'TAGS', 'Ljava/lang/String;');

		return field != null ? field.get() : '';
	}

	/**
	 * The time at which the build was produced, given in milliseconds since the UNIX epoch.
	 */
	public static var TIME(get, never):Float;

	@:noCompletion
	static function get_TIME():Float
	{
		final field:Null<Dynamic> = JNICache.createStaticField('android/os/Build', 'TIME', 'J');

		return field != null ? field.get() : 0;
	}

	/**
	 * The type of build, like "user" or "eng".
	 */
	public static var TYPE(get, never):String;

	@:noCompletion
	static function get_TYPE():String
	{
		final field:Null<Dynamic> = JNICache.createStaticField('android/os/Build', 'TYPE', 'Ljava/lang/String;');

		return field != null ? field.get() : '';
	}

	/**
	 * The hostname of the system.
	 */
	public static var HOST(get, never):String;

	@:noCompletion
	static function get_HOST():String
	{
		final field:Null<Dynamic> = JNICache.createStaticField('android/os/Build', 'HOST', 'Ljava/lang/String;');

		return field != null ? field.get() : '';
	}

	/**
	 * The user of the system.
	 */
	public static var USER(get, never):String;

	@:noCompletion
	static function get_USER():String
	{
		final field:Null<Dynamic> = JNICache.createStaticField('android/os/Build', 'USER', 'Ljava/lang/String;');

		return field != null ? field.get() : '';
	}

	/**
	 * The version of the radio firmware, or an empty string if not available.
	 */
	public static function getRadioVersion():String
	{
		final getRadioVersionJNI:Null<Dynamic> = JNICache.createStaticMethod('android/os/Build', 'getRadioVersion', '()Ljava/lang/String;');

		if (getRadioVersionJNI != null)
		{
			final version:Null<String> = getRadioVersionJNI();

			if (version != null)
				return version;
		}

		return '';
	}

	/**
	 * Retrieves the hardware serial number, if available.
	 * Requires android.permission.READ_PRIVILEGED_PHONE_STATE.
	 */
	public static function getSerial():String
	{
		final getSerialJNI:Null<Dynamic> = JNICache.createStaticMethod('android/os/Build', 'getSerial', '()Ljava/lang/String;');

		if (getSerialJNI != null)
		{
			final serial:Null<String> = getSerialJNI();

			if (serial != null)
				return serial;
		}

		return UNKNOWN;
	}
}

/**
 * Utility class providing Android version-related constants and information.
 */
class VERSION
{
	/**
	 * The base OS build the product is based on.
	 */
	public static var BASE_OS(get, never):String;

	@:noCompletion
	static function get_BASE_OS():String
	{
		final field:Null<Dynamic> = JNICache.createStaticField("android/os/Build$VERSION", 'BASE_OS', 'Ljava/lang/String;');

		return field != null ? field.get() : '';
	}

	/**
	 * The current development codename, or the string "REL" if this is a release build.
	 */
	public static var CODENAME(get, never):String;

	@:noCompletion
	static function get_CODENAME():String
	{
		final field:Null<Dynamic> = JNICache.createStaticField("android/os/Build$VERSION", 'CODENAME', 'Ljava/lang/String;');

		return field != null ? field.get() : '';
	}

	/**
	 * The internal value used by the underlying source control to represent this build.
	 * E.g., a perforce changelist number or a git hash.
	 */
	public static var INCREMENTAL(get, never):String;

	@:noCompletion
	static function get_INCREMENTAL():String
	{
		final field:Null<Dynamic> = JNICache.createStaticField("android/os/Build$VERSION", 'INCREMENTAL', 'Ljava/lang/String;');

		return field != null ? field.get() : '';
	}

	/**
	 * The media performance class of the device or 0 if none.
	 * If this value is not 0, the device conforms to the media performance class definition of the SDK version of this value.
	 * This value never changes while a device is booted, but it may increase when the hardware manufacturer provides an OTA update.
	 * Possible non-zero values are defined in ``VERSION_CODES`` starting with ``VERSION_CODES.R``.
	 */
	public static var MEDIA_PERFORMANCE_CLASS(get, never):Int;

	@:noCompletion
	static function get_MEDIA_PERFORMANCE_CLASS():Int
	{
		if (SDK_INT >= VERSION_CODES.S)
		{
			final field:Null<Dynamic> = JNICache.createStaticField("android/os/Build$VERSION", 'MEDIA_PERFORMANCE_CLASS', 'I');

			return field != null ? field.get() : 0;
		}

		return 0;
	}

	/**
	 * The user-visible version string.
	 */
	public static var RELEASE(get, never):String;

	@:noCompletion
	static function get_RELEASE():String
	{
		final field:Null<Dynamic> = JNICache.createStaticField("android/os/Build$VERSION", 'RELEASE', 'Ljava/lang/String;');

		return field != null ? field.get() : '';
	}

	/**
	 * The user-visible SDK version of the framework in its raw String representation; use SDK_INT instead.
	 */
	public static var SDK(get, never):String;

	@:noCompletion
	static function get_SDK():String
	{
		final field:Null<Dynamic> = JNICache.createStaticField("android/os/Build$VERSION", 'SDK', 'Ljava/lang/String;');

		return field != null ? field.get() : '';
	}

	/**
	 * The SDK version of the software currently running on this hardware device.
	 */
	public static var SDK_INT(get, never):Int;

	@:noCompletion
	static function get_SDK_INT():Int
	{
		final field:Null<Dynamic> = JNICache.createStaticField("android/os/Build$VERSION", 'SDK_INT', 'I');

		return field != null ? field.get() : 0;
	}

	/**
	 * The developer preview revision of a prerelease SDK.
	 * This value will always be 0 on production platform builds/devices.
	 */
	public static var PREVIEW_SDK_INT(get, never):Int;

	@:noCompletion
	static function get_PREVIEW_SDK_INT():Int
	{
		final field:Null<Dynamic> = JNICache.createStaticField("android/os/Build$VERSION", 'PREVIEW_SDK_INT', 'I');

		return field != null ? field.get() : 0;
	}

	/**
	 * The version string.
	 * May be ``RELEASE`` or ``CODENAME`` if not a final release build.
	 */
	public static var RELEASE_OR_CODENAME(get, never):String;

	@:noCompletion
	static function get_RELEASE_OR_CODENAME():String
	{
		if (SDK_INT >= VERSION_CODES.R)
		{
			final field:Null<Dynamic> = JNICache.createStaticField("android/os/Build$VERSION", 'RELEASE_OR_CODENAME', 'Ljava/lang/String;');

			return field != null ? field.get() : Build.UNKNOWN;
		}

		return Build.UNKNOWN;
	}

	/**
	 * The user-visible version string shown to the user.
	 * May be ``RELEASE`` or a descriptive string if not a final release build.
	 */
	public static var RELEASE_OR_PREVIEW_DISPLAY(get, never):String;

	@:noCompletion
	static function get_RELEASE_OR_PREVIEW_DISPLAY():String
	{
		if (SDK_INT >= VERSION_CODES.TIRAMISU)
		{
			final field:Null<Dynamic> = JNICache.createStaticField("android/os/Build$VERSION", 'RELEASE_OR_PREVIEW_DISPLAY', 'Ljava/lang/String;');

			return field != null ? field.get() : Build.UNKNOWN;
		}

		return Build.UNKNOWN;
	}

	/**
	 * The user-visible security patch level.
	 * This value represents the date when the device most recently applied a security patch.
	 */
	public static var SECURITY_PATCH(get, never):String;

	@:noCompletion
	static function get_SECURITY_PATCH():String
	{
		final field:Null<Dynamic> = JNICache.createStaticField("android/os/Build$VERSION", 'SECURITY_PATCH', 'Ljava/lang/String;');

		return field != null ? field.get() : '';
	}
}

/**
 * Constants for Android SDK version codes.
 */
class VERSION_CODES
{
	public static final BASE:Int = 1;
	public static final BASE_1_1:Int = 2;
	public static final CUPCAKE:Int = 3;
	public static final DONUT:Int = 4;
	public static final ECLAIR:Int = 5;
	public static final ECLAIR_0_1:Int = 6;
	public static final ECLAIR_MR1:Int = 7;
	public static final FROYO:Int = 8;
	public static final GINGERBREAD:Int = 9;
	public static final GINGERBREAD_MR1:Int = 10;
	public static final HONEYCOMB:Int = 11;
	public static final HONEYCOMB_MR1:Int = 12;
	public static final HONEYCOMB_MR2:Int = 13;
	public static final ICE_CREAM_SANDWICH:Int = 14;
	public static final ICE_CREAM_SANDWICH_MR1:Int = 15;
	public static final JELLY_BEAN:Int = 16;
	public static final JELLY_BEAN_MR1:Int = 17;
	public static final JELLY_BEAN_MR2:Int = 18;
	public static final KITKAT:Int = 19;
	public static final KITKAT_WATCH:Int = 20;
	public static final LOLLIPOP:Int = 21;
	public static final LOLLIPOP_MR1:Int = 22;
	public static final M:Int = 23;
	public static final N:Int = 24;
	public static final N_MR1:Int = 25;
	public static final O:Int = 26;
	public static final O_MR1:Int = 27;
	public static final P:Int = 28;
	public static final Q:Int = 29;
	public static final R:Int = 30;
	public static final S:Int = 31;
	public static final S_V2:Int = 32;
	public static final TIRAMISU:Int = 33;
	public static final UPSIDE_DOWN_CAKE:Int = 34;
	public static final VANILLA_ICE_CREAM:Int = 35;
	public static final BAKLAVA:Int = 36;
	public static final CINNAMON_BUN:Int = 37;
}
#end
