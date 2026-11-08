/* Check radial gradient output across vector boundaries and mask hints. */
#include "utils.h"
#include <stdio.h>
#include <stdlib.h>

static const int                  widths[]  = {1, 2, 7, 17, 33, 65, 129};
static const pixman_point_fixed_t centers[] = {
    {0, 0},
    {48 * 65536, 20 * 65536},
    {32 * 65536, 0},
    {32 * 65536, 8 * 65536},
};
static const pixman_repeat_t repeats[] = {
    PIXMAN_REPEAT_NONE,
    PIXMAN_REPEAT_NORMAL,
    PIXMAN_REPEAT_PAD,
    PIXMAN_REPEAT_REFLECT,
};

enum
{
    MASK_ABSENT,
    MASK_TWO_THIRDS_VISIBLE,
    MASK_ONE_THIRD_VISIBLE,
    MASK_ALL_VISIBLE,
    MASK_FIFTEEN_SIXTEENTHS_VISIBLE,
    MASK_ONE_SIXTEENTH_VISIBLE,
    MASK_ALL_HIDDEN,
    N_MASK_MODES
};

#define N_TRANSFORM_MODES 2
#define N_CASES                                                                \
    (ARRAY_LENGTH (centers) * N_TRANSFORM_MODES * N_MASK_MODES *               \
     ARRAY_LENGTH (repeats) * ARRAY_LENGTH (widths))

static uint32_t
test_radial (int testnum, int verbose)
{
    static const pixman_gradient_stop_t stops[] = {
	{0x00000, {0xffff, 0x0000, 0x0000, 0xffff}},
	{0x08000, {0x0000, 0xffff, 0x0000, 0xffff}},
	{0x10000, {0x0000, 0x0000, 0xffff, 0xffff}},
    };
    static const pixman_fixed_t     outer_radii[] = {64 * 65536, 16 * 65536,
						     32 * 65536, 32 * 65536};
    static const pixman_transform_t transform = {{{0x12000, 0x04000, -0x80000},
						  {-0x02000, 0x0e000, 0x40000},
						  {0, 0, 0x10000}}};
    const pixman_point_fixed_t      inner     = {0, 0};
    const int                       height    = 5;
    int                             n         = testnum - 1;
    int                             width = widths[n % ARRAY_LENGTH (widths)];
    int                             geometry, use_transform, mask_mode;
    pixman_repeat_t                 repeat;
    pixman_image_t                 *src, *mask = NULL, *dest;
    uint32_t                       *dest_bits;
    uint8_t                        *mask_bits = NULL;
    uint32_t                        crc;
    int                             x, y, mask_stride;

    n /= ARRAY_LENGTH (widths);
    repeat = repeats[n % ARRAY_LENGTH (repeats)];
    n /= ARRAY_LENGTH (repeats);
    mask_mode = n % N_MASK_MODES;
    n /= N_MASK_MODES;
    use_transform = n % N_TRANSFORM_MODES;
    geometry      = n / N_TRANSFORM_MODES;

    dest = pixman_image_create_bits (PIXMAN_a8r8g8b8, width, height, NULL, -1);
    if (!dest)
	abort ();
    dest_bits = pixman_image_get_data (dest);
    for (y = 0; y < height; ++y)
    {
	for (x = 0; x < width; ++x)
	    dest_bits[y * pixman_image_get_stride (dest) / 4 + x] = 0xff203040;
    }

    src = pixman_image_create_radial_gradient (&inner, &centers[geometry], 0,
					       outer_radii[geometry], stops,
					       ARRAY_LENGTH (stops));
    if (!src)
	abort ();
    pixman_image_set_repeat (src, repeat);
    if (use_transform)
	pixman_image_set_transform (src, &transform);

    if (mask_mode != MASK_ABSENT)
    {
	mask = pixman_image_create_bits (PIXMAN_a8, width, height, NULL, -1);
	if (!mask)
	    abort ();
	mask_bits   = (uint8_t *)pixman_image_get_data (mask);
	mask_stride = pixman_image_get_stride (mask);
	for (y = 0; y < height; ++y)
	{
	    for (x = 0; x < width; ++x)
	    {
		int visible;

		if (mask_mode == MASK_ALL_VISIBLE)
		    visible = 1;
		else if (mask_mode == MASK_FIFTEEN_SIXTEENTHS_VISIBLE)
		    visible = (x + 2 * y) % 16 != 0;
		else if (mask_mode == MASK_ONE_SIXTEENTH_VISIBLE)
		    visible = (x + 2 * y) % 16 == 0;
		else if (mask_mode == MASK_ALL_HIDDEN)
		    visible = 0;
		else if (mask_mode == MASK_ONE_THIRD_VISIBLE)
		    visible = (x + 2 * y) % 3 == 0;
		else
		    visible = (x + 2 * y) % 3 != 0;

		mask_bits[y * mask_stride + x] = visible ? 255 : 0;
	    }
	}
    }

    pixman_image_composite32 (PIXMAN_OP_OVER, src, mask, dest, -12, -3, 0, 0, 0,
			      0, width, height);
    crc = compute_crc32_for_image (0, dest);

    if (verbose)
	printf ("geometry=%d transform=%d mask=%d repeat=%d width=%d: %08x\n",
		geometry, use_transform, mask_mode, repeat, width, crc);

    if (mask)
	pixman_image_unref (mask);
    pixman_image_unref (src);
    pixman_image_unref (dest);

    return crc;
}

int
main (int argc, const char *argv[])
{
    return fuzzer_test_main ("radial gradient", N_CASES, 0xEB7FC058,
			     test_radial, argc, argv);
}
