#include <assert.h>
#include <limits.h>
#include <stdlib.h>
#include <stdio.h>
#include "utils.h"

/* Adding an unsigned size to a negative origin used to wrap before the
 * result was stored in a double.
 */
static void
test_region64f_negative_origin (void)
{
    pixman_region64f_t rf, expected;
    pixman_box64f_t *box;

    pixman_region64f_init_rectf (&expected, -10, -10, 5, 5);
    pixman_region64f_init_rect (&rf, -10, -10, 5, 5);
    assert (pixman_region64f_equal (&rf, &expected));
    pixman_region64f_fini (&rf);

    pixman_region64f_init_rectf (&rf, -20, -20, 40, 40);
    assert (pixman_region64f_intersect_rect (&rf, &rf, -10, -10, 5, 5));
    assert (pixman_region64f_equal (&rf, &expected));
    pixman_region64f_fini (&rf);

    pixman_region64f_init (&rf);
    assert (pixman_region64f_union_rect (&rf, &rf, -10, -10, 5, 5));
    assert (pixman_region64f_equal (&rf, &expected));
    pixman_region64f_fini (&rf);
    pixman_region64f_fini (&expected);

    pixman_region64f_init_rect (&rf, -10, -10, 0, 1);
    assert (pixman_region64f_n_rects (&rf) == 0);
    pixman_region64f_fini (&rf);

    pixman_region64f_init_rect (&rf, -10, -10, UINT_MAX, 1);
    box = pixman_region64f_extents (&rf);
    assert (box->x1 == -10);
    assert (box->x2 == (double)UINT_MAX - 10);
    pixman_region64f_fini (&rf);
}

int
main ()
{
    pixman_region32_t r1;
    pixman_region32_t r2;
    pixman_region32_t r3;
    pixman_box32_t boxes[] = {
	{ 10, 10, 20, 20 },
	{ 30, 30, 30, 40 },
	{ 50, 45, 60, 44 },
    };
    pixman_box32_t boxes2[] = {
	{ 2, 6, 7, 6 },
	{ 4, 1, 6, 7 },
    };
    pixman_box32_t boxes3[] = {
	{ 2, 6, 7, 6 },
	{ 4, 1, 6, 1 },
    };
    int i, j;
    pixman_box32_t *b;
    pixman_image_t *image, *fill;
    pixman_color_t white = {
	0xffff,
	0xffff,
	0xffff,
	0xffff
    };

    /* An empty intersection used to leave a degenerate one-box region. */
    for (i = 0; i < 2; i++)
    {
	for (j = 0; j < 2; j++)
	{
	    pixman_region16_t  r16;
	    pixman_region64f_t rf;

	    pixman_region_init_rect (&r16, -10, -10, 20, 20);
	    pixman_region_intersect_rect (&r16, &r16, 0, 0, i, j);
	    assert (pixman_region_not_empty (&r16) == (i && j));
	    assert (pixman_region_n_rects (&r16) == (i && j));
	    pixman_region_fini (&r16);

	    pixman_region32_init_rect (&r1, -10, -10, 20, 20);
	    pixman_region32_intersect_rect (&r1, &r1, 0, 0, i, j);
	    assert (pixman_region32_not_empty (&r1) == (i && j));
	    assert (pixman_region32_n_rects (&r1) == (i && j));
	    pixman_region32_fini (&r1);

	    pixman_region64f_init_rect (&rf, -10, -10, 20, 20);
	    pixman_region64f_intersect_rect (&rf, &rf, 0, 0, i, j);
	    assert (pixman_region64f_not_empty (&rf) == (i && j));
	    assert (pixman_region64f_n_rects (&rf) == (i && j));
	    pixman_region64f_fini (&rf);

	    pixman_region64f_init_rectf (&rf, -10.5, -10.5, 20.5, 20.5);
	    pixman_region64f_intersect_rectf (&rf, &rf, 0.5, 0.5, i, j);
	    assert (pixman_region64f_not_empty (&rf) == (i && j));
	    assert (pixman_region64f_n_rects (&rf) == (i && j));
	    pixman_region64f_fini (&rf);
	}
    }

    test_region64f_negative_origin ();

    prng_srand (0);

    /* This used to go into an infinite loop before pixman-region.c
     * was fixed to not use explict "short" variables
     */
    pixman_region32_init_rect (&r1, 0, 0, 20, 64000);
    pixman_region32_init_rect (&r2, 0, 0, 20, 64000);
    pixman_region32_init_rect (&r3, 0, 0, 20, 64000);

    pixman_region32_subtract (&r1, &r2, &r3);


    /* This would produce a region containing an empty
     * rectangle in it. Such regions are considered malformed,
     * but using an empty rectangle for initialization should
     * work.
     */
    pixman_region32_init_rects (&r1, boxes, 3);

    b = pixman_region32_rectangles (&r1, &i);

    assert (i == 1);
    
    while (i--)
    {
	assert (b[i].x1 < b[i].x2);
	assert (b[i].y1 < b[i].y2);
    }

    /* This would produce a rectangle containing the bounding box
     * of the two rectangles. The correct result is to eliminate
     * the broken rectangle.
     */
    pixman_region32_init_rects (&r1, boxes2, 2);

    b = pixman_region32_rectangles (&r1, &i);

    assert (i == 1);

    assert (b[0].x1 == 4);
    assert (b[0].y1 == 1);
    assert (b[0].x2 == 6);
    assert (b[0].y2 == 7);

    /* This should produce an empty region */
    pixman_region32_init_rects (&r1, boxes3, 2);

    b = pixman_region32_rectangles (&r1, &i);

    assert (i == 0);

    fill = pixman_image_create_solid_fill (&white);
    for (i = 0; i < 100; i++)
    {
	int image_size = 128;

	pixman_region32_init (&r1);

	/* Add some random rectangles */
	for (j = 0; j < 64; j++)
	    pixman_region32_union_rect (&r1, &r1,
					prng_rand_n (image_size),
					prng_rand_n (image_size),
					prng_rand_n (25),
					prng_rand_n (25));

	/* Clip to image size */
	pixman_region32_init_rect (&r2, 0, 0, image_size, image_size);
	pixman_region32_intersect (&r1, &r1, &r2);
	pixman_region32_fini (&r2);

	/* render region to a1 mask */
	image = pixman_image_create_bits (PIXMAN_a1, image_size, image_size, NULL, 0);
	pixman_image_set_clip_region32 (image, &r1);
	pixman_image_composite32 (PIXMAN_OP_SRC,
				  fill, NULL, image,
				  0, 0, 0, 0, 0, 0,
				  image_size, image_size);
	pixman_region32_init_from_image (&r2, image);

	pixman_image_unref (image);

	assert (pixman_region32_equal (&r1, &r2));
	pixman_region32_fini (&r1);
	pixman_region32_fini (&r2);

    }
    pixman_image_unref (fill);

    return 0;
}
