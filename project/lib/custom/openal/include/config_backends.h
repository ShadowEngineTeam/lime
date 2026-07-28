/* Define to 1 if the given backend is enabled, else 0 */

if (defined(__linux__) && !defined(__ANDROID__))
# define HAVE_ALSA 1
# define HAVE_OSS 1
# define HAVE_PIPEWIRE 1
# define HAVE_PULSEAUDIO 1
# define HAVE_JACK 1
#else
# define HAVE_ALSA 0
# define HAVE_OSS 0
# define HAVE_PIPEWIRE 0
# define HAVE_PULSEAUDIO 0
# define HAVE_JACK 0
#endif

#define HAVE_SOLARIS 0

#define HAVE_SNDIO 0

#if defined(_WIN32) || defined(_WIN64) || defined(__CYGWIN__)
# define HAVE_WASAPI 1
# define HAVE_DSOUND 1
#else
# define HAVE_WASAPI 0
# define HAVE_DSOUND 0
#endif

#define HAVE_WINMM 0

#define HAVE_PORTAUDIO 0

#if defined(__APPLE__) || defined(__MACH__)
# define HAVE_COREAUDIO 1
#else
# define HAVE_COREAUDIO 0
#endif

#if defined(__ANDROID__)
# define HAVE_OPENSL 1
# define HAVE_AAUDIO 1
# define HAVE_OBOE 1
#else
# define HAVE_OPENSL 0
# define HAVE_OBOE 0
# define HAVE_AAUDIO 0
#endif

#define HAVE_WAVE 0

#if defined (NATIVE_TOOLKIT_HAVE_SDL)
# define HAVE_SDL3 1
#else
# define HAVE_SDL3 0
#endif

#define HAVE_SDL2 0
