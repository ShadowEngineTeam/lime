/*
 * The OpenGL ES renderer on Windows and Linux, see renderer_gles.h.
 */

#include "renderer_gles.h"

#if BX_PLATFORM_WINDOWS || BX_PLATFORM_LINUX
#	include "renderer_gl.cpp"
#endif // BX_PLATFORM_WINDOWS || BX_PLATFORM_LINUX
