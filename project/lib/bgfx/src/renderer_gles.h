/*
 * bgfx builds renderer_gl.cpp as either OpenGL or OpenGL ES. On Windows and Linux,
 * renderer_gles.cpp and glcontext_gles.cpp build it a second time as OpenGL ES 3.0 in
 * namespace bgfx::gles, next to the OpenGL renderer in bgfx::gl.
 */

#ifndef BGFX_RENDERER_GLES_H_HEADER_GUARD
#define BGFX_RENDERER_GLES_H_HEADER_GUARD

#include <bx/platform.h>

#if BX_PLATFORM_WINDOWS || BX_PLATFORM_LINUX
#	define BGFX_CONFIG_RENDERER_OPENGL   0
#	define BGFX_CONFIG_RENDERER_OPENGLES 30
#	define BGFX_CONFIG_GL_USE_WGL        1
#	include "bgfx_p.h"
#	define gl gles
#endif // BX_PLATFORM_WINDOWS || BX_PLATFORM_LINUX

#endif // BGFX_RENDERER_GLES_H_HEADER_GUARD
