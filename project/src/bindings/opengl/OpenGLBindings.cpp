#include "OpenGLBindings.h"

#include <hx/CFFIPrime.h>
#include <map>
#include <SDL3/SDL.h>
#include <string>
#include <system/CFFIPointer.h>
#include <system/Mutex.h>
#include <utils/Bytes.h>
#include <vector>

namespace lime
{

	bool OpenGLBindings::initialized = false;

	int OpenGLBindings::defaultFramebuffer = 0;
	int OpenGLBindings::defaultRenderbuffer = 0;

	std::map<GLObjectType, std::map<GLuint, void *>> glObjects;
	std::map<void *, GLuint> glObjectIDs;
	std::map<void *, void *> glObjectPtrs;
	std::map<void *, GLObjectType> glObjectTypes;

	std::vector<GLuint> gc_gl_id;
	std::vector<void *> gc_gl_ptr;
	std::vector<GLObjectType> gc_gl_type;
	Mutex gc_gl_mutex;

	void gc_gl_object(value object)
	{
		gc_gl_mutex.Lock();

		if (glObjectTypes.find(object) != glObjectTypes.end())
		{
			GLObjectType type = glObjectTypes[object];

			if (type != TYPE_SYNC)
			{
				GLuint id = glObjectIDs[object];

				gc_gl_id.push_back(id);
				gc_gl_type.push_back(type);

				glObjects[type].erase(id);
				glObjectIDs.erase(object);
				glObjectTypes.erase(object);
			}
			else
			{
				void *ptr = glObjectPtrs[object];

				gc_gl_ptr.push_back(ptr);

				glObjectPtrs.erase(object);
				glObjectTypes.erase(object);
			}
		}

		gc_gl_mutex.Unlock();
	}

	void gc_gl_run()
	{
		gc_gl_mutex.Lock();

		if (gc_gl_id.size() > 0 || gc_gl_ptr.size() > 0)
		{
			int size = gc_gl_id.size();

			GLuint id;
			GLObjectType type;

			for (int i = 0; i < size; i++)
			{
				id = gc_gl_id[i];
				type = gc_gl_type[i];

				switch (type)
				{
					case TYPE_BUFFER:

						if (glIsBuffer(id))
							glDeleteBuffers(1, &id);
						break;

					case TYPE_FRAMEBUFFER:

#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
						if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0)
						{
							if (GLAD_GL_EXT_framebuffer_object)
							{
								if (glIsFramebufferEXT(id))
									glDeleteFramebuffersEXT(1, &id);
							}
						}
						else
						{
							if (glIsFramebuffer(id))
								glDeleteFramebuffers(1, &id);
						}
#else
						if (glIsFramebuffer(id))
							glDeleteFramebuffers(1, &id);
#endif
						break;

					case TYPE_PROGRAM:

						if (glIsProgram(id))
							glDeleteProgram(id);
						break;

					case TYPE_QUERY:

						if (glIsQuery(id))
							glDeleteQueries(1, &id);
						break;

					case TYPE_RENDERBUFFER:

#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
						if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0)
						{
							if (GLAD_GL_EXT_framebuffer_object)
							{
								if (glIsRenderbufferEXT(id))
									glDeleteRenderbuffersEXT(1, &id);
							}
						}
						else
						{
							if (glIsRenderbuffer(id))
								glDeleteRenderbuffers(1, &id);
						}
#else
						if (glIsRenderbuffer(id))
							glDeleteRenderbuffers(1, &id);
#endif
						break;

					case TYPE_SAMPLER:

						if (glIsSampler(id))
							glDeleteSamplers(1, &id);
						break;

					case TYPE_SHADER:

						if (glIsShader(id))
							glDeleteShader(id);
						break;

					case TYPE_TEXTURE:

						if (glIsTexture(id))
							glDeleteTextures(1, &id);
						break;

					case TYPE_VERTEX_ARRAY_OBJECT:

#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
						if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0)
						{
							if (GLAD_GL_APPLE_vertex_array_object)
							{
								if (glIsVertexArrayAPPLE(id))
									glDeleteVertexArraysAPPLE(1, &id);
							}
							else if (GLAD_GL_ARB_vertex_array_object)
							{
								if (glIsVertexArray(id))
									glDeleteVertexArrays(1, &id);
							}
						}
						else
						{
							if (glIsVertexArray(id))
								glDeleteVertexArrays(1, &id);
						}
#else
						if (glIsVertexArray(id))
							glDeleteVertexArrays(1, &id);
#endif
						break;

					default:
						break;
				}
			}

			size = gc_gl_ptr.size();
			void *ptr;

			for (int i = 0; i < size; i++)
			{
				ptr = gc_gl_ptr[i];
				// type = gc_gl_type[i];

				if (glIsSync((GLsync)ptr))
					glDeleteSync((GLsync)ptr);
			}

			gc_gl_id.clear();
			gc_gl_ptr.clear();
			gc_gl_type.clear();
		}

		gc_gl_mutex.Unlock();
	}

	void lime_gl_active_texture(int texture)
	{
		glActiveTexture(texture);
	}

	void lime_gl_attach_shader(int program, int shader)
	{
		glAttachShader(program, shader);
	}

	void lime_gl_begin_query(int target, int query)
	{
		glBeginQuery(target, query);
	}

	void lime_gl_begin_transform_feedback(int primitiveNode)
	{
		glBeginTransformFeedback(primitiveNode);
	}

	void lime_gl_bind_attrib_location(int program, int index, HxString name)
	{
		glBindAttribLocation(program, index, name.__s);
	}

	void lime_gl_bind_buffer(int target, int buffer)
	{
		glBindBuffer(target, buffer);
	}

	void lime_gl_bind_buffer_base(int target, int index, int buffer)
	{
		glBindBufferBase(target, index, buffer);
	}

	void lime_gl_bind_buffer_range(int target, int index, int buffer, double offset, int size)
	{
		glBindBufferRange(target, index, buffer, (GLintptr)(uintptr_t)offset, size);
	}

	void lime_gl_bind_framebuffer(int target, int framebuffer)
	{
		if (!framebuffer)
		{
			framebuffer = OpenGLBindings::defaultFramebuffer;
		}

#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0)
		{
			if (GLAD_GL_EXT_framebuffer_object)
			{
				glBindFramebufferEXT(target, framebuffer);
			}
		}
		else
		{
			glBindFramebuffer(target, framebuffer);
		}
#else
		glBindFramebuffer(target, framebuffer);
#endif
	}

	void lime_gl_bind_renderbuffer(int target, int renderbuffer)
	{
		if (!renderbuffer)
		{
			renderbuffer = OpenGLBindings::defaultRenderbuffer;
		}

#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0)
		{
			if (GLAD_GL_EXT_framebuffer_object)
			{
				glBindRenderbufferEXT(target, renderbuffer);
			}
		}
		else
		{
			glBindRenderbuffer(target, renderbuffer);
		}
#else
		glBindRenderbuffer(target, renderbuffer);
#endif
	}

	void lime_gl_bind_sampler(int unit, int sampler)
	{
		glBindSampler(unit, sampler);
	}

	void lime_gl_bind_texture(int target, int texture)
	{
		glBindTexture(target, texture);
	}

	void lime_gl_bind_transform_feedback(int target, int transformFeedback)
	{
		glBindTransformFeedback(target, transformFeedback);
	}

	void lime_gl_bind_vertex_array(int vertexArray)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0)
		{
			if (GLAD_GL_APPLE_vertex_array_object)
			{
				glBindVertexArrayAPPLE(vertexArray);
			}
			else if (GLAD_GL_ARB_vertex_array_object)
			{
				glBindVertexArray(vertexArray);
			}
		}
		else
		{
			glBindVertexArray(vertexArray);
		}
#else
		glBindVertexArray(vertexArray);
#endif
	}

	void lime_gl_blend_color(float r, float g, float b, float a)
	{
		glBlendColor(r, g, b, a);
	}

	void lime_gl_blend_equation(int mode)
	{
		glBlendEquation(mode);
	}

	void lime_gl_blend_equation_separate(int rgb, int a)
	{
		glBlendEquationSeparate(rgb, a);
	}

	void lime_gl_blend_func(int sfactor, int dfactor)
	{
		glBlendFunc(sfactor, dfactor);
	}

	void lime_gl_blend_func_separate(int srcRGB, int destRGB, int srcAlpha, int destAlpha)
	{
		glBlendFuncSeparate(srcRGB, destRGB, srcAlpha, destAlpha);
	}

	void lime_gl_blend_barrier()
	{
#ifdef LIME_GLAD
		if (GLAD_GL_KHR_blend_equation_advanced)
		{
			glBlendBarrierKHR();
		}
#endif
	}

	void lime_gl_blit_framebuffer(int srcX0, int srcY0, int srcX1, int srcY1, int dstX0, int dstY0, int dstX1, int dstY1, int mask, int filter)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0)
		{
			if (GLAD_GL_EXT_framebuffer_blit)
			{
				glBlitFramebufferEXT(srcX0, srcY0, srcX1, srcY1, dstX0, dstY0, dstX1, dstY1, mask, filter);
			}
		}
		else
		{
			glBlitFramebuffer(srcX0, srcY0, srcX1, srcY1, dstX0, dstY0, dstX1, dstY1, mask, filter);
		}
#else
		glBlitFramebuffer(srcX0, srcY0, srcX1, srcY1, dstX0, dstY0, dstX1, dstY1, mask, filter);
#endif
	}

	void lime_gl_buffer_data(int target, int size, double data, int usage)
	{
		glBufferData(target, size, (void *)(uintptr_t)data, usage);
	}

	void lime_gl_buffer_sub_data(int target, int offset, int size, double data)
	{
		glBufferSubData(target, offset, size, (void *)(uintptr_t)data);
	}

	int lime_gl_check_framebuffer_status(int target)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		return (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0) ? (GLAD_GL_EXT_framebuffer_object ? glCheckFramebufferStatusEXT(target) : 0) : glCheckFramebufferStatus(target);
#else
		return glCheckFramebufferStatus(target);
#endif
	}

	void lime_gl_clear(int mask)
	{
		gc_gl_run();
		glClear(mask);
	}

	void lime_gl_clear_bufferfi(int buffer, int drawBuffer, float depth, int stencil)
	{
		glClearBufferfi(buffer, drawBuffer, depth, stencil);
	}

	void lime_gl_clear_bufferfv(int buffer, int drawBuffer, double data)
	{
		glClearBufferfv(buffer, drawBuffer, (GLfloat *)(uintptr_t)data);
	}

	void lime_gl_clear_bufferiv(int buffer, int drawBuffer, double data)
	{
		glClearBufferiv(buffer, drawBuffer, (GLint *)(uintptr_t)data);
	}

	void lime_gl_clear_bufferuiv(int buffer, int drawBuffer, double data)
	{
		glClearBufferuiv(buffer, drawBuffer, (GLuint *)(uintptr_t)data);
	}

	void lime_gl_clear_color(float red, float green, float blue, float alpha)
	{
		glClearColor(red, green, blue, alpha);
	}

	void lime_gl_clear_depthf(float depth)
	{
#ifdef LIME_OPENGL_GL
		glClearDepth(depth);
#else
		glClearDepthf(depth);
#endif
	}

	void lime_gl_clear_stencil(int stencil)
	{
		glClearStencil(stencil);
	}

	int lime_gl_client_wait_sync(value sync, int flags, int timeoutA, int timeoutB)
	{
		GLuint64 timeout = (GLuint64)timeoutA << 32 | timeoutB;
		return glClientWaitSync((GLsync)val_data(sync), flags, timeout);
	}

	void lime_gl_color_mask(bool red, bool green, bool blue, bool alpha)
	{
		glColorMask(red, green, blue, alpha);
	}

	void lime_gl_compile_shader(int shader)
	{
		glCompileShader(shader);
	}

	void lime_gl_compressed_tex_image_2d(int target, int level, int internalformat, int width, int height, int border, int imageSize, double data)
	{
		glCompressedTexImage2D(target, level, internalformat, width, height, border, imageSize, (void *)(uintptr_t)data);
	}

	void lime_gl_compressed_tex_image_3d(int target, int level, int internalformat, int width, int height, int depth, int border, int imageSize, double data)
	{
		glCompressedTexImage3D(target, level, internalformat, width, height, depth, border, imageSize, (void *)(uintptr_t)data);
	}

	void lime_gl_compressed_tex_sub_image_2d(int target, int level, int xoffset, int yoffset, int width, int height, int format, int imageSize, double data)
	{
		glCompressedTexSubImage2D(target, level, xoffset, yoffset, width, height, format, imageSize, (void *)(uintptr_t)data);
	}

	void lime_gl_compressed_tex_sub_image_3d(int target, int level, int xoffset, int yoffset, int zoffset, int width, int height, int depth, int format, int imageSize, double data)
	{
		glCompressedTexSubImage3D(target, level, xoffset, yoffset, zoffset, width, height, depth, format, imageSize, (void *)(uintptr_t)data);
	}

	void lime_gl_copy_buffer_sub_data(int readTarget, int writeTarget, double readOffset, double writeOffset, int size)
	{
		glCopyBufferSubData(readTarget, writeTarget, (GLintptr)(uintptr_t)readOffset, (GLintptr)(uintptr_t)writeOffset, size);
	}

	void lime_gl_copy_tex_image_2d(int target, int level, int internalformat, int x, int y, int width, int height, int border)
	{
		glCopyTexImage2D(target, level, internalformat, x, y, width, height, border);
	}

	void lime_gl_copy_tex_sub_image_2d(int target, int level, int xoffset, int yoffset, int x, int y, int width, int height)
	{
		glCopyTexSubImage2D(target, level, xoffset, yoffset, x, y, width, height);
	}

	void lime_gl_copy_tex_sub_image_3d(int target, int level, int xoffset, int yoffset, int zoffset, int x, int y, int width, int height)
	{
		glCopyTexSubImage3D(target, level, xoffset, yoffset, zoffset, x, y, width, height);
	}

	int lime_gl_create_buffer()
	{
		GLuint id = 0;
		glGenBuffers(1, &id);
		return id;
	}

	int lime_gl_create_framebuffer()
	{
		GLuint id = 0;

#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0)
		{
			if (GLAD_GL_EXT_framebuffer_object)
			{
				glGenFramebuffersEXT(1, &id);
			}
		}
		else
		{
			glGenFramebuffers(1, &id);
		}
#else
		glGenFramebuffers(1, &id);
#endif

		return id;
	}

	int lime_gl_create_program()
	{
		return glCreateProgram();
	}

	int lime_gl_create_query()
	{
		GLuint id = 0;
		glGenQueries(1, &id);
		return id;
	}

	int lime_gl_create_renderbuffer()
	{
		GLuint id = 0;

#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0)
		{
			if (GLAD_GL_EXT_framebuffer_object)
			{
				glGenRenderbuffersEXT(1, &id);
			}
		}
		else
		{
			glGenRenderbuffers(1, &id);
		}
#else
		glGenRenderbuffers(1, &id);
#endif

		return id;
	}

	int lime_gl_create_sampler()
	{
		GLuint id = 0;
		glGenSamplers(1, &id);
		return id;
	}

	int lime_gl_create_shader(int type)
	{
		return glCreateShader(type);
	}

	int lime_gl_create_texture()
	{
		GLuint id = 0;
		glGenTextures(1, &id);
		return id;
	}

	int lime_gl_create_transform_feedback()
	{
		GLuint id = 0;
		glGenTransformFeedbacks(1, &id);
		return id;
	}

	int lime_gl_create_vertex_array()
	{
		GLuint id = 0;

#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0)
		{
			if (GLAD_GL_APPLE_vertex_array_object)
			{
				glGenVertexArraysAPPLE(1, &id);
			}
			else if (GLAD_GL_ARB_vertex_array_object)
			{
				glGenVertexArrays(1, &id);
			}
		}
		else
		{
			glGenVertexArrays(1, &id);
		}
#else
		glGenVertexArrays(1, &id);
#endif

		return id;
	}

	void lime_gl_cull_face(int mode)
	{
		glCullFace(mode);
	}

	void lime_gl_delete_buffer(int buffer)
	{
		glDeleteBuffers(1, (GLuint *)&buffer);
	}

	void lime_gl_delete_framebuffer(int framebuffer)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0)
		{
			if (GLAD_GL_EXT_framebuffer_object)
			{
				glDeleteFramebuffersEXT(1, (GLuint *)&framebuffer);
			}
		}
		else
		{
			glDeleteFramebuffers(1, (GLuint *)&framebuffer);
		}
#else
		glDeleteFramebuffers(1, (GLuint *)&framebuffer);
#endif
	}

	void lime_gl_delete_program(int program)
	{
		glDeleteProgram(program);
	}

	void lime_gl_delete_query(int query)
	{
		glDeleteQueries(1, (GLuint *)&query);
	}

	void lime_gl_delete_renderbuffer(int renderbuffer)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0)
		{
			if (GLAD_GL_EXT_framebuffer_object)
			{
				glDeleteRenderbuffersEXT(1, (GLuint *)&renderbuffer);
			}
		}
		else
		{
			glDeleteRenderbuffers(1, (GLuint *)&renderbuffer);
		}
#else
		glDeleteRenderbuffers(1, (GLuint *)&renderbuffer);
#endif
	}

	void lime_gl_delete_sampler(int sampler)
	{
		glDeleteSamplers(1, (GLuint *)&sampler);
	}

	void lime_gl_delete_shader(int shader)
	{
		glDeleteShader(shader);
	}

	void lime_gl_delete_sync(value sync)
	{
		if (val_is_null(sync))
			return;
		glDeleteSync((GLsync)val_data(sync));
	}

	void lime_gl_delete_texture(int texture)
	{
		glDeleteTextures(1, (GLuint *)&texture);
	}

	void lime_gl_delete_transform_feedback(int transformFeedback)
	{
		glDeleteTransformFeedbacks(1, (GLuint *)&transformFeedback);
	}

	void lime_gl_delete_vertex_array(int vertexArray)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0)
		{
			if (GLAD_GL_APPLE_vertex_array_object)
			{
				glDeleteVertexArraysAPPLE(1, (GLuint *)&vertexArray);
			}
			else if (GLAD_GL_ARB_vertex_array_object)
			{
				glDeleteVertexArrays(1, (GLuint *)&vertexArray);
			}
		}
		else
		{
			glDeleteVertexArrays(1, (GLuint *)&vertexArray);
		}
#else
		glDeleteVertexArrays(1, (GLuint *)&vertexArray);
#endif
	}

	void lime_gl_depth_func(int func)
	{
		glDepthFunc(func);
	}

	void lime_gl_depth_mask(bool flag)
	{
		glDepthMask(flag);
	}

	void lime_gl_depth_rangef(float zNear, float zFar)
	{
		glDepthRangef(zNear, zFar);
	}

	void lime_gl_detach_shader(int program, int shader)
	{
		glDetachShader(program, shader);
	}

	void lime_gl_disable(int cap)
	{
		glDisable(cap);
	}

	void lime_gl_disable_vertex_attrib_array(int index)
	{
		glDisableVertexAttribArray(index);
	}

	void lime_gl_draw_arrays(int mode, int first, int count)
	{
		glDrawArrays(mode, first, count);
	}

	void lime_gl_draw_arrays_instanced(int mode, int first, int count, int instanceCount)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_1)
		{
			if (GLAD_GL_ARB_draw_instanced)
			{
				glDrawArraysInstancedARB(mode, first, count, instanceCount);
			}
			else if (GLAD_GL_EXT_draw_instanced)
			{
				glDrawArraysInstancedEXT(mode, first, count, instanceCount);
			}
		}
		else
		{
			glDrawArraysInstanced(mode, first, count, instanceCount);
		}
#else
		glDrawArraysInstanced(mode, first, count, instanceCount);
#endif
	}

	void lime_gl_draw_buffers(value buffers)
	{
		GLsizei size = val_array_size(buffers);
		GLenum *_buffers = (GLenum *)alloca(size * sizeof(GLenum));

		for (int i = 0; i < size; i++)
		{
			_buffers[i] = val_int(val_array_i(buffers, i));
		}

		glDrawBuffers(size, _buffers);
	}

	void lime_gl_draw_elements(int mode, int count, int type, double offset)
	{
		glDrawElements(mode, count, type, (void *)(uintptr_t)offset);
	}

	void lime_gl_draw_elements_instanced(int mode, int count, int type, double offset, int instanceCount)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_1)
		{
			if (GLAD_GL_ARB_draw_instanced)
			{
				glDrawElementsInstancedARB(mode, count, type, (void *)(uintptr_t)offset, instanceCount);
			}
			else if (GLAD_GL_EXT_draw_instanced)
			{
				glDrawElementsInstancedEXT(mode, count, type, (void *)(uintptr_t)offset, instanceCount);
			}
		}
		else
		{
			glDrawElementsInstanced(mode, count, type, (void *)(uintptr_t)offset, instanceCount);
		}
#else
		glDrawElementsInstanced(mode, count, type, (void *)(uintptr_t)offset, instanceCount);
#endif
	}

	void lime_gl_draw_range_elements(int mode, int start, int end, int count, int type, double offset)
	{
		glDrawRangeElements(mode, start, end, count, type, (void *)(uintptr_t)offset);
	}

	void lime_gl_enable(int cap)
	{
		glEnable(cap);
	}

	void lime_gl_enable_vertex_attrib_array(int index)
	{
		glEnableVertexAttribArray(index);
	}

	void lime_gl_end_query(int target)
	{
		glEndQuery(target);
	}

	void lime_gl_end_transform_feedback()
	{
		glEndTransformFeedback();
	}

	value lime_gl_fence_sync(int condition, int flags)
	{
		GLsync result = glFenceSync(condition, flags);
		value handle = CFFIPointer(result, gc_gl_object);
		glObjectPtrs[handle] = result;
		return handle;
	}

	void lime_gl_finish()
	{
		glFinish();
	}

	void lime_gl_flush()
	{
		glFlush();
	}

	void lime_gl_framebuffer_renderbuffer(int target, int attachment, int renderbuffertarget, int renderbuffer)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0)
		{
			if (GLAD_GL_EXT_framebuffer_object)
			{
				glFramebufferRenderbufferEXT(target, attachment, renderbuffertarget, renderbuffer);
			}
		}
		else
		{
			glFramebufferRenderbuffer(target, attachment, renderbuffertarget, renderbuffer);
		}
#else
		glFramebufferRenderbuffer(target, attachment, renderbuffertarget, renderbuffer);
#endif
	}

	void lime_gl_framebuffer_texture2D(int target, int attachment, int textarget, int texture, int level)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0)
		{
			if (GLAD_GL_EXT_framebuffer_object)
			{
				glFramebufferTexture2DEXT(target, attachment, textarget, texture, level);
			}
		}
		else
		{
			glFramebufferTexture2D(target, attachment, textarget, texture, level);
		}
#else
		glFramebufferTexture2D(target, attachment, textarget, texture, level);
#endif
	}

	void lime_gl_framebuffer_texture_layer(int target, int attachment, int texture, int level, int layer)
	{
		glFramebufferTextureLayer(target, attachment, texture, level, layer);
	}

	void lime_gl_front_face(int face)
	{
		glFrontFace(face);
	}

	void lime_gl_generate_mipmap(int target)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0)
		{
			if (GLAD_GL_EXT_framebuffer_object)
			{
				glGenerateMipmapEXT(target);
			}
		}
		else
		{
			glGenerateMipmap(target);
		}
#else
		glGenerateMipmap(target);
#endif
	}

	value lime_gl_get_active_attrib(int program, int index)
	{
		value result = alloc_empty_object();

		std::string buffer(GL_ACTIVE_ATTRIBUTE_MAX_LENGTH, 0);
		GLsizei outLen = 0;
		GLsizei size = 0;
		GLenum type = 0;

		glGetActiveAttrib(program, index, GL_ACTIVE_ATTRIBUTE_MAX_LENGTH, &outLen, &size, &type, &buffer[0]);

		buffer.resize(outLen);

		alloc_field(result, val_id("size"), alloc_int(size));
		alloc_field(result, val_id("type"), alloc_int(type));
		alloc_field(result, val_id("name"), alloc_string(buffer.c_str()));

		return result;
	}

	value lime_gl_get_active_uniform(int program, int index)
	{
		std::string buffer(GL_ACTIVE_UNIFORM_MAX_LENGTH, 0);
		GLsizei outLen = 0;
		GLsizei size = 0;
		GLenum type = 0;

		glGetActiveUniform(program, index, GL_ACTIVE_UNIFORM_MAX_LENGTH, &outLen, &size, &type, &buffer[0]);

		buffer.resize(outLen);

		value result = alloc_empty_object();
		alloc_field(result, val_id("size"), alloc_int(size));
		alloc_field(result, val_id("type"), alloc_int(type));
		alloc_field(result, val_id("name"), alloc_string(buffer.c_str()));

		return result;
	}

	int lime_gl_get_active_uniform_blocki(int program, int uniformBlockIndex, int pname)
	{
		GLint param = 0;
		glGetActiveUniformBlockiv(program, uniformBlockIndex, pname, &param);
		return param;
	}

	void lime_gl_get_active_uniform_blockiv(int program, int uniformBlockIndex, int pname, double params)
	{
		glGetActiveUniformBlockiv(program, uniformBlockIndex, pname, (GLint *)(uintptr_t)params);
	}

	value lime_gl_get_active_uniform_block_name(int program, int uniformBlockIndex)
	{
		GLint length;
		glGetActiveUniformBlockiv(program, uniformBlockIndex, GL_UNIFORM_BLOCK_NAME_LENGTH, &length);

		std::string buffer(length, 0);

		glGetActiveUniformBlockName(program, uniformBlockIndex, length, 0, &buffer[0]);

		return alloc_string(buffer.c_str());
	}

	void lime_gl_get_active_uniformsiv(int program, value uniformIndices, int pname, double params)
	{
		GLsizei size = val_array_size(uniformIndices);
		GLenum *_uniformIndices = (GLenum *)alloca(size * sizeof(GLenum));

		for (int i = 0; i < size; i++)
		{
			_uniformIndices[i] = val_int(val_array_i(uniformIndices, i));
		}

		glGetActiveUniformsiv(program, size, _uniformIndices, pname, (GLint *)(uintptr_t)params);
	}

	value lime_gl_get_attached_shaders(int program)
	{
		GLsizei maxCount = 0;
		glGetProgramiv(program, GL_ATTACHED_SHADERS, &maxCount);

		if (!maxCount)
		{
			return alloc_null();
		}

		GLsizei count;
		GLuint *shaders = new GLuint[maxCount];

		glGetAttachedShaders(program, maxCount, &count, shaders);

		value data = alloc_array(maxCount);

		for (int i = 0; i < maxCount; i++)
		{
			val_array_set_i(data, i, alloc_int(shaders[i]));
		}

		delete[] shaders;
		return data;
	}

	int lime_gl_get_attrib_location(int program, HxString name)
	{
		return glGetAttribLocation(program, name.__s);
	}

	bool lime_gl_get_boolean(int pname)
	{
		unsigned char params;
		glGetBooleanv(pname, &params);
		return params;
	}

	void lime_gl_get_booleanv(int pname, double params)
	{
		glGetBooleanv(pname, (unsigned char *)(uintptr_t)params);
	}

	int lime_gl_get_buffer_parameteri(int target, int index)
	{
		GLint params = 0;
		glGetBufferParameteriv(target, index, &params);
		return params;
	}

	void lime_gl_get_buffer_parameteri64v(int target, int index, double params)
	{
		glGetBufferParameteri64v(target, index, (GLint64 *)(uintptr_t)params);
	}

	void lime_gl_get_buffer_parameteriv(int target, int index, double params)
	{
		glGetBufferParameteriv(target, index, (GLint *)(uintptr_t)params);
	}

	double lime_gl_get_buffer_pointerv(int target, int pname)
	{
		uintptr_t result = 0;
		glGetBufferPointerv(target, pname, (void **)result);
		return (double)result;
	}

	void lime_gl_get_buffer_sub_data(int target, double offset, int size, double data)
	{
#ifdef LIME_OPENGL_GL
		glGetBufferSubData(target, (GLintptr)(uintptr_t)offset, size, (void *)(uintptr_t)data);
#endif
	}

	value lime_gl_get_context_attributes()
	{
		value result = alloc_empty_object();

		alloc_field(result, val_id("alpha"), alloc_bool(true));
		alloc_field(result, val_id("depth"), alloc_bool(true));
		alloc_field(result, val_id("stencil"), alloc_bool(true));
		alloc_field(result, val_id("antialias"), alloc_bool(true));

		return result;
	}

	int lime_gl_get_error()
	{
		return glGetError();
	}

	value lime_gl_get_extension(HxString name)
	{
		return alloc_null();
	}

	float lime_gl_get_float(int pname)
	{
		GLfloat params;
		glGetFloatv(pname, &params);
		return params;
	}

	void lime_gl_get_floatv(int pname, double params)
	{
		glGetFloatv(pname, (GLfloat *)(uintptr_t)params);
	}

	int lime_gl_get_frag_data_location(int program, HxString name)
	{
		return glGetFragDataLocation(program, name.__s);
	}

	int lime_gl_get_framebuffer_attachment_parameteri(int target, int attachment, int pname)
	{
		GLint params = 0;

#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0)
		{
			if (GLAD_GL_EXT_framebuffer_object)
			{
				glGetFramebufferAttachmentParameterivEXT(target, attachment, pname, &params);
			}
		}
		else
		{
			glGetFramebufferAttachmentParameteriv(target, attachment, pname, &params);
		}
#else
		glGetFramebufferAttachmentParameteriv(target, attachment, pname, &params);
#endif

		return params;
	}

	void lime_gl_get_framebuffer_attachment_parameteriv(int target, int attachment, int pname, double params)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0)
		{
			if (GLAD_GL_EXT_framebuffer_object)
			{
				glGetFramebufferAttachmentParameterivEXT(target, attachment, pname, (GLint *)(uintptr_t)params);
			}
		}
		else
		{
			glGetFramebufferAttachmentParameteriv(target, attachment, pname, (GLint *)(uintptr_t)params);
		}
#else
		glGetFramebufferAttachmentParameteriv(target, attachment, pname, (GLint *)(uintptr_t)params);
#endif
	}

	int lime_gl_get_integer(int pname)
	{
		GLint params;
		glGetIntegerv(pname, &params);
		return params;
	}

	void lime_gl_get_integer64v(int pname, double params)
	{
		glGetInteger64v(pname, (GLint64 *)(uintptr_t)params);
	}

	void lime_gl_get_integer64i_v(int pname, int index, double params)
	{
		glGetInteger64i_v(pname, index, (GLint64 *)(uintptr_t)params);
	}

	void lime_gl_get_integerv(int pname, double params)
	{
		glGetIntegerv(pname, (GLint *)(uintptr_t)params);
	}

	void lime_gl_get_integeri_v(int pname, int index, double params)
	{
		glGetIntegeri_v(pname, index, (GLint *)(uintptr_t)params);
	}

	void lime_gl_get_internalformativ(int target, int internalformat, int pname, int bufSize, double params)
	{
		glGetInternalformativ(target, internalformat, pname, (GLsizei)bufSize, (GLint *)(uintptr_t)params);
	}

	void lime_gl_get_program_binary(int program, int binaryFormat, value bytes)
	{
		GLint size = 0;
		glGetProgramiv(program, GL_PROGRAM_BINARY_LENGTH, &size);

		if (size > 0)
		{
			Bytes _bytes(bytes);
			_bytes.Resize(size);

			glGetProgramBinary(program, size, &size, (GLenum *)&binaryFormat, _bytes.b);
		}
	}

	value lime_gl_get_program_info_log(int handle)
	{
		GLuint program = handle;

		GLint logSize = 0;
		glGetProgramiv(program, GL_INFO_LOG_LENGTH, &logSize);

		if (logSize == 0)
		{
			return alloc_null();
		}

		std::string buffer(logSize, 0);

		glGetProgramInfoLog(program, logSize, 0, &buffer[0]);

		return alloc_string(buffer.c_str());
	}

	int lime_gl_get_programi(int program, int pname)
	{
		GLint params = 0;
		glGetProgramiv(program, pname, &params);
		return params;
	}

	void lime_gl_get_programiv(int program, int pname, double params)
	{
		glGetProgramiv(program, pname, (GLint *)(uintptr_t)params);
	}

	int lime_gl_get_queryi(int target, int pname)
	{
		GLint param = 0;
		glGetQueryiv(target, pname, &param);
		return param;
	}

	void lime_gl_get_queryiv(int target, int pname, double params)
	{
		glGetQueryiv(target, pname, (GLint *)(uintptr_t)params);
	}

	int lime_gl_get_query_objectui(int query, int pname)
	{
		GLuint param = 0;
		glGetQueryObjectuiv(query, pname, &param);
		return param;
	}

	void lime_gl_get_query_objectuiv(int query, int pname, double params)
	{
		glGetQueryObjectuiv(query, pname, (GLuint *)(uintptr_t)params);
	}

	int lime_gl_get_renderbuffer_parameteri(int target, int pname)
	{
		GLint param = 0;

#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0)
		{
			if (GLAD_GL_EXT_framebuffer_object)
			{
				glGetRenderbufferParameterivEXT(target, pname, &param);
			}
		}
		else
		{
			glGetRenderbufferParameteriv(target, pname, &param);
		}
#else
		glGetRenderbufferParameteriv(target, pname, &param);
#endif

		return param;
	}

	void lime_gl_get_renderbuffer_parameteriv(int target, int pname, double params)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0)
		{
			if (GLAD_GL_EXT_framebuffer_object)
			{
				glGetRenderbufferParameterivEXT(target, pname, (GLint *)(uintptr_t)params);
			}
		}
		else
		{
			glGetRenderbufferParameteriv(target, pname, (GLint *)(uintptr_t)params);
		}
#else
		glGetRenderbufferParameteriv(target, pname, (GLint *)(uintptr_t)params);
#endif
	}

	float lime_gl_get_sampler_parameterf(int sampler, int pname)
	{
		GLfloat param = 0;
		glGetSamplerParameterfv(sampler, pname, &param);
		return param;
	}

	void lime_gl_get_sampler_parameterfv(int sampler, int pname, double params)
	{
		glGetSamplerParameterfv(sampler, pname, (GLfloat *)(uintptr_t)params);
	}

	int lime_gl_get_sampler_parameteri(int sampler, int pname)
	{
		GLint param = 0;
		glGetSamplerParameteriv(sampler, pname, &param);
		return param;
	}

	void lime_gl_get_sampler_parameteriv(int sampler, int pname, double params)
	{
		glGetSamplerParameteriv(sampler, pname, (GLint *)(uintptr_t)params);
	}

	value lime_gl_get_shader_info_log(int handle)
	{
		GLuint shader = handle;

		GLint logSize = 0;
		glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &logSize);

		if (logSize == 0)
		{
			return alloc_null();
		}

		std::string buffer(logSize, 0);
		GLint writeSize;
		glGetShaderInfoLog(shader, logSize, &writeSize, &buffer[0]);

		return alloc_string(buffer.c_str());
	}

	int lime_gl_get_shaderi(int shader, int pname)
	{
		GLint params = 0;
		glGetShaderiv(shader, pname, &params);
		return params;
	}

	void lime_gl_get_shaderiv(int shader, int pname, double params)
	{
		glGetShaderiv(shader, pname, (GLint *)(uintptr_t)params);
	}

	value lime_gl_get_shader_precision_format(int shadertype, int precisiontype)
	{
		GLint range[2];
		GLint precision;

		glGetShaderPrecisionFormat(shadertype, precisiontype, range, &precision);

		value result = alloc_empty_object();
		alloc_field(result, val_id("rangeMin"), alloc_int(range[0]));
		alloc_field(result, val_id("rangeMax"), alloc_int(range[1]));
		alloc_field(result, val_id("precision"), alloc_int(precision));
		return result;
	}

	value lime_gl_get_shader_source(int shader)
	{
		GLint len = 0;
		glGetShaderiv(shader, GL_SHADER_SOURCE_LENGTH, &len);

		if (len == 0)
		{
			return alloc_null();
		}

		char *buf = new char[len + 1];
		glGetShaderSource(shader, len + 1, 0, buf);
		value result = alloc_string(buf);

		delete[] buf;

		return result;
	}

	value lime_gl_get_string(int pname)
	{
		const char *val = (const char *)glGetString(pname);

		if (val)
		{
			return alloc_string(val);
		}
		else
		{
			return alloc_null();
		}
	}

	value lime_gl_get_stringi(int pname, int index)
	{
		const char *val = (const char *)glGetStringi(pname, index);

		if (val)
		{
			return alloc_string(val);
		}
		else
		{
			return alloc_null();
		}
	}

	int lime_gl_get_sync_parameteri(value sync, int pname)
	{
		// TODO

		GLint param = 0;
		// glGetSynciv ((GLsync)(uintptr_t)sync, pname, &param);
		return param;
	}

	void lime_gl_get_sync_parameteriv(value sync, int pname, double params)
	{
		// TODO

		// glGetSynciv ((GLsync)(uintptr_t)sync, pname, (GLint*)(uintptr_t)param);
	}

	float lime_gl_get_tex_parameterf(int target, int pname)
	{
		GLfloat params = 0;
		glGetTexParameterfv(target, pname, &params);
		return params;
	}

	void lime_gl_get_tex_parameterfv(int target, int pname, double params)
	{
		glGetTexParameterfv(target, pname, (GLfloat *)(uintptr_t)params);
	}

	int lime_gl_get_tex_parameteri(int target, int pname)
	{
		GLint params = 0;
		glGetTexParameteriv(target, pname, &params);
		return params;
	}

	void lime_gl_get_tex_parameteriv(int target, int pname, double params)
	{
		glGetTexParameteriv(target, pname, (GLint *)(uintptr_t)params);
	}

	value lime_gl_get_transform_feedback_varying(int program, int index)
	{
		value result = alloc_empty_object();

		GLint maxLength = 0;
		glGetProgramiv(program, GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH, &maxLength);

		GLsizei outLen = 0;
		GLsizei size = 0;
		GLenum type = 0;

		std::string buffer(maxLength, 0);

		glGetTransformFeedbackVarying(program, index, maxLength, &outLen, &size, &type, &buffer[0]);

		buffer.resize(outLen);

		alloc_field(result, val_id("size"), alloc_int(size));
		alloc_field(result, val_id("type"), alloc_int(type));
		alloc_field(result, val_id("name"), alloc_string(buffer.c_str()));

		return result;
	}

	float lime_gl_get_uniformf(int program, int location)
	{
		GLfloat params = 0;
		glGetUniformfv(program, location, &params);
		return params;
	}

	void lime_gl_get_uniformfv(int program, int location, double params)
	{
		glGetUniformfv(program, location, (GLfloat *)(uintptr_t)params);
	}

	int lime_gl_get_uniformi(int program, int location)
	{
		GLint params = 0;
		glGetUniformiv(program, location, &params);
		return params;
	}

	void lime_gl_get_uniformiv(int program, int location, double params)
	{
		glGetUniformiv(program, location, (GLint *)(uintptr_t)params);
	}

	int lime_gl_get_uniformui(int program, int location)
	{
		GLuint params = 0;
		glGetUniformuiv(program, location, &params);
		return params;
	}

	void lime_gl_get_uniformuiv(int program, int location, double params)
	{
		glGetUniformuiv(program, location, (GLuint *)(uintptr_t)params);
	}

	int lime_gl_get_uniform_block_index(int program, HxString uniformBlockName)
	{
		return glGetUniformBlockIndex(program, uniformBlockName.__s);
	}

	int lime_gl_get_uniform_location(int program, HxString name)
	{
		return glGetUniformLocation(program, name.__s);
	}

	float lime_gl_get_vertex_attribf(int index, int pname)
	{
		GLfloat params = 0;
		glGetVertexAttribfv(index, pname, &params);
		return params;
	}

	void lime_gl_get_vertex_attribfv(int index, int pname, double params)
	{
		glGetVertexAttribfv(index, pname, (GLfloat *)(uintptr_t)params);
	}

	int lime_gl_get_vertex_attribi(int index, int pname)
	{
		GLint params = 0;
		glGetVertexAttribiv(index, pname, &params);
		return params;
	}

	void lime_gl_get_vertex_attribiv(int index, int pname, double params)
	{
		glGetVertexAttribiv(index, pname, (GLint *)(uintptr_t)params);
	}

	int lime_gl_get_vertex_attribii(int index, int pname)
	{
		GLint params = 0;
		glGetVertexAttribIiv(index, pname, &params);
		return params;
	}

	void lime_gl_get_vertex_attribiiv(int index, int pname, double params)
	{
		glGetVertexAttribIiv(index, pname, (GLint *)(uintptr_t)params);
	}

	int lime_gl_get_vertex_attribiui(int index, int pname)
	{
		GLuint params = 0;
		glGetVertexAttribIuiv(index, pname, &params);
		return params;
	}

	void lime_gl_get_vertex_attribiuiv(int index, int pname, double params)
	{
		glGetVertexAttribIuiv(index, pname, (GLuint *)(uintptr_t)params);
	}

	double lime_gl_get_vertex_attrib_pointerv(int index, int pname)
	{
		uintptr_t result = 0;
		glGetVertexAttribPointerv(index, pname, (void **)result);
		return (double)result;
	}

	void lime_gl_hint(int target, int mode)
	{
		glHint(target, mode);
	}

	void lime_gl_invalidate_framebuffer(int target, value attachments)
	{
		GLint size = val_array_size(attachments);
		GLenum *_attachments = (GLenum *)alloca(size * sizeof(GLenum));

		for (int i = 0; i < size; i++)
		{
			_attachments[i] = val_int(val_array_i(attachments, i));
		}

		glInvalidateFramebuffer(target, size, _attachments);
	}

	void lime_gl_invalidate_sub_framebuffer(int target, value attachments, int x, int y, int width, int height)
	{
		GLint size = val_array_size(attachments);
		GLenum *_attachments = (GLenum *)alloca(size * sizeof(GLenum));

		for (int i = 0; i < size; i++)
		{
			_attachments[i] = val_int(val_array_i(attachments, i));
		}

		glInvalidateSubFramebuffer(target, size, _attachments, x, y, width, height);
	}

	bool lime_gl_is_buffer(int handle)
	{
		return glIsBuffer(handle);
	}

	bool lime_gl_is_enabled(int cap)
	{
		return glIsEnabled(cap);
	}

	bool lime_gl_is_framebuffer(int handle)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		return (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0) ? (GLAD_GL_EXT_framebuffer_object ? glIsFramebufferEXT(handle) : false) : glIsFramebuffer(handle);
#else
		return glIsFramebuffer(handle);
#endif
	}

	bool lime_gl_is_program(int handle)
	{
		return glIsProgram(handle);
	}

	bool lime_gl_is_query(int handle)
	{
		return glIsQuery(handle);
	}

	bool lime_gl_is_renderbuffer(int handle)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		return (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0) ? (GLAD_GL_EXT_framebuffer_object ? glIsRenderbufferEXT(handle) : false) : glIsRenderbuffer(handle);
#else
		return glIsRenderbuffer(handle);
#endif
	}

	bool lime_gl_is_sampler(int handle)
	{
		return glIsSampler(handle);
	}

	bool lime_gl_is_shader(int handle)
	{
		return glIsShader(handle);
	}

	bool lime_gl_is_sync(value handle)
	{
		if (val_is_null(handle))
			return false;
		return glIsSync((GLsync)val_data(handle));
	}

	bool lime_gl_is_texture(int handle)
	{
		return glIsTexture(handle);
	}

	bool lime_gl_is_transform_feedback(int handle)
	{
		return glIsTransformFeedback(handle);
	}

	bool lime_gl_is_vertex_array(int handle)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0)
		{
			return GLAD_GL_APPLE_vertex_array_object ? glIsVertexArrayAPPLE(handle) : (GLAD_GL_ARB_vertex_array_object ? glIsVertexArray(handle) : false);
		}
		else
		{
			return glIsVertexArray(handle);
		}
#else
		return glIsVertexArray(handle);
#endif
	}

	void lime_gl_line_width(float width)
	{
		glLineWidth(width);
	}

	void lime_gl_link_program(int program)
	{
		glLinkProgram(program);
	}

	double lime_gl_map_buffer_range(int target, double offset, int length, int access)
	{
		uintptr_t result = (uintptr_t)glMapBufferRange(target, (GLintptr)(uintptr_t)offset, length, access);
		return (double)result;
	}

	void lime_gl_object_deregister(value object)
	{
		if (glObjectIDs.find(object) != glObjectIDs.end())
		{
			GLuint id = glObjectIDs[object];
			GLObjectType type = glObjectTypes[object];

			glObjects[type].erase(id);
			glObjectTypes.erase(object);
			glObjectIDs.erase(object);
		}

		if (glObjectPtrs.find(object) != glObjectPtrs.end())
		{
			value handle = (value)glObjectPtrs[object];
			val_gc(handle, 0);
			glObjectPtrs.erase(object);
		}
	}

	value lime_gl_object_from_id(int id, int type)
	{
		GLObjectType _type = (GLObjectType)type;

		if (glObjects[_type].find(id) != glObjects[_type].end())
		{
			return (value)glObjects[_type][id];
		}
		else
		{
			return alloc_null();
		}
	}

	value lime_gl_object_register(int id, int type, value object)
	{
		GLObjectType _type = (GLObjectType)type;
		value handle = CFFIPointer(object, gc_gl_object);

		// if (glObjects[_type].find (id) != glObjects[_type].end ()) {
		//
		// value otherObject = glObjects[_type][id];
		// if (otherObject == object) return;
		//
		// glObjectTypes.erase (otherObject);
		// glObjectIDs.erase (object);
		//
		// val_gc (otherObject, 0);
		//
		//}

		glObjectTypes[object] = (GLObjectType)type;
		glObjectIDs[object] = id;
		glObjects[_type][id] = object;
		glObjectPtrs[object] = handle;

		return handle;
	}

	void lime_gl_pause_transform_feedback()
	{
		glPauseTransformFeedback();
	}

	void lime_gl_pixel_storei(int pname, int param)
	{
		glPixelStorei(pname, param);
	}

	void lime_gl_polygon_offset(float factor, float units)
	{
		glPolygonOffset(factor, units);
	}

	void lime_gl_program_binary(int program, int binaryFormat, double binary, int length)
	{
		glProgramBinary(program, binaryFormat, (void *)(uintptr_t)binary, length);
	}

	void lime_gl_program_parameteri(int program, int pname, int value)
	{
		glProgramParameteri(program, pname, value);
	}

	void lime_gl_read_buffer(int src)
	{
		glReadBuffer(src);
	}

	void lime_gl_read_pixels(int x, int y, int width, int height, int format, int type, double pixels)
	{
		glReadPixels(x, y, width, height, format, type, (void *)(uintptr_t)pixels);
	}

	void lime_gl_release_shader_compiler()
	{
		glReleaseShaderCompiler();
	}

	void lime_gl_renderbuffer_storage(int target, int internalformat, int width, int height)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0)
		{
			if (GLAD_GL_EXT_framebuffer_object)
			{
				glRenderbufferStorageEXT(target, internalformat, width, height);
			}
		}
		else
		{
			glRenderbufferStorage(target, internalformat, width, height);
		}
#else
		glRenderbufferStorage(target, internalformat, width, height);
#endif
	}

	void lime_gl_renderbuffer_storage_multisample(int target, int samples, int internalformat, int width, int height)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_0)
		{
			if (GLAD_GL_EXT_framebuffer_multisample)
			{
				glRenderbufferStorageMultisampleEXT(target, samples, internalformat, width, height);
			}
		}
		else
		{
			glRenderbufferStorageMultisample(target, samples, internalformat, width, height);
		}
#else
		glRenderbufferStorageMultisample(target, samples, internalformat, width, height);
#endif
	}

	void lime_gl_resume_transform_feedback()
	{
		glResumeTransformFeedback();
	}

	void lime_gl_sample_coverage(float val, bool invert)
	{
		glSampleCoverage(val, invert);
	}

	void lime_gl_sampler_parameterf(int sampler, int pname, float param)
	{
		glSamplerParameterf(sampler, pname, param);
	}

	void lime_gl_sampler_parameteri(int sampler, int pname, int param)
	{
		glSamplerParameteri(sampler, pname, param);
	}

	void lime_gl_scissor(int x, int y, int width, int height)
	{
		glScissor(x, y, width, height);
	}

	void lime_gl_shader_binary(value shaders, int binaryformat, double binary, int length)
	{
		GLsizei size = val_array_size(shaders);
		GLenum *_shaders = (GLenum *)alloca(size * sizeof(GLenum));

		for (int i = 0; i < size; i++)
		{
			_shaders[i] = val_int(val_array_i(shaders, i));
		}

		glShaderBinary(size, _shaders, binaryformat, (void *)(uintptr_t)binary, length);
	}

	void lime_gl_shader_source(int handle, HxString source)
	{
		glShaderSource(handle, 1, &source.__s, 0);
	}

	void lime_gl_stencil_func(int func, int ref, int mask)
	{
		glStencilFunc(func, ref, mask);
	}

	void lime_gl_stencil_func_separate(int face, int func, int ref, int mask)
	{
		glStencilFuncSeparate(face, func, ref, mask);
	}

	void lime_gl_stencil_mask(int mask)
	{
		glStencilMask(mask);
	}

	void lime_gl_stencil_mask_separate(int face, int mask)
	{
		glStencilMaskSeparate(face, mask);
	}

	void lime_gl_stencil_op(int sfail, int dpfail, int dppass)
	{
		glStencilOp(sfail, dpfail, dppass);
	}

	void lime_gl_stencil_op_separate(int face, int sfail, int dpfail, int dppass)
	{
		glStencilOpSeparate(face, sfail, dpfail, dppass);
	}

	void lime_gl_tex_image_2d(int target, int level, int internalformat, int width, int height, int border, int format, int type, double data)
	{
		glTexImage2D(target, level, internalformat, width, height, border, format, type, (void *)(uintptr_t)data);
	}

	void lime_gl_tex_image_3d(int target, int level, int internalformat, int width, int height, int depth, int border, int format, int type, double data)
	{
		glTexImage3D(target, level, internalformat, width, height, depth, border, format, type, (void *)(uintptr_t)data);
	}

	void lime_gl_tex_parameterf(int target, int pname, float param)
	{
		glTexParameterf(target, pname, param);
	}

	void lime_gl_tex_parameteri(int target, int pname, int param)
	{
		glTexParameterf(target, pname, param);
	}

	void lime_gl_tex_storage_2d(int target, int level, int internalformat, int width, int height)
	{
		glTexStorage2D(target, level, internalformat, width, height);
	}

	void lime_gl_tex_storage_3d(int target, int level, int internalformat, int width, int height, int depth)
	{
		glTexStorage3D(target, level, internalformat, width, height, depth);
	}

	void lime_gl_tex_sub_image_2d(int target, int level, int xoffset, int yoffset, int width, int height, int format, int type, double data)
	{
		glTexSubImage2D(target, level, xoffset, yoffset, width, height, format, type, (void *)(uintptr_t)data);
	}

	void lime_gl_tex_sub_image_3d(int target, int level, int xoffset, int yoffset, int zoffset, int width, int height, int depth, int format, int type, double data)
	{
		glTexSubImage3D(target, level, xoffset, yoffset, zoffset, width, height, depth, format, type, (void *)(uintptr_t)data);
	}

	void lime_gl_transform_feedback_varyings(int program, value varyings, int bufferMode)
	{
		GLsizei size = val_array_size(varyings);
		const char **_varyings = (const char **)alloca(size * sizeof(GLenum));

		for (int i = 0; i < size; i++)
		{
			_varyings[i] = val_string(val_array_i(varyings, i));
		}

		glTransformFeedbackVaryings(program, size, _varyings, bufferMode);
	}

	void lime_gl_uniform1f(int location, float v0)
	{
		glUniform1f(location, v0);
	}

	void lime_gl_uniform1fv(int location, int count, double _value)
	{
		glUniform1fv(location, count, (GLfloat *)(uintptr_t)_value);
	}

	void lime_gl_uniform1i(int location, int v0)
	{
		glUniform1i(location, v0);
	}

	void lime_gl_uniform1iv(int location, int count, double _value)
	{
		glUniform1iv(location, count, (GLint *)(uintptr_t)_value);
	}

	void lime_gl_uniform1ui(int location, int v0)
	{
		glUniform1ui(location, v0);
	}

	void lime_gl_uniform1uiv(int location, int count, double _value)
	{
		glUniform1uiv(location, count, (GLuint *)(uintptr_t)_value);
	}

	void lime_gl_uniform2f(int location, float v0, float v1)
	{
		glUniform2f(location, v0, v1);
	}

	void lime_gl_uniform2fv(int location, int count, double _value)
	{
		glUniform2fv(location, count, (GLfloat *)(uintptr_t)_value);
	}

	void lime_gl_uniform2i(int location, int v0, int v1)
	{
		glUniform2i(location, v0, v1);
	}

	void lime_gl_uniform2iv(int location, int count, double _value)
	{
		glUniform2iv(location, count, (GLint *)(uintptr_t)_value);
	}

	void lime_gl_uniform2ui(int location, int v0, int v1)
	{
		glUniform2ui(location, v0, v1);
	}

	void lime_gl_uniform2uiv(int location, int count, double _value)
	{
		glUniform2uiv(location, count, (GLuint *)(uintptr_t)_value);
	}

	void lime_gl_uniform3f(int location, float v0, float v1, float v2)
	{
		glUniform3f(location, v0, v1, v2);
	}

	void lime_gl_uniform3fv(int location, int count, double _value)
	{
		glUniform3fv(location, count, (GLfloat *)(uintptr_t)_value);
	}

	void lime_gl_uniform3i(int location, int v0, int v1, int v2)
	{
		glUniform3i(location, v0, v1, v2);
	}

	void lime_gl_uniform3iv(int location, int count, double _value)
	{
		glUniform3iv(location, count, (GLint *)(uintptr_t)_value);
	}

	void lime_gl_uniform3ui(int location, int v0, int v1, int v2)
	{
		glUniform3ui(location, v0, v1, v2);
	}

	void lime_gl_uniform3uiv(int location, int count, double _value)
	{
		glUniform3uiv(location, count, (GLuint *)(uintptr_t)_value);
	}

	void lime_gl_uniform4f(int location, float v0, float v1, float v2, float v3)
	{
		glUniform4f(location, v0, v1, v2, v3);
	}

	void lime_gl_uniform4fv(int location, int count, double _value)
	{
		glUniform4fv(location, count, (GLfloat *)(uintptr_t)_value);
	}

	void lime_gl_uniform4i(int location, int v0, int v1, int v2, int v3)
	{
		glUniform4i(location, v0, v1, v2, v3);
	}

	void lime_gl_uniform4iv(int location, int count, double _value)
	{
		glUniform4iv(location, count, (GLint *)(uintptr_t)_value);
	}

	void lime_gl_uniform4ui(int location, int v0, int v1, int v2, int v3)
	{
		glUniform4ui(location, v0, v1, v2, v3);
	}

	void lime_gl_uniform4uiv(int location, int count, double _value)
	{
		glUniform4uiv(location, count, (GLuint *)(uintptr_t)_value);
	}

	void lime_gl_uniform_block_binding(int program, int uniformBlockIndex, int uniformBlockBinding)
	{
		glUniformBlockBinding(program, uniformBlockIndex, uniformBlockBinding);
	}

	void lime_gl_uniform_matrix2fv(int location, int count, bool transpose, double _value)
	{
		glUniformMatrix2fv(location, count, transpose, (GLfloat *)(uintptr_t)_value);
	}

	void lime_gl_uniform_matrix2x3fv(int location, int count, bool transpose, double _value)
	{
		glUniformMatrix2x3fv(location, count, transpose, (GLfloat *)(uintptr_t)_value);
	}

	void lime_gl_uniform_matrix2x4fv(int location, int count, bool transpose, double _value)
	{
		glUniformMatrix2x4fv(location, count, transpose, (GLfloat *)(uintptr_t)_value);
	}

	void lime_gl_uniform_matrix3fv(int location, int count, bool transpose, double _value)
	{
		glUniformMatrix3fv(location, count, transpose, (GLfloat *)(uintptr_t)_value);
	}

	void lime_gl_uniform_matrix3x2fv(int location, int count, bool transpose, double _value)
	{
		glUniformMatrix3x2fv(location, count, transpose, (GLfloat *)(uintptr_t)_value);
	}

	void lime_gl_uniform_matrix3x4fv(int location, int count, bool transpose, double _value)
	{
		glUniformMatrix3x4fv(location, count, transpose, (GLfloat *)(uintptr_t)_value);
	}

	void lime_gl_uniform_matrix4fv(int location, int count, bool transpose, double _value)
	{
		glUniformMatrix4fv(location, count, transpose, (GLfloat *)(uintptr_t)_value);
	}

	void lime_gl_uniform_matrix4x2fv(int location, int count, bool transpose, double _value)
	{
		glUniformMatrix4x2fv(location, count, transpose, (GLfloat *)(uintptr_t)_value);
	}

	void lime_gl_uniform_matrix4x3fv(int location, int count, bool transpose, double _value)
	{
		glUniformMatrix4x3fv(location, count, transpose, (GLfloat *)(uintptr_t)_value);
	}

	bool lime_gl_unmap_buffer(int target)
	{
		return glUnmapBuffer(target);
	}

	void lime_gl_use_program(int handle)
	{
		glUseProgram(handle);
	}

	void lime_gl_validate_program(int handle)
	{
		glValidateProgram(handle);
	}

	void lime_gl_vertex_attrib_divisor(int index, int divisor)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (GLAD_GL_VERSION_2_1 && !GLAD_GL_VERSION_3_3)
		{
			if (GLAD_GL_ARB_instanced_arrays)
			{
				glVertexAttribDivisorARB(index, divisor);
			}
		}
		else
		{
			glVertexAttribDivisor(index, divisor);
		}
#else
		glVertexAttribDivisor(index, divisor);
#endif
	}

	void lime_gl_vertex_attrib_ipointer(int index, int size, int type, int stride, double offset)
	{
		glVertexAttribIPointer(index, size, type, stride, (void *)(uintptr_t)offset);
	}

	void lime_gl_vertex_attrib_pointer(int index, int size, int type, bool normalized, int stride, double offset)
	{
		glVertexAttribPointer(index, size, type, normalized, stride, (void *)(uintptr_t)offset);
	}

	void lime_gl_vertex_attribi4i(int index, int v0, int v1, int v2, int v3)
	{
		glVertexAttribI4i(index, v0, v1, v2, v3);
	}

	void lime_gl_vertex_attribi4iv(int index, double v)
	{
		glVertexAttribI4iv(index, (GLint *)(uintptr_t)v);
	}

	void lime_gl_vertex_attribi4ui(int index, int v0, int v1, int v2, int v3)
	{
		glVertexAttribI4ui(index, v0, v1, v2, v3);
	}

	void lime_gl_vertex_attribi4uiv(int index, double v)
	{
		glVertexAttribI4uiv(index, (GLuint *)(uintptr_t)v);
	}

	void lime_gl_vertex_attrib1f(int index, float v0)
	{
		glVertexAttrib1f(index, v0);
	}

	void lime_gl_vertex_attrib1fv(int index, double v)
	{
		glVertexAttrib1fv(index, (GLfloat *)(uintptr_t)v);
	}

	void lime_gl_vertex_attrib2f(int index, float v0, float v1)
	{
		glVertexAttrib2f(index, v0, v1);
	}

	void lime_gl_vertex_attrib2fv(int index, double v)
	{
		glVertexAttrib2fv(index, (GLfloat *)(uintptr_t)v);
	}

	void lime_gl_vertex_attrib3f(int index, float v0, float v1, float v2)
	{
		glVertexAttrib3f(index, v0, v1, v2);
	}

	void lime_gl_vertex_attrib3fv(int index, double v)
	{
		glVertexAttrib3fv(index, (GLfloat *)(uintptr_t)v);
	}

	void lime_gl_vertex_attrib4f(int index, float v0, float v1, float v2, float v3)
	{
		glVertexAttrib4f(index, v0, v1, v2, v3);
	}

	void lime_gl_vertex_attrib4fv(int index, double v)
	{
		glVertexAttrib4fv(index, (GLfloat *)(uintptr_t)v);
	}

	void lime_gl_viewport(int x, int y, int width, int height)
	{
		glViewport(x, y, width, height);
	}

	void lime_gl_wait_sync(value sync, int flags, int timeoutA, int timeoutB)
	{
		GLuint64 timeout = (GLuint64)timeoutA << 32 | timeoutB;
		glWaitSync((GLsync)val_data(sync), flags, timeout);
	}

	// Modern OpenGL / OpenGL ES entry points. glad leaves the function pointer null when
	// the driver does not expose the entry point, so each call is guarded; callers should
	// still gate on the context version or an extension before relying on one.

	void lime_gl_flush_mapped_buffer_range(int target, double offset, int length)
	{
		if (glFlushMappedBufferRange)
		{
			glFlushMappedBufferRange(target, (GLintptr)(uintptr_t)offset, length);
		}
	}

	void lime_gl_dispatch_compute(int x, int y, int z)
	{
#if defined(LIME_GLAD)
		if (glDispatchCompute)
		{
			glDispatchCompute(x, y, z);
		}
#endif
	}

	void lime_gl_dispatch_compute_indirect(double indirect)
	{
#if defined(LIME_GLAD)
		if (glDispatchComputeIndirect)
		{
			glDispatchComputeIndirect((GLintptr)(uintptr_t)indirect);
		}
#endif
	}

	void lime_gl_memory_barrier(int barriers)
	{
#if defined(LIME_GLAD)
		if (glMemoryBarrier)
		{
			glMemoryBarrier(barriers);
		}
#endif
	}

	void lime_gl_memory_barrier_by_region(int barriers)
	{
#if defined(LIME_GLAD)
		if (glMemoryBarrierByRegion)
		{
			glMemoryBarrierByRegion(barriers);
		}
#endif
	}

	void lime_gl_bind_image_texture(int unit, int texture, int level, bool layered, int layer, int access, int format)
	{
#if defined(LIME_GLAD)
		if (glBindImageTexture)
		{
			glBindImageTexture(unit, texture, level, layered, layer, access, format);
		}
#endif
	}

	void lime_gl_draw_arrays_indirect(int mode, double indirect)
	{
#if defined(LIME_GLAD)
		if (glDrawArraysIndirect)
		{
			glDrawArraysIndirect(mode, (const void *)(uintptr_t)indirect);
		}
#endif
	}

	void lime_gl_draw_elements_indirect(int mode, int type, double indirect)
	{
#if defined(LIME_GLAD)
		if (glDrawElementsIndirect)
		{
			glDrawElementsIndirect(mode, type, (const void *)(uintptr_t)indirect);
		}
#endif
	}

	int lime_gl_get_program_interfacei(int program, int programInterface, int pname)
	{
#if defined(LIME_GLAD)
		if (glGetProgramInterfaceiv)
		{
			GLint value = 0;
			glGetProgramInterfaceiv(program, programInterface, pname, &value);
			return value;
		}
#endif
		return 0;
	}

	void lime_gl_get_program_interfaceiv(int program, int programInterface, int pname, double params)
	{
#if defined(LIME_GLAD)
		if (glGetProgramInterfaceiv)
		{
			glGetProgramInterfaceiv(program, programInterface, pname, (GLint *)(uintptr_t)params);
		}
#endif
	}

	int lime_gl_get_program_resource_index(int program, int programInterface, HxString name)
	{
#if defined(LIME_GLAD)
		if (glGetProgramResourceIndex)
		{
			return glGetProgramResourceIndex(program, programInterface, name.__s);
		}
#endif
		return 0;
	}

	int lime_gl_get_program_resource_location(int program, int programInterface, HxString name)
	{
#if defined(LIME_GLAD)
		if (glGetProgramResourceLocation)
		{
			return glGetProgramResourceLocation(program, programInterface, name.__s);
		}
#endif
		return 0;
	}

	value lime_gl_get_program_resource_name(int program, int programInterface, int index)
	{
#if defined(LIME_GLAD)
		if (glGetProgramResourceName)
		{
			GLint length = 0;
			glGetProgramInterfaceiv(program, programInterface, GL_MAX_NAME_LENGTH, &length);
			if (length <= 0) return alloc_null();
			std::string buffer(length, 0);
			glGetProgramResourceName(program, programInterface, index, length, 0, &buffer[0]);
			return alloc_string(buffer.c_str());
		}
#endif
		return alloc_null();
	}

	void lime_gl_get_program_resourceiv(int program, int programInterface, int index, int propCount, double props, int bufSize, double params)
	{
#if defined(LIME_GLAD)
		if (glGetProgramResourceiv)
		{
			glGetProgramResourceiv(program, programInterface, index, propCount, (const GLenum *)(uintptr_t)props, bufSize, 0, (GLint *)(uintptr_t)params);
		}
#endif
	}

	int lime_gl_create_program_pipeline()
	{
#if defined(LIME_GLAD)
		if (glGenProgramPipelines)
		{
			GLuint id = 0;
			glGenProgramPipelines(1, &id);
			return id;
		}
#endif
		return 0;
	}

	void lime_gl_delete_program_pipeline(int pipeline)
	{
#if defined(LIME_GLAD)
		if (glDeleteProgramPipelines)
		{
			GLuint id = pipeline;
			glDeleteProgramPipelines(1, &id);
		}
#endif
	}

	void lime_gl_bind_program_pipeline(int pipeline)
	{
#if defined(LIME_GLAD)
		if (glBindProgramPipeline)
		{
			glBindProgramPipeline(pipeline);
		}
#endif
	}

	bool lime_gl_is_program_pipeline(int pipeline)
	{
#if defined(LIME_GLAD)
		if (glIsProgramPipeline)
		{
			return glIsProgramPipeline(pipeline);
		}
#endif
		return false;
	}

	void lime_gl_use_program_stages(int pipeline, int stages, int program)
	{
#if defined(LIME_GLAD)
		if (glUseProgramStages)
		{
			glUseProgramStages(pipeline, stages, program);
		}
#endif
	}

	void lime_gl_active_shader_program(int pipeline, int program)
	{
#if defined(LIME_GLAD)
		if (glActiveShaderProgram)
		{
			glActiveShaderProgram(pipeline, program);
		}
#endif
	}

	int lime_gl_create_shader_programv(int type, HxString source)
	{
#if defined(LIME_GLAD)
		if (glCreateShaderProgramv)
		{
			const char *strings[1] = {source.__s};
			return glCreateShaderProgramv(type, 1, strings);
		}
#endif
		return 0;
	}

	void lime_gl_validate_program_pipeline(int pipeline)
	{
#if defined(LIME_GLAD)
		if (glValidateProgramPipeline)
		{
			glValidateProgramPipeline(pipeline);
		}
#endif
	}

	int lime_gl_get_program_pipelinei(int pipeline, int pname)
	{
#if defined(LIME_GLAD)
		if (glGetProgramPipelineiv)
		{
			GLint value = 0;
			glGetProgramPipelineiv(pipeline, pname, &value);
			return value;
		}
#endif
		return 0;
	}

	value lime_gl_get_program_pipeline_info_log(int pipeline)
	{
#if defined(LIME_GLAD)
		if (glGetProgramPipelineInfoLog)
		{
			GLint length = 0;
			glGetProgramPipelineiv(pipeline, GL_INFO_LOG_LENGTH, &length);
			if (length <= 0) return alloc_string("");
			std::string buffer(length, 0);
			glGetProgramPipelineInfoLog(pipeline, length, 0, &buffer[0]);
			return alloc_string(buffer.c_str());
		}
#endif
		return alloc_null();
	}

	void lime_gl_program_uniform1i(int program, int location, int v0)
	{
#if defined(LIME_GLAD)
		if (glProgramUniform1i)
		{
			glProgramUniform1i(program, location, v0);
		}
#endif
	}

	void lime_gl_program_uniform1f(int program, int location, float v0)
	{
#if defined(LIME_GLAD)
		if (glProgramUniform1f)
		{
			glProgramUniform1f(program, location, v0);
		}
#endif
	}

	void lime_gl_program_uniform2f(int program, int location, float v0, float v1)
	{
#if defined(LIME_GLAD)
		if (glProgramUniform2f)
		{
			glProgramUniform2f(program, location, v0, v1);
		}
#endif
	}

	void lime_gl_program_uniform3f(int program, int location, float v0, float v1, float v2)
	{
#if defined(LIME_GLAD)
		if (glProgramUniform3f)
		{
			glProgramUniform3f(program, location, v0, v1, v2);
		}
#endif
	}

	void lime_gl_program_uniform4f(int program, int location, float v0, float v1, float v2, float v3)
	{
#if defined(LIME_GLAD)
		if (glProgramUniform4f)
		{
			glProgramUniform4f(program, location, v0, v1, v2, v3);
		}
#endif
	}

	void lime_gl_program_uniform_matrix4fv(int program, int location, int count, bool transpose, double value)
	{
#if defined(LIME_GLAD)
		if (glProgramUniformMatrix4fv)
		{
			glProgramUniformMatrix4fv(program, location, count, transpose, (const GLfloat *)(uintptr_t)value);
		}
#endif
	}

	void lime_gl_bind_vertex_buffer(int bindingIndex, int buffer, double offset, int stride)
	{
#if defined(LIME_GLAD)
		if (glBindVertexBuffer)
		{
			glBindVertexBuffer(bindingIndex, buffer, (GLintptr)(uintptr_t)offset, stride);
		}
#endif
	}

	void lime_gl_vertex_attrib_format(int attribIndex, int size, int type, bool normalized, int relativeOffset)
	{
#if defined(LIME_GLAD)
		if (glVertexAttribFormat)
		{
			glVertexAttribFormat(attribIndex, size, type, normalized, relativeOffset);
		}
#endif
	}

	void lime_gl_vertex_attrib_iformat(int attribIndex, int size, int type, int relativeOffset)
	{
#if defined(LIME_GLAD)
		if (glVertexAttribIFormat)
		{
			glVertexAttribIFormat(attribIndex, size, type, relativeOffset);
		}
#endif
	}

	void lime_gl_vertex_attrib_binding(int attribIndex, int bindingIndex)
	{
#if defined(LIME_GLAD)
		if (glVertexAttribBinding)
		{
			glVertexAttribBinding(attribIndex, bindingIndex);
		}
#endif
	}

	void lime_gl_vertex_binding_divisor(int bindingIndex, int divisor)
	{
#if defined(LIME_GLAD)
		if (glVertexBindingDivisor)
		{
			glVertexBindingDivisor(bindingIndex, divisor);
		}
#endif
	}

	void lime_gl_tex_storage_2d_multisample(int target, int samples, int internalformat, int width, int height, bool fixedSampleLocations)
	{
#if defined(LIME_GLAD)
		if (glTexStorage2DMultisample)
		{
			glTexStorage2DMultisample(target, samples, internalformat, width, height, fixedSampleLocations);
		}
#endif
	}

	void lime_gl_get_multisamplefv(int pname, int index, double val)
	{
#if defined(LIME_GLAD)
		if (glGetMultisamplefv)
		{
			glGetMultisamplefv(pname, index, (GLfloat *)(uintptr_t)val);
		}
#endif
	}

	void lime_gl_sample_maski(int maskNumber, int mask)
	{
#if defined(LIME_GLAD)
		if (glSampleMaski)
		{
			glSampleMaski(maskNumber, mask);
		}
#endif
	}

	int lime_gl_get_tex_level_parameteri(int target, int level, int pname)
	{
#if defined(LIME_GLAD)
		if (glGetTexLevelParameteriv)
		{
			GLint value = 0;
			glGetTexLevelParameteriv(target, level, pname, &value);
			return value;
		}
#endif
		return 0;
	}

	float lime_gl_get_tex_level_parameterf(int target, int level, int pname)
	{
#if defined(LIME_GLAD)
		if (glGetTexLevelParameterfv)
		{
			GLfloat value = 0;
			glGetTexLevelParameterfv(target, level, pname, &value);
			return value;
		}
#endif
		return 0;
	}

	bool lime_gl_get_booleani(int target, int index)
	{
#if defined(LIME_GLAD)
		if (glGetBooleani_v)
		{
			GLboolean value = 0;
			glGetBooleani_v(target, index, &value);
			return value != 0;
		}
#endif
		return false;
	}

	void lime_gl_framebuffer_parameteri(int target, int pname, int param)
	{
#if defined(LIME_GLAD)
		if (glFramebufferParameteri)
		{
			glFramebufferParameteri(target, pname, param);
		}
#endif
	}

	int lime_gl_get_framebuffer_parameteri(int target, int pname)
	{
#if defined(LIME_GLAD)
		if (glGetFramebufferParameteriv)
		{
			GLint value = 0;
			glGetFramebufferParameteriv(target, pname, &value);
			return value;
		}
#endif
		return 0;
	}

	void lime_gl_copy_image_sub_data(int srcName, int srcTarget, int srcLevel, int srcX, int srcY, int srcZ, int dstName, int dstTarget, int dstLevel, int dstX, int dstY, int dstZ, int srcWidth, int srcHeight, int srcDepth)
	{
#if defined(LIME_GLAD)
		if (glCopyImageSubData)
		{
			glCopyImageSubData(srcName, srcTarget, srcLevel, srcX, srcY, srcZ, dstName, dstTarget, dstLevel, dstX, dstY, dstZ, srcWidth, srcHeight, srcDepth);
		}
#endif
	}

	void lime_gl_draw_elements_base_vertex(int mode, int count, int type, double indices, int baseVertex)
	{
#if defined(LIME_GLAD)
		if (glDrawElementsBaseVertex)
		{
			glDrawElementsBaseVertex(mode, count, type, (const void *)(uintptr_t)indices, baseVertex);
		}
#endif
	}

	void lime_gl_draw_range_elements_base_vertex(int mode, int start, int end, int count, int type, double indices, int baseVertex)
	{
#if defined(LIME_GLAD)
		if (glDrawRangeElementsBaseVertex)
		{
			glDrawRangeElementsBaseVertex(mode, start, end, count, type, (const void *)(uintptr_t)indices, baseVertex);
		}
#endif
	}

	void lime_gl_draw_elements_instanced_base_vertex(int mode, int count, int type, double indices, int instanceCount, int baseVertex)
	{
#if defined(LIME_GLAD)
		if (glDrawElementsInstancedBaseVertex)
		{
			glDrawElementsInstancedBaseVertex(mode, count, type, (const void *)(uintptr_t)indices, instanceCount, baseVertex);
		}
#endif
	}

	void lime_gl_framebuffer_texture(int target, int attachment, int texture, int level)
	{
#if defined(LIME_GLAD)
		if (glFramebufferTexture)
		{
			glFramebufferTexture(target, attachment, texture, level);
		}
#endif
	}

	void lime_gl_tex_buffer(int target, int internalformat, int buffer)
	{
#if defined(LIME_GLAD)
		if (glTexBuffer)
		{
			glTexBuffer(target, internalformat, buffer);
		}
#endif
	}

	void lime_gl_tex_buffer_range(int target, int internalformat, int buffer, double offset, int size)
	{
#if defined(LIME_GLAD)
		if (glTexBufferRange)
		{
			glTexBufferRange(target, internalformat, buffer, (GLintptr)(uintptr_t)offset, size);
		}
#endif
	}

	void lime_gl_patch_parameteri(int pname, int value)
	{
#if defined(LIME_GLAD)
		if (glPatchParameteri)
		{
			glPatchParameteri(pname, value);
		}
#endif
	}

	void lime_gl_min_sample_shading(float value)
	{
#if defined(LIME_GLAD)
		if (glMinSampleShading)
		{
			glMinSampleShading(value);
		}
#endif
	}

	void lime_gl_blend_equationi(int buf, int mode)
	{
#if defined(LIME_GLAD)
		if (glBlendEquationi)
		{
			glBlendEquationi(buf, mode);
		}
#endif
	}

	void lime_gl_blend_equation_separatei(int buf, int modeRGB, int modeAlpha)
	{
#if defined(LIME_GLAD)
		if (glBlendEquationSeparatei)
		{
			glBlendEquationSeparatei(buf, modeRGB, modeAlpha);
		}
#endif
	}

	void lime_gl_blend_funci(int buf, int src, int dst)
	{
#if defined(LIME_GLAD)
		if (glBlendFunci)
		{
			glBlendFunci(buf, src, dst);
		}
#endif
	}

	void lime_gl_blend_func_separatei(int buf, int srcRGB, int dstRGB, int srcAlpha, int dstAlpha)
	{
#if defined(LIME_GLAD)
		if (glBlendFuncSeparatei)
		{
			glBlendFuncSeparatei(buf, srcRGB, dstRGB, srcAlpha, dstAlpha);
		}
#endif
	}

	void lime_gl_color_maski(int index, bool r, bool g, bool b, bool a)
	{
#if defined(LIME_GLAD)
		if (glColorMaski)
		{
			glColorMaski(index, r, g, b, a);
		}
#endif
	}

	void lime_gl_enablei(int target, int index)
	{
#if defined(LIME_GLAD)
		if (glEnablei)
		{
			glEnablei(target, index);
		}
#endif
	}

	void lime_gl_disablei(int target, int index)
	{
#if defined(LIME_GLAD)
		if (glDisablei)
		{
			glDisablei(target, index);
		}
#endif
	}

	bool lime_gl_is_enabledi(int target, int index)
	{
#if defined(LIME_GLAD)
		if (glIsEnabledi)
		{
			return glIsEnabledi(target, index);
		}
#endif
		return false;
	}

	void lime_gl_tex_storage_3d_multisample(int target, int samples, int internalformat, int width, int height, int depth, bool fixedSampleLocations)
	{
#if defined(LIME_GLAD)
		if (glTexStorage3DMultisample)
		{
			glTexStorage3DMultisample(target, samples, internalformat, width, height, depth, fixedSampleLocations);
		}
#endif
	}

	void lime_gl_push_debug_group(int source, int id, HxString message)
	{
#if defined(LIME_GLAD)
		if (glPushDebugGroup)
		{
			glPushDebugGroup(source, id, -1, message.__s);
		}
#endif
	}

	void lime_gl_pop_debug_group()
	{
#if defined(LIME_GLAD)
		if (glPopDebugGroup)
		{
			glPopDebugGroup();
		}
#endif
	}

	void lime_gl_object_label(int identifier, int name, HxString label)
	{
#if defined(LIME_GLAD)
		if (glObjectLabel)
		{
			glObjectLabel(identifier, name, -1, label.__s);
		}
#endif
	}

	value lime_gl_get_object_label(int identifier, int name)
	{
#if defined(LIME_GLAD)
		if (glGetObjectLabel)
		{
			GLsizei length = 0;
			std::string buffer(512, 0);
			glGetObjectLabel(identifier, name, 512, &length, &buffer[0]);
			return alloc_string(buffer.c_str());
		}
#endif
		return alloc_null();
	}

	void lime_gl_debug_message_insert(int source, int type, int id, int severity, HxString buf)
	{
#if defined(LIME_GLAD)
		if (glDebugMessageInsert)
		{
			glDebugMessageInsert(source, type, id, severity, -1, buf.__s);
		}
#endif
	}

	void lime_gl_debug_message_control(int source, int type, int severity, int count, double ids, bool enabled)
	{
#if defined(LIME_GLAD)
		if (glDebugMessageControl)
		{
			glDebugMessageControl(source, type, severity, count, (const GLuint *)(uintptr_t)ids, enabled);
		}
#endif
	}

	int lime_gl_create_buffer_dsa()
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glCreateBuffers)
		{
			GLuint id = 0;
			glCreateBuffers(1, &id);
			return id;
		}
#endif
		return 0;
	}

	void lime_gl_named_buffer_data(int buffer, int size, double data, int usage)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glNamedBufferData)
		{
			glNamedBufferData(buffer, size, (const void *)(uintptr_t)data, usage);
		}
#endif
	}

	void lime_gl_named_buffer_sub_data(int buffer, double offset, int size, double data)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glNamedBufferSubData)
		{
			glNamedBufferSubData(buffer, (GLintptr)(uintptr_t)offset, size, (const void *)(uintptr_t)data);
		}
#endif
	}

	void lime_gl_named_buffer_storage(int buffer, int size, double data, int flags)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glNamedBufferStorage)
		{
			glNamedBufferStorage(buffer, size, (const void *)(uintptr_t)data, flags);
		}
#endif
	}

	double lime_gl_map_named_buffer_range(int buffer, double offset, int length, int access)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glMapNamedBufferRange)
		{
			return (double)(uintptr_t)glMapNamedBufferRange(buffer, (GLintptr)(uintptr_t)offset, length, access);
		}
#endif
		return 0;
	}

	bool lime_gl_unmap_named_buffer(int buffer)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glUnmapNamedBuffer)
		{
			return glUnmapNamedBuffer(buffer);
		}
#endif
		return false;
	}

	void lime_gl_flush_mapped_named_buffer_range(int buffer, double offset, int length)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glFlushMappedNamedBufferRange)
		{
			glFlushMappedNamedBufferRange(buffer, (GLintptr)(uintptr_t)offset, length);
		}
#endif
	}

	void lime_gl_buffer_storage(int target, int size, double data, int flags)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glBufferStorage)
		{
			glBufferStorage(target, size, (const void *)(uintptr_t)data, flags);
		}
#endif
	}

	int lime_gl_create_texture_dsa(int target)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glCreateTextures)
		{
			GLuint id = 0;
			glCreateTextures(target, 1, &id);
			return id;
		}
#endif
		return 0;
	}

	void lime_gl_texture_storage_2d(int texture, int levels, int internalformat, int width, int height)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glTextureStorage2D)
		{
			glTextureStorage2D(texture, levels, internalformat, width, height);
		}
#endif
	}

	void lime_gl_texture_storage_3d(int texture, int levels, int internalformat, int width, int height, int depth)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glTextureStorage3D)
		{
			glTextureStorage3D(texture, levels, internalformat, width, height, depth);
		}
#endif
	}

	void lime_gl_texture_sub_image_2d(int texture, int level, int xoffset, int yoffset, int width, int height, int format, int type, double pixels)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glTextureSubImage2D)
		{
			glTextureSubImage2D(texture, level, xoffset, yoffset, width, height, format, type, (const void *)(uintptr_t)pixels);
		}
#endif
	}

	void lime_gl_texture_parameteri(int texture, int pname, int param)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glTextureParameteri)
		{
			glTextureParameteri(texture, pname, param);
		}
#endif
	}

	void lime_gl_texture_parameterf(int texture, int pname, float param)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glTextureParameterf)
		{
			glTextureParameterf(texture, pname, param);
		}
#endif
	}

	void lime_gl_generate_texture_mipmap(int texture)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glGenerateTextureMipmap)
		{
			glGenerateTextureMipmap(texture);
		}
#endif
	}

	void lime_gl_bind_texture_unit(int unit, int texture)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glBindTextureUnit)
		{
			glBindTextureUnit(unit, texture);
		}
#endif
	}

	int lime_gl_create_framebuffer_dsa()
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glCreateFramebuffers)
		{
			GLuint id = 0;
			glCreateFramebuffers(1, &id);
			return id;
		}
#endif
		return 0;
	}

	void lime_gl_named_framebuffer_texture(int framebuffer, int attachment, int texture, int level)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glNamedFramebufferTexture)
		{
			glNamedFramebufferTexture(framebuffer, attachment, texture, level);
		}
#endif
	}

	void lime_gl_named_framebuffer_renderbuffer(int framebuffer, int attachment, int renderbufferTarget, int renderbuffer)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glNamedFramebufferRenderbuffer)
		{
			glNamedFramebufferRenderbuffer(framebuffer, attachment, renderbufferTarget, renderbuffer);
		}
#endif
	}

	int lime_gl_check_named_framebuffer_status(int framebuffer, int target)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glCheckNamedFramebufferStatus)
		{
			return glCheckNamedFramebufferStatus(framebuffer, target);
		}
#endif
		return 0;
	}

	void lime_gl_clear_named_framebufferfv(int framebuffer, int buffer, int drawbuffer, double value)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glClearNamedFramebufferfv)
		{
			glClearNamedFramebufferfv(framebuffer, buffer, drawbuffer, (const GLfloat *)(uintptr_t)value);
		}
#endif
	}

	void lime_gl_blit_named_framebuffer(int readFramebuffer, int drawFramebuffer, int srcX0, int srcY0, int srcX1, int srcY1, int dstX0, int dstY0, int dstX1, int dstY1, int mask, int filter)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glBlitNamedFramebuffer)
		{
			glBlitNamedFramebuffer(readFramebuffer, drawFramebuffer, srcX0, srcY0, srcX1, srcY1, dstX0, dstY0, dstX1, dstY1, mask, filter);
		}
#endif
	}

	int lime_gl_create_renderbuffer_dsa()
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glCreateRenderbuffers)
		{
			GLuint id = 0;
			glCreateRenderbuffers(1, &id);
			return id;
		}
#endif
		return 0;
	}

	void lime_gl_named_renderbuffer_storage(int renderbuffer, int internalformat, int width, int height)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glNamedRenderbufferStorage)
		{
			glNamedRenderbufferStorage(renderbuffer, internalformat, width, height);
		}
#endif
	}

	int lime_gl_create_vertex_array_dsa()
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glCreateVertexArrays)
		{
			GLuint id = 0;
			glCreateVertexArrays(1, &id);
			return id;
		}
#endif
		return 0;
	}

	void lime_gl_vertex_array_vertex_buffer(int vaobj, int bindingIndex, int buffer, double offset, int stride)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glVertexArrayVertexBuffer)
		{
			glVertexArrayVertexBuffer(vaobj, bindingIndex, buffer, (GLintptr)(uintptr_t)offset, stride);
		}
#endif
	}

	void lime_gl_vertex_array_attrib_format(int vaobj, int attribIndex, int size, int type, bool normalized, int relativeOffset)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glVertexArrayAttribFormat)
		{
			glVertexArrayAttribFormat(vaobj, attribIndex, size, type, normalized, relativeOffset);
		}
#endif
	}

	void lime_gl_vertex_array_attrib_binding(int vaobj, int attribIndex, int bindingIndex)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glVertexArrayAttribBinding)
		{
			glVertexArrayAttribBinding(vaobj, attribIndex, bindingIndex);
		}
#endif
	}

	void lime_gl_vertex_array_element_buffer(int vaobj, int buffer)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glVertexArrayElementBuffer)
		{
			glVertexArrayElementBuffer(vaobj, buffer);
		}
#endif
	}

	void lime_gl_enable_vertex_array_attrib(int vaobj, int index)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glEnableVertexArrayAttrib)
		{
			glEnableVertexArrayAttrib(vaobj, index);
		}
#endif
	}

	void lime_gl_multi_draw_arrays_indirect(int mode, double indirect, int drawCount, int stride)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glMultiDrawArraysIndirect)
		{
			glMultiDrawArraysIndirect(mode, (const void *)(uintptr_t)indirect, drawCount, stride);
		}
#endif
	}

	void lime_gl_multi_draw_elements_indirect(int mode, int type, double indirect, int drawCount, int stride)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glMultiDrawElementsIndirect)
		{
			glMultiDrawElementsIndirect(mode, type, (const void *)(uintptr_t)indirect, drawCount, stride);
		}
#endif
	}

	void lime_gl_clip_control(int origin, int depth)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glClipControl)
		{
			glClipControl(origin, depth);
		}
#endif
	}

	void lime_gl_texture_barrier()
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glTextureBarrier)
		{
			glTextureBarrier();
		}
#endif
	}

	void lime_gl_polygon_mode(int face, int mode)
	{
#if defined(LIME_GLAD) && defined(LIME_OPENGL_GL)
		if (glPolygonMode)
		{
			glPolygonMode(face, mode);
		}
#endif
	}

	bool OpenGLBindings::Init()
	{
		static bool result = true;

		if (!initialized)
		{
#if defined(LIME_GLAD)

#ifdef LIME_OPENGL_GLES
			gladLoadGLES2((GLADloadfunc)SDL_GL_GetProcAddress);
#endif

#ifdef LIME_OPENGL_GL
			gladLoadGL((GLADloadfunc)SDL_GL_GetProcAddress);
#endif

#endif

			initialized = true;
		}

		return result;
	}

	DEFINE_PRIME1v(lime_gl_active_texture);
	DEFINE_PRIME2v(lime_gl_attach_shader);
	DEFINE_PRIME2v(lime_gl_begin_query);
	DEFINE_PRIME1v(lime_gl_begin_transform_feedback);
	DEFINE_PRIME3v(lime_gl_bind_attrib_location);
	DEFINE_PRIME2v(lime_gl_bind_buffer);
	DEFINE_PRIME3v(lime_gl_bind_buffer_base);
	DEFINE_PRIME5v(lime_gl_bind_buffer_range);
	DEFINE_PRIME2v(lime_gl_bind_framebuffer);
	DEFINE_PRIME2v(lime_gl_bind_renderbuffer);
	DEFINE_PRIME2v(lime_gl_bind_sampler);
	DEFINE_PRIME2v(lime_gl_bind_texture);
	DEFINE_PRIME2v(lime_gl_bind_transform_feedback);
	DEFINE_PRIME1v(lime_gl_bind_vertex_array);
	DEFINE_PRIME4v(lime_gl_blend_color);
	DEFINE_PRIME1v(lime_gl_blend_equation);
	DEFINE_PRIME2v(lime_gl_blend_equation_separate);
	DEFINE_PRIME2v(lime_gl_blend_func);
	DEFINE_PRIME4v(lime_gl_blend_func_separate);
	DEFINE_PRIME0v(lime_gl_blend_barrier);
	DEFINE_PRIME10v(lime_gl_blit_framebuffer);
	DEFINE_PRIME4v(lime_gl_buffer_data);
	DEFINE_PRIME4v(lime_gl_buffer_sub_data);
	DEFINE_PRIME1(lime_gl_check_framebuffer_status);
	DEFINE_PRIME1v(lime_gl_clear);
	DEFINE_PRIME4v(lime_gl_clear_bufferfi);
	DEFINE_PRIME3v(lime_gl_clear_bufferfv);
	DEFINE_PRIME3v(lime_gl_clear_bufferiv);
	DEFINE_PRIME3v(lime_gl_clear_bufferuiv);
	DEFINE_PRIME4v(lime_gl_clear_color);
	DEFINE_PRIME1v(lime_gl_clear_depthf);
	DEFINE_PRIME1v(lime_gl_clear_stencil);
	DEFINE_PRIME4(lime_gl_client_wait_sync);
	DEFINE_PRIME4v(lime_gl_color_mask);
	DEFINE_PRIME1v(lime_gl_compile_shader);
	DEFINE_PRIME8v(lime_gl_compressed_tex_image_2d);
	DEFINE_PRIME9v(lime_gl_compressed_tex_image_3d);
	DEFINE_PRIME9v(lime_gl_compressed_tex_sub_image_2d);
	DEFINE_PRIME11v(lime_gl_compressed_tex_sub_image_3d);
	DEFINE_PRIME5v(lime_gl_copy_buffer_sub_data);
	DEFINE_PRIME8v(lime_gl_copy_tex_image_2d);
	DEFINE_PRIME8v(lime_gl_copy_tex_sub_image_2d);
	DEFINE_PRIME9v(lime_gl_copy_tex_sub_image_3d);
	DEFINE_PRIME0(lime_gl_create_buffer);
	DEFINE_PRIME0(lime_gl_create_framebuffer);
	DEFINE_PRIME0(lime_gl_create_program);
	DEFINE_PRIME0(lime_gl_create_query);
	DEFINE_PRIME0(lime_gl_create_renderbuffer);
	DEFINE_PRIME0(lime_gl_create_sampler);
	DEFINE_PRIME1(lime_gl_create_shader);
	DEFINE_PRIME0(lime_gl_create_texture);
	DEFINE_PRIME0(lime_gl_create_transform_feedback);
	DEFINE_PRIME0(lime_gl_create_vertex_array);
	DEFINE_PRIME1v(lime_gl_cull_face);
	DEFINE_PRIME1v(lime_gl_delete_buffer);
	DEFINE_PRIME1v(lime_gl_delete_framebuffer);
	DEFINE_PRIME1v(lime_gl_delete_program);
	DEFINE_PRIME1v(lime_gl_delete_query);
	DEFINE_PRIME1v(lime_gl_delete_renderbuffer);
	DEFINE_PRIME1v(lime_gl_delete_sampler);
	DEFINE_PRIME1v(lime_gl_delete_shader);
	DEFINE_PRIME1v(lime_gl_delete_sync);
	DEFINE_PRIME1v(lime_gl_delete_texture);
	DEFINE_PRIME1v(lime_gl_delete_transform_feedback);
	DEFINE_PRIME1v(lime_gl_delete_vertex_array);
	DEFINE_PRIME1v(lime_gl_depth_func);
	DEFINE_PRIME1v(lime_gl_depth_mask);
	DEFINE_PRIME2v(lime_gl_depth_rangef);
	DEFINE_PRIME2v(lime_gl_detach_shader);
	DEFINE_PRIME1v(lime_gl_disable);
	DEFINE_PRIME1v(lime_gl_disable_vertex_attrib_array);
	DEFINE_PRIME3v(lime_gl_draw_arrays);
	DEFINE_PRIME4v(lime_gl_draw_arrays_instanced);
	DEFINE_PRIME1v(lime_gl_draw_buffers);
	DEFINE_PRIME4v(lime_gl_draw_elements);
	DEFINE_PRIME5v(lime_gl_draw_elements_instanced);
	DEFINE_PRIME6v(lime_gl_draw_range_elements);
	DEFINE_PRIME1v(lime_gl_enable);
	DEFINE_PRIME1v(lime_gl_enable_vertex_attrib_array);
	DEFINE_PRIME1v(lime_gl_end_query);
	DEFINE_PRIME0v(lime_gl_end_transform_feedback);
	DEFINE_PRIME2(lime_gl_fence_sync);
	DEFINE_PRIME0v(lime_gl_finish);
	DEFINE_PRIME0v(lime_gl_flush);
	DEFINE_PRIME4v(lime_gl_framebuffer_renderbuffer);
	DEFINE_PRIME5v(lime_gl_framebuffer_texture_layer);
	DEFINE_PRIME5v(lime_gl_framebuffer_texture2D);
	DEFINE_PRIME1v(lime_gl_front_face);
	DEFINE_PRIME1v(lime_gl_generate_mipmap);
	DEFINE_PRIME2(lime_gl_get_active_attrib);
	DEFINE_PRIME2(lime_gl_get_active_uniform);
	DEFINE_PRIME3(lime_gl_get_active_uniform_blocki);
	DEFINE_PRIME4v(lime_gl_get_active_uniform_blockiv);
	DEFINE_PRIME2(lime_gl_get_active_uniform_block_name);
	DEFINE_PRIME4v(lime_gl_get_active_uniformsiv);
	DEFINE_PRIME1(lime_gl_get_attached_shaders);
	DEFINE_PRIME2(lime_gl_get_attrib_location);
	DEFINE_PRIME1(lime_gl_get_boolean);
	DEFINE_PRIME2v(lime_gl_get_booleanv);
	DEFINE_PRIME2(lime_gl_get_buffer_parameteri);
	DEFINE_PRIME3v(lime_gl_get_buffer_parameteriv);
	DEFINE_PRIME3v(lime_gl_get_buffer_parameteri64v);
	DEFINE_PRIME2(lime_gl_get_buffer_pointerv);
	DEFINE_PRIME4v(lime_gl_get_buffer_sub_data);
	DEFINE_PRIME0(lime_gl_get_context_attributes);
	DEFINE_PRIME0(lime_gl_get_error);
	DEFINE_PRIME1(lime_gl_get_extension);
	DEFINE_PRIME1(lime_gl_get_float);
	DEFINE_PRIME2v(lime_gl_get_floatv);
	DEFINE_PRIME2(lime_gl_get_frag_data_location);
	DEFINE_PRIME3(lime_gl_get_framebuffer_attachment_parameteri);
	DEFINE_PRIME4v(lime_gl_get_framebuffer_attachment_parameteriv);
	DEFINE_PRIME1(lime_gl_get_integer);
	DEFINE_PRIME2v(lime_gl_get_integerv);
	DEFINE_PRIME2v(lime_gl_get_integer64v);
	DEFINE_PRIME3v(lime_gl_get_integer64i_v);
	DEFINE_PRIME3v(lime_gl_get_integeri_v);
	DEFINE_PRIME5v(lime_gl_get_internalformativ);
	DEFINE_PRIME2(lime_gl_get_programi);
	DEFINE_PRIME3v(lime_gl_get_programiv);
	DEFINE_PRIME3v(lime_gl_get_program_binary);
	DEFINE_PRIME1(lime_gl_get_program_info_log);
	DEFINE_PRIME2(lime_gl_get_queryi);
	DEFINE_PRIME3v(lime_gl_get_queryiv);
	DEFINE_PRIME2(lime_gl_get_query_objectui);
	DEFINE_PRIME3v(lime_gl_get_query_objectuiv);
	DEFINE_PRIME2(lime_gl_get_renderbuffer_parameteri);
	DEFINE_PRIME3v(lime_gl_get_renderbuffer_parameteriv);
	DEFINE_PRIME2(lime_gl_get_sampler_parameterf);
	DEFINE_PRIME3v(lime_gl_get_sampler_parameterfv);
	DEFINE_PRIME2(lime_gl_get_sampler_parameteri);
	DEFINE_PRIME3v(lime_gl_get_sampler_parameteriv);
	DEFINE_PRIME1(lime_gl_get_shader_info_log);
	DEFINE_PRIME2(lime_gl_get_shaderi);
	DEFINE_PRIME3v(lime_gl_get_shaderiv);
	DEFINE_PRIME2(lime_gl_get_shader_precision_format);
	DEFINE_PRIME1(lime_gl_get_shader_source);
	DEFINE_PRIME1(lime_gl_get_string);
	DEFINE_PRIME2(lime_gl_get_stringi);
	DEFINE_PRIME2(lime_gl_get_sync_parameteri);
	DEFINE_PRIME3v(lime_gl_get_sync_parameteriv);
	DEFINE_PRIME2(lime_gl_get_tex_parameterf);
	DEFINE_PRIME3v(lime_gl_get_tex_parameterfv);
	DEFINE_PRIME2(lime_gl_get_tex_parameteri);
	DEFINE_PRIME3v(lime_gl_get_tex_parameteriv);
	DEFINE_PRIME2(lime_gl_get_transform_feedback_varying);
	DEFINE_PRIME2(lime_gl_get_uniformf);
	DEFINE_PRIME3v(lime_gl_get_uniformfv);
	DEFINE_PRIME2(lime_gl_get_uniformi);
	DEFINE_PRIME3v(lime_gl_get_uniformiv);
	DEFINE_PRIME2(lime_gl_get_uniformui);
	DEFINE_PRIME3v(lime_gl_get_uniformuiv);
	DEFINE_PRIME2(lime_gl_get_uniform_block_index);
	DEFINE_PRIME2(lime_gl_get_uniform_location);
	DEFINE_PRIME2(lime_gl_get_vertex_attribf);
	DEFINE_PRIME3v(lime_gl_get_vertex_attribfv);
	DEFINE_PRIME2(lime_gl_get_vertex_attribi);
	DEFINE_PRIME3v(lime_gl_get_vertex_attribiv);
	DEFINE_PRIME2(lime_gl_get_vertex_attribii);
	DEFINE_PRIME3v(lime_gl_get_vertex_attribiiv);
	DEFINE_PRIME2(lime_gl_get_vertex_attribiui);
	DEFINE_PRIME3v(lime_gl_get_vertex_attribiuiv);
	DEFINE_PRIME2(lime_gl_get_vertex_attrib_pointerv);
	DEFINE_PRIME2v(lime_gl_hint);
	DEFINE_PRIME2v(lime_gl_invalidate_framebuffer);
	DEFINE_PRIME6v(lime_gl_invalidate_sub_framebuffer);
	DEFINE_PRIME1(lime_gl_is_buffer);
	DEFINE_PRIME1(lime_gl_is_enabled);
	DEFINE_PRIME1(lime_gl_is_framebuffer);
	DEFINE_PRIME1(lime_gl_is_program);
	DEFINE_PRIME1(lime_gl_is_query);
	DEFINE_PRIME1(lime_gl_is_renderbuffer);
	DEFINE_PRIME1(lime_gl_is_sampler);
	DEFINE_PRIME1(lime_gl_is_shader);
	DEFINE_PRIME1(lime_gl_is_sync);
	DEFINE_PRIME1(lime_gl_is_texture);
	DEFINE_PRIME1(lime_gl_is_transform_feedback);
	DEFINE_PRIME1(lime_gl_is_vertex_array);
	DEFINE_PRIME1v(lime_gl_line_width);
	DEFINE_PRIME1v(lime_gl_link_program);
	DEFINE_PRIME4(lime_gl_map_buffer_range);
	DEFINE_PRIME1v(lime_gl_object_deregister);
	DEFINE_PRIME2(lime_gl_object_from_id);
	DEFINE_PRIME3(lime_gl_object_register);
	DEFINE_PRIME0v(lime_gl_pause_transform_feedback);
	DEFINE_PRIME2v(lime_gl_pixel_storei);
	DEFINE_PRIME2v(lime_gl_polygon_offset);
	DEFINE_PRIME4v(lime_gl_program_binary);
	DEFINE_PRIME3v(lime_gl_program_parameteri);
	DEFINE_PRIME1v(lime_gl_read_buffer);
	DEFINE_PRIME7v(lime_gl_read_pixels);
	DEFINE_PRIME0v(lime_gl_release_shader_compiler);
	DEFINE_PRIME4v(lime_gl_renderbuffer_storage);
	DEFINE_PRIME5v(lime_gl_renderbuffer_storage_multisample);
	DEFINE_PRIME0v(lime_gl_resume_transform_feedback);
	DEFINE_PRIME2v(lime_gl_sample_coverage);
	DEFINE_PRIME3v(lime_gl_sampler_parameterf);
	DEFINE_PRIME3v(lime_gl_sampler_parameteri);
	DEFINE_PRIME4v(lime_gl_scissor);
	DEFINE_PRIME4v(lime_gl_shader_binary);
	DEFINE_PRIME2v(lime_gl_shader_source);
	DEFINE_PRIME3v(lime_gl_stencil_func);
	DEFINE_PRIME4v(lime_gl_stencil_func_separate);
	DEFINE_PRIME1v(lime_gl_stencil_mask);
	DEFINE_PRIME2v(lime_gl_stencil_mask_separate);
	DEFINE_PRIME3v(lime_gl_stencil_op);
	DEFINE_PRIME4v(lime_gl_stencil_op_separate);
	DEFINE_PRIME9v(lime_gl_tex_image_2d);
	DEFINE_PRIME10v(lime_gl_tex_image_3d);
	DEFINE_PRIME3v(lime_gl_tex_parameterf);
	DEFINE_PRIME3v(lime_gl_tex_parameteri);
	DEFINE_PRIME5v(lime_gl_tex_storage_2d);
	DEFINE_PRIME6v(lime_gl_tex_storage_3d);
	DEFINE_PRIME9v(lime_gl_tex_sub_image_2d);
	DEFINE_PRIME11v(lime_gl_tex_sub_image_3d);
	DEFINE_PRIME3v(lime_gl_transform_feedback_varyings);
	DEFINE_PRIME2v(lime_gl_uniform1f);
	DEFINE_PRIME3v(lime_gl_uniform1fv);
	DEFINE_PRIME2v(lime_gl_uniform1i);
	DEFINE_PRIME3v(lime_gl_uniform1iv);
	DEFINE_PRIME2v(lime_gl_uniform1ui);
	DEFINE_PRIME3v(lime_gl_uniform1uiv);
	DEFINE_PRIME3v(lime_gl_uniform2f);
	DEFINE_PRIME3v(lime_gl_uniform2fv);
	DEFINE_PRIME3v(lime_gl_uniform2i);
	DEFINE_PRIME3v(lime_gl_uniform2iv);
	DEFINE_PRIME3v(lime_gl_uniform2ui);
	DEFINE_PRIME3v(lime_gl_uniform2uiv);
	DEFINE_PRIME4v(lime_gl_uniform3f);
	DEFINE_PRIME3v(lime_gl_uniform3fv);
	DEFINE_PRIME4v(lime_gl_uniform3i);
	DEFINE_PRIME3v(lime_gl_uniform3iv);
	DEFINE_PRIME4v(lime_gl_uniform3ui);
	DEFINE_PRIME3v(lime_gl_uniform3uiv);
	DEFINE_PRIME5v(lime_gl_uniform4f);
	DEFINE_PRIME3v(lime_gl_uniform4fv);
	DEFINE_PRIME5v(lime_gl_uniform4i);
	DEFINE_PRIME3v(lime_gl_uniform4iv);
	DEFINE_PRIME5v(lime_gl_uniform4ui);
	DEFINE_PRIME3v(lime_gl_uniform4uiv);
	DEFINE_PRIME3v(lime_gl_uniform_block_binding);
	DEFINE_PRIME4v(lime_gl_uniform_matrix2fv);
	DEFINE_PRIME4v(lime_gl_uniform_matrix2x3fv);
	DEFINE_PRIME4v(lime_gl_uniform_matrix2x4fv);
	DEFINE_PRIME4v(lime_gl_uniform_matrix3fv);
	DEFINE_PRIME4v(lime_gl_uniform_matrix3x2fv);
	DEFINE_PRIME4v(lime_gl_uniform_matrix3x4fv);
	DEFINE_PRIME4v(lime_gl_uniform_matrix4fv);
	DEFINE_PRIME4v(lime_gl_uniform_matrix4x2fv);
	DEFINE_PRIME4v(lime_gl_uniform_matrix4x3fv);
	DEFINE_PRIME1(lime_gl_unmap_buffer);
	DEFINE_PRIME1v(lime_gl_use_program);
	DEFINE_PRIME1v(lime_gl_validate_program);
	DEFINE_PRIME2v(lime_gl_vertex_attrib_divisor);
	DEFINE_PRIME5v(lime_gl_vertex_attrib_ipointer);
	DEFINE_PRIME6v(lime_gl_vertex_attrib_pointer);
	DEFINE_PRIME5v(lime_gl_vertex_attribi4i);
	DEFINE_PRIME2v(lime_gl_vertex_attribi4iv);
	DEFINE_PRIME5v(lime_gl_vertex_attribi4ui);
	DEFINE_PRIME2v(lime_gl_vertex_attribi4uiv);
	DEFINE_PRIME2v(lime_gl_vertex_attrib1f);
	DEFINE_PRIME2v(lime_gl_vertex_attrib1fv);
	DEFINE_PRIME3v(lime_gl_vertex_attrib2f);
	DEFINE_PRIME2v(lime_gl_vertex_attrib2fv);
	DEFINE_PRIME4v(lime_gl_vertex_attrib3f);
	DEFINE_PRIME2v(lime_gl_vertex_attrib3fv);
	DEFINE_PRIME5v(lime_gl_vertex_attrib4f);
	DEFINE_PRIME2v(lime_gl_vertex_attrib4fv);
	DEFINE_PRIME4v(lime_gl_viewport);
	DEFINE_PRIME3v(lime_gl_flush_mapped_buffer_range);
	DEFINE_PRIME3v(lime_gl_dispatch_compute);
	DEFINE_PRIME1v(lime_gl_dispatch_compute_indirect);
	DEFINE_PRIME1v(lime_gl_memory_barrier);
	DEFINE_PRIME1v(lime_gl_memory_barrier_by_region);
	DEFINE_PRIME7v(lime_gl_bind_image_texture);
	DEFINE_PRIME2v(lime_gl_draw_arrays_indirect);
	DEFINE_PRIME3v(lime_gl_draw_elements_indirect);
	DEFINE_PRIME3(lime_gl_get_program_interfacei);
	DEFINE_PRIME4v(lime_gl_get_program_interfaceiv);
	DEFINE_PRIME3(lime_gl_get_program_resource_index);
	DEFINE_PRIME3(lime_gl_get_program_resource_location);
	DEFINE_PRIME3(lime_gl_get_program_resource_name);
	DEFINE_PRIME7v(lime_gl_get_program_resourceiv);
	DEFINE_PRIME0(lime_gl_create_program_pipeline);
	DEFINE_PRIME1v(lime_gl_delete_program_pipeline);
	DEFINE_PRIME1v(lime_gl_bind_program_pipeline);
	DEFINE_PRIME1(lime_gl_is_program_pipeline);
	DEFINE_PRIME3v(lime_gl_use_program_stages);
	DEFINE_PRIME2v(lime_gl_active_shader_program);
	DEFINE_PRIME2(lime_gl_create_shader_programv);
	DEFINE_PRIME1v(lime_gl_validate_program_pipeline);
	DEFINE_PRIME2(lime_gl_get_program_pipelinei);
	DEFINE_PRIME1(lime_gl_get_program_pipeline_info_log);
	DEFINE_PRIME3v(lime_gl_program_uniform1i);
	DEFINE_PRIME3v(lime_gl_program_uniform1f);
	DEFINE_PRIME4v(lime_gl_program_uniform2f);
	DEFINE_PRIME5v(lime_gl_program_uniform3f);
	DEFINE_PRIME6v(lime_gl_program_uniform4f);
	DEFINE_PRIME5v(lime_gl_program_uniform_matrix4fv);
	DEFINE_PRIME4v(lime_gl_bind_vertex_buffer);
	DEFINE_PRIME5v(lime_gl_vertex_attrib_format);
	DEFINE_PRIME4v(lime_gl_vertex_attrib_iformat);
	DEFINE_PRIME2v(lime_gl_vertex_attrib_binding);
	DEFINE_PRIME2v(lime_gl_vertex_binding_divisor);
	DEFINE_PRIME6v(lime_gl_tex_storage_2d_multisample);
	DEFINE_PRIME3v(lime_gl_get_multisamplefv);
	DEFINE_PRIME2v(lime_gl_sample_maski);
	DEFINE_PRIME3(lime_gl_get_tex_level_parameteri);
	DEFINE_PRIME3(lime_gl_get_tex_level_parameterf);
	DEFINE_PRIME2(lime_gl_get_booleani);
	DEFINE_PRIME3v(lime_gl_framebuffer_parameteri);
	DEFINE_PRIME2(lime_gl_get_framebuffer_parameteri);
	DEFINE_PRIME15v(lime_gl_copy_image_sub_data);
	DEFINE_PRIME5v(lime_gl_draw_elements_base_vertex);
	DEFINE_PRIME7v(lime_gl_draw_range_elements_base_vertex);
	DEFINE_PRIME6v(lime_gl_draw_elements_instanced_base_vertex);
	DEFINE_PRIME4v(lime_gl_framebuffer_texture);
	DEFINE_PRIME3v(lime_gl_tex_buffer);
	DEFINE_PRIME5v(lime_gl_tex_buffer_range);
	DEFINE_PRIME2v(lime_gl_patch_parameteri);
	DEFINE_PRIME1v(lime_gl_min_sample_shading);
	DEFINE_PRIME2v(lime_gl_blend_equationi);
	DEFINE_PRIME3v(lime_gl_blend_equation_separatei);
	DEFINE_PRIME3v(lime_gl_blend_funci);
	DEFINE_PRIME5v(lime_gl_blend_func_separatei);
	DEFINE_PRIME5v(lime_gl_color_maski);
	DEFINE_PRIME2v(lime_gl_enablei);
	DEFINE_PRIME2v(lime_gl_disablei);
	DEFINE_PRIME2(lime_gl_is_enabledi);
	DEFINE_PRIME7v(lime_gl_tex_storage_3d_multisample);
	DEFINE_PRIME3v(lime_gl_push_debug_group);
	DEFINE_PRIME0v(lime_gl_pop_debug_group);
	DEFINE_PRIME3v(lime_gl_object_label);
	DEFINE_PRIME2(lime_gl_get_object_label);
	DEFINE_PRIME5v(lime_gl_debug_message_insert);
	DEFINE_PRIME6v(lime_gl_debug_message_control);
	DEFINE_PRIME0(lime_gl_create_buffer_dsa);
	DEFINE_PRIME4v(lime_gl_named_buffer_data);
	DEFINE_PRIME4v(lime_gl_named_buffer_sub_data);
	DEFINE_PRIME4v(lime_gl_named_buffer_storage);
	DEFINE_PRIME4(lime_gl_map_named_buffer_range);
	DEFINE_PRIME1(lime_gl_unmap_named_buffer);
	DEFINE_PRIME3v(lime_gl_flush_mapped_named_buffer_range);
	DEFINE_PRIME4v(lime_gl_buffer_storage);
	DEFINE_PRIME1(lime_gl_create_texture_dsa);
	DEFINE_PRIME5v(lime_gl_texture_storage_2d);
	DEFINE_PRIME6v(lime_gl_texture_storage_3d);
	DEFINE_PRIME9v(lime_gl_texture_sub_image_2d);
	DEFINE_PRIME3v(lime_gl_texture_parameteri);
	DEFINE_PRIME3v(lime_gl_texture_parameterf);
	DEFINE_PRIME1v(lime_gl_generate_texture_mipmap);
	DEFINE_PRIME2v(lime_gl_bind_texture_unit);
	DEFINE_PRIME0(lime_gl_create_framebuffer_dsa);
	DEFINE_PRIME4v(lime_gl_named_framebuffer_texture);
	DEFINE_PRIME4v(lime_gl_named_framebuffer_renderbuffer);
	DEFINE_PRIME2(lime_gl_check_named_framebuffer_status);
	DEFINE_PRIME4v(lime_gl_clear_named_framebufferfv);
	DEFINE_PRIME12v(lime_gl_blit_named_framebuffer);
	DEFINE_PRIME0(lime_gl_create_renderbuffer_dsa);
	DEFINE_PRIME4v(lime_gl_named_renderbuffer_storage);
	DEFINE_PRIME0(lime_gl_create_vertex_array_dsa);
	DEFINE_PRIME5v(lime_gl_vertex_array_vertex_buffer);
	DEFINE_PRIME6v(lime_gl_vertex_array_attrib_format);
	DEFINE_PRIME3v(lime_gl_vertex_array_attrib_binding);
	DEFINE_PRIME2v(lime_gl_vertex_array_element_buffer);
	DEFINE_PRIME2v(lime_gl_enable_vertex_array_attrib);
	DEFINE_PRIME4v(lime_gl_multi_draw_arrays_indirect);
	DEFINE_PRIME5v(lime_gl_multi_draw_elements_indirect);
	DEFINE_PRIME2v(lime_gl_clip_control);
	DEFINE_PRIME0v(lime_gl_texture_barrier);
	DEFINE_PRIME2v(lime_gl_polygon_mode);
	DEFINE_PRIME4v(lime_gl_wait_sync);

} // namespace lime

extern "C" int lime_opengl_register_prims()
{
	return 0;
}
