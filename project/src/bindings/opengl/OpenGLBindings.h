#pragma once

#if defined(LIME_GLAD)
	#include <glad/gles2.h>
	//#include <glad/glsc2.h>
#elif defined(LIME_ANGLE) && defined(IPHONE)
	#define GL_GLEXT_PROTOTYPES 1
	#include <GLES3/gl3.h>
	#include <GLES2/gl2ext.h>
#endif

namespace lime {


	class OpenGLBindings {

		public:

			static bool initialized;
			static bool Init ();

	};


	enum GLObjectType {

		TYPE_UNKNOWN,
		TYPE_PROGRAM,
		TYPE_SHADER,
		TYPE_BUFFER,
		TYPE_TEXTURE,
		TYPE_FRAMEBUFFER,
		TYPE_RENDERBUFFER,
		TYPE_VERTEX_ARRAY_OBJECT,
		TYPE_QUERY,
		TYPE_SAMPLER,
		TYPE_SYNC,
		TYPE_TRANSFORM_FEEDBACK

	};


}
