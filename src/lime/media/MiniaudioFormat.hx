package lime.media;

// this is a direct map to ma_format (with ma_format_unknown excluded)
enum abstract MiniaudioFormat(Int) from Int to Int
{
	var U8 = 1;
	var S16 = 2;
	var S24 = 3;
	var S32 = 4;
	var F32 = 5;

	/** The size of a single sample, in bytes. A frame holds one sample per channel. **/
	public function getBytesPerSample():Int
	{
		var bytesPerSample = 0;

		switch (this) {
			case U8: bytesPerSample = 1;
			case S16: bytesPerSample = 2;
			case S24: bytesPerSample = 3;
			case S32: bytesPerSample = 4;
			case F32: bytesPerSample = 4;
		}

		return bytesPerSample;
	}

	/** The size of one frame, in bytes. This is what pcm frame counts have to be scaled by. **/
	public function getBytesPerFrame(channels:Int):Int
	{
		return getBytesPerSample() * channels;
	}
}
