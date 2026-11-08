#include "utils.h"
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int
main (int argc, char **argv)
{
    static const pixman_point_fixed_t inner = { 0x0000, 0x0000 };
    static const pixman_point_fixed_t outer = { 0x0000, 0x0000 };
    static const pixman_fixed_t r_inner = 0;
    static const pixman_fixed_t r_outer = 64 << 16;
    static const pixman_gradient_stop_t stops[] = {
	{ 0x00000, { 0x6666, 0x6666, 0x6666, 0xffff } },
	{ 0x10000, { 0x0000, 0x0000, 0x0000, 0xffff } }
    };
    static const pixman_transform_t transform = {
	{ { 0x0,        0x26ee, 0x0}, 
	  { 0xffffeeef, 0x0,    0x0}, 
	  { 0x0,        0x0,    0x10000}
	}
    };
    static const pixman_color_t z = { 0x0000, 0x0000, 0x0000, 0x0000 };
    pixman_image_t *dest, *radial, *zero, *mask = NULL;
    int i, x, y, visible_percent = 0;
    double before, after;

    if (argc != 1)
    {
	char *end;
	long value;

	if (argc != 3 || strcmp (argv[1], "--mask-visible") != 0)
	    goto usage;

	errno = 0;
	value = strtol (argv[2], &end, 10);
	if (errno || end == argv[2] || *end || value < 0 || value > 100)
	    goto usage;
	visible_percent = value;
    }

    dest = pixman_image_create_bits (
	PIXMAN_x8r8g8b8, 640, 429, NULL, -1);
    zero = pixman_image_create_solid_fill (&z);
    radial = pixman_image_create_radial_gradient (
	&inner, &outer, r_inner, r_outer, stops, ARRAY_LENGTH (stops));
    pixman_image_set_transform (radial, &transform);
    pixman_image_set_repeat (radial, PIXMAN_REPEAT_PAD);

    if (argc != 1)
    {
	uint8_t *bits;
	int      stride;

	mask = pixman_image_create_bits (PIXMAN_a8, 640, 361, NULL, -1);
	if (!mask)
	    return 1;
	bits   = (uint8_t *)pixman_image_get_data (mask);
	stride = pixman_image_get_stride (mask);
	/* Use the same deterministic mask pattern in every run. */
	for (y = 0; y < 361; ++y)
	{
	    for (x = 0; x < 640; ++x)
		bits[y * stride + x] = ((x + 2 * y) % 100 < visible_percent)
					   ? 255
					   : 0;
	}
    }

#define N_COMPOSITE	500

    before = gettime();
    for (i = 0; i < N_COMPOSITE; ++i)
    {
	before -= gettime();

	pixman_image_composite (
	    PIXMAN_OP_SRC, zero, NULL, dest,
	    0, 0, 0, 0, 0, 0, 640, 429);

	before += gettime();

	pixman_image_composite32 (
	    PIXMAN_OP_OVER, radial, mask, dest,
	    - 150, -158, 0, 0, 0, 0, 640, 361);
    }

    after = gettime();

    write_png (dest, "radial.png");

    printf ("Average time to composite: %f\n", (after - before) / N_COMPOSITE);
    if (mask)
	pixman_image_unref (mask);
    return 0;

usage:
    fprintf (stderr, "Usage: %s [--mask-visible PERCENT]\n", argv[0]);
    return 1;
}
