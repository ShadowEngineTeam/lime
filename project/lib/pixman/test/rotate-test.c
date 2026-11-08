#include <stdlib.h>
#include "utils.h"

#define WIDTH	32
#define HEIGHT	32

static const pixman_format_code_t formats[] =
{
    PIXMAN_a8r8g8b8,
    PIXMAN_a8b8g8r8,
    PIXMAN_x8r8g8b8,
    PIXMAN_x8b8g8r8,
    PIXMAN_b8g8r8a8,
    PIXMAN_b8g8r8x8,
    PIXMAN_r8g8b8a8,
    PIXMAN_r8g8b8x8,
    PIXMAN_a2r10g10b10,
    PIXMAN_x2r10g10b10,
    PIXMAN_a2b10g10r10,
    PIXMAN_x2b10g10r10,
    PIXMAN_r5g6b5,
    PIXMAN_b5g6r5,
    PIXMAN_a8,
    PIXMAN_a1,
};

static const pixman_op_t ops[] =
{
    PIXMAN_OP_OVER,
    PIXMAN_OP_SRC,
    PIXMAN_OP_ADD,
};

#define TRANSFORM(v00, v01, v10, v11)					\
    { { { v00, v01, WIDTH * pixman_fixed_1 / 2 },			\
        { v10, v11, HEIGHT * pixman_fixed_1 / 2 },			\
	{ 0, 0, pixman_fixed_1 } } }

#define F1 pixman_fixed_1

static const pixman_transform_t transforms[] =
{
    TRANSFORM (0, -1, 1, 0),		/* wrong 90 degree rotation */
    TRANSFORM (0, 1, -1, 0),		/* wrong 270 degree rotation */
    TRANSFORM (1, 0, 0, 1),		/* wrong identity */
    TRANSFORM (-1, 0, 0, -1),		/* wrong 180 degree rotation */
    TRANSFORM (0, -F1, F1, 0),		/* correct 90 degree rotation */
    TRANSFORM (0, F1, -F1, 0),		/* correct 270 degree rotation */
    TRANSFORM (F1, 0, 0, F1),		/* correct identity */
    TRANSFORM (-F1, 0, 0, -F1),		/* correct 180 degree rotation */
};

#define RANDOM_FORMAT()							\
    (formats[prng_rand_n (ARRAY_LENGTH (formats))])

#define RANDOM_OP()							\
    (ops[prng_rand_n (ARRAY_LENGTH (ops))])

#define RANDOM_TRANSFORM()						\
    (&(transforms[prng_rand_n (ARRAY_LENGTH (transforms))]))

static void
on_destroy (pixman_image_t *image, void *data)
{
    free (data);
}

static pixman_image_t *
make_image (void)
{
    pixman_format_code_t format = RANDOM_FORMAT();
    uint32_t *bytes, *orig;
    pixman_image_t *image;
    int stride;

    orig = bytes = malloc (WIDTH * HEIGHT * 4);
    prng_randmemset (bytes, WIDTH * HEIGHT * 4, 0);

    stride = WIDTH * 4;
    if (prng_rand_n (2) == 0)
    {
	bytes += (stride / 4) * (HEIGHT - 1);
	stride = - stride;
    }

    image = pixman_image_create_bits (
	format, WIDTH, HEIGHT, bytes, stride);

    pixman_image_set_transform (image, RANDOM_TRANSFORM());
    pixman_image_set_destroy_function (image, on_destroy, orig);
    pixman_image_set_repeat (image, PIXMAN_REPEAT_NORMAL);

    image_endian_swap (image);

    return image;
}

static uint32_t
test_transform (int testnum, int verbose)
{
    pixman_image_t *src, *dest;
    pixman_op_t op;
    uint32_t crc;

    prng_srand (testnum);
    
    src = make_image ();
    dest = make_image ();
    op = RANDOM_OP();

    /* With wide formats, the other operators use floating point math,
     * which does not round the same way on all platforms. With SRC and
     * nearest filtering, the only floating point math converts each
     * channel to float and back, and the result is never close enough
     * to an integer boundary to differ between platforms.
     */
    if (PIXMAN_FORMAT_IS_WIDE (pixman_image_get_format (src)) ||
	PIXMAN_FORMAT_IS_WIDE (pixman_image_get_format (dest)))
    {
	op = PIXMAN_OP_SRC;
    }

    pixman_image_composite (op,
			    src, NULL, dest,
			    0, 0, 0, 0, WIDTH / 2, HEIGHT / 2,
			    WIDTH, HEIGHT);

    crc = compute_crc32_for_image (0, dest);

    pixman_image_unref (src);
    pixman_image_unref (dest);

    return crc;
}

int
main (int argc, const char *argv[])
{
    return fuzzer_test_main ("rotate", 15000,
			     0xDF33AE42,
			     test_transform, argc, argv);
}
