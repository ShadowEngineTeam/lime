#pragma once

#include <SDL3/SDL.h>

#undef main

namespace lime
{

	class BGFXBindings
	{
	  public:
		static SDL_Window *defaultWindow;

		// Starts bgfx on the window with this renderer only. It does not try another one when
		// that fails. With `software` it only starts on a software device, without it never on one.
		static bool Init(SDL_Window *sdlWindow, int rendererType, bool software);

		// The renderer bgfx starts on when none is asked for: Metal on Apple, Vulkan elsewhere.
		static int GetDefaultRendererType();

		// The renderer a name such as "vulkan" or "d3d11" stands for, or -1.
		static int GetRendererType(const char *name);

		static const char *GetRendererName(int rendererType);

		static void SetMetalLayerComposited(bool composit);

		static void ResetWindow(int width, int height);

		static bool SetVSync(bool vsync);

		static void Shutdown();
	};

} // namespace lime
