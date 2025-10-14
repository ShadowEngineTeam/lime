/* Define to 1 if we have SSE CPU extensions, else 0 */
#define HAVE_SSE 0
#define HAVE_SSE2 0
#define HAVE_SSE3 0
#define HAVE_SSE4_1 0

#define HAVE_SSE_INTRINSICS 0

/* Define to 1 if we have ARM Neon CPU extensions, else 0 */
#ifdef HXCPP_ARM64
#define HAVE_NEON 1
#else
#define HAVE_NEON 0
#endif
