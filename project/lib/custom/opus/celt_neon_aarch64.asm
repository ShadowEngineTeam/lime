; Generated from opus celt/arm/celt_neon_aarch64.S for armasm64: its macros expanded with llvm-mc

	AREA |.text|, CODE, READONLY, ALIGN=4
	AREA |.rdata|, DATA, READONLY, ALIGN=4
	ALIGN 4
LSIG2RES_inv_scale
	DCD 0x38000000
	AREA |.text|, CODE, READONLY, ALIGN=4
	ALIGN 16
	EXPORT comb_filter_const_neon
comb_filter_const_neon
	sub	x4, x1, w2, sxtw #2
	cmp	w3, #4
	b.lt	L_0
	sub	x5, x4, #8
	dup	v1.4s, v1.s[0]
	dup	v2.4s, v2.s[0]
	dup	v0.4s, v0.s[0]
	ld1	{ v3.4s }, [x5], #16
	sub	x6, x4, #4
	add	x7, x4, #4
	fmul	v3.4s, v3.4s, v2.4s
	sub	w3, w3, #4
L_1
	ld1	{ v7.4s }, [x5], #16
	ld1	{ v4.4s }, [x6], #16
	fmla	v3.4s, v7.4s, v2.4s
	ld1	{ v6.4s }, [x7], #16
	ld1	{ v5.4s }, [x4], #16
	fadd	v6.4s, v6.4s, v4.4s
	fmla	v3.4s, v5.4s, v0.4s
	ld1	{ v4.4s }, [x1], #16
	fmla	v3.4s, v6.4s, v1.4s
	fadd	v4.4s, v4.4s, v3.4s
	fmul	v3.4s, v7.4s, v2.4s
	st1	{ v4.4s }, [x0], #16
	subs	w3, w3, #4
	b.ge	L_1
	add	w3, w3, #4
L_0
	cmp	w3, #0
	b.le	L_2
L_3
	ldur	s3, [x4, #-8]
	ldr	s7, [x4, #8]
	ldur	s4, [x4, #-4]
	ldr	s6, [x4, #4]
	ldr	s5, [x4], #4
	ldr	s16, [x1], #4
	fmul	s3, s3, s2
	fadd	s6, s6, s4
	fmadd	s3, s7, s2, s3
	fmadd	s3, s5, s0, s3
	fmadd	s3, s6, s1, s3
	fadd	s16, s16, s3
	str	s16, [x0], #4
	subs	w3, w3, #1
	b.gt	L_3
L_2
	ret
	ALIGN 16
	EXPORT celt_deemphasis_neon
celt_deemphasis_neon
	fmul	s17, s0, s0
	fmul	s18, s0, s17
	fmul	s19, s17, s17
	movi	v4.16b, #0
	mov	v4.s[0], v0.s[0]
	mov	v4.s[1], v17.s[0]
	mov	v4.s[2], v18.s[0]
	mov	v4.s[3], v19.s[0]
	movi	v20.16b, #0
	ext	v5.16b, v20.16b, v4.16b, #12
	ext	v6.16b, v20.16b, v4.16b, #8
	ext	v7.16b, v20.16b, v4.16b, #4
	adrp	x3, LSIG2RES_inv_scale
	add	x3, x3, PageOffset(LSIG2RES_inv_scale)
	ld1r	{ v24.4s }, [x3]
	fmul	v0.4s, v5.4s, v1.s[0]
	mov	v0.s[0], v1.s[0]
	subs	w2, w2, #8
	b.lt	L_4
L_5
	ld1	{ v1.4s, v2.4s }, [x1], #32
	fmla	v0.4s, v5.4s, v1.s[0]
	fmul	v3.4s, v7.4s, v2.s[2]
	fmla	v0.4s, v6.4s, v1.s[1]
	fmla	v3.4s, v6.4s, v2.s[1]
	fmla	v0.4s, v7.4s, v1.s[2]
	fmla	v3.4s, v5.4s, v2.s[0]
	fadd	v1.4s, v1.4s, v0.4s
	fadd	v2.4s, v2.4s, v3.4s
	fmla	v2.4s, v4.4s, v1.s[3]
	fmul	v0.4s, v4.4s, v2.s[3]
	fmul	v1.4s, v1.4s, v24.4s
	fmul	v2.4s, v2.4s, v24.4s
	st1	{ v1.4s, v2.4s }, [x0], #32
	subs	w2, w2, #8
	b.ge	L_5
L_4
	adds	w2, w2, #8
	b.le	L_6
L_7
	ldr	s1, [x1], #4
	fadd	s1, s1, s0
	fmul	s0, s1, s4
	fmul	s1, s1, s24
	str	s1, [x0], #4
	subs	w2, w2, #1
	b.gt	L_7
L_6
	ret
	ALIGN 16
	EXPORT deemphasis_stereo_simple_neon
deemphasis_stereo_simple_neon
	ldp	x4, x5, [x0]
	fmul	s17, s0, s0
	fmul	s18, s0, s17
	fmul	s19, s17, s17
	movi	v4.16b, #0
	mov	v4.s[0], v0.s[0]
	mov	v4.s[1], v17.s[0]
	mov	v4.s[2], v18.s[0]
	mov	v4.s[3], v19.s[0]
	movi	v20.16b, #0
	ext	v5.16b, v20.16b, v4.16b, #12
	ext	v6.16b, v20.16b, v4.16b, #8
	ext	v7.16b, v20.16b, v4.16b, #4
	adrp	x6, LSIG2RES_inv_scale
	add	x6, x6, PageOffset(LSIG2RES_inv_scale)
	ld1r	{ v24.4s }, [x6]
	ldp	s28, s29, [x3]
	fmul	v0.4s, v5.4s, v28.s[0]
	fmul	v16.4s, v5.4s, v29.s[0]
	mov	v0.s[0], v28.s[0]
	mov	v16.s[0], v29.s[0]
	subs	w2, w2, #8
	b.lt	L_8
L_9
	ld1	{ v1.4s, v2.4s }, [x4], #32
	ld1	{ v17.4s, v18.4s }, [x5], #32
	fmla	v0.4s, v5.4s, v1.s[0]
	fmla	v16.4s, v5.4s, v17.s[0]
	fmul	v3.4s, v7.4s, v2.s[2]
	fmul	v19.4s, v7.4s, v18.s[2]
	fmla	v0.4s, v6.4s, v1.s[1]
	fmla	v16.4s, v6.4s, v17.s[1]
	fmla	v3.4s, v6.4s, v2.s[1]
	fmla	v19.4s, v6.4s, v18.s[1]
	fmla	v0.4s, v7.4s, v1.s[2]
	fmla	v16.4s, v7.4s, v17.s[2]
	fmla	v3.4s, v5.4s, v2.s[0]
	fmla	v19.4s, v5.4s, v18.s[0]
	fadd	v1.4s, v1.4s, v0.4s
	fadd	v17.4s, v17.4s, v16.4s
	fadd	v2.4s, v2.4s, v3.4s
	fadd	v18.4s, v18.4s, v19.4s
	fmla	v2.4s, v4.4s, v1.s[3]
	fmla	v18.4s, v4.4s, v17.s[3]
	fmul	v0.4s, v4.4s, v2.s[3]
	fmul	v16.4s, v4.4s, v18.s[3]
	fmul	v1.4s, v1.4s, v24.4s
	fmul	v17.4s, v17.4s, v24.4s
	fmul	v2.4s, v2.4s, v24.4s
	fmul	v18.4s, v18.4s, v24.4s
	zip1	v20.4s, v1.4s, v17.4s
	zip2	v21.4s, v1.4s, v17.4s
	zip1	v22.4s, v2.4s, v18.4s
	zip2	v23.4s, v2.4s, v18.4s
	st1	{ v20.4s, v21.4s, v22.4s, v23.4s }, [x1], #64
	subs	w2, w2, #8
	b.ge	L_9
L_8
	adds	w2, w2, #8
	b.le	L_10
L_11
	ldr	s1, [x4], #4
	ldr	s17, [x5], #4
	fadd	s1, s1, s0
	fadd	s17, s17, s16
	fmul	s0, s1, s4
	fmul	s16, s17, s4
	fmul	s1, s1, s24
	fmul	s17, s17, s24
	stp	s1, s17, [x1], #8
	subs	w2, w2, #1
	b.gt	L_11
L_10
	stp	s0, s16, [x3]
	ret

	END
