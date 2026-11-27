; Generated from opus pixman/pixman-arma64-neon-asm-bilinear.S for armasm64: its macros expanded with llvm-mc

	AREA |.text|, CODE, READONLY, ALIGN=4
	ALIGN 4
	EXPORT pixman_scaled_bilinear_scanline_8888_8_8888_SRC_asm_neon
pixman_scaled_bilinear_scanline_8888_8_8888_SRC_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x10, x11, [x29, #-80]
	stp	x12, x13, [x29, #-96]
	stp	x14, x15, [x29, #-112]
	stur	x8, [x29, #-120]
	ldr	w8, [x29, #16]
	sub	sp, sp, #120
	mov	w10, #28
	umull	x12, w10, w7
	sub	x15, x3, x2
	cmp	x8, #0
	b.le	L_0
	dup	v12.8h, w6
	dup	v13.8h, w7
	dup	v28.8b, w4
	dup	v29.8b, w5
	mov	v25.d[0], v12.d[1]
	mov	v26.d[0], v13.d[0]
	add	v25.4h, v25.4h, v26.4h
	mov	v12.d[1], v25.d[0]
	cmp	x8, #1
	b.lt	L_1
	tst	x0, #0x4
	b.eq	L_1
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v0.2s }, [x10], x15
	ld1	{ v1.2s }, [x10]
	ld1	{ v4.b }[0], [x1], #1
	prfum	pldl1keep, [x1, #28]
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	dup	v4.8b, v4.b[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.s }[0], [x0], #4
	sub	x8, x8, #1
L_1
	add	v13.8h, v13.8h, v13.8h
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	cmp	x8, #2
	b.lt	L_2
	tst	x0, #0x8
	b.eq	L_2
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v18.2s }, [x10], x15
	ld1	{ v19.2s }, [x10]
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v4.h }[0], [x1], #2
	prfum	pldl1keep, [x1, #28]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	dup	v4.4h, v4.h[0]
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s }, [x0], #8
	sub	x8, x8, #2
L_2
	subs	x8, x8, #4
	b.lt	L_3
	asr	x12, x12, #14
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v4.2s }, [x10], x15
	ld1	{ v5.2s }, [x10]
	umull	v1.8h, v4.8b, v28.8b
	umlal	v1.8h, v5.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v6.2s }, [x10], x15
	ld1	{ v7.2s }, [x10]
	umull	v11.8h, v6.8b, v28.8b
	umlal	v11.8h, v7.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v16.2s }, [x10], x15
	ld1	{ v17.2s }, [x10]
	umull	v3.8h, v16.8b, v28.8b
	umlal	v3.8h, v17.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v9.8h, v20.8b, v28.8b
	umlal	v9.8h, v21.8b, v29.8b
	prfm	pldl1keep, [x10, x12]
	sub	x10, x10, x15
	prfm	pldl1keep, [x10, x12]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	ushr	v15.8h, v12.8h, #9
	ushll	v2.4s, v3.4h, #7
	umlsl	v2.4s, v3.4h, v15.h[0]
	umlal2	v2.4s, v3.8h, v15.h[0]
	ushll	v8.4s, v9.4h, #7
	umlsl	v8.4s, v9.4h, v15.h[4]
	umlal2	v8.4s, v9.8h, v15.h[4]
	add	v12.8h, v12.8h, v13.8h
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	shrn	v2.4h, v2.4s, #14
	shrn2	v2.8h, v8.4s, #14
	ld1	{ v4.s }[0], [x1], #4
	prfum	pldl1keep, [x1, #28]
	dup	v4.2s, v4.s[0]
	ushr	v15.8h, v12.8h, #9
	xtn	v0.8b, v0.8h
	xtn	v1.8b, v2.8h
	add	v12.8h, v12.8h, v13.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v11.d[1], v3.d[0]
	mov	v11.d[0], v2.d[0]
	umull	v6.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v9.8h, v6.8h, #8
	urshr	v10.8h, v8.8h, #8
	raddhn	v0.8b, v9.8h, v6.8h
	raddhn	v1.8b, v10.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s, v1.2s }, [x0], #16
	subs	x8, x8, #4
	b.lt	L_4
L_5
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v4.2s }, [x10], x15
	ld1	{ v5.2s }, [x10]
	umull	v1.8h, v4.8b, v28.8b
	umlal	v1.8h, v5.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v6.2s }, [x10], x15
	ld1	{ v7.2s }, [x10]
	umull	v11.8h, v6.8b, v28.8b
	umlal	v11.8h, v7.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v16.2s }, [x10], x15
	ld1	{ v17.2s }, [x10]
	umull	v3.8h, v16.8b, v28.8b
	umlal	v3.8h, v17.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v9.8h, v20.8b, v28.8b
	umlal	v9.8h, v21.8b, v29.8b
	prfm	pldl1keep, [x10, x12]
	sub	x10, x10, x15
	prfm	pldl1keep, [x10, x12]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	ushr	v15.8h, v12.8h, #9
	ushll	v2.4s, v3.4h, #7
	umlsl	v2.4s, v3.4h, v15.h[0]
	umlal2	v2.4s, v3.8h, v15.h[0]
	ushll	v8.4s, v9.4h, #7
	umlsl	v8.4s, v9.4h, v15.h[4]
	umlal2	v8.4s, v9.8h, v15.h[4]
	add	v12.8h, v12.8h, v13.8h
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	shrn	v2.4h, v2.4s, #14
	shrn2	v2.8h, v8.4s, #14
	ld1	{ v4.s }[0], [x1], #4
	prfum	pldl1keep, [x1, #28]
	dup	v4.2s, v4.s[0]
	ushr	v15.8h, v12.8h, #9
	xtn	v0.8b, v0.8h
	xtn	v1.8b, v2.8h
	add	v12.8h, v12.8h, v13.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v11.d[1], v3.d[0]
	mov	v11.d[0], v2.d[0]
	umull	v6.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v9.8h, v6.8h, #8
	urshr	v10.8h, v8.8h, #8
	raddhn	v0.8b, v9.8h, v6.8h
	raddhn	v1.8b, v10.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s, v1.2s }, [x0], #16
	subs	x8, x8, #4
	b.ge	L_5
L_4
L_3
	tst	x8, #0x2
	b.eq	L_6
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v18.2s }, [x10], x15
	ld1	{ v19.2s }, [x10]
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v4.h }[0], [x1], #2
	prfum	pldl1keep, [x1, #28]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	dup	v4.4h, v4.h[0]
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s }, [x0], #8
L_6
	tst	x8, #0x1
	b.eq	L_0
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v0.2s }, [x10], x15
	ld1	{ v1.2s }, [x10]
	ld1	{ v4.b }[0], [x1], #1
	prfum	pldl1keep, [x1, #28]
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	dup	v4.8b, v4.b[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.s }[0], [x0], #4
L_0
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x10, x11, [x29, #-80]
	ldp	x12, x13, [x29, #-96]
	ldp	x14, x15, [x29, #-112]
	ldur	x8, [x29, #-120]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_scaled_bilinear_scanline_8888_8_0565_SRC_asm_neon
pixman_scaled_bilinear_scanline_8888_8_0565_SRC_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x10, x11, [x29, #-80]
	stp	x12, x13, [x29, #-96]
	stp	x14, x15, [x29, #-112]
	stur	x8, [x29, #-120]
	ldr	w8, [x29, #16]
	sub	sp, sp, #120
	mov	w10, #28
	umull	x12, w10, w7
	sub	x15, x3, x2
	cmp	x8, #0
	b.le	L_7
	dup	v12.8h, w6
	dup	v13.8h, w7
	dup	v28.8b, w4
	dup	v29.8b, w5
	mov	v25.d[0], v12.d[1]
	mov	v26.d[0], v13.d[0]
	add	v25.4h, v25.4h, v26.4h
	mov	v12.d[1], v25.d[0]
	cmp	x8, #1
	b.lt	L_8
	tst	x0, #0x2
	b.eq	L_8
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v0.2s }, [x10], x15
	ld1	{ v1.2s }, [x10]
	ld1	{ v4.b }[0], [x1], #1
	prfum	pldl1keep, [x1, #28]
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	dup	v4.8b, v4.b[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v24.8b
	uzp1	v24.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v24.8b
	ushll	v17.8h, v1.8b, #7
	shl	v17.8h, v17.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v18.8h, v0.8b, #7
	shl	v18.8h, v18.8h, #1
	sri	v1.8h, v17.8h, #5
	sri	v1.8h, v18.8h, #11
	st1	{ v1.h }[0], [x0], #2
	sub	x8, x8, #1
L_8
	add	v13.8h, v13.8h, v13.8h
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	cmp	x8, #2
	b.lt	L_9
	tst	x0, #0x4
	b.eq	L_9
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v18.2s }, [x10], x15
	ld1	{ v19.2s }, [x10]
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v4.h }[0], [x1], #2
	prfum	pldl1keep, [x1, #28]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	dup	v4.4h, v4.h[0]
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v24.8b
	uzp1	v24.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v24.8b
	ushll	v16.8h, v1.8b, #7
	shl	v16.8h, v16.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v17.8h, v0.8b, #7
	shl	v17.8h, v17.8h, #1
	sri	v1.8h, v16.8h, #5
	sri	v1.8h, v17.8h, #11
	st1	{ v1.s }[0], [x0], #4
	sub	x8, x8, #2
L_9
	subs	x8, x8, #4
	b.lt	L_10
	asr	x12, x12, #14
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v4.2s }, [x10], x15
	ld1	{ v5.2s }, [x10]
	umull	v1.8h, v4.8b, v28.8b
	umlal	v1.8h, v5.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v6.2s }, [x10], x15
	ld1	{ v7.2s }, [x10]
	umull	v11.8h, v6.8b, v28.8b
	umlal	v11.8h, v7.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v16.2s }, [x10], x15
	ld1	{ v17.2s }, [x10]
	umull	v3.8h, v16.8b, v28.8b
	umlal	v3.8h, v17.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v9.8h, v20.8b, v28.8b
	umlal	v9.8h, v21.8b, v29.8b
	prfm	pldl1keep, [x10, x12]
	sub	x10, x10, x15
	prfm	pldl1keep, [x10, x12]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	ushr	v15.8h, v12.8h, #9
	ushll	v2.4s, v3.4h, #7
	umlsl	v2.4s, v3.4h, v15.h[0]
	umlal2	v2.4s, v3.8h, v15.h[0]
	ushll	v8.4s, v9.4h, #7
	umlsl	v8.4s, v9.4h, v15.h[4]
	umlal2	v8.4s, v9.8h, v15.h[4]
	add	v12.8h, v12.8h, v13.8h
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	shrn	v2.4h, v2.4s, #14
	shrn2	v2.8h, v8.4s, #14
	ld1	{ v4.s }[0], [x1], #4
	prfum	pldl1keep, [x1, #28]
	dup	v4.2s, v4.s[0]
	ushr	v15.8h, v12.8h, #9
	xtn	v0.8b, v0.8h
	xtn	v1.8b, v2.8h
	add	v12.8h, v12.8h, v13.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v11.d[1], v3.d[0]
	mov	v11.d[0], v2.d[0]
	umull	v6.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v9.8h, v6.8h, #8
	urshr	v10.8h, v8.8h, #8
	raddhn	v0.8b, v9.8h, v6.8h
	raddhn	v1.8b, v10.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v24.8b
	uzp1	v24.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v24.8b
	ushll	v6.8h, v1.8b, #7
	shl	v6.8h, v6.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v7.8h, v0.8b, #7
	shl	v7.8h, v7.8h, #1
	sri	v1.8h, v6.8h, #5
	sri	v1.8h, v7.8h, #11
	st1	{ v1.4h }, [x0], #8
	subs	x8, x8, #4
	b.lt	L_11
L_12
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v4.2s }, [x10], x15
	ld1	{ v5.2s }, [x10]
	umull	v1.8h, v4.8b, v28.8b
	umlal	v1.8h, v5.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v6.2s }, [x10], x15
	ld1	{ v7.2s }, [x10]
	umull	v11.8h, v6.8b, v28.8b
	umlal	v11.8h, v7.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v16.2s }, [x10], x15
	ld1	{ v17.2s }, [x10]
	umull	v3.8h, v16.8b, v28.8b
	umlal	v3.8h, v17.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v9.8h, v20.8b, v28.8b
	umlal	v9.8h, v21.8b, v29.8b
	prfm	pldl1keep, [x10, x12]
	sub	x10, x10, x15
	prfm	pldl1keep, [x10, x12]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	ushr	v15.8h, v12.8h, #9
	ushll	v2.4s, v3.4h, #7
	umlsl	v2.4s, v3.4h, v15.h[0]
	umlal2	v2.4s, v3.8h, v15.h[0]
	ushll	v8.4s, v9.4h, #7
	umlsl	v8.4s, v9.4h, v15.h[4]
	umlal2	v8.4s, v9.8h, v15.h[4]
	add	v12.8h, v12.8h, v13.8h
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	shrn	v2.4h, v2.4s, #14
	shrn2	v2.8h, v8.4s, #14
	ld1	{ v4.s }[0], [x1], #4
	prfum	pldl1keep, [x1, #28]
	dup	v4.2s, v4.s[0]
	ushr	v15.8h, v12.8h, #9
	xtn	v0.8b, v0.8h
	xtn	v1.8b, v2.8h
	add	v12.8h, v12.8h, v13.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v11.d[1], v3.d[0]
	mov	v11.d[0], v2.d[0]
	umull	v6.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v9.8h, v6.8h, #8
	urshr	v10.8h, v8.8h, #8
	raddhn	v0.8b, v9.8h, v6.8h
	raddhn	v1.8b, v10.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v24.8b
	uzp1	v24.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v24.8b
	ushll	v6.8h, v1.8b, #7
	shl	v6.8h, v6.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v7.8h, v0.8b, #7
	shl	v7.8h, v7.8h, #1
	sri	v1.8h, v6.8h, #5
	sri	v1.8h, v7.8h, #11
	st1	{ v1.4h }, [x0], #8
	subs	x8, x8, #4
	b.ge	L_12
L_11
L_10
	tst	x8, #0x2
	b.eq	L_13
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v18.2s }, [x10], x15
	ld1	{ v19.2s }, [x10]
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v4.h }[0], [x1], #2
	prfum	pldl1keep, [x1, #28]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	dup	v4.4h, v4.h[0]
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v24.8b
	uzp1	v24.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v24.8b
	ushll	v16.8h, v1.8b, #7
	shl	v16.8h, v16.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v17.8h, v0.8b, #7
	shl	v17.8h, v17.8h, #1
	sri	v1.8h, v16.8h, #5
	sri	v1.8h, v17.8h, #11
	st1	{ v1.s }[0], [x0], #4
L_13
	tst	x8, #0x1
	b.eq	L_7
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v0.2s }, [x10], x15
	ld1	{ v1.2s }, [x10]
	ld1	{ v4.b }[0], [x1], #1
	prfum	pldl1keep, [x1, #28]
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	dup	v4.8b, v4.b[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v24.8b
	uzp1	v24.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v24.8b
	ushll	v17.8h, v1.8b, #7
	shl	v17.8h, v17.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v18.8h, v0.8b, #7
	shl	v18.8h, v18.8h, #1
	sri	v1.8h, v17.8h, #5
	sri	v1.8h, v18.8h, #11
	st1	{ v1.h }[0], [x0], #2
L_7
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x10, x11, [x29, #-80]
	ldp	x12, x13, [x29, #-96]
	ldp	x14, x15, [x29, #-112]
	ldur	x8, [x29, #-120]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_scaled_bilinear_scanline_0565_8_x888_SRC_asm_neon
pixman_scaled_bilinear_scanline_0565_8_x888_SRC_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x10, x11, [x29, #-80]
	stp	x12, x13, [x29, #-96]
	stp	x14, x15, [x29, #-112]
	stur	x8, [x29, #-120]
	ldr	w8, [x29, #16]
	sub	sp, sp, #120
	mov	w10, #28
	umull	x12, w10, w7
	sub	x15, x3, x2
	cmp	x8, #0
	b.le	L_14
	dup	v12.8h, w6
	dup	v13.8h, w7
	dup	v28.8b, w4
	dup	v29.8b, w5
	mov	v25.d[0], v12.d[1]
	mov	v26.d[0], v13.d[0]
	add	v25.4h, v25.4h, v26.4h
	mov	v12.d[1], v25.d[0]
	cmp	x8, #1
	b.lt	L_15
	tst	x0, #0x4
	b.eq	L_15
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #1
	ld1	{ v1.s }[0], [x10], x15
	ld1	{ v1.s }[1], [x10]
	shl	v0.4h, v1.4h, #5
	shl	v2.4h, v1.4h, #11
	sri	v1.4h, v1.4h, #5
	sri	v0.4h, v0.4h, #6
	sri	v2.4h, v2.4h, #5
	ushr	v1.4h, v1.4h, #8
	sri	v0.4h, v2.4h, #8
	zip1	v2.4h, v0.4h, v1.4h
	zip2	v1.4h, v0.4h, v1.4h
	mov	v0.d[0], v2.d[0]
	ld1	{ v4.b }[0], [x1], #1
	prfum	pldl1keep, [x1, #28]
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	dup	v4.8b, v4.b[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.s }[0], [x0], #4
	sub	x8, x8, #1
L_15
	add	v13.8h, v13.8h, v13.8h
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	cmp	x8, #2
	b.lt	L_16
	tst	x0, #0x8
	b.eq	L_16
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #1
	asr	w11, w6, #16
	add	w6, w6, w7
	add	x11, x2, x11, lsl #1
	ld1	{ v11.s }[0], [x10], x15
	ld1	{ v11.s }[2], [x11], x15
	ld1	{ v11.s }[1], [x10]
	ld1	{ v11.s }[3], [x11]
	shrn	v20.8b, v11.8h, #8
	shrn	v19.8b, v11.8h, #3
	sli	v11.8h, v11.8h, #5
	sri	v20.8b, v20.8b, #5
	sri	v19.8b, v19.8b, #6
	shrn	v18.8b, v11.8h, #2
	zip1	v24.8b, v18.8b, v20.8b
	zip2	v20.8b, v18.8b, v20.8b
	mov	v18.8b, v24.8b
	zip1	v24.8b, v19.8b, v21.8b
	zip2	v21.8b, v19.8b, v21.8b
	mov	v19.8b, v24.8b
	zip1	v24.8b, v20.8b, v21.8b
	zip2	v21.8b, v20.8b, v21.8b
	mov	v20.8b, v24.8b
	zip1	v24.8b, v18.8b, v19.8b
	zip2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v4.h }[0], [x1], #2
	prfum	pldl1keep, [x1, #28]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	dup	v4.4h, v4.h[0]
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s }, [x0], #8
	sub	x8, x8, #2
L_16
	subs	x8, x8, #4
	b.lt	L_17
	asr	x12, x12, #15
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #1
	asr	w11, w6, #16
	add	w6, w6, w7
	add	x11, x2, x11, lsl #1
	ld1	{ v11.s }[0], [x10], x15
	ld1	{ v11.s }[2], [x11], x15
	ld1	{ v11.s }[1], [x10]
	ld1	{ v11.s }[3], [x11]
	shrn	v6.8b, v11.8h, #8
	shrn	v5.8b, v11.8h, #3
	sli	v11.8h, v11.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v11.8h, #2
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #1
	asr	w11, w6, #16
	add	w6, w6, w7
	add	x11, x2, x11, lsl #1
	ld1	{ v9.s }[0], [x10], x15
	zip1	v24.8b, v4.8b, v6.8b
	zip2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v24.8b
	ld1	{ v9.s }[2], [x11], x15
	zip1	v24.8b, v5.8b, v7.8b
	zip2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v24.8b
	ld1	{ v9.s }[1], [x10]
	zip1	v24.8b, v6.8b, v7.8b
	zip2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v24.8b
	ld1	{ v9.s }[3], [x11]
	zip1	v24.8b, v4.8b, v5.8b
	zip2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v24.8b
	shrn	v20.8b, v9.8h, #8
	shrn	v17.8b, v9.8h, #3
	sli	v9.8h, v9.8h, #5
	sri	v20.8b, v20.8b, #5
	sri	v17.8b, v17.8b, #6
	shrn	v16.8b, v9.8h, #2
	umull	v1.8h, v4.8b, v28.8b
	zip1	v24.8b, v16.8b, v20.8b
	zip2	v20.8b, v16.8b, v20.8b
	mov	v16.8b, v24.8b
	umlal	v1.8h, v5.8b, v29.8b
	zip1	v24.8b, v17.8b, v21.8b
	zip2	v21.8b, v17.8b, v21.8b
	mov	v17.8b, v24.8b
	umull	v11.8h, v6.8b, v28.8b
	zip1	v24.8b, v20.8b, v21.8b
	zip2	v21.8b, v20.8b, v21.8b
	mov	v20.8b, v24.8b
	umlal	v11.8h, v7.8b, v29.8b
	zip1	v24.8b, v16.8b, v17.8b
	zip2	v17.8b, v16.8b, v17.8b
	mov	v16.8b, v24.8b
	umull	v3.8h, v16.8b, v28.8b
	umlal	v3.8h, v17.8b, v29.8b
	umull	v9.8h, v20.8b, v28.8b
	umlal	v9.8h, v21.8b, v29.8b
	prfm	pldl1keep, [x10, x12]
	sub	x10, x10, x15
	prfm	pldl1keep, [x10, x12]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	ushr	v15.8h, v12.8h, #9
	ushll	v2.4s, v3.4h, #7
	umlsl	v2.4s, v3.4h, v15.h[0]
	umlal2	v2.4s, v3.8h, v15.h[0]
	ushll	v8.4s, v9.4h, #7
	umlsl	v8.4s, v9.4h, v15.h[4]
	umlal2	v8.4s, v9.8h, v15.h[4]
	add	v12.8h, v12.8h, v13.8h
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	shrn	v2.4h, v2.4s, #14
	shrn2	v2.8h, v8.4s, #14
	ld1	{ v4.s }[0], [x1], #4
	prfum	pldl1keep, [x1, #28]
	dup	v4.2s, v4.s[0]
	ushr	v15.8h, v12.8h, #9
	xtn	v0.8b, v0.8h
	xtn	v1.8b, v2.8h
	add	v12.8h, v12.8h, v13.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v11.d[1], v3.d[0]
	mov	v11.d[0], v2.d[0]
	umull	v6.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v9.8h, v6.8h, #8
	urshr	v10.8h, v8.8h, #8
	raddhn	v0.8b, v9.8h, v6.8h
	raddhn	v1.8b, v10.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s, v1.2s }, [x0], #16
	subs	x8, x8, #4
	b.lt	L_18
L_19
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #1
	asr	w11, w6, #16
	add	w6, w6, w7
	add	x11, x2, x11, lsl #1
	ld1	{ v11.s }[0], [x10], x15
	ld1	{ v11.s }[2], [x11], x15
	ld1	{ v11.s }[1], [x10]
	ld1	{ v11.s }[3], [x11]
	shrn	v6.8b, v11.8h, #8
	shrn	v5.8b, v11.8h, #3
	sli	v11.8h, v11.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v11.8h, #2
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #1
	asr	w11, w6, #16
	add	w6, w6, w7
	add	x11, x2, x11, lsl #1
	ld1	{ v9.s }[0], [x10], x15
	zip1	v24.8b, v4.8b, v6.8b
	zip2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v24.8b
	ld1	{ v9.s }[2], [x11], x15
	zip1	v24.8b, v5.8b, v7.8b
	zip2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v24.8b
	ld1	{ v9.s }[1], [x10]
	zip1	v24.8b, v6.8b, v7.8b
	zip2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v24.8b
	ld1	{ v9.s }[3], [x11]
	zip1	v24.8b, v4.8b, v5.8b
	zip2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v24.8b
	shrn	v20.8b, v9.8h, #8
	shrn	v17.8b, v9.8h, #3
	sli	v9.8h, v9.8h, #5
	sri	v20.8b, v20.8b, #5
	sri	v17.8b, v17.8b, #6
	shrn	v16.8b, v9.8h, #2
	umull	v1.8h, v4.8b, v28.8b
	zip1	v24.8b, v16.8b, v20.8b
	zip2	v20.8b, v16.8b, v20.8b
	mov	v16.8b, v24.8b
	umlal	v1.8h, v5.8b, v29.8b
	zip1	v24.8b, v17.8b, v21.8b
	zip2	v21.8b, v17.8b, v21.8b
	mov	v17.8b, v24.8b
	umull	v11.8h, v6.8b, v28.8b
	zip1	v24.8b, v20.8b, v21.8b
	zip2	v21.8b, v20.8b, v21.8b
	mov	v20.8b, v24.8b
	umlal	v11.8h, v7.8b, v29.8b
	zip1	v24.8b, v16.8b, v17.8b
	zip2	v17.8b, v16.8b, v17.8b
	mov	v16.8b, v24.8b
	umull	v3.8h, v16.8b, v28.8b
	umlal	v3.8h, v17.8b, v29.8b
	umull	v9.8h, v20.8b, v28.8b
	umlal	v9.8h, v21.8b, v29.8b
	prfm	pldl1keep, [x10, x12]
	sub	x10, x10, x15
	prfm	pldl1keep, [x10, x12]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	ushr	v15.8h, v12.8h, #9
	ushll	v2.4s, v3.4h, #7
	umlsl	v2.4s, v3.4h, v15.h[0]
	umlal2	v2.4s, v3.8h, v15.h[0]
	ushll	v8.4s, v9.4h, #7
	umlsl	v8.4s, v9.4h, v15.h[4]
	umlal2	v8.4s, v9.8h, v15.h[4]
	add	v12.8h, v12.8h, v13.8h
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	shrn	v2.4h, v2.4s, #14
	shrn2	v2.8h, v8.4s, #14
	ld1	{ v4.s }[0], [x1], #4
	prfum	pldl1keep, [x1, #28]
	dup	v4.2s, v4.s[0]
	ushr	v15.8h, v12.8h, #9
	xtn	v0.8b, v0.8h
	xtn	v1.8b, v2.8h
	add	v12.8h, v12.8h, v13.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v11.d[1], v3.d[0]
	mov	v11.d[0], v2.d[0]
	umull	v6.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v9.8h, v6.8h, #8
	urshr	v10.8h, v8.8h, #8
	raddhn	v0.8b, v9.8h, v6.8h
	raddhn	v1.8b, v10.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s, v1.2s }, [x0], #16
	subs	x8, x8, #4
	b.ge	L_19
L_18
L_17
	tst	x8, #0x2
	b.eq	L_20
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #1
	asr	w11, w6, #16
	add	w6, w6, w7
	add	x11, x2, x11, lsl #1
	ld1	{ v11.s }[0], [x10], x15
	ld1	{ v11.s }[2], [x11], x15
	ld1	{ v11.s }[1], [x10]
	ld1	{ v11.s }[3], [x11]
	shrn	v20.8b, v11.8h, #8
	shrn	v19.8b, v11.8h, #3
	sli	v11.8h, v11.8h, #5
	sri	v20.8b, v20.8b, #5
	sri	v19.8b, v19.8b, #6
	shrn	v18.8b, v11.8h, #2
	zip1	v24.8b, v18.8b, v20.8b
	zip2	v20.8b, v18.8b, v20.8b
	mov	v18.8b, v24.8b
	zip1	v24.8b, v19.8b, v21.8b
	zip2	v21.8b, v19.8b, v21.8b
	mov	v19.8b, v24.8b
	zip1	v24.8b, v20.8b, v21.8b
	zip2	v21.8b, v20.8b, v21.8b
	mov	v20.8b, v24.8b
	zip1	v24.8b, v18.8b, v19.8b
	zip2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v4.h }[0], [x1], #2
	prfum	pldl1keep, [x1, #28]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	dup	v4.4h, v4.h[0]
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s }, [x0], #8
L_20
	tst	x8, #0x1
	b.eq	L_14
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #1
	ld1	{ v1.s }[0], [x10], x15
	ld1	{ v1.s }[1], [x10]
	shl	v0.4h, v1.4h, #5
	shl	v2.4h, v1.4h, #11
	sri	v1.4h, v1.4h, #5
	sri	v0.4h, v0.4h, #6
	sri	v2.4h, v2.4h, #5
	ushr	v1.4h, v1.4h, #8
	sri	v0.4h, v2.4h, #8
	zip1	v2.4h, v0.4h, v1.4h
	zip2	v1.4h, v0.4h, v1.4h
	mov	v0.d[0], v2.d[0]
	ld1	{ v4.b }[0], [x1], #1
	prfum	pldl1keep, [x1, #28]
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	dup	v4.8b, v4.b[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.s }[0], [x0], #4
L_14
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x10, x11, [x29, #-80]
	ldp	x12, x13, [x29, #-96]
	ldp	x14, x15, [x29, #-112]
	ldur	x8, [x29, #-120]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_scaled_bilinear_scanline_0565_8_0565_SRC_asm_neon
pixman_scaled_bilinear_scanline_0565_8_0565_SRC_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x10, x11, [x29, #-80]
	stp	x12, x13, [x29, #-96]
	stp	x14, x15, [x29, #-112]
	stur	x8, [x29, #-120]
	ldr	w8, [x29, #16]
	sub	sp, sp, #120
	mov	w10, #28
	umull	x12, w10, w7
	sub	x15, x3, x2
	cmp	x8, #0
	b.le	L_21
	dup	v12.8h, w6
	dup	v13.8h, w7
	dup	v28.8b, w4
	dup	v29.8b, w5
	mov	v25.d[0], v12.d[1]
	mov	v26.d[0], v13.d[0]
	add	v25.4h, v25.4h, v26.4h
	mov	v12.d[1], v25.d[0]
	cmp	x8, #1
	b.lt	L_22
	tst	x0, #0x2
	b.eq	L_22
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #1
	ld1	{ v1.s }[0], [x10], x15
	ld1	{ v1.s }[1], [x10]
	shl	v0.4h, v1.4h, #5
	shl	v2.4h, v1.4h, #11
	sri	v1.4h, v1.4h, #5
	sri	v0.4h, v0.4h, #6
	sri	v2.4h, v2.4h, #5
	ushr	v1.4h, v1.4h, #8
	sri	v0.4h, v2.4h, #8
	zip1	v2.4h, v0.4h, v1.4h
	zip2	v1.4h, v0.4h, v1.4h
	mov	v0.d[0], v2.d[0]
	ld1	{ v4.b }[0], [x1], #1
	prfum	pldl1keep, [x1, #28]
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	dup	v4.8b, v4.b[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v24.8b
	uzp1	v24.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v24.8b
	ushll	v17.8h, v1.8b, #7
	shl	v17.8h, v17.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v18.8h, v0.8b, #7
	shl	v18.8h, v18.8h, #1
	sri	v1.8h, v17.8h, #5
	sri	v1.8h, v18.8h, #11
	st1	{ v1.h }[0], [x0], #2
	sub	x8, x8, #1
L_22
	add	v13.8h, v13.8h, v13.8h
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	cmp	x8, #2
	b.lt	L_23
	tst	x0, #0x4
	b.eq	L_23
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #1
	asr	w11, w6, #16
	add	w6, w6, w7
	add	x11, x2, x11, lsl #1
	ld1	{ v11.s }[0], [x10], x15
	ld1	{ v11.s }[2], [x11], x15
	ld1	{ v11.s }[1], [x10]
	ld1	{ v11.s }[3], [x11]
	shrn	v20.8b, v11.8h, #8
	shrn	v19.8b, v11.8h, #3
	sli	v11.8h, v11.8h, #5
	sri	v20.8b, v20.8b, #5
	sri	v19.8b, v19.8b, #6
	shrn	v18.8b, v11.8h, #2
	zip1	v24.8b, v18.8b, v20.8b
	zip2	v20.8b, v18.8b, v20.8b
	mov	v18.8b, v24.8b
	zip1	v24.8b, v19.8b, v21.8b
	zip2	v21.8b, v19.8b, v21.8b
	mov	v19.8b, v24.8b
	zip1	v24.8b, v20.8b, v21.8b
	zip2	v21.8b, v20.8b, v21.8b
	mov	v20.8b, v24.8b
	zip1	v24.8b, v18.8b, v19.8b
	zip2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v4.h }[0], [x1], #2
	prfum	pldl1keep, [x1, #28]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	dup	v4.4h, v4.h[0]
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v24.8b
	uzp1	v24.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v24.8b
	ushll	v16.8h, v1.8b, #7
	shl	v16.8h, v16.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v17.8h, v0.8b, #7
	shl	v17.8h, v17.8h, #1
	sri	v1.8h, v16.8h, #5
	sri	v1.8h, v17.8h, #11
	st1	{ v1.s }[0], [x0], #4
	sub	x8, x8, #2
L_23
	subs	x8, x8, #4
	b.lt	L_24
	asr	x12, x12, #15
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #1
	asr	w11, w6, #16
	add	w6, w6, w7
	add	x11, x2, x11, lsl #1
	ld1	{ v11.s }[0], [x10], x15
	ld1	{ v11.s }[2], [x11], x15
	ld1	{ v11.s }[1], [x10]
	ld1	{ v11.s }[3], [x11]
	shrn	v6.8b, v11.8h, #8
	shrn	v5.8b, v11.8h, #3
	sli	v11.8h, v11.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v11.8h, #2
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #1
	asr	w11, w6, #16
	add	w6, w6, w7
	add	x11, x2, x11, lsl #1
	ld1	{ v9.s }[0], [x10], x15
	zip1	v24.8b, v4.8b, v6.8b
	zip2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v24.8b
	ld1	{ v9.s }[2], [x11], x15
	zip1	v24.8b, v5.8b, v7.8b
	zip2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v24.8b
	ld1	{ v9.s }[1], [x10]
	zip1	v24.8b, v6.8b, v7.8b
	zip2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v24.8b
	ld1	{ v9.s }[3], [x11]
	zip1	v24.8b, v4.8b, v5.8b
	zip2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v24.8b
	shrn	v20.8b, v9.8h, #8
	shrn	v17.8b, v9.8h, #3
	sli	v9.8h, v9.8h, #5
	sri	v20.8b, v20.8b, #5
	sri	v17.8b, v17.8b, #6
	shrn	v16.8b, v9.8h, #2
	umull	v1.8h, v4.8b, v28.8b
	zip1	v24.8b, v16.8b, v20.8b
	zip2	v20.8b, v16.8b, v20.8b
	mov	v16.8b, v24.8b
	umlal	v1.8h, v5.8b, v29.8b
	zip1	v24.8b, v17.8b, v21.8b
	zip2	v21.8b, v17.8b, v21.8b
	mov	v17.8b, v24.8b
	umull	v11.8h, v6.8b, v28.8b
	zip1	v24.8b, v20.8b, v21.8b
	zip2	v21.8b, v20.8b, v21.8b
	mov	v20.8b, v24.8b
	umlal	v11.8h, v7.8b, v29.8b
	zip1	v24.8b, v16.8b, v17.8b
	zip2	v17.8b, v16.8b, v17.8b
	mov	v16.8b, v24.8b
	umull	v3.8h, v16.8b, v28.8b
	umlal	v3.8h, v17.8b, v29.8b
	umull	v9.8h, v20.8b, v28.8b
	umlal	v9.8h, v21.8b, v29.8b
	prfm	pldl1keep, [x10, x12]
	sub	x10, x10, x15
	prfm	pldl1keep, [x10, x12]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	ushr	v15.8h, v12.8h, #9
	ushll	v2.4s, v3.4h, #7
	umlsl	v2.4s, v3.4h, v15.h[0]
	umlal2	v2.4s, v3.8h, v15.h[0]
	ushll	v8.4s, v9.4h, #7
	umlsl	v8.4s, v9.4h, v15.h[4]
	umlal2	v8.4s, v9.8h, v15.h[4]
	add	v12.8h, v12.8h, v13.8h
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	shrn	v2.4h, v2.4s, #14
	shrn2	v2.8h, v8.4s, #14
	ld1	{ v4.s }[0], [x1], #4
	prfum	pldl1keep, [x1, #28]
	dup	v4.2s, v4.s[0]
	ushr	v15.8h, v12.8h, #9
	xtn	v0.8b, v0.8h
	xtn	v1.8b, v2.8h
	add	v12.8h, v12.8h, v13.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v11.d[1], v3.d[0]
	mov	v11.d[0], v2.d[0]
	umull	v6.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v9.8h, v6.8h, #8
	urshr	v10.8h, v8.8h, #8
	raddhn	v0.8b, v9.8h, v6.8h
	raddhn	v1.8b, v10.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v24.8b
	uzp1	v24.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v24.8b
	ushll	v6.8h, v1.8b, #7
	shl	v6.8h, v6.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v7.8h, v0.8b, #7
	shl	v7.8h, v7.8h, #1
	sri	v1.8h, v6.8h, #5
	sri	v1.8h, v7.8h, #11
	st1	{ v1.4h }, [x0], #8
	subs	x8, x8, #4
	b.lt	L_25
L_26
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #1
	asr	w11, w6, #16
	add	w6, w6, w7
	add	x11, x2, x11, lsl #1
	ld1	{ v11.s }[0], [x10], x15
	ld1	{ v11.s }[2], [x11], x15
	ld1	{ v11.s }[1], [x10]
	ld1	{ v11.s }[3], [x11]
	shrn	v6.8b, v11.8h, #8
	shrn	v5.8b, v11.8h, #3
	sli	v11.8h, v11.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v11.8h, #2
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #1
	asr	w11, w6, #16
	add	w6, w6, w7
	add	x11, x2, x11, lsl #1
	ld1	{ v9.s }[0], [x10], x15
	zip1	v24.8b, v4.8b, v6.8b
	zip2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v24.8b
	ld1	{ v9.s }[2], [x11], x15
	zip1	v24.8b, v5.8b, v7.8b
	zip2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v24.8b
	ld1	{ v9.s }[1], [x10]
	zip1	v24.8b, v6.8b, v7.8b
	zip2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v24.8b
	ld1	{ v9.s }[3], [x11]
	zip1	v24.8b, v4.8b, v5.8b
	zip2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v24.8b
	shrn	v20.8b, v9.8h, #8
	shrn	v17.8b, v9.8h, #3
	sli	v9.8h, v9.8h, #5
	sri	v20.8b, v20.8b, #5
	sri	v17.8b, v17.8b, #6
	shrn	v16.8b, v9.8h, #2
	umull	v1.8h, v4.8b, v28.8b
	zip1	v24.8b, v16.8b, v20.8b
	zip2	v20.8b, v16.8b, v20.8b
	mov	v16.8b, v24.8b
	umlal	v1.8h, v5.8b, v29.8b
	zip1	v24.8b, v17.8b, v21.8b
	zip2	v21.8b, v17.8b, v21.8b
	mov	v17.8b, v24.8b
	umull	v11.8h, v6.8b, v28.8b
	zip1	v24.8b, v20.8b, v21.8b
	zip2	v21.8b, v20.8b, v21.8b
	mov	v20.8b, v24.8b
	umlal	v11.8h, v7.8b, v29.8b
	zip1	v24.8b, v16.8b, v17.8b
	zip2	v17.8b, v16.8b, v17.8b
	mov	v16.8b, v24.8b
	umull	v3.8h, v16.8b, v28.8b
	umlal	v3.8h, v17.8b, v29.8b
	umull	v9.8h, v20.8b, v28.8b
	umlal	v9.8h, v21.8b, v29.8b
	prfm	pldl1keep, [x10, x12]
	sub	x10, x10, x15
	prfm	pldl1keep, [x10, x12]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	ushr	v15.8h, v12.8h, #9
	ushll	v2.4s, v3.4h, #7
	umlsl	v2.4s, v3.4h, v15.h[0]
	umlal2	v2.4s, v3.8h, v15.h[0]
	ushll	v8.4s, v9.4h, #7
	umlsl	v8.4s, v9.4h, v15.h[4]
	umlal2	v8.4s, v9.8h, v15.h[4]
	add	v12.8h, v12.8h, v13.8h
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	shrn	v2.4h, v2.4s, #14
	shrn2	v2.8h, v8.4s, #14
	ld1	{ v4.s }[0], [x1], #4
	prfum	pldl1keep, [x1, #28]
	dup	v4.2s, v4.s[0]
	ushr	v15.8h, v12.8h, #9
	xtn	v0.8b, v0.8h
	xtn	v1.8b, v2.8h
	add	v12.8h, v12.8h, v13.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v11.d[1], v3.d[0]
	mov	v11.d[0], v2.d[0]
	umull	v6.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v9.8h, v6.8h, #8
	urshr	v10.8h, v8.8h, #8
	raddhn	v0.8b, v9.8h, v6.8h
	raddhn	v1.8b, v10.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v24.8b
	uzp1	v24.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v24.8b
	ushll	v6.8h, v1.8b, #7
	shl	v6.8h, v6.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v7.8h, v0.8b, #7
	shl	v7.8h, v7.8h, #1
	sri	v1.8h, v6.8h, #5
	sri	v1.8h, v7.8h, #11
	st1	{ v1.4h }, [x0], #8
	subs	x8, x8, #4
	b.ge	L_26
L_25
L_24
	tst	x8, #0x2
	b.eq	L_27
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #1
	asr	w11, w6, #16
	add	w6, w6, w7
	add	x11, x2, x11, lsl #1
	ld1	{ v11.s }[0], [x10], x15
	ld1	{ v11.s }[2], [x11], x15
	ld1	{ v11.s }[1], [x10]
	ld1	{ v11.s }[3], [x11]
	shrn	v20.8b, v11.8h, #8
	shrn	v19.8b, v11.8h, #3
	sli	v11.8h, v11.8h, #5
	sri	v20.8b, v20.8b, #5
	sri	v19.8b, v19.8b, #6
	shrn	v18.8b, v11.8h, #2
	zip1	v24.8b, v18.8b, v20.8b
	zip2	v20.8b, v18.8b, v20.8b
	mov	v18.8b, v24.8b
	zip1	v24.8b, v19.8b, v21.8b
	zip2	v21.8b, v19.8b, v21.8b
	mov	v19.8b, v24.8b
	zip1	v24.8b, v20.8b, v21.8b
	zip2	v21.8b, v20.8b, v21.8b
	mov	v20.8b, v24.8b
	zip1	v24.8b, v18.8b, v19.8b
	zip2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v4.h }[0], [x1], #2
	prfum	pldl1keep, [x1, #28]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	dup	v4.4h, v4.h[0]
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v24.8b
	uzp1	v24.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v24.8b
	ushll	v16.8h, v1.8b, #7
	shl	v16.8h, v16.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v17.8h, v0.8b, #7
	shl	v17.8h, v17.8h, #1
	sri	v1.8h, v16.8h, #5
	sri	v1.8h, v17.8h, #11
	st1	{ v1.s }[0], [x0], #4
L_27
	tst	x8, #0x1
	b.eq	L_21
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #1
	ld1	{ v1.s }[0], [x10], x15
	ld1	{ v1.s }[1], [x10]
	shl	v0.4h, v1.4h, #5
	shl	v2.4h, v1.4h, #11
	sri	v1.4h, v1.4h, #5
	sri	v0.4h, v0.4h, #6
	sri	v2.4h, v2.4h, #5
	ushr	v1.4h, v1.4h, #8
	sri	v0.4h, v2.4h, #8
	zip1	v2.4h, v0.4h, v1.4h
	zip2	v1.4h, v0.4h, v1.4h
	mov	v0.d[0], v2.d[0]
	ld1	{ v4.b }[0], [x1], #1
	prfum	pldl1keep, [x1, #28]
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	dup	v4.8b, v4.b[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v24.8b
	uzp1	v24.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v24.8b
	ushll	v17.8h, v1.8b, #7
	shl	v17.8h, v17.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v18.8h, v0.8b, #7
	shl	v18.8h, v18.8h, #1
	sri	v1.8h, v17.8h, #5
	sri	v1.8h, v18.8h, #11
	st1	{ v1.h }[0], [x0], #2
L_21
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x10, x11, [x29, #-80]
	ldp	x12, x13, [x29, #-96]
	ldp	x14, x15, [x29, #-112]
	ldur	x8, [x29, #-120]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_scaled_bilinear_scanline_8888_8888_OVER_asm_neon
pixman_scaled_bilinear_scanline_8888_8888_OVER_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #112
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x10, x11, [x29, #-80]
	stp	x12, x13, [x29, #-96]
	stp	x14, x15, [x29, #-112]
	mov	w10, #28
	umull	x12, w10, w6
	sub	x15, x2, x1
	cmp	x7, #0
	b.le	L_28
	dup	v12.8h, w5
	dup	v13.8h, w6
	dup	v28.8b, w3
	dup	v29.8b, w4
	mov	v25.d[0], v12.d[1]
	mov	v26.d[0], v13.d[0]
	add	v25.4h, v25.4h, v26.4h
	mov	v12.d[1], v25.d[0]
	cmp	x7, #1
	b.lt	L_29
	tst	x0, #0x4
	b.eq	L_29
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	asr	w10, w5, #16
	add	w5, w5, w6
	add	x10, x1, x10, lsl #2
	ld1	{ v0.2s }, [x10], x15
	ld1	{ v1.2s }, [x10]
	ld1	{ v18.s }[0], [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	dup	v5.2s, v1.s[1]
	mvn	v5.8b, v5.8b
	umull	v3.8h, v18.8b, v5.8b
	umull	v8.8h, v19.8b, v5.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v18.8b, v10.8h, v3.8h
	raddhn	v19.8b, v11.8h, v8.8h
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.s }[0], [x0], #4
	sub	x7, x7, #1
L_29
	add	v13.8h, v13.8h, v13.8h
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	cmp	x7, #2
	b.lt	L_30
	tst	x0, #0x8
	b.eq	L_30
	asr	w10, w5, #16
	add	w5, w5, w6
	add	x10, x1, x10, lsl #2
	ld1	{ v18.2s }, [x10], x15
	ld1	{ v19.2s }, [x10]
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	asr	w10, w5, #16
	add	w5, w5, w6
	add	x10, x1, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v18.2s }, [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	dup	v5.2s, v1.s[1]
	mvn	v5.8b, v5.8b
	umull	v3.8h, v18.8b, v5.8b
	umull	v8.8h, v19.8b, v5.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v18.8b, v10.8h, v3.8h
	raddhn	v19.8b, v11.8h, v8.8h
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s }, [x0], #8
	sub	x7, x7, #2
L_30
	subs	x7, x7, #4
	b.lt	L_31
	asr	x12, x12, #14
	asr	w10, w5, #16
	add	w5, w5, w6
	add	x10, x1, x10, lsl #2
	asr	w11, w5, #16
	add	w5, w5, w6
	add	x11, x1, x11, lsl #2
	ld1	{ v22.2s }, [x10], x15
	ld1	{ v23.2s }, [x10]
	asr	w13, w5, #16
	add	w5, w5, w6
	add	x13, x1, x13, lsl #2
	umull	v8.8h, v22.8b, v28.8b
	umlal	v8.8h, v23.8b, v29.8b
	ld1	{ v22.2s }, [x11], x15
	ld1	{ v23.2s }, [x11]
	asr	w14, w5, #16
	add	w5, w5, w6
	add	x14, x1, x14, lsl #2
	umull	v9.8h, v22.8b, v28.8b
	umlal	v9.8h, v23.8b, v29.8b
	ld1	{ v22.2s }, [x13], x15
	ld1	{ v23.2s }, [x13]
	umull	v10.8h, v22.8b, v28.8b
	umlal	v10.8h, v23.8b, v29.8b
	ushll	v0.4s, v8.4h, #7
	umlsl	v0.4s, v8.4h, v15.h[0]
	umlal2	v0.4s, v8.8h, v15.h[0]
	prfm	pldl1keep, [x14, x12]
	ld1	{ v16.2s }, [x14], x15
	ld1	{ v17.2s }, [x14]
	prfm	pldl1keep, [x14, x12]
	umull	v11.8h, v16.8b, v28.8b
	umlal	v11.8h, v17.8b, v29.8b
	ushll	v1.4s, v9.4h, #7
	umlsl	v1.4s, v9.4h, v15.h[4]
	umlal2	v1.4s, v9.8h, v15.h[4]
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	subs	x7, x7, #4
	b.lt	L_32
L_33
	ushll	v2.4s, v10.4h, #7
	asr	w10, w5, #16
	add	w5, w5, w6
	add	x10, x1, x10, lsl #2
	umlsl	v2.4s, v10.4h, v15.h[0]
	asr	w11, w5, #16
	add	w5, w5, w6
	add	x11, x1, x11, lsl #2
	umlal2	v2.4s, v10.8h, v15.h[0]
	ushll	v3.4s, v11.4h, #7
	ld1	{ v20.2s }, [x10], x15
	umlsl	v3.4s, v11.4h, v15.h[4]
	umlal2	v3.4s, v11.8h, v15.h[4]
	ld1	{ v21.2s }, [x10]
	umull	v8.8h, v20.8b, v28.8b
	umlal	v8.8h, v21.8b, v29.8b
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v1.4s, #14
	shrn	v2.4h, v2.4s, #14
	ushr	v15.8h, v12.8h, #9
	ld1	{ v22.2s }, [x11], x15
	shrn2	v2.8h, v3.4s, #14
	xtn	v6.8b, v0.8h
	ld1	{ v23.2s }, [x11]
	umull	v9.8h, v22.8b, v28.8b
	asr	w13, w5, #16
	add	w5, w5, w6
	add	x13, x1, x13, lsl #2
	asr	w14, w5, #16
	add	w5, w5, w6
	add	x14, x1, x14, lsl #2
	umlal	v9.8h, v23.8b, v29.8b
	xtn	v7.8b, v2.8h
	ld1	{ v2.2s, v3.2s }, [x0]
	prfm	pldl1keep, [x0, x12]
	ld1	{ v22.2s }, [x13], x15
	uzp1	v24.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	dup	v4.2s, v7.s[1]
	ld1	{ v23.2s }, [x13]
	mvn	v4.8b, v4.8b
	umull	v10.8h, v22.8b, v28.8b
	umlal	v10.8h, v23.8b, v29.8b
	umull	v11.8h, v2.8b, v4.8b
	umull	v2.8h, v3.8b, v4.8b
	ushll	v0.4s, v8.4h, #7
	umlsl	v0.4s, v8.4h, v15.h[0]
	urshr	v1.8h, v11.8h, #8
	umlal2	v0.4s, v8.8h, v15.h[0]
	urshr	v8.8h, v2.8h, #8
	raddhn	v3.8b, v8.8h, v2.8h
	raddhn	v2.8b, v1.8h, v11.8h
	prfm	pldl1keep, [x14, x12]
	ld1	{ v16.2s }, [x14], x15
	uqadd	v6.8b, v2.8b, v6.8b
	uqadd	v7.8b, v3.8b, v7.8b
	ld1	{ v17.2s }, [x14]
	prfm	pldl1keep, [x14, x12]
	umull	v11.8h, v16.8b, v28.8b
	umlal	v11.8h, v17.8b, v29.8b
	uzp1	v24.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v24.8b
	ushll	v1.4s, v9.4h, #7
	uzp1	v24.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v24.8b
	umlsl	v1.4s, v9.4h, v15.h[4]
	add	v12.8h, v12.8h, v13.8h
	umlal2	v1.4s, v9.8h, v15.h[4]
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	st1	{ v6.2s, v7.2s }, [x0], #16
	subs	x7, x7, #4
	b.ge	L_33
L_32
	ushll	v2.4s, v10.4h, #7
	umlsl	v2.4s, v10.4h, v15.h[0]
	umlal2	v2.4s, v10.8h, v15.h[0]
	ushll	v3.4s, v11.4h, #7
	umlsl	v3.4s, v11.4h, v15.h[4]
	umlal2	v3.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v1.4s, #14
	shrn	v2.4h, v2.4s, #14
	ushr	v15.8h, v12.8h, #9
	shrn2	v2.8h, v3.4s, #14
	xtn	v6.8b, v0.8h
	xtn	v7.8b, v2.8h
	ld1	{ v2.2s, v3.2s }, [x0]
	prfm	pldl1keep, [x0, #112]
	uzp1	v24.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	dup	v4.2s, v7.s[1]
	mvn	v4.8b, v4.8b
	umull	v11.8h, v2.8b, v4.8b
	umull	v2.8h, v3.8b, v4.8b
	urshr	v1.8h, v11.8h, #8
	urshr	v10.8h, v2.8h, #8
	raddhn	v3.8b, v10.8h, v2.8h
	raddhn	v2.8b, v1.8h, v11.8h
	uqadd	v6.8b, v2.8b, v6.8b
	uqadd	v7.8b, v3.8b, v7.8b
	uzp1	v24.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v24.8b
	uzp1	v24.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v24.8b
	add	v12.8h, v12.8h, v13.8h
	st1	{ v6.2s, v7.2s }, [x0], #16
L_31
	tst	x7, #0x2
	b.eq	L_34
	asr	w10, w5, #16
	add	w5, w5, w6
	add	x10, x1, x10, lsl #2
	ld1	{ v18.2s }, [x10], x15
	ld1	{ v19.2s }, [x10]
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	asr	w10, w5, #16
	add	w5, w5, w6
	add	x10, x1, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v18.2s }, [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	dup	v5.2s, v1.s[1]
	mvn	v5.8b, v5.8b
	umull	v3.8h, v18.8b, v5.8b
	umull	v8.8h, v19.8b, v5.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v18.8b, v10.8h, v3.8h
	raddhn	v19.8b, v11.8h, v8.8h
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s }, [x0], #8
L_34
	tst	x7, #0x1
	b.eq	L_28
	asr	w10, w5, #16
	add	w5, w5, w6
	add	x10, x1, x10, lsl #2
	ld1	{ v0.2s }, [x10], x15
	ld1	{ v1.2s }, [x10]
	ld1	{ v18.s }[0], [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	dup	v5.2s, v1.s[1]
	mvn	v5.8b, v5.8b
	umull	v3.8h, v18.8b, v5.8b
	umull	v8.8h, v19.8b, v5.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v18.8b, v10.8h, v3.8h
	raddhn	v19.8b, v11.8h, v8.8h
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.s }[0], [x0], #4
L_28
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x10, x11, [x29, #-80]
	ldp	x12, x13, [x29, #-96]
	ldp	x14, x15, [x29, #-112]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_scaled_bilinear_scanline_8888_8_8888_OVER_asm_neon
pixman_scaled_bilinear_scanline_8888_8_8888_OVER_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x10, x11, [x29, #-80]
	stp	x12, x13, [x29, #-96]
	stp	x14, x15, [x29, #-112]
	stur	x8, [x29, #-120]
	ldr	w8, [x29, #16]
	sub	sp, sp, #120
	mov	w10, #28
	umull	x12, w10, w7
	sub	x15, x3, x2
	cmp	x8, #0
	b.le	L_35
	dup	v12.8h, w6
	dup	v13.8h, w7
	dup	v28.8b, w4
	dup	v29.8b, w5
	mov	v25.d[0], v12.d[1]
	mov	v26.d[0], v13.d[0]
	add	v25.4h, v25.4h, v26.4h
	mov	v12.d[1], v25.d[0]
	cmp	x8, #1
	b.lt	L_36
	tst	x0, #0x4
	b.eq	L_36
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v0.2s }, [x10], x15
	ld1	{ v1.2s }, [x10]
	ld1	{ v4.b }[0], [x1], #1
	prfum	pldl1keep, [x1, #28]
	ld1	{ v18.s }[0], [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	dup	v4.8b, v4.b[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	dup	v5.2s, v1.s[1]
	mvn	v5.8b, v5.8b
	umull	v3.8h, v18.8b, v5.8b
	umull	v8.8h, v19.8b, v5.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v18.8b, v10.8h, v3.8h
	raddhn	v19.8b, v11.8h, v8.8h
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.s }[0], [x0], #4
	sub	x8, x8, #1
L_36
	add	v13.8h, v13.8h, v13.8h
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	cmp	x8, #2
	b.lt	L_37
	tst	x0, #0x8
	b.eq	L_37
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v18.2s }, [x10], x15
	ld1	{ v19.2s }, [x10]
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v4.h }[0], [x1], #2
	prfum	pldl1keep, [x1, #28]
	ld1	{ v18.2s }, [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	dup	v4.4h, v4.h[0]
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	dup	v5.2s, v1.s[1]
	mvn	v5.8b, v5.8b
	umull	v3.8h, v18.8b, v5.8b
	umull	v8.8h, v19.8b, v5.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v18.8b, v10.8h, v3.8h
	raddhn	v19.8b, v11.8h, v8.8h
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s }, [x0], #8
	sub	x8, x8, #2
L_37
	subs	x8, x8, #4
	b.lt	L_38
	asr	x12, x12, #14
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v18.2s }, [x10], x15
	ld1	{ v19.2s }, [x10]
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v4.h }[0], [x1], #2
	prfum	pldl1keep, [x1, #28]
	ld1	{ v18.2s }, [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	dup	v4.4h, v4.h[0]
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	dup	v5.2s, v1.s[1]
	mvn	v5.8b, v5.8b
	umull	v3.8h, v18.8b, v5.8b
	umull	v8.8h, v19.8b, v5.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v18.8b, v10.8h, v3.8h
	raddhn	v19.8b, v11.8h, v8.8h
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s }, [x0], #8
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v18.2s }, [x10], x15
	ld1	{ v19.2s }, [x10]
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v4.h }[0], [x1], #2
	prfum	pldl1keep, [x1, #28]
	ld1	{ v18.2s }, [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	dup	v4.4h, v4.h[0]
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	dup	v5.2s, v1.s[1]
	mvn	v5.8b, v5.8b
	umull	v3.8h, v18.8b, v5.8b
	umull	v8.8h, v19.8b, v5.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v18.8b, v10.8h, v3.8h
	raddhn	v19.8b, v11.8h, v8.8h
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s }, [x0], #8
	subs	x8, x8, #4
	b.lt	L_39
L_40
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v18.2s }, [x10], x15
	ld1	{ v19.2s }, [x10]
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v4.h }[0], [x1], #2
	prfum	pldl1keep, [x1, #28]
	ld1	{ v18.2s }, [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	dup	v4.4h, v4.h[0]
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	dup	v5.2s, v1.s[1]
	mvn	v5.8b, v5.8b
	umull	v3.8h, v18.8b, v5.8b
	umull	v8.8h, v19.8b, v5.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v18.8b, v10.8h, v3.8h
	raddhn	v19.8b, v11.8h, v8.8h
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s }, [x0], #8
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v18.2s }, [x10], x15
	ld1	{ v19.2s }, [x10]
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v4.h }[0], [x1], #2
	prfum	pldl1keep, [x1, #28]
	ld1	{ v18.2s }, [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	dup	v4.4h, v4.h[0]
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	dup	v5.2s, v1.s[1]
	mvn	v5.8b, v5.8b
	umull	v3.8h, v18.8b, v5.8b
	umull	v8.8h, v19.8b, v5.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v18.8b, v10.8h, v3.8h
	raddhn	v19.8b, v11.8h, v8.8h
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s }, [x0], #8
	subs	x8, x8, #4
	b.ge	L_40
L_39
L_38
	tst	x8, #0x2
	b.eq	L_41
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v18.2s }, [x10], x15
	ld1	{ v19.2s }, [x10]
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v4.h }[0], [x1], #2
	prfum	pldl1keep, [x1, #28]
	ld1	{ v18.2s }, [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	dup	v4.4h, v4.h[0]
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	dup	v5.2s, v1.s[1]
	mvn	v5.8b, v5.8b
	umull	v3.8h, v18.8b, v5.8b
	umull	v8.8h, v19.8b, v5.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v18.8b, v10.8h, v3.8h
	raddhn	v19.8b, v11.8h, v8.8h
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s }, [x0], #8
L_41
	tst	x8, #0x1
	b.eq	L_35
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v0.2s }, [x10], x15
	ld1	{ v1.2s }, [x10]
	ld1	{ v4.b }[0], [x1], #1
	prfum	pldl1keep, [x1, #28]
	ld1	{ v18.s }[0], [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	dup	v4.8b, v4.b[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	dup	v5.2s, v1.s[1]
	mvn	v5.8b, v5.8b
	umull	v3.8h, v18.8b, v5.8b
	umull	v8.8h, v19.8b, v5.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v18.8b, v10.8h, v3.8h
	raddhn	v19.8b, v11.8h, v8.8h
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.s }[0], [x0], #4
L_35
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x10, x11, [x29, #-80]
	ldp	x12, x13, [x29, #-96]
	ldp	x14, x15, [x29, #-112]
	ldur	x8, [x29, #-120]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_scaled_bilinear_scanline_8888_8888_ADD_asm_neon
pixman_scaled_bilinear_scanline_8888_8888_ADD_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #112
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x10, x11, [x29, #-80]
	stp	x12, x13, [x29, #-96]
	stp	x14, x15, [x29, #-112]
	mov	w10, #28
	umull	x12, w10, w6
	sub	x15, x2, x1
	cmp	x7, #0
	b.le	L_42
	dup	v12.8h, w5
	dup	v13.8h, w6
	dup	v28.8b, w3
	dup	v29.8b, w4
	mov	v25.d[0], v12.d[1]
	mov	v26.d[0], v13.d[0]
	add	v25.4h, v25.4h, v26.4h
	mov	v12.d[1], v25.d[0]
	cmp	x7, #1
	b.lt	L_43
	tst	x0, #0x4
	b.eq	L_43
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	asr	w10, w5, #16
	add	w5, w5, w6
	add	x10, x1, x10, lsl #2
	ld1	{ v0.2s }, [x10], x15
	ld1	{ v1.2s }, [x10]
	ld1	{ v18.s }[0], [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.s }[0], [x0], #4
	sub	x7, x7, #1
L_43
	add	v13.8h, v13.8h, v13.8h
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	cmp	x7, #2
	b.lt	L_44
	tst	x0, #0x8
	b.eq	L_44
	asr	w10, w5, #16
	add	w5, w5, w6
	add	x10, x1, x10, lsl #2
	ld1	{ v18.2s }, [x10], x15
	ld1	{ v19.2s }, [x10]
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	asr	w10, w5, #16
	add	w5, w5, w6
	add	x10, x1, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v18.2s }, [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s }, [x0], #8
	sub	x7, x7, #2
L_44
	subs	x7, x7, #4
	b.lt	L_45
	asr	x12, x12, #14
	asr	w10, w5, #16
	add	w5, w5, w6
	add	x10, x1, x10, lsl #2
	ld1	{ v18.2s }, [x10], x15
	ld1	{ v19.2s }, [x10]
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	asr	w10, w5, #16
	add	w5, w5, w6
	add	x10, x1, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v18.2s }, [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s }, [x0], #8
	asr	w10, w5, #16
	add	w5, w5, w6
	add	x10, x1, x10, lsl #2
	ld1	{ v18.2s }, [x10], x15
	ld1	{ v19.2s }, [x10]
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	asr	w10, w5, #16
	add	w5, w5, w6
	add	x10, x1, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v18.2s }, [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s }, [x0], #8
	subs	x7, x7, #4
	b.lt	L_46
L_47
	asr	w10, w5, #16
	add	w5, w5, w6
	add	x10, x1, x10, lsl #2
	ld1	{ v18.2s }, [x10], x15
	ld1	{ v19.2s }, [x10]
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	asr	w10, w5, #16
	add	w5, w5, w6
	add	x10, x1, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v18.2s }, [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s }, [x0], #8
	asr	w10, w5, #16
	add	w5, w5, w6
	add	x10, x1, x10, lsl #2
	ld1	{ v18.2s }, [x10], x15
	ld1	{ v19.2s }, [x10]
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	asr	w10, w5, #16
	add	w5, w5, w6
	add	x10, x1, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v18.2s }, [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s }, [x0], #8
	subs	x7, x7, #4
	b.ge	L_47
L_46
L_45
	tst	x7, #0x2
	b.eq	L_48
	asr	w10, w5, #16
	add	w5, w5, w6
	add	x10, x1, x10, lsl #2
	ld1	{ v18.2s }, [x10], x15
	ld1	{ v19.2s }, [x10]
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	asr	w10, w5, #16
	add	w5, w5, w6
	add	x10, x1, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v18.2s }, [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s }, [x0], #8
L_48
	tst	x7, #0x1
	b.eq	L_42
	asr	w10, w5, #16
	add	w5, w5, w6
	add	x10, x1, x10, lsl #2
	ld1	{ v0.2s }, [x10], x15
	ld1	{ v1.2s }, [x10]
	ld1	{ v18.s }[0], [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.s }[0], [x0], #4
L_42
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x10, x11, [x29, #-80]
	ldp	x12, x13, [x29, #-96]
	ldp	x14, x15, [x29, #-112]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_scaled_bilinear_scanline_8888_8_8888_ADD_asm_neon
pixman_scaled_bilinear_scanline_8888_8_8888_ADD_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x10, x11, [x29, #-80]
	stp	x12, x13, [x29, #-96]
	stp	x14, x15, [x29, #-112]
	stur	x8, [x29, #-120]
	ldr	w8, [x29, #16]
	sub	sp, sp, #120
	mov	w10, #28
	umull	x12, w10, w7
	sub	x15, x3, x2
	cmp	x8, #0
	b.le	L_49
	dup	v12.8h, w6
	dup	v13.8h, w7
	dup	v28.8b, w4
	dup	v29.8b, w5
	mov	v25.d[0], v12.d[1]
	mov	v26.d[0], v13.d[0]
	add	v25.4h, v25.4h, v26.4h
	mov	v12.d[1], v25.d[0]
	cmp	x8, #1
	b.lt	L_50
	tst	x0, #0x4
	b.eq	L_50
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v0.2s }, [x10], x15
	ld1	{ v1.2s }, [x10]
	ld1	{ v4.b }[0], [x1], #1
	prfum	pldl1keep, [x1, #28]
	ld1	{ v18.s }[0], [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	dup	v4.8b, v4.b[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.s }[0], [x0], #4
	sub	x8, x8, #1
L_50
	add	v13.8h, v13.8h, v13.8h
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	cmp	x8, #2
	b.lt	L_51
	tst	x0, #0x8
	b.eq	L_51
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v18.2s }, [x10], x15
	ld1	{ v19.2s }, [x10]
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v4.h }[0], [x1], #2
	prfum	pldl1keep, [x1, #28]
	ld1	{ v18.2s }, [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	dup	v4.4h, v4.h[0]
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s }, [x0], #8
	sub	x8, x8, #2
L_51
	subs	x8, x8, #4
	b.lt	L_52
	asr	x12, x12, #14
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v4.2s }, [x10], x15
	ld1	{ v5.2s }, [x10]
	umull	v1.8h, v4.8b, v28.8b
	umlal	v1.8h, v5.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v6.2s }, [x10], x15
	ld1	{ v7.2s }, [x10]
	umull	v11.8h, v6.8b, v28.8b
	umlal	v11.8h, v7.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v16.2s }, [x10], x15
	ld1	{ v17.2s }, [x10]
	umull	v3.8h, v16.8b, v28.8b
	umlal	v3.8h, v17.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v9.8h, v20.8b, v28.8b
	umlal	v9.8h, v21.8b, v29.8b
	prfm	pldl1keep, [x10, x12]
	sub	x10, x10, x15
	prfm	pldl1keep, [x10, x12]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	ushr	v15.8h, v12.8h, #9
	ushll	v2.4s, v3.4h, #7
	umlsl	v2.4s, v3.4h, v15.h[0]
	umlal2	v2.4s, v3.8h, v15.h[0]
	ushll	v8.4s, v9.4h, #7
	umlsl	v8.4s, v9.4h, v15.h[4]
	umlal2	v8.4s, v9.8h, v15.h[4]
	add	v12.8h, v12.8h, v13.8h
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	shrn	v2.4h, v2.4s, #14
	shrn2	v2.8h, v8.4s, #14
	ld1	{ v4.s }[0], [x1], #4
	prfum	pldl1keep, [x1, #28]
	dup	v4.2s, v4.s[0]
	ushr	v15.8h, v12.8h, #9
	xtn	v0.8b, v0.8h
	xtn	v1.8b, v2.8h
	add	v12.8h, v12.8h, v13.8h
	ld1	{ v2.2s, v3.2s }, [x0]
	mov	v21.d[0], v2.d[0]
	mov	v21.d[1], v3.d[0]
	prfm	pldl1keep, [x0, #112]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v11.d[1], v3.d[0]
	mov	v11.d[0], v2.d[0]
	umull	v6.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v9.8h, v6.8h, #8
	urshr	v10.8h, v8.8h, #8
	raddhn	v0.8b, v9.8h, v6.8h
	raddhn	v1.8b, v10.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uqadd	v0.8b, v2.8b, v0.8b
	uqadd	v1.8b, v3.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s, v1.2s }, [x0], #16
	subs	x8, x8, #4
	b.lt	L_53
L_54
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v4.2s }, [x10], x15
	ld1	{ v5.2s }, [x10]
	umull	v1.8h, v4.8b, v28.8b
	umlal	v1.8h, v5.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v6.2s }, [x10], x15
	ld1	{ v7.2s }, [x10]
	umull	v11.8h, v6.8b, v28.8b
	umlal	v11.8h, v7.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v16.2s }, [x10], x15
	ld1	{ v17.2s }, [x10]
	umull	v3.8h, v16.8b, v28.8b
	umlal	v3.8h, v17.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v9.8h, v20.8b, v28.8b
	umlal	v9.8h, v21.8b, v29.8b
	prfm	pldl1keep, [x10, x12]
	sub	x10, x10, x15
	prfm	pldl1keep, [x10, x12]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	ushr	v15.8h, v12.8h, #9
	ushll	v2.4s, v3.4h, #7
	umlsl	v2.4s, v3.4h, v15.h[0]
	umlal2	v2.4s, v3.8h, v15.h[0]
	ushll	v8.4s, v9.4h, #7
	umlsl	v8.4s, v9.4h, v15.h[4]
	umlal2	v8.4s, v9.8h, v15.h[4]
	add	v12.8h, v12.8h, v13.8h
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	shrn	v2.4h, v2.4s, #14
	shrn2	v2.8h, v8.4s, #14
	ld1	{ v4.s }[0], [x1], #4
	prfum	pldl1keep, [x1, #28]
	dup	v4.2s, v4.s[0]
	ushr	v15.8h, v12.8h, #9
	xtn	v0.8b, v0.8h
	xtn	v1.8b, v2.8h
	add	v12.8h, v12.8h, v13.8h
	ld1	{ v2.2s, v3.2s }, [x0]
	mov	v21.d[0], v2.d[0]
	mov	v21.d[1], v3.d[0]
	prfm	pldl1keep, [x0, #112]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v11.d[1], v3.d[0]
	mov	v11.d[0], v2.d[0]
	umull	v6.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v9.8h, v6.8h, #8
	urshr	v10.8h, v8.8h, #8
	raddhn	v0.8b, v9.8h, v6.8h
	raddhn	v1.8b, v10.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uqadd	v0.8b, v2.8b, v0.8b
	uqadd	v1.8b, v3.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s, v1.2s }, [x0], #16
	subs	x8, x8, #4
	b.ge	L_54
L_53
L_52
	tst	x8, #0x2
	b.eq	L_55
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v18.2s }, [x10], x15
	ld1	{ v19.2s }, [x10]
	umull	v1.8h, v18.8b, v28.8b
	umlal	v1.8h, v19.8b, v29.8b
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v20.2s }, [x10], x15
	ld1	{ v21.2s }, [x10]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
	ld1	{ v4.h }[0], [x1], #2
	prfum	pldl1keep, [x1, #28]
	ld1	{ v18.2s }, [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	ushll	v0.4s, v1.4h, #7
	umlsl	v0.4s, v1.4h, v15.h[0]
	umlal2	v0.4s, v1.8h, v15.h[0]
	ushll	v10.4s, v11.4h, #7
	umlsl	v10.4s, v11.4h, v15.h[4]
	umlal2	v10.4s, v11.8h, v15.h[4]
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	dup	v4.4h, v4.h[0]
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.2s }, [x0], #8
L_55
	tst	x8, #0x1
	b.eq	L_49
	asr	w10, w6, #16
	add	w6, w6, w7
	add	x10, x2, x10, lsl #2
	ld1	{ v0.2s }, [x10], x15
	ld1	{ v1.2s }, [x10]
	ld1	{ v4.b }[0], [x1], #1
	prfum	pldl1keep, [x1, #28]
	ld1	{ v18.s }[0], [x0]
	mov	v9.d[0], v18.d[0]
	mov	v9.d[1], v19.d[0]
	prfm	pldl1keep, [x0, #112]
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	dup	v4.8b, v4.b[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v18.8b, v19.8b
	uzp2	v19.8b, v18.8b, v19.8b
	mov	v18.8b, v24.8b
	mov	v0.d[1], v1.d[0]
	mov	v0.d[0], v0.d[0]
	mov	v9.d[1], v19.d[0]
	mov	v9.d[0], v18.d[0]
	umull	v3.8h, v0.8b, v4.8b
	umull	v8.8h, v1.8b, v4.8b
	urshr	v10.8h, v3.8h, #8
	urshr	v11.8h, v8.8h, #8
	raddhn	v0.8b, v10.8h, v3.8h
	raddhn	v1.8b, v11.8h, v8.8h
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uqadd	v0.8b, v18.8b, v0.8b
	uqadd	v1.8b, v19.8b, v1.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	uzp1	v24.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v24.8b
	mov	v0.d[0], v0.d[0]
	mov	v0.d[1], v1.d[0]
	st1	{ v0.s }[0], [x0], #4
L_49
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x10, x11, [x29, #-80]
	ldp	x12, x13, [x29, #-96]
	ldp	x14, x15, [x29, #-112]
	ldur	x8, [x29, #-120]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret

	END
