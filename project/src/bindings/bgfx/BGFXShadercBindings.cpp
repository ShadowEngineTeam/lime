// windows.h (via the CFFI include chain) defines min/max macros that break
// bx templates; neutralize before anything else is included
#ifndef NOMINMAX
#define NOMINMAX
#endif

#include <system/CFFI.h>
#include <utils/Bytes.h>

#ifdef min
#undef min
#endif
#ifdef max
#undef max
#endif

#ifdef LIME_BGFX_SHADERC
#include <bx/allocator.h>
#include <bx/file.h>
#include <bx/readerwriter.h>
#include <shaderc.h>
#include <SDL3/SDL_system.h>

#include "BGFXShaderIncludes.h"

namespace bgfx {

	// defined in tools/shaderc/shaderc.cpp but not declared in shaderc.h
	bool compileShader (const char* _varying, const char* _comment, char* _shader, uint32_t _shaderLen, const Options& _options,
		bx::WriterI* _shaderWriter, bx::WriterI* _messageWriter);

}
#endif

#include <string>
#include <cstring>


namespace lime {


	static std::string bgfxShadercMessages;


	#ifdef LIME_BGFX_SHADERC

	// Extract the embedded bgfx shader include files (bgfx_shader.sh etc.) to
	// a per-user cache directory, so `#include <bgfx_shader.sh>` always works
	// without shipping the files next to the application.
	static const char* EnsureEmbeddedIncludeDir () {
		static std::string includeDir;
		if (!includeDir.empty ()) {
			return includeDir.c_str ();
		}

		std::string base;

		#if defined (ANDROID)
		const char* androidCache = SDL_GetAndroidCachePath ();
		if (androidCache && androidCache[0]) base = androidCache;
		#elif defined (IPHONE) || defined (APPLETV)
		char* prefPath = SDL_GetPrefPath (NULL, "bgfx-include"); // org/app id already known to SDL from the bundle
		if (prefPath && prefPath[0]) base = prefPath;
		if (prefPath) SDL_free (prefPath);
		#else
		const char* envBase = getenv ("TEMP");
		#ifndef HX_WINDOWS
		if (!envBase || !envBase[0]) envBase = getenv ("TMPDIR");
		if (!envBase || !envBase[0]) envBase = "/tmp";
		#endif
		if (envBase) base = envBase;
		#endif

		if (base.empty ()) {
			return "";
		}

		if (base.back () == '/' || base.back () == '\\') {
			base.pop_back ();
		}
		std::string dir = base + "/lime-bgfx-include";

		bx::makeAll (bx::FilePath (dir.c_str ()), bx::ErrorIgnore{});

		struct EmbeddedFile {
			const char* name;
			const unsigned char* data;
			unsigned int length;
		};
		const EmbeddedFile files[] = {
			{ "bgfx_shader.sh", bgfx_shader_sh, bgfx_shader_sh_len },
			{ "bgfx_compute.sh", bgfx_compute_sh, bgfx_compute_sh_len },
		};
		for (const EmbeddedFile& file : files) {
			std::string path = dir + "/" + file.name;
			FILE* existing = fopen (path.c_str (), "rb");
			if (existing) {
				fseek (existing, 0, SEEK_END);
				long size = ftell (existing);
				fclose (existing);
				if (size == (long)file.length) continue;
			}
			FILE* f = fopen (path.c_str (), "wb");
			if (!f) return "";
			fwrite (file.data, 1, file.length, f);
			fclose (f);
		}

		includeDir = dir;
		return includeDir.c_str ();
	}


	static bool CompileBGFXShader (const char* source, int sourceLength, char shaderType, const char* platform, const char* profile,
		const char* varying, const char* includeDir, bool debug, Bytes* result) {

		bgfxShadercMessages.clear ();

		// LIME_BGFX_DUMP_SHADERS=1 writes every source handed to the runtime
		// shaderc into %TEMP%/lime-shader-NNN-<type>.txt for debugging
		const char* dumpEnv = getenv ("LIME_BGFX_DUMP_SHADERS");
		if (dumpEnv && dumpEnv[0] && dumpEnv[0] != '0') {
			const char* tempDir = getenv ("TEMP");
			if (tempDir && tempDir[0]) {
				static int dumpCounter = 0;
				char path[1024];
				snprintf (path, sizeof (path), "%s/lime-shader-%03d-%c.txt", tempDir, dumpCounter++, shaderType);
				FILE* f = fopen (path, "wb");
				if (f) {
					fwrite (source, 1, sourceLength, f);
					const char* sep = "\n---- varying.def ----\n";
					fwrite (sep, 1, strlen (sep), f);
					if (varying) fwrite (varying, 1, strlen (varying), f);
					fclose (f);
				}
			}
		}

		bgfx::Options options;
		options.shaderType = shaderType;
		options.platform = platform;
		options.profile = profile;
		options.inputFilePath = "<runtime>";
		options.debugInformation = debug;
		options.optimize = !debug;
		options.optimizationLevel = 3;

		if (includeDir && includeDir[0]) {

			options.includeDirs.push_back (includeDir);

		}

		// embedded bgfx_shader.sh / bgfx_compute.sh are always reachable
		const char* embeddedDir = EnsureEmbeddedIncludeDir ();
		if (embeddedDir[0]) {

			options.includeDirs.push_back (embeddedDir);

		}

		// compileShader takes ownership of the buffer (delete[]); fcpp needs
		// 16K of zeroed scratch space and a trailing newline after the source
		const int32_t padding = 16384;
		int32_t size = sourceLength;
		char* data = new char[size + padding];
		bx::memCopy (data, source, size);
		data[size] = '\n';
		bx::memSet (&data[size + 1], 0, padding - 1);

		bx::DefaultAllocator allocator;
		bx::MemoryBlock shaderBlock (&allocator);
		bx::MemoryWriter shaderWriter (&shaderBlock);
		bx::MemoryBlock messageBlock (&allocator);
		bx::MemoryWriter messageWriter (&messageBlock);

		bool compiled = bgfx::compileShader (varying, "", data, size, options, &shaderWriter, &messageWriter);

		// MemoryBlock::getSize() reports the allocated capacity; the writer's
		// current position is the number of bytes actually written
		int32_t shaderSize = (int32_t)bx::seek (&shaderWriter, 0, bx::Whence::Current);
		int32_t messageSize = (int32_t)bx::seek (&messageWriter, 0, bx::Whence::Current);

		if (messageSize > 0) {

			bgfxShadercMessages.assign ((const char*)messageBlock.more (0), messageSize);

		}

		if (!compiled || shaderSize <= 0) {

			return false;

		}

		result->Resize (shaderSize);
		bx::memCopy (result->b, shaderBlock.more (0), shaderSize);

		return true;

	}

	#endif


	value lime_bgfx_compile_shader (HxString source, HxString type, HxString platform, HxString profile, HxString varying, HxString includeDir,
		bool debug, value bytes) {

		#ifdef LIME_BGFX_SHADERC
		Bytes result (bytes);

		if (CompileBGFXShader (source.__s, source.length, type.length > 0 ? type.__s[0] : 'f', platform.__s, profile.__s, varying.__s,
			includeDir.__s, debug, &result)) {

			return result.Value (bytes);

		}
		#endif

		return alloc_null ();

	}


	HL_PRIM Bytes* HL_NAME(hl_bgfx_compile_shader) (hl_vstring* source, hl_vstring* type, hl_vstring* platform, hl_vstring* profile,
		hl_vstring* varying, hl_vstring* includeDir, bool debug, Bytes* bytes) {

		#ifdef LIME_BGFX_SHADERC
		// copy immediately: each hl_to_utf8 result lives in a shared temp buffer
		std::string _source = source ? hl_to_utf8 (source->bytes) : "";
		std::string _type = type ? hl_to_utf8 (type->bytes) : "f";
		std::string _platform = platform ? hl_to_utf8 (platform->bytes) : "";
		std::string _profile = profile ? hl_to_utf8 (profile->bytes) : "";
		std::string _varying = varying ? hl_to_utf8 (varying->bytes) : "";
		std::string _includeDir = includeDir ? hl_to_utf8 (includeDir->bytes) : "";

		if (CompileBGFXShader (_source.c_str (), (int)_source.size (), _type.empty () ? 'f' : _type[0], _platform.c_str (), _profile.c_str (),
			_varying.c_str (), _includeDir.c_str (), debug, bytes)) {

			return bytes;

		}
		#endif

		return 0;

	}


	value lime_bgfx_get_shader_compile_messages () {

		return alloc_string (bgfxShadercMessages.c_str ());

	}


	HL_PRIM vbyte* HL_NAME(hl_bgfx_get_shader_compile_messages) () {

		int length = (int)bgfxShadercMessages.size ();
		vbyte* result = hl_alloc_bytes (length + 1);
		memcpy (result, bgfxShadercMessages.c_str (), length + 1);
		return result;

	}


	bool lime_bgfx_shaderc_available () {

		#ifdef LIME_BGFX_SHADERC
		return true;
		#else
		return false;
		#endif

	}


	HL_PRIM bool HL_NAME(hl_bgfx_shaderc_available) () {

		#ifdef LIME_BGFX_SHADERC
		return true;
		#else
		return false;
		#endif

	}


	DEFINE_PRIME8 (lime_bgfx_compile_shader);
	DEFINE_PRIME0 (lime_bgfx_get_shader_compile_messages);
	DEFINE_PRIME0 (lime_bgfx_shaderc_available);


	#define _TBYTES _OBJ (_I32 _BYTES)

	DEFINE_HL_PRIM (_TBYTES, hl_bgfx_compile_shader, _STRING _STRING _STRING _STRING _STRING _STRING _BOOL _TBYTES);
	DEFINE_HL_PRIM (_BYTES, hl_bgfx_get_shader_compile_messages, _NO_ARG);
	DEFINE_HL_PRIM (_BOOL, hl_bgfx_shaderc_available, _NO_ARG);


}
