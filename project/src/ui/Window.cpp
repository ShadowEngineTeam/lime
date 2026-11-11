#include <app/Application.h>
#ifdef LIME_OPENGL
#include <bindings/opengl/OpenGLBindings.h>
#endif
#ifdef LIME_BGFX
#include <bindings/bgfx/BGFXBindings.h>
#endif
#ifdef ANDROID
#include <android/native_window.h>
#endif

#include <cstring>
#include <system/System.h>
#include <ui/Window.h>
#include <vector>

namespace lime
{
	static SystemCursor currentCursor = DEFAULT;

	double drawScale = 1.0;

	static bool envEnabled(const char *name)
	{
		const char *value = SDL_getenv(name);
		return value != NULL && value[0] != '\0' && value[0] != '0';
	}

	static void showRendererError(SDL_Window *window, const char *title)
	{
#if defined(IPHONE)
		printf("%s: %s\n", title, SDL_GetError());
#else
		SDL_Log("%s: %s\n", title, SDL_GetError());
		SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_ERROR, title, SDL_GetError(), window);
#endif
	}

	Window::Window(Application *application, int width, int height, int flags, const char *title)
	{
		context = 0;
		bgfxRenderer = false;
		sdlWindow = 0;

		contextWidth = 0;
		contextHeight = 0;

		currentApplication = application;

		this->flags = flags;

		int sdlWindowFlags = 0;

		if (flags & WINDOW_FLAG_FULLSCREEN)
			sdlWindowFlags |= SDL_WINDOW_FULLSCREEN;

		if (flags & WINDOW_FLAG_RESIZABLE)
			sdlWindowFlags |= SDL_WINDOW_RESIZABLE;

		if (flags & WINDOW_FLAG_TRANSPARENT)
			sdlWindowFlags |= SDL_WINDOW_TRANSPARENT;

		if (flags & WINDOW_FLAG_BORDERLESS)
			sdlWindowFlags |= SDL_WINDOW_BORDERLESS;

		if (flags & WINDOW_FLAG_ALLOW_HIGHDPI)
			sdlWindowFlags |= SDL_WINDOW_HIGH_PIXEL_DENSITY;

		if (flags & WINDOW_FLAG_HIDDEN)
			sdlWindowFlags |= SDL_WINDOW_HIDDEN;

		if (flags & WINDOW_FLAG_MINIMIZED)
			sdlWindowFlags |= SDL_WINDOW_MINIMIZED;

		if (flags & WINDOW_FLAG_MAXIMIZED)
			sdlWindowFlags |= SDL_WINDOW_MAXIMIZED;

		if (flags & WINDOW_FLAG_ALWAYS_ON_TOP)
			sdlWindowFlags |= SDL_WINDOW_ALWAYS_ON_TOP;

		auto createWindow = [&](int windowFlags, bool externalContext) -> SDL_Window *
		{
			SDL_PropertiesID props = SDL_CreateProperties();

			if (title && (*title))
			{
				SDL_SetStringProperty(props, SDL_PROP_WINDOW_CREATE_TITLE_STRING, title);
			}

			SDL_SetNumberProperty(props, SDL_PROP_WINDOW_CREATE_WIDTH_NUMBER, width);
			SDL_SetNumberProperty(props, SDL_PROP_WINDOW_CREATE_HEIGHT_NUMBER, height);
			SDL_SetNumberProperty(props, SDL_PROP_WINDOW_CREATE_FLAGS_NUMBER, windowFlags);

			if (externalContext)
			{
				// bgfx creates the graphics context itself, so SDL must not set one up for the window
				SDL_SetBooleanProperty(props, SDL_PROP_WINDOW_CREATE_EXTERNAL_GRAPHICS_CONTEXT_BOOLEAN, true);
			}

			SDL_Window *window = SDL_CreateWindowWithProperties(props);

			SDL_DestroyProperties(props);

			return window;
		};

		// The renderers are tried in this order:
		//   1. bgfx on Vulkan (Metal on Apple)
		//   2. OpenGL 4 or 3 core, then OpenGL 2 (OpenGL ES 3, then ES 2, where that is the platform's)
		//
		// LIME_RENDERER names one instead: "opengl" for step 2 alone, or a bgfx renderer ("vulkan", "metal",
		// "d3d11", "d3d12", "bgfx-opengl", "bgfx-opengles"), which then has nothing to fall back to.
		//
		// A software implementation (lavapipe, llvmpipe, WARP...) counts as a failure at every step,
		// unless LIME_ALLOW_SOFTWARE_RENDERER is set.
		const char *requested = SDL_getenv("LIME_RENDERER");
		bool hasRequest = requested != NULL && requested[0] != '\0' && SDL_strcasecmp(requested, "auto") != 0;
		const bool openglRequested = hasRequest && (SDL_strcasecmp(requested, "opengl") == 0 || SDL_strcasecmp(requested, "opengles") == 0);
		const bool allowSoftware = envEnabled("LIME_ALLOW_SOFTWARE_RENDERER");

#ifdef LIME_BGFX
		if (!openglRequested)
		{
			int rendererType = hasRequest ? BGFXBindings::GetRendererType(requested) : BGFXBindings::GetDefaultRendererType();

			if (rendererType < 0)
			{
				SDL_Log("LIME_RENDERER: \"%s\" is not a renderer, using the default order\n", requested);

				hasRequest = false;
				rendererType = BGFXBindings::GetDefaultRendererType();
			}

			sdlWindow = createWindow(sdlWindowFlags, true);

			if (sdlWindow)
			{
				if (BGFXBindings::Init(sdlWindow, rendererType, allowSoftware))
				{
					bgfxRenderer = true;

					currentApplication->RegisterWindow(this);

					return;
				}

				if (hasRequest)
				{
					// Asked for by name: there is nothing to fall back to
					showRendererError(sdlWindow, "Could not start the renderer LIME_RENDERER asks for");
				}
				else
				{
					SDL_Log("bgfx: %s. Falling back to OpenGL\n", SDL_GetError());
				}

				SDL_DestroyWindow(sdlWindow);
				sdlWindow = 0;
			}
			else if (hasRequest)
			{
				showRendererError(NULL, "Could not create a window");
			}

			if (hasRequest)
			{
				return;
			}
		}
#else
		if (hasRequest && !openglRequested)
		{
			SDL_Log("LIME_RENDERER: this build has no bgfx renderers, using OpenGL\n");
		}
#endif

#ifdef LIME_OPENGL
		softwareAllowed = allowSoftware;

		const int samples = (flags & WINDOW_FLAG_ANTIALIASING_8X) ? 8 : (flags & WINDOW_FLAG_ANTIALIASING_4X) ? 4 : (flags & WINDOW_FLAG_ANTIALIASING_2X) ? 2 : 0;

#if defined(LIME_OPENGL_GLES)
		SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_ES);
		SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3);
		SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 0);
#elif defined(__APPLE__)
		SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE);
		SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3);
		SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 2);
		SDL_GL_SetAttribute(SDL_GL_CONTEXT_FLAGS, SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG);
#endif

		if (flags & WINDOW_FLAG_DEPTH_BUFFER)
		{
			SDL_GL_SetAttribute(SDL_GL_DEPTH_SIZE, 32 - ((flags & WINDOW_FLAG_STENCIL_BUFFER) ? 8 : 0));
		}

		if (flags & WINDOW_FLAG_STENCIL_BUFFER)
		{
			SDL_GL_SetAttribute(SDL_GL_STENCIL_SIZE, 8);
		}

		SDL_GL_SetAttribute(SDL_GL_MULTISAMPLEBUFFERS, samples > 0 ? 1 : 0);
		SDL_GL_SetAttribute(SDL_GL_MULTISAMPLESAMPLES, samples);

		const bool color32 = (flags & WINDOW_FLAG_COLOR_DEPTH_32_BIT) != 0;

		SDL_GL_SetAttribute(SDL_GL_RED_SIZE, color32 ? 8 : 5);
		SDL_GL_SetAttribute(SDL_GL_GREEN_SIZE, color32 ? 8 : 6);
		SDL_GL_SetAttribute(SDL_GL_BLUE_SIZE, color32 ? 8 : 5);
		SDL_GL_SetAttribute(SDL_GL_ALPHA_SIZE, color32 ? 8 : 0);

		sdlWindow = createWindow(sdlWindowFlags | SDL_WINDOW_OPENGL, false);

		// Retry without MSAA
		if (!sdlWindow && samples > 0)
		{
			SDL_GL_SetAttribute(SDL_GL_MULTISAMPLEBUFFERS, 0);
			SDL_GL_SetAttribute(SDL_GL_MULTISAMPLESAMPLES, 0);

			sdlWindow = createWindow(sdlWindowFlags | SDL_WINDOW_OPENGL, false);
		}

#if defined(LIME_OPENGL_GLES)
		// Retry with ES 2
		if (!sdlWindow)
		{
			SDL_Log("Could not create SDL Window with OpenGL ES 3: %s\nTrying OpenGL ES 2...", SDL_GetError());

			SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_ES);
			SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 2);
			SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 0);

			sdlWindow = createWindow(sdlWindowFlags | SDL_WINDOW_OPENGL, false);
		}
#endif
#endif

		if (!sdlWindow)
		{
			showRendererError(NULL, "Could not create a window with a supported renderer");
			return;
		}

		if (!CreateRenderer())
		{
			showRendererError(sdlWindow, "Could not start a renderer");

			if (context)
			{
				SDL_GL_DestroyContext(context);
				context = 0;
			}

			if (sdlWindow)
			{
				SDL_DestroyWindow(sdlWindow);
				sdlWindow = 0;
			}
		}
	}

	Window::~Window()
	{
#ifdef LIME_BGFX
		// Before the window goes: bgfx still presents to it
		if (bgfxRenderer)
		{
			BGFXBindings::Shutdown();
			bgfxRenderer = false;
		}
#endif

		if (sdlWindow)
		{
			SDL_DestroyWindow(sdlWindow);
			sdlWindow = 0;
		}

		if (context)
		{
			SDL_GL_DestroyContext(context);
			context = 0;
		}
	}

	// Creates the OpenGL context of a window made for one. bgfx is started by the constructor.
	bool Window::CreateRenderer()
	{
#ifdef LIME_OPENGL
#if defined(LIME_OPENGL_GL) && !defined(__APPLE__)
		{
			struct GLContextRequest
			{
				SDL_GLProfile profile;
				int major;
				int minor;
				SDL_GLContextFlag flags;
			};

			static const GLContextRequest contextRequests[] = {
				{SDL_GL_CONTEXT_PROFILE_CORE, 4, 1, SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG},
				{SDL_GL_CONTEXT_PROFILE_CORE, 3, 3, SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG},
				{SDL_GL_CONTEXT_PROFILE_COMPATIBILITY, 4, 0, (SDL_GLContextFlag)0},
				{SDL_GL_CONTEXT_PROFILE_COMPATIBILITY, 2, 1, (SDL_GLContextFlag)0},
			};

			const bool compatOnly = envEnabled("LIME_GL_COMPAT");

			for (size_t i = compatOnly ? 2 : 0; i < SDL_arraysize(contextRequests); ++i)
			{
				const GLContextRequest &request = contextRequests[i];

				SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, request.profile);
				SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, request.major);
				SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, request.minor);
				SDL_GL_SetAttribute(SDL_GL_CONTEXT_FLAGS, request.flags);

				context = SDL_GL_CreateContext(sdlWindow);

				if (context)
					break;
			}
		}
#elif defined(LIME_OPENGL_GLES)
		context = SDL_GL_CreateContext(sdlWindow);

		// The window can exist while the driver has no OpenGL ES 3 context for it
		if (!context)
		{
			SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_ES);
			SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 2);
			SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 0);

			context = SDL_GL_CreateContext(sdlWindow);
		}
#else
		context = SDL_GL_CreateContext(sdlWindow);
#endif

		if (context && SDL_GL_MakeCurrent(sdlWindow, context))
		{
			OpenGLBindings::Init();

			if (!softwareAllowed)
			{
				// The names the software OpenGL implementations go by
				static const char *softwareRenderers[] = {"llvmpipe", "softpipe", "swrast", "SwiftShader", "GDI Generic", "Software Rasterizer", "Software Renderer"};

				const char *renderer = (const char *)glGetString(GL_RENDERER);

				for (size_t i = 0; renderer && i < SDL_arraysize(softwareRenderers); ++i)
				{
					if (SDL_strcasestr(renderer, softwareRenderers[i]))
					{
						SDL_SetError("the only OpenGL device is a software one (%s)", renderer);
						return false;
					}
				}
			}

			SetVSyncMode((flags & WINDOW_FLAG_VSYNC) ? WINDOW_VSYNC_ON : WINDOW_VSYNC_OFF);

#if defined(LIME_OPENGL_GL)
#if defined(LIME_GLAD)
			if (glGenVertexArrays != NULL && glBindVertexArray != NULL)
#endif
			{
				GLuint defaultVAO = 0;
				glGenVertexArrays(1, &defaultVAO);
				glBindVertexArray(defaultVAO);
			}
#endif

#if defined(IPHONE)
			SDL_PropertiesID props = SDL_GetWindowProperties(sdlWindow);
			OpenGLBindings::defaultFramebuffer = (int)SDL_GetNumberProperty(props, SDL_PROP_WINDOW_UIKIT_OPENGL_FRAMEBUFFER_NUMBER, 0);
			OpenGLBindings::defaultRenderbuffer = (int)SDL_GetNumberProperty(props, SDL_PROP_WINDOW_UIKIT_OPENGL_RENDERBUFFER_NUMBER, 0);
#endif

			currentApplication->RegisterWindow(this);

			return true;
		}

		return false;
#else
		SDL_SetError("this build has no OpenGL renderer");
		return false;
#endif
	}

	int Window::Alert(int type, const char *message, const char *title, const char **buttons, int count)
	{
		SDL_MessageBoxFlags flags = SDL_MESSAGEBOX_BUTTONS_LEFT_TO_RIGHT;

		switch (type)
		{
			case 0:
				flags |= SDL_MESSAGEBOX_ERROR;
				break;

			case 1:
				flags |= SDL_MESSAGEBOX_WARNING;
				break;

			case 2:
				flags |= SDL_MESSAGEBOX_INFORMATION;
				break;
		}

		SDL_MessageBoxData data;
		SDL_zero(data);
		data.flags = flags;
		data.title = title;
		data.message = message;
		data.window = sdlWindow;

		std::vector<SDL_MessageBoxButtonData> sdlButtons;

		sdlButtons.reserve(count);

		if (count == 1)
		{
			SDL_MessageBoxButtonData button;
			button.flags = SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT;
			button.buttonID = 0;
			button.text = buttons[0];
			sdlButtons.push_back(button);
		}
		else
		{
			for (int i = 0; i < count; ++i)
			{
				SDL_MessageBoxButtonData button;
				SDL_zero(button);
				button.buttonID = i;
				button.text = buttons[i];
				sdlButtons.push_back(button);
			}
		}

		data.numbuttons = sdlButtons.size();
		data.buttons = sdlButtons.data();

		int buttonID;

		if (!SDL_ShowMessageBox(&data, &buttonID))
		{
			buttonID = -1;
		}

		return buttonID;
	}

	bool Window::SetVSyncMode(int mode)
	{
		return SDL_GL_SetSwapInterval(mode);
	}

	void Window::Close()
	{
#ifdef LIME_BGFX
		if (bgfxRenderer)
		{
			BGFXBindings::Shutdown();
			bgfxRenderer = false;
		}
#endif

		if (sdlWindow)
		{
			SDL_DestroyWindow(sdlWindow);
			sdlWindow = 0;
		}
	}

	bool Window::SetVisible(bool visible)
	{
		if (visible)
		{
			SDL_ShowWindow(sdlWindow);
		}
		else
		{
			SDL_HideWindow(sdlWindow);
		}

		return !(SDL_GetWindowFlags(sdlWindow) & SDL_WINDOW_HIDDEN);
	}

	void Window::ContextFlip()
	{
		if (context)
		{
#if defined(LIME_OPENGL_GLES)
#if defined(LIME_GLAD)
			const bool canInvalidate = glInvalidateFramebuffer != NULL;
#else
			const bool canInvalidate = true;
#endif

			if (canInvalidate)
			{
				GLint boundFramebuffer = 0;
				glGetIntegerv(GL_FRAMEBUFFER_BINDING, &boundFramebuffer);

				if (boundFramebuffer == OpenGLBindings::defaultFramebuffer)
				{
					const GLenum attachments[] = {GL_DEPTH, GL_STENCIL};
					glInvalidateFramebuffer(GL_FRAMEBUFFER, 2, attachments);
				}
			}
#endif

			SDL_GL_SwapWindow(sdlWindow);
		}
	}

	void Window::ContextMakeCurrent()
	{
		if (sdlWindow && context)
		{
			SDL_GL_MakeCurrent(sdlWindow, context);
		}
	}

	void Window::Focus()
	{
		SDL_RaiseWindow(sdlWindow);
	}

	void *Window::GetHandle()
	{
		SDL_PropertiesID props = SDL_GetWindowProperties(sdlWindow);

#if defined(SDL_VIDEO_DRIVER_WINDOWS)
		void *hwnd = nullptr;
		SDL_GetPointerProperty(props, SDL_PROP_WINDOW_WIN32_HWND_POINTER, &hwnd);
		return hwnd;
#elif defined(SDL_VIDEO_DRIVER_X11)
		unsigned long x11win = 0;
		SDL_GetNumberProperty(props, SDL_PROP_WINDOW_X11_WINDOW_NUMBER, &x11win);
		return (void *)(uintptr_t)x11win;
#elif defined(SDL_VIDEO_DRIVER_WAYLAND)
		void *wlSurface = nullptr;
		SDL_GetPointerProperty(props, SDL_PROP_WINDOW_WAYLAND_SURFACE_POINTER, &wlSurface);
		return wlSurface;
#elif defined(SDL_VIDEO_DRIVER_ANDROID)
		void *native = nullptr;
		SDL_GetPointerProperty(props, SDL_PROP_WINDOW_ANDROID_WINDOW_POINTER, &native);
		return native;
#elif defined(SDL_VIDEO_DRIVER_COCOA)
		void *cocoa = nullptr;
		SDL_GetPointerProperty(props, SDL_PROP_WINDOW_COCOA_WINDOW_POINTER, &cocoa);
		return cocoa;
#else
		return nullptr;
#endif
	}

	void *Window::GetContext()
	{
		return context;
	}

	const char *Window::GetContextType()
	{
		if (bgfxRenderer)
		{
			return "bgfx";
		}

		if (context)
		{
			return "opengl";
		}

		return "none";
	}

	int Window::GetDisplay()
	{
		return SDL_GetDisplayForWindow(sdlWindow);
	}

	void Window::GetDisplayMode(DisplayMode *displayMode)
	{
		const SDL_DisplayMode *mode = SDL_GetDesktopDisplayMode(SDL_GetDisplayForWindow(sdlWindow));

		displayMode->width = mode->w;
		displayMode->height = mode->h;

		switch (mode->format)
		{
			case SDL_PIXELFORMAT_ARGB8888:

				displayMode->pixelFormat = ARGB32;
				break;

			case SDL_PIXELFORMAT_BGRA8888:
			case SDL_PIXELFORMAT_BGRX8888:

				displayMode->pixelFormat = BGRA32;
				break;

			default:

				displayMode->pixelFormat = RGBA32;
		}

		displayMode->refreshRate = mode->refresh_rate;
	}

	int Window::GetHeight()
	{
		int width;
		int height;

#ifndef IPHONE
		SDL_GetWindowSize(sdlWindow, &width, &height);
#else
		SDL_GetWindowSizeInPixels(sdlWindow, &width, &height);
#endif

		return height;
	}

	uint32_t Window::GetID()
	{
		return SDL_GetWindowID(sdlWindow);
	}

	bool Window::GetMouseLock()
	{
		return SDL_GetWindowRelativeMouseMode(sdlWindow);
	}

	float Window::GetOpacity()
	{
		return SDL_GetWindowOpacity(sdlWindow);
	}

	double Window::GetScale()
	{
#ifndef IPHONE
		return SDL_GetWindowPixelDensity(sdlWindow);
#else
		return 1;
#endif
	}

	double Window::GetDisplayScale()
	{
		return SDL_GetWindowDisplayScale(sdlWindow);
	}

	bool Window::GetTextInputEnabled()
	{
		return SDL_TextInputActive(sdlWindow);
	}

	int Window::GetWidth()
	{
		int width;
		int height;

#ifndef IPHONE
		SDL_GetWindowSize(sdlWindow, &width, &height);
#else
		SDL_GetWindowSizeInPixels(sdlWindow, &width, &height);
#endif

		return width;
	}

	int Window::GetX()
	{
		int x;
		int y;

		SDL_GetWindowPosition(sdlWindow, &x, &y);

		return x;
	}

	int Window::GetY()
	{
		int x;
		int y;

		SDL_GetWindowPosition(sdlWindow, &x, &y);

		return y;
	}

	void Window::Move(int x, int y)
	{
		SDL_SetWindowPosition(sdlWindow, x, y);
	}

	void Window::ReadPixels(ImageBuffer *buffer, Rectangle *rect)
	{
		if (context)
		{
			// TODO
		}
	}

	void Window::Resize(int width, int height)
	{
		SDL_SetWindowSize(sdlWindow, width, height);
	}

	void Window::SetMinimumSize(int width, int height)
	{
		SDL_SetWindowMinimumSize(sdlWindow, width, height);
	}

	void Window::SetMaximumSize(int width, int height)
	{
		SDL_SetWindowMaximumSize(sdlWindow, width, height);
	}

	bool Window::SetBorderless(bool borderless)
	{
		SDL_SetWindowBordered(sdlWindow, !borderless);
		return borderless;
	}

	void Window::SetCursor(SystemCursor cursor)
	{
		if (cursor != currentCursor)
		{
			if (currentCursor == HIDDEN)
			{
				SDL_ShowCursor();
			}

			switch (cursor)
			{
				case HIDDEN:

					SDL_HideCursor();
					break;

				default:

					SDL_SetCursor((SDL_Cursor *)Cursor::GetSystemCursor(cursor));
					break;
			}

			currentCursor = cursor;
		}
	}

	void Window::SetDisplayMode(DisplayMode *displayMode)
	{
		SDL_PixelFormat pixelFormat;

		switch (displayMode->pixelFormat)
		{
			case ARGB32:

				pixelFormat = SDL_PIXELFORMAT_ARGB8888;
				break;

			case BGRA32:

				pixelFormat = SDL_PIXELFORMAT_BGRA8888;
				break;

			default:

				pixelFormat = SDL_PIXELFORMAT_RGBA8888;
		}

		SDL_DisplayMode mode = {static_cast<SDL_DisplayID>(GetDisplay()), pixelFormat, displayMode->width, displayMode->height, (float)(SDL_GetDesktopDisplayMode(1)->pixel_density), (float)(displayMode->refreshRate), 0, 0};

		if (SDL_SetWindowFullscreenMode(sdlWindow, &mode))
		{
			if (SDL_GetWindowFlags(sdlWindow) & SDL_WINDOW_FULLSCREEN)
			{
				SDL_SetWindowFullscreen(sdlWindow, true);
			}
		}
	}

	bool Window::SetFullscreen(bool fullscreen)
	{
#if (defined(LIME_BGFX) && (defined(IPHONE) || defined(HX_MACOS)))
		BGFXBindings::SetMetalLayerComposited(!fullscreen);
#endif

		SDL_SetWindowFullscreen(sdlWindow, fullscreen);
		return fullscreen;
	}

	void Window::SetIcon(ImageBuffer *imageBuffer)
	{
		SDL_PixelFormat format = SDL_GetPixelFormatForMasks(imageBuffer->bitsPerPixel, 0x000000FF, 0x0000FF00, 0x00FF0000, 0xFF000000);

		SDL_Surface *surface = SDL_CreateSurfaceFrom(imageBuffer->width, imageBuffer->height, format, imageBuffer->data->buffer->b, imageBuffer->Stride());

		if (surface)
		{
			SDL_SetWindowIcon(sdlWindow, surface);
			SDL_DestroySurface(surface);
		}
	}

	bool Window::SetMaximized(bool maximized)
	{
		if (maximized)
		{
			SDL_MaximizeWindow(sdlWindow);
		}
		else
		{
			SDL_RestoreWindow(sdlWindow);
		}

		return maximized;
	}

	bool Window::SetMinimized(bool minimized)
	{
		if (minimized)
		{
			SDL_MinimizeWindow(sdlWindow);
		}
		else
		{
			SDL_RestoreWindow(sdlWindow);
		}

		return minimized;
	}

	void Window::SetMouseLock(bool mouseLock)
	{
		SDL_SetWindowRelativeMouseMode(sdlWindow, mouseLock);
	}

	void Window::SetOpacity(float opacity)
	{
		SDL_SetWindowOpacity(sdlWindow, opacity);
	}

	bool Window::SetResizable(bool resizable)
	{
		SDL_SetWindowResizable(sdlWindow, resizable);

		return (SDL_GetWindowFlags(sdlWindow) & SDL_WINDOW_RESIZABLE);
	}

	void Window::SetTextInputEnabled(bool enabled)
	{
		if (enabled)
		{
			SDL_StartTextInput(sdlWindow);
		}
		else
		{
			SDL_StopTextInput(sdlWindow);
		}
	}

	void Window::SetTextInputRect(Rectangle *rect)
	{
		SDL_Rect bounds = {0, 0, 0, 0};

		if (rect)
		{
			bounds.x = rect->x;
			bounds.y = rect->y;
			bounds.w = rect->width;
			bounds.h = rect->height;
		}

		SDL_SetTextInputArea(sdlWindow, &bounds, 0);
	}

	const char *Window::SetTitle(const char *title)
	{
		SDL_SetWindowTitle(sdlWindow, title);

		return title;
	}

	bool Window::SetAlwaysOnTop(bool alwaysOnTop)
	{
		SDL_SetWindowAlwaysOnTop(sdlWindow, alwaysOnTop);

		return alwaysOnTop;
	}

	void Window::WarpMouse(int x, int y)
	{
		SDL_WarpMouseInWindow(sdlWindow, x, y);
	}

	double Window::GetDrawScale()
	{
		const int nativeWidth = GetNativeWidth();

		if (nativeWidth <= 0)
		{
			return 1.0;
		}

		return (double)GetWidth() / (double)nativeWidth;
	}

	int Window::GetNativeWidth()
	{
#if defined(ANDROID)
		return ANativeWindow_getWidth((ANativeWindow *)GetHandle());
#else
		int width;
		int height;

		SDL_GetWindowSizeInPixels(sdlWindow, &width, &height);

		return width;
#endif
	}

	int Window::GetNativeHeight()
	{
#if defined(ANDROID)
		return ANativeWindow_getHeight((ANativeWindow *)GetHandle());
#else
		int width;
		int height;

		SDL_GetWindowSizeInPixels(sdlWindow, &width, &height);

		return height;
#endif
	}

} // namespace lime