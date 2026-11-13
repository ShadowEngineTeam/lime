/*
 * The OpenGL ES contexts on Windows (WGL) and Linux (EGL), see renderer_gles.h.
 */

#include "renderer_gles.h"

#if BX_PLATFORM_WINDOWS || BX_PLATFORM_LINUX
#	include "glcontext_egl.cpp"
#	include "glcontext_wgl.cpp"
#endif // BX_PLATFORM_WINDOWS || BX_PLATFORM_LINUX
