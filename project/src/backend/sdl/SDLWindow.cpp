#include "SDLWindow.h"
#include "SDLApplication.h"
#include "system/System.h"
#ifdef ANDROID
#include <android/native_window.h>
#endif

#include <vector>
#include <cstring>


namespace lime {


	static SystemCursor currentCursor = DEFAULT;

	double drawScale = 1.0;

	SDLWindow::SDLWindow (Application* application, int width, int height, int flags, const char* title) {

		sdlTexture = 0;
		sdlRenderer = 0;

		#ifdef LIME_BGFX
		metalView = 0;
		#endif

		contextWidth = 0;
		contextHeight = 0;

		currentApplication = application;

		this->flags = flags;

		int sdlWindowFlags = 0;

		if (flags & WINDOW_FLAG_FULLSCREEN) sdlWindowFlags |= SDL_WINDOW_FULLSCREEN;
		if (flags & WINDOW_FLAG_RESIZABLE) sdlWindowFlags |= SDL_WINDOW_RESIZABLE;
		if (flags & WINDOW_FLAG_TRANSPARENT) sdlWindowFlags |= SDL_WINDOW_TRANSPARENT;
		if (flags & WINDOW_FLAG_BORDERLESS) sdlWindowFlags |= SDL_WINDOW_BORDERLESS;
		if (flags & WINDOW_FLAG_ALLOW_HIGHDPI) sdlWindowFlags |= SDL_WINDOW_HIGH_PIXEL_DENSITY;
		if (flags & WINDOW_FLAG_HIDDEN) sdlWindowFlags |= SDL_WINDOW_HIDDEN;
		if (flags & WINDOW_FLAG_MINIMIZED) sdlWindowFlags |= SDL_WINDOW_MINIMIZED;
		if (flags & WINDOW_FLAG_MAXIMIZED) sdlWindowFlags |= SDL_WINDOW_MAXIMIZED;
		if (flags & WINDOW_FLAG_ALWAYS_ON_TOP) sdlWindowFlags |= SDL_WINDOW_ALWAYS_ON_TOP;

		// bgfx is the only hardware renderer; no SDL_WINDOW_OPENGL, no GL
		// attributes — bgfx configures its own backbuffer from reset flags
		#if defined(HX_MACOS) || defined(IPHONE) || defined(APPLETV)
		sdlWindowFlags |= SDL_WINDOW_METAL;
		#endif

		sdlWindow = SDL_CreateWindow (title, width, height, sdlWindowFlags);

		if (!sdlWindow) {

			SDL_Log ("Could not create SDL Window: %s.\nReturning null...\n", SDL_GetError ());

			return;

		}

		#ifdef LIME_BGFX

		// bgfx::init happens later, from lime.graphics.bgfx.BGFX on the
		// Haxe side, using GetNativeWindowHandle / GetNativeDisplayHandle

		#if defined(HX_MACOS) || defined(IPHONE) || defined(APPLETV)
		metalView = SDL_Metal_CreateView (sdlWindow);
		#endif

		((SDLApplication*)currentApplication)->RegisterWindow (this);

		#else

		// no bgfx in this build: software renderer only
		sdlRenderer = SDL_CreateRenderer (sdlWindow, SDL_SOFTWARE_RENDERER);

		if (sdlRenderer) {

			((SDLApplication*)currentApplication)->RegisterWindow (this);

		} else {

			SDL_Log ("Could not create SDL renderer: %s.\n", SDL_GetError ());

		}

		#endif

	}


	SDLWindow::~SDLWindow () {

		if (sdlWindow) {

			SDL_DestroyWindow (sdlWindow);
			sdlWindow = 0;

		}

		if (sdlRenderer) {

			SDL_DestroyRenderer (sdlRenderer);

		}

		#ifdef LIME_BGFX
		if (metalView) {

			SDL_Metal_DestroyView (metalView);
			metalView = 0;

		}
		#endif

	}


	int SDLWindow::Alert (int type, const char* message, const char* title, const char** buttons, int count) {

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
		SDL_zero (data);
		data.flags = flags;
		data.title = title;
		data.message = message;
		data.window = sdlWindow;

		std::vector<SDL_MessageBoxButtonData> sdlButtons;

		sdlButtons.reserve (count);

		if (count == 1) {

			SDL_MessageBoxButtonData button;
			button.flags = SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT;
			button.buttonID = 0;
			button.text = buttons[0];
			sdlButtons.push_back (button);

		} else {

			for (int i = 0; i < count; ++i) {

				SDL_MessageBoxButtonData button;
				SDL_zero (button);
				button.buttonID = i;
				button.text = buttons[i];
				sdlButtons.push_back (button);

			}

		}

		data.numbuttons = sdlButtons.size ();
		data.buttons = sdlButtons.data ();

		int buttonID;

		if (!SDL_ShowMessageBox (&data, &buttonID)) {

			buttonID = -1;

		}

		return buttonID;

	}


	bool SDLWindow::SetVSyncMode (int mode) {

		// vsync is controlled through BGFX_RESET_VSYNC on the Haxe side
		return false;

	}


	void SDLWindow::Close () {

		if (sdlWindow) {

			SDL_DestroyWindow (sdlWindow);
			sdlWindow = 0;

		}

	}


	bool SDLWindow::SetVisible (bool visible) {

		if (visible) {

			SDL_ShowWindow (sdlWindow);

		} else {

			SDL_HideWindow (sdlWindow);

		}

		return !(SDL_GetWindowFlags (sdlWindow) & SDL_WINDOW_HIDDEN);

	}


	void SDLWindow::ContextFlip () {

		if (SDLApplication::isInBackground ()) return;

		// bgfx presents inside bgfx::frame; only the software fallback flips here
		if (sdlRenderer) {

			SDL_RenderPresent (sdlRenderer);

		}

	}


	void* SDLWindow::ContextLock (bool useCFFIValue) {

		if (sdlRenderer) {

			int width;
			int height;

			SDL_GetCurrentRenderOutputSize (sdlRenderer, &width, &height);

			if (width != contextWidth || height != contextHeight) {

				if (sdlTexture) {

					SDL_DestroyTexture (sdlTexture);

				}

				sdlTexture = SDL_CreateTexture (sdlRenderer, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_STREAMING, width, height);

				contextWidth = width;
				contextHeight = height;

			}

			void *pixels;
			int pitch;

			if (useCFFIValue) {

				if (SDL_LockTexture (sdlTexture, NULL, &pixels, &pitch)) {

					value result = alloc_empty_object ();
					alloc_field (result, val_id ("width"), alloc_int (contextWidth));
					alloc_field (result, val_id ("height"), alloc_int (contextHeight));
					alloc_field (result, val_id ("pixels"), alloc_float ((uintptr_t)pixels));
					alloc_field (result, val_id ("pitch"), alloc_int (pitch));
					return result;

				} else {

					return alloc_null ();

				}

			} else {

				const int id_width = hl_hash_utf8 ("width");
				const int id_height = hl_hash_utf8 ("height");
				const int id_pixels = hl_hash_utf8 ("pixels");
				const int id_pitch = hl_hash_utf8 ("pitch");

				if (SDL_LockTexture (sdlTexture, NULL, &pixels, &pitch)) {

					vdynamic* result = (vdynamic*)hl_alloc_dynobj ();
					hl_dyn_seti (result, id_width, &hlt_i32, contextWidth);
					hl_dyn_seti (result, id_height, &hlt_i32, contextHeight);
					hl_dyn_setd (result, id_pixels, (uintptr_t)pixels);
					hl_dyn_seti (result, id_pitch, &hlt_i32, pitch);
					return result;

				} else {

					return 0;

				}

			}

		} else {

			if (useCFFIValue) {

				return alloc_null ();

			} else {

				return 0;

			}

		}

	}


	void SDLWindow::ContextMakeCurrent () {

		// no-op: bgfx owns the device context

	}


	void SDLWindow::ContextUnlock () {

		if (sdlTexture) {

			SDL_UnlockTexture (sdlTexture);
			SDL_RenderClear (sdlRenderer);
			SDL_RenderTexture (sdlRenderer, sdlTexture, NULL, NULL);

		}

	}


	void SDLWindow::Focus () {

		SDL_RaiseWindow (sdlWindow);

	}


	void* SDLWindow::GetHandle () {

		SDL_PropertiesID props = SDL_GetWindowProperties (sdlWindow);

		// note: SDL_VIDEO_DRIVER_* are SDL-internal build macros and are never
		// defined for library consumers; use the public SDL_PLATFORM_* macros.
		// SDL_GetPointerProperty RETURNS the value (third argument is a default).

		#if defined(SDL_PLATFORM_WIN32)
			return SDL_GetPointerProperty (props, SDL_PROP_WINDOW_WIN32_HWND_POINTER, NULL);
		#elif defined(SDL_PLATFORM_MACOS)
			return SDL_GetPointerProperty (props, SDL_PROP_WINDOW_COCOA_WINDOW_POINTER, NULL);
		#elif defined(SDL_PLATFORM_ANDROID)
			return SDL_GetPointerProperty (props, SDL_PROP_WINDOW_ANDROID_WINDOW_POINTER, NULL);
		#elif defined(SDL_PLATFORM_IOS) || defined(SDL_PLATFORM_TVOS)
			return SDL_GetPointerProperty (props, SDL_PROP_WINDOW_UIKIT_WINDOW_POINTER, NULL);
		#elif defined(SDL_PLATFORM_LINUX)
			const char* videoDriver = SDL_GetCurrentVideoDriver ();

			if (videoDriver && SDL_strcmp (videoDriver, "wayland") == 0) {

				return SDL_GetPointerProperty (props, SDL_PROP_WINDOW_WAYLAND_SURFACE_POINTER, NULL);

			}

			return (void*)(uintptr_t)SDL_GetNumberProperty (props, SDL_PROP_WINDOW_X11_WINDOW_NUMBER, 0);
		#else
			return nullptr;
		#endif

	}


	void* SDLWindow::GetContext () {

		return 0;

	}


	const char* SDLWindow::GetContextType () {

		#ifdef LIME_BGFX
		if (sdlWindow) {

			return "bgfx";

		}
		#endif

		if (sdlRenderer) {

			return "software";

		}

		return "none";

	}


	int SDLWindow::GetDisplay () {

		return SDL_GetDisplayForWindow (sdlWindow);

	}


	void SDLWindow::GetDisplayMode (DisplayMode* displayMode) {

		const SDL_DisplayMode *mode = SDL_GetDesktopDisplayMode (SDL_GetDisplayForWindow (sdlWindow));

		displayMode->width = mode->w;
		displayMode->height = mode->h;

		switch (mode->format) {

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


	int SDLWindow::GetHeight () {

		int width;
		int height;

		SDL_GetWindowSizeInPixels (sdlWindow, &width, &height);

		return height;

	}


	uint32_t SDLWindow::GetID () {

		return SDL_GetWindowID (sdlWindow);

	}


	bool SDLWindow::GetMouseLock () {

		return SDL_GetWindowRelativeMouseMode (sdlWindow);

	}


	float SDLWindow::GetOpacity () {

		return SDL_GetWindowOpacity (sdlWindow);

	}


	double SDLWindow::GetScale () {

		return 1;

	}


	bool SDLWindow::GetTextInputEnabled () {

		return SDL_TextInputActive (sdlWindow);

	}


	int SDLWindow::GetWidth () {

		int width;
		int height;

		SDL_GetWindowSizeInPixels (sdlWindow, &width, &height);

		return width;

	}


	int SDLWindow::GetX () {

		int x;
		int y;

		SDL_GetWindowPosition (sdlWindow, &x, &y);

		return x;

	}


	int SDLWindow::GetY () {

		int x;
		int y;

		SDL_GetWindowPosition (sdlWindow, &x, &y);

		return y;

	}


	void SDLWindow::Move (int x, int y) {

		SDL_SetWindowPosition (sdlWindow, x, y);

	}


	void SDLWindow::ReadPixels (ImageBuffer *buffer, Rectangle *rect) {

		if (sdlRenderer) {

			SDL_Rect bounds = { 0, 0, 0, 0 };

			if (rect) {

				bounds.x = rect->x;
				bounds.y = rect->y;
				bounds.w = rect->width;
				bounds.h = rect->height;

			} else {

				SDL_GetWindowSizeInPixels (sdlWindow, &bounds.w, &bounds.h);

			}

			buffer->Resize (bounds.w, bounds.h, 32);

			buffer->data->buffer->b = (unsigned char *)(SDL_RenderReadPixels (sdlRenderer, &bounds)->pixels);

		}

	}


	void SDLWindow::Resize (int width, int height) {

		SDL_SetWindowSize (sdlWindow, width, height);

	}


	void SDLWindow::SetMinimumSize (int width, int height) {

		SDL_SetWindowMinimumSize (sdlWindow, width, height);

	}


	void SDLWindow::SetMaximumSize (int width, int height) {

		SDL_SetWindowMaximumSize (sdlWindow, width, height);

	}


	bool SDLWindow::SetBorderless (bool borderless) {

		SDL_SetWindowBordered (sdlWindow, !borderless);
		return borderless;

	}


	void SDLWindow::SetCursor (SystemCursor cursor) {

		if (cursor != currentCursor) {

			if (currentCursor == HIDDEN) {

				SDL_ShowCursor ();

			}

			switch (cursor) {

				case HIDDEN:

					SDL_HideCursor ();
					break;

				default:

					SDL_SetCursor ((SDL_Cursor*)Cursor::GetSystemCursor (cursor));
					break;

			}

			currentCursor = cursor;

		}

	}


	void SDLWindow::SetDisplayMode (DisplayMode* displayMode) {

		SDL_PixelFormat pixelFormat;

		switch (displayMode->pixelFormat) {

			case ARGB32:

				pixelFormat = SDL_PIXELFORMAT_ARGB8888;
				break;

			case BGRA32:

				pixelFormat = SDL_PIXELFORMAT_BGRA8888;
				break;

			default:

				pixelFormat = SDL_PIXELFORMAT_RGBA8888;

		}

		SDL_DisplayMode mode = { static_cast<SDL_DisplayID>(GetDisplay()), pixelFormat, displayMode->width, displayMode->height, (float)(SDL_GetDesktopDisplayMode(1)->pixel_density), (float)(displayMode->refreshRate), 0, 0 };

		if (SDL_SetWindowFullscreenMode (sdlWindow, &mode)) {

			if (SDL_GetWindowFlags (sdlWindow) & SDL_WINDOW_FULLSCREEN) {

				SDL_SetWindowFullscreen (sdlWindow, true);

			}

		}

	}


	bool SDLWindow::SetFullscreen (bool fullscreen) {

		SDL_SetWindowFullscreen (sdlWindow, fullscreen);
		return fullscreen;

	}


	void SDLWindow::SetIcon (ImageBuffer *imageBuffer) {

		SDL_PixelFormat format = SDL_GetPixelFormatForMasks (imageBuffer->bitsPerPixel, 0x000000FF, 0x0000FF00, 0x00FF0000, 0xFF000000);

		SDL_Surface *surface = SDL_CreateSurfaceFrom (imageBuffer->width, imageBuffer->height, format, imageBuffer->data->buffer->b, imageBuffer->Stride ());

		if (surface) {

			SDL_SetWindowIcon (sdlWindow, surface);
			SDL_DestroySurface (surface);

		}

	}


	bool SDLWindow::SetMaximized (bool maximized) {

		if (maximized) {

			SDL_MaximizeWindow (sdlWindow);

		} else {

			SDL_RestoreWindow (sdlWindow);

		}

		return maximized;

	}


	bool SDLWindow::SetMinimized (bool minimized) {

		if (minimized) {

			SDL_MinimizeWindow (sdlWindow);

		} else {

			SDL_RestoreWindow (sdlWindow);

		}

		return minimized;

	}


	void SDLWindow::SetMouseLock (bool mouseLock) {

		if (mouseLock) {

			SDL_SetWindowRelativeMouseMode (sdlWindow, true);

		} else {

			SDL_SetWindowRelativeMouseMode (sdlWindow, false);

		}

	}


	void SDLWindow::SetOpacity (float opacity) {

		SDL_SetWindowOpacity (sdlWindow, opacity);

	}


	bool SDLWindow::SetResizable (bool resizable) {

		if (resizable) {

			SDL_SetWindowResizable (sdlWindow, true);

		} else {

			SDL_SetWindowResizable (sdlWindow, false);

		}

		return (SDL_GetWindowFlags (sdlWindow) & SDL_WINDOW_RESIZABLE);

	}


	void SDLWindow::SetTextInputEnabled (bool enabled) {

		if (enabled) {

			SDL_StartTextInput (sdlWindow);

		} else {

			SDL_StopTextInput (sdlWindow);

		}

	}


	void SDLWindow::SetTextInputRect (Rectangle * rect) {

		SDL_Rect bounds = { 0, 0, 0, 0 };

		if (rect) {

			bounds.x = rect->x;
			bounds.y = rect->y;
			bounds.w = rect->width;
			bounds.h = rect->height;

		}

		SDL_SetTextInputArea (sdlWindow, &bounds, 0);

	}


	const char* SDLWindow::SetTitle (const char* title) {

		SDL_SetWindowTitle (sdlWindow, title);

		return title;

	}


	bool SDLWindow::SetAlwaysOnTop (bool alwaysOnTop) {

		SDL_SetWindowAlwaysOnTop (sdlWindow, alwaysOnTop);

		return alwaysOnTop;

	}


	void SDLWindow::WarpMouse (int x, int y) {

		SDL_WarpMouseInWindow (sdlWindow, x, y);

	}


	double SDLWindow::GetDrawScale () {

		return GetWidth () / GetNativeWidth ();

	}


	int SDLWindow::GetNativeWidth () {

		#if defined(ANDROID)
		return ANativeWindow_getWidth ((ANativeWindow*)GetHandle ());
		#else
		int width;
		int height;

		SDL_GetWindowSizeInPixels (sdlWindow, &width, &height);

		return width;
		#endif

	}


	int SDLWindow::GetNativeHeight () {

		#if defined(ANDROID)
		return ANativeWindow_getHeight ((ANativeWindow*)GetHandle ());
		#else
		int width;
		int height;

		SDL_GetWindowSizeInPixels (sdlWindow, &width, &height);

		return height;
		#endif

	}


	void* SDLWindow::GetNativeWindowHandle () {

		#ifdef LIME_BGFX
		#if defined(HX_MACOS) || defined(IPHONE) || defined(APPLETV)
		// bgfx accepts a CAMetalLayer directly as the native window handle
		if (metalView) {

			return SDL_Metal_GetLayer (metalView);

		}
		#endif
		#endif

		return GetHandle ();

	}


	void* SDLWindow::GetNativeDisplayHandle () {

		#if defined(SDL_PLATFORM_LINUX)
			SDL_PropertiesID props = SDL_GetWindowProperties (sdlWindow);
			const char* videoDriver = SDL_GetCurrentVideoDriver ();

			if (videoDriver && SDL_strcmp (videoDriver, "wayland") == 0) {

				return SDL_GetPointerProperty (props, SDL_PROP_WINDOW_WAYLAND_DISPLAY_POINTER, NULL);

			}

			return SDL_GetPointerProperty (props, SDL_PROP_WINDOW_X11_DISPLAY_POINTER, NULL);
		#else
			return NULL;
		#endif

	}


	Window* MakeWindow (Application* application, int width, int height, int flags, const char* title) {

		return new SDLWindow (application, width, height, flags, title);

	}


}
