/*
  Simple DirectMedia Layer
  Copyright (C) 1997-2026 Sam Lantinga <slouken@libsdl.org>

  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.
*/
#include "SDL_internal.h"

#if defined(SDL_VIDEO_DRIVER_UIKIT) && (defined(SDL_VIDEO_OPENGL_ES) || defined(SDL_VIDEO_OPENGL_ES2))

#include "SDL_uikitopengles.h"
#import "SDL_uikitopenglview.h"
#include "SDL_uikitmodes.h"
#include "SDL_uikitwindow.h"
#include "SDL_uikitevents.h"
#include "../SDL_sysvideo.h"
#include "../../events/SDL_keyboard_c.h"
#include "../../events/SDL_mouse_c.h"
#include "../../power/uikit/SDL_syspower.h"
#include "../../SDL_hints_c.h"
#include <EGL/egl.h>
#include <EGL/eglext.h>
#include <dlfcn.h>

SDL_FunctionPointer UIKit_GL_GetProcAddress(SDL_VideoDevice *_this, const char *proc)
{
    return dlsym(RTLD_DEFAULT, proc);
}

bool UIKit_GL_MakeCurrent(SDL_VideoDevice *_this, SDL_Window *window, SDL_GLContext context)
{
    @autoreleasepool {
        SDL_uikitopenglview *view = (__bridge SDL_uikitopenglview *)context;

        if (!view || !eglMakeCurrent(view.eglDisplay, view.eglSurface, view.eglSurface, view.eglContext)) {
            return SDL_SetError("Could not make EGL context current");
        }
    }

    return true;
}

bool UIKit_GL_LoadLibrary(SDL_VideoDevice *_this, const char *path)
{
    if (path != NULL) {
        return SDL_SetError("iOS GL Load Library just here for compatibility");
    }
    return true;
}

bool UIKit_GL_SwapWindow(SDL_VideoDevice *_this, SDL_Window *window)
{
    @autoreleasepool {
        SDL_uikitopenglview *view = (__bridge SDL_uikitopenglview *)SDL_GL_GetCurrentContext();

#ifdef SDL_POWER_UIKIT
        SDL_UIKit_UpdateBatteryMonitoring();
#endif

        [view swapBuffers];
    }
    return true;
}

SDL_GLContext UIKit_GL_CreateContext(SDL_VideoDevice *_this, SDL_Window *window)
{
    @autoreleasepool {
        SDL_uikitopenglview *view;
        SDL_UIKitWindowData *data = (__bridge SDL_UIKitWindowData *)window->internal;
        CGRect frame = UIKit_ComputeViewFrame(window, data.uiwindow.screen);
        CGFloat scale = 1.0;
        int samples = 0;
        int major = _this->gl_config.major_version;
        int minor = _this->gl_config.minor_version;

        if (major > 3 || (major == 3 && minor > 0)) {
            SDL_SetError("OpenGL ES %d.%d context could not be created", major, minor);
            return NULL;
        }

        if (_this->gl_config.multisamplebuffers > 0) {
            samples = _this->gl_config.multisamplesamples;
        }

        if (window->flags & SDL_WINDOW_HIGH_PIXEL_DENSITY) {
            scale = data.uiwindow.screen.nativeScale;
        }

        view = [[SDL_uikitopenglview alloc] initWithFrame:frame
                                            scale:scale
                                    retainBacking:_this->gl_config.retained_backing
                                            rBits:_this->gl_config.red_size
                                            gBits:_this->gl_config.green_size
                                            bBits:_this->gl_config.blue_size
                                            aBits:_this->gl_config.alpha_size
                                        depthBits:_this->gl_config.depth_size
                                      stencilBits:_this->gl_config.stencil_size
                                             sRGB:_this->gl_config.framebuffer_srgb_capable
                                      multisamples:samples
                                           context:NULL];

        if (!view) {
            return NULL;
        }

        SDL_PropertiesID props = SDL_GetWindowProperties(window);
        SDL_SetNumberProperty(props, SDL_PROP_WINDOW_UIKIT_OPENGL_FRAMEBUFFER_NUMBER, view.drawableFramebuffer);
        SDL_SetNumberProperty(props, SDL_PROP_WINDOW_UIKIT_OPENGL_RENDERBUFFER_NUMBER, view.drawableRenderbuffer);
        SDL_SetNumberProperty(props, SDL_PROP_WINDOW_UIKIT_OPENGL_RESOLVE_FRAMEBUFFER_NUMBER, view.msaaResolveFramebuffer);

        if (!UIKit_GL_MakeCurrent(_this, window, (__bridge SDL_GLContext)view)) {
            UIKit_GL_DestroyContext(_this, (__bridge SDL_GLContext)view);
            return NULL;
        }

        return (__bridge SDL_GLContext)view;
    }
}

bool UIKit_GL_DestroyContext(SDL_VideoDevice *_this, SDL_GLContext context)
{
    @autoreleasepool {
        SDL_uikitopenglview *view = (__bridge SDL_uikitopenglview *)context;
        if (view) {
            view = nil;
        }
    }
    return true;
}

void UIKit_GL_RestoreCurrentContext(void)
{
    @autoreleasepool {
        SDL_uikitopenglview *view = (__bridge SDL_uikitopenglview *)SDL_GL_GetCurrentContext();
        if (view != nil && view.eglContext != eglGetCurrentContext()) {
            eglMakeCurrent(view.eglDisplay, view.eglSurface, view.eglSurface, view.eglContext);
        }
    }
}

#endif // SDL_VIDEO_DRIVER_UIKIT
