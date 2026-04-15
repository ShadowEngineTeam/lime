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

#include <EGL/egl.h>
#include <EGL/eglext.h>
#include <GLES2/gl2.h>
#include <GLES2/gl2ext.h>
#include <GLES3/gl3.h>
#import "SDL_uikitopenglview.h"
#include "SDL_uikitwindow.h"

@implementation SDL_uikitopenglview
{
    EGLDisplay eglDisplay;
    EGLSurface eglSurface;
    EGLContext eglContext;

    GLuint viewRenderbuffer, viewFramebuffer;
    GLuint depthRenderbuffer;

    GLenum colorBufferFormat;
    GLenum depthBufferFormat;

    GLuint msaaFramebuffer, msaaRenderbuffer;

    int samples;

    BOOL retainedBacking;

    CAMetalLayer *metalLayer;
}

@synthesize backingWidth;
@synthesize backingHeight;
@synthesize eglDisplay;
@synthesize eglSurface;
@synthesize eglContext;

+ (Class)layerClass
{
    return [CAMetalLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
                        scale:(CGFloat)scale
                retainBacking:(BOOL)retained
                        rBits:(int)rBits
                        gBits:(int)gBits
                        bBits:(int)bBits
                        aBits:(int)aBits
                    depthBits:(int)depthBits
                  stencilBits:(int)stencilBits
                          sRGB:(int)sRGB
                  multisamples:(int)multisamples
                       context:(EGLContext *)glcontext
{
    if ((self = [super initWithFrame:frame])) {
        const BOOL useStencilBuffer = (stencilBits != 0);
        const BOOL useDepthBuffer = (depthBits != 0);

        samples = multisamples;
        retainedBacking = retained;

        metalLayer = (CAMetalLayer *)self.layer;
        metalLayer.device = MTLCreateSystemDefaultDevice();
        metalLayer.pixelFormat = MTLPixelFormatBGRA8Unorm;
        metalLayer.framebufferOnly = !retained;
        metalLayer.drawableSize = CGSizeMake(frame.size.width * scale, frame.size.height * scale);

        self.contentScaleFactor = scale;

        eglDisplay = eglGetDisplay(EGL_DEFAULT_DISPLAY);
        if (eglDisplay == EGL_NO_DISPLAY) {
            SDL_SetError("Could not create EGL display");
            return nil;
        }

        EGLint majorVersion, minorVersion;
        if (!eglInitialize(eglDisplay, &majorVersion, &minorVersion)) {
            SDL_SetError("Could not initialize EGL");
            return nil;
        }

        EGLint configAttribs[] = {
            EGL_SURFACE_TYPE, EGL_WINDOW_BIT,
            EGL_RED_SIZE, rBits ? rBits : 5,
            EGL_GREEN_SIZE, gBits ? gBits : 6,
            EGL_BLUE_SIZE, bBits ? bBits : 5,
            EGL_ALPHA_SIZE, aBits,
            EGL_DEPTH_SIZE, depthBits,
            EGL_STENCIL_SIZE, stencilBits,
            EGL_SAMPLE_BUFFERS, samples > 0 ? 1 : 0,
            EGL_SAMPLES, samples,
            EGL_RENDERABLE_TYPE, EGL_OPENGL_ES2_BIT,
            EGL_NONE
        };

        EGLConfig eglConfig;
        EGLint numConfigs;
        if (!eglChooseConfig(eglDisplay, configAttribs, &eglConfig, 1, &numConfigs) || numConfigs == 0) {
            SDL_SetError("Could not find suitable EGL config");
            return nil;
        }

        eglBindAPI(EGL_OPENGL_ES_API);

        EGLint contextAttribs[] = {
            EGL_CONTEXT_CLIENT_VERSION, 2,
            EGL_NONE
        };
        eglContext = eglCreateContext(eglDisplay, eglConfig, EGL_NO_CONTEXT, contextAttribs);
        if (eglContext == EGL_NO_CONTEXT) {
            SDL_SetError("Could not create EGL context");
            return nil;
        }

        EGLint surfaceAttribs[] = {
            EGL_WIDTH, (int)(frame.size.width * scale),
            EGL_HEIGHT, (int)(frame.size.height * scale),
            EGL_NONE
        };
        eglSurface = eglCreateWindowSurface(eglDisplay, eglConfig, (__bridge EGLNativeWindowType)metalLayer, surfaceAttribs);
        if (eglSurface == EGL_NO_SURFACE) {
            SDL_SetError("Could not create EGL surface");
            return nil;
        }

        if (!eglMakeCurrent(eglDisplay, eglSurface, eglSurface, eglContext)) {
            SDL_SetError("Could not make EGL context current");
            return nil;
        }

        if (samples > 0) {
            EGLint maxsamples = 0;
            eglGetConfigAttrib(eglDisplay, eglConfig, EGL_SAMPLES, &maxsamples);
            if (maxsamples > 0) {
                samples = SDL_min(samples, (int)maxsamples);
            } else {
                samples = 0;
            }
        }

        backingWidth = (int)(frame.size.width * scale);
        backingHeight = (int)(frame.size.height * scale);

        glGenFramebuffers(1, &viewFramebuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, viewFramebuffer);

        glGenRenderbuffers(1, &viewRenderbuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, viewRenderbuffer);
        glRenderbufferStorage(GL_RENDERBUFFER, GL_RGBA8, backingWidth, backingHeight);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, viewRenderbuffer);

        if (useDepthBuffer || useStencilBuffer) {
            if (useStencilBuffer) {
                depthBufferFormat = GL_DEPTH24_STENCIL8_OES;
            } else if (useDepthBuffer) {
                depthBufferFormat = GL_DEPTH_COMPONENT24_OES;
            }

            glGenRenderbuffers(1, &depthRenderbuffer);
            glBindRenderbuffer(GL_RENDERBUFFER, depthRenderbuffer);
            glRenderbufferStorage(GL_RENDERBUFFER, depthBufferFormat, backingWidth, backingHeight);

            if (useDepthBuffer) {
                glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthRenderbuffer);
            }
            if (useStencilBuffer) {
                glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_STENCIL_ATTACHMENT, GL_RENDERBUFFER, depthRenderbuffer);
            }
        }

        if (samples > 0) {
            glGenFramebuffers(1, &msaaFramebuffer);
            glBindFramebuffer(GL_FRAMEBUFFER, msaaFramebuffer);

            glGenRenderbuffers(1, &msaaRenderbuffer);
            glBindRenderbuffer(GL_RENDERBUFFER, msaaRenderbuffer);
            glRenderbufferStorage(GL_RENDERBUFFER, GL_RGB, backingWidth, backingHeight);

            glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, msaaRenderbuffer);
        }

        if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE) {
            SDL_SetError("Failed creating OpenGL ES framebuffer");
            return nil;
        }

        if (samples > 0) {
            glBindFramebuffer(GL_FRAMEBUFFER, msaaFramebuffer);
        } else {
            glBindFramebuffer(GL_FRAMEBUFFER, viewFramebuffer);
        }
    }

    return self;
}

- (GLuint)drawableRenderbuffer
{
    return viewRenderbuffer;
}

- (GLuint)drawableFramebuffer
{
    if (msaaFramebuffer) {
        return msaaFramebuffer;
    } else {
        return viewFramebuffer;
    }
}

- (GLuint)msaaResolveFramebuffer
{
    if (msaaFramebuffer) {
        return viewFramebuffer;
    } else {
        return 0;
    }
}

- (void)updateFrame
{
    CGRect bounds = self.bounds;
    CGFloat scale = self.contentScaleFactor;

    backingWidth = (int)(bounds.size.width * scale);
    backingHeight = (int)(bounds.size.height * scale);

    metalLayer.drawableSize = CGSizeMake(backingWidth, backingHeight);

    if (depthRenderbuffer != 0) {
        glBindRenderbuffer(GL_RENDERBUFFER, depthRenderbuffer);
        glRenderbufferStorage(GL_RENDERBUFFER, depthBufferFormat, backingWidth, backingHeight);
    }

    if (msaaRenderbuffer != 0) {
        glBindRenderbuffer(GL_RENDERBUFFER, msaaRenderbuffer);
        glRenderbufferStorage(GL_RENDERBUFFER, GL_RGB, backingWidth, backingHeight);
    }
}

- (void)swapBuffers
{
    if (msaaFramebuffer) {
        glBindFramebuffer(GL_READ_FRAMEBUFFER, msaaFramebuffer);
        glBindFramebuffer(GL_DRAW_FRAMEBUFFER, 0);
        glBlitFramebuffer(0, 0, backingWidth, backingHeight,
                          0, 0, backingWidth, backingHeight,
                          GL_COLOR_BUFFER_BIT, GL_NEAREST);
    }

    eglSwapBuffers(eglDisplay, eglSurface);

    if (msaaFramebuffer) {
        glBindFramebuffer(GL_FRAMEBUFFER, msaaFramebuffer);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    int width = (int)(self.bounds.size.width * self.contentScaleFactor);
    int height = (int)(self.bounds.size.height * self.contentScaleFactor);

    if (width != backingWidth || height != backingHeight) {
        /* EGLContext is an opaque handle (void *); do not add another '*'. */
        EGLContext prevContext = eglGetCurrentContext();
        EGLDisplay prevDisplay = eglGetCurrentDisplay();
        EGLSurface prevDraw = eglGetCurrentSurface(EGL_DRAW);
        EGLSurface prevRead = eglGetCurrentSurface(EGL_READ);

        if (prevContext != eglContext || prevDraw != eglSurface) {
            eglMakeCurrent(eglDisplay, eglSurface, eglSurface, eglContext);
        }

        [self updateFrame];

        if (prevContext != EGL_NO_CONTEXT) {
            eglMakeCurrent(prevDisplay, prevDraw, prevRead, prevContext);
        }
    }
}

- (void)destroyFramebuffer
{
    if (viewFramebuffer != 0) {
        glDeleteFramebuffers(1, &viewFramebuffer);
        viewFramebuffer = 0;
    }

    if (viewRenderbuffer != 0) {
        glDeleteRenderbuffers(1, &viewRenderbuffer);
        viewRenderbuffer = 0;
    }

    if (depthRenderbuffer != 0) {
        glDeleteRenderbuffers(1, &depthRenderbuffer);
        depthRenderbuffer = 0;
    }

    if (msaaFramebuffer != 0) {
        glDeleteFramebuffers(1, &msaaFramebuffer);
        msaaFramebuffer = 0;
    }

    if (msaaRenderbuffer != 0) {
        glDeleteRenderbuffers(1, &msaaRenderbuffer);
        msaaRenderbuffer = 0;
    }
}

- (void)dealloc
{
    if (eglContext != EGL_NO_CONTEXT) {
        if (viewFramebuffer != 0 || depthRenderbuffer != 0 || msaaFramebuffer != 0) {
            eglMakeCurrent(eglDisplay, eglSurface, eglSurface, eglContext);
            [self destroyFramebuffer];
        }
        eglDestroyContext(eglDisplay, eglContext);
        eglContext = EGL_NO_CONTEXT;
    }

    if (eglSurface != EGL_NO_SURFACE) {
        eglDestroySurface(eglDisplay, eglSurface);
        eglSurface = EGL_NO_SURFACE;
    }

    if (eglDisplay != EGL_NO_DISPLAY) {
        eglTerminate(eglDisplay);
        eglDisplay = EGL_NO_DISPLAY;
    }
}

@end

#endif // SDL_VIDEO_DRIVER_UIKIT