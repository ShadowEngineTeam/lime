package lime._internal.backend.native;

import haxe.io.Bytes;
import haxe.Int64;

import lime.graphics.opengl.ext.*;
import lime.graphics.opengl.GLQuery;
import lime.graphics.opengl.GLSampler;
import lime.graphics.opengl.GLSync;
import lime.graphics.opengl.GLTransformFeedback;
import lime.graphics.opengl.GLVertexArrayObject;
import lime.graphics.opengl.GLActiveInfo;
import lime.graphics.opengl.GLBuffer;
import lime.graphics.opengl.GLContextAttributes;
import lime.graphics.opengl.GLFramebuffer;
import lime.graphics.opengl.GLProgram;
import lime.graphics.opengl.GLRenderbuffer;
import lime.graphics.opengl.GLShader;
import lime.graphics.opengl.GLShaderPrecisionFormat;
import lime.graphics.opengl.GLTexture;
import lime.graphics.opengl.GLUniformLocation;
import lime.graphics.opengl.GL;
import lime.graphics.RenderContextType;
import lime.system.CFFI;
import lime.utils.DataPointer;
import lime.utils.Float32Array;
import lime.utils.Int32Array;
import lime.utils.UInt32Array;

@:dox(hide)
@:allow(lime.ui.Window)
@:access(lime._internal.backend.native.NativeCFFI)
@:access(lime.graphics.opengl)
class NativeOpenGLRenderContext
{
	private static var __extensionObjects:Map<String, Dynamic>;
	private static var __extensionObjectConstructors = new Map<String, Void->Dynamic>();
	private static var __lastContextID = 0;
	private static var __supportedExtensions:Array<String>;

	public var DEPTH_BUFFER_BIT(get, never):Int;
	public var STENCIL_BUFFER_BIT(get, never):Int;
	public var COLOR_BUFFER_BIT(get, never):Int;
	public var POINTS(get, never):Int;
	public var LINES(get, never):Int;
	public var LINE_LOOP(get, never):Int;
	public var LINE_STRIP(get, never):Int;
	public var TRIANGLES(get, never):Int;
	public var TRIANGLE_STRIP(get, never):Int;
	public var TRIANGLE_FAN(get, never):Int;
	public var ZERO(get, never):Int;
	public var ONE(get, never):Int;
	public var SRC_COLOR(get, never):Int;
	public var ONE_MINUS_SRC_COLOR(get, never):Int;
	public var SRC_ALPHA(get, never):Int;
	public var ONE_MINUS_SRC_ALPHA(get, never):Int;
	public var DST_ALPHA(get, never):Int;
	public var ONE_MINUS_DST_ALPHA(get, never):Int;
	public var DST_COLOR(get, never):Int;
	public var ONE_MINUS_DST_COLOR(get, never):Int;
	public var SRC_ALPHA_SATURATE(get, never):Int;
	public var FUNC_ADD(get, never):Int;
	public var BLEND_EQUATION(get, never):Int;
	public var BLEND_EQUATION_RGB(get, never):Int;
	public var BLEND_EQUATION_ALPHA(get, never):Int;
	public var FUNC_SUBTRACT(get, never):Int;
	public var FUNC_REVERSE_SUBTRACT(get, never):Int;
	public var BLEND_DST_RGB(get, never):Int;
	public var BLEND_SRC_RGB(get, never):Int;
	public var BLEND_DST_ALPHA(get, never):Int;
	public var BLEND_SRC_ALPHA(get, never):Int;
	public var CONSTANT_COLOR(get, never):Int;
	public var ONE_MINUS_CONSTANT_COLOR(get, never):Int;
	public var CONSTANT_ALPHA(get, never):Int;
	public var ONE_MINUS_CONSTANT_ALPHA(get, never):Int;
	public var BLEND_COLOR(get, never):Int;
	public var ARRAY_BUFFER(get, never):Int;
	public var ELEMENT_ARRAY_BUFFER(get, never):Int;
	public var ARRAY_BUFFER_BINDING(get, never):Int;
	public var ELEMENT_ARRAY_BUFFER_BINDING(get, never):Int;
	public var STREAM_DRAW(get, never):Int;
	public var STATIC_DRAW(get, never):Int;
	public var DYNAMIC_DRAW(get, never):Int;
	public var BUFFER_SIZE(get, never):Int;
	public var BUFFER_USAGE(get, never):Int;
	public var CURRENT_VERTEX_ATTRIB(get, never):Int;
	public var FRONT(get, never):Int;
	public var BACK(get, never):Int;
	public var FRONT_AND_BACK(get, never):Int;
	public var TEXTURE_2D(get, never):Int;
	public var CULL_FACE(get, never):Int;
	public var BLEND(get, never):Int;
	public var DITHER(get, never):Int;
	public var STENCIL_TEST(get, never):Int;
	public var DEPTH_TEST(get, never):Int;
	public var SCISSOR_TEST(get, never):Int;
	public var POLYGON_OFFSET_FILL(get, never):Int;
	public var SAMPLE_ALPHA_TO_COVERAGE(get, never):Int;
	public var SAMPLE_COVERAGE(get, never):Int;
	public var NO_ERROR(get, never):Int;
	public var INVALID_ENUM(get, never):Int;
	public var INVALID_VALUE(get, never):Int;
	public var INVALID_OPERATION(get, never):Int;
	public var OUT_OF_MEMORY(get, never):Int;
	public var CW(get, never):Int;
	public var CCW(get, never):Int;
	public var LINE_WIDTH(get, never):Int;
	public var ALIASED_POINT_SIZE_RANGE(get, never):Int;
	public var ALIASED_LINE_WIDTH_RANGE(get, never):Int;
	public var CULL_FACE_MODE(get, never):Int;
	public var FRONT_FACE(get, never):Int;
	public var DEPTH_RANGE(get, never):Int;
	public var DEPTH_WRITEMASK(get, never):Int;
	public var DEPTH_CLEAR_VALUE(get, never):Int;
	public var DEPTH_FUNC(get, never):Int;
	public var STENCIL_CLEAR_VALUE(get, never):Int;
	public var STENCIL_FUNC(get, never):Int;
	public var STENCIL_FAIL(get, never):Int;
	public var STENCIL_PASS_DEPTH_FAIL(get, never):Int;
	public var STENCIL_PASS_DEPTH_PASS(get, never):Int;
	public var STENCIL_REF(get, never):Int;
	public var STENCIL_VALUE_MASK(get, never):Int;
	public var STENCIL_WRITEMASK(get, never):Int;
	public var STENCIL_BACK_FUNC(get, never):Int;
	public var STENCIL_BACK_FAIL(get, never):Int;
	public var STENCIL_BACK_PASS_DEPTH_FAIL(get, never):Int;
	public var STENCIL_BACK_PASS_DEPTH_PASS(get, never):Int;
	public var STENCIL_BACK_REF(get, never):Int;
	public var STENCIL_BACK_VALUE_MASK(get, never):Int;
	public var STENCIL_BACK_WRITEMASK(get, never):Int;
	public var VIEWPORT(get, never):Int;
	public var SCISSOR_BOX(get, never):Int;
	public var COLOR_CLEAR_VALUE(get, never):Int;
	public var COLOR_WRITEMASK(get, never):Int;
	public var UNPACK_ALIGNMENT(get, never):Int;
	public var PACK_ALIGNMENT(get, never):Int;
	public var MAX_TEXTURE_SIZE(get, never):Int;
	public var MAX_VIEWPORT_DIMS(get, never):Int;
	public var SUBPIXEL_BITS(get, never):Int;
	public var RED_BITS(get, never):Int;
	public var GREEN_BITS(get, never):Int;
	public var BLUE_BITS(get, never):Int;
	public var ALPHA_BITS(get, never):Int;
	public var DEPTH_BITS(get, never):Int;
	public var STENCIL_BITS(get, never):Int;
	public var POLYGON_OFFSET_UNITS(get, never):Int;
	public var POLYGON_OFFSET_FACTOR(get, never):Int;
	public var TEXTURE_BINDING_2D(get, never):Int;
	public var SAMPLE_BUFFERS(get, never):Int;
	public var SAMPLES(get, never):Int;
	public var SAMPLE_COVERAGE_VALUE(get, never):Int;
	public var SAMPLE_COVERAGE_INVERT(get, never):Int;
	public var NUM_COMPRESSED_TEXTURE_FORMATS(get, never):Int;
	public var COMPRESSED_TEXTURE_FORMATS(get, never):Int;
	public var DONT_CARE(get, never):Int;
	public var FASTEST(get, never):Int;
	public var NICEST(get, never):Int;
	public var GENERATE_MIPMAP_HINT(get, never):Int;
	public var BYTE(get, never):Int;
	public var UNSIGNED_BYTE(get, never):Int;
	public var SHORT(get, never):Int;
	public var UNSIGNED_SHORT(get, never):Int;
	public var INT(get, never):Int;
	public var UNSIGNED_INT(get, never):Int;
	public var FLOAT(get, never):Int;
	public var FIXED(get, never):Int;
	public var DEPTH_COMPONENT(get, never):Int;
	public var ALPHA(get, never):Int;
	public var RGB(get, never):Int;
	public var RGBA(get, never):Int;
	public var LUMINANCE(get, never):Int;
	public var LUMINANCE_ALPHA(get, never):Int;
	public var UNSIGNED_SHORT_4_4_4_4(get, never):Int;
	public var UNSIGNED_SHORT_5_5_5_1(get, never):Int;
	public var UNSIGNED_SHORT_5_6_5(get, never):Int;
	public var FRAGMENT_SHADER(get, never):Int;
	public var VERTEX_SHADER(get, never):Int;
	public var MAX_VERTEX_ATTRIBS(get, never):Int;
	public var MAX_VERTEX_UNIFORM_VECTORS(get, never):Int;
	public var MAX_VARYING_VECTORS(get, never):Int;
	public var MAX_COMBINED_TEXTURE_IMAGE_UNITS(get, never):Int;
	public var MAX_VERTEX_TEXTURE_IMAGE_UNITS(get, never):Int;
	public var MAX_TEXTURE_IMAGE_UNITS(get, never):Int;
	public var MAX_FRAGMENT_UNIFORM_VECTORS(get, never):Int;
	public var SHADER_TYPE(get, never):Int;
	public var DELETE_STATUS(get, never):Int;
	public var LINK_STATUS(get, never):Int;
	public var VALIDATE_STATUS(get, never):Int;
	public var ATTACHED_SHADERS(get, never):Int;
	public var ACTIVE_UNIFORMS(get, never):Int;
	public var ACTIVE_UNIFORMS_MAX_LENGTH(get, never):Int;
	public var ACTIVE_ATTRIBUTES(get, never):Int;
	public var ACTIVE_ATTRIBUTES_MAX_LENGTH(get, never):Int;
	public var SHADING_LANGUAGE_VERSION(get, never):Int;
	public var CURRENT_PROGRAM(get, never):Int;
	public var NEVER(get, never):Int;
	public var LESS(get, never):Int;
	public var EQUAL(get, never):Int;
	public var LEQUAL(get, never):Int;
	public var GREATER(get, never):Int;
	public var NOTEQUAL(get, never):Int;
	public var GEQUAL(get, never):Int;
	public var ALWAYS(get, never):Int;
	public var KEEP(get, never):Int;
	public var REPLACE(get, never):Int;
	public var INCR(get, never):Int;
	public var DECR(get, never):Int;
	public var INVERT(get, never):Int;
	public var INCR_WRAP(get, never):Int;
	public var DECR_WRAP(get, never):Int;
	public var VENDOR(get, never):Int;
	public var RENDERER(get, never):Int;
	public var VERSION(get, never):Int;
	public var EXTENSIONS(get, never):Int;
	public var NEAREST(get, never):Int;
	public var LINEAR(get, never):Int;
	public var NEAREST_MIPMAP_NEAREST(get, never):Int;
	public var LINEAR_MIPMAP_NEAREST(get, never):Int;
	public var NEAREST_MIPMAP_LINEAR(get, never):Int;
	public var LINEAR_MIPMAP_LINEAR(get, never):Int;
	public var TEXTURE_MAG_FILTER(get, never):Int;
	public var TEXTURE_MIN_FILTER(get, never):Int;
	public var TEXTURE_WRAP_S(get, never):Int;
	public var TEXTURE_WRAP_T(get, never):Int;
	public var TEXTURE(get, never):Int;
	public var TEXTURE_CUBE_MAP(get, never):Int;
	public var TEXTURE_BINDING_CUBE_MAP(get, never):Int;
	public var TEXTURE_CUBE_MAP_POSITIVE_X(get, never):Int;
	public var TEXTURE_CUBE_MAP_NEGATIVE_X(get, never):Int;
	public var TEXTURE_CUBE_MAP_POSITIVE_Y(get, never):Int;
	public var TEXTURE_CUBE_MAP_NEGATIVE_Y(get, never):Int;
	public var TEXTURE_CUBE_MAP_POSITIVE_Z(get, never):Int;
	public var TEXTURE_CUBE_MAP_NEGATIVE_Z(get, never):Int;
	public var MAX_CUBE_MAP_TEXTURE_SIZE(get, never):Int;
	public var TEXTURE0(get, never):Int;
	public var TEXTURE1(get, never):Int;
	public var TEXTURE2(get, never):Int;
	public var TEXTURE3(get, never):Int;
	public var TEXTURE4(get, never):Int;
	public var TEXTURE5(get, never):Int;
	public var TEXTURE6(get, never):Int;
	public var TEXTURE7(get, never):Int;
	public var TEXTURE8(get, never):Int;
	public var TEXTURE9(get, never):Int;
	public var TEXTURE10(get, never):Int;
	public var TEXTURE11(get, never):Int;
	public var TEXTURE12(get, never):Int;
	public var TEXTURE13(get, never):Int;
	public var TEXTURE14(get, never):Int;
	public var TEXTURE15(get, never):Int;
	public var TEXTURE16(get, never):Int;
	public var TEXTURE17(get, never):Int;
	public var TEXTURE18(get, never):Int;
	public var TEXTURE19(get, never):Int;
	public var TEXTURE20(get, never):Int;
	public var TEXTURE21(get, never):Int;
	public var TEXTURE22(get, never):Int;
	public var TEXTURE23(get, never):Int;
	public var TEXTURE24(get, never):Int;
	public var TEXTURE25(get, never):Int;
	public var TEXTURE26(get, never):Int;
	public var TEXTURE27(get, never):Int;
	public var TEXTURE28(get, never):Int;
	public var TEXTURE29(get, never):Int;
	public var TEXTURE30(get, never):Int;
	public var TEXTURE31(get, never):Int;
	public var ACTIVE_TEXTURE(get, never):Int;
	public var REPEAT(get, never):Int;
	public var CLAMP_TO_EDGE(get, never):Int;
	public var MIRRORED_REPEAT(get, never):Int;
	public var FLOAT_VEC2(get, never):Int;
	public var FLOAT_VEC3(get, never):Int;
	public var FLOAT_VEC4(get, never):Int;
	public var INT_VEC2(get, never):Int;
	public var INT_VEC3(get, never):Int;
	public var INT_VEC4(get, never):Int;
	public var BOOL(get, never):Int;
	public var BOOL_VEC2(get, never):Int;
	public var BOOL_VEC3(get, never):Int;
	public var BOOL_VEC4(get, never):Int;
	public var FLOAT_MAT2(get, never):Int;
	public var FLOAT_MAT3(get, never):Int;
	public var FLOAT_MAT4(get, never):Int;
	public var SAMPLER_2D(get, never):Int;
	public var SAMPLER_CUBE(get, never):Int;
	public var VERTEX_ATTRIB_ARRAY_ENABLED(get, never):Int;
	public var VERTEX_ATTRIB_ARRAY_SIZE(get, never):Int;
	public var VERTEX_ATTRIB_ARRAY_STRIDE(get, never):Int;
	public var VERTEX_ATTRIB_ARRAY_TYPE(get, never):Int;
	public var VERTEX_ATTRIB_ARRAY_NORMALIZED(get, never):Int;
	public var VERTEX_ATTRIB_ARRAY_POINTER(get, never):Int;
	public var VERTEX_ATTRIB_ARRAY_BUFFER_BINDING(get, never):Int;
	public var IMPLEMENTATION_COLOR_READ_TYPE(get, never):Int;
	public var IMPLEMENTATION_COLOR_READ_FORMAT(get, never):Int;
	public var VERTEX_PROGRAM_POINT_SIZE(get, never):Int;
	public var POINT_SPRITE(get, never):Int;
	public var COMPILE_STATUS(get, never):Int;
	public var INFO_LOG_LENGTH(get, never):Int;
	public var SHADER_SOURCE_LENGTH(get, never):Int;
	public var SHADER_COMPILER(get, never):Int;
	public var SHADER_BINARY_FORMATS(get, never):Int;
	public var NUM_SHADER_BINARY_FORMATS(get, never):Int;
	public var LOW_FLOAT(get, never):Int;
	public var MEDIUM_FLOAT(get, never):Int;
	public var HIGH_FLOAT(get, never):Int;
	public var LOW_INT(get, never):Int;
	public var MEDIUM_INT(get, never):Int;
	public var HIGH_INT(get, never):Int;
	public var FRAMEBUFFER(get, never):Int;
	public var RENDERBUFFER(get, never):Int;
	public var RGBA4(get, never):Int;
	public var RGB5_A1(get, never):Int;
	public var RGB565(get, never):Int;
	public var DEPTH_COMPONENT16(get, never):Int;
	public var STENCIL_INDEX(get, never):Int;
	public var STENCIL_INDEX8(get, never):Int;
	public var DEPTH_STENCIL(get, never):Int;
	public var RENDERBUFFER_WIDTH(get, never):Int;
	public var RENDERBUFFER_HEIGHT(get, never):Int;
	public var RENDERBUFFER_INTERNAL_FORMAT(get, never):Int;
	public var RENDERBUFFER_RED_SIZE(get, never):Int;
	public var RENDERBUFFER_GREEN_SIZE(get, never):Int;
	public var RENDERBUFFER_BLUE_SIZE(get, never):Int;
	public var RENDERBUFFER_ALPHA_SIZE(get, never):Int;
	public var RENDERBUFFER_DEPTH_SIZE(get, never):Int;
	public var RENDERBUFFER_STENCIL_SIZE(get, never):Int;
	public var FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE(get, never):Int;
	public var FRAMEBUFFER_ATTACHMENT_OBJECT_NAME(get, never):Int;
	public var FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL(get, never):Int;
	public var FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE(get, never):Int;
	public var COLOR_ATTACHMENT0(get, never):Int;
	public var DEPTH_ATTACHMENT(get, never):Int;
	public var STENCIL_ATTACHMENT(get, never):Int;
	public var DEPTH_STENCIL_ATTACHMENT(get, never):Int;
	public var NONE(get, never):Int;
	public var FRAMEBUFFER_COMPLETE(get, never):Int;
	public var FRAMEBUFFER_INCOMPLETE_ATTACHMENT(get, never):Int;
	public var FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT(get, never):Int;
	public var FRAMEBUFFER_INCOMPLETE_DIMENSIONS(get, never):Int;
	public var FRAMEBUFFER_UNSUPPORTED(get, never):Int;
	public var FRAMEBUFFER_BINDING(get, never):Int;
	public var RENDERBUFFER_BINDING(get, never):Int;
	public var MAX_RENDERBUFFER_SIZE(get, never):Int;
	public var INVALID_FRAMEBUFFER_OPERATION(get, never):Int;
	public var READ_BUFFER(get, never):Int;
	public var UNPACK_ROW_LENGTH(get, never):Int;
	public var UNPACK_SKIP_ROWS(get, never):Int;
	public var UNPACK_SKIP_PIXELS(get, never):Int;
	public var PACK_ROW_LENGTH(get, never):Int;
	public var PACK_SKIP_ROWS(get, never):Int;
	public var PACK_SKIP_PIXELS(get, never):Int;
	public var TEXTURE_BINDING_3D(get, never):Int;
	public var UNPACK_SKIP_IMAGES(get, never):Int;
	public var UNPACK_IMAGE_HEIGHT(get, never):Int;
	public var MAX_3D_TEXTURE_SIZE(get, never):Int;
	public var MAX_ELEMENTS_VERTICES(get, never):Int;
	public var MAX_ELEMENTS_INDICES(get, never):Int;
	public var MAX_TEXTURE_LOD_BIAS(get, never):Int;
	public var MAX_FRAGMENT_UNIFORM_COMPONENTS(get, never):Int;
	public var MAX_VERTEX_UNIFORM_COMPONENTS(get, never):Int;
	public var MAX_ARRAY_TEXTURE_LAYERS(get, never):Int;
	public var MIN_PROGRAM_TEXEL_OFFSET(get, never):Int;
	public var MAX_PROGRAM_TEXEL_OFFSET(get, never):Int;
	public var MAX_VARYING_COMPONENTS(get, never):Int;
	public var FRAGMENT_SHADER_DERIVATIVE_HINT(get, never):Int;
	public var RASTERIZER_DISCARD(get, never):Int;
	public var VERTEX_ARRAY_BINDING(get, never):Int;
	public var MAX_VERTEX_OUTPUT_COMPONENTS(get, never):Int;
	public var MAX_FRAGMENT_INPUT_COMPONENTS(get, never):Int;
	public var MAX_SERVER_WAIT_TIMEOUT(get, never):Int;
	public var MAX_ELEMENT_INDEX(get, never):Int;
	public var RED(get, never):Int;
	public var RGB8(get, never):Int;
	public var RGBA8(get, never):Int;
	public var RGB10_A2(get, never):Int;
	public var TEXTURE_3D(get, never):Int;
	public var TEXTURE_WRAP_R(get, never):Int;
	public var TEXTURE_MIN_LOD(get, never):Int;
	public var TEXTURE_MAX_LOD(get, never):Int;
	public var TEXTURE_BASE_LEVEL(get, never):Int;
	public var TEXTURE_MAX_LEVEL(get, never):Int;
	public var TEXTURE_COMPARE_MODE(get, never):Int;
	public var TEXTURE_COMPARE_FUNC(get, never):Int;
	public var SRGB(get, never):Int;
	public var SRGB8(get, never):Int;
	public var SRGB8_ALPHA8(get, never):Int;
	public var COMPARE_REF_TO_TEXTURE(get, never):Int;
	public var RGBA32F(get, never):Int;
	public var RGB32F(get, never):Int;
	public var RGBA16F(get, never):Int;
	public var RGB16F(get, never):Int;
	public var TEXTURE_2D_ARRAY(get, never):Int;
	public var TEXTURE_BINDING_2D_ARRAY(get, never):Int;
	public var R11F_G11F_B10F(get, never):Int;
	public var RGB9_E5(get, never):Int;
	public var RGBA32UI(get, never):Int;
	public var RGB32UI(get, never):Int;
	public var RGBA16UI(get, never):Int;
	public var RGB16UI(get, never):Int;
	public var RGBA8UI(get, never):Int;
	public var RGB8UI(get, never):Int;
	public var RGBA32I(get, never):Int;
	public var RGB32I(get, never):Int;
	public var RGBA16I(get, never):Int;
	public var RGB16I(get, never):Int;
	public var RGBA8I(get, never):Int;
	public var RGB8I(get, never):Int;
	public var RED_INTEGER(get, never):Int;
	public var RGB_INTEGER(get, never):Int;
	public var RGBA_INTEGER(get, never):Int;
	public var R8(get, never):Int;
	public var RG8(get, never):Int;
	public var R16F(get, never):Int;
	public var R32F(get, never):Int;
	public var RG16F(get, never):Int;
	public var RG32F(get, never):Int;
	public var R8I(get, never):Int;
	public var R8UI(get, never):Int;
	public var R16I(get, never):Int;
	public var R16UI(get, never):Int;
	public var R32I(get, never):Int;
	public var R32UI(get, never):Int;
	public var RG8I(get, never):Int;
	public var RG8UI(get, never):Int;
	public var RG16I(get, never):Int;
	public var RG16UI(get, never):Int;
	public var RG32I(get, never):Int;
	public var RG32UI(get, never):Int;
	public var R8_SNORM(get, never):Int;
	public var RG8_SNORM(get, never):Int;
	public var RGB8_SNORM(get, never):Int;
	public var RGBA8_SNORM(get, never):Int;
	public var RGB10_A2UI(get, never):Int;
	public var TEXTURE_IMMUTABLE_FORMAT(get, never):Int;
	public var TEXTURE_IMMUTABLE_LEVELS(get, never):Int;
	public var UNSIGNED_INT_2_10_10_10_REV(get, never):Int;
	public var UNSIGNED_INT_10F_11F_11F_REV(get, never):Int;
	public var UNSIGNED_INT_5_9_9_9_REV(get, never):Int;
	public var FLOAT_32_UNSIGNED_INT_24_8_REV(get, never):Int;
	public var UNSIGNED_INT_24_8(get, never):Int;
	public var HALF_FLOAT(get, never):Int;
	public var RG(get, never):Int;
	public var RG_INTEGER(get, never):Int;
	public var INT_2_10_10_10_REV(get, never):Int;
	public var CURRENT_QUERY(get, never):Int;
	public var QUERY_RESULT(get, never):Int;
	public var QUERY_RESULT_AVAILABLE(get, never):Int;
	public var ANY_SAMPLES_PASSED(get, never):Int;
	public var ANY_SAMPLES_PASSED_CONSERVATIVE(get, never):Int;
	public var MAX_DRAW_BUFFERS(get, never):Int;
	public var DRAW_BUFFER0(get, never):Int;
	public var DRAW_BUFFER1(get, never):Int;
	public var DRAW_BUFFER2(get, never):Int;
	public var DRAW_BUFFER3(get, never):Int;
	public var DRAW_BUFFER4(get, never):Int;
	public var DRAW_BUFFER5(get, never):Int;
	public var DRAW_BUFFER6(get, never):Int;
	public var DRAW_BUFFER7(get, never):Int;
	public var DRAW_BUFFER8(get, never):Int;
	public var DRAW_BUFFER9(get, never):Int;
	public var DRAW_BUFFER10(get, never):Int;
	public var DRAW_BUFFER11(get, never):Int;
	public var DRAW_BUFFER12(get, never):Int;
	public var DRAW_BUFFER13(get, never):Int;
	public var DRAW_BUFFER14(get, never):Int;
	public var DRAW_BUFFER15(get, never):Int;
	public var MAX_COLOR_ATTACHMENTS(get, never):Int;
	public var COLOR_ATTACHMENT1(get, never):Int;
	public var COLOR_ATTACHMENT2(get, never):Int;
	public var COLOR_ATTACHMENT3(get, never):Int;
	public var COLOR_ATTACHMENT4(get, never):Int;
	public var COLOR_ATTACHMENT5(get, never):Int;
	public var COLOR_ATTACHMENT6(get, never):Int;
	public var COLOR_ATTACHMENT7(get, never):Int;
	public var COLOR_ATTACHMENT8(get, never):Int;
	public var COLOR_ATTACHMENT9(get, never):Int;
	public var COLOR_ATTACHMENT10(get, never):Int;
	public var COLOR_ATTACHMENT11(get, never):Int;
	public var COLOR_ATTACHMENT12(get, never):Int;
	public var COLOR_ATTACHMENT13(get, never):Int;
	public var COLOR_ATTACHMENT14(get, never):Int;
	public var COLOR_ATTACHMENT15(get, never):Int;
	public var SAMPLER_3D(get, never):Int;
	public var SAMPLER_2D_SHADOW(get, never):Int;
	public var SAMPLER_2D_ARRAY(get, never):Int;
	public var SAMPLER_2D_ARRAY_SHADOW(get, never):Int;
	public var SAMPLER_CUBE_SHADOW(get, never):Int;
	public var INT_SAMPLER_2D(get, never):Int;
	public var INT_SAMPLER_3D(get, never):Int;
	public var INT_SAMPLER_CUBE(get, never):Int;
	public var INT_SAMPLER_2D_ARRAY(get, never):Int;
	public var UNSIGNED_INT_SAMPLER_2D(get, never):Int;
	public var UNSIGNED_INT_SAMPLER_3D(get, never):Int;
	public var UNSIGNED_INT_SAMPLER_CUBE(get, never):Int;
	public var UNSIGNED_INT_SAMPLER_2D_ARRAY(get, never):Int;
	public var MAX_SAMPLES(get, never):Int;
	public var SAMPLER_BINDING(get, never):Int;
	public var PIXEL_PACK_BUFFER(get, never):Int;
	public var PIXEL_UNPACK_BUFFER(get, never):Int;
	public var PIXEL_PACK_BUFFER_BINDING(get, never):Int;
	public var PIXEL_UNPACK_BUFFER_BINDING(get, never):Int;
	public var COPY_READ_BUFFER(get, never):Int;
	public var COPY_WRITE_BUFFER(get, never):Int;
	public var COPY_READ_BUFFER_BINDING(get, never):Int;
	public var COPY_WRITE_BUFFER_BINDING(get, never):Int;
	public var FLOAT_MAT2x3 = 0x8B65;
	public var FLOAT_MAT2x4 = 0x8B66;
	public var FLOAT_MAT3x2 = 0x8B67;
	public var FLOAT_MAT3x4 = 0x8B68;
	public var FLOAT_MAT4x2 = 0x8B69;
	public var FLOAT_MAT4x3 = 0x8B6A;
	public var UNSIGNED_INT_VEC2(get, never):Int;
	public var UNSIGNED_INT_VEC3(get, never):Int;
	public var UNSIGNED_INT_VEC4(get, never):Int;
	public var UNSIGNED_NORMALIZED(get, never):Int;
	public var SIGNED_NORMALIZED(get, never):Int;
	public var VERTEX_ATTRIB_ARRAY_INTEGER(get, never):Int;
	public var VERTEX_ATTRIB_ARRAY_DIVISOR(get, never):Int;
	public var TRANSFORM_FEEDBACK_BUFFER_MODE(get, never):Int;
	public var MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS(get, never):Int;
	public var TRANSFORM_FEEDBACK_VARYINGS(get, never):Int;
	public var TRANSFORM_FEEDBACK_BUFFER_START(get, never):Int;
	public var TRANSFORM_FEEDBACK_BUFFER_SIZE(get, never):Int;
	public var TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN(get, never):Int;
	public var MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS(get, never):Int;
	public var MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS(get, never):Int;
	public var INTERLEAVED_ATTRIBS(get, never):Int;
	public var SEPARATE_ATTRIBS(get, never):Int;
	public var TRANSFORM_FEEDBACK_BUFFER(get, never):Int;
	public var TRANSFORM_FEEDBACK_BUFFER_BINDING(get, never):Int;
	public var TRANSFORM_FEEDBACK(get, never):Int;
	public var TRANSFORM_FEEDBACK_PAUSED(get, never):Int;
	public var TRANSFORM_FEEDBACK_ACTIVE(get, never):Int;
	public var TRANSFORM_FEEDBACK_BINDING(get, never):Int;
	public var FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING(get, never):Int;
	public var FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE(get, never):Int;
	public var FRAMEBUFFER_ATTACHMENT_RED_SIZE(get, never):Int;
	public var FRAMEBUFFER_ATTACHMENT_GREEN_SIZE(get, never):Int;
	public var FRAMEBUFFER_ATTACHMENT_BLUE_SIZE(get, never):Int;
	public var FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE(get, never):Int;
	public var FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE(get, never):Int;
	public var FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE(get, never):Int;
	public var FRAMEBUFFER_DEFAULT(get, never):Int;
	public var DEPTH24_STENCIL8(get, never):Int;
	public var DRAW_FRAMEBUFFER_BINDING(get, never):Int;
	public var READ_FRAMEBUFFER(get, never):Int;
	public var DRAW_FRAMEBUFFER(get, never):Int;
	public var READ_FRAMEBUFFER_BINDING(get, never):Int;
	public var RENDERBUFFER_SAMPLES(get, never):Int;
	public var FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER(get, never):Int;
	public var FRAMEBUFFER_INCOMPLETE_MULTISAMPLE(get, never):Int;
	public var UNIFORM_BUFFER(get, never):Int;
	public var UNIFORM_BUFFER_BINDING(get, never):Int;
	public var UNIFORM_BUFFER_START(get, never):Int;
	public var UNIFORM_BUFFER_SIZE(get, never):Int;
	public var MAX_VERTEX_UNIFORM_BLOCKS(get, never):Int;
	public var MAX_FRAGMENT_UNIFORM_BLOCKS(get, never):Int;
	public var MAX_COMBINED_UNIFORM_BLOCKS(get, never):Int;
	public var MAX_UNIFORM_BUFFER_BINDINGS(get, never):Int;
	public var MAX_UNIFORM_BLOCK_SIZE(get, never):Int;
	public var MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS(get, never):Int;
	public var MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS(get, never):Int;
	public var UNIFORM_BUFFER_OFFSET_ALIGNMENT(get, never):Int;
	public var ACTIVE_UNIFORM_BLOCKS(get, never):Int;
	public var UNIFORM_TYPE(get, never):Int;
	public var UNIFORM_SIZE(get, never):Int;
	public var UNIFORM_BLOCK_INDEX(get, never):Int;
	public var UNIFORM_OFFSET(get, never):Int;
	public var UNIFORM_ARRAY_STRIDE(get, never):Int;
	public var UNIFORM_MATRIX_STRIDE(get, never):Int;
	public var UNIFORM_IS_ROW_MAJOR(get, never):Int;
	public var UNIFORM_BLOCK_BINDING(get, never):Int;
	public var UNIFORM_BLOCK_DATA_SIZE(get, never):Int;
	public var UNIFORM_BLOCK_ACTIVE_UNIFORMS(get, never):Int;
	public var UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES(get, never):Int;
	public var UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER(get, never):Int;
	public var UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER(get, never):Int;
	public var OBJECT_TYPE(get, never):Int;
	public var SYNC_CONDITION(get, never):Int;
	public var SYNC_STATUS(get, never):Int;
	public var SYNC_FLAGS(get, never):Int;
	public var SYNC_FENCE(get, never):Int;
	public var SYNC_GPU_COMMANDS_COMPLETE(get, never):Int;
	public var UNSIGNALED(get, never):Int;
	public var SIGNALED(get, never):Int;
	public var ALREADY_SIGNALED(get, never):Int;
	public var TIMEOUT_EXPIRED(get, never):Int;
	public var CONDITION_SATISFIED(get, never):Int;
	public var WAIT_FAILED(get, never):Int;
	public var SYNC_FLUSH_COMMANDS_BIT(get, never):Int;
	public var COLOR(get, never):Int;
	public var DEPTH(get, never):Int;
	public var STENCIL(get, never):Int;
	public var MIN(get, never):Int;
	public var MAX(get, never):Int;
	public var DEPTH_COMPONENT24(get, never):Int;
	public var STREAM_READ(get, never):Int;
	public var STREAM_COPY(get, never):Int;
	public var STATIC_READ(get, never):Int;
	public var STATIC_COPY(get, never):Int;
	public var DYNAMIC_READ(get, never):Int;
	public var DYNAMIC_COPY(get, never):Int;
	public var DEPTH_COMPONENT32F(get, never):Int;
	public var DEPTH32F_STENCIL8(get, never):Int;
	public var INVALID_INDEX(get, never):Int;
	public var TIMEOUT_IGNORED(get, never):Int;

	// Modern OpenGL / OpenGL ES enums (compute, SSBOs, memory barriers, program interface
	// query, separable programs, vertex attrib bindings, multisample textures, KHR_debug,
	// buffer storage and clip control).
	public var COMPUTE_SHADER(get, never):Int;
	public var MAX_COMPUTE_WORK_GROUP_COUNT(get, never):Int;
	public var MAX_COMPUTE_WORK_GROUP_SIZE(get, never):Int;
	public var MAX_COMPUTE_WORK_GROUP_INVOCATIONS(get, never):Int;
	public var COMPUTE_WORK_GROUP_SIZE(get, never):Int;
	public var DISPATCH_INDIRECT_BUFFER(get, never):Int;
	public var DISPATCH_INDIRECT_BUFFER_BINDING(get, never):Int;
	public var DRAW_INDIRECT_BUFFER(get, never):Int;
	public var DRAW_INDIRECT_BUFFER_BINDING(get, never):Int;
	public var SHADER_STORAGE_BUFFER(get, never):Int;
	public var SHADER_STORAGE_BUFFER_BINDING(get, never):Int;
	public var SHADER_STORAGE_BUFFER_START(get, never):Int;
	public var SHADER_STORAGE_BUFFER_SIZE(get, never):Int;
	public var MAX_SHADER_STORAGE_BLOCK_SIZE(get, never):Int;
	public var MAX_SHADER_STORAGE_BUFFER_BINDINGS(get, never):Int;
	public var SHADER_STORAGE_BARRIER_BIT(get, never):Int;
	public var VERTEX_ATTRIB_ARRAY_BARRIER_BIT(get, never):Int;
	public var ELEMENT_ARRAY_BARRIER_BIT(get, never):Int;
	public var UNIFORM_BARRIER_BIT(get, never):Int;
	public var TEXTURE_FETCH_BARRIER_BIT(get, never):Int;
	public var SHADER_IMAGE_ACCESS_BARRIER_BIT(get, never):Int;
	public var COMMAND_BARRIER_BIT(get, never):Int;
	public var PIXEL_BUFFER_BARRIER_BIT(get, never):Int;
	public var TEXTURE_UPDATE_BARRIER_BIT(get, never):Int;
	public var BUFFER_UPDATE_BARRIER_BIT(get, never):Int;
	public var FRAMEBUFFER_BARRIER_BIT(get, never):Int;
	public var TRANSFORM_FEEDBACK_BARRIER_BIT(get, never):Int;
	public var ATOMIC_COUNTER_BARRIER_BIT(get, never):Int;
	public var ALL_BARRIER_BITS(get, never):Int;
	public var ATOMIC_COUNTER_BUFFER(get, never):Int;
	public var READ_ONLY(get, never):Int;
	public var WRITE_ONLY(get, never):Int;
	public var READ_WRITE(get, never):Int;
	public var IMAGE_2D(get, never):Int;
	public var MAX_IMAGE_UNITS(get, never):Int;
	public var UNIFORM(get, never):Int;
	public var UNIFORM_BLOCK(get, never):Int;
	public var PROGRAM_INPUT(get, never):Int;
	public var PROGRAM_OUTPUT(get, never):Int;
	public var BUFFER_VARIABLE(get, never):Int;
	public var SHADER_STORAGE_BLOCK(get, never):Int;
	public var ACTIVE_RESOURCES(get, never):Int;
	public var MAX_NAME_LENGTH(get, never):Int;
	public var MAX_NUM_ACTIVE_VARIABLES(get, never):Int;
	public var NAME_LENGTH(get, never):Int;
	public var TYPE(get, never):Int;
	public var ARRAY_SIZE(get, never):Int;
	public var OFFSET(get, never):Int;
	public var BLOCK_INDEX(get, never):Int;
	public var LOCATION(get, never):Int;
	public var VERTEX_SHADER_BIT(get, never):Int;
	public var FRAGMENT_SHADER_BIT(get, never):Int;
	public var COMPUTE_SHADER_BIT(get, never):Int;
	public var ALL_SHADER_BITS(get, never):Int;
	public var PROGRAM_SEPARABLE(get, never):Int;
	public var ACTIVE_PROGRAM(get, never):Int;
	public var PROGRAM_PIPELINE_BINDING(get, never):Int;
	public var VERTEX_ATTRIB_BINDING(get, never):Int;
	public var VERTEX_ATTRIB_RELATIVE_OFFSET(get, never):Int;
	public var VERTEX_BINDING_DIVISOR(get, never):Int;
	public var VERTEX_BINDING_OFFSET(get, never):Int;
	public var VERTEX_BINDING_STRIDE(get, never):Int;
	public var VERTEX_BINDING_BUFFER(get, never):Int;
	public var MAX_VERTEX_ATTRIB_BINDINGS(get, never):Int;
	public var MAX_VERTEX_ATTRIB_STRIDE(get, never):Int;
	public var TEXTURE_2D_MULTISAMPLE(get, never):Int;
	public var TEXTURE_2D_MULTISAMPLE_ARRAY(get, never):Int;
	public var SAMPLE_POSITION(get, never):Int;
	public var SAMPLE_MASK(get, never):Int;
	public var MAX_SAMPLE_MASK_WORDS(get, never):Int;
	public var MAX_COLOR_TEXTURE_SAMPLES(get, never):Int;
	public var MAX_DEPTH_TEXTURE_SAMPLES(get, never):Int;
	public var FRAMEBUFFER_DEFAULT_WIDTH(get, never):Int;
	public var FRAMEBUFFER_DEFAULT_HEIGHT(get, never):Int;
	public var FRAMEBUFFER_DEFAULT_SAMPLES(get, never):Int;
	public var TEXTURE_BUFFER(get, never):Int;
	public var TEXTURE_BUFFER_BINDING(get, never):Int;
	public var TEXTURE_BUFFER_OFFSET(get, never):Int;
	public var TEXTURE_BUFFER_SIZE(get, never):Int;
	public var PATCHES(get, never):Int;
	public var PATCH_VERTICES(get, never):Int;
	public var MIN_SAMPLE_SHADING_VALUE(get, never):Int;
	public var SAMPLE_SHADING(get, never):Int;
	public var DEBUG_OUTPUT(get, never):Int;
	public var DEBUG_OUTPUT_SYNCHRONOUS(get, never):Int;
	public var DEBUG_SOURCE_APPLICATION(get, never):Int;
	public var DEBUG_SOURCE_THIRD_PARTY(get, never):Int;
	public var DEBUG_TYPE_ERROR(get, never):Int;
	public var DEBUG_TYPE_PERFORMANCE(get, never):Int;
	public var DEBUG_TYPE_MARKER(get, never):Int;
	public var DEBUG_TYPE_PUSH_GROUP(get, never):Int;
	public var DEBUG_TYPE_POP_GROUP(get, never):Int;
	public var DEBUG_SEVERITY_HIGH(get, never):Int;
	public var DEBUG_SEVERITY_MEDIUM(get, never):Int;
	public var DEBUG_SEVERITY_LOW(get, never):Int;
	public var DEBUG_SEVERITY_NOTIFICATION(get, never):Int;
	public var MAX_DEBUG_MESSAGE_LENGTH(get, never):Int;
	public var MAX_LABEL_LENGTH(get, never):Int;
	public var BUFFER_OBJECT(get, never):Int;
	public var SHADER_OBJECT(get, never):Int;
	public var PROGRAM_OBJECT(get, never):Int;
	public var QUERY_OBJECT(get, never):Int;
	public var MAP_PERSISTENT_BIT(get, never):Int;
	public var MAP_COHERENT_BIT(get, never):Int;
	public var DYNAMIC_STORAGE_BIT(get, never):Int;
	public var CLIENT_STORAGE_BIT(get, never):Int;
	public var LOWER_LEFT(get, never):Int;
	public var UPPER_LEFT(get, never):Int;
	public var NEGATIVE_ONE_TO_ONE(get, never):Int;
	public var ZERO_TO_ONE(get, never):Int;
	public var FILL(get, never):Int;
	public var LINE(get, never):Int;
	public var POINT(get, never):Int;

	public var type(default, null):RenderContextType;
	public var version(default, null):Float;

	private var __arrayBufferBinding:GLBuffer;
	private var __elementBufferBinding:GLBuffer;
	private var __contextID:Int;
	private var __currentProgram:GLProgram;
	private var __framebufferBinding:GLFramebuffer;
	private var __initialized:Bool;
	private var __isContextLost:Bool;
	private var __renderbufferBinding:GLRenderbuffer;
	private var __texture2DBinding:GLTexture;
	private var __textureCubeMapBinding:GLTexture;
	private static inline var __TEXTURE_UNIT_CACHE_SIZE:Int = 32;
	private var __activeTextureUnit:Int = 0x84C0; // GL_TEXTURE0
	private var __textureUnitBindings:haxe.ds.Vector<Int> = __newTextureUnitBindings();
	private var __blendSFactor:Int = -1;
	private var __blendDFactor:Int = -1;
	private var __blendSFactorRGB:Int = -1;
	private var __blendDFactorRGB:Int = -1;
	private var __blendSFactorAlpha:Int = -1;
	private var __blendDFactorAlpha:Int = -1;
	private var __capEnabledMask:Int = 0;
	private var __capKnownMask:Int = 0;
	private var __lastArrayBufferID:Int = -1;
	private var __lastElementBufferID:Int = -1;
	private var __lastDrawFramebufferID:Int = -1;
	private var __lastReadFramebufferID:Int = -1;
	private var __lastProgramID:Int = -1;

	private function new()
	{
		__contextID = __lastContextID++;

		__initialize();

		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		var versionString:String = getParameter(VERSION);
		if (versionString.indexOf("OpenGL ES") > -1)
		{
			type = OPENGLES;
		}
		else
		{
			type = OPENGL;
		}
		var ereg = ~/[0-9]+[.]?[0-9]?/i;
		if (ereg.match(versionString))
		{
			version = Std.parseFloat(ereg.matched(0));
		}
		else
		{
			version = 2;
		}
		#else
		type = OPENGL;
		version = 2;
		#end
	}

	public function activeTexture(texture:Int):Void
	{
		if (__activeTextureUnit == texture)
			return;
		__activeTextureUnit = texture;

		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_active_texture(texture);
		#end
	}

	public function attachShader(program:GLProgram, shader:GLShader):Void
	{
		if (program != null && shader != null)
		{
			if (program.refs == null)
			{
				program.refs = [shader];
			}
			else if (program.refs.indexOf(shader) == -1)
			{
				program.refs.push(shader);
			}
		}

		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_attach_shader(__getObjectID(program), __getObjectID(shader));
		#end
	}

	public function beginQuery(target:Int, query:GLQuery):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_begin_query(target, __getObjectID(query));
		#end
	}

	public function beginTransformFeedback(primitiveNode:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_begin_transform_feedback(primitiveNode);
		#end
	}

	public function bindAttribLocation(program:GLProgram, index:Int, name:String):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_bind_attrib_location(__getObjectID(program), index, name);
		#end
	}

	public function bindBuffer(target:Int, buffer:GLBuffer):Void
	{
		var id = __getObjectID(buffer);

		if (target == ARRAY_BUFFER)
		{
			if (__lastArrayBufferID == id)
				return;
			__lastArrayBufferID = id;
			__arrayBufferBinding = buffer;
		}
		else if (target == ELEMENT_ARRAY_BUFFER)
		{
			if (__lastElementBufferID == id)
				return;
			__lastElementBufferID = id;
			__elementBufferBinding = buffer;
		}

		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_bind_buffer(target, id);
		#end
	}

	public function bindBufferBase(target:Int, index:Int, buffer:GLBuffer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_bind_buffer_base(target, index, __getObjectID(buffer));
		#end
	}

	public function bindBufferRange(target:Int, index:Int, buffer:GLBuffer, offset:DataPointer, size:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_bind_buffer_range(target, index, __getObjectID(buffer), offset, size);
		#end
	}

	public function bindFramebuffer(target:Int, framebuffer:GLFramebuffer):Void
	{
		var id = __getObjectID(framebuffer);

		switch (target)
		{
			case 0x8CA9: // DRAW_FRAMEBUFFER
				if (__lastDrawFramebufferID == id)
					return;
				__lastDrawFramebufferID = id;

			case 0x8CA8: // READ_FRAMEBUFFER
				if (__lastReadFramebufferID == id)
					return;
				__lastReadFramebufferID = id;

			default:
				if (__lastDrawFramebufferID == id && __lastReadFramebufferID == id)
					return;
				__lastDrawFramebufferID = id;
				__lastReadFramebufferID = id;
		}

		__framebufferBinding = framebuffer;

		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_bind_framebuffer(target, id);
		#end
	}

	public function bindRenderbuffer(target:Int, renderbuffer:GLRenderbuffer):Void
	{
		__renderbufferBinding = renderbuffer;

		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_bind_renderbuffer(target, __getObjectID(renderbuffer));
		#end
	}

	public function bindSampler(unit:Int, sampler:GLSampler):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_bind_sampler(unit, __getObjectID(sampler));
		#end
	}

	public function bindTexture(target:Int, texture:GLTexture):Void
	{
		var id = __getObjectID(texture);

		if (target == TEXTURE_2D)
			__texture2DBinding = texture;
		if (target == TEXTURE_CUBE_MAP)
			__textureCubeMapBinding = texture;

		var index = __textureCacheIndex(target);

		if (index != -1)
		{
			if (__textureUnitBindings[index] == id)
				return;
			__textureUnitBindings[index] = id;
		}

		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_bind_texture(target, id);
		#end
	}

	public function bindTransformFeedback(target:Int, transformFeedback:GLTransformFeedback):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_bind_transform_feedback(target, __getObjectID(transformFeedback));
		#end
	}

	public function bindVertexArray(vertexArray:GLVertexArrayObject):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_bind_vertex_array(__getObjectID(vertexArray));
		#end
	}

	public function blendColor(red:Float, green:Float, blue:Float, alpha:Float):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_blend_color(red, green, blue, alpha);
		#end
	}

	public function blendEquation(mode:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_blend_equation(mode);
		#end
	}

	public function blendEquationSeparate(modeRGB:Int, modeAlpha:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_blend_equation_separate(modeRGB, modeAlpha);
		#end
	}

	public function blendFunc(sfactor:Int, dfactor:Int):Void
	{
		if (__blendSFactor == sfactor && __blendDFactor == dfactor && __blendSFactorRGB == sfactor && __blendDFactorRGB == dfactor
			&& __blendSFactorAlpha == sfactor && __blendDFactorAlpha == dfactor)
			return;

		__blendSFactor = __blendSFactorRGB = __blendSFactorAlpha = sfactor;
		__blendDFactor = __blendDFactorRGB = __blendDFactorAlpha = dfactor;

		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_blend_func(sfactor, dfactor);
		#end
	}

	public function blendFuncSeparate(srcRGB:Int, dstRGB:Int, srcAlpha:Int, dstAlpha:Int):Void
	{
		if (__blendSFactorRGB == srcRGB && __blendDFactorRGB == dstRGB && __blendSFactorAlpha == srcAlpha && __blendDFactorAlpha == dstAlpha)
			return;

		__blendSFactorRGB = srcRGB;
		__blendDFactorRGB = dstRGB;
		__blendSFactorAlpha = srcAlpha;
		__blendDFactorAlpha = dstAlpha;
		__blendSFactor = -1; // no longer a single uniform state
		__blendDFactor = -1;

		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_blend_func_separate(srcRGB, dstRGB, srcAlpha, dstAlpha);
		#end
	}

	public function blendBarrier():Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_blend_barrier();
		#end
	}

	public function blitFramebuffer(srcX0:Int, srcY0:Int, srcX1:Int, srcY1:Int, dstX0:Int, dstY0:Int, dstX1:Int, dstY1:Int, mask:Int, filter:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_blit_framebuffer(srcX0, srcY0, srcX1, srcY1, dstX0, dstY0, dstX1, dstY1, mask, filter);
		#end
	}

	public function bufferData(target:Int, size:Int, srcData:DataPointer, usage:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_buffer_data(target, size, srcData, usage);
		#end
	}

	public function bufferSubData(target:Int, dstByteOffset:Int, size:Int, srcData:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_buffer_sub_data(target, dstByteOffset, size, srcData);
		#end
	}

	public function checkFramebufferStatus(target:Int):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_check_framebuffer_status(target);
		#else
		return 0;
		#end
	}

	public function clear(mask:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_clear(mask);
		#end
	}

	public function clearBufferfi(buffer:Int, drawbuffer:Int, depth:Float, stencil:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_clear_bufferfi(buffer, drawbuffer, depth, stencil);
		#end
	}

	public function clearBufferfv(buffer:Int, drawbuffer:Int, value:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_clear_bufferfv(buffer, drawbuffer, value);
		#end
	}

	public function clearBufferiv(buffer:Int, drawbuffer:Int, value:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_clear_bufferiv(buffer, drawbuffer, value);
		#end
	}

	public function clearBufferuiv(buffer:Int, drawbuffer:Int, value:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_clear_bufferuiv(buffer, drawbuffer, value);
		#end
	}

	public function clearColor(red:Float, green:Float, blue:Float, alpha:Float):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_clear_color(red, green, blue, alpha);
		#end
	}

	public function clearDepthf(depth:Float):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_clear_depthf(depth);
		#end
	}

	public function clearStencil(s:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_clear_stencil(s);
		#end
	}

	public function clientWaitSync(sync:GLSync, flags:Int, timeout:Int64):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_client_wait_sync(sync, flags, timeout.high, timeout.low);
		#else
		return 0;
		#end
	}

	public function colorMask(red:Bool, green:Bool, blue:Bool, alpha:Bool):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_color_mask(red, green, blue, alpha);
		#end
	}

	public function compileShader(shader:GLShader):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_compile_shader(__getObjectID(shader));
		#end
	}

	public function compressedTexImage2D(target:Int, level:Int, internalformat:Int, width:Int, height:Int, border:Int, imageSize:Int, data:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_compressed_tex_image_2d(target, level, internalformat, width, height, border, imageSize, data);
		#end
	}

	public function compressedTexImage3D(target:Int, level:Int, internalformat:Int, width:Int, height:Int, depth:Int, border:Int, imageSize:Int,
			data:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_compressed_tex_image_3d(target, level, internalformat, width, height, depth, border, imageSize, data);
		#end
	}

	public function compressedTexSubImage2D(target:Int, level:Int, xoffset:Int, yoffset:Int, width:Int, height:Int, format:Int, imageSize:Int,
			data:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_compressed_tex_sub_image_2d(target, level, xoffset, yoffset, width, height, format, imageSize, data);
		#end
	}

	public function compressedTexSubImage3D(target:Int, level:Int, xoffset:Int, yoffset:Int, zoffset:Int, width:Int, height:Int, depth:Int, format:Int,
			imageSize:Int, data:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_compressed_tex_sub_image_3d(target, level, xoffset, yoffset, zoffset, width, height, depth, format, imageSize, data);
		#end
	}

	public function copyBufferSubData(readTarget:Int, writeTarget:Int, readOffset:DataPointer, writeOffset:DataPointer, size:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_copy_buffer_sub_data(readTarget, writeTarget, readOffset, writeOffset, size);
		#end
	}

	public function copyTexImage2D(target:Int, level:Int, internalformat:Int, x:Int, y:Int, width:Int, height:Int, border:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_copy_tex_image_2d(target, level, internalformat, x, y, width, height, border);
		#end
	}

	public function copyTexSubImage2D(target:Int, level:Int, xoffset:Int, yoffset:Int, x:Int, y:Int, width:Int, height:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_copy_tex_sub_image_2d(target, level, xoffset, yoffset, x, y, width, height);
		#end
	}

	public function copyTexSubImage3D(target:Int, level:Int, xoffset:Int, yoffset:Int, zoffset:Int, x:Int, y:Int, width:Int, height:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_copy_tex_sub_image_3d(target, level, xoffset, yoffset, zoffset, x, y, width, height);
		#end
	}

	public function createBuffer():GLBuffer
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		var id = NativeCFFI.lime_gl_create_buffer();
		if (id == 0)
			return null;
		var object = new GLObject(id);
		object.ptr = NativeCFFI.lime_gl_object_register(id, GLObjectType.BUFFER, object);
		return object;
		#else
		return null;
		#end
	}

	public function createFramebuffer():GLFramebuffer
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		var id = NativeCFFI.lime_gl_create_framebuffer();
		if (id == 0)
			return null;
		var object = new GLObject(id);
		object.ptr = NativeCFFI.lime_gl_object_register(id, GLObjectType.FRAMEBUFFER, object);
		return object;
		#else
		return null;
		#end
	}

	public function createProgram():GLProgram
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		var id = NativeCFFI.lime_gl_create_program();
		if (id == 0)
			return null;
		var object = new GLObject(id);
		object.ptr = NativeCFFI.lime_gl_object_register(id, GLObjectType.PROGRAM, object);
		return object;
		#else
		return null;
		#end
	}

	public function createQuery():GLQuery
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		var id = NativeCFFI.lime_gl_create_query();
		if (id == 0)
			return null;
		var object = new GLObject(id);
		object.ptr = NativeCFFI.lime_gl_object_register(id, GLObjectType.QUERY, object);
		return object;
		#else
		return null;
		#end
	}

	public function createRenderbuffer():GLRenderbuffer
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		var id = NativeCFFI.lime_gl_create_renderbuffer();
		if (id == 0)
			return null;
		var object = new GLObject(id);
		object.ptr = NativeCFFI.lime_gl_object_register(id, GLObjectType.RENDERBUFFER, object);
		return object;
		#else
		return null;
		#end
	}

	public function createSampler():GLSampler
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		var id = NativeCFFI.lime_gl_create_sampler();
		if (id == 0)
			return null;
		var object = new GLObject(id);
		object.ptr = NativeCFFI.lime_gl_object_register(id, GLObjectType.SAMPLER, object);
		return object;
		#else
		return null;
		#end
	}

	public function createShader(type:Int):GLShader
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		var id = NativeCFFI.lime_gl_create_shader(type);
		if (id == 0)
			return null;
		var object = new GLObject(id);
		object.ptr = NativeCFFI.lime_gl_object_register(id, GLObjectType.SHADER, object);
		return object;
		#else
		return null;
		#end
	}

	public function createTexture():GLTexture
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		var id = NativeCFFI.lime_gl_create_texture();
		if (id == 0)
			return null;
		var object = new GLObject(id);
		object.ptr = NativeCFFI.lime_gl_object_register(id, GLObjectType.TEXTURE, object);
		return object;
		#else
		return null;
		#end
	}

	public function createTransformFeedback():GLTransformFeedback
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		var id = NativeCFFI.lime_gl_create_transform_feedback();
		if (id == 0)
			return null;
		var object = new GLObject(id);
		object.ptr = NativeCFFI.lime_gl_object_register(id, GLObjectType.TRANSFORM_FEEDBACK, object);
		return object;
		#else
		return null;
		#end
	}

	public function createVertexArray():GLVertexArrayObject
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		var id = NativeCFFI.lime_gl_create_vertex_array();
		if (id == 0)
			return null;
		var object = new GLObject(id);
		object.ptr = NativeCFFI.lime_gl_object_register(id, GLObjectType.VERTEX_ARRAY_OBJECT, object);
		return object;
		#else
		return null;
		#end
	}

	public function cullFace(mode:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_cull_face(mode);
		#end
	}

	public function deleteBuffer(buffer:GLBuffer):Void
	{
		__lastArrayBufferID = -1;
		__lastElementBufferID = -1;

		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		if (buffer != null)
			NativeCFFI.lime_gl_object_deregister(buffer);
		NativeCFFI.lime_gl_delete_buffer(__getObjectID(buffer));
		#end
	}

	public function deleteFramebuffer(framebuffer:GLFramebuffer):Void
	{
		__lastDrawFramebufferID = -1;
		__lastReadFramebufferID = -1;

		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		if (framebuffer != null)
			NativeCFFI.lime_gl_object_deregister(framebuffer);
		NativeCFFI.lime_gl_delete_framebuffer(__getObjectID(framebuffer));
		#end
	}

	public function deleteProgram(program:GLProgram):Void
	{
		__lastProgramID = -1;

		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		if (program != null)
			NativeCFFI.lime_gl_object_deregister(program);
		NativeCFFI.lime_gl_delete_program(__getObjectID(program));
		#end
	}

	public function deleteQuery(query:GLQuery):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		if (query != null)
			NativeCFFI.lime_gl_object_deregister(query);
		NativeCFFI.lime_gl_delete_query(__getObjectID(query));
		#end
	}

	public function deleteRenderbuffer(renderbuffer:GLRenderbuffer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		if (renderbuffer != null)
			NativeCFFI.lime_gl_object_deregister(renderbuffer);
		NativeCFFI.lime_gl_delete_renderbuffer(__getObjectID(renderbuffer));
		#end
	}

	public function deleteSampler(sampler:GLSampler):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		if (sampler != null)
			NativeCFFI.lime_gl_object_deregister(sampler);
		NativeCFFI.lime_gl_delete_sampler(__getObjectID(sampler));
		#end
	}

	public function deleteShader(shader:GLShader):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		if (shader != null)
			NativeCFFI.lime_gl_object_deregister(shader);
		NativeCFFI.lime_gl_delete_shader(__getObjectID(shader));
		#end
	}

	public function deleteSync(sync:GLSync):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_delete_sync(sync);
		#end
	}

	public function deleteTexture(texture:GLTexture):Void
	{
		__resetTextureUnitBindings();

		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		if (texture != null)
			NativeCFFI.lime_gl_object_deregister(texture);
		NativeCFFI.lime_gl_delete_texture(__getObjectID(texture));
		#end
	}

	public function deleteTransformFeedback(transformFeedback:GLTransformFeedback):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		if (transformFeedback != null)
			NativeCFFI.lime_gl_object_deregister(transformFeedback);
		NativeCFFI.lime_gl_delete_transform_feedback(__getObjectID(transformFeedback));
		#end
	}

	public function deleteVertexArray(vertexArray:GLVertexArrayObject):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		if (vertexArray != null)
			NativeCFFI.lime_gl_object_deregister(vertexArray);
		NativeCFFI.lime_gl_delete_vertex_array(__getObjectID(vertexArray));
		#end
	}

	public function depthFunc(func:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_depth_func(func);
		#end
	}

	public function depthMask(flag:Bool):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_depth_mask(flag);
		#end
	}

	public function depthRangef(zNear:Float, zFar:Float):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_depth_rangef(zNear, zFar);
		#end
	}

	public function detachShader(program:GLProgram, shader:GLShader):Void
	{
		if (program != null && program.refs != null)
		{
			program.refs.remove(shader);
		}

		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_detach_shader(__getObjectID(program), __getObjectID(shader));
		#end
	}

	public function disable(cap:Int):Void
	{
		var bit = __capCacheBit(cap);

		if (bit != 0)
		{
			if ((__capKnownMask & bit) != 0 && (__capEnabledMask & bit) == 0)
				return;
			__capKnownMask |= bit;
			__capEnabledMask &= ~bit;
		}

		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_disable(cap);
		#end
	}

	public function disableVertexAttribArray(index:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_disable_vertex_attrib_array(index);
		#end
	}

	public function drawArrays(mode:Int, first:Int, count:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_draw_arrays(mode, first, count);
		#end
	}

	public function drawArraysInstanced(mode:Int, first:Int, count:Int, instanceCount:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_draw_arrays_instanced(mode, first, count, instanceCount);
		#end
	}

	public function drawBuffers(buffers:Array<Int>):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_draw_buffers(buffers);
		#end
	}

	public function drawElements(mode:Int, count:Int, type:Int, offset:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_draw_elements(mode, count, type, offset);
		#end
	}

	public function drawElementsInstanced(mode:Int, count:Int, type:Int, offset:DataPointer, instanceCount:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_draw_elements_instanced(mode, count, type, offset, instanceCount);
		#end
	}

	public function drawRangeElements(mode:Int, start:Int, end:Int, count:Int, type:Int, offset:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_draw_range_elements(mode, start, end, count, type, offset);
		#end
	}

	public function enable(cap:Int):Void
	{
		var bit = __capCacheBit(cap);

		if (bit != 0)
		{
			if ((__capKnownMask & bit) != 0 && (__capEnabledMask & bit) != 0)
				return;
			__capKnownMask |= bit;
			__capEnabledMask |= bit;
		}

		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_enable(cap);
		#end
	}

	public function enableVertexAttribArray(index:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_enable_vertex_attrib_array(index);
		#end
	}

	public function endQuery(target:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_end_query(target);
		#end
	}

	public function endTransformFeedback():Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_end_transform_feedback();
		#end
	}

	public function fenceSync(condition:Int, flags:Int):GLSync
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_fence_sync(condition, flags);
		#else
		return null;
		#end
	}

	public function finish():Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_finish();
		#end
	}

	public function flush():Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_flush();
		#end
	}

	public function framebufferRenderbuffer(target:Int, attachment:Int, renderbuffertarget:Int, renderbuffer:GLRenderbuffer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_framebuffer_renderbuffer(target, attachment, renderbuffertarget, __getObjectID(renderbuffer));
		#end
	}

	public function framebufferTexture2D(target:Int, attachment:Int, textarget:Int, texture:GLTexture, level:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_framebuffer_texture2D(target, attachment, textarget, __getObjectID(texture), level);
		#end
	}

	public function framebufferTextureLayer(target:Int, attachment:Int, texture:GLTexture, level:Int, layer:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_framebuffer_texture_layer(target, attachment, __getObjectID(texture), level, layer);
		#end
	}

	public function frontFace(mode:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_front_face(mode);
		#end
	}

	public function generateMipmap(target:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_generate_mipmap(target);
		#end
	}

	public function getActiveAttrib(program:GLProgram, index:Int):GLActiveInfo
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_active_attrib(__getObjectID(program), index);
		#else
		return null;
		#end
	}

	public function getActiveUniform(program:GLProgram, index:Int):GLActiveInfo
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_active_uniform(__getObjectID(program), index);
		#else
		return null;
		#end
	}

	public function getActiveUniformBlocki(program:GLProgram, uniformBlockIndex:Int, pname:Int):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_active_uniform_blocki(__getObjectID(program), uniformBlockIndex, pname);
		#else
		return 0;
		#end
	}

	public function getActiveUniformBlockiv(program:GLProgram, uniformBlockIndex:Int, pname:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_active_uniform_blockiv(__getObjectID(program), uniformBlockIndex, pname, params);
		#end
	}

	public function getActiveUniformBlockName(program:GLProgram, uniformBlockIndex:Int):String
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_active_uniform_block_name(__getObjectID(program), uniformBlockIndex);
		#else
		return null;
		#end
	}

	public function getActiveUniformBlockParameter(program:GLProgram, uniformBlockIndex:Int, pname:Int):Dynamic
	{
		return switch (pname)
		{
			case GL.UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER, GL.UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER:
				getActiveUniformBlocki(program, uniformBlockIndex, pname) != 0;

			case GL.UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES:
				var count = getActiveUniformBlocki(program, uniformBlockIndex, UNIFORM_BLOCK_ACTIVE_UNIFORMS);

				if (count <= 0)
				{
					new Int32Array(0);
				}
				else
				{
					var indices = new Int32Array(count);
					getActiveUniformBlockiv(program, uniformBlockIndex, pname, indices);
					indices;
				}

			default:
				getActiveUniformBlocki(program, uniformBlockIndex, pname);
		}
	}

	public function getActiveUniforms(program:GLProgram, uniformIndices:Array<Int>, pname:Int):Dynamic
	{
		// TODO

		return null;
	}

	public function getActiveUniformsiv(program:GLProgram, uniformIndices:Array<Int>, pname:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_active_uniformsiv(__getObjectID(program), uniformIndices, pname, params);
		#end
	}

	public function getAttachedShaders(program:GLProgram):Array<GLShader>
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_attached_shaders(__getObjectID(program));
		#else
		return null;
		#end
	}

	public function getAttribLocation(program:GLProgram, name:String):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_attrib_location(__getObjectID(program), name);
		#else
		return 0;
		#end
	}

	public function getBoolean(pname:Int):Bool
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_boolean(pname);
		#else
		return false;
		#end
	}

	public function getBooleanv(pname:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_booleanv(pname, params);
		#end
	}

	public function getBufferParameter(target:Int, pname:Int):Dynamic
	{
		return getBufferParameteri(target, pname);
	}

	public function getBufferParameteri(target:Int, pname:Int):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_buffer_parameteri(target, pname);
		#else
		return 0;
		#end
	}

	public function getBufferParameteri64v(target:Int, pname:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_buffer_parameteri64v(target, pname, params);
		#end
	}

	public function getBufferParameteriv(target:Int, pname:Int, data:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_buffer_parameteriv(target, pname, data);
		#end
	}

	public function getBufferPointerv(target:Int, pname:Int):DataPointer
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_buffer_pointerv(target, pname);
		#else
		return 0;
		#end
	}

	public function getBufferSubData(target:Int, offset:DataPointer, size:Int, data:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_buffer_sub_data(target, offset, size, data);
		#end
	}

	public function getContextAttributes():GLContextAttributes
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		var base:Dynamic = NativeCFFI.lime_gl_get_context_attributes();
		base.premultipliedAlpha = false;
		base.preserveDrawingBuffer = false;
		return base;
		#else
		return null;
		#end
	}

	public function getError():Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_error();
		#else
		return 0;
		#end
	}

	public function getExtension(name:String):Dynamic
	{
		if (__extensionObjects == null)
		{
			__extensionObjects = new Map();
			var supportedExtensions = getSupportedExtensions();

			for (extension in supportedExtensions)
			{
				if (__extensionObjectConstructors.exists(extension))
				{
					__extensionObjects.set(extension, null);
				}
			}
		}

		if (__extensionObjects.exists(name))
		{
			var object = __extensionObjects.get(name);

			if (object == null)
			{
				object = __extensionObjectConstructors.get(name)();
				__extensionObjects.set(name, object);

				#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
				NativeCFFI.lime_gl_get_extension(name);
				#end
			}

			return object;
		}
		else
		{
			return null;
		}
	}

	public function getFloat(pname:Int):Float
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_float(pname);
		#else
		return 0;
		#end
	}

	public function getFloatv(pname:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_floatv(pname, params);
		#end
	}

	public function getFragDataLocation(program:GLProgram, name:String):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_frag_data_location(__getObjectID(program), name);
		#else
		return 0;
		#end
	}

	public function getFramebufferAttachmentParameter(target:Int, attachment:Int, pname:Int):Dynamic
	{
		var value = getFramebufferAttachmentParameteri(target, attachment, pname);

		if (pname == FRAMEBUFFER_ATTACHMENT_OBJECT_NAME)
		{
			var texture:GLTexture = value;
			if (texture != null)
				return texture;

			var renderbuffer:GLRenderbuffer = value;
			if (renderbuffer != null)
				return renderbuffer;
		}

		return value;
	}

	public function getFramebufferAttachmentParameteri(target:Int, attachment:Int, pname:Int):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_framebuffer_attachment_parameteri(target, attachment, pname);
		#else
		return 0;
		#end
	}

	public function getFramebufferAttachmentParameteriv(target:Int, attachment:Int, pname:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_framebuffer_attachment_parameteriv(target, attachment, pname, params);
		#end
	}

	public function getIndexedParameter(target:Int, index:Int):Dynamic
	{
		// TODO

		return null;
	}

	public function getInteger(pname:Int):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_integer(pname);
		#else
		return 0;
		#end
	}

	public function getInteger64(pname:Int):Int64
	{
		// TODO

		// #if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		// return NativeCFFI.lime_gl_get_integer64 (pname);
		// #else
		return Int64.ofInt(0);
		// #end
	}

	public function getInteger64i(pname:Int):Int64
	{
		// TODO

		// #if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		// return NativeCFFI.lime_gl_get_integer64i (pname);
		// #else
		return Int64.ofInt(0);
		// #end
	}

	public function getInteger64i_v(pname:Int, index:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_integer64i_v(pname, index, params);
		#end
	}

	public function getInteger64v(pname:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_integer64v(pname, params);
		#end
	}

	public function getIntegeri_v(pname:Int, index:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_integeri_v(pname, index, params);
		#end
	}

	public function getIntegerv(pname:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_integerv(pname, params);
		#end
	}

	public function getInternalformati(target:Int, internalformat:Int, pname:Int):Int
	{
		// TODO

		// #if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		// return NativeCFFI.lime_gl_get_internalformati (target, internalformat, pname);
		// #else
		return 0;
		// #end
	}

	public function getInternalformativ(target:Int, internalformat:Int, pname:Int, bufSize:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_internalformativ(target, internalformat, pname, bufSize, params);
		#end
	}

	public function getInternalformatParameter(target:Int, internalformat:Int, pname:Int):Dynamic
	{
		// TODO

		return null;
	}

	public function getParameter(pname:Int):Dynamic
	{
		switch (pname)
		{
			case GL.BLEND, GL.CULL_FACE, GL.DEPTH_TEST, GL.DEPTH_WRITEMASK, GL.DITHER, GL.POLYGON_OFFSET_FILL, GL.SAMPLE_COVERAGE_INVERT, GL.SCISSOR_TEST,
				GL.STENCIL_TEST:
				return getBoolean(pname);

			case GL.COLOR_WRITEMASK:
				var params = Bytes.alloc(4);
				getBooleanv(pname, params);

				var data = new Array<Bool>();
				for (i in 0...4)
					data[i] = params.get(i) != 0;
				return data;

			case GL.DEPTH_CLEAR_VALUE, GL.LINE_WIDTH, GL.POLYGON_OFFSET_FACTOR, GL.POLYGON_OFFSET_UNITS, GL.SAMPLE_COVERAGE_VALUE:
				return getFloat(pname);

			case GL.ALIASED_LINE_WIDTH_RANGE, GL.ALIASED_POINT_SIZE_RANGE, GL.DEPTH_RANGE:
				var params = new Float32Array(2);
				getFloatv(pname, params);
				return params;

			case GL.BLEND_COLOR, GL.COLOR_CLEAR_VALUE:
				var params = new Float32Array(4);
				getFloatv(pname, params);
				return params;

			case GL.ACTIVE_TEXTURE, GL.ALPHA_BITS, GL.BLEND_DST_ALPHA, GL.BLEND_DST_RGB, GL.BLEND_EQUATION, GL.BLEND_EQUATION_ALPHA,
				/*GL.BLEND_EQUATION_RGB,*/ GL.BLEND_SRC_ALPHA, GL.BLEND_SRC_RGB, GL.BLUE_BITS, GL.CULL_FACE_MODE, GL.DEPTH_BITS, GL.DEPTH_FUNC, GL.FRONT_FACE,
				GL.GENERATE_MIPMAP_HINT, GL.GREEN_BITS, GL.IMPLEMENTATION_COLOR_READ_FORMAT, GL.IMPLEMENTATION_COLOR_READ_TYPE,
				GL.MAX_COMBINED_TEXTURE_IMAGE_UNITS, GL.MAX_CUBE_MAP_TEXTURE_SIZE, GL.MAX_FRAGMENT_UNIFORM_VECTORS, GL.MAX_RENDERBUFFER_SIZE,
				GL.MAX_TEXTURE_IMAGE_UNITS, GL.MAX_TEXTURE_SIZE, GL.MAX_VARYING_VECTORS, GL.MAX_VERTEX_ATTRIBS, GL.MAX_VERTEX_TEXTURE_IMAGE_UNITS,
				GL.MAX_VERTEX_UNIFORM_VECTORS, GL.PACK_ALIGNMENT, GL.RED_BITS, GL.SAMPLE_BUFFERS, GL.SAMPLES, GL.STENCIL_BACK_FAIL, GL.STENCIL_BACK_FUNC,
				GL.STENCIL_BACK_PASS_DEPTH_FAIL, GL.STENCIL_BACK_PASS_DEPTH_PASS, GL.STENCIL_BACK_REF, GL.STENCIL_BACK_VALUE_MASK, GL.STENCIL_BACK_WRITEMASK,
				GL.STENCIL_BITS, GL.STENCIL_CLEAR_VALUE, GL.STENCIL_FAIL, GL.STENCIL_FUNC, GL.STENCIL_PASS_DEPTH_FAIL, GL.STENCIL_PASS_DEPTH_PASS,
				GL.STENCIL_REF, GL.STENCIL_VALUE_MASK, GL.STENCIL_WRITEMASK, GL.SUBPIXEL_BITS, GL.UNPACK_ALIGNMENT:
				return getInteger(pname);

			case GL.COMPRESSED_TEXTURE_FORMATS:
				var params = new UInt32Array(getInteger(GL.NUM_COMPRESSED_TEXTURE_FORMATS));
				getIntegerv(pname, params);
				return params;

			case GL.MAX_VIEWPORT_DIMS:
				var params = new Int32Array(2);
				getIntegerv(pname, params);
				return params;

			case GL.SCISSOR_BOX, GL.VIEWPORT:
				var params = new Int32Array(4);
				getIntegerv(pname, params);
				return params;

			case GL.RENDERER, GL.SHADING_LANGUAGE_VERSION, GL.VENDOR, GL.VERSION:
				return getString(pname);

			case GL.ARRAY_BUFFER_BINDING, GL.ELEMENT_ARRAY_BUFFER_BINDING:
				var data:GLBuffer = getInteger(pname);
				return data;

			case GL.CURRENT_PROGRAM:
				var data:GLProgram = getInteger(pname);
				return data;

			case GL.FRAMEBUFFER_BINDING:
				var data:GLFramebuffer = getInteger(pname);
				return data;

			case GL.RENDERBUFFER_BINDING:
				var data:GLRenderbuffer = getInteger(pname);
				return data;

			case GL.TEXTURE_BINDING_2D, GL.TEXTURE_BINDING_CUBE_MAP:
				var data:GLTexture = getInteger(pname);
				return data;

			default:
				return getInteger(pname);
				// return null;
		}
	}

	public function getProgrami(program:GLProgram, pname:Int):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_programi(__getObjectID(program), pname);
		#else
		return 0;
		#end
	}

	public function getProgramiv(program:GLProgram, pname:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_programiv(__getObjectID(program), pname, params);
		#end
	}

	public function getProgramBinary(program:GLProgram, binaryFormat:Int):Bytes
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		var bytes = Bytes.alloc(0);
		NativeCFFI.lime_gl_get_program_binary(__getObjectID(program), binaryFormat, bytes);
		return bytes;
		#else
		return null;
		#end
	}

	public function getProgramInfoLog(program:GLProgram):String
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_program_info_log(__getObjectID(program));
		#else
		return null;
		#end
	}

	public function getProgramParameter(program:GLProgram, pname:Int):Dynamic
	{
		return getProgrami(program, pname);
	}

	public function getQuery(target:Int, pname:Int):GLQuery
	{
		return getQueryi(target, pname);
	}

	public function getQueryi(target:Int, pname:Int):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_queryi(target, pname);
		#else
		return 0;
		#end
	}

	public function getQueryiv(target:Int, pname:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_queryiv(target, pname, params);
		#end
	}

	public function getQueryObjectui(query:GLQuery, pname:Int):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_query_objectui(__getObjectID(query), pname);
		#else
		return 0;
		#end
	}

	public function getQueryObjectuiv(query:GLQuery, pname:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_query_objectuiv(__getObjectID(query), pname, params);
		#end
	}

	public function getQueryParameter(query:GLQuery, pname:Int):Dynamic
	{
		return switch (pname)
		{
			case GL.QUERY_RESULT_AVAILABLE: getQueryObjectui(query, pname) != 0;
			default: getQueryObjectui(query, pname);
		}
	}

	public function getRenderbufferParameter(target:Int, pname:Int):Dynamic
	{
		return getRenderbufferParameteri(target, pname);
	}

	public function getRenderbufferParameteri(target:Int, pname:Int):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_renderbuffer_parameteri(target, pname);
		#else
		return 0;
		#end
	}

	public function getRenderbufferParameteriv(target:Int, pname:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_renderbuffer_parameteriv(target, pname, params);
		#end
	}

	public function getSamplerParameter(sampler:GLSampler, pname:Int):Dynamic
	{
		return switch (pname)
		{
			case GL.TEXTURE_MIN_LOD, GL.TEXTURE_MAX_LOD: getSamplerParameterf(sampler, pname);
			default: getSamplerParameteri(sampler, pname);
		}
	}

	public function getSamplerParameterf(sampler:GLSampler, pname:Int):Float
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_sampler_parameterf(__getObjectID(sampler), pname);
		#else
		return 0;
		#end
	}

	public function getSamplerParameterfv(sampler:GLSampler, pname:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_sampler_parameterfv(__getObjectID(sampler), pname, params);
		#end
	}

	public function getSamplerParameteri(sampler:GLSampler, pname:Int):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_sampler_parameteri(__getObjectID(sampler), pname);
		#else
		return 0;
		#end
	}

	public function getSamplerParameteriv(sampler:GLSampler, pname:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_sampler_parameteriv(__getObjectID(sampler), pname, params);
		#end
	}

	public function getShaderi(shader:GLShader, pname:Int):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_shaderi(__getObjectID(shader), pname);
		#else
		return 0;
		#end
	}

	public function getShaderiv(shader:GLShader, pname:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_shaderiv(__getObjectID(shader), pname, params);
		#end
	}

	public function getShaderInfoLog(shader:GLShader):String
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_shader_info_log(__getObjectID(shader));
		#else
		return null;
		#end
	}

	public function getShaderParameter(shader:GLShader, pname:Int):Dynamic
	{
		return getShaderi(shader, pname);
	}

	public function getShaderPrecisionFormat(shadertype:Int, precisiontype:Int):GLShaderPrecisionFormat
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_shader_precision_format(shadertype, precisiontype);
		#else
		return null;
		#end
	}

	public function getShaderSource(shader:GLShader):String
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_shader_source(__getObjectID(shader));
		#else
		return null;
		#end
	}

	public function getString(name:Int):String
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_string(name);
		#else
		return null;
		#end
	}

	public function getStringi(name:Int, index:Int):String
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_stringi(name, index);
		#else
		return null;
		#end
	}

	public function getSupportedExtensions():Array<String>
	{
		if (__supportedExtensions == null)
		{
			__supportedExtensions = new Array<String>();

			// glGetString(GL_EXTENSIONS) is removed in desktop GL 3.1+ core profiles, where it
			// returns null and sets GL_INVALID_ENUM. Enumerate individually when the context is
			// new enough to have glGetStringi, and fall back if that yields nothing.
			if (version >= 3)
			{
				var count = getInteger(0x821D); // NUM_EXTENSIONS

				for (i in 0...count)
				{
					var extension = getStringi(GL.EXTENSIONS, i);

					if (extension != null)
					{
						__pushSupportedExtension(extension);
					}
				}
			}

			if (__supportedExtensions.length == 0)
			{
				var extensions = getString(GL.EXTENSIONS);

				if (extensions != null)
				{
					for (extension in extensions.split(" "))
					{
						if (extension != "")
						{
							__pushSupportedExtension(extension);
						}
					}
				}
			}
		}

		return __supportedExtensions;
	}

	public function getSyncParameter(sync:GLSync, pname:Int):Dynamic
	{
		// TODO

		return null;
	}

	public function getSyncParameteri(sync:GLSync, pname:Int):Int
	{
		// TODO

		return 0;
	}

	public function getSyncParameteriv(sync:GLSync, pname:Int, params:DataPointer):Void
	{
		// TODO
	}

	public function getTexParameter(target:Int, pname:Int):Dynamic
	{
		switch (pname)
		{
			case GL.TEXTURE_MAX_LOD, GL.TEXTURE_MIN_LOD:
				return getTexParameterf(target, pname);

			case GL.TEXTURE_IMMUTABLE_FORMAT:
				return getTexParameterf(target, pname) != 0;

			default:
				return getTexParameteri(target, pname);
		}
	}

	public function getTexParameterf(target:Int, pname:Int):Float
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_tex_parameterf(target, pname);
		#else
		return 0;
		#end
	}

	public function getTexParameterfv(target:Int, pname:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_tex_parameterfv(target, pname, params);
		#end
	}

	public function getTexParameteri(target:Int, pname:Int):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_tex_parameteri(target, pname);
		#else
		return 0;
		#end
	}

	public function getTexParameteriv(target:Int, pname:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_tex_parameteriv(target, pname, params);
		#end
	}

	public function getTransformFeedbackVarying(program:GLProgram, index:Int):GLActiveInfo
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_transform_feedback_varying(__getObjectID(program), index);
		#else
		return null;
		#end
	}

	public function getUniform(program:GLProgram, location:GLUniformLocation):Dynamic
	{
		var info = getActiveUniform(program, location);

		var bools = 0;
		var ints = 0;
		var floats = 0;

		switch (info.type)
		{
			case GL.BOOL:
				bools = 1;
			case GL.INT:
				ints = 1;
			case GL.FLOAT:
				floats = 1;
			case GL.FLOAT_VEC2:
				floats = 2;
			case GL.INT_VEC2:
				ints = 2;
			case GL.BOOL_VEC2:
				bools = 2;
			case GL.FLOAT_VEC3:
				floats = 3;
			case GL.INT_VEC3:
				ints = 3;
			case GL.BOOL_VEC3:
				bools = 3;
			case GL.FLOAT_VEC4:
				floats = 4;
			case GL.INT_VEC4:
				ints = 4;
			case GL.BOOL_VEC4:
				bools = 4;
			case GL.FLOAT_MAT2:
				floats = 4;
			case GL.FLOAT_MAT2x3:
				floats = 12;
			case GL.FLOAT_MAT2x4:
				floats = 16;
			case GL.FLOAT_MAT3:
				floats = 9;
			case GL.FLOAT_MAT3x2:
				floats = 18;
			case GL.FLOAT_MAT3x4:
				floats = 36;
			case GL.FLOAT_MAT4:
				floats = 16;
			case GL.FLOAT_MAT4x2:
				floats = 32;
			case GL.FLOAT_MAT4x3:
				floats = 48;
			case GL.SAMPLER_2D, GL.SAMPLER_3D, GL.SAMPLER_CUBE, GL.SAMPLER_2D_SHADOW:
				ints = 1;
			default:
				return null;
		}

		if (bools == 1)
		{
			return getUniformi(program, location) != 0;
		}
		else if (ints == 1)
		{
			return getUniformi(program, location);
		}
		else if (floats == 1)
		{
			return getUniformf(program, location);
		}
		else if (bools > 0)
		{
			var params = Bytes.alloc(bools);
			getUniformiv(program, location, params);

			var data = new Array<Bool>();

			for (i in 0...bools)
			{
				data[i] = params.get(i) != 0;
			}

			return data;
		}
		else if (ints > 0)
		{
			var params = new Int32Array(ints);
			getUniformiv(program, location, params);
			return params;
		}
		else if (floats > 0)
		{
			var params = new Float32Array(floats);
			getUniformfv(program, location, params);
			return params;
		}
		else
		{
			return null;
		}
	}

	public function getUniformf(program:GLProgram, location:GLUniformLocation):Float
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_uniformf(__getObjectID(program), location);
		#else
		return 0;
		#end
	}

	public function getUniformfv(program:GLProgram, location:GLUniformLocation, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_uniformfv(__getObjectID(program), location, params);
		#end
	}

	public function getUniformi(program:GLProgram, location:GLUniformLocation):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_uniformi(__getObjectID(program), location);
		#else
		return 0;
		#end
	}

	public function getUniformiv(program:GLProgram, location:GLUniformLocation, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_uniformiv(__getObjectID(program), location, params);
		#end
	}

	public function getUniformui(program:GLProgram, location:GLUniformLocation):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_uniformui(__getObjectID(program), location);
		#else
		return 0;
		#end
	}

	public function getUniformuiv(program:GLProgram, location:GLUniformLocation, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_uniformuiv(__getObjectID(program), location, params);
		#end
	}

	public function getUniformBlockIndex(program:GLProgram, uniformBlockName:String):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_uniform_block_index(__getObjectID(program), uniformBlockName);
		#else
		return 0;
		#end
	}

	public function getUniformIndices(program:GLProgram, uniformNames:Array<String>):Array<Int>
	{
		// TODO

		return null;
	}

	public function getUniformLocation(program:GLProgram, name:String):GLUniformLocation
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_uniform_location(__getObjectID(program), name);
		#else
		return 0;
		#end
	}

	public function getVertexAttrib(index:Int, pname:Int):Dynamic
	{
		return getVertexAttribi(index, pname);
	}

	public function getVertexAttribf(index:Int, pname:Int):Float
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_vertex_attribf(index, pname);
		#else
		return 0;
		#end
	}

	public function getVertexAttribfv(index:Int, pname:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_vertex_attribfv(index, pname, params);
		#end
	}

	public function getVertexAttribi(index:Int, pname:Int):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_vertex_attribi(index, pname);
		#else
		return 0;
		#end
	}

	public function getVertexAttribIi(index:Int, pname:Int):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_vertex_attribii(index, pname);
		#else
		return 0;
		#end
	}

	public function getVertexAttribIiv(index:Int, pname:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_vertex_attribiiv(index, pname, params);
		#end
	}

	public function getVertexAttribIui(index:Int, pname:Int):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_vertex_attribiui(index, pname);
		#else
		return 0;
		#end
	}

	public function getVertexAttribIuiv(index:Int, pname:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_vertex_attribiuiv(index, pname, params);
		#end
	}

	public function getVertexAttribiv(index:Int, pname:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_vertex_attribiv(index, pname, params);
		#end
	}

	public function getVertexAttribPointerv(index:Int, pname:Int):DataPointer
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_vertex_attrib_pointerv(index, pname);
		#else
		return 0;
		#end
	}

	public function hint(target:Int, mode:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_hint(target, mode);
		#end
	}

	public function invalidateFramebuffer(target:Int, attachments:Array<Int>):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_invalidate_framebuffer(target, attachments);
		#end
	}

	public function invalidateSubFramebuffer(target:Int, attachments:Array<Int>, x:Int, y:Int, width:Int, height:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_invalidate_sub_framebuffer(target, attachments, x, y, width, height);
		#end
	}

	public function isBuffer(buffer:GLBuffer):Bool
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_is_buffer(__getObjectID(buffer));
		#else
		return false;
		#end
	}

	public function isContextLost():Bool
	{
		return __isContextLost;
	}

	public function isEnabled(cap:Int):Bool
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_is_enabled(cap);
		#else
		return false;
		#end
	}

	public function isFramebuffer(framebuffer:GLFramebuffer):Bool
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_is_framebuffer(__getObjectID(framebuffer));
		#else
		return false;
		#end
	}

	public function isProgram(program:GLProgram):Bool
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_is_program(__getObjectID(program));
		#else
		return false;
		#end
	}

	public function isQuery(query:GLQuery):Bool
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_is_query(__getObjectID(query));
		#else
		return false;
		#end
	}

	public function isRenderbuffer(renderbuffer:GLRenderbuffer):Bool
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_is_renderbuffer(__getObjectID(renderbuffer));
		#else
		return false;
		#end
	}

	public function isSampler(sampler:GLSampler):Bool
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_is_sampler(__getObjectID(sampler));
		#else
		return false;
		#end
	}

	public function isShader(shader:GLShader):Bool
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_is_shader(__getObjectID(shader));
		#else
		return false;
		#end
	}

	public function isSync(sync:GLSync):Bool
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_is_sync(sync);
		#else
		return false;
		#end
	}

	public function isTexture(texture:GLTexture):Bool
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_is_texture(__getObjectID(texture));
		#else
		return false;
		#end
	}

	public function isTransformFeedback(transformFeedback:GLTransformFeedback):Bool
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_is_transform_feedback(__getObjectID(transformFeedback));
		#else
		return false;
		#end
	}

	public function isVertexArray(vertexArray:GLVertexArrayObject):Bool
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_is_vertex_array(__getObjectID(vertexArray));
		#else
		return false;
		#end
	}

	public function lineWidth(width:Float):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_line_width(width);
		#end
	}

	public function linkProgram(program:GLProgram):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_link_program(__getObjectID(program));
		#end
	}

	public function mapBufferRange(target:Int, offset:DataPointer, length:Int, access:Int):DataPointer
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_map_buffer_range(target, offset, length, access);
		#else
		return 0;
		#end
	}

	public function pauseTransformFeedback():Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_pause_transform_feedback();
		#end
	}

	public function pixelStorei(pname:Int, param:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_pixel_storei(pname, param);
		#end
	}

	public function polygonOffset(factor:Float, units:Float):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_polygon_offset(factor, units);
		#end
	}

	public function programBinary(program:GLProgram, binaryFormat:Int, binary:DataPointer, length:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_program_binary(__getObjectID(program), binaryFormat, binary, length);
		#end
	}

	public function programParameteri(program:GLProgram, pname:Int, value:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_program_parameteri(__getObjectID(program), pname, value);
		#end
	}

	public function readBuffer(src:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_read_buffer(src);
		#end
	}

	public function readPixels(x:Int, y:Int, width:Int, height:Int, format:Int, type:Int, pixels:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_read_pixels(x, y, width, height, format, type, pixels);
		#end
	}

	public function releaseShaderCompiler():Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_release_shader_compiler();
		#end
	}

	public function renderbufferStorage(target:Int, internalformat:Int, width:Int, height:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_renderbuffer_storage(target, internalformat, width, height);
		#end
	}

	public function renderbufferStorageMultisample(target:Int, samples:Int, internalformat:Int, width:Int, height:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_renderbuffer_storage_multisample(target, samples, internalformat, width, height);
		#end
	}

	public function resumeTransformFeedback():Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_resume_transform_feedback();
		#end
	}

	public function sampleCoverage(value:Float, invert:Bool):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_sample_coverage(value, invert);
		#end
	}

	public function samplerParameterf(sampler:GLSampler, pname:Int, param:Float):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_sampler_parameterf(__getObjectID(sampler), pname, param);
		#end
	}

	public function samplerParameteri(sampler:GLSampler, pname:Int, param:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_sampler_parameteri(__getObjectID(sampler), pname, param);
		#end
	}

	public function scissor(x:Int, y:Int, width:Int, height:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_scissor(x, y, width, height);
		#end
	}

	public function shaderBinary(shaders:Array<GLShader>, binaryformat:Int, binary:DataPointer, length:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_shader_binary(shaders, binaryformat, binary, length);
		#end
	}

	public function shaderSource(shader:GLShader, source:String):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_shader_source(__getObjectID(shader), source);
		#end
	}

	public function stencilFunc(func:Int, ref:Int, mask:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_stencil_func(func, ref, mask);
		#end
	}

	public function stencilFuncSeparate(face:Int, func:Int, ref:Int, mask:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_stencil_func_separate(face, func, ref, mask);
		#end
	}

	public function stencilMask(mask:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_stencil_mask(mask);
		#end
	}

	public function stencilMaskSeparate(face:Int, mask:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_stencil_mask_separate(face, mask);
		#end
	}

	public function stencilOp(fail:Int, zfail:Int, zpass:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_stencil_op(fail, zfail, zpass);
		#end
	}

	public function stencilOpSeparate(face:Int, fail:Int, zfail:Int, zpass:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_stencil_op_separate(face, fail, zfail, zpass);
		#end
	}

	public function texImage2D(target:Int, level:Int, internalformat:Int, width:Int, height:Int, border:Int, format:Int, type:Int, data:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_tex_image_2d(target, level, internalformat, width, height, border, format, type, data);
		#end
	}

	public function texImage3D(target:Int, level:Int, internalformat:Int, width:Int, height:Int, depth:Int, border:Int, format:Int, type:Int,
			data:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_tex_image_3d(target, level, internalformat, width, height, depth, border, format, type, data);
		#end
	}

	public function texStorage2D(target:Int, level:Int, internalformat:Int, width:Int, height:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_tex_storage_2d(target, level, internalformat, width, height);
		#end
	}

	public function texStorage3D(target:Int, level:Int, internalformat:Int, width:Int, height:Int, depth:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_tex_storage_3d(target, level, internalformat, width, height, depth);
		#end
	}

	public function texParameterf(target:Int, pname:Int, param:Float):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_tex_parameterf(target, pname, param);
		#end
	}

	public function texParameteri(target:Int, pname:Int, param:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_tex_parameteri(target, pname, param);
		#end
	}

	public function texSubImage2D(target:Int, level:Int, xoffset:Int, yoffset:Int, width:Int, height:Int, format:Int, type:Int, pixels:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_tex_sub_image_2d(target, level, xoffset, yoffset, width, height, format, type, pixels);
		#end
	}

	public function texSubImage3D(target:Int, level:Int, xoffset:Int, yoffset:Int, zoffset:Int, width:Int, height:Int, depth:Int, format:Int, type:Int,
			data:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_tex_sub_image_3d(target, level, xoffset, yoffset, zoffset, width, height, depth, format, type, data);
		#end
	}

	@:noCompletion @:dox(hide) public function toString():String
	{
		return "NativeOpenGLRenderContext";
	}

	public function transformFeedbackVaryings(program:GLProgram, varyings:Array<String>, bufferMode:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_transform_feedback_varyings(__getObjectID(program), varyings, bufferMode);
		#end
	}

	public function uniform1f(location:GLUniformLocation, v0:Float):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform1f(location, v0);
		#end
	}

	public function uniform1fv(location:GLUniformLocation, count:Int, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform1fv(location, count, v);
		#end
	}

	public function uniform1i(location:GLUniformLocation, v0:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform1i(location, v0);
		#end
	}

	public function uniform1iv(location:GLUniformLocation, count:Int, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform1iv(location, count, v);
		#end
	}

	public function uniform1ui(location:GLUniformLocation, v0:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform1ui(location, v0);
		#end
	}

	public function uniform1uiv(location:GLUniformLocation, count:Int, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform1uiv(location, count, v);
		#end
	}

	public function uniform2f(location:GLUniformLocation, v0:Float, v1:Float):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform2f(location, v0, v1);
		#end
	}

	public function uniform2fv(location:GLUniformLocation, count:Int, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform2fv(location, count, v);
		#end
	}

	public function uniform2i(location:GLUniformLocation, v0:Int, v1:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform2i(location, v0, v1);
		#end
	}

	public function uniform2iv(location:GLUniformLocation, count:Int, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform2iv(location, count, v);
		#end
	}

	public function uniform2ui(location:GLUniformLocation, v0:Int, v1:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform2ui(location, v0, v1);
		#end
	}

	public function uniform2uiv(location:GLUniformLocation, count:Int, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform2uiv(location, count, v);
		#end
	}

	public function uniform3f(location:GLUniformLocation, v0:Float, v1:Float, v2:Float):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform3f(location, v0, v1, v2);
		#end
	}

	public function uniform3fv(location:GLUniformLocation, count:Int, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform3fv(location, count, v);
		#end
	}

	public function uniform3i(location:GLUniformLocation, v0:Int, v1:Int, v2:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform3i(location, v0, v1, v2);
		#end
	}

	public function uniform3iv(location:GLUniformLocation, count:Int, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform3iv(location, count, v);
		#end
	}

	public function uniform3ui(location:GLUniformLocation, v0:Int, v1:Int, v2:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform3ui(location, v0, v1, v2);
		#end
	}

	public function uniform3uiv(location:GLUniformLocation, count:Int, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform3uiv(location, count, v);
		#end
	}

	public function uniform4f(location:GLUniformLocation, v0:Float, v1:Float, v2:Float, v3:Float):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform4f(location, v0, v1, v2, v3);
		#end
	}

	public function uniform4fv(location:GLUniformLocation, count:Int, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform4fv(location, count, v);
		#end
	}

	public function uniform4i(location:GLUniformLocation, v0:Int, v1:Int, v2:Int, v3:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform4i(location, v0, v1, v2, v3);
		#end
	}

	public function uniform4iv(location:GLUniformLocation, count:Int, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform4iv(location, count, v);
		#end
	}

	public function uniform4ui(location:GLUniformLocation, v0:Int, v1:Int, v2:Int, v3:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform4ui(location, v0, v1, v2, v3);
		#end
	}

	public function uniform4uiv(location:GLUniformLocation, count:Int, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform4uiv(location, count, v);
		#end
	}

	public function uniformBlockBinding(program:GLProgram, uniformBlockIndex:Int, uniformBlockBinding:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform_block_binding(__getObjectID(program), uniformBlockIndex, uniformBlockBinding);
		#end
	}

	public function uniformMatrix2fv(location:GLUniformLocation, count:Int, transpose:Bool, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform_matrix2fv(location, count, transpose, v);
		#end
	}

	public function uniformMatrix2x3fv(location:GLUniformLocation, count:Int, transpose:Bool, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform_matrix2x3fv(location, count, transpose, v);
		#end
	}

	public function uniformMatrix2x4fv(location:GLUniformLocation, count:Int, transpose:Bool, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform_matrix2x4fv(location, count, transpose, v);
		#end
	}

	public function uniformMatrix3fv(location:GLUniformLocation, count:Int, transpose:Bool, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform_matrix3fv(location, count, transpose, v);
		#end
	}

	public function uniformMatrix3x2fv(location:GLUniformLocation, count:Int, transpose:Bool, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform_matrix3x2fv(location, count, transpose, v);
		#end
	}

	public function uniformMatrix3x4fv(location:GLUniformLocation, count:Int, transpose:Bool, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform_matrix3x4fv(location, count, transpose, v);
		#end
	}

	public function uniformMatrix4fv(location:GLUniformLocation, count:Int, transpose:Bool, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform_matrix4fv(location, count, transpose, v);
		#end
	}

	public function uniformMatrix4x2fv(location:GLUniformLocation, count:Int, transpose:Bool, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform_matrix4x2fv(location, count, transpose, v);
		#end
	}

	public function uniformMatrix4x3fv(location:GLUniformLocation, count:Int, transpose:Bool, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_uniform_matrix4x3fv(location, count, transpose, v);
		#end
	}

	public function unmapBuffer(target:Int):Bool
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_unmap_buffer(target);
		#else
		return false;
		#end
	}

	public function useProgram(program:GLProgram):Void
	{
		var id = __getObjectID(program);
		if (__lastProgramID == id)
			return;
		__lastProgramID = id;
		__currentProgram = program;

		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_use_program(id);
		#end
	}

	public function validateProgram(program:GLProgram):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_validate_program(__getObjectID(program));
		#end
	}

	public function vertexAttrib1f(index:Int, v0:Float):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_vertex_attrib1f(index, v0);
		#end
	}

	public function vertexAttrib1fv(index:Int, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_vertex_attrib1fv(index, v);
		#end
	}

	public function vertexAttrib2f(index:Int, v0:Float, y:Float):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_vertex_attrib2f(index, v0, y);
		#end
	}

	public function vertexAttrib2fv(index:Int, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_vertex_attrib2fv(index, v);
		#end
	}

	public function vertexAttrib3f(index:Int, v0:Float, v1:Float, v2:Float):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_vertex_attrib3f(index, v0, v1, v2);
		#end
	}

	public function vertexAttrib3fv(index:Int, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_vertex_attrib3fv(index, v);
		#end
	}

	public function vertexAttrib4f(index:Int, v0:Float, v1:Float, v2:Float, v3:Float):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_vertex_attrib4f(index, v0, v1, v2, v3);
		#end
	}

	public function vertexAttrib4fv(index:Int, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_vertex_attrib4fv(index, v);
		#end
	}

	public function vertexAttribDivisor(index:Int, divisor:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_vertex_attrib_divisor(index, divisor);
		#end
	}

	public function vertexAttribI4i(index:Int, v0:Int, v1:Int, v2:Int, v3:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_vertex_attribi4i(index, v0, v1, v2, v3);
		#end
	}

	public function vertexAttribI4iv(index:Int, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_vertex_attribi4iv(index, v);
		#end
	}

	public function vertexAttribI4ui(index:Int, v0:Int, v1:Int, v2:Int, v3:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_vertex_attribi4ui(index, v0, v1, v2, v3);
		#end
	}

	public function vertexAttribI4uiv(index:Int, v:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_vertex_attribi4uiv(index, v);
		#end
	}

	public function vertexAttribIPointer(index:Int, size:Int, type:Int, stride:Int, offset:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_vertex_attrib_ipointer(index, size, type, stride, offset);
		#end
	}

	public function vertexAttribPointer(index:Int, size:Int, type:Int, normalized:Bool, stride:Int, offset:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_vertex_attrib_pointer(index, size, type, normalized, stride, offset);
		#end
	}

	public function viewport(x:Int, y:Int, width:Int, height:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_viewport(x, y, width, height);
		#end
	}

	public function waitSync(sync:GLSync, flags:Int, timeout:Int64):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_wait_sync(sync, flags, timeout.high, timeout.low);
		#end
	}

	private function __contextLost():Void
	{
		__isContextLost = true;
		__arrayBufferBinding = null;
		__elementBufferBinding = null;
		__currentProgram = null;
		__framebufferBinding = null;
		__renderbufferBinding = null;
		__activeTextureUnit = 0x84C0; // GL_TEXTURE0
		__resetTextureUnitBindings();
		__blendSFactor = __blendDFactor = -1;
		__blendSFactorRGB = __blendDFactorRGB = -1;
		__blendSFactorAlpha = __blendDFactorAlpha = -1;
		__capEnabledMask = 0;
		__capKnownMask = 0;
		__lastArrayBufferID = -1;
		__lastElementBufferID = -1;
		__lastDrawFramebufferID = -1;
		__lastReadFramebufferID = -1;
		__lastProgramID = -1;
		__texture2DBinding = null;
		__textureCubeMapBinding = null;
	}

	public function flushMappedBufferRange(target:Int, offset:DataPointer, length:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_flush_mapped_buffer_range(target, offset, length);
		#end
	}

	public function dispatchCompute(x:Int, y:Int, z:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_dispatch_compute(x, y, z);
		#end
	}

	public function dispatchComputeIndirect(indirect:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_dispatch_compute_indirect(indirect);
		#end
	}

	public function memoryBarrier(barriers:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_memory_barrier(barriers);
		#end
	}

	public function memoryBarrierByRegion(barriers:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_memory_barrier_by_region(barriers);
		#end
	}

	public function bindImageTexture(unit:Int, texture:Int, level:Int, layered:Bool, layer:Int, access:Int, format:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_bind_image_texture(unit, texture, level, layered, layer, access, format);
		#end
	}

	public function drawArraysIndirect(mode:Int, indirect:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_draw_arrays_indirect(mode, indirect);
		#end
	}

	public function drawElementsIndirect(mode:Int, type:Int, indirect:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_draw_elements_indirect(mode, type, indirect);
		#end
	}

	public function getProgramInterfacei(program:Int, programInterface:Int, pname:Int):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_program_interfacei(program, programInterface, pname);
		#else
		return 0;
		#end
	}

	public function getProgramInterfaceiv(program:Int, programInterface:Int, pname:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_program_interfaceiv(program, programInterface, pname, params);
		#end
	}

	public function getProgramResourceIndex(program:Int, programInterface:Int, name:String):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_program_resource_index(program, programInterface, name);
		#else
		return 0;
		#end
	}

	public function getProgramResourceLocation(program:Int, programInterface:Int, name:String):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_program_resource_location(program, programInterface, name);
		#else
		return 0;
		#end
	}

	public function getProgramResourceName(program:Int, programInterface:Int, index:Int):String
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_program_resource_name(program, programInterface, index);
		#else
		return null;
		#end
	}

	public function getProgramResourceiv(program:Int, programInterface:Int, index:Int, propCount:Int, props:DataPointer, bufSize:Int, params:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_program_resourceiv(program, programInterface, index, propCount, props, bufSize, params);
		#end
	}

	public function createProgramPipeline():Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_create_program_pipeline();
		#else
		return 0;
		#end
	}

	public function deleteProgramPipeline(pipeline:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_delete_program_pipeline(pipeline);
		#end
	}

	public function bindProgramPipeline(pipeline:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_bind_program_pipeline(pipeline);
		#end
	}

	public function isProgramPipeline(pipeline:Int):Bool
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_is_program_pipeline(pipeline);
		#else
		return false;
		#end
	}

	public function useProgramStages(pipeline:Int, stages:Int, program:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_use_program_stages(pipeline, stages, program);
		#end
	}

	public function activeShaderProgram(pipeline:Int, program:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_active_shader_program(pipeline, program);
		#end
	}

	public function createShaderProgram(type:Int, source:String):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_create_shader_programv(type, source);
		#else
		return 0;
		#end
	}

	public function validateProgramPipeline(pipeline:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_validate_program_pipeline(pipeline);
		#end
	}

	public function getProgramPipelinei(pipeline:Int, pname:Int):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_program_pipelinei(pipeline, pname);
		#else
		return 0;
		#end
	}

	public function getProgramPipelineInfoLog(pipeline:Int):String
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_program_pipeline_info_log(pipeline);
		#else
		return null;
		#end
	}

	public function programUniform1i(program:Int, location:Int, v0:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_program_uniform1i(program, location, v0);
		#end
	}

	public function programUniform1f(program:Int, location:Int, v0:Float):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_program_uniform1f(program, location, v0);
		#end
	}

	public function programUniform2f(program:Int, location:Int, v0:Float, v1:Float):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_program_uniform2f(program, location, v0, v1);
		#end
	}

	public function programUniform3f(program:Int, location:Int, v0:Float, v1:Float, v2:Float):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_program_uniform3f(program, location, v0, v1, v2);
		#end
	}

	public function programUniform4f(program:Int, location:Int, v0:Float, v1:Float, v2:Float, v3:Float):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_program_uniform4f(program, location, v0, v1, v2, v3);
		#end
	}

	public function programUniformMatrix4fv(program:Int, location:Int, count:Int, transpose:Bool, value:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_program_uniform_matrix4fv(program, location, count, transpose, value);
		#end
	}

	public function bindVertexBuffer(bindingIndex:Int, buffer:Int, offset:DataPointer, stride:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_bind_vertex_buffer(bindingIndex, buffer, offset, stride);
		#end
	}

	public function vertexAttribFormat(attribIndex:Int, size:Int, type:Int, normalized:Bool, relativeOffset:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_vertex_attrib_format(attribIndex, size, type, normalized, relativeOffset);
		#end
	}

	public function vertexAttribIFormat(attribIndex:Int, size:Int, type:Int, relativeOffset:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_vertex_attrib_iformat(attribIndex, size, type, relativeOffset);
		#end
	}

	public function vertexAttribBinding(attribIndex:Int, bindingIndex:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_vertex_attrib_binding(attribIndex, bindingIndex);
		#end
	}

	public function vertexBindingDivisor(bindingIndex:Int, divisor:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_vertex_binding_divisor(bindingIndex, divisor);
		#end
	}

	public function texStorage2DMultisample(target:Int, samples:Int, internalformat:Int, width:Int, height:Int, fixedSampleLocations:Bool):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_tex_storage_2d_multisample(target, samples, internalformat, width, height, fixedSampleLocations);
		#end
	}

	public function getMultisamplefv(pname:Int, index:Int, val:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_get_multisamplefv(pname, index, val);
		#end
	}

	public function sampleMaski(maskNumber:Int, mask:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_sample_maski(maskNumber, mask);
		#end
	}

	public function getTexLevelParameteri(target:Int, level:Int, pname:Int):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_tex_level_parameteri(target, level, pname);
		#else
		return 0;
		#end
	}

	public function getTexLevelParameterf(target:Int, level:Int, pname:Int):Float
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_tex_level_parameterf(target, level, pname);
		#else
		return 0;
		#end
	}

	public function getBooleani(target:Int, index:Int):Bool
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_booleani(target, index);
		#else
		return false;
		#end
	}

	public function framebufferParameteri(target:Int, pname:Int, param:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_framebuffer_parameteri(target, pname, param);
		#end
	}

	public function getFramebufferParameteri(target:Int, pname:Int):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_framebuffer_parameteri(target, pname);
		#else
		return 0;
		#end
	}

	public function copyImageSubData(srcName:Int, srcTarget:Int, srcLevel:Int, srcX:Int, srcY:Int, srcZ:Int, dstName:Int, dstTarget:Int, dstLevel:Int, dstX:Int, dstY:Int, dstZ:Int, srcWidth:Int, srcHeight:Int, srcDepth:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_copy_image_sub_data(srcName, srcTarget, srcLevel, srcX, srcY, srcZ, dstName, dstTarget, dstLevel, dstX, dstY, dstZ, srcWidth, srcHeight, srcDepth);
		#end
	}

	public function drawElementsBaseVertex(mode:Int, count:Int, type:Int, indices:DataPointer, baseVertex:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_draw_elements_base_vertex(mode, count, type, indices, baseVertex);
		#end
	}

	public function drawRangeElementsBaseVertex(mode:Int, start:Int, end:Int, count:Int, type:Int, indices:DataPointer, baseVertex:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_draw_range_elements_base_vertex(mode, start, end, count, type, indices, baseVertex);
		#end
	}

	public function drawElementsInstancedBaseVertex(mode:Int, count:Int, type:Int, indices:DataPointer, instanceCount:Int, baseVertex:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_draw_elements_instanced_base_vertex(mode, count, type, indices, instanceCount, baseVertex);
		#end
	}

	public function framebufferTexture(target:Int, attachment:Int, texture:Int, level:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_framebuffer_texture(target, attachment, texture, level);
		#end
	}

	public function texBuffer(target:Int, internalformat:Int, buffer:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_tex_buffer(target, internalformat, buffer);
		#end
	}

	public function texBufferRange(target:Int, internalformat:Int, buffer:Int, offset:DataPointer, size:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_tex_buffer_range(target, internalformat, buffer, offset, size);
		#end
	}

	public function patchParameteri(pname:Int, value:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_patch_parameteri(pname, value);
		#end
	}

	public function minSampleShading(value:Float):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_min_sample_shading(value);
		#end
	}

	public function blendEquationi(buf:Int, mode:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_blend_equationi(buf, mode);
		#end
	}

	public function blendEquationSeparatei(buf:Int, modeRGB:Int, modeAlpha:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_blend_equation_separatei(buf, modeRGB, modeAlpha);
		#end
	}

	public function blendFunci(buf:Int, src:Int, dst:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_blend_funci(buf, src, dst);
		#end
	}

	public function blendFuncSeparatei(buf:Int, srcRGB:Int, dstRGB:Int, srcAlpha:Int, dstAlpha:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_blend_func_separatei(buf, srcRGB, dstRGB, srcAlpha, dstAlpha);
		#end
	}

	public function colorMaski(index:Int, r:Bool, g:Bool, b:Bool, a:Bool):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_color_maski(index, r, g, b, a);
		#end
	}

	public function enablei(target:Int, index:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_enablei(target, index);
		#end
	}

	public function disablei(target:Int, index:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_disablei(target, index);
		#end
	}

	public function isEnabledi(target:Int, index:Int):Bool
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_is_enabledi(target, index);
		#else
		return false;
		#end
	}

	public function texStorage3DMultisample(target:Int, samples:Int, internalformat:Int, width:Int, height:Int, depth:Int, fixedSampleLocations:Bool):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_tex_storage_3d_multisample(target, samples, internalformat, width, height, depth, fixedSampleLocations);
		#end
	}

	public function pushDebugGroup(source:Int, id:Int, message:String):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_push_debug_group(source, id, message);
		#end
	}

	public function popDebugGroup():Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_pop_debug_group();
		#end
	}

	public function objectLabel(identifier:Int, name:Int, label:String):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_object_label(identifier, name, label);
		#end
	}

	public function getObjectLabel(identifier:Int, name:Int):String
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_get_object_label(identifier, name);
		#else
		return null;
		#end
	}

	public function debugMessageInsert(source:Int, type:Int, id:Int, severity:Int, buf:String):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_debug_message_insert(source, type, id, severity, buf);
		#end
	}

	public function debugMessageControl(source:Int, type:Int, severity:Int, count:Int, ids:DataPointer, enabled:Bool):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_debug_message_control(source, type, severity, count, ids, enabled);
		#end
	}

	public function createBufferDSA():Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_create_buffer_dsa();
		#else
		return 0;
		#end
	}

	public function namedBufferData(buffer:Int, size:Int, data:DataPointer, usage:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_named_buffer_data(buffer, size, data, usage);
		#end
	}

	public function namedBufferSubData(buffer:Int, offset:DataPointer, size:Int, data:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_named_buffer_sub_data(buffer, offset, size, data);
		#end
	}

	public function namedBufferStorage(buffer:Int, size:Int, data:DataPointer, flags:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_named_buffer_storage(buffer, size, data, flags);
		#end
	}

	public function mapNamedBufferRange(buffer:Int, offset:DataPointer, length:Int, access:Int):DataPointer
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_map_named_buffer_range(buffer, offset, length, access);
		#else
		return 0;
		#end
	}

	public function unmapNamedBuffer(buffer:Int):Bool
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_unmap_named_buffer(buffer);
		#else
		return false;
		#end
	}

	public function flushMappedNamedBufferRange(buffer:Int, offset:DataPointer, length:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_flush_mapped_named_buffer_range(buffer, offset, length);
		#end
	}

	public function bufferStorage(target:Int, size:Int, data:DataPointer, flags:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_buffer_storage(target, size, data, flags);
		#end
	}

	public function createTextureDSA(target:Int):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_create_texture_dsa(target);
		#else
		return 0;
		#end
	}

	public function textureStorage2D(texture:Int, levels:Int, internalformat:Int, width:Int, height:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_texture_storage_2d(texture, levels, internalformat, width, height);
		#end
	}

	public function textureStorage3D(texture:Int, levels:Int, internalformat:Int, width:Int, height:Int, depth:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_texture_storage_3d(texture, levels, internalformat, width, height, depth);
		#end
	}

	public function textureSubImage2D(texture:Int, level:Int, xoffset:Int, yoffset:Int, width:Int, height:Int, format:Int, type:Int, pixels:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_texture_sub_image_2d(texture, level, xoffset, yoffset, width, height, format, type, pixels);
		#end
	}

	public function textureParameteri(texture:Int, pname:Int, param:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_texture_parameteri(texture, pname, param);
		#end
	}

	public function textureParameterf(texture:Int, pname:Int, param:Float):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_texture_parameterf(texture, pname, param);
		#end
	}

	public function generateTextureMipmap(texture:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_generate_texture_mipmap(texture);
		#end
	}

	public function bindTextureUnit(unit:Int, texture:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_bind_texture_unit(unit, texture);
		#end
	}

	public function createFramebufferDSA():Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_create_framebuffer_dsa();
		#else
		return 0;
		#end
	}

	public function namedFramebufferTexture(framebuffer:Int, attachment:Int, texture:Int, level:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_named_framebuffer_texture(framebuffer, attachment, texture, level);
		#end
	}

	public function namedFramebufferRenderbuffer(framebuffer:Int, attachment:Int, renderbufferTarget:Int, renderbuffer:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_named_framebuffer_renderbuffer(framebuffer, attachment, renderbufferTarget, renderbuffer);
		#end
	}

	public function checkNamedFramebufferStatus(framebuffer:Int, target:Int):Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_check_named_framebuffer_status(framebuffer, target);
		#else
		return 0;
		#end
	}

	public function clearNamedFramebufferfv(framebuffer:Int, buffer:Int, drawbuffer:Int, value:DataPointer):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_clear_named_framebufferfv(framebuffer, buffer, drawbuffer, value);
		#end
	}

	public function blitNamedFramebuffer(readFramebuffer:Int, drawFramebuffer:Int, srcX0:Int, srcY0:Int, srcX1:Int, srcY1:Int, dstX0:Int, dstY0:Int, dstX1:Int, dstY1:Int, mask:Int, filter:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_blit_named_framebuffer(readFramebuffer, drawFramebuffer, srcX0, srcY0, srcX1, srcY1, dstX0, dstY0, dstX1, dstY1, mask, filter);
		#end
	}

	public function createRenderbufferDSA():Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_create_renderbuffer_dsa();
		#else
		return 0;
		#end
	}

	public function namedRenderbufferStorage(renderbuffer:Int, internalformat:Int, width:Int, height:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_named_renderbuffer_storage(renderbuffer, internalformat, width, height);
		#end
	}

	public function createVertexArrayDSA():Int
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		return NativeCFFI.lime_gl_create_vertex_array_dsa();
		#else
		return 0;
		#end
	}

	public function vertexArrayVertexBuffer(vaobj:Int, bindingIndex:Int, buffer:Int, offset:DataPointer, stride:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_vertex_array_vertex_buffer(vaobj, bindingIndex, buffer, offset, stride);
		#end
	}

	public function vertexArrayAttribFormat(vaobj:Int, attribIndex:Int, size:Int, type:Int, normalized:Bool, relativeOffset:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_vertex_array_attrib_format(vaobj, attribIndex, size, type, normalized, relativeOffset);
		#end
	}

	public function vertexArrayAttribBinding(vaobj:Int, attribIndex:Int, bindingIndex:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_vertex_array_attrib_binding(vaobj, attribIndex, bindingIndex);
		#end
	}

	public function vertexArrayElementBuffer(vaobj:Int, buffer:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_vertex_array_element_buffer(vaobj, buffer);
		#end
	}

	public function enableVertexArrayAttrib(vaobj:Int, index:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_enable_vertex_array_attrib(vaobj, index);
		#end
	}

	public function multiDrawArraysIndirect(mode:Int, indirect:DataPointer, drawCount:Int, stride:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_multi_draw_arrays_indirect(mode, indirect, drawCount, stride);
		#end
	}

	public function multiDrawElementsIndirect(mode:Int, type:Int, indirect:DataPointer, drawCount:Int, stride:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_multi_draw_elements_indirect(mode, type, indirect, drawCount, stride);
		#end
	}

	public function clipControl(origin:Int, depth:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_clip_control(origin, depth);
		#end
	}

	public function textureBarrier():Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_texture_barrier();
		#end
	}

	public function polygonMode(face:Int, mode:Int):Void
	{
		#if (lime_cffi && (lime_opengl || lime_opengles) && !macro)
		NativeCFFI.lime_gl_polygon_mode(face, mode);
		#end
	}

	@:noCompletion private inline function get_DEPTH_BUFFER_BIT():Int
	{
		return GL.DEPTH_BUFFER_BIT;
	}

	@:noCompletion private inline function get_STENCIL_BUFFER_BIT():Int
	{
		return GL.STENCIL_BUFFER_BIT;
	}

	@:noCompletion private inline function get_COLOR_BUFFER_BIT():Int
	{
		return GL.COLOR_BUFFER_BIT;
	}

	@:noCompletion private inline function get_POINTS():Int
	{
		return GL.POINTS;
	}

	@:noCompletion private inline function get_LINES():Int
	{
		return GL.LINES;
	}

	@:noCompletion private inline function get_LINE_LOOP():Int
	{
		return GL.LINE_LOOP;
	}

	@:noCompletion private inline function get_LINE_STRIP():Int
	{
		return GL.LINE_STRIP;
	}

	@:noCompletion private inline function get_TRIANGLES():Int
	{
		return GL.TRIANGLES;
	}

	@:noCompletion private inline function get_TRIANGLE_STRIP():Int
	{
		return GL.TRIANGLE_STRIP;
	}

	@:noCompletion private inline function get_TRIANGLE_FAN():Int
	{
		return GL.TRIANGLE_FAN;
	}

	@:noCompletion private inline function get_ZERO():Int
	{
		return GL.ZERO;
	}

	@:noCompletion private inline function get_ONE():Int
	{
		return GL.ONE;
	}

	@:noCompletion private inline function get_SRC_COLOR():Int
	{
		return GL.SRC_COLOR;
	}

	@:noCompletion private inline function get_ONE_MINUS_SRC_COLOR():Int
	{
		return GL.ONE_MINUS_SRC_COLOR;
	}

	@:noCompletion private inline function get_SRC_ALPHA():Int
	{
		return GL.SRC_ALPHA;
	}

	@:noCompletion private inline function get_ONE_MINUS_SRC_ALPHA():Int
	{
		return GL.ONE_MINUS_SRC_ALPHA;
	}

	@:noCompletion private inline function get_DST_ALPHA():Int
	{
		return GL.DST_ALPHA;
	}

	@:noCompletion private inline function get_ONE_MINUS_DST_ALPHA():Int
	{
		return GL.ONE_MINUS_DST_ALPHA;
	}

	@:noCompletion private inline function get_DST_COLOR():Int
	{
		return GL.DST_COLOR;
	}

	@:noCompletion private inline function get_ONE_MINUS_DST_COLOR():Int
	{
		return GL.ONE_MINUS_DST_COLOR;
	}

	@:noCompletion private inline function get_SRC_ALPHA_SATURATE():Int
	{
		return GL.SRC_ALPHA_SATURATE;
	}

	@:noCompletion private inline function get_FUNC_ADD():Int
	{
		return GL.FUNC_ADD;
	}

	@:noCompletion private inline function get_BLEND_EQUATION():Int
	{
		return GL.BLEND_EQUATION;
	}

	@:noCompletion private inline function get_BLEND_EQUATION_RGB():Int
	{
		return GL.BLEND_EQUATION_RGB;
	}

	@:noCompletion private inline function get_BLEND_EQUATION_ALPHA():Int
	{
		return GL.BLEND_EQUATION_ALPHA;
	}

	@:noCompletion private inline function get_FUNC_SUBTRACT():Int
	{
		return GL.FUNC_SUBTRACT;
	}

	@:noCompletion private inline function get_FUNC_REVERSE_SUBTRACT():Int
	{
		return GL.FUNC_REVERSE_SUBTRACT;
	}

	@:noCompletion private inline function get_BLEND_DST_RGB():Int
	{
		return GL.BLEND_DST_RGB;
	}

	@:noCompletion private inline function get_BLEND_SRC_RGB():Int
	{
		return GL.BLEND_SRC_RGB;
	}

	@:noCompletion private inline function get_BLEND_DST_ALPHA():Int
	{
		return GL.BLEND_DST_ALPHA;
	}

	@:noCompletion private inline function get_BLEND_SRC_ALPHA():Int
	{
		return GL.BLEND_SRC_ALPHA;
	}

	@:noCompletion private inline function get_CONSTANT_COLOR():Int
	{
		return GL.CONSTANT_COLOR;
	}

	@:noCompletion private inline function get_ONE_MINUS_CONSTANT_COLOR():Int
	{
		return GL.ONE_MINUS_CONSTANT_COLOR;
	}

	@:noCompletion private inline function get_CONSTANT_ALPHA():Int
	{
		return GL.CONSTANT_ALPHA;
	}

	@:noCompletion private inline function get_ONE_MINUS_CONSTANT_ALPHA():Int
	{
		return GL.ONE_MINUS_CONSTANT_ALPHA;
	}

	@:noCompletion private inline function get_BLEND_COLOR():Int
	{
		return GL.BLEND_COLOR;
	}

	@:noCompletion private inline function get_ARRAY_BUFFER():Int
	{
		return GL.ARRAY_BUFFER;
	}

	@:noCompletion private inline function get_ELEMENT_ARRAY_BUFFER():Int
	{
		return GL.ELEMENT_ARRAY_BUFFER;
	}

	@:noCompletion private inline function get_ARRAY_BUFFER_BINDING():Int
	{
		return GL.ARRAY_BUFFER_BINDING;
	}

	@:noCompletion private inline function get_ELEMENT_ARRAY_BUFFER_BINDING():Int
	{
		return GL.ELEMENT_ARRAY_BUFFER_BINDING;
	}

	@:noCompletion private inline function get_STREAM_DRAW():Int
	{
		return GL.STREAM_DRAW;
	}

	@:noCompletion private inline function get_STATIC_DRAW():Int
	{
		return GL.STATIC_DRAW;
	}

	@:noCompletion private inline function get_DYNAMIC_DRAW():Int
	{
		return GL.DYNAMIC_DRAW;
	}

	@:noCompletion private inline function get_BUFFER_SIZE():Int
	{
		return GL.BUFFER_SIZE;
	}

	@:noCompletion private inline function get_BUFFER_USAGE():Int
	{
		return GL.BUFFER_USAGE;
	}

	@:noCompletion private inline function get_CURRENT_VERTEX_ATTRIB():Int
	{
		return GL.CURRENT_VERTEX_ATTRIB;
	}

	@:noCompletion private inline function get_FRONT():Int
	{
		return GL.FRONT;
	}

	@:noCompletion private inline function get_BACK():Int
	{
		return GL.BACK;
	}

	@:noCompletion private inline function get_FRONT_AND_BACK():Int
	{
		return GL.FRONT_AND_BACK;
	}

	@:noCompletion private inline function get_TEXTURE_2D():Int
	{
		return GL.TEXTURE_2D;
	}

	@:noCompletion private inline function get_CULL_FACE():Int
	{
		return GL.CULL_FACE;
	}

	@:noCompletion private inline function get_BLEND():Int
	{
		return GL.BLEND;
	}

	@:noCompletion private inline function get_DITHER():Int
	{
		return GL.DITHER;
	}

	@:noCompletion private inline function get_STENCIL_TEST():Int
	{
		return GL.STENCIL_TEST;
	}

	@:noCompletion private inline function get_DEPTH_TEST():Int
	{
		return GL.DEPTH_TEST;
	}

	@:noCompletion private inline function get_SCISSOR_TEST():Int
	{
		return GL.SCISSOR_TEST;
	}

	@:noCompletion private inline function get_POLYGON_OFFSET_FILL():Int
	{
		return GL.POLYGON_OFFSET_FILL;
	}

	@:noCompletion private inline function get_SAMPLE_ALPHA_TO_COVERAGE():Int
	{
		return GL.SAMPLE_ALPHA_TO_COVERAGE;
	}

	@:noCompletion private inline function get_SAMPLE_COVERAGE():Int
	{
		return GL.SAMPLE_COVERAGE;
	}

	@:noCompletion private inline function get_NO_ERROR():Int
	{
		return GL.NO_ERROR;
	}

	@:noCompletion private inline function get_INVALID_ENUM():Int
	{
		return GL.INVALID_ENUM;
	}

	@:noCompletion private inline function get_INVALID_VALUE():Int
	{
		return GL.INVALID_VALUE;
	}

	@:noCompletion private inline function get_INVALID_OPERATION():Int
	{
		return GL.INVALID_OPERATION;
	}

	@:noCompletion private inline function get_OUT_OF_MEMORY():Int
	{
		return GL.OUT_OF_MEMORY;
	}

	@:noCompletion private inline function get_CW():Int
	{
		return GL.CW;
	}

	@:noCompletion private inline function get_CCW():Int
	{
		return GL.CCW;
	}

	@:noCompletion private inline function get_LINE_WIDTH():Int
	{
		return GL.LINE_WIDTH;
	}

	@:noCompletion private inline function get_ALIASED_POINT_SIZE_RANGE():Int
	{
		return GL.ALIASED_POINT_SIZE_RANGE;
	}

	@:noCompletion private inline function get_ALIASED_LINE_WIDTH_RANGE():Int
	{
		return GL.ALIASED_LINE_WIDTH_RANGE;
	}

	@:noCompletion private inline function get_CULL_FACE_MODE():Int
	{
		return GL.CULL_FACE_MODE;
	}

	@:noCompletion private inline function get_FRONT_FACE():Int
	{
		return GL.FRONT_FACE;
	}

	@:noCompletion private inline function get_DEPTH_RANGE():Int
	{
		return GL.DEPTH_RANGE;
	}

	@:noCompletion private inline function get_DEPTH_WRITEMASK():Int
	{
		return GL.DEPTH_WRITEMASK;
	}

	@:noCompletion private inline function get_DEPTH_CLEAR_VALUE():Int
	{
		return GL.DEPTH_CLEAR_VALUE;
	}

	@:noCompletion private inline function get_DEPTH_FUNC():Int
	{
		return GL.DEPTH_FUNC;
	}

	@:noCompletion private inline function get_STENCIL_CLEAR_VALUE():Int
	{
		return GL.STENCIL_CLEAR_VALUE;
	}

	@:noCompletion private inline function get_STENCIL_FUNC():Int
	{
		return GL.STENCIL_FUNC;
	}

	@:noCompletion private inline function get_STENCIL_FAIL():Int
	{
		return GL.STENCIL_FAIL;
	}

	@:noCompletion private inline function get_STENCIL_PASS_DEPTH_FAIL():Int
	{
		return GL.STENCIL_PASS_DEPTH_FAIL;
	}

	@:noCompletion private inline function get_STENCIL_PASS_DEPTH_PASS():Int
	{
		return GL.STENCIL_PASS_DEPTH_PASS;
	}

	@:noCompletion private inline function get_STENCIL_REF():Int
	{
		return GL.STENCIL_REF;
	}

	@:noCompletion private inline function get_STENCIL_VALUE_MASK():Int
	{
		return GL.STENCIL_VALUE_MASK;
	}

	@:noCompletion private inline function get_STENCIL_WRITEMASK():Int
	{
		return GL.STENCIL_WRITEMASK;
	}

	@:noCompletion private inline function get_STENCIL_BACK_FUNC():Int
	{
		return GL.STENCIL_BACK_FUNC;
	}

	@:noCompletion private inline function get_STENCIL_BACK_FAIL():Int
	{
		return GL.STENCIL_BACK_FAIL;
	}

	@:noCompletion private inline function get_STENCIL_BACK_PASS_DEPTH_FAIL():Int
	{
		return GL.STENCIL_BACK_PASS_DEPTH_FAIL;
	}

	@:noCompletion private inline function get_STENCIL_BACK_PASS_DEPTH_PASS():Int
	{
		return GL.STENCIL_BACK_PASS_DEPTH_PASS;
	}

	@:noCompletion private inline function get_STENCIL_BACK_REF():Int
	{
		return GL.STENCIL_BACK_REF;
	}

	@:noCompletion private inline function get_STENCIL_BACK_VALUE_MASK():Int
	{
		return GL.STENCIL_BACK_VALUE_MASK;
	}

	@:noCompletion private inline function get_STENCIL_BACK_WRITEMASK():Int
	{
		return GL.STENCIL_BACK_WRITEMASK;
	}

	@:noCompletion private inline function get_VIEWPORT():Int
	{
		return GL.VIEWPORT;
	}

	@:noCompletion private inline function get_SCISSOR_BOX():Int
	{
		return GL.SCISSOR_BOX;
	}

	@:noCompletion private inline function get_COLOR_CLEAR_VALUE():Int
	{
		return GL.COLOR_CLEAR_VALUE;
	}

	@:noCompletion private inline function get_COLOR_WRITEMASK():Int
	{
		return GL.COLOR_WRITEMASK;
	}

	@:noCompletion private inline function get_UNPACK_ALIGNMENT():Int
	{
		return GL.UNPACK_ALIGNMENT;
	}

	@:noCompletion private inline function get_PACK_ALIGNMENT():Int
	{
		return GL.PACK_ALIGNMENT;
	}

	@:noCompletion private inline function get_MAX_TEXTURE_SIZE():Int
	{
		return GL.MAX_TEXTURE_SIZE;
	}

	@:noCompletion private inline function get_MAX_VIEWPORT_DIMS():Int
	{
		return GL.MAX_VIEWPORT_DIMS;
	}

	@:noCompletion private inline function get_SUBPIXEL_BITS():Int
	{
		return GL.SUBPIXEL_BITS;
	}

	@:noCompletion private inline function get_RED_BITS():Int
	{
		return GL.RED_BITS;
	}

	@:noCompletion private inline function get_GREEN_BITS():Int
	{
		return GL.GREEN_BITS;
	}

	@:noCompletion private inline function get_BLUE_BITS():Int
	{
		return GL.BLUE_BITS;
	}

	@:noCompletion private inline function get_ALPHA_BITS():Int
	{
		return GL.ALPHA_BITS;
	}

	@:noCompletion private inline function get_DEPTH_BITS():Int
	{
		return GL.DEPTH_BITS;
	}

	@:noCompletion private inline function get_STENCIL_BITS():Int
	{
		return GL.STENCIL_BITS;
	}

	@:noCompletion private inline function get_POLYGON_OFFSET_UNITS():Int
	{
		return GL.POLYGON_OFFSET_UNITS;
	}

	@:noCompletion private inline function get_POLYGON_OFFSET_FACTOR():Int
	{
		return GL.POLYGON_OFFSET_FACTOR;
	}

	@:noCompletion private inline function get_TEXTURE_BINDING_2D():Int
	{
		return GL.TEXTURE_BINDING_2D;
	}

	@:noCompletion private inline function get_SAMPLE_BUFFERS():Int
	{
		return GL.SAMPLE_BUFFERS;
	}

	@:noCompletion private inline function get_SAMPLES():Int
	{
		return GL.SAMPLES;
	}

	@:noCompletion private inline function get_SAMPLE_COVERAGE_VALUE():Int
	{
		return GL.SAMPLE_COVERAGE_VALUE;
	}

	@:noCompletion private inline function get_SAMPLE_COVERAGE_INVERT():Int
	{
		return GL.SAMPLE_COVERAGE_INVERT;
	}

	@:noCompletion private inline function get_NUM_COMPRESSED_TEXTURE_FORMATS():Int
	{
		return GL.NUM_COMPRESSED_TEXTURE_FORMATS;
	}

	@:noCompletion private inline function get_COMPRESSED_TEXTURE_FORMATS():Int
	{
		return GL.COMPRESSED_TEXTURE_FORMATS;
	}

	@:noCompletion private inline function get_DONT_CARE():Int
	{
		return GL.DONT_CARE;
	}

	@:noCompletion private inline function get_FASTEST():Int
	{
		return GL.FASTEST;
	}

	@:noCompletion private inline function get_NICEST():Int
	{
		return GL.NICEST;
	}

	@:noCompletion private inline function get_GENERATE_MIPMAP_HINT():Int
	{
		return GL.GENERATE_MIPMAP_HINT;
	}

	@:noCompletion private inline function get_BYTE():Int
	{
		return GL.BYTE;
	}

	@:noCompletion private inline function get_UNSIGNED_BYTE():Int
	{
		return GL.UNSIGNED_BYTE;
	}

	@:noCompletion private inline function get_SHORT():Int
	{
		return GL.SHORT;
	}

	@:noCompletion private inline function get_UNSIGNED_SHORT():Int
	{
		return GL.UNSIGNED_SHORT;
	}

	@:noCompletion private inline function get_INT():Int
	{
		return GL.INT;
	}

	@:noCompletion private inline function get_UNSIGNED_INT():Int
	{
		return GL.UNSIGNED_INT;
	}

	@:noCompletion private inline function get_FLOAT():Int
	{
		return GL.FLOAT;
	}

	@:noCompletion private inline function get_FIXED():Int
	{
		return GL.FIXED;
	}

	@:noCompletion private inline function get_DEPTH_COMPONENT():Int
	{
		return GL.DEPTH_COMPONENT;
	}

	@:noCompletion private inline function get_ALPHA():Int
	{
		return GL.ALPHA;
	}

	@:noCompletion private inline function get_RGB():Int
	{
		return GL.RGB;
	}

	@:noCompletion private inline function get_RGBA():Int
	{
		return GL.RGBA;
	}

	@:noCompletion private inline function get_LUMINANCE():Int
	{
		return GL.LUMINANCE;
	}

	@:noCompletion private inline function get_LUMINANCE_ALPHA():Int
	{
		return GL.LUMINANCE_ALPHA;
	}

	@:noCompletion private inline function get_UNSIGNED_SHORT_4_4_4_4():Int
	{
		return GL.UNSIGNED_SHORT_4_4_4_4;
	}

	@:noCompletion private inline function get_UNSIGNED_SHORT_5_5_5_1():Int
	{
		return GL.UNSIGNED_SHORT_5_5_5_1;
	}

	@:noCompletion private inline function get_UNSIGNED_SHORT_5_6_5():Int
	{
		return GL.UNSIGNED_SHORT_5_6_5;
	}

	@:noCompletion private inline function get_FRAGMENT_SHADER():Int
	{
		return GL.FRAGMENT_SHADER;
	}

	@:noCompletion private inline function get_VERTEX_SHADER():Int
	{
		return GL.VERTEX_SHADER;
	}

	@:noCompletion private inline function get_MAX_VERTEX_ATTRIBS():Int
	{
		return GL.MAX_VERTEX_ATTRIBS;
	}

	@:noCompletion private inline function get_MAX_VERTEX_UNIFORM_VECTORS():Int
	{
		return GL.MAX_VERTEX_UNIFORM_VECTORS;
	}

	@:noCompletion private inline function get_MAX_VARYING_VECTORS():Int
	{
		return GL.MAX_VARYING_VECTORS;
	}

	@:noCompletion private inline function get_MAX_COMBINED_TEXTURE_IMAGE_UNITS():Int
	{
		return GL.MAX_COMBINED_TEXTURE_IMAGE_UNITS;
	}

	@:noCompletion private inline function get_MAX_VERTEX_TEXTURE_IMAGE_UNITS():Int
	{
		return GL.MAX_VERTEX_TEXTURE_IMAGE_UNITS;
	}

	@:noCompletion private inline function get_MAX_TEXTURE_IMAGE_UNITS():Int
	{
		return GL.MAX_TEXTURE_IMAGE_UNITS;
	}

	@:noCompletion private inline function get_MAX_FRAGMENT_UNIFORM_VECTORS():Int
	{
		return GL.MAX_FRAGMENT_UNIFORM_VECTORS;
	}

	@:noCompletion private inline function get_SHADER_TYPE():Int
	{
		return GL.SHADER_TYPE;
	}

	@:noCompletion private inline function get_DELETE_STATUS():Int
	{
		return GL.DELETE_STATUS;
	}

	@:noCompletion private inline function get_LINK_STATUS():Int
	{
		return GL.LINK_STATUS;
	}

	@:noCompletion private inline function get_VALIDATE_STATUS():Int
	{
		return GL.VALIDATE_STATUS;
	}

	@:noCompletion private inline function get_ATTACHED_SHADERS():Int
	{
		return GL.ATTACHED_SHADERS;
	}

	@:noCompletion private inline function get_ACTIVE_UNIFORMS():Int
	{
		return GL.ACTIVE_UNIFORMS;
	}

	@:noCompletion private inline function get_ACTIVE_UNIFORMS_MAX_LENGTH():Int
	{
		return GL.ACTIVE_UNIFORMS_MAX_LENGTH;
	}

	@:noCompletion private inline function get_ACTIVE_ATTRIBUTES():Int
	{
		return GL.ACTIVE_ATTRIBUTES;
	}

	@:noCompletion private inline function get_ACTIVE_ATTRIBUTES_MAX_LENGTH():Int
	{
		return GL.ACTIVE_ATTRIBUTES_MAX_LENGTH;
	}

	@:noCompletion private inline function get_SHADING_LANGUAGE_VERSION():Int
	{
		return GL.SHADING_LANGUAGE_VERSION;
	}

	@:noCompletion private inline function get_CURRENT_PROGRAM():Int
	{
		return GL.CURRENT_PROGRAM;
	}

	@:noCompletion private inline function get_NEVER():Int
	{
		return GL.NEVER;
	}

	@:noCompletion private inline function get_LESS():Int
	{
		return GL.LESS;
	}

	@:noCompletion private inline function get_EQUAL():Int
	{
		return GL.EQUAL;
	}

	@:noCompletion private inline function get_LEQUAL():Int
	{
		return GL.LEQUAL;
	}

	@:noCompletion private inline function get_GREATER():Int
	{
		return GL.GREATER;
	}

	@:noCompletion private inline function get_NOTEQUAL():Int
	{
		return GL.NOTEQUAL;
	}

	@:noCompletion private inline function get_GEQUAL():Int
	{
		return GL.GEQUAL;
	}

	@:noCompletion private inline function get_ALWAYS():Int
	{
		return GL.ALWAYS;
	}

	@:noCompletion private inline function get_KEEP():Int
	{
		return GL.KEEP;
	}

	@:noCompletion private inline function get_REPLACE():Int
	{
		return GL.REPLACE;
	}

	@:noCompletion private inline function get_INCR():Int
	{
		return GL.INCR;
	}

	@:noCompletion private inline function get_DECR():Int
	{
		return GL.DECR;
	}

	@:noCompletion private inline function get_INVERT():Int
	{
		return GL.INVERT;
	}

	@:noCompletion private inline function get_INCR_WRAP():Int
	{
		return GL.INCR_WRAP;
	}

	@:noCompletion private inline function get_DECR_WRAP():Int
	{
		return GL.DECR_WRAP;
	}

	@:noCompletion private inline function get_VENDOR():Int
	{
		return GL.VENDOR;
	}

	@:noCompletion private inline function get_RENDERER():Int
	{
		return GL.RENDERER;
	}

	@:noCompletion private inline function get_VERSION():Int
	{
		return GL.VERSION;
	}

	@:noCompletion private inline function get_EXTENSIONS():Int
	{
		return GL.EXTENSIONS;
	}

	@:noCompletion private inline function get_NEAREST():Int
	{
		return GL.NEAREST;
	}

	@:noCompletion private inline function get_LINEAR():Int
	{
		return GL.LINEAR;
	}

	@:noCompletion private inline function get_NEAREST_MIPMAP_NEAREST():Int
	{
		return GL.NEAREST_MIPMAP_NEAREST;
	}

	@:noCompletion private inline function get_LINEAR_MIPMAP_NEAREST():Int
	{
		return GL.LINEAR_MIPMAP_NEAREST;
	}

	@:noCompletion private inline function get_NEAREST_MIPMAP_LINEAR():Int
	{
		return GL.NEAREST_MIPMAP_LINEAR;
	}

	@:noCompletion private inline function get_LINEAR_MIPMAP_LINEAR():Int
	{
		return GL.LINEAR_MIPMAP_LINEAR;
	}

	@:noCompletion private inline function get_TEXTURE_MAG_FILTER():Int
	{
		return GL.TEXTURE_MAG_FILTER;
	}

	@:noCompletion private inline function get_TEXTURE_MIN_FILTER():Int
	{
		return GL.TEXTURE_MIN_FILTER;
	}

	@:noCompletion private inline function get_TEXTURE_WRAP_S():Int
	{
		return GL.TEXTURE_WRAP_S;
	}

	@:noCompletion private inline function get_TEXTURE_WRAP_T():Int
	{
		return GL.TEXTURE_WRAP_T;
	}

	@:noCompletion private inline function get_TEXTURE():Int
	{
		return GL.TEXTURE;
	}

	@:noCompletion private inline function get_TEXTURE_CUBE_MAP():Int
	{
		return GL.TEXTURE_CUBE_MAP;
	}

	@:noCompletion private inline function get_TEXTURE_BINDING_CUBE_MAP():Int
	{
		return GL.TEXTURE_BINDING_CUBE_MAP;
	}

	@:noCompletion private inline function get_TEXTURE_CUBE_MAP_POSITIVE_X():Int
	{
		return GL.TEXTURE_CUBE_MAP_POSITIVE_X;
	}

	@:noCompletion private inline function get_TEXTURE_CUBE_MAP_NEGATIVE_X():Int
	{
		return GL.TEXTURE_CUBE_MAP_NEGATIVE_X;
	}

	@:noCompletion private inline function get_TEXTURE_CUBE_MAP_POSITIVE_Y():Int
	{
		return GL.TEXTURE_CUBE_MAP_POSITIVE_Y;
	}

	@:noCompletion private inline function get_TEXTURE_CUBE_MAP_NEGATIVE_Y():Int
	{
		return GL.TEXTURE_CUBE_MAP_NEGATIVE_Y;
	}

	@:noCompletion private inline function get_TEXTURE_CUBE_MAP_POSITIVE_Z():Int
	{
		return GL.TEXTURE_CUBE_MAP_POSITIVE_Z;
	}

	@:noCompletion private inline function get_TEXTURE_CUBE_MAP_NEGATIVE_Z():Int
	{
		return GL.TEXTURE_CUBE_MAP_NEGATIVE_Z;
	}

	@:noCompletion private inline function get_MAX_CUBE_MAP_TEXTURE_SIZE():Int
	{
		return GL.MAX_CUBE_MAP_TEXTURE_SIZE;
	}

	@:noCompletion private inline function get_TEXTURE0():Int
	{
		return GL.TEXTURE0;
	}

	@:noCompletion private inline function get_TEXTURE1():Int
	{
		return GL.TEXTURE1;
	}

	@:noCompletion private inline function get_TEXTURE2():Int
	{
		return GL.TEXTURE2;
	}

	@:noCompletion private inline function get_TEXTURE3():Int
	{
		return GL.TEXTURE3;
	}

	@:noCompletion private inline function get_TEXTURE4():Int
	{
		return GL.TEXTURE4;
	}

	@:noCompletion private inline function get_TEXTURE5():Int
	{
		return GL.TEXTURE5;
	}

	@:noCompletion private inline function get_TEXTURE6():Int
	{
		return GL.TEXTURE6;
	}

	@:noCompletion private inline function get_TEXTURE7():Int
	{
		return GL.TEXTURE7;
	}

	@:noCompletion private inline function get_TEXTURE8():Int
	{
		return GL.TEXTURE8;
	}

	@:noCompletion private inline function get_TEXTURE9():Int
	{
		return GL.TEXTURE9;
	}

	@:noCompletion private inline function get_TEXTURE10():Int
	{
		return GL.TEXTURE10;
	}

	@:noCompletion private inline function get_TEXTURE11():Int
	{
		return GL.TEXTURE11;
	}

	@:noCompletion private inline function get_TEXTURE12():Int
	{
		return GL.TEXTURE12;
	}

	@:noCompletion private inline function get_TEXTURE13():Int
	{
		return GL.TEXTURE13;
	}

	@:noCompletion private inline function get_TEXTURE14():Int
	{
		return GL.TEXTURE14;
	}

	@:noCompletion private inline function get_TEXTURE15():Int
	{
		return GL.TEXTURE15;
	}

	@:noCompletion private inline function get_TEXTURE16():Int
	{
		return GL.TEXTURE16;
	}

	@:noCompletion private inline function get_TEXTURE17():Int
	{
		return GL.TEXTURE17;
	}

	@:noCompletion private inline function get_TEXTURE18():Int
	{
		return GL.TEXTURE18;
	}

	@:noCompletion private inline function get_TEXTURE19():Int
	{
		return GL.TEXTURE19;
	}

	@:noCompletion private inline function get_TEXTURE20():Int
	{
		return GL.TEXTURE20;
	}

	@:noCompletion private inline function get_TEXTURE21():Int
	{
		return GL.TEXTURE21;
	}

	@:noCompletion private inline function get_TEXTURE22():Int
	{
		return GL.TEXTURE22;
	}

	@:noCompletion private inline function get_TEXTURE23():Int
	{
		return GL.TEXTURE23;
	}

	@:noCompletion private inline function get_TEXTURE24():Int
	{
		return GL.TEXTURE24;
	}

	@:noCompletion private inline function get_TEXTURE25():Int
	{
		return GL.TEXTURE25;
	}

	@:noCompletion private inline function get_TEXTURE26():Int
	{
		return GL.TEXTURE26;
	}

	@:noCompletion private inline function get_TEXTURE27():Int
	{
		return GL.TEXTURE27;
	}

	@:noCompletion private inline function get_TEXTURE28():Int
	{
		return GL.TEXTURE28;
	}

	@:noCompletion private inline function get_TEXTURE29():Int
	{
		return GL.TEXTURE29;
	}

	@:noCompletion private inline function get_TEXTURE30():Int
	{
		return GL.TEXTURE30;
	}

	@:noCompletion private inline function get_TEXTURE31():Int
	{
		return GL.TEXTURE31;
	}

	@:noCompletion private inline function get_ACTIVE_TEXTURE():Int
	{
		return GL.ACTIVE_TEXTURE;
	}

	@:noCompletion private inline function get_REPEAT():Int
	{
		return GL.REPEAT;
	}

	@:noCompletion private inline function get_CLAMP_TO_EDGE():Int
	{
		return GL.CLAMP_TO_EDGE;
	}

	@:noCompletion private inline function get_MIRRORED_REPEAT():Int
	{
		return GL.MIRRORED_REPEAT;
	}

	@:noCompletion private inline function get_FLOAT_VEC2():Int
	{
		return GL.FLOAT_VEC2;
	}

	@:noCompletion private inline function get_FLOAT_VEC3():Int
	{
		return GL.FLOAT_VEC3;
	}

	@:noCompletion private inline function get_FLOAT_VEC4():Int
	{
		return GL.FLOAT_VEC4;
	}

	@:noCompletion private inline function get_INT_VEC2():Int
	{
		return GL.INT_VEC2;
	}

	@:noCompletion private inline function get_INT_VEC3():Int
	{
		return GL.INT_VEC3;
	}

	@:noCompletion private inline function get_INT_VEC4():Int
	{
		return GL.INT_VEC4;
	}

	@:noCompletion private inline function get_BOOL():Int
	{
		return GL.BOOL;
	}

	@:noCompletion private inline function get_BOOL_VEC2():Int
	{
		return GL.BOOL_VEC2;
	}

	@:noCompletion private inline function get_BOOL_VEC3():Int
	{
		return GL.BOOL_VEC3;
	}

	@:noCompletion private inline function get_BOOL_VEC4():Int
	{
		return GL.BOOL_VEC4;
	}

	@:noCompletion private inline function get_FLOAT_MAT2():Int
	{
		return GL.FLOAT_MAT2;
	}

	@:noCompletion private inline function get_FLOAT_MAT3():Int
	{
		return GL.FLOAT_MAT3;
	}

	@:noCompletion private inline function get_FLOAT_MAT4():Int
	{
		return GL.FLOAT_MAT4;
	}

	@:noCompletion private inline function get_SAMPLER_2D():Int
	{
		return GL.SAMPLER_2D;
	}

	@:noCompletion private inline function get_SAMPLER_CUBE():Int
	{
		return GL.SAMPLER_CUBE;
	}

	@:noCompletion private inline function get_VERTEX_ATTRIB_ARRAY_ENABLED():Int
	{
		return GL.VERTEX_ATTRIB_ARRAY_ENABLED;
	}

	@:noCompletion private inline function get_VERTEX_ATTRIB_ARRAY_SIZE():Int
	{
		return GL.VERTEX_ATTRIB_ARRAY_SIZE;
	}

	@:noCompletion private inline function get_VERTEX_ATTRIB_ARRAY_STRIDE():Int
	{
		return GL.VERTEX_ATTRIB_ARRAY_STRIDE;
	}

	@:noCompletion private inline function get_VERTEX_ATTRIB_ARRAY_TYPE():Int
	{
		return GL.VERTEX_ATTRIB_ARRAY_TYPE;
	}

	@:noCompletion private inline function get_VERTEX_ATTRIB_ARRAY_NORMALIZED():Int
	{
		return GL.VERTEX_ATTRIB_ARRAY_NORMALIZED;
	}

	@:noCompletion private inline function get_VERTEX_ATTRIB_ARRAY_POINTER():Int
	{
		return GL.VERTEX_ATTRIB_ARRAY_POINTER;
	}

	@:noCompletion private inline function get_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING():Int
	{
		return GL.VERTEX_ATTRIB_ARRAY_BUFFER_BINDING;
	}

	@:noCompletion private inline function get_IMPLEMENTATION_COLOR_READ_TYPE():Int
	{
		return GL.IMPLEMENTATION_COLOR_READ_TYPE;
	}

	@:noCompletion private inline function get_IMPLEMENTATION_COLOR_READ_FORMAT():Int
	{
		return GL.IMPLEMENTATION_COLOR_READ_FORMAT;
	}

	@:noCompletion private inline function get_VERTEX_PROGRAM_POINT_SIZE():Int
	{
		return GL.VERTEX_PROGRAM_POINT_SIZE;
	}

	@:noCompletion private inline function get_POINT_SPRITE():Int
	{
		return GL.POINT_SPRITE;
	}

	@:noCompletion private inline function get_COMPILE_STATUS():Int
	{
		return GL.COMPILE_STATUS;
	}

	@:noCompletion private inline function get_INFO_LOG_LENGTH():Int
	{
		return GL.INFO_LOG_LENGTH;
	}

	@:noCompletion private inline function get_SHADER_SOURCE_LENGTH():Int
	{
		return GL.SHADER_SOURCE_LENGTH;
	}

	@:noCompletion private inline function get_SHADER_COMPILER():Int
	{
		return GL.SHADER_COMPILER;
	}

	@:noCompletion private inline function get_SHADER_BINARY_FORMATS():Int
	{
		return GL.SHADER_BINARY_FORMATS;
	}

	@:noCompletion private inline function get_NUM_SHADER_BINARY_FORMATS():Int
	{
		return GL.NUM_SHADER_BINARY_FORMATS;
	}

	@:noCompletion private inline function get_LOW_FLOAT():Int
	{
		return GL.LOW_FLOAT;
	}

	@:noCompletion private inline function get_MEDIUM_FLOAT():Int
	{
		return GL.MEDIUM_FLOAT;
	}

	@:noCompletion private inline function get_HIGH_FLOAT():Int
	{
		return GL.HIGH_FLOAT;
	}

	@:noCompletion private inline function get_LOW_INT():Int
	{
		return GL.LOW_INT;
	}

	@:noCompletion private inline function get_MEDIUM_INT():Int
	{
		return GL.MEDIUM_INT;
	}

	@:noCompletion private inline function get_HIGH_INT():Int
	{
		return GL.HIGH_INT;
	}

	@:noCompletion private inline function get_FRAMEBUFFER():Int
	{
		return GL.FRAMEBUFFER;
	}

	@:noCompletion private inline function get_RENDERBUFFER():Int
	{
		return GL.RENDERBUFFER;
	}

	@:noCompletion private inline function get_RGBA4():Int
	{
		return GL.RGBA4;
	}

	@:noCompletion private inline function get_RGB5_A1():Int
	{
		return GL.RGB5_A1;
	}

	@:noCompletion private inline function get_RGB565():Int
	{
		return GL.RGB565;
	}

	@:noCompletion private inline function get_DEPTH_COMPONENT16():Int
	{
		return GL.DEPTH_COMPONENT16;
	}

	@:noCompletion private inline function get_STENCIL_INDEX():Int
	{
		return GL.STENCIL_INDEX;
	}

	@:noCompletion private inline function get_STENCIL_INDEX8():Int
	{
		return GL.STENCIL_INDEX8;
	}

	@:noCompletion private inline function get_DEPTH_STENCIL():Int
	{
		return GL.DEPTH_STENCIL;
	}

	@:noCompletion private inline function get_RENDERBUFFER_WIDTH():Int
	{
		return GL.RENDERBUFFER_WIDTH;
	}

	@:noCompletion private inline function get_RENDERBUFFER_HEIGHT():Int
	{
		return GL.RENDERBUFFER_HEIGHT;
	}

	@:noCompletion private inline function get_RENDERBUFFER_INTERNAL_FORMAT():Int
	{
		return GL.RENDERBUFFER_INTERNAL_FORMAT;
	}

	@:noCompletion private inline function get_RENDERBUFFER_RED_SIZE():Int
	{
		return GL.RENDERBUFFER_RED_SIZE;
	}

	@:noCompletion private inline function get_RENDERBUFFER_GREEN_SIZE():Int
	{
		return GL.RENDERBUFFER_GREEN_SIZE;
	}

	@:noCompletion private inline function get_RENDERBUFFER_BLUE_SIZE():Int
	{
		return GL.RENDERBUFFER_BLUE_SIZE;
	}

	@:noCompletion private inline function get_RENDERBUFFER_ALPHA_SIZE():Int
	{
		return GL.RENDERBUFFER_ALPHA_SIZE;
	}

	@:noCompletion private inline function get_RENDERBUFFER_DEPTH_SIZE():Int
	{
		return GL.RENDERBUFFER_DEPTH_SIZE;
	}

	@:noCompletion private inline function get_RENDERBUFFER_STENCIL_SIZE():Int
	{
		return GL.RENDERBUFFER_STENCIL_SIZE;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE():Int
	{
		return GL.FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME():Int
	{
		return GL.FRAMEBUFFER_ATTACHMENT_OBJECT_NAME;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL():Int
	{
		return GL.FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE():Int
	{
		return GL.FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE;
	}

	@:noCompletion private inline function get_COLOR_ATTACHMENT0():Int
	{
		return GL.COLOR_ATTACHMENT0;
	}

	@:noCompletion private inline function get_DEPTH_ATTACHMENT():Int
	{
		return GL.DEPTH_ATTACHMENT;
	}

	@:noCompletion private inline function get_STENCIL_ATTACHMENT():Int
	{
		return GL.STENCIL_ATTACHMENT;
	}

	@:noCompletion private inline function get_DEPTH_STENCIL_ATTACHMENT():Int
	{
		return GL.DEPTH_STENCIL_ATTACHMENT;
	}

	@:noCompletion private inline function get_NONE():Int
	{
		return GL.NONE;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_COMPLETE():Int
	{
		return GL.FRAMEBUFFER_COMPLETE;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_INCOMPLETE_ATTACHMENT():Int
	{
		return GL.FRAMEBUFFER_INCOMPLETE_ATTACHMENT;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT():Int
	{
		return GL.FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_INCOMPLETE_DIMENSIONS():Int
	{
		return GL.FRAMEBUFFER_INCOMPLETE_DIMENSIONS;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_UNSUPPORTED():Int
	{
		return GL.FRAMEBUFFER_UNSUPPORTED;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_BINDING():Int
	{
		return GL.FRAMEBUFFER_BINDING;
	}

	@:noCompletion private inline function get_RENDERBUFFER_BINDING():Int
	{
		return GL.RENDERBUFFER_BINDING;
	}

	@:noCompletion private inline function get_MAX_RENDERBUFFER_SIZE():Int
	{
		return GL.MAX_RENDERBUFFER_SIZE;
	}

	@:noCompletion private inline function get_INVALID_FRAMEBUFFER_OPERATION():Int
	{
		return GL.INVALID_FRAMEBUFFER_OPERATION;
	}

	@:noCompletion private inline function get_READ_BUFFER():Int
	{
		return GL.READ_BUFFER;
	}

	@:noCompletion private inline function get_UNPACK_ROW_LENGTH():Int
	{
		return GL.UNPACK_ROW_LENGTH;
	}

	@:noCompletion private inline function get_UNPACK_SKIP_ROWS():Int
	{
		return GL.UNPACK_SKIP_ROWS;
	}

	@:noCompletion private inline function get_UNPACK_SKIP_PIXELS():Int
	{
		return GL.UNPACK_SKIP_PIXELS;
	}

	@:noCompletion private inline function get_PACK_ROW_LENGTH():Int
	{
		return GL.PACK_ROW_LENGTH;
	}

	@:noCompletion private inline function get_PACK_SKIP_ROWS():Int
	{
		return GL.PACK_SKIP_ROWS;
	}

	@:noCompletion private inline function get_PACK_SKIP_PIXELS():Int
	{
		return GL.PACK_SKIP_PIXELS;
	}

	@:noCompletion private inline function get_TEXTURE_BINDING_3D():Int
	{
		return GL.TEXTURE_BINDING_3D;
	}

	@:noCompletion private inline function get_UNPACK_SKIP_IMAGES():Int
	{
		return GL.UNPACK_SKIP_IMAGES;
	}

	@:noCompletion private inline function get_UNPACK_IMAGE_HEIGHT():Int
	{
		return GL.UNPACK_IMAGE_HEIGHT;
	}

	@:noCompletion private inline function get_MAX_3D_TEXTURE_SIZE():Int
	{
		return GL.MAX_3D_TEXTURE_SIZE;
	}

	@:noCompletion private inline function get_MAX_ELEMENTS_VERTICES():Int
	{
		return GL.MAX_ELEMENTS_VERTICES;
	}

	@:noCompletion private inline function get_MAX_ELEMENTS_INDICES():Int
	{
		return GL.MAX_ELEMENTS_INDICES;
	}

	@:noCompletion private inline function get_MAX_TEXTURE_LOD_BIAS():Int
	{
		return GL.MAX_TEXTURE_LOD_BIAS;
	}

	@:noCompletion private inline function get_MAX_FRAGMENT_UNIFORM_COMPONENTS():Int
	{
		return GL.MAX_FRAGMENT_UNIFORM_COMPONENTS;
	}

	@:noCompletion private inline function get_MAX_VERTEX_UNIFORM_COMPONENTS():Int
	{
		return GL.MAX_VERTEX_UNIFORM_COMPONENTS;
	}

	@:noCompletion private inline function get_MAX_ARRAY_TEXTURE_LAYERS():Int
	{
		return GL.MAX_ARRAY_TEXTURE_LAYERS;
	}

	@:noCompletion private inline function get_MIN_PROGRAM_TEXEL_OFFSET():Int
	{
		return GL.MIN_PROGRAM_TEXEL_OFFSET;
	}

	@:noCompletion private inline function get_MAX_PROGRAM_TEXEL_OFFSET():Int
	{
		return GL.MAX_PROGRAM_TEXEL_OFFSET;
	}

	@:noCompletion private inline function get_MAX_VARYING_COMPONENTS():Int
	{
		return GL.MAX_VARYING_COMPONENTS;
	}

	@:noCompletion private inline function get_FRAGMENT_SHADER_DERIVATIVE_HINT():Int
	{
		return GL.FRAGMENT_SHADER_DERIVATIVE_HINT;
	}

	@:noCompletion private inline function get_RASTERIZER_DISCARD():Int
	{
		return GL.RASTERIZER_DISCARD;
	}

	@:noCompletion private inline function get_VERTEX_ARRAY_BINDING():Int
	{
		return GL.VERTEX_ARRAY_BINDING;
	}

	@:noCompletion private inline function get_MAX_VERTEX_OUTPUT_COMPONENTS():Int
	{
		return GL.MAX_VERTEX_OUTPUT_COMPONENTS;
	}

	@:noCompletion private inline function get_MAX_FRAGMENT_INPUT_COMPONENTS():Int
	{
		return GL.MAX_FRAGMENT_INPUT_COMPONENTS;
	}

	@:noCompletion private inline function get_MAX_SERVER_WAIT_TIMEOUT():Int
	{
		return GL.MAX_SERVER_WAIT_TIMEOUT;
	}

	@:noCompletion private inline function get_MAX_ELEMENT_INDEX():Int
	{
		return GL.MAX_ELEMENT_INDEX;
	}

	@:noCompletion private inline function get_RED():Int
	{
		return GL.RED;
	}

	@:noCompletion private inline function get_RGB8():Int
	{
		return GL.RGB8;
	}

	@:noCompletion private inline function get_RGBA8():Int
	{
		return GL.RGBA8;
	}

	@:noCompletion private inline function get_RGB10_A2():Int
	{
		return GL.RGB10_A2;
	}

	@:noCompletion private inline function get_TEXTURE_3D():Int
	{
		return GL.TEXTURE_3D;
	}

	@:noCompletion private inline function get_TEXTURE_WRAP_R():Int
	{
		return GL.TEXTURE_WRAP_R;
	}

	@:noCompletion private inline function get_TEXTURE_MIN_LOD():Int
	{
		return GL.TEXTURE_MIN_LOD;
	}

	@:noCompletion private inline function get_TEXTURE_MAX_LOD():Int
	{
		return GL.TEXTURE_MAX_LOD;
	}

	@:noCompletion private inline function get_TEXTURE_BASE_LEVEL():Int
	{
		return GL.TEXTURE_BASE_LEVEL;
	}

	@:noCompletion private inline function get_TEXTURE_MAX_LEVEL():Int
	{
		return GL.TEXTURE_MAX_LEVEL;
	}

	@:noCompletion private inline function get_TEXTURE_COMPARE_MODE():Int
	{
		return GL.TEXTURE_COMPARE_MODE;
	}

	@:noCompletion private inline function get_TEXTURE_COMPARE_FUNC():Int
	{
		return GL.TEXTURE_COMPARE_FUNC;
	}

	@:noCompletion private inline function get_SRGB():Int
	{
		return GL.SRGB;
	}

	@:noCompletion private inline function get_SRGB8():Int
	{
		return GL.SRGB8;
	}

	@:noCompletion private inline function get_SRGB8_ALPHA8():Int
	{
		return GL.SRGB8_ALPHA8;
	}

	@:noCompletion private inline function get_COMPARE_REF_TO_TEXTURE():Int
	{
		return GL.COMPARE_REF_TO_TEXTURE;
	}

	@:noCompletion private inline function get_RGBA32F():Int
	{
		return GL.RGBA32F;
	}

	@:noCompletion private inline function get_RGB32F():Int
	{
		return GL.RGB32F;
	}

	@:noCompletion private inline function get_RGBA16F():Int
	{
		return GL.RGBA16F;
	}

	@:noCompletion private inline function get_RGB16F():Int
	{
		return GL.RGB16F;
	}

	@:noCompletion private inline function get_TEXTURE_2D_ARRAY():Int
	{
		return GL.TEXTURE_2D_ARRAY;
	}

	@:noCompletion private inline function get_TEXTURE_BINDING_2D_ARRAY():Int
	{
		return GL.TEXTURE_BINDING_2D_ARRAY;
	}

	@:noCompletion private inline function get_R11F_G11F_B10F():Int
	{
		return GL.R11F_G11F_B10F;
	}

	@:noCompletion private inline function get_RGB9_E5():Int
	{
		return GL.RGB9_E5;
	}

	@:noCompletion private inline function get_RGBA32UI():Int
	{
		return GL.RGBA32UI;
	}

	@:noCompletion private inline function get_RGB32UI():Int
	{
		return GL.RGB32UI;
	}

	@:noCompletion private inline function get_RGBA16UI():Int
	{
		return GL.RGBA16UI;
	}

	@:noCompletion private inline function get_RGB16UI():Int
	{
		return GL.RGB16UI;
	}

	@:noCompletion private inline function get_RGBA8UI():Int
	{
		return GL.RGBA8UI;
	}

	@:noCompletion private inline function get_RGB8UI():Int
	{
		return GL.RGB8UI;
	}

	@:noCompletion private inline function get_RGBA32I():Int
	{
		return GL.RGBA32I;
	}

	@:noCompletion private inline function get_RGB32I():Int
	{
		return GL.RGB32I;
	}

	@:noCompletion private inline function get_RGBA16I():Int
	{
		return GL.RGBA16I;
	}

	@:noCompletion private inline function get_RGB16I():Int
	{
		return GL.RGB16I;
	}

	@:noCompletion private inline function get_RGBA8I():Int
	{
		return GL.RGBA8I;
	}

	@:noCompletion private inline function get_RGB8I():Int
	{
		return GL.RGB8I;
	}

	@:noCompletion private inline function get_RED_INTEGER():Int
	{
		return GL.RED_INTEGER;
	}

	@:noCompletion private inline function get_RGB_INTEGER():Int
	{
		return GL.RGB_INTEGER;
	}

	@:noCompletion private inline function get_RGBA_INTEGER():Int
	{
		return GL.RGBA_INTEGER;
	}

	@:noCompletion private inline function get_R8():Int
	{
		return GL.R8;
	}

	@:noCompletion private inline function get_RG8():Int
	{
		return GL.RG8;
	}

	@:noCompletion private inline function get_R16F():Int
	{
		return GL.R16F;
	}

	@:noCompletion private inline function get_R32F():Int
	{
		return GL.R32F;
	}

	@:noCompletion private inline function get_RG16F():Int
	{
		return GL.RG16F;
	}

	@:noCompletion private inline function get_RG32F():Int
	{
		return GL.RG32F;
	}

	@:noCompletion private inline function get_R8I():Int
	{
		return GL.R8I;
	}

	@:noCompletion private inline function get_R8UI():Int
	{
		return GL.R8UI;
	}

	@:noCompletion private inline function get_R16I():Int
	{
		return GL.R16I;
	}

	@:noCompletion private inline function get_R16UI():Int
	{
		return GL.R16UI;
	}

	@:noCompletion private inline function get_R32I():Int
	{
		return GL.R32I;
	}

	@:noCompletion private inline function get_R32UI():Int
	{
		return GL.R32UI;
	}

	@:noCompletion private inline function get_RG8I():Int
	{
		return GL.RG8I;
	}

	@:noCompletion private inline function get_RG8UI():Int
	{
		return GL.RG8UI;
	}

	@:noCompletion private inline function get_RG16I():Int
	{
		return GL.RG16I;
	}

	@:noCompletion private inline function get_RG16UI():Int
	{
		return GL.RG16UI;
	}

	@:noCompletion private inline function get_RG32I():Int
	{
		return GL.RG32I;
	}

	@:noCompletion private inline function get_RG32UI():Int
	{
		return GL.RG32UI;
	}

	@:noCompletion private inline function get_R8_SNORM():Int
	{
		return GL.R8_SNORM;
	}

	@:noCompletion private inline function get_RG8_SNORM():Int
	{
		return GL.RG8_SNORM;
	}

	@:noCompletion private inline function get_RGB8_SNORM():Int
	{
		return GL.RGB8_SNORM;
	}

	@:noCompletion private inline function get_RGBA8_SNORM():Int
	{
		return GL.RGBA8_SNORM;
	}

	@:noCompletion private inline function get_RGB10_A2UI():Int
	{
		return GL.RGB10_A2UI;
	}

	@:noCompletion private inline function get_TEXTURE_IMMUTABLE_FORMAT():Int
	{
		return GL.TEXTURE_IMMUTABLE_FORMAT;
	}

	@:noCompletion private inline function get_TEXTURE_IMMUTABLE_LEVELS():Int
	{
		return GL.TEXTURE_IMMUTABLE_LEVELS;
	}

	@:noCompletion private inline function get_UNSIGNED_INT_2_10_10_10_REV():Int
	{
		return GL.UNSIGNED_INT_2_10_10_10_REV;
	}

	@:noCompletion private inline function get_UNSIGNED_INT_10F_11F_11F_REV():Int
	{
		return GL.UNSIGNED_INT_10F_11F_11F_REV;
	}

	@:noCompletion private inline function get_UNSIGNED_INT_5_9_9_9_REV():Int
	{
		return GL.UNSIGNED_INT_5_9_9_9_REV;
	}

	@:noCompletion private inline function get_FLOAT_32_UNSIGNED_INT_24_8_REV():Int
	{
		return GL.FLOAT_32_UNSIGNED_INT_24_8_REV;
	}

	@:noCompletion private inline function get_UNSIGNED_INT_24_8():Int
	{
		return GL.UNSIGNED_INT_24_8;
	}

	@:noCompletion private inline function get_HALF_FLOAT():Int
	{
		return GL.HALF_FLOAT;
	}

	@:noCompletion private inline function get_RG():Int
	{
		return GL.RG;
	}

	@:noCompletion private inline function get_RG_INTEGER():Int
	{
		return GL.RG_INTEGER;
	}

	@:noCompletion private inline function get_INT_2_10_10_10_REV():Int
	{
		return GL.INT_2_10_10_10_REV;
	}

	@:noCompletion private inline function get_CURRENT_QUERY():Int
	{
		return GL.CURRENT_QUERY;
	}

	@:noCompletion private inline function get_QUERY_RESULT():Int
	{
		return GL.QUERY_RESULT;
	}

	@:noCompletion private inline function get_QUERY_RESULT_AVAILABLE():Int
	{
		return GL.QUERY_RESULT_AVAILABLE;
	}

	@:noCompletion private inline function get_ANY_SAMPLES_PASSED():Int
	{
		return GL.ANY_SAMPLES_PASSED;
	}

	@:noCompletion private inline function get_ANY_SAMPLES_PASSED_CONSERVATIVE():Int
	{
		return GL.ANY_SAMPLES_PASSED_CONSERVATIVE;
	}

	@:noCompletion private inline function get_MAX_DRAW_BUFFERS():Int
	{
		return GL.MAX_DRAW_BUFFERS;
	}

	@:noCompletion private inline function get_DRAW_BUFFER0():Int
	{
		return GL.DRAW_BUFFER0;
	}

	@:noCompletion private inline function get_DRAW_BUFFER1():Int
	{
		return GL.DRAW_BUFFER1;
	}

	@:noCompletion private inline function get_DRAW_BUFFER2():Int
	{
		return GL.DRAW_BUFFER2;
	}

	@:noCompletion private inline function get_DRAW_BUFFER3():Int
	{
		return GL.DRAW_BUFFER3;
	}

	@:noCompletion private inline function get_DRAW_BUFFER4():Int
	{
		return GL.DRAW_BUFFER4;
	}

	@:noCompletion private inline function get_DRAW_BUFFER5():Int
	{
		return GL.DRAW_BUFFER5;
	}

	@:noCompletion private inline function get_DRAW_BUFFER6():Int
	{
		return GL.DRAW_BUFFER6;
	}

	@:noCompletion private inline function get_DRAW_BUFFER7():Int
	{
		return GL.DRAW_BUFFER7;
	}

	@:noCompletion private inline function get_DRAW_BUFFER8():Int
	{
		return GL.DRAW_BUFFER8;
	}

	@:noCompletion private inline function get_DRAW_BUFFER9():Int
	{
		return GL.DRAW_BUFFER9;
	}

	@:noCompletion private inline function get_DRAW_BUFFER10():Int
	{
		return GL.DRAW_BUFFER10;
	}

	@:noCompletion private inline function get_DRAW_BUFFER11():Int
	{
		return GL.DRAW_BUFFER11;
	}

	@:noCompletion private inline function get_DRAW_BUFFER12():Int
	{
		return GL.DRAW_BUFFER12;
	}

	@:noCompletion private inline function get_DRAW_BUFFER13():Int
	{
		return GL.DRAW_BUFFER13;
	}

	@:noCompletion private inline function get_DRAW_BUFFER14():Int
	{
		return GL.DRAW_BUFFER14;
	}

	@:noCompletion private inline function get_DRAW_BUFFER15():Int
	{
		return GL.DRAW_BUFFER15;
	}

	@:noCompletion private inline function get_MAX_COLOR_ATTACHMENTS():Int
	{
		return GL.MAX_COLOR_ATTACHMENTS;
	}

	@:noCompletion private inline function get_COLOR_ATTACHMENT1():Int
	{
		return GL.COLOR_ATTACHMENT1;
	}

	@:noCompletion private inline function get_COLOR_ATTACHMENT2():Int
	{
		return GL.COLOR_ATTACHMENT2;
	}

	@:noCompletion private inline function get_COLOR_ATTACHMENT3():Int
	{
		return GL.COLOR_ATTACHMENT3;
	}

	@:noCompletion private inline function get_COLOR_ATTACHMENT4():Int
	{
		return GL.COLOR_ATTACHMENT4;
	}

	@:noCompletion private inline function get_COLOR_ATTACHMENT5():Int
	{
		return GL.COLOR_ATTACHMENT5;
	}

	@:noCompletion private inline function get_COLOR_ATTACHMENT6():Int
	{
		return GL.COLOR_ATTACHMENT6;
	}

	@:noCompletion private inline function get_COLOR_ATTACHMENT7():Int
	{
		return GL.COLOR_ATTACHMENT7;
	}

	@:noCompletion private inline function get_COLOR_ATTACHMENT8():Int
	{
		return GL.COLOR_ATTACHMENT8;
	}

	@:noCompletion private inline function get_COLOR_ATTACHMENT9():Int
	{
		return GL.COLOR_ATTACHMENT9;
	}

	@:noCompletion private inline function get_COLOR_ATTACHMENT10():Int
	{
		return GL.COLOR_ATTACHMENT10;
	}

	@:noCompletion private inline function get_COLOR_ATTACHMENT11():Int
	{
		return GL.COLOR_ATTACHMENT11;
	}

	@:noCompletion private inline function get_COLOR_ATTACHMENT12():Int
	{
		return GL.COLOR_ATTACHMENT12;
	}

	@:noCompletion private inline function get_COLOR_ATTACHMENT13():Int
	{
		return GL.COLOR_ATTACHMENT13;
	}

	@:noCompletion private inline function get_COLOR_ATTACHMENT14():Int
	{
		return GL.COLOR_ATTACHMENT14;
	}

	@:noCompletion private inline function get_COLOR_ATTACHMENT15():Int
	{
		return GL.COLOR_ATTACHMENT15;
	}

	@:noCompletion private inline function get_SAMPLER_3D():Int
	{
		return GL.SAMPLER_3D;
	}

	@:noCompletion private inline function get_SAMPLER_2D_SHADOW():Int
	{
		return GL.SAMPLER_2D_SHADOW;
	}

	@:noCompletion private inline function get_SAMPLER_2D_ARRAY():Int
	{
		return GL.SAMPLER_2D_ARRAY;
	}

	@:noCompletion private inline function get_SAMPLER_2D_ARRAY_SHADOW():Int
	{
		return GL.SAMPLER_2D_ARRAY_SHADOW;
	}

	@:noCompletion private inline function get_SAMPLER_CUBE_SHADOW():Int
	{
		return GL.SAMPLER_CUBE_SHADOW;
	}

	@:noCompletion private inline function get_INT_SAMPLER_2D():Int
	{
		return GL.INT_SAMPLER_2D;
	}

	@:noCompletion private inline function get_INT_SAMPLER_3D():Int
	{
		return GL.INT_SAMPLER_3D;
	}

	@:noCompletion private inline function get_INT_SAMPLER_CUBE():Int
	{
		return GL.INT_SAMPLER_CUBE;
	}

	@:noCompletion private inline function get_INT_SAMPLER_2D_ARRAY():Int
	{
		return GL.INT_SAMPLER_2D_ARRAY;
	}

	@:noCompletion private inline function get_UNSIGNED_INT_SAMPLER_2D():Int
	{
		return GL.UNSIGNED_INT_SAMPLER_2D;
	}

	@:noCompletion private inline function get_UNSIGNED_INT_SAMPLER_3D():Int
	{
		return GL.UNSIGNED_INT_SAMPLER_3D;
	}

	@:noCompletion private inline function get_UNSIGNED_INT_SAMPLER_CUBE():Int
	{
		return GL.UNSIGNED_INT_SAMPLER_CUBE;
	}

	@:noCompletion private inline function get_UNSIGNED_INT_SAMPLER_2D_ARRAY():Int
	{
		return GL.UNSIGNED_INT_SAMPLER_2D_ARRAY;
	}

	@:noCompletion private inline function get_MAX_SAMPLES():Int
	{
		return GL.MAX_SAMPLES;
	}

	@:noCompletion private inline function get_SAMPLER_BINDING():Int
	{
		return GL.SAMPLER_BINDING;
	}

	@:noCompletion private inline function get_PIXEL_PACK_BUFFER():Int
	{
		return GL.PIXEL_PACK_BUFFER;
	}

	@:noCompletion private inline function get_PIXEL_UNPACK_BUFFER():Int
	{
		return GL.PIXEL_UNPACK_BUFFER;
	}

	@:noCompletion private inline function get_PIXEL_PACK_BUFFER_BINDING():Int
	{
		return GL.PIXEL_PACK_BUFFER_BINDING;
	}

	@:noCompletion private inline function get_PIXEL_UNPACK_BUFFER_BINDING():Int
	{
		return GL.PIXEL_UNPACK_BUFFER_BINDING;
	}

	@:noCompletion private inline function get_COPY_READ_BUFFER():Int
	{
		return GL.COPY_READ_BUFFER;
	}

	@:noCompletion private inline function get_COPY_WRITE_BUFFER():Int
	{
		return GL.COPY_WRITE_BUFFER;
	}

	@:noCompletion private inline function get_COPY_READ_BUFFER_BINDING():Int
	{
		return GL.COPY_READ_BUFFER_BINDING;
	}

	@:noCompletion private inline function get_COPY_WRITE_BUFFER_BINDING():Int
	{
		return GL.COPY_WRITE_BUFFER_BINDING;
	}

	@:noCompletion private inline function get_UNSIGNED_INT_VEC2():Int
	{
		return GL.UNSIGNED_INT_VEC2;
	}

	@:noCompletion private inline function get_UNSIGNED_INT_VEC3():Int
	{
		return GL.UNSIGNED_INT_VEC3;
	}

	@:noCompletion private inline function get_UNSIGNED_INT_VEC4():Int
	{
		return GL.UNSIGNED_INT_VEC4;
	}

	@:noCompletion private inline function get_UNSIGNED_NORMALIZED():Int
	{
		return GL.UNSIGNED_NORMALIZED;
	}

	@:noCompletion private inline function get_SIGNED_NORMALIZED():Int
	{
		return GL.SIGNED_NORMALIZED;
	}

	@:noCompletion private inline function get_VERTEX_ATTRIB_ARRAY_INTEGER():Int
	{
		return GL.VERTEX_ATTRIB_ARRAY_INTEGER;
	}

	@:noCompletion private inline function get_VERTEX_ATTRIB_ARRAY_DIVISOR():Int
	{
		return GL.VERTEX_ATTRIB_ARRAY_DIVISOR;
	}

	@:noCompletion private inline function get_TRANSFORM_FEEDBACK_BUFFER_MODE():Int
	{
		return GL.TRANSFORM_FEEDBACK_BUFFER_MODE;
	}

	@:noCompletion private inline function get_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS():Int
	{
		return GL.MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS;
	}

	@:noCompletion private inline function get_TRANSFORM_FEEDBACK_VARYINGS():Int
	{
		return GL.TRANSFORM_FEEDBACK_VARYINGS;
	}

	@:noCompletion private inline function get_TRANSFORM_FEEDBACK_BUFFER_START():Int
	{
		return GL.TRANSFORM_FEEDBACK_BUFFER_START;
	}

	@:noCompletion private inline function get_TRANSFORM_FEEDBACK_BUFFER_SIZE():Int
	{
		return GL.TRANSFORM_FEEDBACK_BUFFER_SIZE;
	}

	@:noCompletion private inline function get_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN():Int
	{
		return GL.TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN;
	}

	@:noCompletion private inline function get_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS():Int
	{
		return GL.MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS;
	}

	@:noCompletion private inline function get_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS():Int
	{
		return GL.MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS;
	}

	@:noCompletion private inline function get_INTERLEAVED_ATTRIBS():Int
	{
		return GL.INTERLEAVED_ATTRIBS;
	}

	@:noCompletion private inline function get_SEPARATE_ATTRIBS():Int
	{
		return GL.SEPARATE_ATTRIBS;
	}

	@:noCompletion private inline function get_TRANSFORM_FEEDBACK_BUFFER():Int
	{
		return GL.TRANSFORM_FEEDBACK_BUFFER;
	}

	@:noCompletion private inline function get_TRANSFORM_FEEDBACK_BUFFER_BINDING():Int
	{
		return GL.TRANSFORM_FEEDBACK_BUFFER_BINDING;
	}

	@:noCompletion private inline function get_TRANSFORM_FEEDBACK():Int
	{
		return GL.TRANSFORM_FEEDBACK;
	}

	@:noCompletion private inline function get_TRANSFORM_FEEDBACK_PAUSED():Int
	{
		return GL.TRANSFORM_FEEDBACK_PAUSED;
	}

	@:noCompletion private inline function get_TRANSFORM_FEEDBACK_ACTIVE():Int
	{
		return GL.TRANSFORM_FEEDBACK_ACTIVE;
	}

	@:noCompletion private inline function get_TRANSFORM_FEEDBACK_BINDING():Int
	{
		return GL.TRANSFORM_FEEDBACK_BINDING;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING():Int
	{
		return GL.FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE():Int
	{
		return GL.FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_ATTACHMENT_RED_SIZE():Int
	{
		return GL.FRAMEBUFFER_ATTACHMENT_RED_SIZE;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE():Int
	{
		return GL.FRAMEBUFFER_ATTACHMENT_GREEN_SIZE;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE():Int
	{
		return GL.FRAMEBUFFER_ATTACHMENT_BLUE_SIZE;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE():Int
	{
		return GL.FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE():Int
	{
		return GL.FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE():Int
	{
		return GL.FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_DEFAULT():Int
	{
		return GL.FRAMEBUFFER_DEFAULT;
	}

	@:noCompletion private inline function get_DEPTH24_STENCIL8():Int
	{
		return GL.DEPTH24_STENCIL8;
	}

	@:noCompletion private inline function get_DRAW_FRAMEBUFFER_BINDING():Int
	{
		return GL.DRAW_FRAMEBUFFER_BINDING;
	}

	@:noCompletion private inline function get_READ_FRAMEBUFFER():Int
	{
		return GL.READ_FRAMEBUFFER;
	}

	@:noCompletion private inline function get_DRAW_FRAMEBUFFER():Int
	{
		return GL.DRAW_FRAMEBUFFER;
	}

	@:noCompletion private inline function get_READ_FRAMEBUFFER_BINDING():Int
	{
		return GL.READ_FRAMEBUFFER_BINDING;
	}

	@:noCompletion private inline function get_RENDERBUFFER_SAMPLES():Int
	{
		return GL.RENDERBUFFER_SAMPLES;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER():Int
	{
		return GL.FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE():Int
	{
		return GL.FRAMEBUFFER_INCOMPLETE_MULTISAMPLE;
	}

	@:noCompletion private inline function get_UNIFORM_BUFFER():Int
	{
		return GL.UNIFORM_BUFFER;
	}

	@:noCompletion private inline function get_UNIFORM_BUFFER_BINDING():Int
	{
		return GL.UNIFORM_BUFFER_BINDING;
	}

	@:noCompletion private inline function get_UNIFORM_BUFFER_START():Int
	{
		return GL.UNIFORM_BUFFER_START;
	}

	@:noCompletion private inline function get_UNIFORM_BUFFER_SIZE():Int
	{
		return GL.UNIFORM_BUFFER_SIZE;
	}

	@:noCompletion private inline function get_MAX_VERTEX_UNIFORM_BLOCKS():Int
	{
		return GL.MAX_VERTEX_UNIFORM_BLOCKS;
	}

	@:noCompletion private inline function get_MAX_FRAGMENT_UNIFORM_BLOCKS():Int
	{
		return GL.MAX_FRAGMENT_UNIFORM_BLOCKS;
	}

	@:noCompletion private inline function get_MAX_COMBINED_UNIFORM_BLOCKS():Int
	{
		return GL.MAX_COMBINED_UNIFORM_BLOCKS;
	}

	@:noCompletion private inline function get_MAX_UNIFORM_BUFFER_BINDINGS():Int
	{
		return GL.MAX_UNIFORM_BUFFER_BINDINGS;
	}

	@:noCompletion private inline function get_MAX_UNIFORM_BLOCK_SIZE():Int
	{
		return GL.MAX_UNIFORM_BLOCK_SIZE;
	}

	@:noCompletion private inline function get_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS():Int
	{
		return GL.MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS;
	}

	@:noCompletion private inline function get_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS():Int
	{
		return GL.MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS;
	}

	@:noCompletion private inline function get_UNIFORM_BUFFER_OFFSET_ALIGNMENT():Int
	{
		return GL.UNIFORM_BUFFER_OFFSET_ALIGNMENT;
	}

	@:noCompletion private inline function get_ACTIVE_UNIFORM_BLOCKS():Int
	{
		return GL.ACTIVE_UNIFORM_BLOCKS;
	}

	@:noCompletion private inline function get_UNIFORM_TYPE():Int
	{
		return GL.UNIFORM_TYPE;
	}

	@:noCompletion private inline function get_UNIFORM_SIZE():Int
	{
		return GL.UNIFORM_SIZE;
	}

	@:noCompletion private inline function get_UNIFORM_BLOCK_INDEX():Int
	{
		return GL.UNIFORM_BLOCK_INDEX;
	}

	@:noCompletion private inline function get_UNIFORM_OFFSET():Int
	{
		return GL.UNIFORM_OFFSET;
	}

	@:noCompletion private inline function get_UNIFORM_ARRAY_STRIDE():Int
	{
		return GL.UNIFORM_ARRAY_STRIDE;
	}

	@:noCompletion private inline function get_UNIFORM_MATRIX_STRIDE():Int
	{
		return GL.UNIFORM_MATRIX_STRIDE;
	}

	@:noCompletion private inline function get_UNIFORM_IS_ROW_MAJOR():Int
	{
		return GL.UNIFORM_IS_ROW_MAJOR;
	}

	@:noCompletion private inline function get_UNIFORM_BLOCK_BINDING():Int
	{
		return GL.UNIFORM_BLOCK_BINDING;
	}

	@:noCompletion private inline function get_UNIFORM_BLOCK_DATA_SIZE():Int
	{
		return GL.UNIFORM_BLOCK_DATA_SIZE;
	}

	@:noCompletion private inline function get_UNIFORM_BLOCK_ACTIVE_UNIFORMS():Int
	{
		return GL.UNIFORM_BLOCK_ACTIVE_UNIFORMS;
	}

	@:noCompletion private inline function get_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES():Int
	{
		return GL.UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES;
	}

	@:noCompletion private inline function get_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER():Int
	{
		return GL.UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER;
	}

	@:noCompletion private inline function get_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER():Int
	{
		return GL.UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER;
	}

	@:noCompletion private inline function get_OBJECT_TYPE():Int
	{
		return GL.OBJECT_TYPE;
	}

	@:noCompletion private inline function get_SYNC_CONDITION():Int
	{
		return GL.SYNC_CONDITION;
	}

	@:noCompletion private inline function get_SYNC_STATUS():Int
	{
		return GL.SYNC_STATUS;
	}

	@:noCompletion private inline function get_SYNC_FLAGS():Int
	{
		return GL.SYNC_FLAGS;
	}

	@:noCompletion private inline function get_SYNC_FENCE():Int
	{
		return GL.SYNC_FENCE;
	}

	@:noCompletion private inline function get_SYNC_GPU_COMMANDS_COMPLETE():Int
	{
		return GL.SYNC_GPU_COMMANDS_COMPLETE;
	}

	@:noCompletion private inline function get_UNSIGNALED():Int
	{
		return GL.UNSIGNALED;
	}

	@:noCompletion private inline function get_SIGNALED():Int
	{
		return GL.SIGNALED;
	}

	@:noCompletion private inline function get_ALREADY_SIGNALED():Int
	{
		return GL.ALREADY_SIGNALED;
	}

	@:noCompletion private inline function get_TIMEOUT_EXPIRED():Int
	{
		return GL.TIMEOUT_EXPIRED;
	}

	@:noCompletion private inline function get_CONDITION_SATISFIED():Int
	{
		return GL.CONDITION_SATISFIED;
	}

	@:noCompletion private inline function get_WAIT_FAILED():Int
	{
		return GL.WAIT_FAILED;
	}

	@:noCompletion private inline function get_SYNC_FLUSH_COMMANDS_BIT():Int
	{
		return GL.SYNC_FLUSH_COMMANDS_BIT;
	}

	@:noCompletion private inline function get_COLOR():Int
	{
		return GL.COLOR;
	}

	@:noCompletion private inline function get_DEPTH():Int
	{
		return GL.DEPTH;
	}

	@:noCompletion private inline function get_STENCIL():Int
	{
		return GL.STENCIL;
	}

	@:noCompletion private inline function get_MIN():Int
	{
		return GL.MIN;
	}

	@:noCompletion private inline function get_MAX():Int
	{
		return GL.MAX;
	}

	@:noCompletion private inline function get_DEPTH_COMPONENT24():Int
	{
		return GL.DEPTH_COMPONENT24;
	}

	@:noCompletion private inline function get_STREAM_READ():Int
	{
		return GL.STREAM_READ;
	}

	@:noCompletion private inline function get_STREAM_COPY():Int
	{
		return GL.STREAM_COPY;
	}

	@:noCompletion private inline function get_STATIC_READ():Int
	{
		return GL.STATIC_READ;
	}

	@:noCompletion private inline function get_STATIC_COPY():Int
	{
		return GL.STATIC_COPY;
	}

	@:noCompletion private inline function get_DYNAMIC_READ():Int
	{
		return GL.DYNAMIC_READ;
	}

	@:noCompletion private inline function get_DYNAMIC_COPY():Int
	{
		return GL.DYNAMIC_COPY;
	}

	@:noCompletion private inline function get_DEPTH_COMPONENT32F():Int
	{
		return GL.DEPTH_COMPONENT32F;
	}

	@:noCompletion private inline function get_DEPTH32F_STENCIL8():Int
	{
		return GL.DEPTH32F_STENCIL8;
	}

	@:noCompletion private inline function get_INVALID_INDEX():Int
	{
		return GL.INVALID_INDEX;
	}

	@:noCompletion private inline function get_TIMEOUT_IGNORED():Int
	{
		return GL.TIMEOUT_IGNORED;
	}

	@:noCompletion private inline function get_COMPUTE_SHADER():Int
	{
		return GL.COMPUTE_SHADER;
	}

	@:noCompletion private inline function get_MAX_COMPUTE_WORK_GROUP_COUNT():Int
	{
		return GL.MAX_COMPUTE_WORK_GROUP_COUNT;
	}

	@:noCompletion private inline function get_MAX_COMPUTE_WORK_GROUP_SIZE():Int
	{
		return GL.MAX_COMPUTE_WORK_GROUP_SIZE;
	}

	@:noCompletion private inline function get_MAX_COMPUTE_WORK_GROUP_INVOCATIONS():Int
	{
		return GL.MAX_COMPUTE_WORK_GROUP_INVOCATIONS;
	}

	@:noCompletion private inline function get_COMPUTE_WORK_GROUP_SIZE():Int
	{
		return GL.COMPUTE_WORK_GROUP_SIZE;
	}

	@:noCompletion private inline function get_DISPATCH_INDIRECT_BUFFER():Int
	{
		return GL.DISPATCH_INDIRECT_BUFFER;
	}

	@:noCompletion private inline function get_DISPATCH_INDIRECT_BUFFER_BINDING():Int
	{
		return GL.DISPATCH_INDIRECT_BUFFER_BINDING;
	}

	@:noCompletion private inline function get_DRAW_INDIRECT_BUFFER():Int
	{
		return GL.DRAW_INDIRECT_BUFFER;
	}

	@:noCompletion private inline function get_DRAW_INDIRECT_BUFFER_BINDING():Int
	{
		return GL.DRAW_INDIRECT_BUFFER_BINDING;
	}

	@:noCompletion private inline function get_SHADER_STORAGE_BUFFER():Int
	{
		return GL.SHADER_STORAGE_BUFFER;
	}

	@:noCompletion private inline function get_SHADER_STORAGE_BUFFER_BINDING():Int
	{
		return GL.SHADER_STORAGE_BUFFER_BINDING;
	}

	@:noCompletion private inline function get_SHADER_STORAGE_BUFFER_START():Int
	{
		return GL.SHADER_STORAGE_BUFFER_START;
	}

	@:noCompletion private inline function get_SHADER_STORAGE_BUFFER_SIZE():Int
	{
		return GL.SHADER_STORAGE_BUFFER_SIZE;
	}

	@:noCompletion private inline function get_MAX_SHADER_STORAGE_BLOCK_SIZE():Int
	{
		return GL.MAX_SHADER_STORAGE_BLOCK_SIZE;
	}

	@:noCompletion private inline function get_MAX_SHADER_STORAGE_BUFFER_BINDINGS():Int
	{
		return GL.MAX_SHADER_STORAGE_BUFFER_BINDINGS;
	}

	@:noCompletion private inline function get_SHADER_STORAGE_BARRIER_BIT():Int
	{
		return GL.SHADER_STORAGE_BARRIER_BIT;
	}

	@:noCompletion private inline function get_VERTEX_ATTRIB_ARRAY_BARRIER_BIT():Int
	{
		return GL.VERTEX_ATTRIB_ARRAY_BARRIER_BIT;
	}

	@:noCompletion private inline function get_ELEMENT_ARRAY_BARRIER_BIT():Int
	{
		return GL.ELEMENT_ARRAY_BARRIER_BIT;
	}

	@:noCompletion private inline function get_UNIFORM_BARRIER_BIT():Int
	{
		return GL.UNIFORM_BARRIER_BIT;
	}

	@:noCompletion private inline function get_TEXTURE_FETCH_BARRIER_BIT():Int
	{
		return GL.TEXTURE_FETCH_BARRIER_BIT;
	}

	@:noCompletion private inline function get_SHADER_IMAGE_ACCESS_BARRIER_BIT():Int
	{
		return GL.SHADER_IMAGE_ACCESS_BARRIER_BIT;
	}

	@:noCompletion private inline function get_COMMAND_BARRIER_BIT():Int
	{
		return GL.COMMAND_BARRIER_BIT;
	}

	@:noCompletion private inline function get_PIXEL_BUFFER_BARRIER_BIT():Int
	{
		return GL.PIXEL_BUFFER_BARRIER_BIT;
	}

	@:noCompletion private inline function get_TEXTURE_UPDATE_BARRIER_BIT():Int
	{
		return GL.TEXTURE_UPDATE_BARRIER_BIT;
	}

	@:noCompletion private inline function get_BUFFER_UPDATE_BARRIER_BIT():Int
	{
		return GL.BUFFER_UPDATE_BARRIER_BIT;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_BARRIER_BIT():Int
	{
		return GL.FRAMEBUFFER_BARRIER_BIT;
	}

	@:noCompletion private inline function get_TRANSFORM_FEEDBACK_BARRIER_BIT():Int
	{
		return GL.TRANSFORM_FEEDBACK_BARRIER_BIT;
	}

	@:noCompletion private inline function get_ATOMIC_COUNTER_BARRIER_BIT():Int
	{
		return GL.ATOMIC_COUNTER_BARRIER_BIT;
	}

	@:noCompletion private inline function get_ALL_BARRIER_BITS():Int
	{
		return GL.ALL_BARRIER_BITS;
	}

	@:noCompletion private inline function get_ATOMIC_COUNTER_BUFFER():Int
	{
		return GL.ATOMIC_COUNTER_BUFFER;
	}

	@:noCompletion private inline function get_READ_ONLY():Int
	{
		return GL.READ_ONLY;
	}

	@:noCompletion private inline function get_WRITE_ONLY():Int
	{
		return GL.WRITE_ONLY;
	}

	@:noCompletion private inline function get_READ_WRITE():Int
	{
		return GL.READ_WRITE;
	}

	@:noCompletion private inline function get_IMAGE_2D():Int
	{
		return GL.IMAGE_2D;
	}

	@:noCompletion private inline function get_MAX_IMAGE_UNITS():Int
	{
		return GL.MAX_IMAGE_UNITS;
	}

	@:noCompletion private inline function get_UNIFORM():Int
	{
		return GL.UNIFORM;
	}

	@:noCompletion private inline function get_UNIFORM_BLOCK():Int
	{
		return GL.UNIFORM_BLOCK;
	}

	@:noCompletion private inline function get_PROGRAM_INPUT():Int
	{
		return GL.PROGRAM_INPUT;
	}

	@:noCompletion private inline function get_PROGRAM_OUTPUT():Int
	{
		return GL.PROGRAM_OUTPUT;
	}

	@:noCompletion private inline function get_BUFFER_VARIABLE():Int
	{
		return GL.BUFFER_VARIABLE;
	}

	@:noCompletion private inline function get_SHADER_STORAGE_BLOCK():Int
	{
		return GL.SHADER_STORAGE_BLOCK;
	}

	@:noCompletion private inline function get_ACTIVE_RESOURCES():Int
	{
		return GL.ACTIVE_RESOURCES;
	}

	@:noCompletion private inline function get_MAX_NAME_LENGTH():Int
	{
		return GL.MAX_NAME_LENGTH;
	}

	@:noCompletion private inline function get_MAX_NUM_ACTIVE_VARIABLES():Int
	{
		return GL.MAX_NUM_ACTIVE_VARIABLES;
	}

	@:noCompletion private inline function get_NAME_LENGTH():Int
	{
		return GL.NAME_LENGTH;
	}

	@:noCompletion private inline function get_TYPE():Int
	{
		return GL.TYPE;
	}

	@:noCompletion private inline function get_ARRAY_SIZE():Int
	{
		return GL.ARRAY_SIZE;
	}

	@:noCompletion private inline function get_OFFSET():Int
	{
		return GL.OFFSET;
	}

	@:noCompletion private inline function get_BLOCK_INDEX():Int
	{
		return GL.BLOCK_INDEX;
	}

	@:noCompletion private inline function get_LOCATION():Int
	{
		return GL.LOCATION;
	}

	@:noCompletion private inline function get_VERTEX_SHADER_BIT():Int
	{
		return GL.VERTEX_SHADER_BIT;
	}

	@:noCompletion private inline function get_FRAGMENT_SHADER_BIT():Int
	{
		return GL.FRAGMENT_SHADER_BIT;
	}

	@:noCompletion private inline function get_COMPUTE_SHADER_BIT():Int
	{
		return GL.COMPUTE_SHADER_BIT;
	}

	@:noCompletion private inline function get_ALL_SHADER_BITS():Int
	{
		return GL.ALL_SHADER_BITS;
	}

	@:noCompletion private inline function get_PROGRAM_SEPARABLE():Int
	{
		return GL.PROGRAM_SEPARABLE;
	}

	@:noCompletion private inline function get_ACTIVE_PROGRAM():Int
	{
		return GL.ACTIVE_PROGRAM;
	}

	@:noCompletion private inline function get_PROGRAM_PIPELINE_BINDING():Int
	{
		return GL.PROGRAM_PIPELINE_BINDING;
	}

	@:noCompletion private inline function get_VERTEX_ATTRIB_BINDING():Int
	{
		return GL.VERTEX_ATTRIB_BINDING;
	}

	@:noCompletion private inline function get_VERTEX_ATTRIB_RELATIVE_OFFSET():Int
	{
		return GL.VERTEX_ATTRIB_RELATIVE_OFFSET;
	}

	@:noCompletion private inline function get_VERTEX_BINDING_DIVISOR():Int
	{
		return GL.VERTEX_BINDING_DIVISOR;
	}

	@:noCompletion private inline function get_VERTEX_BINDING_OFFSET():Int
	{
		return GL.VERTEX_BINDING_OFFSET;
	}

	@:noCompletion private inline function get_VERTEX_BINDING_STRIDE():Int
	{
		return GL.VERTEX_BINDING_STRIDE;
	}

	@:noCompletion private inline function get_VERTEX_BINDING_BUFFER():Int
	{
		return GL.VERTEX_BINDING_BUFFER;
	}

	@:noCompletion private inline function get_MAX_VERTEX_ATTRIB_BINDINGS():Int
	{
		return GL.MAX_VERTEX_ATTRIB_BINDINGS;
	}

	@:noCompletion private inline function get_MAX_VERTEX_ATTRIB_STRIDE():Int
	{
		return GL.MAX_VERTEX_ATTRIB_STRIDE;
	}

	@:noCompletion private inline function get_TEXTURE_2D_MULTISAMPLE():Int
	{
		return GL.TEXTURE_2D_MULTISAMPLE;
	}

	@:noCompletion private inline function get_TEXTURE_2D_MULTISAMPLE_ARRAY():Int
	{
		return GL.TEXTURE_2D_MULTISAMPLE_ARRAY;
	}

	@:noCompletion private inline function get_SAMPLE_POSITION():Int
	{
		return GL.SAMPLE_POSITION;
	}

	@:noCompletion private inline function get_SAMPLE_MASK():Int
	{
		return GL.SAMPLE_MASK;
	}

	@:noCompletion private inline function get_MAX_SAMPLE_MASK_WORDS():Int
	{
		return GL.MAX_SAMPLE_MASK_WORDS;
	}

	@:noCompletion private inline function get_MAX_COLOR_TEXTURE_SAMPLES():Int
	{
		return GL.MAX_COLOR_TEXTURE_SAMPLES;
	}

	@:noCompletion private inline function get_MAX_DEPTH_TEXTURE_SAMPLES():Int
	{
		return GL.MAX_DEPTH_TEXTURE_SAMPLES;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_DEFAULT_WIDTH():Int
	{
		return GL.FRAMEBUFFER_DEFAULT_WIDTH;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_DEFAULT_HEIGHT():Int
	{
		return GL.FRAMEBUFFER_DEFAULT_HEIGHT;
	}

	@:noCompletion private inline function get_FRAMEBUFFER_DEFAULT_SAMPLES():Int
	{
		return GL.FRAMEBUFFER_DEFAULT_SAMPLES;
	}

	@:noCompletion private inline function get_TEXTURE_BUFFER():Int
	{
		return GL.TEXTURE_BUFFER;
	}

	@:noCompletion private inline function get_TEXTURE_BUFFER_BINDING():Int
	{
		return GL.TEXTURE_BUFFER_BINDING;
	}

	@:noCompletion private inline function get_TEXTURE_BUFFER_OFFSET():Int
	{
		return GL.TEXTURE_BUFFER_OFFSET;
	}

	@:noCompletion private inline function get_TEXTURE_BUFFER_SIZE():Int
	{
		return GL.TEXTURE_BUFFER_SIZE;
	}

	@:noCompletion private inline function get_PATCHES():Int
	{
		return GL.PATCHES;
	}

	@:noCompletion private inline function get_PATCH_VERTICES():Int
	{
		return GL.PATCH_VERTICES;
	}

	@:noCompletion private inline function get_MIN_SAMPLE_SHADING_VALUE():Int
	{
		return GL.MIN_SAMPLE_SHADING_VALUE;
	}

	@:noCompletion private inline function get_SAMPLE_SHADING():Int
	{
		return GL.SAMPLE_SHADING;
	}

	@:noCompletion private inline function get_DEBUG_OUTPUT():Int
	{
		return GL.DEBUG_OUTPUT;
	}

	@:noCompletion private inline function get_DEBUG_OUTPUT_SYNCHRONOUS():Int
	{
		return GL.DEBUG_OUTPUT_SYNCHRONOUS;
	}

	@:noCompletion private inline function get_DEBUG_SOURCE_APPLICATION():Int
	{
		return GL.DEBUG_SOURCE_APPLICATION;
	}

	@:noCompletion private inline function get_DEBUG_SOURCE_THIRD_PARTY():Int
	{
		return GL.DEBUG_SOURCE_THIRD_PARTY;
	}

	@:noCompletion private inline function get_DEBUG_TYPE_ERROR():Int
	{
		return GL.DEBUG_TYPE_ERROR;
	}

	@:noCompletion private inline function get_DEBUG_TYPE_PERFORMANCE():Int
	{
		return GL.DEBUG_TYPE_PERFORMANCE;
	}

	@:noCompletion private inline function get_DEBUG_TYPE_MARKER():Int
	{
		return GL.DEBUG_TYPE_MARKER;
	}

	@:noCompletion private inline function get_DEBUG_TYPE_PUSH_GROUP():Int
	{
		return GL.DEBUG_TYPE_PUSH_GROUP;
	}

	@:noCompletion private inline function get_DEBUG_TYPE_POP_GROUP():Int
	{
		return GL.DEBUG_TYPE_POP_GROUP;
	}

	@:noCompletion private inline function get_DEBUG_SEVERITY_HIGH():Int
	{
		return GL.DEBUG_SEVERITY_HIGH;
	}

	@:noCompletion private inline function get_DEBUG_SEVERITY_MEDIUM():Int
	{
		return GL.DEBUG_SEVERITY_MEDIUM;
	}

	@:noCompletion private inline function get_DEBUG_SEVERITY_LOW():Int
	{
		return GL.DEBUG_SEVERITY_LOW;
	}

	@:noCompletion private inline function get_DEBUG_SEVERITY_NOTIFICATION():Int
	{
		return GL.DEBUG_SEVERITY_NOTIFICATION;
	}

	@:noCompletion private inline function get_MAX_DEBUG_MESSAGE_LENGTH():Int
	{
		return GL.MAX_DEBUG_MESSAGE_LENGTH;
	}

	@:noCompletion private inline function get_MAX_LABEL_LENGTH():Int
	{
		return GL.MAX_LABEL_LENGTH;
	}

	@:noCompletion private inline function get_BUFFER_OBJECT():Int
	{
		return GL.BUFFER_OBJECT;
	}

	@:noCompletion private inline function get_SHADER_OBJECT():Int
	{
		return GL.SHADER_OBJECT;
	}

	@:noCompletion private inline function get_PROGRAM_OBJECT():Int
	{
		return GL.PROGRAM_OBJECT;
	}

	@:noCompletion private inline function get_QUERY_OBJECT():Int
	{
		return GL.QUERY_OBJECT;
	}

	@:noCompletion private inline function get_MAP_PERSISTENT_BIT():Int
	{
		return GL.MAP_PERSISTENT_BIT;
	}

	@:noCompletion private inline function get_MAP_COHERENT_BIT():Int
	{
		return GL.MAP_COHERENT_BIT;
	}

	@:noCompletion private inline function get_DYNAMIC_STORAGE_BIT():Int
	{
		return GL.DYNAMIC_STORAGE_BIT;
	}

	@:noCompletion private inline function get_CLIENT_STORAGE_BIT():Int
	{
		return GL.CLIENT_STORAGE_BIT;
	}

	@:noCompletion private inline function get_LOWER_LEFT():Int
	{
		return GL.LOWER_LEFT;
	}

	@:noCompletion private inline function get_UPPER_LEFT():Int
	{
		return GL.UPPER_LEFT;
	}

	@:noCompletion private inline function get_NEGATIVE_ONE_TO_ONE():Int
	{
		return GL.NEGATIVE_ONE_TO_ONE;
	}

	@:noCompletion private inline function get_ZERO_TO_ONE():Int
	{
		return GL.ZERO_TO_ONE;
	}

	@:noCompletion private inline function get_FILL():Int
	{
		return GL.FILL;
	}

	@:noCompletion private inline function get_LINE():Int
	{
		return GL.LINE;
	}

	@:noCompletion private inline function get_POINT():Int
	{
		return GL.POINT;
	}

	private function __pushSupportedExtension(extension:String):Void
	{
		__supportedExtensions.push(StringTools.startsWith(extension, "GL_") ? extension.substr(3) : extension);
	}

	private static function __newTextureUnitBindings():haxe.ds.Vector<Int>
	{
		var bindings = new haxe.ds.Vector<Int>(__TEXTURE_UNIT_CACHE_SIZE * 2);

		for (i in 0...bindings.length)
		{
			bindings[i] = -1;
		}

		return bindings;
	}

	private function __resetTextureUnitBindings():Void
	{
		for (i in 0...__textureUnitBindings.length)
		{
			__textureUnitBindings[i] = -1;
		}
	}

	/**
		Cache index for `target` bound to the current texture unit, or -1 when the
		binding is not cached (an uncached target, or a unit beyond the cache size).
	**/
	private function __textureCacheIndex(target:Int):Int
	{
		var slot = switch (target)
		{
			case 0x0DE1: 0; // TEXTURE_2D
			case 0x8513: 1; // TEXTURE_CUBE_MAP
			default: -1;
		}

		if (slot == -1)
			return -1;

		var unit = __activeTextureUnit - 0x84C0; // GL_TEXTURE0

		if (unit < 0 || unit >= __TEXTURE_UNIT_CACHE_SIZE)
			return -1;

		return unit * 2 + slot;
	}

	/**
		Bit for `cap` within `__capEnabledMask` / `__capKnownMask`, or 0 when the cap
		is not cached and `enable`/`disable` should always pass through to the driver.
	**/
	private function __capCacheBit(cap:Int):Int
	{
		return switch (cap)
		{
			case 0x0BE2: 1 << 0; // BLEND
			case 0x0B44: 1 << 1; // CULL_FACE
			case 0x0B71: 1 << 2; // DEPTH_TEST
			case 0x0BD0: 1 << 3; // DITHER
			case 0x8037: 1 << 4; // POLYGON_OFFSET_FILL
			case 0x809E: 1 << 5; // SAMPLE_ALPHA_TO_COVERAGE
			case 0x80A0: 1 << 6; // SAMPLE_COVERAGE
			case 0x0C11: 1 << 7; // SCISSOR_TEST
			case 0x0B90: 1 << 8; // STENCIL_TEST
			case 0x8C89: 1 << 9; // RASTERIZER_DISCARD
			case 0x8D69: 1 << 10; // PRIMITIVE_RESTART_FIXED_INDEX
			default: 0;
		}
	}

	private function __createObject(id:Int):GLObject
	{
		return new GLObject(id);
	}

	private function __getObjectID(object:GLObject):Int
	{
		return (object == null) ? 0 : object.id;
	}

	private function __initialize():Void
	{
		if (!__initialized)
		{
			__extensionObjectConstructors["AMD_compressed_3DC_texture"] = AMD_compressed_3DC_texture.new;
			__extensionObjectConstructors["AMD_compressed_ATC_texture"] = AMD_compressed_ATC_texture.new;
			__extensionObjectConstructors["AMD_performance_monitor"] = AMD_performance_monitor.new;
			__extensionObjectConstructors["AMD_program_binary_Z400"] = AMD_program_binary_Z400.new;
			__extensionObjectConstructors["ANGLE_framebuffer_blit"] = ANGLE_framebuffer_blit.new;
			__extensionObjectConstructors["ANGLE_framebuffer_multisample"] = ANGLE_framebuffer_multisample.new;
			__extensionObjectConstructors["ANGLE_instanced_arrays"] = ANGLE_instanced_arrays.new;
			__extensionObjectConstructors["ANGLE_pack_reverse_row_order"] = ANGLE_pack_reverse_row_order.new;
			__extensionObjectConstructors["ANGLE_texture_compression_dxt3"] = ANGLE_texture_compression_dxt3.new;
			__extensionObjectConstructors["ANGLE_texture_compression_dxt5"] = ANGLE_texture_compression_dxt5.new;
			__extensionObjectConstructors["ANGLE_texture_usage"] = ANGLE_texture_usage.new;
			__extensionObjectConstructors["ANGLE_translated_shader_source"] = ANGLE_translated_shader_source.new;
			__extensionObjectConstructors["APPLE_copy_texture_levels"] = APPLE_copy_texture_levels.new;
			__extensionObjectConstructors["APPLE_framebuffer_multisample"] = APPLE_framebuffer_multisample.new;
			__extensionObjectConstructors["APPLE_rgb_422"] = APPLE_rgb_422.new;
			__extensionObjectConstructors["APPLE_sync"] = APPLE_sync.new;
			__extensionObjectConstructors["APPLE_texture_format_BGRA8888"] = APPLE_texture_format_BGRA8888.new;
			__extensionObjectConstructors["APPLE_texture_max_level"] = APPLE_texture_max_level.new;
			__extensionObjectConstructors["ARB_texture_compression"] = ARB_texture_compression.new;
			__extensionObjectConstructors["ARB_texture_compression_bptc"] = ARB_texture_compression_bptc.new;
			__extensionObjectConstructors["ARB_texture_compression_rgtc"] = ARB_texture_compression_rgtc.new;
			__extensionObjectConstructors["ARM_mali_program_binary"] = ARM_mali_program_binary.new;
			__extensionObjectConstructors["ARM_mali_shader_binary"] = ARM_mali_shader_binary.new;
			__extensionObjectConstructors["ARM_rgba8"] = ARM_rgba8.new;
			__extensionObjectConstructors["DMP_shader_binary"] = DMP_shader_binary.new;
			__extensionObjectConstructors["EXT_bgra"] = EXT_bgra.new;
			__extensionObjectConstructors["EXT_blend_minmax"] = EXT_blend_minmax.new;
			__extensionObjectConstructors["EXT_color_buffer_float"] = EXT_color_buffer_float.new;
			__extensionObjectConstructors["EXT_color_buffer_half_float"] = EXT_color_buffer_half_float.new;
			__extensionObjectConstructors["EXT_debug_label"] = EXT_debug_label.new;
			__extensionObjectConstructors["EXT_debug_marker"] = EXT_debug_marker.new;
			__extensionObjectConstructors["EXT_discard_framebuffer"] = EXT_discard_framebuffer.new;
			__extensionObjectConstructors["EXT_framebuffer_object"] = EXT_framebuffer_object.new;
			__extensionObjectConstructors["EXT_map_buffer_range"] = EXT_map_buffer_range.new;
			__extensionObjectConstructors["EXT_multi_draw_arrays"] = EXT_multi_draw_arrays.new;
			__extensionObjectConstructors["EXT_multisampled_render_to_texture"] = EXT_multisampled_render_to_texture.new;
			__extensionObjectConstructors["EXT_multiview_draw_buffers"] = EXT_multiview_draw_buffers.new;
			__extensionObjectConstructors["EXT_occlusion_query_boolean"] = EXT_occlusion_query_boolean.new;
			__extensionObjectConstructors["EXT_packed_depth_stencil"] = EXT_packed_depth_stencil.new;
			__extensionObjectConstructors["EXT_read_format_bgra"] = EXT_read_format_bgra.new;
			__extensionObjectConstructors["EXT_robustness"] = EXT_robustness.new;
			__extensionObjectConstructors["EXT_separate_shader_objects"] = EXT_separate_shader_objects.new;
			__extensionObjectConstructors["EXT_shader_framebuffer_fetch"] = EXT_shader_framebuffer_fetch.new;
			__extensionObjectConstructors["EXT_shader_texture_lod"] = EXT_shader_texture_lod.new;
			__extensionObjectConstructors["EXT_shadow_samplers"] = EXT_shadow_samplers.new;
			__extensionObjectConstructors["EXT_sRGB"] = EXT_sRGB.new;
			__extensionObjectConstructors["EXT_texture_compression_astc_decode_mode"] = EXT_texture_compression_astc_decode_mode.new;
			__extensionObjectConstructors["EXT_texture_compression_bptc"] = EXT_texture_compression_bptc.new;
			__extensionObjectConstructors["EXT_texture_compression_dxt1"] = EXT_texture_compression_dxt1.new;
			__extensionObjectConstructors["EXT_texture_compression_rgtc"] = EXT_texture_compression_rgtc.new;
			__extensionObjectConstructors["EXT_texture_compression_s3tc"] = EXT_texture_compression_s3tc.new;
			__extensionObjectConstructors["EXT_texture_compression_s3tc_srgb"] = EXT_texture_compression_s3tc_srgb.new;
			__extensionObjectConstructors["EXT_texture_filter_anisotropic"] = EXT_texture_filter_anisotropic.new;
			__extensionObjectConstructors["EXT_texture_format_BGRA8888"] = EXT_texture_format_BGRA8888.new;
			__extensionObjectConstructors["EXT_texture_rg"] = EXT_texture_rg.new;
			__extensionObjectConstructors["EXT_texture_storage"] = EXT_texture_storage.new;
			__extensionObjectConstructors["EXT_texture_type_2_10_10_10_REV"] = EXT_texture_type_2_10_10_10_REV.new;
			__extensionObjectConstructors["EXT_unpack_subimage"] = EXT_unpack_subimage.new;
			__extensionObjectConstructors["FJ_shader_binary_GCCSO"] = FJ_shader_binary_GCCSO.new;
			__extensionObjectConstructors["IMG_multisampled_render_to_texture"] = IMG_multisampled_render_to_texture.new;
			__extensionObjectConstructors["IMG_program_binary"] = IMG_program_binary.new;
			__extensionObjectConstructors["IMG_read_format"] = IMG_read_format.new;
			__extensionObjectConstructors["IMG_shader_binary"] = IMG_shader_binary.new;
			__extensionObjectConstructors["IMG_texture_compression_pvrtc"] = IMG_texture_compression_pvrtc.new;
			__extensionObjectConstructors["IMG_texture_compression_pvrtc2"] = IMG_texture_compression_pvrtc2.new;
			__extensionObjectConstructors["KHR_blend_equation_advanced"] = KHR_blend_equation_advanced.new;
			__extensionObjectConstructors["KHR_blend_equation_advanced_coherent"] = KHR_blend_equation_advanced_coherent.new;
			__extensionObjectConstructors["KHR_debug"] = KHR_debug.new;
			__extensionObjectConstructors["KHR_texture_compression_astc_hdr"] = KHR_texture_compression_astc_hdr.new;
			__extensionObjectConstructors["KHR_texture_compression_astc_ldr"] = KHR_texture_compression_astc_ldr.new;
			__extensionObjectConstructors["KHR_texture_compression_astc_sliced_3d"] = KHR_texture_compression_astc_sliced_3d.new;
			__extensionObjectConstructors["NV_coverage_sample"] = NV_coverage_sample.new;
			__extensionObjectConstructors["NV_depth_nonlinear"] = NV_depth_nonlinear.new;
			__extensionObjectConstructors["NV_draw_buffers"] = NV_draw_buffers.new;
			__extensionObjectConstructors["NV_fbo_color_attachments"] = NV_fbo_color_attachments.new;
			__extensionObjectConstructors["NV_fence"] = NV_fence.new;
			__extensionObjectConstructors["NV_read_buffer"] = NV_read_buffer.new;
			__extensionObjectConstructors["NV_read_buffer_front"] = NV_read_buffer_front.new;
			__extensionObjectConstructors["NV_read_depth"] = NV_read_depth.new;
			__extensionObjectConstructors["NV_read_depth_stencil"] = NV_read_depth_stencil.new;
			__extensionObjectConstructors["NV_read_stencil"] = NV_read_stencil.new;
			__extensionObjectConstructors["NV_texture_compression_s3tc_update"] = NV_texture_compression_s3tc_update.new;
			__extensionObjectConstructors["NV_texture_npot_2D_mipmap"] = NV_texture_npot_2D_mipmap.new;
			__extensionObjectConstructors["NVX_gpu_memory_info"] = NVX_gpu_memory_info.new;
			__extensionObjectConstructors["OES_compressed_ETC1_RGB8_texture"] = OES_compressed_ETC1_RGB8_texture.new;
			__extensionObjectConstructors["OES_compressed_paletted_texture"] = OES_compressed_paletted_texture.new;
			__extensionObjectConstructors["OES_depth_texture"] = OES_depth_texture.new;
			__extensionObjectConstructors["OES_depth24"] = OES_depth24.new;
			__extensionObjectConstructors["OES_depth32"] = OES_depth32.new;
			__extensionObjectConstructors["OES_EGL_image"] = OES_EGL_image.new;
			__extensionObjectConstructors["OES_EGL_image_external"] = OES_EGL_image_external.new;
			__extensionObjectConstructors["OES_element_index_uint"] = OES_element_index_uint.new;
			__extensionObjectConstructors["OES_get_program_binary"] = OES_get_program_binary.new;
			__extensionObjectConstructors["OES_mapbuffer"] = OES_mapbuffer.new;
			__extensionObjectConstructors["OES_packed_depth_stencil"] = OES_packed_depth_stencil.new;
			__extensionObjectConstructors["OES_required_internalformat"] = OES_required_internalformat.new;
			__extensionObjectConstructors["OES_rgb8_rgba8"] = OES_rgb8_rgba8.new;
			__extensionObjectConstructors["OES_standard_derivatives"] = OES_standard_derivatives.new;
			__extensionObjectConstructors["OES_stencil1"] = OES_stencil1.new;
			__extensionObjectConstructors["OES_stencil4"] = OES_stencil4.new;
			__extensionObjectConstructors["OES_surfaceless_context"] = OES_surfaceless_context.new;
			__extensionObjectConstructors["OES_texture_3D"] = OES_texture_3D.new;
			__extensionObjectConstructors["OES_texture_float"] = OES_texture_float.new;
			__extensionObjectConstructors["OES_texture_float_linear"] = OES_texture_float_linear.new;
			__extensionObjectConstructors["OES_texture_half_float"] = OES_texture_half_float.new;
			__extensionObjectConstructors["OES_texture_half_float_linear"] = OES_texture_half_float_linear.new;
			__extensionObjectConstructors["OES_texture_npot"] = OES_texture_npot.new;
			__extensionObjectConstructors["OES_vertex_array_object"] = OES_vertex_array_object.new;
			__extensionObjectConstructors["OES_vertex_half_float"] = OES_vertex_half_float.new;
			__extensionObjectConstructors["OES_vertex_type_10_10_10_2"] = OES_vertex_type_10_10_10_2.new;
			__extensionObjectConstructors["QCOM_alpha_test"] = QCOM_alpha_test.new;
			__extensionObjectConstructors["QCOM_binning_control"] = QCOM_binning_control.new;
			__extensionObjectConstructors["QCOM_driver_control"] = QCOM_driver_control.new;
			__extensionObjectConstructors["QCOM_extended_get"] = QCOM_extended_get.new;
			__extensionObjectConstructors["QCOM_extended_get2"] = QCOM_extended_get2.new;
			__extensionObjectConstructors["QCOM_perfmon_global_mode"] = QCOM_perfmon_global_mode.new;
			__extensionObjectConstructors["QCOM_tiled_rendering"] = QCOM_tiled_rendering.new;
			__extensionObjectConstructors["QCOM_writeonly_rendering"] = QCOM_writeonly_rendering.new;
			__extensionObjectConstructors["S3_s3tc"] = S3_s3tc.new;
			__extensionObjectConstructors["VIV_shader_binary"] = VIV_shader_binary.new;
		}

		__initialized = true;
	}
}
