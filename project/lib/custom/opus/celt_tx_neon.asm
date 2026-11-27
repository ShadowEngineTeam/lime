; Generated from opus celt/arm/celt_tx_neon.S for armasm64: its macros expanded with llvm-mc

	IMPORT celt_tx_tab_32
	IMPORT celt_tx_tab_53
	IMPORT celt_tx_tab_64
	AREA |.text|, CODE, READONLY, ALIGN=4
	AREA |.rdata|, DATA, READONLY, ALIGN=4
	ALIGN 16
subadd
	DCD 0xbf800000
	DCD 0x3f800000
	DCD 0xbf800000
	DCD 0x3f800000
	AREA |.text|, CODE, READONLY, ALIGN=4
	AREA |.rdata|, DATA, READONLY, ALIGN=4
	ALIGN 16
tab_8pt
	DCD 0x3f3504f3
	DCD 0xbf3504f3
	DCD 0xbf3504f3
	DCD 0x3f3504f3
	AREA |.text|, CODE, READONLY, ALIGN=4
	AREA |.rdata|, DATA, READONLY, ALIGN=4
	ALIGN 16
tab_16pt
	DCD 0xbf6c835e
	DCD 0x3f6c835e
	DCD 0xbec3ef15
	DCD 0x3ec3ef15
	DCD 0x3ec3ef15
	DCD 0x3ec3ef15
	DCD 0x3f6c835e
	DCD 0x3f6c835e
	DCD 0x3f800000
	DCD 0x3f800000
	DCD 0x3f3504f3
	DCD 0x3f3504f3
	AREA |.text|, CODE, READONLY, ALIGN=4
	ALIGN 16
	EXPORT celt_tx_fft4_fwd_float_neon
celt_tx_fft4_fwd_float_neon
	ld1	{ v0.4s, v1.4s }, [x2]
	fadd	v16.4s, v0.4s, v1.4s
	fsub	v0.4s, v0.4s, v1.4s
	rev64	v18.4s, v0.4s
	zip2	v1.2d, v16.2d, v0.2d
	zip1	v17.2d, v16.2d, v0.2d
	mov	v1.d[1], v18.d[1]
	fadd	v0.4s, v17.4s, v1.4s
	fsub	v16.4s, v17.4s, v1.4s
	mov	v1.16b, v16.16b
	mov	v1.s[3], v0.s[3]
	mov	v0.s[3], v16.s[3]
	st1	{ v0.4s, v1.4s }, [x1]
	ret
	ALIGN 16
	EXPORT celt_tx_fft8_ns_float_neon
celt_tx_fft8_ns_float_neon
	ld1	{ v0.4s, v1.4s, v2.4s, v3.4s }, [x2], #64
	adrp	x5, subadd
	add	x5, x5, #PageOffset(subadd)
	ld1	{ v31.4s }, [x5]
	adrp	x5, tab_8pt
	add	x5, x5, #PageOffset(tab_8pt)
	fsub	v17.4s, v1.4s, v3.4s
	fadd	v3.4s, v1.4s, v3.4s
	fsub	v16.4s, v0.4s, v2.4s
	fadd	v2.4s, v0.4s, v2.4s
	ld1	{ v21.4s }, [x5]
	ext	v20.16b, v3.16b, v3.16b, #12
	rev64	v20.4s, v20.4s
	ext	v18.16b, v2.16b, v20.16b, #8
	mov	v2.d[1], v20.d[1]
	fsub	v1.4s, v2.4s, v18.4s
	fadd	v18.4s, v2.4s, v18.4s
	rev64	v22.4s, v31.4s
	dup	v2.2d, v16.d[0]
	dup	v3.2d, v16.d[1]
	rev64	v20.4s, v1.4s
	rev64	v3.4s, v3.4s
	ext	v22.16b, v31.16b, v22.16b, #8
	zip1	v19.2d, v18.2d, v1.2d
	zip2	v18.2d, v18.2d, v20.2d
	fadd	v0.4s, v19.4s, v18.4s
	fsub	v1.4s, v19.4s, v18.4s
	fmul	v17.4s, v17.4s, v21.4s
	fmls	v2.4s, v3.4s, v22.4s
	rev64	v20.4s, v17.4s
	fmla	v17.4s, v20.4s, v31.4s
	rev64	v20.4s, v17.4s
	ext	v20.16b, v20.16b, v20.16b, #8
	fmla	v20.4s, v17.4s, v31.4s
	fadd	v3.4s, v2.4s, v20.4s
	fsub	v2.4s, v2.4s, v20.4s
	zip1	v16.2d, v0.2d, v2.2d
	zip2	v17.2d, v0.2d, v2.2d
	zip1	v18.2d, v1.2d, v3.2d
	zip2	v19.2d, v1.2d, v3.2d
	st1	{ v16.4s, v17.4s, v18.4s, v19.4s }, [x1]
	ret
	ALIGN 16
	EXPORT celt_tx_fft16_ns_float_neon
celt_tx_fft16_ns_float_neon
	ld1	{ v0.4s, v1.4s, v2.4s, v3.4s }, [x2], #64
	ld1	{ v4.4s, v5.4s, v6.4s, v7.4s }, [x2], #64
	adrp	x5, subadd
	add	x5, x5, #PageOffset(subadd)
	ld1	{ v31.4s }, [x5]
	adrp	x5, tab_8pt
	add	x5, x5, #PageOffset(tab_8pt)
	fsub	v17.4s, v1.4s, v3.4s
	fadd	v3.4s, v1.4s, v3.4s
	fsub	v16.4s, v0.4s, v2.4s
	fadd	v2.4s, v0.4s, v2.4s
	ld1	{ v21.4s }, [x5]
	ext	v20.16b, v3.16b, v3.16b, #12
	rev64	v20.4s, v20.4s
	ext	v18.16b, v2.16b, v20.16b, #8
	mov	v2.d[1], v20.d[1]
	fsub	v1.4s, v2.4s, v18.4s
	fadd	v18.4s, v2.4s, v18.4s
	rev64	v22.4s, v31.4s
	dup	v2.2d, v16.d[0]
	dup	v3.2d, v16.d[1]
	rev64	v20.4s, v1.4s
	rev64	v3.4s, v3.4s
	ext	v22.16b, v31.16b, v22.16b, #8
	zip1	v19.2d, v18.2d, v1.2d
	zip2	v18.2d, v18.2d, v20.2d
	fadd	v0.4s, v19.4s, v18.4s
	fsub	v1.4s, v19.4s, v18.4s
	fmul	v17.4s, v17.4s, v21.4s
	fmls	v2.4s, v3.4s, v22.4s
	rev64	v20.4s, v17.4s
	fmla	v17.4s, v20.4s, v31.4s
	rev64	v20.4s, v17.4s
	ext	v20.16b, v20.16b, v20.16b, #8
	fmla	v20.4s, v17.4s, v31.4s
	fadd	v3.4s, v2.4s, v20.4s
	fsub	v2.4s, v2.4s, v20.4s
	fadd	v16.4s, v4.4s, v5.4s
	fadd	v18.4s, v6.4s, v7.4s
	fsub	v4.4s, v4.4s, v5.4s
	fsub	v6.4s, v6.4s, v7.4s
	rev64	v20.4s, v4.4s
	rev64	v21.4s, v6.4s
	zip2	v5.2d, v16.2d, v20.2d
	zip2	v7.2d, v18.2d, v21.2d
	fneg	v19.4s, v20.4s
	fneg	v20.4s, v21.4s
	mov	v5.s[3], v19.s[3]
	mov	v7.s[3], v20.s[3]
	zip1	v17.2d, v16.2d, v4.2d
	zip1	v19.2d, v18.2d, v6.2d
	fsub	v20.4s, v17.4s, v5.4s
	fadd	v21.4s, v17.4s, v5.4s
	fsub	v18.4s, v19.4s, v7.4s
	fadd	v19.4s, v19.4s, v7.4s
	zip1	v4.2d, v21.2d, v20.2d
	zip2	v5.2d, v21.2d, v20.2d
	zip1	v6.2d, v19.2d, v18.2d
	zip2	v7.2d, v19.2d, v18.2d
	adrp	x5, tab_16pt
	add	x5, x5, #PageOffset(tab_16pt)
	rev64	v16.4s, v4.4s
	rev64	v17.4s, v6.4s
	mov	v16.d[0], xzr
	mov	v17.d[0], xzr
	ld1	{ v20.4s, v21.4s, v22.4s }, [x5]
	fmla	v6.4s, v17.4s, v31.4s
	fmls	v4.4s, v16.4s, v31.4s
	fmul	v18.4s, v5.4s, v20.4s
	fmul	v19.4s, v7.4s, v20.4s
	rev64	v7.4s, v7.4s
	rev64	v5.4s, v5.4s
	fmla	v19.4s, v7.4s, v21.4s
	fmls	v18.4s, v5.4s, v21.4s
	fmul	v17.4s, v6.4s, v22.4s
	fmul	v16.4s, v4.4s, v22.4s
	mov	v5.16b, v19.16b
	mov	v6.16b, v17.16b
	fsub	v19.4s, v19.4s, v18.4s
	fsub	v17.4s, v17.4s, v16.4s
	fadd	v18.4s, v18.4s, v5.4s
	rev64	v19.4s, v19.4s
	fadd	v16.4s, v16.4s, v6.4s
	rev64	v17.4s, v17.4s
	fmul	v18.4s, v18.4s, v31.4s
	fmul	v17.4s, v17.4s, v31.4s
	fadd	v7.4s, v3.4s, v19.4s
	fsub	v6.4s, v3.4s, v19.4s
	fsub	v5.4s, v2.4s, v18.4s
	fadd	v4.4s, v2.4s, v18.4s
	fsub	v2.4s, v0.4s, v16.4s
	fadd	v0.4s, v0.4s, v16.4s
	fsub	v3.4s, v1.4s, v17.4s
	fadd	v1.4s, v1.4s, v17.4s
	zip1	v20.2d, v0.2d, v4.2d
	zip2	v21.2d, v0.2d, v4.2d
	zip1	v22.2d, v1.2d, v6.2d
	zip2	v23.2d, v1.2d, v6.2d
	st1	{ v20.4s, v21.4s, v22.4s, v23.4s }, [x1], #64
	zip1	v24.2d, v2.2d, v5.2d
	zip2	v25.2d, v2.2d, v5.2d
	zip1	v26.2d, v3.2d, v7.2d
	zip2	v27.2d, v3.2d, v7.2d
	st1	{ v24.4s, v25.4s, v26.4s, v27.4s }, [x1]
	ret
	AREA |.rdata|, DATA, READONLY, ALIGN=4
	ALIGN 16
tab_15pt
	DCD 0x3f800000
	DCD 0x3f800000
	DCD 0xbf800000
	DCD 0xbf800000
	AREA |.text|, CODE, READONLY, ALIGN=4
	ALIGN 16
	EXPORT celt_tx_fft_pfa_15xM_ns_float_neon
celt_tx_fft_pfa_15xM_ns_float_neon
	stp	x29, x30, [sp, #-128]!
	mov	x29, sp
	stp	x19, x20, [sp, #16]
	stp	x21, x22, [sp, #32]
	stp	x23, x24, [sp, #48]
	stp	x25, x26, [sp, #64]
	stp	x27, x28, [sp, #80]
	stp	d8, d9, [sp, #96]
	str	d10, [sp, #112]
	mov	x25, x0
	mov	x26, x1
	mov	x27, x3
	ldr	w19, [x0]
	ldr	x20, [x0, #24]
	ldr	x23, [x0, #32]
	ldr	w24, [x23]
	ldr	x28, [x23, #8]
	lsl	x3, x24, #3
	adrp	x5, celt_tx_tab_53
	add	x5, x5, #PageOffset(celt_tx_tab_53)
	ld1	{ v28.4s, v29.4s, v30.4s }, [x5]
	adrp	x5, tab_15pt
	add	x5, x5, #PageOffset(tab_15pt)
	ld1	{ v24.4s }, [x5]
	adrp	x5, subadd
	add	x5, x5, #PageOffset(subadd)
	ld1	{ v31.4s }, [x5]
	dup	v8.2d, v30.d[0]
	dup	v9.2d, v30.d[1]
	dup	v10.2d, v29.d[1]
	dup	v25.2d, v28.d[0]
	dup	v28.2d, v28.d[1]
	dup	v29.2d, v29.d[0]
	fmul	v8.4s, v8.4s, v31.4s
	fmul	v9.4s, v9.4s, v31.4s
	fmul	v10.4s, v10.4s, v24.4s
	add	x6, x3, x3, lsl #1
	add	x7, x3, x3, lsl #2
L_0
	ldrh	w10, [x28], #2
	add	x1, x20, x10, lsl #3
	ld1	{ v0.4s }, [x2], #16
	ld1r	{ v1.2d }, [x2], #8
	ld1	{ v2.4s, v3.4s, v4.4s }, [x2], #48
	ld1	{ v5.4s, v6.4s, v7.4s }, [x2], #48
	add	x8, x1, x7
	add	x9, x8, x7
	fsub	v16.4s, v2.4s, v4.4s
	ext	v26.16b, v0.16b, v0.16b, #8
	fsub	v17.4s, v3.4s, v5.4s
	fadd	v27.4s, v0.4s, v26.4s
	fadd	v2.4s, v2.4s, v4.4s
	fsub	v20.4s, v0.4s, v26.4s
	fadd	v3.4s, v3.4s, v5.4s
	rev64	v20.4s, v20.4s
	rev64	v16.4s, v16.4s
	ext	v21.16b, v20.16b, v27.16b, #8
	rev64	v17.4s, v17.4s
	fadd	v0.4s, v1.4s, v27.4s
	fadd	v22.4s, v6.4s, v2.4s
	fmul	v21.4s, v21.4s, v30.4s
	fadd	v23.4s, v7.4s, v3.4s
	fmul	v16.4s, v16.4s, v8.4s
	ext	v26.16b, v21.16b, v21.16b, #8
	fmul	v17.4s, v17.4s, v8.4s
	fmla	v21.4s, v26.4s, v24.4s
	fmla	v6.4s, v2.4s, v9.4s
	fmla	v7.4s, v3.4s, v9.4s
	fmla	v1.4s, v21.4s, v31.4s
	fsub	v4.4s, v6.4s, v16.4s
	fsub	v5.4s, v7.4s, v17.4s
	fadd	v2.4s, v6.4s, v16.4s
	fadd	v3.4s, v7.4s, v17.4s
	ext	v16.16b, v23.16b, v23.16b, #8
	ext	v17.16b, v5.16b, v5.16b, #8
	ext	v20.16b, v3.16b, v3.16b, #8
	fsub	v21.4s, v22.4s, v16.4s
	fadd	v22.4s, v22.4s, v16.4s
	fsub	v26.4s, v4.4s, v17.4s
	fadd	v4.4s, v4.4s, v17.4s
	fsub	v27.4s, v2.4s, v20.4s
	fadd	v2.4s, v2.4s, v20.4s
	ext	v16.16b, v22.16b, v22.16b, #8
	zip1	v17.2d, v4.2d, v2.2d
	zip2	v20.2d, v4.2d, v2.2d
	fadd	v16.4s, v16.4s, v22.4s
	fadd	v17.4s, v17.4s, v20.4s
	fadd	v16.4s, v16.4s, v0.4s
	fadd	v17.4s, v17.4s, v1.4s
	st1	{ v16.d }[0], [x1]
	st1	{ v17.d }[1], [x8]
	st1	{ v17.d }[0], [x9]
	ext	v16.16b, v22.16b, v22.16b, #8
	mov	v6.16b, v0.16b
	ext	v17.16b, v21.16b, v21.16b, #8
	fmul	v7.4s, v21.4s, v29.4s
	fmla	v6.4s, v22.4s, v25.4s
	dup	v18.2d, v1.d[0]
	fmla	v18.4s, v4.4s, v25.4s
	fmls	v6.4s, v16.4s, v28.4s
	ext	v16.16b, v4.16b, v4.16b, #8
	fmla	v7.4s, v17.4s, v10.4s
	ext	v17.16b, v26.16b, v26.16b, #8
	fmls	v18.4s, v16.4s, v28.4s
	fmul	v23.4s, v26.4s, v29.4s
	dup	v19.2d, v1.d[1]
	fmla	v19.4s, v2.4s, v25.4s
	ext	v16.16b, v2.16b, v2.16b, #8
	fmla	v23.4s, v17.4s, v10.4s
	ext	v17.16b, v27.16b, v27.16b, #8
	fmul	v5.4s, v27.4s, v29.4s
	fmls	v19.4s, v16.4s, v28.4s
	fmla	v5.4s, v17.4s, v10.4s
	rev64	v16.4s, v7.4s
	rev64	v17.4s, v23.4s
	rev64	v20.4s, v5.4s
	fmul	v16.4s, v16.4s, v31.4s
	fmul	v17.4s, v17.4s, v31.4s
	fmul	v20.4s, v20.4s, v31.4s
	fsub	v7.4s, v6.4s, v16.4s
	fadd	v6.4s, v6.4s, v16.4s
	fsub	v23.4s, v18.4s, v17.4s
	fadd	v22.4s, v18.4s, v17.4s
	fsub	v5.4s, v19.4s, v20.4s
	fadd	v4.4s, v19.4s, v20.4s
	add	x10, x1, x6, lsl #1
	add	x11, x1, x6
	st1	{ v7.d }[0], [x10]
	st1	{ v7.d }[1], [x11]
	add	x12, x8, x3, lsl #2
	add	x13, x1, x6, lsl #2
	st1	{ v6.d }[0], [x12]
	st1	{ v6.d }[1], [x13]
	add	x10, x1, x3
	add	x11, x9, x6
	st1	{ v23.d }[0], [x10]
	st1	{ v23.d }[1], [x11]
	add	x12, x1, x3, lsl #2
	add	x13, x8, x3, lsl #1
	st1	{ v22.d }[0], [x12]
	st1	{ v22.d }[1], [x13]
	add	x10, x9, x3
	add	x11, x1, x3, lsl #3
	st1	{ v5.d }[0], [x10]
	st1	{ v5.d }[1], [x11]
	add	x12, x9, x3, lsl #2
	add	x13, x1, x3, lsl #1
	st1	{ v4.d }[0], [x12]
	st1	{ v4.d }[1], [x13]
	subs	w19, w19, #15
	b.gt	L_0
	ldr	x28, [x25, #40]
	mov	x21, x20
	mov	w19, #15
L_1
	mov	x0, x23
	mov	x1, x21
	mov	x2, x21
	mov	x3, #8
	blr	x28
	add	x21, x21, x24, lsl #3
	subs	w19, w19, #1
	b.gt	L_1
	ldr	w19, [x25]
	ldr	x22, [x25, #8]
	mov	x10, x26
	lsl	x11, x27, #1
	add	x12, x27, x11
L_2
	ldp	w13, w15, [x22], #8
	lsr	w14, w13, #16
	uxth	w13, w13
	lsr	w16, w15, #16
	uxth	w15, w15
	ldr	d0, [x20, x13, lsl #3]
	ldr	d1, [x20, x14, lsl #3]
	ldr	d2, [x20, x15, lsl #3]
	ldr	d3, [x20, x16, lsl #3]
	str	d0, [x10]
	str	d1, [x10, x27]
	str	d2, [x10, x11]
	str	d3, [x10, x12]
	add	x10, x10, x11, lsl #1
	subs	w19, w19, #4
	b.gt	L_2
	ldp	x19, x20, [sp, #16]
	ldp	x21, x22, [sp, #32]
	ldp	x23, x24, [sp, #48]
	ldp	x25, x26, [sp, #64]
	ldp	x27, x28, [sp, #80]
	ldp	d8, d9, [sp, #96]
	ldr	d10, [sp, #112]
	ldp	x29, x30, [sp], #128
	ret
	ALIGN 16
	EXPORT celt_tx_mdct_inv_float_neon
celt_tx_mdct_inv_float_neon
	stp	x29, x30, [sp, #-48]!
	mov	x29, sp
	stp	x19, x20, [sp, #16]
	stp	x21, x22, [sp, #32]
	mov	x19, x1
	mov	x20, x0
	ldr	w21, [x0]
	ldr	x22, [x0, #16]
	ldr	x4, [x0, #8]
	adrp	x5, subadd
	add	x5, x5, #PageOffset(subadd)
	ld1	{ v31.4s }, [x5]
	sub	x5, x21, #1
	madd	x14, x5, x3, x2
	lsr	w7, w21, #1
	cmp	x3, #4
	b.ne	L_3
	tst	w21, #0x7
	b.eq	L_4
L_3
	mov	x13, x19
L_5
	ldr	w5, [x4], #4
	lsr	w6, w5, #16
	uxth	w5, w5
	madd	x8, x5, x3, x2
	msub	x9, x5, x3, x14
	madd	x10, x6, x3, x2
	msub	x11, x6, x3, x14
	add	x15, x22, x5, lsl #2
	add	x16, x22, x6, lsl #2
	ldr	s0, [x9]
	ld1	{ v0.s }[1], [x8]
	ld1	{ v0.s }[2], [x11]
	ld1	{ v0.s }[3], [x10]
	ldr	d1, [x15]
	ld1	{ v1.d }[1], [x16]
	trn1	v2.4s, v0.4s, v0.4s
	trn2	v3.4s, v0.4s, v0.4s
	rev64	v4.4s, v1.4s
	fmul	v5.4s, v2.4s, v1.4s
	fmul	v6.4s, v3.4s, v4.4s
	fmla	v5.4s, v6.4s, v31.4s
	st1	{ v5.4s }, [x13], #16
	subs	w7, w7, #2
	b.gt	L_5
	b	L_6
L_4
	mov	x15, x22
	add	x4, x4, x21
	sub	x10, x14, #12
	add	x12, x22, x21, lsl #2
	sub	x12, x12, #16
	add	x13, x4, x21
	sub	x13, x13, #4
L_7
	ld2	{ v6.2s, v7.2s }, [x2], #16
	ld2	{ v16.2s, v17.2s }, [x10]
	sub	x10, x10, #16
	rev64	v17.2s, v17.2s
	ld2	{ v1.2s, v2.2s }, [x15], #16
	rev64	v7.2s, v7.2s
	ld2	{ v3.2s, v4.2s }, [x12]
	sub	x12, x12, #16
	fmul	v5.2s, v17.2s, v1.2s
	fmul	v18.2s, v17.2s, v2.2s
	fmul	v19.2s, v7.2s, v3.2s
	fmul	v20.2s, v7.2s, v4.2s
	fmls	v5.2s, v6.2s, v2.2s
	fmla	v18.2s, v6.2s, v1.2s
	fmls	v19.2s, v16.2s, v4.2s
	fmla	v20.2s, v16.2s, v3.2s
	ldr	w16, [x4], #4
	lsr	w17, w16, #16
	uxth	w16, w16
	zip1	v0.2s, v5.2s, v18.2s
	zip2	v1.2s, v5.2s, v18.2s
	str	d0, [x19, w16, uxtw #3]
	str	d1, [x19, w17, uxtw #3]
	ldr	w16, [x13]
	sub	x13, x13, #4
	lsr	w17, w16, #16
	uxth	w16, w16
	zip1	v2.2s, v19.2s, v20.2s
	zip2	v3.2s, v19.2s, v20.2s
	str	d2, [x19, w16, uxtw #3]
	str	d3, [x19, w17, uxtw #3]
	subs	w7, w7, #4
	b.gt	L_7
L_6
	ldr	x5, [x20, #40]
	ldr	x0, [x20, #32]
	mov	x1, x19
	mov	x2, x19
	mov	x3, #8
	blr	x5
	mov	x15, x22
	add	x8, x19, x21, lsl #1
	sub	x9, x8, #16
	add	x10, x15, x21, lsl #1
	sub	x11, x10, #16
	lsr	w7, w21, #2
	lsr	w6, w7, #1
	cbz	w6, L_8
L_9
	ld2	{ v0.2s, v1.2s }, [x8]
	ld2	{ v2.2s, v3.2s }, [x9]
	ld2	{ v4.2s, v5.2s }, [x10], #16
	ld2	{ v6.2s, v7.2s }, [x11]
	sub	x11, x11, #16
	fmul	v16.2s, v1.2s, v5.2s
	fmul	v18.2s, v1.2s, v4.2s
	fmul	v20.2s, v3.2s, v7.2s
	fmul	v22.2s, v3.2s, v6.2s
	fmls	v16.2s, v0.2s, v4.2s
	fmla	v18.2s, v0.2s, v5.2s
	fmls	v20.2s, v2.2s, v6.2s
	fmla	v22.2s, v2.2s, v7.2s
	rev64	v22.2s, v22.2s
	rev64	v18.2s, v18.2s
	zip1	v0.4s, v16.4s, v22.4s
	zip1	v2.4s, v20.4s, v18.4s
	st1	{ v0.4s }, [x8], #16
	st1	{ v2.4s }, [x9]
	sub	x9, x9, #16
	subs	w6, w6, #1
	b.gt	L_9
L_8
	tbz	w7, #0, L_10
	adrp	x5, subadd
	add	x5, x5, #PageOffset(subadd)
	ld1	{ v31.4s }, [x5]
	add	x9, x9, #8
	add	x11, x11, #8
	ldr	d0, [x8]
	ld1	{ v0.d }[1], [x9]
	ldr	d1, [x10]
	ld1	{ v1.d }[1], [x11]
	rev64	v2.4s, v0.4s
	rev64	v3.4s, v1.4s
	trn1	v4.4s, v2.4s, v2.4s
	trn2	v5.4s, v2.4s, v2.4s
	fmul	v6.4s, v4.4s, v3.4s
	fmul	v7.4s, v5.4s, v1.4s
	fmla	v6.4s, v7.4s, v31.4s
	mov	v16.16b, v6.16b
	mov	v16.s[1], v6.s[3]
	mov	v16.s[3], v6.s[1]
	st1	{ v16.d }[0], [x8]
	st1	{ v16.d }[1], [x9]
L_10
	ldp	x19, x20, [sp, #16]
	ldp	x21, x22, [sp, #32]
	ldp	x29, x30, [sp], #48
	ret
	ALIGN 16
	EXPORT celt_tx_fft32_ns_float_neon
celt_tx_fft32_ns_float_neon
	stp	d14, d15, [sp, #-64]!
	stp	d8, d9, [sp, #48]
	stp	d10, d11, [sp, #32]
	stp	d12, d13, [sp, #16]
	adrp	x5, subadd
	add	x5, x5, #PageOffset(subadd)
	ld1	{ v31.4s }, [x5]
	mov	w5, #4
	adrp	x7, celt_tx_tab_32
	add	x7, x7, #PageOffset(celt_tx_tab_32)
	add	x8, x7, x5
	mov	x9, #-32
	ld1	{ v0.4s, v1.4s, v2.4s, v3.4s }, [x2], #64
	ld1	{ v4.4s, v5.4s, v6.4s, v7.4s }, [x2], #64
	ld1	{ v8.4s, v9.4s, v10.4s, v11.4s }, [x2], #64
	ld1	{ v12.4s, v13.4s, v14.4s, v15.4s }, [x2], #64
	adrp	x5, tab_8pt
	add	x5, x5, #PageOffset(tab_8pt)
	fadd	v19.4s, v13.4s, v15.4s
	fadd	v17.4s, v9.4s, v11.4s
	fadd	v18.4s, v12.4s, v14.4s
	fadd	v16.4s, v8.4s, v10.4s
	ld1	{ v23.4s }, [x5]
	ext	v22.16b, v19.16b, v19.16b, #12
	ext	v21.16b, v17.16b, v17.16b, #12
	rev64	v22.4s, v22.4s
	rev64	v21.4s, v21.4s
	ext	v19.16b, v18.16b, v22.16b, #8
	ext	v17.16b, v16.16b, v21.16b, #8
	mov	v18.d[1], v22.d[1]
	mov	v21.d[0], v16.d[0]
	fadd	v22.4s, v18.4s, v19.4s
	fsub	v19.4s, v18.4s, v19.4s
	fsub	v18.4s, v21.4s, v17.4s
	fadd	v16.4s, v21.4s, v17.4s
	fsub	v8.4s, v8.4s, v10.4s
	fsub	v20.4s, v9.4s, v11.4s
	fsub	v12.4s, v12.4s, v14.4s
	fsub	v21.4s, v13.4s, v15.4s
	rev64	v24.4s, v31.4s
	zip1	v17.2d, v16.2d, v18.2d
	zip1	v9.2d, v22.2d, v19.2d
	rev64	v18.4s, v18.4s
	rev64	v19.4s, v19.4s
	zip2	v16.2d, v16.2d, v18.2d
	zip2	v13.2d, v22.2d, v19.2d
	dup	v10.2d, v8.d[0]
	dup	v11.2d, v8.d[1]
	dup	v14.2d, v12.d[0]
	dup	v15.2d, v12.d[1]
	fadd	v12.4s, v9.4s, v13.4s
	fsub	v13.4s, v9.4s, v13.4s
	fadd	v8.4s, v17.4s, v16.4s
	fsub	v9.4s, v17.4s, v16.4s
	ext	v24.16b, v31.16b, v24.16b, #8
	rev64	v11.4s, v11.4s
	rev64	v15.4s, v15.4s
	fmul	v19.4s, v20.4s, v23.4s
	fmul	v21.4s, v21.4s, v23.4s
	rev64	v20.4s, v19.4s
	rev64	v18.4s, v21.4s
	fmls	v10.4s, v11.4s, v24.4s
	fmls	v14.4s, v15.4s, v24.4s
	fmla	v19.4s, v20.4s, v31.4s
	fmla	v21.4s, v18.4s, v31.4s
	rev64	v20.4s, v19.4s
	rev64	v18.4s, v21.4s
	ext	v20.16b, v20.16b, v20.16b, #8
	ext	v18.16b, v18.16b, v18.16b, #8
	fmla	v20.4s, v19.4s, v31.4s
	fmla	v18.4s, v21.4s, v31.4s
	fadd	v11.4s, v10.4s, v20.4s
	fadd	v15.4s, v14.4s, v18.4s
	fsub	v10.4s, v10.4s, v20.4s
	fsub	v14.4s, v14.4s, v18.4s
	adrp	x5, tab_8pt
	add	x5, x5, #PageOffset(tab_8pt)
	fsub	v17.4s, v1.4s, v3.4s
	fadd	v3.4s, v1.4s, v3.4s
	fsub	v16.4s, v0.4s, v2.4s
	fadd	v2.4s, v0.4s, v2.4s
	ld1	{ v21.4s }, [x5]
	ext	v20.16b, v3.16b, v3.16b, #12
	rev64	v20.4s, v20.4s
	ext	v18.16b, v2.16b, v20.16b, #8
	mov	v2.d[1], v20.d[1]
	fsub	v1.4s, v2.4s, v18.4s
	fadd	v18.4s, v2.4s, v18.4s
	rev64	v22.4s, v31.4s
	dup	v2.2d, v16.d[0]
	dup	v3.2d, v16.d[1]
	rev64	v20.4s, v1.4s
	rev64	v3.4s, v3.4s
	ext	v22.16b, v31.16b, v22.16b, #8
	zip1	v19.2d, v18.2d, v1.2d
	zip2	v18.2d, v18.2d, v20.2d
	fadd	v0.4s, v19.4s, v18.4s
	fsub	v1.4s, v19.4s, v18.4s
	fmul	v17.4s, v17.4s, v21.4s
	fmls	v2.4s, v3.4s, v22.4s
	rev64	v20.4s, v17.4s
	fmla	v17.4s, v20.4s, v31.4s
	rev64	v20.4s, v17.4s
	ext	v20.16b, v20.16b, v20.16b, #8
	fmla	v20.4s, v17.4s, v31.4s
	fadd	v3.4s, v2.4s, v20.4s
	fsub	v2.4s, v2.4s, v20.4s
	fadd	v16.4s, v4.4s, v5.4s
	fadd	v18.4s, v6.4s, v7.4s
	fsub	v4.4s, v4.4s, v5.4s
	fsub	v6.4s, v6.4s, v7.4s
	rev64	v20.4s, v4.4s
	rev64	v21.4s, v6.4s
	zip2	v5.2d, v16.2d, v20.2d
	zip2	v7.2d, v18.2d, v21.2d
	fneg	v19.4s, v20.4s
	fneg	v20.4s, v21.4s
	mov	v5.s[3], v19.s[3]
	mov	v7.s[3], v20.s[3]
	zip1	v17.2d, v16.2d, v4.2d
	zip1	v19.2d, v18.2d, v6.2d
	fsub	v20.4s, v17.4s, v5.4s
	fadd	v21.4s, v17.4s, v5.4s
	fsub	v18.4s, v19.4s, v7.4s
	fadd	v19.4s, v19.4s, v7.4s
	zip1	v4.2d, v21.2d, v20.2d
	zip2	v5.2d, v21.2d, v20.2d
	zip1	v6.2d, v19.2d, v18.2d
	zip2	v7.2d, v19.2d, v18.2d
	adrp	x5, tab_16pt
	add	x5, x5, #PageOffset(tab_16pt)
	rev64	v16.4s, v4.4s
	rev64	v17.4s, v6.4s
	mov	v16.d[0], xzr
	mov	v17.d[0], xzr
	ld1	{ v20.4s, v21.4s, v22.4s }, [x5]
	fmla	v6.4s, v17.4s, v31.4s
	fmls	v4.4s, v16.4s, v31.4s
	fmul	v18.4s, v5.4s, v20.4s
	fmul	v19.4s, v7.4s, v20.4s
	rev64	v7.4s, v7.4s
	rev64	v5.4s, v5.4s
	fmla	v19.4s, v7.4s, v21.4s
	fmls	v18.4s, v5.4s, v21.4s
	fmul	v17.4s, v6.4s, v22.4s
	fmul	v16.4s, v4.4s, v22.4s
	mov	v5.16b, v19.16b
	mov	v6.16b, v17.16b
	fsub	v19.4s, v19.4s, v18.4s
	fsub	v17.4s, v17.4s, v16.4s
	fadd	v18.4s, v18.4s, v5.4s
	rev64	v19.4s, v19.4s
	fadd	v16.4s, v16.4s, v6.4s
	rev64	v17.4s, v17.4s
	fmul	v18.4s, v18.4s, v31.4s
	fmul	v17.4s, v17.4s, v31.4s
	fadd	v7.4s, v3.4s, v19.4s
	fsub	v6.4s, v3.4s, v19.4s
	fsub	v5.4s, v2.4s, v18.4s
	fadd	v4.4s, v2.4s, v18.4s
	fsub	v2.4s, v0.4s, v16.4s
	fadd	v0.4s, v0.4s, v16.4s
	fsub	v3.4s, v1.4s, v17.4s
	fadd	v1.4s, v1.4s, v17.4s
	ld1	{ v24.4s, v25.4s }, [x8], x9
	ld1	{ v16.4s, v17.4s }, [x7], #32
	ext	v18.16b, v24.16b, v24.16b, #8
	ext	v19.16b, v25.16b, v25.16b, #8
	trn1	v20.4s, v16.4s, v16.4s
	trn2	v16.4s, v16.4s, v16.4s
	trn1	v21.4s, v17.4s, v17.4s
	trn2	v17.4s, v17.4s, v17.4s
	rev64	v22.4s, v8.4s
	rev64	v23.4s, v10.4s
	rev64	v24.4s, v12.4s
	rev64	v25.4s, v14.4s
	fmul	v22.4s, v22.4s, v20.4s
	fmul	v23.4s, v23.4s, v16.4s
	fmul	v24.4s, v24.4s, v20.4s
	fmul	v25.4s, v25.4s, v16.4s
	rev64	v26.4s, v9.4s
	rev64	v27.4s, v11.4s
	rev64	v20.4s, v13.4s
	rev64	v16.4s, v15.4s
	fmul	v26.4s, v26.4s, v21.4s
	fmul	v27.4s, v27.4s, v17.4s
	fmul	v20.4s, v20.4s, v21.4s
	fmul	v16.4s, v16.4s, v17.4s
	trn1	v21.4s, v19.4s, v19.4s
	trn2	v19.4s, v19.4s, v19.4s
	trn1	v17.4s, v18.4s, v18.4s
	trn2	v18.4s, v18.4s, v18.4s
	fmul	v21.4s, v21.4s, v31.4s
	fmul	v19.4s, v19.4s, v31.4s
	fmul	v17.4s, v17.4s, v31.4s
	fmul	v18.4s, v18.4s, v31.4s
	fmla	v23.4s, v10.4s, v21.4s
	fmls	v25.4s, v14.4s, v21.4s
	fmla	v22.4s, v8.4s, v19.4s
	fmls	v24.4s, v12.4s, v19.4s
	fmla	v26.4s, v9.4s, v18.4s
	fmla	v27.4s, v11.4s, v17.4s
	fmls	v20.4s, v13.4s, v18.4s
	fmls	v16.4s, v15.4s, v17.4s
	fsub	v18.4s, v23.4s, v25.4s
	fsub	v17.4s, v24.4s, v22.4s
	fsub	v19.4s, v20.4s, v26.4s
	fsub	v21.4s, v16.4s, v27.4s
	fadd	v22.4s, v24.4s, v22.4s
	fadd	v23.4s, v25.4s, v23.4s
	fadd	v24.4s, v20.4s, v26.4s
	fadd	v25.4s, v16.4s, v27.4s
	fmul	v17.4s, v17.4s, v31.4s
	fmul	v18.4s, v18.4s, v31.4s
	fmul	v19.4s, v19.4s, v31.4s
	fmul	v21.4s, v21.4s, v31.4s
	rev64	v22.4s, v22.4s
	rev64	v24.4s, v24.4s
	rev64	v23.4s, v23.4s
	rev64	v25.4s, v25.4s
	fsub	v8.4s, v0.4s, v22.4s
	fsub	v9.4s, v1.4s, v24.4s
	fsub	v10.4s, v2.4s, v17.4s
	fsub	v11.4s, v3.4s, v19.4s
	fsub	v12.4s, v4.4s, v23.4s
	fsub	v13.4s, v6.4s, v25.4s
	fadd	v14.4s, v5.4s, v18.4s
	fsub	v15.4s, v7.4s, v21.4s
	fadd	v0.4s, v0.4s, v22.4s
	fadd	v1.4s, v1.4s, v24.4s
	fadd	v2.4s, v2.4s, v17.4s
	fadd	v3.4s, v3.4s, v19.4s
	fadd	v4.4s, v4.4s, v23.4s
	fsub	v5.4s, v5.4s, v18.4s
	fadd	v6.4s, v6.4s, v25.4s
	fadd	v7.4s, v7.4s, v21.4s
	zip1	v16.2d, v0.2d, v4.2d
	zip2	v17.2d, v0.2d, v4.2d
	zip1	v18.2d, v1.2d, v6.2d
	zip2	v19.2d, v1.2d, v6.2d
	st1	{ v16.4s, v17.4s, v18.4s, v19.4s }, [x1], #64
	zip1	v20.2d, v2.2d, v5.2d
	zip2	v21.2d, v2.2d, v5.2d
	zip1	v22.2d, v3.2d, v7.2d
	zip2	v23.2d, v3.2d, v7.2d
	st1	{ v20.4s, v21.4s, v22.4s, v23.4s }, [x1], #64
	zip1	v24.2d, v8.2d, v12.2d
	zip2	v25.2d, v8.2d, v12.2d
	zip1	v26.2d, v9.2d, v13.2d
	zip2	v27.2d, v9.2d, v13.2d
	st1	{ v24.4s, v25.4s, v26.4s, v27.4s }, [x1], #64
	zip1	v28.2d, v10.2d, v14.2d
	zip2	v29.2d, v10.2d, v14.2d
	zip1	v30.2d, v11.2d, v15.2d
	zip2	v31.2d, v11.2d, v15.2d
	st1	{ v28.4s, v29.4s, v30.4s, v31.4s }, [x1]
	ldp	d12, d13, [sp, #16]
	ldp	d10, d11, [sp, #32]
	ldp	d8, d9, [sp, #48]
	ldp	d14, d15, [sp], #64
	ret
	ALIGN 16
	EXPORT celt_tx_fft_sr_ns_float_neon
celt_tx_fft_sr_ns_float_neon
	stp	x21, x22, [sp, #-96]!
	stp	d8, d9, [sp, #80]
	stp	d10, d11, [sp, #64]
	stp	d12, d13, [sp, #48]
	stp	d14, d15, [sp, #32]
	stp	x19, x20, [sp, #16]
	ldr	w19, [x0]
	mov	w20, w19
	adrp	x5, subadd
	add	x5, x5, #PageOffset(subadd)
	ld1	{ v31.4s }, [x5]
L_11
	mov	w5, #4
	adrp	x7, celt_tx_tab_32
	add	x7, x7, #PageOffset(celt_tx_tab_32)
	add	x8, x7, x5
	mov	x9, #-32
	ld1	{ v0.4s, v1.4s, v2.4s, v3.4s }, [x2], #64
	ldp	q4, q6, [x2]
	ldp	q5, q7, [x2, #32]
	add	x2, x2, #64
	ld1	{ v8.4s, v9.4s, v10.4s, v11.4s }, [x2], #64
	ld1	{ v12.4s, v13.4s, v14.4s, v15.4s }, [x2], #64
	adrp	x5, tab_8pt
	add	x5, x5, #PageOffset(tab_8pt)
	fadd	v19.4s, v13.4s, v15.4s
	fadd	v17.4s, v9.4s, v11.4s
	fadd	v18.4s, v12.4s, v14.4s
	fadd	v16.4s, v8.4s, v10.4s
	ld1	{ v23.4s }, [x5]
	ext	v22.16b, v19.16b, v19.16b, #12
	ext	v21.16b, v17.16b, v17.16b, #12
	rev64	v22.4s, v22.4s
	rev64	v21.4s, v21.4s
	ext	v19.16b, v18.16b, v22.16b, #8
	ext	v17.16b, v16.16b, v21.16b, #8
	mov	v18.d[1], v22.d[1]
	mov	v21.d[0], v16.d[0]
	fadd	v22.4s, v18.4s, v19.4s
	fsub	v19.4s, v18.4s, v19.4s
	fsub	v18.4s, v21.4s, v17.4s
	fadd	v16.4s, v21.4s, v17.4s
	fsub	v8.4s, v8.4s, v10.4s
	fsub	v20.4s, v9.4s, v11.4s
	fsub	v12.4s, v12.4s, v14.4s
	fsub	v21.4s, v13.4s, v15.4s
	rev64	v24.4s, v31.4s
	zip1	v17.2d, v16.2d, v18.2d
	zip1	v9.2d, v22.2d, v19.2d
	rev64	v18.4s, v18.4s
	rev64	v19.4s, v19.4s
	zip2	v16.2d, v16.2d, v18.2d
	zip2	v13.2d, v22.2d, v19.2d
	dup	v10.2d, v8.d[0]
	dup	v11.2d, v8.d[1]
	dup	v14.2d, v12.d[0]
	dup	v15.2d, v12.d[1]
	fadd	v12.4s, v9.4s, v13.4s
	fsub	v13.4s, v9.4s, v13.4s
	fadd	v8.4s, v17.4s, v16.4s
	fsub	v9.4s, v17.4s, v16.4s
	ext	v24.16b, v31.16b, v24.16b, #8
	rev64	v11.4s, v11.4s
	rev64	v15.4s, v15.4s
	fmul	v19.4s, v20.4s, v23.4s
	fmul	v21.4s, v21.4s, v23.4s
	rev64	v20.4s, v19.4s
	rev64	v18.4s, v21.4s
	fmls	v10.4s, v11.4s, v24.4s
	fmls	v14.4s, v15.4s, v24.4s
	fmla	v19.4s, v20.4s, v31.4s
	fmla	v21.4s, v18.4s, v31.4s
	rev64	v20.4s, v19.4s
	rev64	v18.4s, v21.4s
	ext	v20.16b, v20.16b, v20.16b, #8
	ext	v18.16b, v18.16b, v18.16b, #8
	fmla	v20.4s, v19.4s, v31.4s
	fmla	v18.4s, v21.4s, v31.4s
	fadd	v11.4s, v10.4s, v20.4s
	fadd	v15.4s, v14.4s, v18.4s
	fsub	v10.4s, v10.4s, v20.4s
	fsub	v14.4s, v14.4s, v18.4s
	adrp	x5, tab_8pt
	add	x5, x5, #PageOffset(tab_8pt)
	fsub	v17.4s, v1.4s, v3.4s
	fadd	v3.4s, v1.4s, v3.4s
	fsub	v16.4s, v0.4s, v2.4s
	fadd	v2.4s, v0.4s, v2.4s
	ld1	{ v21.4s }, [x5]
	ext	v20.16b, v3.16b, v3.16b, #12
	rev64	v20.4s, v20.4s
	ext	v18.16b, v2.16b, v20.16b, #8
	mov	v2.d[1], v20.d[1]
	fsub	v1.4s, v2.4s, v18.4s
	fadd	v18.4s, v2.4s, v18.4s
	rev64	v22.4s, v31.4s
	dup	v2.2d, v16.d[0]
	dup	v3.2d, v16.d[1]
	rev64	v20.4s, v1.4s
	rev64	v3.4s, v3.4s
	ext	v22.16b, v31.16b, v22.16b, #8
	zip1	v19.2d, v18.2d, v1.2d
	zip2	v18.2d, v18.2d, v20.2d
	fadd	v0.4s, v19.4s, v18.4s
	fsub	v1.4s, v19.4s, v18.4s
	fmul	v17.4s, v17.4s, v21.4s
	fmls	v2.4s, v3.4s, v22.4s
	rev64	v20.4s, v17.4s
	fmla	v17.4s, v20.4s, v31.4s
	rev64	v20.4s, v17.4s
	ext	v20.16b, v20.16b, v20.16b, #8
	fmla	v20.4s, v17.4s, v31.4s
	fadd	v3.4s, v2.4s, v20.4s
	fsub	v2.4s, v2.4s, v20.4s
	fadd	v16.4s, v4.4s, v6.4s
	fadd	v18.4s, v5.4s, v7.4s
	fsub	v4.4s, v4.4s, v6.4s
	fsub	v5.4s, v5.4s, v7.4s
	rev64	v20.4s, v4.4s
	rev64	v21.4s, v5.4s
	zip2	v6.2d, v16.2d, v20.2d
	zip2	v7.2d, v18.2d, v21.2d
	fneg	v19.4s, v20.4s
	fneg	v20.4s, v21.4s
	mov	v6.s[3], v19.s[3]
	mov	v7.s[3], v20.s[3]
	zip1	v17.2d, v16.2d, v4.2d
	zip1	v19.2d, v18.2d, v5.2d
	fsub	v20.4s, v17.4s, v6.4s
	fadd	v21.4s, v17.4s, v6.4s
	fsub	v18.4s, v19.4s, v7.4s
	fadd	v19.4s, v19.4s, v7.4s
	zip1	v4.2d, v21.2d, v20.2d
	zip2	v6.2d, v21.2d, v20.2d
	zip1	v5.2d, v19.2d, v18.2d
	zip2	v7.2d, v19.2d, v18.2d
	adrp	x5, tab_16pt
	add	x5, x5, #PageOffset(tab_16pt)
	rev64	v16.4s, v4.4s
	rev64	v17.4s, v5.4s
	mov	v16.d[0], xzr
	mov	v17.d[0], xzr
	ld1	{ v20.4s, v21.4s, v22.4s }, [x5]
	fmla	v5.4s, v17.4s, v31.4s
	fmls	v4.4s, v16.4s, v31.4s
	fmul	v18.4s, v6.4s, v20.4s
	fmul	v19.4s, v7.4s, v20.4s
	rev64	v7.4s, v7.4s
	rev64	v6.4s, v6.4s
	fmla	v19.4s, v7.4s, v21.4s
	fmls	v18.4s, v6.4s, v21.4s
	fmul	v17.4s, v5.4s, v22.4s
	fmul	v16.4s, v4.4s, v22.4s
	mov	v6.16b, v19.16b
	mov	v5.16b, v17.16b
	fsub	v19.4s, v19.4s, v18.4s
	fsub	v17.4s, v17.4s, v16.4s
	fadd	v18.4s, v18.4s, v6.4s
	rev64	v19.4s, v19.4s
	fadd	v16.4s, v16.4s, v5.4s
	rev64	v17.4s, v17.4s
	fmul	v18.4s, v18.4s, v31.4s
	fmul	v17.4s, v17.4s, v31.4s
	fadd	v7.4s, v3.4s, v19.4s
	fsub	v5.4s, v3.4s, v19.4s
	fsub	v6.4s, v2.4s, v18.4s
	fadd	v4.4s, v2.4s, v18.4s
	fsub	v2.4s, v0.4s, v16.4s
	fadd	v0.4s, v0.4s, v16.4s
	fsub	v3.4s, v1.4s, v17.4s
	fadd	v1.4s, v1.4s, v17.4s
	ld1	{ v24.4s, v25.4s }, [x8], x9
	ld1	{ v16.4s, v17.4s }, [x7], #32
	ext	v18.16b, v24.16b, v24.16b, #8
	ext	v19.16b, v25.16b, v25.16b, #8
	trn1	v20.4s, v16.4s, v16.4s
	trn2	v16.4s, v16.4s, v16.4s
	trn1	v21.4s, v17.4s, v17.4s
	trn2	v17.4s, v17.4s, v17.4s
	rev64	v22.4s, v8.4s
	rev64	v23.4s, v10.4s
	rev64	v24.4s, v12.4s
	rev64	v25.4s, v14.4s
	fmul	v22.4s, v22.4s, v20.4s
	fmul	v23.4s, v23.4s, v16.4s
	fmul	v24.4s, v24.4s, v20.4s
	fmul	v25.4s, v25.4s, v16.4s
	rev64	v26.4s, v9.4s
	rev64	v27.4s, v11.4s
	rev64	v20.4s, v13.4s
	rev64	v16.4s, v15.4s
	fmul	v26.4s, v26.4s, v21.4s
	fmul	v27.4s, v27.4s, v17.4s
	fmul	v20.4s, v20.4s, v21.4s
	fmul	v16.4s, v16.4s, v17.4s
	trn1	v21.4s, v19.4s, v19.4s
	trn2	v19.4s, v19.4s, v19.4s
	trn1	v17.4s, v18.4s, v18.4s
	trn2	v18.4s, v18.4s, v18.4s
	fmul	v21.4s, v21.4s, v31.4s
	fmul	v19.4s, v19.4s, v31.4s
	fmul	v17.4s, v17.4s, v31.4s
	fmul	v18.4s, v18.4s, v31.4s
	fmla	v23.4s, v10.4s, v21.4s
	fmls	v25.4s, v14.4s, v21.4s
	fmla	v22.4s, v8.4s, v19.4s
	fmls	v24.4s, v12.4s, v19.4s
	fmla	v26.4s, v9.4s, v18.4s
	fmla	v27.4s, v11.4s, v17.4s
	fmls	v20.4s, v13.4s, v18.4s
	fmls	v16.4s, v15.4s, v17.4s
	fsub	v18.4s, v23.4s, v25.4s
	fsub	v17.4s, v24.4s, v22.4s
	fsub	v19.4s, v20.4s, v26.4s
	fsub	v21.4s, v16.4s, v27.4s
	fadd	v22.4s, v24.4s, v22.4s
	fadd	v23.4s, v25.4s, v23.4s
	fadd	v24.4s, v20.4s, v26.4s
	fadd	v25.4s, v16.4s, v27.4s
	fmul	v17.4s, v17.4s, v31.4s
	fmul	v18.4s, v18.4s, v31.4s
	fmul	v19.4s, v19.4s, v31.4s
	fmul	v21.4s, v21.4s, v31.4s
	rev64	v22.4s, v22.4s
	rev64	v24.4s, v24.4s
	rev64	v23.4s, v23.4s
	rev64	v25.4s, v25.4s
	fsub	v8.4s, v0.4s, v22.4s
	fsub	v9.4s, v1.4s, v24.4s
	fsub	v10.4s, v2.4s, v17.4s
	fsub	v11.4s, v3.4s, v19.4s
	fsub	v12.4s, v4.4s, v23.4s
	fsub	v13.4s, v5.4s, v25.4s
	fadd	v14.4s, v6.4s, v18.4s
	fsub	v15.4s, v7.4s, v21.4s
	fadd	v0.4s, v0.4s, v22.4s
	fadd	v1.4s, v1.4s, v24.4s
	fadd	v2.4s, v2.4s, v17.4s
	fadd	v3.4s, v3.4s, v19.4s
	fadd	v4.4s, v4.4s, v23.4s
	fsub	v6.4s, v6.4s, v18.4s
	fadd	v5.4s, v5.4s, v25.4s
	fadd	v7.4s, v7.4s, v21.4s
	stp	q2, q3, [x1, #32]
	stp	q6, q7, [x1, #96]
	stp	q10, q11, [x1, #160]
	stp	q14, q15, [x1, #224]
	cmp	w20, #32
	b.gt	L_12
	stp	q0, q1, [x1]
	stp	q4, q5, [x1, #64]
	stp	q8, q9, [x1, #128]
	stp	q12, q13, [x1, #192]
	ret
L_12
	mov	w5, #36
	adrp	x7, celt_tx_tab_64
	add	x7, x7, #PageOffset(celt_tx_tab_64)
	add	x8, x7, x5
	mov	x9, #-32
	mov	x21, #128
	add	x22, x21, x21, lsl #1
	ldp	q2, q3, [x2]
	ldp	q10, q11, [x2, #32]
	add	x2, x2, #64
	ldp	q6, q14, [x2]
	ldp	q7, q15, [x2, #32]
	add	x2, x2, #64
	adrp	x5, tab_8pt
	add	x5, x5, #PageOffset(tab_8pt)
	fsub	v17.4s, v3.4s, v11.4s
	fadd	v11.4s, v3.4s, v11.4s
	fsub	v16.4s, v2.4s, v10.4s
	fadd	v10.4s, v2.4s, v10.4s
	ld1	{ v21.4s }, [x5]
	ext	v20.16b, v11.16b, v11.16b, #12
	rev64	v20.4s, v20.4s
	ext	v18.16b, v10.16b, v20.16b, #8
	mov	v10.d[1], v20.d[1]
	fsub	v3.4s, v10.4s, v18.4s
	fadd	v18.4s, v10.4s, v18.4s
	rev64	v22.4s, v31.4s
	dup	v10.2d, v16.d[0]
	dup	v11.2d, v16.d[1]
	rev64	v20.4s, v3.4s
	rev64	v11.4s, v11.4s
	ext	v22.16b, v31.16b, v22.16b, #8
	zip1	v19.2d, v18.2d, v3.2d
	zip2	v18.2d, v18.2d, v20.2d
	fadd	v2.4s, v19.4s, v18.4s
	fsub	v3.4s, v19.4s, v18.4s
	fmul	v17.4s, v17.4s, v21.4s
	fmls	v10.4s, v11.4s, v22.4s
	rev64	v20.4s, v17.4s
	fmla	v17.4s, v20.4s, v31.4s
	rev64	v20.4s, v17.4s
	ext	v20.16b, v20.16b, v20.16b, #8
	fmla	v20.4s, v17.4s, v31.4s
	fadd	v11.4s, v10.4s, v20.4s
	fsub	v10.4s, v10.4s, v20.4s
	fadd	v16.4s, v6.4s, v14.4s
	fadd	v18.4s, v7.4s, v15.4s
	fsub	v6.4s, v6.4s, v14.4s
	fsub	v7.4s, v7.4s, v15.4s
	rev64	v20.4s, v6.4s
	rev64	v21.4s, v7.4s
	zip2	v14.2d, v16.2d, v20.2d
	zip2	v15.2d, v18.2d, v21.2d
	fneg	v19.4s, v20.4s
	fneg	v20.4s, v21.4s
	mov	v14.s[3], v19.s[3]
	mov	v15.s[3], v20.s[3]
	zip1	v17.2d, v16.2d, v6.2d
	zip1	v19.2d, v18.2d, v7.2d
	fsub	v20.4s, v17.4s, v14.4s
	fadd	v21.4s, v17.4s, v14.4s
	fsub	v18.4s, v19.4s, v15.4s
	fadd	v19.4s, v19.4s, v15.4s
	zip1	v6.2d, v21.2d, v20.2d
	zip2	v14.2d, v21.2d, v20.2d
	zip1	v7.2d, v19.2d, v18.2d
	zip2	v15.2d, v19.2d, v18.2d
	adrp	x5, tab_16pt
	add	x5, x5, #PageOffset(tab_16pt)
	rev64	v16.4s, v6.4s
	rev64	v17.4s, v7.4s
	mov	v16.d[0], xzr
	mov	v17.d[0], xzr
	ld1	{ v20.4s, v21.4s, v22.4s }, [x5]
	fmla	v7.4s, v17.4s, v31.4s
	fmls	v6.4s, v16.4s, v31.4s
	fmul	v18.4s, v14.4s, v20.4s
	fmul	v19.4s, v15.4s, v20.4s
	rev64	v15.4s, v15.4s
	rev64	v14.4s, v14.4s
	fmla	v19.4s, v15.4s, v21.4s
	fmls	v18.4s, v14.4s, v21.4s
	fmul	v17.4s, v7.4s, v22.4s
	fmul	v16.4s, v6.4s, v22.4s
	mov	v14.16b, v19.16b
	mov	v7.16b, v17.16b
	fsub	v19.4s, v19.4s, v18.4s
	fsub	v17.4s, v17.4s, v16.4s
	fadd	v18.4s, v18.4s, v14.4s
	rev64	v19.4s, v19.4s
	fadd	v16.4s, v16.4s, v7.4s
	rev64	v17.4s, v17.4s
	fmul	v18.4s, v18.4s, v31.4s
	fmul	v17.4s, v17.4s, v31.4s
	fadd	v15.4s, v11.4s, v19.4s
	fsub	v7.4s, v11.4s, v19.4s
	fsub	v14.4s, v10.4s, v18.4s
	fadd	v6.4s, v10.4s, v18.4s
	fsub	v10.4s, v2.4s, v16.4s
	fadd	v2.4s, v2.4s, v16.4s
	fsub	v11.4s, v3.4s, v17.4s
	fadd	v3.4s, v3.4s, v17.4s
	ld1	{ v16.4s, v17.4s, v18.4s, v19.4s }, [x2], #64
	ldp	q20, q22, [x2]
	ldp	q21, q23, [x2, #32]
	add	x2, x2, #64
	adrp	x5, tab_8pt
	add	x5, x5, #PageOffset(tab_8pt)
	fsub	v25.4s, v17.4s, v19.4s
	fadd	v19.4s, v17.4s, v19.4s
	fsub	v24.4s, v16.4s, v18.4s
	fadd	v18.4s, v16.4s, v18.4s
	ld1	{ v29.4s }, [x5]
	ext	v28.16b, v19.16b, v19.16b, #12
	rev64	v28.4s, v28.4s
	ext	v26.16b, v18.16b, v28.16b, #8
	mov	v18.d[1], v28.d[1]
	fsub	v17.4s, v18.4s, v26.4s
	fadd	v26.4s, v18.4s, v26.4s
	rev64	v30.4s, v31.4s
	dup	v18.2d, v24.d[0]
	dup	v19.2d, v24.d[1]
	rev64	v28.4s, v17.4s
	rev64	v19.4s, v19.4s
	ext	v30.16b, v31.16b, v30.16b, #8
	zip1	v27.2d, v26.2d, v17.2d
	zip2	v26.2d, v26.2d, v28.2d
	fadd	v16.4s, v27.4s, v26.4s
	fsub	v17.4s, v27.4s, v26.4s
	fmul	v25.4s, v25.4s, v29.4s
	fmls	v18.4s, v19.4s, v30.4s
	rev64	v28.4s, v25.4s
	fmla	v25.4s, v28.4s, v31.4s
	rev64	v28.4s, v25.4s
	ext	v28.16b, v28.16b, v28.16b, #8
	fmla	v28.4s, v25.4s, v31.4s
	fadd	v19.4s, v18.4s, v28.4s
	fsub	v18.4s, v18.4s, v28.4s
	fadd	v24.4s, v20.4s, v22.4s
	fadd	v26.4s, v21.4s, v23.4s
	fsub	v20.4s, v20.4s, v22.4s
	fsub	v21.4s, v21.4s, v23.4s
	rev64	v28.4s, v20.4s
	rev64	v29.4s, v21.4s
	zip2	v22.2d, v24.2d, v28.2d
	zip2	v23.2d, v26.2d, v29.2d
	fneg	v27.4s, v28.4s
	fneg	v28.4s, v29.4s
	mov	v22.s[3], v27.s[3]
	mov	v23.s[3], v28.s[3]
	zip1	v25.2d, v24.2d, v20.2d
	zip1	v27.2d, v26.2d, v21.2d
	fsub	v28.4s, v25.4s, v22.4s
	fadd	v29.4s, v25.4s, v22.4s
	fsub	v26.4s, v27.4s, v23.4s
	fadd	v27.4s, v27.4s, v23.4s
	zip1	v20.2d, v29.2d, v28.2d
	zip2	v22.2d, v29.2d, v28.2d
	zip1	v21.2d, v27.2d, v26.2d
	zip2	v23.2d, v27.2d, v26.2d
	adrp	x5, tab_16pt
	add	x5, x5, #PageOffset(tab_16pt)
	rev64	v24.4s, v20.4s
	rev64	v25.4s, v21.4s
	mov	v24.d[0], xzr
	mov	v25.d[0], xzr
	ld1	{ v28.4s, v29.4s, v30.4s }, [x5]
	fmla	v21.4s, v25.4s, v31.4s
	fmls	v20.4s, v24.4s, v31.4s
	fmul	v26.4s, v22.4s, v28.4s
	fmul	v27.4s, v23.4s, v28.4s
	rev64	v23.4s, v23.4s
	rev64	v22.4s, v22.4s
	fmla	v27.4s, v23.4s, v29.4s
	fmls	v26.4s, v22.4s, v29.4s
	fmul	v25.4s, v21.4s, v30.4s
	fmul	v24.4s, v20.4s, v30.4s
	mov	v22.16b, v27.16b
	mov	v21.16b, v25.16b
	fsub	v27.4s, v27.4s, v26.4s
	fsub	v25.4s, v25.4s, v24.4s
	fadd	v26.4s, v26.4s, v22.4s
	rev64	v27.4s, v27.4s
	fadd	v24.4s, v24.4s, v21.4s
	rev64	v25.4s, v25.4s
	fmul	v26.4s, v26.4s, v31.4s
	fmul	v25.4s, v25.4s, v31.4s
	fadd	v23.4s, v19.4s, v27.4s
	fsub	v21.4s, v19.4s, v27.4s
	fsub	v22.4s, v18.4s, v26.4s
	fadd	v20.4s, v18.4s, v26.4s
	fsub	v18.4s, v16.4s, v24.4s
	fadd	v16.4s, v16.4s, v24.4s
	fsub	v19.4s, v17.4s, v25.4s
	fadd	v17.4s, v17.4s, v25.4s
	ld1	{ v26.4s, v27.4s }, [x8], x9
	ldp	q24, q25, [x7], #32
	ext	v26.16b, v26.16b, v26.16b, #8
	ext	v27.16b, v27.16b, v27.16b, #8
	cmp	w19, #64
	b.eq	L_13
	rev64	v28.4s, v2.4s
	rev64	v29.4s, v16.4s
	trn2	v30.4s, v27.4s, v27.4s
	fmul	v30.4s, v30.4s, v31.4s
	fmul	v16.4s, v16.4s, v30.4s
	fmul	v2.4s, v2.4s, v30.4s
	trn1	v30.4s, v24.4s, v24.4s
	fmul	v29.4s, v29.4s, v30.4s
	fmla	v2.4s, v28.4s, v30.4s
	fsub	v29.4s, v29.4s, v16.4s
	rev64	v30.4s, v3.4s
	rev64	v16.4s, v17.4s
	trn2	v28.4s, v26.4s, v26.4s
	fmul	v28.4s, v28.4s, v31.4s
	fmul	v3.4s, v3.4s, v28.4s
	fmul	v17.4s, v17.4s, v28.4s
	trn1	v28.4s, v25.4s, v25.4s
	fmul	v16.4s, v16.4s, v28.4s
	fmla	v3.4s, v30.4s, v28.4s
	fsub	v16.4s, v16.4s, v17.4s
	fsub	v28.4s, v29.4s, v2.4s
	fadd	v2.4s, v29.4s, v2.4s
	fadd	v30.4s, v16.4s, v3.4s
	fsub	v29.4s, v16.4s, v3.4s
	fmul	v28.4s, v28.4s, v31.4s
	fmul	v29.4s, v29.4s, v31.4s
	rev64	v30.4s, v30.4s
	rev64	v2.4s, v2.4s
	fsub	v3.4s, v1.4s, v30.4s
	fsub	v16.4s, v8.4s, v28.4s
	fsub	v17.4s, v9.4s, v29.4s
	fadd	v1.4s, v1.4s, v30.4s
	fadd	v8.4s, v8.4s, v28.4s
	fadd	v9.4s, v9.4s, v29.4s
	mov	v29.16b, v2.16b
	fsub	v2.4s, v0.4s, v29.4s
	fadd	v0.4s, v0.4s, v29.4s
	stp	q0, q1, [x1]
	stp	q8, q9, [x1, #128]
	stp	q2, q3, [x1, #256]
	stp	q16, q17, [x1, #384]
	trn2	v1.4s, v24.4s, v24.4s
	trn2	v25.4s, v25.4s, v25.4s
	trn1	v8.4s, v26.4s, v26.4s
	trn1	v27.4s, v27.4s, v27.4s
	fmul	v8.4s, v8.4s, v31.4s
	fmul	v27.4s, v27.4s, v31.4s
	rev64	v28.4s, v6.4s
	rev64	v29.4s, v20.4s
	rev64	v30.4s, v7.4s
	rev64	v0.4s, v21.4s
	fmul	v6.4s, v6.4s, v27.4s
	fmul	v7.4s, v7.4s, v8.4s
	fmla	v6.4s, v28.4s, v1.4s
	fmla	v7.4s, v30.4s, v25.4s
	fmul	v29.4s, v29.4s, v1.4s
	fmul	v0.4s, v0.4s, v25.4s
	fmls	v29.4s, v20.4s, v27.4s
	fmls	v0.4s, v21.4s, v8.4s
	fsub	v28.4s, v29.4s, v6.4s
	fadd	v29.4s, v29.4s, v6.4s
	fadd	v30.4s, v0.4s, v7.4s
	fsub	v0.4s, v0.4s, v7.4s
	fmul	v28.4s, v28.4s, v31.4s
	fmul	v0.4s, v0.4s, v31.4s
	rev64	v29.4s, v29.4s
	rev64	v30.4s, v30.4s
	fsub	v6.4s, v4.4s, v29.4s
	fadd	v20.4s, v5.4s, v30.4s
	fsub	v7.4s, v12.4s, v28.4s
	fadd	v21.4s, v13.4s, v0.4s
	fadd	v4.4s, v4.4s, v29.4s
	fsub	v5.4s, v5.4s, v30.4s
	fadd	v12.4s, v12.4s, v28.4s
	fsub	v13.4s, v13.4s, v0.4s
	stp	q4, q20, [x1, #64]
	stp	q12, q21, [x1, #192]
	stp	q6, q5, [x1, #320]
	stp	q7, q13, [x1, #448]
	ldp	q2, q3, [x1, #32]
	ldp	q6, q7, [x1, #96]
	ldp	q12, q13, [x1, #160]
	ldp	q16, q17, [x1, #224]
	ld1	{ v0.4s, v1.4s }, [x8], x9
	ld1	{ v24.4s, v25.4s }, [x7], #32
	ext	v26.16b, v0.16b, v0.16b, #8
	ext	v27.16b, v1.16b, v1.16b, #8
	trn1	v28.4s, v24.4s, v24.4s
	trn2	v24.4s, v24.4s, v24.4s
	trn1	v29.4s, v25.4s, v25.4s
	trn2	v25.4s, v25.4s, v25.4s
	rev64	v30.4s, v10.4s
	rev64	v8.4s, v14.4s
	rev64	v0.4s, v18.4s
	rev64	v1.4s, v22.4s
	fmul	v30.4s, v30.4s, v28.4s
	fmul	v8.4s, v8.4s, v24.4s
	fmul	v0.4s, v0.4s, v28.4s
	fmul	v1.4s, v1.4s, v24.4s
	rev64	v4.4s, v11.4s
	rev64	v5.4s, v15.4s
	rev64	v28.4s, v19.4s
	rev64	v24.4s, v23.4s
	fmul	v4.4s, v4.4s, v29.4s
	fmul	v5.4s, v5.4s, v25.4s
	fmul	v28.4s, v28.4s, v29.4s
	fmul	v24.4s, v24.4s, v25.4s
	trn1	v29.4s, v27.4s, v27.4s
	trn2	v27.4s, v27.4s, v27.4s
	trn1	v25.4s, v26.4s, v26.4s
	trn2	v26.4s, v26.4s, v26.4s
	fmul	v29.4s, v29.4s, v31.4s
	fmul	v27.4s, v27.4s, v31.4s
	fmul	v25.4s, v25.4s, v31.4s
	fmul	v26.4s, v26.4s, v31.4s
	fmla	v8.4s, v14.4s, v29.4s
	fmls	v1.4s, v22.4s, v29.4s
	fmla	v30.4s, v10.4s, v27.4s
	fmls	v0.4s, v18.4s, v27.4s
	fmla	v4.4s, v11.4s, v26.4s
	fmla	v5.4s, v15.4s, v25.4s
	fmls	v28.4s, v19.4s, v26.4s
	fmls	v24.4s, v23.4s, v25.4s
	fsub	v26.4s, v8.4s, v1.4s
	fsub	v25.4s, v0.4s, v30.4s
	fsub	v27.4s, v28.4s, v4.4s
	fsub	v29.4s, v24.4s, v5.4s
	fadd	v30.4s, v0.4s, v30.4s
	fadd	v8.4s, v1.4s, v8.4s
	fadd	v0.4s, v28.4s, v4.4s
	fadd	v1.4s, v24.4s, v5.4s
	fmul	v25.4s, v25.4s, v31.4s
	fmul	v26.4s, v26.4s, v31.4s
	fmul	v27.4s, v27.4s, v31.4s
	fmul	v29.4s, v29.4s, v31.4s
	rev64	v30.4s, v30.4s
	rev64	v0.4s, v0.4s
	rev64	v8.4s, v8.4s
	rev64	v1.4s, v1.4s
	fsub	v10.4s, v2.4s, v30.4s
	fsub	v11.4s, v3.4s, v0.4s
	fsub	v14.4s, v12.4s, v25.4s
	fsub	v15.4s, v13.4s, v27.4s
	fsub	v18.4s, v6.4s, v8.4s
	fsub	v19.4s, v7.4s, v1.4s
	fadd	v22.4s, v16.4s, v26.4s
	fsub	v23.4s, v17.4s, v29.4s
	fadd	v2.4s, v2.4s, v30.4s
	fadd	v3.4s, v3.4s, v0.4s
	fadd	v12.4s, v12.4s, v25.4s
	fadd	v13.4s, v13.4s, v27.4s
	fadd	v6.4s, v6.4s, v8.4s
	fsub	v16.4s, v16.4s, v26.4s
	fadd	v7.4s, v7.4s, v1.4s
	fadd	v17.4s, v17.4s, v29.4s
	stp	q2, q3, [x1, #32]
	stp	q6, q7, [x1, #96]
	stp	q12, q13, [x1, #160]
	stp	q16, q17, [x1, #224]
	stp	q10, q11, [x1, #288]
	stp	q18, q19, [x1, #352]
	stp	q14, q15, [x1, #416]
	stp	q22, q23, [x1, #480]
	ret
L_13
	mov	x10, v23.d[0]
	mov	x11, v23.d[1]
	rev64	v28.4s, v2.4s
	rev64	v29.4s, v16.4s
	trn2	v30.4s, v27.4s, v27.4s
	fmul	v30.4s, v30.4s, v31.4s
	fmul	v16.4s, v16.4s, v30.4s
	fmul	v2.4s, v2.4s, v30.4s
	trn1	v30.4s, v24.4s, v24.4s
	fmul	v29.4s, v29.4s, v30.4s
	fmla	v2.4s, v28.4s, v30.4s
	fsub	v29.4s, v29.4s, v16.4s
	rev64	v30.4s, v3.4s
	rev64	v16.4s, v17.4s
	trn2	v28.4s, v26.4s, v26.4s
	fmul	v28.4s, v28.4s, v31.4s
	fmul	v3.4s, v3.4s, v28.4s
	fmul	v17.4s, v17.4s, v28.4s
	trn1	v28.4s, v25.4s, v25.4s
	fmul	v16.4s, v16.4s, v28.4s
	fmla	v3.4s, v30.4s, v28.4s
	fsub	v16.4s, v16.4s, v17.4s
	fsub	v28.4s, v29.4s, v2.4s
	fadd	v2.4s, v29.4s, v2.4s
	fadd	v30.4s, v16.4s, v3.4s
	fsub	v29.4s, v16.4s, v3.4s
	fmul	v28.4s, v28.4s, v31.4s
	fmul	v29.4s, v29.4s, v31.4s
	rev64	v30.4s, v30.4s
	rev64	v2.4s, v2.4s
	fsub	v3.4s, v1.4s, v30.4s
	fsub	v16.4s, v8.4s, v28.4s
	fsub	v17.4s, v9.4s, v29.4s
	fadd	v1.4s, v1.4s, v30.4s
	fadd	v8.4s, v8.4s, v28.4s
	fadd	v9.4s, v9.4s, v29.4s
	mov	v29.16b, v2.16b
	fsub	v2.4s, v0.4s, v29.4s
	fadd	v0.4s, v0.4s, v29.4s
	trn2	v24.4s, v24.4s, v24.4s
	trn2	v25.4s, v25.4s, v25.4s
	trn1	v26.4s, v26.4s, v26.4s
	trn1	v27.4s, v27.4s, v27.4s
	fmul	v26.4s, v26.4s, v31.4s
	fmul	v27.4s, v27.4s, v31.4s
	rev64	v28.4s, v6.4s
	rev64	v29.4s, v20.4s
	rev64	v30.4s, v7.4s
	rev64	v23.4s, v21.4s
	fmul	v6.4s, v6.4s, v27.4s
	fmul	v7.4s, v7.4s, v26.4s
	fmla	v6.4s, v28.4s, v24.4s
	fmla	v7.4s, v30.4s, v25.4s
	fmul	v29.4s, v29.4s, v24.4s
	fmul	v23.4s, v23.4s, v25.4s
	fmls	v29.4s, v20.4s, v27.4s
	fmls	v23.4s, v21.4s, v26.4s
	fsub	v28.4s, v29.4s, v6.4s
	fadd	v29.4s, v29.4s, v6.4s
	fadd	v30.4s, v23.4s, v7.4s
	fsub	v23.4s, v23.4s, v7.4s
	fmul	v28.4s, v28.4s, v31.4s
	fmul	v23.4s, v23.4s, v31.4s
	rev64	v29.4s, v29.4s
	rev64	v30.4s, v30.4s
	fsub	v6.4s, v4.4s, v29.4s
	fadd	v20.4s, v5.4s, v30.4s
	fsub	v7.4s, v12.4s, v28.4s
	fadd	v21.4s, v13.4s, v23.4s
	fadd	v4.4s, v4.4s, v29.4s
	fsub	v5.4s, v5.4s, v30.4s
	fadd	v12.4s, v12.4s, v28.4s
	fsub	v13.4s, v13.4s, v23.4s
	zip1	v23.2d, v0.2d, v4.2d
	zip2	v24.2d, v0.2d, v4.2d
	zip1	v25.2d, v1.2d, v20.2d
	zip2	v26.2d, v1.2d, v20.2d
	zip1	v27.2d, v8.2d, v12.2d
	zip2	v28.2d, v8.2d, v12.2d
	zip1	v29.2d, v9.2d, v21.2d
	zip2	v30.2d, v9.2d, v21.2d
	mov	v20.16b, v5.16b
	mov	v21.16b, v7.16b
	mov	x12, x1
	add	x13, x1, #128
	add	x14, x1, #256
	add	x15, x1, #384
	zip1	v4.2d, v2.2d, v6.2d
	zip2	v5.2d, v2.2d, v6.2d
	zip1	v6.2d, v3.2d, v20.2d
	zip2	v7.2d, v3.2d, v20.2d
	zip1	v0.2d, v16.2d, v21.2d
	zip2	v1.2d, v16.2d, v21.2d
	zip1	v2.2d, v17.2d, v13.2d
	zip2	v3.2d, v17.2d, v13.2d
	ldp	q8, q9, [x1, #32]
	ldp	q12, q13, [x1, #160]
	st1	{ v23.4s, v24.4s, v25.4s, v26.4s }, [x12], #64
	st1	{ v27.4s, v28.4s, v29.4s, v30.4s }, [x13], #64
	st1	{ v4.4s, v5.4s, v6.4s, v7.4s }, [x14], #64
	st1	{ v0.4s, v1.4s, v2.4s, v3.4s }, [x15], #64
	mov	v23.d[0], x10
	mov	v23.d[1], x11
	ldp	q6, q7, [x1, #96]
	ldp	q16, q17, [x1, #224]
	ld1	{ v0.4s, v1.4s }, [x8], x9
	ld1	{ v24.4s, v25.4s }, [x7], #32
	ext	v26.16b, v0.16b, v0.16b, #8
	ext	v27.16b, v1.16b, v1.16b, #8
	trn1	v28.4s, v24.4s, v24.4s
	trn2	v24.4s, v24.4s, v24.4s
	trn1	v29.4s, v25.4s, v25.4s
	trn2	v25.4s, v25.4s, v25.4s
	rev64	v30.4s, v10.4s
	rev64	v4.4s, v14.4s
	rev64	v0.4s, v18.4s
	rev64	v1.4s, v22.4s
	fmul	v30.4s, v30.4s, v28.4s
	fmul	v4.4s, v4.4s, v24.4s
	fmul	v0.4s, v0.4s, v28.4s
	fmul	v1.4s, v1.4s, v24.4s
	rev64	v5.4s, v11.4s
	rev64	v20.4s, v15.4s
	rev64	v28.4s, v19.4s
	rev64	v24.4s, v23.4s
	fmul	v5.4s, v5.4s, v29.4s
	fmul	v20.4s, v20.4s, v25.4s
	fmul	v28.4s, v28.4s, v29.4s
	fmul	v24.4s, v24.4s, v25.4s
	trn1	v29.4s, v27.4s, v27.4s
	trn2	v27.4s, v27.4s, v27.4s
	trn1	v25.4s, v26.4s, v26.4s
	trn2	v26.4s, v26.4s, v26.4s
	fmul	v29.4s, v29.4s, v31.4s
	fmul	v27.4s, v27.4s, v31.4s
	fmul	v25.4s, v25.4s, v31.4s
	fmul	v26.4s, v26.4s, v31.4s
	fmla	v4.4s, v14.4s, v29.4s
	fmls	v1.4s, v22.4s, v29.4s
	fmla	v30.4s, v10.4s, v27.4s
	fmls	v0.4s, v18.4s, v27.4s
	fmla	v5.4s, v11.4s, v26.4s
	fmla	v20.4s, v15.4s, v25.4s
	fmls	v28.4s, v19.4s, v26.4s
	fmls	v24.4s, v23.4s, v25.4s
	fsub	v26.4s, v4.4s, v1.4s
	fsub	v25.4s, v0.4s, v30.4s
	fsub	v27.4s, v28.4s, v5.4s
	fsub	v29.4s, v24.4s, v20.4s
	fadd	v30.4s, v0.4s, v30.4s
	fadd	v4.4s, v1.4s, v4.4s
	fadd	v0.4s, v28.4s, v5.4s
	fadd	v1.4s, v24.4s, v20.4s
	fmul	v25.4s, v25.4s, v31.4s
	fmul	v26.4s, v26.4s, v31.4s
	fmul	v27.4s, v27.4s, v31.4s
	fmul	v29.4s, v29.4s, v31.4s
	rev64	v30.4s, v30.4s
	rev64	v0.4s, v0.4s
	rev64	v4.4s, v4.4s
	rev64	v1.4s, v1.4s
	fsub	v10.4s, v8.4s, v30.4s
	fsub	v11.4s, v9.4s, v0.4s
	fsub	v14.4s, v12.4s, v25.4s
	fsub	v15.4s, v13.4s, v27.4s
	fsub	v18.4s, v6.4s, v4.4s
	fsub	v19.4s, v7.4s, v1.4s
	fadd	v22.4s, v16.4s, v26.4s
	fsub	v23.4s, v17.4s, v29.4s
	fadd	v8.4s, v8.4s, v30.4s
	fadd	v9.4s, v9.4s, v0.4s
	fadd	v12.4s, v12.4s, v25.4s
	fadd	v13.4s, v13.4s, v27.4s
	fadd	v6.4s, v6.4s, v4.4s
	fsub	v16.4s, v16.4s, v26.4s
	fadd	v7.4s, v7.4s, v1.4s
	fadd	v17.4s, v17.4s, v29.4s
	zip1	v0.2d, v8.2d, v6.2d
	zip2	v1.2d, v8.2d, v6.2d
	zip1	v2.2d, v9.2d, v7.2d
	zip2	v3.2d, v9.2d, v7.2d
	st1	{ v0.4s, v1.4s, v2.4s, v3.4s }, [x12]
	zip1	v4.2d, v12.2d, v16.2d
	zip2	v5.2d, v12.2d, v16.2d
	zip1	v6.2d, v13.2d, v17.2d
	zip2	v7.2d, v13.2d, v17.2d
	st1	{ v4.4s, v5.4s, v6.4s, v7.4s }, [x13]
	zip1	v0.2d, v10.2d, v18.2d
	zip2	v1.2d, v10.2d, v18.2d
	zip1	v2.2d, v11.2d, v19.2d
	zip2	v3.2d, v11.2d, v19.2d
	st1	{ v0.4s, v1.4s, v2.4s, v3.4s }, [x14]
	zip1	v4.2d, v14.2d, v22.2d
	zip2	v5.2d, v14.2d, v22.2d
	zip1	v6.2d, v15.2d, v23.2d
	zip2	v7.2d, v15.2d, v23.2d
	st1	{ v4.4s, v5.4s, v6.4s, v7.4s }, [x15]
	ldp	x19, x20, [sp, #16]
	ldp	d14, d15, [sp, #32]
	ldp	d12, d13, [sp, #48]
	ldp	d10, d11, [sp, #64]
	ldp	d8, d9, [sp, #80]
	ldp	x21, x22, [sp], #96
	ret

	END
