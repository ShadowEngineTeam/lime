package lime.graphics;

/**
	An enum containing values for the underlying image type
	represented by an `ImageBuffer`
**/
enum ImageType
{
	/**
		The source image data is stored in a `UInt8Array`
	**/
	DATA;

	/**
		The source image data is stored in a custom format
	**/
	CUSTOM;
}
