; Generated from opus pixman/pixman-arma64-neon-asm.S for armasm64: its macros expanded with llvm-mc

	AREA |.text|, CODE, READONLY, ALIGN=4
	ALIGN 4
	EXPORT pixman_composite_over_8888_0565_asm_neon
pixman_composite_over_8888_0565_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_0
	cmp	x0, #16
	b.lt	L_1
L_2
	tst	x8, #0xf
	b.eq	L_3
	tst	x8, #0x2
	b.eq	L_4
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v4.h }[1], [x8], #2
	add	x10, x10, #1
	sub	x0, x0, #1
L_4
	tst	x8, #0x4
	b.eq	L_5
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v4.h }[2], [x8], #2
	ld1	{ v4.h }[3], [x8], #2
	add	x10, x10, #2
	sub	x0, x0, #2
L_5
	tst	x8, #0x8
	b.eq	L_6
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v5.4h }, [x8], #8
	add	x10, x10, #4
	sub	x0, x0, #4
L_6
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	mov	v4.d[1], v5.d[0]
	shrn	v6.8b, v4.8h, #8
	shrn	v7.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v6.8b, v6.8b, #5
	mvn	v3.8b, v3.8b
	sri	v7.8b, v7.8b, #6
	shrn	v30.8b, v4.8h, #2
	umull	v10.8h, v3.8b, v6.8b
	umull	v11.8h, v3.8b, v7.8b
	umull	v12.8h, v3.8b, v30.8b
	urshr	v17.8h, v10.8h, #8
	urshr	v18.8h, v11.8h, #8
	urshr	v19.8h, v12.8h, #8
	raddhn	v20.8b, v10.8h, v17.8h
	raddhn	v23.8b, v11.8h, v18.8h
	raddhn	v22.8b, v12.8h, v19.8h
	tst	x9, #0xf
	b.eq	L_7
	add	x10, x10, #8
	sub	x9, x9, #1
L_7
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	b.le	L_8
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_8
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
L_8
	uqadd	v17.8b, v2.8b, v20.8b
	uqadd	v18.8b, v0.8b, v22.8b
	uqadd	v19.8b, v1.8b, v23.8b
	ushll	v14.8h, v17.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v8.8h, v19.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v9.8h, v18.8b, #7
	sli	v9.8h, v9.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x2, #0x2
	b.eq	L_9
	st1	{ v28.h }[1], [x2], #2
L_9
	tst	x2, #0x4
	b.eq	L_10
	st1	{ v28.s }[1], [x2], #4
L_10
	tst	x2, #0x8
	b.eq	L_11
	st1	{ v29.4h }, [x2], #8
L_11
L_3
	ld1	{ v4.4h, v5.4h }, [x8], #16
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	add	x10, x10, #8
	mov	v4.d[1], v5.d[0]
	shrn	v6.8b, v4.8h, #8
	shrn	v7.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v6.8b, v6.8b, #5
	mvn	v3.8b, v3.8b
	sri	v7.8b, v7.8b, #6
	shrn	v30.8b, v4.8h, #2
	umull	v10.8h, v3.8b, v6.8b
	umull	v11.8h, v3.8b, v7.8b
	umull	v12.8h, v3.8b, v30.8b
	urshr	v17.8h, v10.8h, #8
	urshr	v18.8h, v11.8h, #8
	urshr	v19.8h, v12.8h, #8
	raddhn	v20.8b, v10.8h, v17.8h
	raddhn	v23.8b, v11.8h, v18.8h
	raddhn	v22.8b, v12.8h, v19.8h
	tst	x9, #0xf
	b.eq	L_12
	add	x10, x10, #8
	sub	x9, x9, #1
L_12
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	b.le	L_13
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_13
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
L_13
	subs	x0, x0, #16
	b.lt	L_14
L_15
	uqadd	v17.8b, v2.8b, v20.8b
	ld1	{ v4.4h, v5.4h }, [x8], #16
	mov	v4.d[1], v5.d[0]
	uqadd	v18.8b, v0.8b, v22.8b
	uqadd	v19.8b, v1.8b, v23.8b
	shrn	v6.8b, v4.8h, #8
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	shrn	v7.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	ushll	v14.8h, v17.8b, #7
	sli	v14.8h, v14.8h, #1
	add	x10, x10, #8
	ushll	v8.8h, v19.8b, #7
	sli	v8.8h, v8.8h, #1
	tst	x9, #0xf
	sri	v6.8b, v6.8b, #5
	b.eq	L_16
	add	x10, x10, #8
L_16
	mvn	v3.8b, v3.8b
	b.eq	L_17
	sub	x9, x9, #1
L_17
	sri	v7.8b, v7.8b, #6
	shrn	v30.8b, v4.8h, #2
	umull	v10.8h, v3.8b, v6.8b
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	umull	v11.8h, v3.8b, v7.8b
	umull	v12.8h, v3.8b, v30.8b
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	sri	v14.8h, v8.8h, #5
	cmp	x10, x14
	ushll	v9.8h, v18.8b, #7
	sli	v9.8h, v9.8h, #1
	urshr	v17.8h, v10.8h, #8
	b.le	L_18
	sub	x10, x10, x14
L_18
	urshr	v19.8h, v11.8h, #8
	urshr	v18.8h, v12.8h, #8
	b.le	L_19
	subs	x9, x9, #16
L_19
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	b.le	L_20
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
L_20
	raddhn	v20.8b, v10.8h, v17.8h
	raddhn	v23.8b, v11.8h, v19.8h
	b.le	L_21
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
L_21
	raddhn	v22.8b, v12.8h, v18.8h
	st1	{ v14.8h }, [x2], #16
	subs	x0, x0, #8
	b.ge	L_15
L_14
	uqadd	v17.8b, v2.8b, v20.8b
	uqadd	v18.8b, v0.8b, v22.8b
	uqadd	v19.8b, v1.8b, v23.8b
	ushll	v14.8h, v17.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v8.8h, v19.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v9.8h, v18.8b, #7
	sli	v9.8h, v9.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
	tst	x0, #0x7
	b.eq	L_22
	tst	x0, #0x4
	b.eq	L_23
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v5.4h }, [x8], #8
	add	x10, x10, #4
L_23
	tst	x0, #0x2
	b.eq	L_24
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v4.h }[2], [x8], #2
	ld1	{ v4.h }[3], [x8], #2
	add	x10, x10, #2
L_24
	tst	x0, #0x1
	b.eq	L_25
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v4.h }[1], [x8], #2
	add	x10, x10, #1
L_25
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	mov	v4.d[1], v5.d[0]
	shrn	v6.8b, v4.8h, #8
	shrn	v7.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v6.8b, v6.8b, #5
	mvn	v3.8b, v3.8b
	sri	v7.8b, v7.8b, #6
	shrn	v30.8b, v4.8h, #2
	umull	v10.8h, v3.8b, v6.8b
	umull	v11.8h, v3.8b, v7.8b
	umull	v12.8h, v3.8b, v30.8b
	urshr	v17.8h, v10.8h, #8
	urshr	v18.8h, v11.8h, #8
	urshr	v19.8h, v12.8h, #8
	raddhn	v20.8b, v10.8h, v17.8h
	raddhn	v23.8b, v11.8h, v18.8h
	raddhn	v22.8b, v12.8h, v19.8h
	tst	x9, #0xf
	b.eq	L_26
	add	x10, x10, #8
	sub	x9, x9, #1
L_26
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	b.le	L_27
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_27
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
L_27
	uqadd	v17.8b, v2.8b, v20.8b
	uqadd	v18.8b, v0.8b, v22.8b
	uqadd	v19.8b, v1.8b, v23.8b
	ushll	v14.8h, v17.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v8.8h, v19.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v9.8h, v18.8b, #7
	sli	v9.8h, v9.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_28
	st1	{ v29.4h }, [x2], #8
L_28
	tst	x0, #0x2
	b.eq	L_29
	st1	{ v28.s }[1], [x2], #4
L_29
	tst	x0, #0x1
	b.eq	L_30
	st1	{ v28.h }[1], [x2], #2
L_30
L_22
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x4, x4, x5, lsl #2
	sub	x2, x2, x0, lsl #1
	sub	x4, x4, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_2
L_31
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1
	lsl	x15, x5, #2
	prfm	pldl1keep, [x4, x15]
	lsl	x15, x3, #1
	prfm	pldl1keep, [x8, x15]
	tst	x0, #0x8
	b.eq	L_32
	ld1	{ v4.4h, v5.4h }, [x8], #16
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	mov	v4.d[1], v5.d[0]
	shrn	v6.8b, v4.8h, #8
	shrn	v7.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v6.8b, v6.8b, #5
	mvn	v3.8b, v3.8b
	sri	v7.8b, v7.8b, #6
	shrn	v30.8b, v4.8h, #2
	umull	v10.8h, v3.8b, v6.8b
	umull	v11.8h, v3.8b, v7.8b
	umull	v12.8h, v3.8b, v30.8b
	urshr	v17.8h, v10.8h, #8
	urshr	v18.8h, v11.8h, #8
	urshr	v19.8h, v12.8h, #8
	raddhn	v20.8b, v10.8h, v17.8h
	raddhn	v23.8b, v11.8h, v18.8h
	raddhn	v22.8b, v12.8h, v19.8h
	uqadd	v17.8b, v2.8b, v20.8b
	uqadd	v18.8b, v0.8b, v22.8b
	uqadd	v19.8b, v1.8b, v23.8b
	ushll	v14.8h, v17.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v8.8h, v19.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v9.8h, v18.8b, #7
	sli	v9.8h, v9.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
L_32
	tst	x0, #0x7
	b.eq	L_33
	tst	x0, #0x4
	b.eq	L_34
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v5.4h }, [x8], #8
L_34
	tst	x0, #0x2
	b.eq	L_35
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v4.h }[2], [x8], #2
	ld1	{ v4.h }[3], [x8], #2
L_35
	tst	x0, #0x1
	b.eq	L_36
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v4.h }[1], [x8], #2
L_36
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	mov	v4.d[1], v5.d[0]
	shrn	v6.8b, v4.8h, #8
	shrn	v7.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v6.8b, v6.8b, #5
	mvn	v3.8b, v3.8b
	sri	v7.8b, v7.8b, #6
	shrn	v30.8b, v4.8h, #2
	umull	v10.8h, v3.8b, v6.8b
	umull	v11.8h, v3.8b, v7.8b
	umull	v12.8h, v3.8b, v30.8b
	urshr	v17.8h, v10.8h, #8
	urshr	v18.8h, v11.8h, #8
	urshr	v19.8h, v12.8h, #8
	raddhn	v20.8b, v10.8h, v17.8h
	raddhn	v23.8b, v11.8h, v18.8h
	raddhn	v22.8b, v12.8h, v19.8h
	uqadd	v17.8b, v2.8b, v20.8b
	uqadd	v18.8b, v0.8b, v22.8b
	uqadd	v19.8b, v1.8b, v23.8b
	ushll	v14.8h, v17.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v8.8h, v19.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v9.8h, v18.8b, #7
	sli	v9.8h, v9.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_37
	st1	{ v29.4h }, [x2], #8
L_37
	tst	x0, #0x2
	b.eq	L_38
	st1	{ v28.h }[2], [x2], #2
	st1	{ v28.h }[3], [x2], #2
L_38
	tst	x0, #0x1
	b.eq	L_39
	st1	{ v28.h }[1], [x2], #2
L_39
L_33
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x4, x4, x5, lsl #2
	sub	x2, x2, x0, lsl #1
	sub	x4, x4, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1
L_0
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_over_n_0565_asm_neon
pixman_composite_over_n_0565_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	mov	v3.s[0], w4
	dup	v0.8b, v3.b[0]
	dup	v1.8b, v3.b[1]
	dup	v2.8b, v3.b[2]
	dup	v3.8b, v3.b[3]
	mvn	v3.8b, v3.8b
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_40
	cmp	x0, #16
	b.lt	L_41
L_42
	tst	x8, #0xf
	b.eq	L_43
	tst	x8, #0x2
	b.eq	L_44
	ld1	{ v4.h }[1], [x8], #2
	add	x10, x10, #1
	sub	x0, x0, #1
L_44
	tst	x8, #0x4
	b.eq	L_45
	ld1	{ v4.h }[2], [x8], #2
	ld1	{ v4.h }[3], [x8], #2
	add	x10, x10, #2
	sub	x0, x0, #2
L_45
	tst	x8, #0x8
	b.eq	L_46
	ld1	{ v5.4h }, [x8], #8
	add	x10, x10, #4
	sub	x0, x0, #4
L_46
	mov	v4.d[1], v5.d[0]
	shrn	v6.8b, v4.8h, #8
	shrn	v7.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v7.8b, v7.8b, #6
	shrn	v30.8b, v4.8h, #2
	umull	v10.8h, v3.8b, v6.8b
	umull	v11.8h, v3.8b, v7.8b
	umull	v12.8h, v3.8b, v30.8b
	urshr	v13.8h, v10.8h, #8
	urshr	v14.8h, v11.8h, #8
	urshr	v15.8h, v12.8h, #8
	raddhn	v20.8b, v10.8h, v13.8h
	raddhn	v23.8b, v11.8h, v14.8h
	raddhn	v22.8b, v12.8h, v15.8h
	tst	x9, #0xf
	b.eq	L_47
	add	x10, x10, #8
	sub	x9, x9, #1
L_47
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	b.le	L_48
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_48
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
L_48
	uqadd	v17.8b, v2.8b, v20.8b
	uqadd	v18.8b, v0.8b, v22.8b
	uqadd	v19.8b, v1.8b, v23.8b
	ushll	v14.8h, v17.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v8.8h, v19.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v9.8h, v18.8b, #7
	sli	v9.8h, v9.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x2, #0x2
	b.eq	L_49
	st1	{ v28.h }[1], [x2], #2
L_49
	tst	x2, #0x4
	b.eq	L_50
	st1	{ v28.s }[1], [x2], #4
L_50
	tst	x2, #0x8
	b.eq	L_51
	st1	{ v29.4h }, [x2], #8
L_51
L_43
	ld1	{ v4.4h, v5.4h }, [x8], #16
	add	x10, x10, #8
	mov	v4.d[1], v5.d[0]
	shrn	v6.8b, v4.8h, #8
	shrn	v7.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v7.8b, v7.8b, #6
	shrn	v30.8b, v4.8h, #2
	umull	v10.8h, v3.8b, v6.8b
	umull	v11.8h, v3.8b, v7.8b
	umull	v12.8h, v3.8b, v30.8b
	urshr	v13.8h, v10.8h, #8
	urshr	v14.8h, v11.8h, #8
	urshr	v15.8h, v12.8h, #8
	raddhn	v20.8b, v10.8h, v13.8h
	raddhn	v23.8b, v11.8h, v14.8h
	raddhn	v22.8b, v12.8h, v15.8h
	tst	x9, #0xf
	b.eq	L_52
	add	x10, x10, #8
	sub	x9, x9, #1
L_52
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	b.le	L_53
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_53
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
L_53
	subs	x0, x0, #16
	b.lt	L_54
L_55
	uqadd	v17.8b, v2.8b, v20.8b
	uqadd	v18.8b, v0.8b, v22.8b
	uqadd	v19.8b, v1.8b, v23.8b
	ushll	v14.8h, v17.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v8.8h, v19.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v9.8h, v18.8b, #7
	sli	v9.8h, v9.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	ld1	{ v4.4h, v5.4h }, [x8], #16
	st1	{ v14.8h }, [x2], #16
	mov	v4.d[1], v5.d[0]
	shrn	v6.8b, v4.8h, #8
	shrn	v7.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v7.8b, v7.8b, #6
	shrn	v30.8b, v4.8h, #2
	umull	v10.8h, v3.8b, v6.8b
	umull	v11.8h, v3.8b, v7.8b
	umull	v12.8h, v3.8b, v30.8b
	urshr	v13.8h, v10.8h, #8
	urshr	v14.8h, v11.8h, #8
	urshr	v15.8h, v12.8h, #8
	raddhn	v20.8b, v10.8h, v13.8h
	raddhn	v23.8b, v11.8h, v14.8h
	raddhn	v22.8b, v12.8h, v15.8h
	add	x10, x10, #8
	tst	x9, #0xf
	b.eq	L_56
	add	x10, x10, #8
	sub	x9, x9, #1
L_56
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	b.le	L_57
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_57
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
L_57
	subs	x0, x0, #8
	b.ge	L_55
L_54
	uqadd	v17.8b, v2.8b, v20.8b
	uqadd	v18.8b, v0.8b, v22.8b
	uqadd	v19.8b, v1.8b, v23.8b
	ushll	v14.8h, v17.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v8.8h, v19.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v9.8h, v18.8b, #7
	sli	v9.8h, v9.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
	tst	x0, #0x7
	b.eq	L_58
	tst	x0, #0x4
	b.eq	L_59
	ld1	{ v5.4h }, [x8], #8
	add	x10, x10, #4
L_59
	tst	x0, #0x2
	b.eq	L_60
	ld1	{ v4.h }[2], [x8], #2
	ld1	{ v4.h }[3], [x8], #2
	add	x10, x10, #2
L_60
	tst	x0, #0x1
	b.eq	L_61
	ld1	{ v4.h }[1], [x8], #2
	add	x10, x10, #1
L_61
	mov	v4.d[1], v5.d[0]
	shrn	v6.8b, v4.8h, #8
	shrn	v7.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v7.8b, v7.8b, #6
	shrn	v30.8b, v4.8h, #2
	umull	v10.8h, v3.8b, v6.8b
	umull	v11.8h, v3.8b, v7.8b
	umull	v12.8h, v3.8b, v30.8b
	urshr	v13.8h, v10.8h, #8
	urshr	v14.8h, v11.8h, #8
	urshr	v15.8h, v12.8h, #8
	raddhn	v20.8b, v10.8h, v13.8h
	raddhn	v23.8b, v11.8h, v14.8h
	raddhn	v22.8b, v12.8h, v15.8h
	tst	x9, #0xf
	b.eq	L_62
	add	x10, x10, #8
	sub	x9, x9, #1
L_62
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	b.le	L_63
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_63
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
L_63
	uqadd	v17.8b, v2.8b, v20.8b
	uqadd	v18.8b, v0.8b, v22.8b
	uqadd	v19.8b, v1.8b, v23.8b
	ushll	v14.8h, v17.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v8.8h, v19.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v9.8h, v18.8b, #7
	sli	v9.8h, v9.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_64
	st1	{ v29.4h }, [x2], #8
L_64
	tst	x0, #0x2
	b.eq	L_65
	st1	{ v28.s }[1], [x2], #4
L_65
	tst	x0, #0x1
	b.eq	L_66
	st1	{ v28.h }[1], [x2], #2
L_66
L_58
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	sub	x2, x2, x0, lsl #1
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_42
L_67
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_41
	lsl	x15, x3, #1
	prfm	pldl1keep, [x8, x15]
	tst	x0, #0x8
	b.eq	L_68
	ld1	{ v4.4h, v5.4h }, [x8], #16
	mov	v4.d[1], v5.d[0]
	shrn	v6.8b, v4.8h, #8
	shrn	v7.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v7.8b, v7.8b, #6
	shrn	v30.8b, v4.8h, #2
	umull	v10.8h, v3.8b, v6.8b
	umull	v11.8h, v3.8b, v7.8b
	umull	v12.8h, v3.8b, v30.8b
	urshr	v13.8h, v10.8h, #8
	urshr	v14.8h, v11.8h, #8
	urshr	v15.8h, v12.8h, #8
	raddhn	v20.8b, v10.8h, v13.8h
	raddhn	v23.8b, v11.8h, v14.8h
	raddhn	v22.8b, v12.8h, v15.8h
	uqadd	v17.8b, v2.8b, v20.8b
	uqadd	v18.8b, v0.8b, v22.8b
	uqadd	v19.8b, v1.8b, v23.8b
	ushll	v14.8h, v17.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v8.8h, v19.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v9.8h, v18.8b, #7
	sli	v9.8h, v9.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
L_68
	tst	x0, #0x7
	b.eq	L_69
	tst	x0, #0x4
	b.eq	L_70
	ld1	{ v5.4h }, [x8], #8
L_70
	tst	x0, #0x2
	b.eq	L_71
	ld1	{ v4.h }[2], [x8], #2
	ld1	{ v4.h }[3], [x8], #2
L_71
	tst	x0, #0x1
	b.eq	L_72
	ld1	{ v4.h }[1], [x8], #2
L_72
	mov	v4.d[1], v5.d[0]
	shrn	v6.8b, v4.8h, #8
	shrn	v7.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v7.8b, v7.8b, #6
	shrn	v30.8b, v4.8h, #2
	umull	v10.8h, v3.8b, v6.8b
	umull	v11.8h, v3.8b, v7.8b
	umull	v12.8h, v3.8b, v30.8b
	urshr	v13.8h, v10.8h, #8
	urshr	v14.8h, v11.8h, #8
	urshr	v15.8h, v12.8h, #8
	raddhn	v20.8b, v10.8h, v13.8h
	raddhn	v23.8b, v11.8h, v14.8h
	raddhn	v22.8b, v12.8h, v15.8h
	uqadd	v17.8b, v2.8b, v20.8b
	uqadd	v18.8b, v0.8b, v22.8b
	uqadd	v19.8b, v1.8b, v23.8b
	ushll	v14.8h, v17.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v8.8h, v19.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v9.8h, v18.8b, #7
	sli	v9.8h, v9.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_73
	st1	{ v29.4h }, [x2], #8
L_73
	tst	x0, #0x2
	b.eq	L_74
	st1	{ v28.h }[2], [x2], #2
	st1	{ v28.h }[3], [x2], #2
L_74
	tst	x0, #0x1
	b.eq	L_75
	st1	{ v28.h }[1], [x2], #2
L_75
L_69
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	sub	x2, x2, x0, lsl #1
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_41
L_40
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_src_8888_0565_asm_neon
pixman_composite_src_8888_0565_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #6
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_76
	cmp	x0, #16
	b.lt	L_77
L_78
	tst	x8, #0xf
	b.eq	L_79
	tst	x8, #0x2
	b.eq	L_80
	ld1	{ v0.s }[1], [x4], #4
	add	x8, x8, #2
	add	x10, x10, #1
	sub	x0, x0, #1
L_80
	tst	x8, #0x4
	b.eq	L_81
	ld1	{ v1.2s }, [x4], #8
	add	x8, x8, #4
	add	x10, x10, #2
	sub	x0, x0, #2
L_81
	tst	x8, #0x8
	b.eq	L_82
	ld1	{ v2.2s, v3.2s }, [x4], #16
	add	x8, x8, #8
	add	x10, x10, #4
	sub	x0, x0, #4
L_82
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	ushll	v8.8h, v1.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v14.8h, v2.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v9.8h, v0.8b, #7
	sli	v9.8h, v9.8h, #1
	tst	x9, #0xf
	b.eq	L_83
	add	x10, x10, #8
	sub	x9, x9, #1
L_83
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	b.le	L_84
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_84
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
L_84
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x2, #0x2
	b.eq	L_85
	st1	{ v28.h }[1], [x2], #2
L_85
	tst	x2, #0x4
	b.eq	L_86
	st1	{ v28.s }[1], [x2], #4
L_86
	tst	x2, #0x8
	b.eq	L_87
	st1	{ v29.4h }, [x2], #8
L_87
L_79
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	add	x10, x10, #8
	ushll	v8.8h, v1.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v14.8h, v2.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v9.8h, v0.8b, #7
	sli	v9.8h, v9.8h, #1
	tst	x9, #0xf
	b.eq	L_88
	add	x10, x10, #8
	sub	x9, x9, #1
L_88
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	b.le	L_89
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_89
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
L_89
	subs	x0, x0, #16
	b.lt	L_90
L_91
	sri	v14.8h, v8.8h, #5
	add	x10, x10, #8
	tst	x9, #0xf
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	b.eq	L_92
	add	x10, x10, #8
	sub	x9, x9, #1
L_92
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	ushll	v8.8h, v1.8b, #7
	sli	v8.8h, v8.8h, #1
	st1	{ v14.8h }, [x2], #16
	b.le	L_93
	sub	x10, x10, x14
	subs	x9, x9, #16
L_93
	ushll	v14.8h, v2.8b, #7
	sli	v14.8h, v14.8h, #1
	b.le	L_94
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
L_94
	ushll	v9.8h, v0.8b, #7
	sli	v9.8h, v9.8h, #1
	subs	x0, x0, #8
	b.ge	L_91
L_90
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
	tst	x0, #0x7
	b.eq	L_95
	tst	x0, #0x4
	b.eq	L_96
	ld1	{ v2.2s, v3.2s }, [x4], #16
	add	x10, x10, #4
L_96
	tst	x0, #0x2
	b.eq	L_97
	ld1	{ v1.2s }, [x4], #8
	add	x10, x10, #2
L_97
	tst	x0, #0x1
	b.eq	L_98
	ld1	{ v0.s }[1], [x4], #4
	add	x10, x10, #1
L_98
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	ushll	v8.8h, v1.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v14.8h, v2.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v9.8h, v0.8b, #7
	sli	v9.8h, v9.8h, #1
	tst	x9, #0xf
	b.eq	L_99
	add	x10, x10, #8
	sub	x9, x9, #1
L_99
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	b.le	L_100
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_100
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
L_100
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_101
	st1	{ v29.4h }, [x2], #8
L_101
	tst	x0, #0x2
	b.eq	L_102
	st1	{ v28.s }[1], [x2], #4
L_102
	tst	x0, #0x1
	b.eq	L_103
	st1	{ v28.h }[1], [x2], #2
L_103
L_95
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x4, x4, x5, lsl #2
	sub	x2, x2, x0, lsl #1
	sub	x4, x4, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_78
L_104
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_77
	lsl	x15, x5, #2
	prfm	pldl1keep, [x4, x15]
	tst	x0, #0x8
	b.eq	L_105
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	ushll	v8.8h, v1.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v14.8h, v2.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v9.8h, v0.8b, #7
	sli	v9.8h, v9.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
L_105
	tst	x0, #0x7
	b.eq	L_106
	tst	x0, #0x4
	b.eq	L_107
	ld1	{ v2.2s, v3.2s }, [x4], #16
L_107
	tst	x0, #0x2
	b.eq	L_108
	ld1	{ v1.2s }, [x4], #8
L_108
	tst	x0, #0x1
	b.eq	L_109
	ld1	{ v0.s }[1], [x4], #4
L_109
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	ushll	v8.8h, v1.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v14.8h, v2.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v9.8h, v0.8b, #7
	sli	v9.8h, v9.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_110
	st1	{ v29.4h }, [x2], #8
L_110
	tst	x0, #0x2
	b.eq	L_111
	st1	{ v28.h }[2], [x2], #2
	st1	{ v28.h }[3], [x2], #2
L_111
	tst	x0, #0x1
	b.eq	L_112
	st1	{ v28.h }[1], [x2], #2
L_112
L_106
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x4, x4, x5, lsl #2
	sub	x2, x2, x0, lsl #1
	sub	x4, x4, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_77
L_76
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_src_0565_8888_asm_neon
pixman_composite_src_0565_8888_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #6
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_113
	cmp	x0, #16
	b.lt	L_114
L_115
	tst	x8, #0xf
	b.eq	L_116
	tst	x8, #0x4
	b.eq	L_117
	ld1	{ v0.h }[1], [x4], #2
	add	x8, x8, #4
	add	x10, x10, #1
	sub	x0, x0, #1
L_117
	tst	x8, #0x8
	b.eq	L_118
	ld1	{ v0.h }[2], [x4], #2
	ld1	{ v0.h }[3], [x4], #2
	add	x8, x8, #8
	add	x10, x10, #2
	sub	x0, x0, #2
L_118
	ld1	{ v1.4h }, [x4], #8
	add	x8, x8, #16
	add	x10, x10, #4
	sub	x0, x0, #4
L_119
	mov	v0.d[1], v1.d[0]
	shrn	v30.8b, v0.8h, #8
	shrn	v29.8b, v0.8h, #3
	sli	v0.8h, v0.8h, #5
	movi	v31.8b, #255
	sri	v30.8b, v30.8b, #5
	sri	v29.8b, v29.8b, #6
	shrn	v28.8b, v0.8h, #2
	tst	x9, #0xf
	b.eq	L_120
	add	x10, x10, #8
	sub	x9, x9, #1
L_120
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x11, x15]
	b.le	L_121
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_121
	add	x11, x11, x5, lsl #1
	ldrsb	x15, [x11]
L_121
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x2, #0x4
	b.eq	L_122
	st1	{ v28.s }[1], [x2], #4
L_122
	tst	x2, #0x8
	b.eq	L_123
	st1	{ v29.2s }, [x2], #8
L_123
	st1	{ v30.2s, v31.2s }, [x2], #16
L_124
L_116
	ld1	{ v0.4h, v1.4h }, [x4], #16
	add	x10, x10, #8
	mov	v0.d[1], v1.d[0]
	shrn	v30.8b, v0.8h, #8
	shrn	v29.8b, v0.8h, #3
	sli	v0.8h, v0.8h, #5
	movi	v31.8b, #255
	sri	v30.8b, v30.8b, #5
	sri	v29.8b, v29.8b, #6
	shrn	v28.8b, v0.8h, #2
	tst	x9, #0xf
	b.eq	L_125
	add	x10, x10, #8
	sub	x9, x9, #1
L_125
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x11, x15]
	b.le	L_126
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_126
	add	x11, x11, x5, lsl #1
	ldrsb	x15, [x11]
L_126
	subs	x0, x0, #16
	b.lt	L_127
L_128
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	ld1	{ v0.4h, v1.4h }, [x4], #16
	mov	v0.d[1], v1.d[0]
	shrn	v30.8b, v0.8h, #8
	shrn	v29.8b, v0.8h, #3
	sli	v0.8h, v0.8h, #5
	movi	v31.8b, #255
	sri	v30.8b, v30.8b, #5
	sri	v29.8b, v29.8b, #6
	shrn	v28.8b, v0.8h, #2
	add	x10, x10, #8
	tst	x9, #0xf
	b.eq	L_129
	add	x10, x10, #8
	sub	x9, x9, #1
L_129
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x11, x15]
	b.le	L_130
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_130
	add	x11, x11, x5, lsl #1
	ldrsb	x15, [x11]
L_130
	subs	x0, x0, #8
	b.ge	L_128
L_127
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	tst	x0, #0x7
	b.eq	L_131
	tst	x0, #0x4
	b.eq	L_132
	ld1	{ v1.4h }, [x4], #8
	add	x10, x10, #4
L_132
	tst	x0, #0x2
	b.eq	L_133
	ld1	{ v0.h }[2], [x4], #2
	ld1	{ v0.h }[3], [x4], #2
	add	x10, x10, #2
L_133
	tst	x0, #0x1
	b.eq	L_134
	ld1	{ v0.h }[1], [x4], #2
	add	x10, x10, #1
L_134
	mov	v0.d[1], v1.d[0]
	shrn	v30.8b, v0.8h, #8
	shrn	v29.8b, v0.8h, #3
	sli	v0.8h, v0.8h, #5
	movi	v31.8b, #255
	sri	v30.8b, v30.8b, #5
	sri	v29.8b, v29.8b, #6
	shrn	v28.8b, v0.8h, #2
	tst	x9, #0xf
	b.eq	L_135
	add	x10, x10, #8
	sub	x9, x9, #1
L_135
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x11, x15]
	b.le	L_136
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_136
	add	x11, x11, x5, lsl #1
	ldrsb	x15, [x11]
L_136
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_137
	st1	{ v30.2s, v31.2s }, [x2], #16
L_137
	tst	x0, #0x2
	b.eq	L_138
	st1	{ v29.2s }, [x2], #8
L_138
	tst	x0, #0x1
	b.eq	L_139
	st1	{ v28.s }[1], [x2], #4
L_139
L_131
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #1
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #1
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_115
L_140
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_114
	lsl	x15, x5, #1
	prfm	pldl1keep, [x4, x15]
	tst	x0, #0x8
	b.eq	L_141
	ld1	{ v0.4h, v1.4h }, [x4], #16
	mov	v0.d[1], v1.d[0]
	shrn	v30.8b, v0.8h, #8
	shrn	v29.8b, v0.8h, #3
	sli	v0.8h, v0.8h, #5
	movi	v31.8b, #255
	sri	v30.8b, v30.8b, #5
	sri	v29.8b, v29.8b, #6
	shrn	v28.8b, v0.8h, #2
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
L_141
	tst	x0, #0x7
	b.eq	L_142
	tst	x0, #0x4
	b.eq	L_143
	ld1	{ v1.4h }, [x4], #8
L_143
	tst	x0, #0x2
	b.eq	L_144
	ld1	{ v0.h }[2], [x4], #2
	ld1	{ v0.h }[3], [x4], #2
L_144
	tst	x0, #0x1
	b.eq	L_145
	ld1	{ v0.h }[1], [x4], #2
L_145
	mov	v0.d[1], v1.d[0]
	shrn	v30.8b, v0.8h, #8
	shrn	v29.8b, v0.8h, #3
	sli	v0.8h, v0.8h, #5
	movi	v31.8b, #255
	sri	v30.8b, v30.8b, #5
	sri	v29.8b, v29.8b, #6
	shrn	v28.8b, v0.8h, #2
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_146
	st1	{ v30.2s, v31.2s }, [x2], #16
L_146
	tst	x0, #0x2
	b.eq	L_147
	st1	{ v29.2s }, [x2], #8
L_147
	tst	x0, #0x1
	b.eq	L_148
	st1	{ v28.s }[1], [x2], #4
L_148
L_142
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #1
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #1
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_114
L_113
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_add_8_8_asm_neon
pixman_composite_add_8_8_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #6
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_149
	cmp	x0, #64
	b.lt	L_150
L_151
	tst	x8, #0xf
	b.eq	L_152
	tst	x8, #0x1
	b.eq	L_153
	ld1	{ v0.b }[1], [x4], #1
	ld1	{ v4.b }[1], [x8], #1
	add	x10, x10, #1
	sub	x0, x0, #1
L_153
	tst	x8, #0x2
	b.eq	L_154
	ld1	{ v0.b }[2], [x4], #1
	ld1	{ v0.b }[3], [x4], #1
	ld1	{ v4.b }[2], [x8], #1
	ld1	{ v4.b }[3], [x8], #1
	add	x10, x10, #2
	sub	x0, x0, #2
L_154
	tst	x8, #0x4
	b.eq	L_155
	ld1	{ v0.b }[4], [x4], #1
	ld1	{ v0.b }[5], [x4], #1
	ld1	{ v0.b }[6], [x4], #1
	ld1	{ v0.b }[7], [x4], #1
	ld1	{ v4.b }[4], [x8], #1
	ld1	{ v4.b }[5], [x8], #1
	ld1	{ v4.b }[6], [x8], #1
	ld1	{ v4.b }[7], [x8], #1
	add	x10, x10, #4
	sub	x0, x0, #4
L_155
	tst	x8, #0x8
	b.eq	L_156
	ld1	{ v1.8b }, [x4], #8
	ld1	{ v5.8b }, [x8], #8
	add	x10, x10, #8
	sub	x0, x0, #8
L_156
	ld1	{ v2.8b, v3.8b }, [x4], #16
	ld1	{ v6.8b, v7.8b }, [x8], #16
	add	x10, x10, #16
	sub	x0, x0, #16
L_157
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_158
	add	x10, x10, #32
	sub	x9, x9, #1
L_158
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x11, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x12, x15]
	b.le	L_159
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_159
	add	x11, x11, x5
	ldrsb	x15, [x11]
	add	x12, x12, x3
	ldrsb	x15, [x12]
L_159
	tst	x2, #0x1
	b.eq	L_160
	st1	{ v28.b }[1], [x2], #1
L_160
	tst	x2, #0x2
	b.eq	L_161
	st1	{ v28.h }[1], [x2], #2
L_161
	tst	x2, #0x4
	b.eq	L_162
	st1	{ v28.s }[1], [x2], #4
L_162
	tst	x2, #0x8
	b.eq	L_163
	st1	{ v29.8b }, [x2], #8
L_163
	st1	{ v30.8b, v31.8b }, [x2], #16
L_164
L_152
	ld1	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld1	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	add	x10, x10, #32
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_165
	add	x10, x10, #32
	sub	x9, x9, #1
L_165
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x11, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x12, x15]
	b.le	L_166
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_166
	add	x11, x11, x5
	ldrsb	x15, [x11]
	add	x12, x12, x3
	ldrsb	x15, [x12]
L_166
	subs	x0, x0, #64
	b.lt	L_167
L_168
	ld1	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	add	x10, x10, #32
	tst	x9, #0xf
	ld1	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	b.eq	L_169
	add	x10, x10, #32
	sub	x9, x9, #1
L_169
	st1	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x11, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x12, x15]
	b.le	L_170
	sub	x10, x10, x14
	subs	x9, x9, #16
L_170
	uqadd	v28.8b, v0.8b, v4.8b
	b.le	L_171
	add	x11, x11, x5
	ldrsb	x15, [x11]
	add	x12, x12, x3
	ldrsb	x15, [x12]
L_171
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	subs	x0, x0, #32
	b.ge	L_168
L_167
	st1	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	tst	x0, #0x1f
	b.eq	L_172
	tst	x0, #0x10
	b.eq	L_173
	ld1	{ v2.8b, v3.8b }, [x4], #16
	ld1	{ v6.8b, v7.8b }, [x8], #16
	add	x10, x10, #16
L_173
	tst	x0, #0x8
	b.eq	L_174
	ld1	{ v1.8b }, [x4], #8
	ld1	{ v5.8b }, [x8], #8
	add	x10, x10, #8
L_174
	tst	x0, #0x4
	b.eq	L_175
	ld1	{ v0.b }[4], [x4], #1
	ld1	{ v0.b }[5], [x4], #1
	ld1	{ v0.b }[6], [x4], #1
	ld1	{ v0.b }[7], [x4], #1
	ld1	{ v4.b }[4], [x8], #1
	ld1	{ v4.b }[5], [x8], #1
	ld1	{ v4.b }[6], [x8], #1
	ld1	{ v4.b }[7], [x8], #1
	add	x10, x10, #4
L_175
	tst	x0, #0x2
	b.eq	L_176
	ld1	{ v0.b }[2], [x4], #1
	ld1	{ v0.b }[3], [x4], #1
	ld1	{ v4.b }[2], [x8], #1
	ld1	{ v4.b }[3], [x8], #1
	add	x10, x10, #2
L_176
	tst	x0, #0x1
	b.eq	L_177
	ld1	{ v0.b }[1], [x4], #1
	ld1	{ v4.b }[1], [x8], #1
	add	x10, x10, #1
L_177
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_178
	add	x10, x10, #32
	sub	x9, x9, #1
L_178
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x11, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x12, x15]
	b.le	L_179
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_179
	add	x11, x11, x5
	ldrsb	x15, [x11]
	add	x12, x12, x3
	ldrsb	x15, [x12]
L_179
	tst	x0, #0x10
	b.eq	L_180
	st1	{ v30.8b, v31.8b }, [x2], #16
L_180
	tst	x0, #0x8
	b.eq	L_181
	st1	{ v29.8b }, [x2], #8
L_181
	tst	x0, #0x4
	b.eq	L_182
	st1	{ v28.s }[1], [x2], #4
L_182
	tst	x0, #0x2
	b.eq	L_183
	st1	{ v28.h }[1], [x2], #2
L_183
	tst	x0, #0x1
	b.eq	L_184
	st1	{ v28.b }[1], [x2], #1
L_184
L_172
	mov	x0, x14
	add	x2, x2, x3
	add	x4, x4, x5
	sub	x2, x2, x0
	sub	x4, x4, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_151
L_185
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_150
	lsr	x15, x5, #0
	prfm	pldl1keep, [x4, x15]
	lsr	x15, x3, #0
	prfm	pldl1keep, [x8, x15]
	tst	x0, #0x20
	b.eq	L_186
	ld1	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld1	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	st1	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
L_186
	tst	x0, #0x1f
	b.eq	L_187
	tst	x0, #0x10
	b.eq	L_188
	ld1	{ v2.8b, v3.8b }, [x4], #16
	ld1	{ v6.8b, v7.8b }, [x8], #16
L_188
	tst	x0, #0x8
	b.eq	L_189
	ld1	{ v1.8b }, [x4], #8
	ld1	{ v5.8b }, [x8], #8
L_189
	tst	x0, #0x4
	b.eq	L_190
	ld1	{ v0.b }[4], [x4], #1
	ld1	{ v0.b }[5], [x4], #1
	ld1	{ v0.b }[6], [x4], #1
	ld1	{ v0.b }[7], [x4], #1
	ld1	{ v4.b }[4], [x8], #1
	ld1	{ v4.b }[5], [x8], #1
	ld1	{ v4.b }[6], [x8], #1
	ld1	{ v4.b }[7], [x8], #1
L_190
	tst	x0, #0x2
	b.eq	L_191
	ld1	{ v0.b }[2], [x4], #1
	ld1	{ v0.b }[3], [x4], #1
	ld1	{ v4.b }[2], [x8], #1
	ld1	{ v4.b }[3], [x8], #1
L_191
	tst	x0, #0x1
	b.eq	L_192
	ld1	{ v0.b }[1], [x4], #1
	ld1	{ v4.b }[1], [x8], #1
L_192
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	tst	x0, #0x10
	b.eq	L_193
	st1	{ v30.8b, v31.8b }, [x2], #16
L_193
	tst	x0, #0x8
	b.eq	L_194
	st1	{ v29.8b }, [x2], #8
L_194
	tst	x0, #0x4
	b.eq	L_195
	st1	{ v28.b }[4], [x2], #1
	st1	{ v28.b }[5], [x2], #1
	st1	{ v28.b }[6], [x2], #1
	st1	{ v28.b }[7], [x2], #1
L_195
	tst	x0, #0x2
	b.eq	L_196
	st1	{ v28.b }[2], [x2], #1
	st1	{ v28.b }[3], [x2], #1
L_196
	tst	x0, #0x1
	b.eq	L_197
	st1	{ v28.b }[1], [x2], #1
L_197
L_187
	mov	x0, x14
	add	x2, x2, x3
	add	x4, x4, x5
	sub	x2, x2, x0
	sub	x4, x4, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_150
L_149
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_add_8888_8888_asm_neon
pixman_composite_add_8888_8888_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #6
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_198
	cmp	x0, #16
	b.lt	L_199
L_200
	tst	x8, #0xf
	b.eq	L_201
	tst	x8, #0x4
	b.eq	L_202
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
	sub	x0, x0, #1
L_202
	tst	x8, #0x8
	b.eq	L_203
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
	sub	x0, x0, #2
L_203
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
	sub	x0, x0, #4
L_204
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_205
	add	x10, x10, #8
	sub	x9, x9, #1
L_205
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_206
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_206
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_206
	tst	x2, #0x4
	b.eq	L_207
	st1	{ v28.s }[1], [x2], #4
L_207
	tst	x2, #0x8
	b.eq	L_208
	st1	{ v29.2s }, [x2], #8
L_208
	st1	{ v30.2s, v31.2s }, [x2], #16
L_209
L_201
	ld1	{ v4.2s, v5.2s, v6.2s, v7.2s }, [x8], #32
	ld1	{ v0.2s, v1.2s, v2.2s, v3.2s }, [x4], #32
	add	x10, x10, #8
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_210
	add	x10, x10, #8
	sub	x9, x9, #1
L_210
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_211
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_211
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_211
	subs	x0, x0, #16
	b.lt	L_212
L_213
	ld1	{ v0.2s, v1.2s, v2.2s, v3.2s }, [x4], #32
	add	x10, x10, #8
	tst	x9, #0xf
	ld1	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	b.eq	L_214
	add	x10, x10, #8
	sub	x9, x9, #1
L_214
	st1	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_215
	sub	x10, x10, x14
	subs	x9, x9, #16
L_215
	uqadd	v28.8b, v0.8b, v4.8b
	b.le	L_216
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_216
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	subs	x0, x0, #8
	b.ge	L_213
L_212
	st1	{ v28.2s, v29.2s, v30.2s, v31.2s }, [x2], #32
	tst	x0, #0x7
	b.eq	L_217
	tst	x0, #0x4
	b.eq	L_218
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
L_218
	tst	x0, #0x2
	b.eq	L_219
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
L_219
	tst	x0, #0x1
	b.eq	L_220
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
L_220
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_221
	add	x10, x10, #8
	sub	x9, x9, #1
L_221
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_222
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_222
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_222
	tst	x0, #0x4
	b.eq	L_223
	st1	{ v30.2s, v31.2s }, [x2], #16
L_223
	tst	x0, #0x2
	b.eq	L_224
	st1	{ v29.2s }, [x2], #8
L_224
	tst	x0, #0x1
	b.eq	L_225
	st1	{ v28.s }[1], [x2], #4
L_225
L_217
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_200
L_226
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_199
	lsl	x15, x5, #2
	prfm	pldl1keep, [x4, x15]
	lsl	x15, x3, #2
	prfm	pldl1keep, [x8, x15]
	tst	x0, #0x8
	b.eq	L_227
	ld1	{ v4.2s, v5.2s, v6.2s, v7.2s }, [x8], #32
	ld1	{ v0.2s, v1.2s, v2.2s, v3.2s }, [x4], #32
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	st1	{ v28.2s, v29.2s, v30.2s, v31.2s }, [x2], #32
L_227
	tst	x0, #0x7
	b.eq	L_228
	tst	x0, #0x4
	b.eq	L_229
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v6.2s, v7.2s }, [x8], #16
L_229
	tst	x0, #0x2
	b.eq	L_230
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v5.2s }, [x8], #8
L_230
	tst	x0, #0x1
	b.eq	L_231
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v4.s }[1], [x8], #4
L_231
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	tst	x0, #0x4
	b.eq	L_232
	st1	{ v30.2s, v31.2s }, [x2], #16
L_232
	tst	x0, #0x2
	b.eq	L_233
	st1	{ v29.2s }, [x2], #8
L_233
	tst	x0, #0x1
	b.eq	L_234
	st1	{ v28.s }[1], [x2], #4
L_234
L_228
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_199
L_198
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_scanline_add_asm_neon
pixman_composite_scanline_add_asm_neon
	sxtw	x0, w0
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #64
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	mov	x4, x1
	cmp	x0, #8
	b.lt	L_235
	tst	x4, #0xf
	b.eq	L_236
	tst	x4, #0x4
	b.eq	L_237
	ld1	{ v0.s }[1], [x2], #4
	ld1	{ v4.s }[1], [x4], #4
	sub	x0, x0, #1
L_237
	tst	x4, #0x8
	b.eq	L_238
	ld1	{ v1.2s }, [x2], #8
	ld1	{ v5.2s }, [x4], #8
	sub	x0, x0, #2
L_238
	ld1	{ v2.2s, v3.2s }, [x2], #16
	ld1	{ v6.2s, v7.2s }, [x4], #16
	sub	x0, x0, #4
L_239
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
L_240
L_241
	tst	x1, #0x4
	b.eq	L_242
	st1	{ v28.s }[1], [x1], #4
L_242
	tst	x1, #0x8
	b.eq	L_243
	st1	{ v29.2s }, [x1], #8
L_243
	st1	{ v30.2s, v31.2s }, [x1], #16
L_244
L_236
	subs	x0, x0, #8
	b.lt	L_245
	ld1	{ v4.2s, v5.2s, v6.2s, v7.2s }, [x4], #32
	ld1	{ v0.2s, v1.2s, v2.2s, v3.2s }, [x2], #32
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	subs	x0, x0, #8
	b.lt	L_246
L_247
	ld1	{ v0.2s, v1.2s, v2.2s, v3.2s }, [x2], #32
	ld1	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x4], #32
L_248
	st1	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x1], #32
L_249
	uqadd	v28.8b, v0.8b, v4.8b
L_250
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	subs	x0, x0, #8
	b.ge	L_247
L_246
	st1	{ v28.2s, v29.2s, v30.2s, v31.2s }, [x1], #32
L_245
	tst	x0, #0x7
	b.eq	L_251
	tst	x0, #0x4
	b.eq	L_252
	ld1	{ v2.2s, v3.2s }, [x2], #16
	ld1	{ v6.2s, v7.2s }, [x4], #16
L_252
	tst	x0, #0x2
	b.eq	L_253
	ld1	{ v1.2s }, [x2], #8
	ld1	{ v5.2s }, [x4], #8
L_253
	tst	x0, #0x1
	b.eq	L_254
	ld1	{ v0.s }[1], [x2], #4
	ld1	{ v4.s }[1], [x4], #4
L_254
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	tst	x0, #0x4
	b.eq	L_255
	st1	{ v30.2s, v31.2s }, [x1], #16
L_255
	tst	x0, #0x2
	b.eq	L_256
	st1	{ v29.2s }, [x1], #8
L_256
	tst	x0, #0x1
	b.eq	L_257
	st1	{ v28.s }[1], [x1], #4
L_257
L_251
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_235
	tst	x0, #0x7
	b.eq	L_258
	tst	x0, #0x4
	b.eq	L_259
	ld1	{ v2.2s, v3.2s }, [x2], #16
	ld1	{ v6.2s, v7.2s }, [x4], #16
L_259
	tst	x0, #0x2
	b.eq	L_260
	ld1	{ v1.2s }, [x2], #8
	ld1	{ v5.2s }, [x4], #8
L_260
	tst	x0, #0x1
	b.eq	L_261
	ld1	{ v0.s }[1], [x2], #4
	ld1	{ v4.s }[1], [x4], #4
L_261
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	tst	x0, #0x4
	b.eq	L_262
	st1	{ v30.2s, v31.2s }, [x1], #16
L_262
	tst	x0, #0x2
	b.eq	L_263
	st1	{ v29.2s }, [x1], #8
L_263
	tst	x0, #0x1
	b.eq	L_264
	st1	{ v28.s }[1], [x1], #4
L_264
L_258
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_scanline_out_reverse_asm_neon
pixman_composite_scanline_out_reverse_asm_neon
	sxtw	x0, w0
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #64
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	mov	x4, x1
	cmp	x0, #8
	b.lt	L_265
	tst	x4, #0xf
	b.eq	L_266
	tst	x4, #0x4
	b.eq	L_267
	ld1	{ v0.s }[1], [x2], #4
	ld1	{ v4.s }[1], [x4], #4
	sub	x0, x0, #1
L_267
	tst	x4, #0x8
	b.eq	L_268
	ld1	{ v1.2s }, [x2], #8
	ld1	{ v5.2s }, [x4], #8
	sub	x0, x0, #2
L_268
	ld1	{ v2.2s, v3.2s }, [x2], #16
	ld1	{ v6.2s, v7.2s }, [x4], #16
	sub	x0, x0, #4
L_269
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
L_270
L_271
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	tst	x1, #0x4
	b.eq	L_272
	st1	{ v28.s }[1], [x1], #4
L_272
	tst	x1, #0x8
	b.eq	L_273
	st1	{ v29.2s }, [x1], #8
L_273
	st1	{ v30.2s, v31.2s }, [x1], #16
L_274
L_266
	subs	x0, x0, #8
	b.lt	L_275
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x4], #32
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], #32
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	subs	x0, x0, #8
	b.lt	L_276
L_277
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x4], #32
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
L_278
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], #32
	mvn	v22.8b, v3.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x1], #32
L_279
	umull	v8.8h, v22.8b, v4.8b
L_280
	umull	v9.8h, v22.8b, v5.8b
L_281
	umull	v10.8h, v22.8b, v6.8b
L_282
	umull	v11.8h, v22.8b, v7.8b
	subs	x0, x0, #8
	b.ge	L_277
L_276
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x1], #32
L_275
	tst	x0, #0x7
	b.eq	L_283
	tst	x0, #0x4
	b.eq	L_284
	ld1	{ v2.2s, v3.2s }, [x2], #16
	ld1	{ v6.2s, v7.2s }, [x4], #16
L_284
	tst	x0, #0x2
	b.eq	L_285
	ld1	{ v1.2s }, [x2], #8
	ld1	{ v5.2s }, [x4], #8
L_285
	tst	x0, #0x1
	b.eq	L_286
	ld1	{ v0.s }[1], [x2], #4
	ld1	{ v4.s }[1], [x4], #4
L_286
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	tst	x0, #0x4
	b.eq	L_287
	st1	{ v30.2s, v31.2s }, [x1], #16
L_287
	tst	x0, #0x2
	b.eq	L_288
	st1	{ v29.2s }, [x1], #8
L_288
	tst	x0, #0x1
	b.eq	L_289
	st1	{ v28.s }[1], [x1], #4
L_289
L_283
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_265
	tst	x0, #0x7
	b.eq	L_290
	tst	x0, #0x4
	b.eq	L_291
	ld1	{ v2.2s, v3.2s }, [x2], #16
	ld1	{ v6.2s, v7.2s }, [x4], #16
L_291
	tst	x0, #0x2
	b.eq	L_292
	ld1	{ v1.2s }, [x2], #8
	ld1	{ v5.2s }, [x4], #8
L_292
	tst	x0, #0x1
	b.eq	L_293
	ld1	{ v0.s }[1], [x2], #4
	ld1	{ v4.s }[1], [x4], #4
L_293
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	tst	x0, #0x4
	b.eq	L_294
	st1	{ v30.2s, v31.2s }, [x1], #16
L_294
	tst	x0, #0x2
	b.eq	L_295
	st1	{ v29.2s }, [x1], #8
L_295
	tst	x0, #0x1
	b.eq	L_296
	st1	{ v28.s }[1], [x1], #4
L_296
L_290
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_over_8888_8888_asm_neon
pixman_composite_over_8888_8888_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_297
	cmp	x0, #16
	b.lt	L_298
L_299
	tst	x8, #0xf
	b.eq	L_300
	tst	x8, #0x4
	b.eq	L_301
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
	sub	x0, x0, #1
L_301
	tst	x8, #0x8
	b.eq	L_302
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
	sub	x0, x0, #2
L_302
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
	sub	x0, x0, #4
L_303
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_304
	add	x10, x10, #8
	sub	x9, x9, #1
L_304
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_305
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_305
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_305
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x2, #0x4
	b.eq	L_306
	st1	{ v28.s }[1], [x2], #4
L_306
	tst	x2, #0x8
	b.eq	L_307
	st1	{ v29.2s }, [x2], #8
L_307
	st1	{ v30.2s, v31.2s }, [x2], #16
L_308
L_300
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	add	x10, x10, #8
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_309
	add	x10, x10, #8
	sub	x9, x9, #1
L_309
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_310
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_310
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_310
	subs	x0, x0, #16
	b.lt	L_311
L_312
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	urshr	v14.8h, v8.8h, #8
	add	x10, x10, #8
	tst	x9, #0xf
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	b.eq	L_313
	add	x10, x10, #8
	sub	x9, x9, #1
L_313
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	cmp	x10, x14
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	mvn	v22.8b, v3.8b
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	b.le	L_314
	sub	x10, x10, x14
L_314
	umull	v8.8h, v22.8b, v4.8b
	b.le	L_315
	subs	x9, x9, #16
L_315
	umull	v9.8h, v22.8b, v5.8b
	b.le	L_316
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
L_316
	umull	v10.8h, v22.8b, v6.8b
	b.le	L_317
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_317
	umull	v11.8h, v22.8b, v7.8b
	subs	x0, x0, #8
	b.ge	L_312
L_311
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	tst	x0, #0x7
	b.eq	L_318
	tst	x0, #0x4
	b.eq	L_319
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
L_319
	tst	x0, #0x2
	b.eq	L_320
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
L_320
	tst	x0, #0x1
	b.eq	L_321
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
L_321
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_322
	add	x10, x10, #8
	sub	x9, x9, #1
L_322
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_323
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_323
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_323
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_324
	st1	{ v30.2s, v31.2s }, [x2], #16
L_324
	tst	x0, #0x2
	b.eq	L_325
	st1	{ v29.2s }, [x2], #8
L_325
	tst	x0, #0x1
	b.eq	L_326
	st1	{ v28.s }[1], [x2], #4
L_326
L_318
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_299
L_327
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_298
	lsl	x15, x5, #2
	prfm	pldl1keep, [x4, x15]
	lsl	x15, x3, #2
	prfm	pldl1keep, [x8, x15]
	tst	x0, #0x8
	b.eq	L_328
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
L_328
	tst	x0, #0x7
	b.eq	L_329
	tst	x0, #0x4
	b.eq	L_330
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v6.2s, v7.2s }, [x8], #16
L_330
	tst	x0, #0x2
	b.eq	L_331
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v5.2s }, [x8], #8
L_331
	tst	x0, #0x1
	b.eq	L_332
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v4.s }[1], [x8], #4
L_332
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_333
	st1	{ v30.2s, v31.2s }, [x2], #16
L_333
	tst	x0, #0x2
	b.eq	L_334
	st1	{ v29.2s }, [x2], #8
L_334
	tst	x0, #0x1
	b.eq	L_335
	st1	{ v28.s }[1], [x2], #4
L_335
L_329
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_298
L_297
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_scanline_over_asm_neon
pixman_composite_scanline_over_asm_neon
	sxtw	x0, w0
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #64
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	mov	x4, x1
	cmp	x0, #8
	b.lt	L_336
	tst	x4, #0xf
	b.eq	L_337
	tst	x4, #0x4
	b.eq	L_338
	ld1	{ v0.s }[1], [x2], #4
	ld1	{ v4.s }[1], [x4], #4
	sub	x0, x0, #1
L_338
	tst	x4, #0x8
	b.eq	L_339
	ld1	{ v1.2s }, [x2], #8
	ld1	{ v5.2s }, [x4], #8
	sub	x0, x0, #2
L_339
	ld1	{ v2.2s, v3.2s }, [x2], #16
	ld1	{ v6.2s, v7.2s }, [x4], #16
	sub	x0, x0, #4
L_340
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
L_341
L_342
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	tst	x1, #0x4
	b.eq	L_343
	st1	{ v28.s }[1], [x1], #4
L_343
	tst	x1, #0x8
	b.eq	L_344
	st1	{ v29.2s }, [x1], #8
L_344
	st1	{ v30.2s, v31.2s }, [x1], #16
L_345
L_337
	subs	x0, x0, #8
	b.lt	L_346
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x4], #32
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], #32
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	subs	x0, x0, #8
	b.lt	L_347
L_348
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x4], #32
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
L_349
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], #32
	mvn	v22.8b, v3.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x1], #32
L_350
	umull	v8.8h, v22.8b, v4.8b
L_351
	umull	v9.8h, v22.8b, v5.8b
L_352
	umull	v10.8h, v22.8b, v6.8b
L_353
	umull	v11.8h, v22.8b, v7.8b
	subs	x0, x0, #8
	b.ge	L_348
L_347
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x1], #32
L_346
	tst	x0, #0x7
	b.eq	L_354
	tst	x0, #0x4
	b.eq	L_355
	ld1	{ v2.2s, v3.2s }, [x2], #16
	ld1	{ v6.2s, v7.2s }, [x4], #16
L_355
	tst	x0, #0x2
	b.eq	L_356
	ld1	{ v1.2s }, [x2], #8
	ld1	{ v5.2s }, [x4], #8
L_356
	tst	x0, #0x1
	b.eq	L_357
	ld1	{ v0.s }[1], [x2], #4
	ld1	{ v4.s }[1], [x4], #4
L_357
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	tst	x0, #0x4
	b.eq	L_358
	st1	{ v30.2s, v31.2s }, [x1], #16
L_358
	tst	x0, #0x2
	b.eq	L_359
	st1	{ v29.2s }, [x1], #8
L_359
	tst	x0, #0x1
	b.eq	L_360
	st1	{ v28.s }[1], [x1], #4
L_360
L_354
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_336
	tst	x0, #0x7
	b.eq	L_361
	tst	x0, #0x4
	b.eq	L_362
	ld1	{ v2.2s, v3.2s }, [x2], #16
	ld1	{ v6.2s, v7.2s }, [x4], #16
L_362
	tst	x0, #0x2
	b.eq	L_363
	ld1	{ v1.2s }, [x2], #8
	ld1	{ v5.2s }, [x4], #8
L_363
	tst	x0, #0x1
	b.eq	L_364
	ld1	{ v0.s }[1], [x2], #4
	ld1	{ v4.s }[1], [x4], #4
L_364
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	tst	x0, #0x4
	b.eq	L_365
	st1	{ v30.2s, v31.2s }, [x1], #16
L_365
	tst	x0, #0x2
	b.eq	L_366
	st1	{ v29.2s }, [x1], #8
L_366
	tst	x0, #0x1
	b.eq	L_367
	st1	{ v28.s }[1], [x1], #4
L_367
L_361
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_over_n_8888_asm_neon
pixman_composite_over_n_8888_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	mov	v3.s[0], w4
	dup	v0.8b, v3.b[0]
	dup	v1.8b, v3.b[1]
	dup	v2.8b, v3.b[2]
	dup	v3.8b, v3.b[3]
	mvn	v24.8b, v3.8b
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_368
	cmp	x0, #16
	b.lt	L_369
L_370
	tst	x8, #0xf
	b.eq	L_371
	tst	x8, #0x4
	b.eq	L_372
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
	sub	x0, x0, #1
L_372
	tst	x8, #0x8
	b.eq	L_373
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
	sub	x0, x0, #2
L_373
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
	sub	x0, x0, #4
L_374
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_375
	add	x10, x10, #8
	sub	x9, x9, #1
L_375
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_376
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_376
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_376
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x2, #0x4
	b.eq	L_377
	st1	{ v28.s }[1], [x2], #4
L_377
	tst	x2, #0x8
	b.eq	L_378
	st1	{ v29.2s }, [x2], #8
L_378
	st1	{ v30.2s, v31.2s }, [x2], #16
L_379
L_371
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	add	x10, x10, #8
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_380
	add	x10, x10, #8
	sub	x9, x9, #1
L_380
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_381
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_381
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_381
	subs	x0, x0, #16
	b.lt	L_382
L_383
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	uqadd	v28.8b, v0.8b, v28.8b
	add	x10, x10, #8
	tst	x9, #0xf
	b.eq	L_384
	add	x10, x10, #8
	sub	x9, x9, #1
L_384
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	cmp	x10, x14
	umull	v8.8h, v24.8b, v4.8b
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	umull	v9.8h, v24.8b, v5.8b
	b.le	L_385
	sub	x10, x10, x14
L_385
	umull	v10.8h, v24.8b, v6.8b
	subs	x9, x9, #16
	umull	v11.8h, v24.8b, v7.8b
	b.le	L_386
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_386
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	subs	x0, x0, #8
	b.ge	L_383
L_382
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	tst	x0, #0x7
	b.eq	L_387
	tst	x0, #0x4
	b.eq	L_388
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
L_388
	tst	x0, #0x2
	b.eq	L_389
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
L_389
	tst	x0, #0x1
	b.eq	L_390
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
L_390
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_391
	add	x10, x10, #8
	sub	x9, x9, #1
L_391
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_392
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_392
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_392
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_393
	st1	{ v30.2s, v31.2s }, [x2], #16
L_393
	tst	x0, #0x2
	b.eq	L_394
	st1	{ v29.2s }, [x2], #8
L_394
	tst	x0, #0x1
	b.eq	L_395
	st1	{ v28.s }[1], [x2], #4
L_395
L_387
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	sub	x2, x2, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_370
L_396
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_369
	lsl	x15, x3, #2
	prfm	pldl1keep, [x8, x15]
	tst	x0, #0x8
	b.eq	L_397
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
L_397
	tst	x0, #0x7
	b.eq	L_398
	tst	x0, #0x4
	b.eq	L_399
	ld1	{ v6.2s, v7.2s }, [x8], #16
L_399
	tst	x0, #0x2
	b.eq	L_400
	ld1	{ v5.2s }, [x8], #8
L_400
	tst	x0, #0x1
	b.eq	L_401
	ld1	{ v4.s }[1], [x8], #4
L_401
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_402
	st1	{ v30.2s, v31.2s }, [x2], #16
L_402
	tst	x0, #0x2
	b.eq	L_403
	st1	{ v29.2s }, [x2], #8
L_403
	tst	x0, #0x1
	b.eq	L_404
	st1	{ v28.s }[1], [x2], #4
L_404
L_398
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	sub	x2, x2, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_369
L_368
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_over_reverse_n_8888_asm_neon
pixman_composite_over_reverse_n_8888_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	mov	v7.s[0], w4
	dup	v4.8b, v7.b[0]
	dup	v5.8b, v7.b[1]
	dup	v6.8b, v7.b[2]
	dup	v7.8b, v7.b[3]
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_405
	cmp	x0, #16
	b.lt	L_406
L_407
	tst	x8, #0xf
	b.eq	L_408
	tst	x8, #0x4
	b.eq	L_409
	ld1	{ v0.s }[1], [x8], #4
	add	x10, x10, #1
	sub	x0, x0, #1
L_409
	tst	x8, #0x8
	b.eq	L_410
	ld1	{ v1.2s }, [x8], #8
	add	x10, x10, #2
	sub	x0, x0, #2
L_410
	ld1	{ v2.2s, v3.2s }, [x8], #16
	add	x10, x10, #4
	sub	x0, x0, #4
L_411
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_412
	add	x10, x10, #8
	sub	x9, x9, #1
L_412
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_413
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_413
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_413
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x2, #0x4
	b.eq	L_414
	st1	{ v28.s }[1], [x2], #4
L_414
	tst	x2, #0x8
	b.eq	L_415
	st1	{ v29.2s }, [x2], #8
L_415
	st1	{ v30.2s, v31.2s }, [x2], #16
L_416
L_408
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x8], #32
	add	x10, x10, #8
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_417
	add	x10, x10, #8
	sub	x9, x9, #1
L_417
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_418
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_418
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_418
	subs	x0, x0, #16
	b.lt	L_419
L_420
	urshr	v14.8h, v8.8h, #8
	add	x10, x10, #8
	tst	x9, #0xf
	urshr	v15.8h, v9.8h, #8
	urshr	v12.8h, v10.8h, #8
	urshr	v13.8h, v11.8h, #8
	b.eq	L_421
	add	x10, x10, #8
	sub	x9, x9, #1
L_421
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	cmp	x10, x14
	raddhn	v30.8b, v12.8h, v10.8h
	raddhn	v31.8b, v13.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x8], #32
	mvn	v22.8b, v3.8b
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	b.lt	L_422
	sub	x10, x10, x14
L_422
	umull	v8.8h, v22.8b, v4.8b
	b.lt	L_423
	subs	x9, x9, #16
L_423
	umull	v9.8h, v22.8b, v5.8b
	umull	v10.8h, v22.8b, v6.8b
	b.lt	L_424
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_424
	umull	v11.8h, v22.8b, v7.8b
	subs	x0, x0, #8
	b.ge	L_420
L_419
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	tst	x0, #0x7
	b.eq	L_425
	tst	x0, #0x4
	b.eq	L_426
	ld1	{ v2.2s, v3.2s }, [x8], #16
	add	x10, x10, #4
L_426
	tst	x0, #0x2
	b.eq	L_427
	ld1	{ v1.2s }, [x8], #8
	add	x10, x10, #2
L_427
	tst	x0, #0x1
	b.eq	L_428
	ld1	{ v0.s }[1], [x8], #4
	add	x10, x10, #1
L_428
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_429
	add	x10, x10, #8
	sub	x9, x9, #1
L_429
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_430
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_430
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_430
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_431
	st1	{ v30.2s, v31.2s }, [x2], #16
L_431
	tst	x0, #0x2
	b.eq	L_432
	st1	{ v29.2s }, [x2], #8
L_432
	tst	x0, #0x1
	b.eq	L_433
	st1	{ v28.s }[1], [x2], #4
L_433
L_425
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	sub	x2, x2, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_407
L_434
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_406
	lsl	x15, x3, #2
	prfm	pldl1keep, [x8, x15]
	tst	x0, #0x8
	b.eq	L_435
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x8], #32
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
L_435
	tst	x0, #0x7
	b.eq	L_436
	tst	x0, #0x4
	b.eq	L_437
	ld1	{ v2.2s, v3.2s }, [x8], #16
L_437
	tst	x0, #0x2
	b.eq	L_438
	ld1	{ v1.2s }, [x8], #8
L_438
	tst	x0, #0x1
	b.eq	L_439
	ld1	{ v0.s }[1], [x8], #4
L_439
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_440
	st1	{ v30.2s, v31.2s }, [x2], #16
L_440
	tst	x0, #0x2
	b.eq	L_441
	st1	{ v29.2s }, [x2], #8
L_441
	tst	x0, #0x1
	b.eq	L_442
	st1	{ v28.s }[1], [x2], #4
L_442
L_436
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	sub	x2, x2, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_406
L_405
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_over_8888_8_0565_asm_neon
pixman_composite_over_8888_8_0565_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_443
	cmp	x0, #16
	b.lt	L_444
L_445
	tst	x8, #0xf
	b.eq	L_446
	tst	x8, #0x2
	b.eq	L_447
	ld1	{ v8.s }[1], [x4], #4
	ld1	{ v24.b }[1], [x6], #1
	ld1	{ v4.h }[1], [x8], #2
	add	x10, x10, #1
	sub	x0, x0, #1
L_447
	tst	x8, #0x4
	b.eq	L_448
	ld1	{ v9.2s }, [x4], #8
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	ld1	{ v4.h }[2], [x8], #2
	ld1	{ v4.h }[3], [x8], #2
	add	x10, x10, #2
	sub	x0, x0, #2
L_448
	tst	x8, #0x8
	b.eq	L_449
	ld1	{ v10.2s, v11.2s }, [x4], #16
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	ld1	{ v5.4h }, [x8], #8
	add	x10, x10, #4
	sub	x0, x0, #4
L_449
	umov	x15, v16.d[0]
	uzp1	v16.8b, v8.8b, v9.8b
	uzp2	v9.8b, v8.8b, v9.8b
	mov	v8.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v10.8b, v11.8b
	uzp2	v11.8b, v10.8b, v11.8b
	mov	v10.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v9.8b, v11.8b
	uzp2	v11.8b, v9.8b, v11.8b
	mov	v9.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v8.8b, v10.8b
	uzp2	v10.8b, v8.8b, v10.8b
	mov	v8.8b, v16.8b
	mov	v16.d[0], x15
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v24.8b, v9.8b
	umull	v2.8h, v24.8b, v10.8b
	umull	v3.8h, v24.8b, v11.8b
	mov	v4.d[1], v5.d[0]
	shrn	v25.8b, v4.8h, #8
	shrn	v26.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	urshr	v17.8h, v0.8h, #8
	urshr	v18.8h, v1.8h, #8
	urshr	v19.8h, v2.8h, #8
	urshr	v20.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v17.8h
	raddhn	v1.8b, v1.8h, v18.8h
	raddhn	v2.8b, v2.8h, v19.8h
	raddhn	v3.8b, v3.8h, v20.8h
	sri	v25.8b, v25.8b, #5
	sri	v26.8b, v26.8b, #6
	mvn	v3.8b, v3.8b
	shrn	v30.8b, v4.8h, #2
	umull	v18.8h, v3.8b, v25.8b
	umull	v19.8h, v3.8b, v26.8b
	umull	v20.8h, v3.8b, v30.8b
	tst	x9, #0xf
	b.eq	L_450
	add	x10, x10, #8
	sub	x9, x9, #1
L_450
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_451
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_451
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_451
	urshr	v5.8h, v18.8h, #8
	urshr	v6.8h, v19.8h, #8
	urshr	v7.8h, v20.8h, #8
	raddhn	v17.8b, v18.8h, v5.8h
	raddhn	v19.8b, v19.8h, v6.8h
	raddhn	v18.8b, v20.8h, v7.8h
	uqadd	v5.8b, v2.8b, v17.8b
	uqadd	v6.8b, v0.8b, v18.8b
	uqadd	v7.8b, v1.8b, v19.8b
	ushll	v14.8h, v5.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v7.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v6.8b, #7
	sli	v19.8h, v19.8h, #1
	sri	v14.8h, v18.8h, #5
	sri	v14.8h, v19.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x2, #0x2
	b.eq	L_452
	st1	{ v28.h }[1], [x2], #2
L_452
	tst	x2, #0x4
	b.eq	L_453
	st1	{ v28.s }[1], [x2], #4
L_453
	tst	x2, #0x8
	b.eq	L_454
	st1	{ v29.4h }, [x2], #8
L_454
L_446
	ld1	{ v4.4h, v5.4h }, [x8], #16
	ld4	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x4], #32
	ld1	{ v24.8b }, [x6], #8
	add	x10, x10, #8
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v24.8b, v9.8b
	umull	v2.8h, v24.8b, v10.8b
	umull	v3.8h, v24.8b, v11.8b
	mov	v4.d[1], v5.d[0]
	shrn	v25.8b, v4.8h, #8
	shrn	v26.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	urshr	v17.8h, v0.8h, #8
	urshr	v18.8h, v1.8h, #8
	urshr	v19.8h, v2.8h, #8
	urshr	v20.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v17.8h
	raddhn	v1.8b, v1.8h, v18.8h
	raddhn	v2.8b, v2.8h, v19.8h
	raddhn	v3.8b, v3.8h, v20.8h
	sri	v25.8b, v25.8b, #5
	sri	v26.8b, v26.8b, #6
	mvn	v3.8b, v3.8b
	shrn	v30.8b, v4.8h, #2
	umull	v18.8h, v3.8b, v25.8b
	umull	v19.8h, v3.8b, v26.8b
	umull	v20.8h, v3.8b, v30.8b
	tst	x9, #0xf
	b.eq	L_455
	add	x10, x10, #8
	sub	x9, x9, #1
L_455
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_456
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_456
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_456
	subs	x0, x0, #16
	b.lt	L_457
L_458
	urshr	v5.8h, v18.8h, #8
	urshr	v6.8h, v19.8h, #8
	urshr	v7.8h, v20.8h, #8
	raddhn	v17.8b, v18.8h, v5.8h
	raddhn	v19.8b, v19.8h, v6.8h
	raddhn	v18.8b, v20.8h, v7.8h
	uqadd	v5.8b, v2.8b, v17.8b
	uqadd	v6.8b, v0.8b, v18.8b
	uqadd	v7.8b, v1.8b, v19.8b
	ushll	v14.8h, v5.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v7.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v6.8b, #7
	sli	v19.8h, v19.8h, #1
	sri	v14.8h, v18.8h, #5
	sri	v14.8h, v19.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
	ld1	{ v4.4h, v5.4h }, [x8], #16
	ld1	{ v24.8b }, [x6], #8
	ld4	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x4], #32
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v24.8b, v9.8b
	umull	v2.8h, v24.8b, v10.8b
	umull	v3.8h, v24.8b, v11.8b
	mov	v4.d[1], v5.d[0]
	shrn	v25.8b, v4.8h, #8
	shrn	v26.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	urshr	v17.8h, v0.8h, #8
	urshr	v18.8h, v1.8h, #8
	urshr	v19.8h, v2.8h, #8
	urshr	v20.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v17.8h
	raddhn	v1.8b, v1.8h, v18.8h
	raddhn	v2.8b, v2.8h, v19.8h
	raddhn	v3.8b, v3.8h, v20.8h
	sri	v25.8b, v25.8b, #5
	sri	v26.8b, v26.8b, #6
	mvn	v3.8b, v3.8b
	shrn	v30.8b, v4.8h, #2
	umull	v18.8h, v3.8b, v25.8b
	umull	v19.8h, v3.8b, v26.8b
	umull	v20.8h, v3.8b, v30.8b
	subs	x0, x0, #8
	b.ge	L_458
L_457
	urshr	v5.8h, v18.8h, #8
	urshr	v6.8h, v19.8h, #8
	urshr	v7.8h, v20.8h, #8
	raddhn	v17.8b, v18.8h, v5.8h
	raddhn	v19.8b, v19.8h, v6.8h
	raddhn	v18.8b, v20.8h, v7.8h
	uqadd	v5.8b, v2.8b, v17.8b
	uqadd	v6.8b, v0.8b, v18.8b
	uqadd	v7.8b, v1.8b, v19.8b
	ushll	v14.8h, v5.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v7.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v6.8b, #7
	sli	v19.8h, v19.8h, #1
	sri	v14.8h, v18.8h, #5
	sri	v14.8h, v19.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
	tst	x0, #0x7
	b.eq	L_459
	tst	x0, #0x4
	b.eq	L_460
	ld1	{ v10.2s, v11.2s }, [x4], #16
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	ld1	{ v5.4h }, [x8], #8
	add	x10, x10, #4
L_460
	tst	x0, #0x2
	b.eq	L_461
	ld1	{ v9.2s }, [x4], #8
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	ld1	{ v4.h }[2], [x8], #2
	ld1	{ v4.h }[3], [x8], #2
	add	x10, x10, #2
L_461
	tst	x0, #0x1
	b.eq	L_462
	ld1	{ v8.s }[1], [x4], #4
	ld1	{ v24.b }[1], [x6], #1
	ld1	{ v4.h }[1], [x8], #2
	add	x10, x10, #1
L_462
	umov	x15, v16.d[0]
	uzp1	v16.8b, v8.8b, v9.8b
	uzp2	v9.8b, v8.8b, v9.8b
	mov	v8.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v10.8b, v11.8b
	uzp2	v11.8b, v10.8b, v11.8b
	mov	v10.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v9.8b, v11.8b
	uzp2	v11.8b, v9.8b, v11.8b
	mov	v9.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v8.8b, v10.8b
	uzp2	v10.8b, v8.8b, v10.8b
	mov	v8.8b, v16.8b
	mov	v16.d[0], x15
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v24.8b, v9.8b
	umull	v2.8h, v24.8b, v10.8b
	umull	v3.8h, v24.8b, v11.8b
	mov	v4.d[1], v5.d[0]
	shrn	v25.8b, v4.8h, #8
	shrn	v26.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	urshr	v17.8h, v0.8h, #8
	urshr	v18.8h, v1.8h, #8
	urshr	v19.8h, v2.8h, #8
	urshr	v20.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v17.8h
	raddhn	v1.8b, v1.8h, v18.8h
	raddhn	v2.8b, v2.8h, v19.8h
	raddhn	v3.8b, v3.8h, v20.8h
	sri	v25.8b, v25.8b, #5
	sri	v26.8b, v26.8b, #6
	mvn	v3.8b, v3.8b
	shrn	v30.8b, v4.8h, #2
	umull	v18.8h, v3.8b, v25.8b
	umull	v19.8h, v3.8b, v26.8b
	umull	v20.8h, v3.8b, v30.8b
	tst	x9, #0xf
	b.eq	L_463
	add	x10, x10, #8
	sub	x9, x9, #1
L_463
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_464
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_464
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_464
	urshr	v5.8h, v18.8h, #8
	urshr	v6.8h, v19.8h, #8
	urshr	v7.8h, v20.8h, #8
	raddhn	v17.8b, v18.8h, v5.8h
	raddhn	v19.8b, v19.8h, v6.8h
	raddhn	v18.8b, v20.8h, v7.8h
	uqadd	v5.8b, v2.8b, v17.8b
	uqadd	v6.8b, v0.8b, v18.8b
	uqadd	v7.8b, v1.8b, v19.8b
	ushll	v14.8h, v5.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v7.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v6.8b, #7
	sli	v19.8h, v19.8h, #1
	sri	v14.8h, v18.8h, #5
	sri	v14.8h, v19.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_465
	st1	{ v29.4h }, [x2], #8
L_465
	tst	x0, #0x2
	b.eq	L_466
	st1	{ v28.s }[1], [x2], #4
L_466
	tst	x0, #0x1
	b.eq	L_467
	st1	{ v28.h }[1], [x2], #2
L_467
L_459
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x4, x4, x5, lsl #2
	add	x6, x6, x7
	sub	x2, x2, x0, lsl #1
	sub	x4, x4, x0, lsl #2
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_445
L_468
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_444
	lsl	x15, x5, #2
	prfm	pldl1keep, [x4, x15]
	lsl	x15, x3, #1
	prfm	pldl1keep, [x8, x15]
	lsr	x15, x7, #0
	prfm	pldl1keep, [x6, x15]
	tst	x0, #0x8
	b.eq	L_469
	ld1	{ v4.4h, v5.4h }, [x8], #16
	ld4	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x4], #32
	ld1	{ v24.8b }, [x6], #8
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v24.8b, v9.8b
	umull	v2.8h, v24.8b, v10.8b
	umull	v3.8h, v24.8b, v11.8b
	mov	v4.d[1], v5.d[0]
	shrn	v25.8b, v4.8h, #8
	shrn	v26.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	urshr	v17.8h, v0.8h, #8
	urshr	v18.8h, v1.8h, #8
	urshr	v19.8h, v2.8h, #8
	urshr	v20.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v17.8h
	raddhn	v1.8b, v1.8h, v18.8h
	raddhn	v2.8b, v2.8h, v19.8h
	raddhn	v3.8b, v3.8h, v20.8h
	sri	v25.8b, v25.8b, #5
	sri	v26.8b, v26.8b, #6
	mvn	v3.8b, v3.8b
	shrn	v30.8b, v4.8h, #2
	umull	v18.8h, v3.8b, v25.8b
	umull	v19.8h, v3.8b, v26.8b
	umull	v20.8h, v3.8b, v30.8b
	urshr	v5.8h, v18.8h, #8
	urshr	v6.8h, v19.8h, #8
	urshr	v7.8h, v20.8h, #8
	raddhn	v17.8b, v18.8h, v5.8h
	raddhn	v19.8b, v19.8h, v6.8h
	raddhn	v18.8b, v20.8h, v7.8h
	uqadd	v5.8b, v2.8b, v17.8b
	uqadd	v6.8b, v0.8b, v18.8b
	uqadd	v7.8b, v1.8b, v19.8b
	ushll	v14.8h, v5.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v7.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v6.8b, #7
	sli	v19.8h, v19.8h, #1
	sri	v14.8h, v18.8h, #5
	sri	v14.8h, v19.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
L_469
	tst	x0, #0x7
	b.eq	L_470
	tst	x0, #0x4
	b.eq	L_471
	ld1	{ v10.2s, v11.2s }, [x4], #16
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	ld1	{ v5.4h }, [x8], #8
L_471
	tst	x0, #0x2
	b.eq	L_472
	ld1	{ v9.2s }, [x4], #8
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	ld1	{ v4.h }[2], [x8], #2
	ld1	{ v4.h }[3], [x8], #2
L_472
	tst	x0, #0x1
	b.eq	L_473
	ld1	{ v8.s }[1], [x4], #4
	ld1	{ v24.b }[1], [x6], #1
	ld1	{ v4.h }[1], [x8], #2
L_473
	umov	x15, v16.d[0]
	uzp1	v16.8b, v8.8b, v9.8b
	uzp2	v9.8b, v8.8b, v9.8b
	mov	v8.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v10.8b, v11.8b
	uzp2	v11.8b, v10.8b, v11.8b
	mov	v10.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v9.8b, v11.8b
	uzp2	v11.8b, v9.8b, v11.8b
	mov	v9.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v8.8b, v10.8b
	uzp2	v10.8b, v8.8b, v10.8b
	mov	v8.8b, v16.8b
	mov	v16.d[0], x15
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v24.8b, v9.8b
	umull	v2.8h, v24.8b, v10.8b
	umull	v3.8h, v24.8b, v11.8b
	mov	v4.d[1], v5.d[0]
	shrn	v25.8b, v4.8h, #8
	shrn	v26.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	urshr	v17.8h, v0.8h, #8
	urshr	v18.8h, v1.8h, #8
	urshr	v19.8h, v2.8h, #8
	urshr	v20.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v17.8h
	raddhn	v1.8b, v1.8h, v18.8h
	raddhn	v2.8b, v2.8h, v19.8h
	raddhn	v3.8b, v3.8h, v20.8h
	sri	v25.8b, v25.8b, #5
	sri	v26.8b, v26.8b, #6
	mvn	v3.8b, v3.8b
	shrn	v30.8b, v4.8h, #2
	umull	v18.8h, v3.8b, v25.8b
	umull	v19.8h, v3.8b, v26.8b
	umull	v20.8h, v3.8b, v30.8b
	urshr	v5.8h, v18.8h, #8
	urshr	v6.8h, v19.8h, #8
	urshr	v7.8h, v20.8h, #8
	raddhn	v17.8b, v18.8h, v5.8h
	raddhn	v19.8b, v19.8h, v6.8h
	raddhn	v18.8b, v20.8h, v7.8h
	uqadd	v5.8b, v2.8b, v17.8b
	uqadd	v6.8b, v0.8b, v18.8b
	uqadd	v7.8b, v1.8b, v19.8b
	ushll	v14.8h, v5.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v7.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v6.8b, #7
	sli	v19.8h, v19.8h, #1
	sri	v14.8h, v18.8h, #5
	sri	v14.8h, v19.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_474
	st1	{ v29.4h }, [x2], #8
L_474
	tst	x0, #0x2
	b.eq	L_475
	st1	{ v28.h }[2], [x2], #2
	st1	{ v28.h }[3], [x2], #2
L_475
	tst	x0, #0x1
	b.eq	L_476
	st1	{ v28.h }[1], [x2], #2
L_476
L_470
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x4, x4, x5, lsl #2
	add	x6, x6, x7
	sub	x2, x2, x0, lsl #1
	sub	x4, x4, x0, lsl #2
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_444
L_443
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_over_n_8_0565_asm_neon
pixman_composite_over_n_8_0565_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	mov	v11.s[0], w4
	dup	v8.8b, v11.b[0]
	dup	v9.8b, v11.b[1]
	dup	v10.8b, v11.b[2]
	dup	v11.8b, v11.b[3]
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_477
	cmp	x0, #16
	b.lt	L_478
L_479
	tst	x8, #0xf
	b.eq	L_480
	tst	x8, #0x2
	b.eq	L_481
	ld1	{ v24.b }[1], [x6], #1
	ld1	{ v4.h }[1], [x8], #2
	add	x10, x10, #1
	sub	x0, x0, #1
L_481
	tst	x8, #0x4
	b.eq	L_482
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	ld1	{ v4.h }[2], [x8], #2
	ld1	{ v4.h }[3], [x8], #2
	add	x10, x10, #2
	sub	x0, x0, #2
L_482
	tst	x8, #0x8
	b.eq	L_483
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	ld1	{ v5.4h }, [x8], #8
	add	x10, x10, #4
	sub	x0, x0, #4
L_483
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v24.8b, v9.8b
	umull	v2.8h, v24.8b, v10.8b
	umull	v3.8h, v24.8b, v11.8b
	mov	v4.d[1], v5.d[0]
	shrn	v25.8b, v4.8h, #8
	shrn	v26.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	urshr	v17.8h, v0.8h, #8
	urshr	v18.8h, v1.8h, #8
	urshr	v19.8h, v2.8h, #8
	urshr	v20.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v17.8h
	raddhn	v1.8b, v1.8h, v18.8h
	raddhn	v2.8b, v2.8h, v19.8h
	raddhn	v3.8b, v3.8h, v20.8h
	sri	v25.8b, v25.8b, #5
	sri	v26.8b, v26.8b, #6
	mvn	v3.8b, v3.8b
	shrn	v30.8b, v4.8h, #2
	umull	v18.8h, v3.8b, v25.8b
	umull	v19.8h, v3.8b, v26.8b
	umull	v20.8h, v3.8b, v30.8b
	tst	x9, #0xf
	b.eq	L_484
	add	x10, x10, #8
	sub	x9, x9, #1
L_484
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_485
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_485
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_485
	urshr	v5.8h, v18.8h, #8
	urshr	v6.8h, v19.8h, #8
	urshr	v7.8h, v20.8h, #8
	raddhn	v17.8b, v18.8h, v5.8h
	raddhn	v19.8b, v19.8h, v6.8h
	raddhn	v18.8b, v20.8h, v7.8h
	uqadd	v5.8b, v2.8b, v17.8b
	uqadd	v6.8b, v0.8b, v18.8b
	uqadd	v7.8b, v1.8b, v19.8b
	ushll	v14.8h, v5.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v7.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v6.8b, #7
	sli	v19.8h, v19.8h, #1
	sri	v14.8h, v18.8h, #5
	sri	v14.8h, v19.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x2, #0x2
	b.eq	L_486
	st1	{ v28.h }[1], [x2], #2
L_486
	tst	x2, #0x4
	b.eq	L_487
	st1	{ v28.s }[1], [x2], #4
L_487
	tst	x2, #0x8
	b.eq	L_488
	st1	{ v29.4h }, [x2], #8
L_488
L_480
	ld1	{ v4.4h, v5.4h }, [x8], #16
	ld1	{ v24.8b }, [x6], #8
	add	x10, x10, #8
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v24.8b, v9.8b
	umull	v2.8h, v24.8b, v10.8b
	umull	v3.8h, v24.8b, v11.8b
	mov	v4.d[1], v5.d[0]
	shrn	v25.8b, v4.8h, #8
	shrn	v26.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	urshr	v17.8h, v0.8h, #8
	urshr	v18.8h, v1.8h, #8
	urshr	v19.8h, v2.8h, #8
	urshr	v20.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v17.8h
	raddhn	v1.8b, v1.8h, v18.8h
	raddhn	v2.8b, v2.8h, v19.8h
	raddhn	v3.8b, v3.8h, v20.8h
	sri	v25.8b, v25.8b, #5
	sri	v26.8b, v26.8b, #6
	mvn	v3.8b, v3.8b
	shrn	v30.8b, v4.8h, #2
	umull	v18.8h, v3.8b, v25.8b
	umull	v19.8h, v3.8b, v26.8b
	umull	v20.8h, v3.8b, v30.8b
	tst	x9, #0xf
	b.eq	L_489
	add	x10, x10, #8
	sub	x9, x9, #1
L_489
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_490
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_490
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_490
	subs	x0, x0, #16
	b.lt	L_491
L_492
	urshr	v5.8h, v18.8h, #8
	urshr	v6.8h, v19.8h, #8
	urshr	v7.8h, v20.8h, #8
	raddhn	v17.8b, v18.8h, v5.8h
	raddhn	v19.8b, v19.8h, v6.8h
	raddhn	v18.8b, v20.8h, v7.8h
	uqadd	v5.8b, v2.8b, v17.8b
	uqadd	v6.8b, v0.8b, v18.8b
	uqadd	v7.8b, v1.8b, v19.8b
	ushll	v14.8h, v5.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v7.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v6.8b, #7
	sli	v19.8h, v19.8h, #1
	sri	v14.8h, v18.8h, #5
	sri	v14.8h, v19.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
	ld1	{ v4.4h, v5.4h }, [x8], #16
	ld1	{ v24.8b }, [x6], #8
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v24.8b, v9.8b
	umull	v2.8h, v24.8b, v10.8b
	umull	v3.8h, v24.8b, v11.8b
	mov	v4.d[1], v5.d[0]
	shrn	v25.8b, v4.8h, #8
	shrn	v26.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	urshr	v17.8h, v0.8h, #8
	urshr	v18.8h, v1.8h, #8
	urshr	v19.8h, v2.8h, #8
	urshr	v20.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v17.8h
	raddhn	v1.8b, v1.8h, v18.8h
	raddhn	v2.8b, v2.8h, v19.8h
	raddhn	v3.8b, v3.8h, v20.8h
	sri	v25.8b, v25.8b, #5
	sri	v26.8b, v26.8b, #6
	mvn	v3.8b, v3.8b
	shrn	v30.8b, v4.8h, #2
	umull	v18.8h, v3.8b, v25.8b
	umull	v19.8h, v3.8b, v26.8b
	umull	v20.8h, v3.8b, v30.8b
	subs	x0, x0, #8
	b.ge	L_492
L_491
	urshr	v5.8h, v18.8h, #8
	urshr	v6.8h, v19.8h, #8
	urshr	v7.8h, v20.8h, #8
	raddhn	v17.8b, v18.8h, v5.8h
	raddhn	v19.8b, v19.8h, v6.8h
	raddhn	v18.8b, v20.8h, v7.8h
	uqadd	v5.8b, v2.8b, v17.8b
	uqadd	v6.8b, v0.8b, v18.8b
	uqadd	v7.8b, v1.8b, v19.8b
	ushll	v14.8h, v5.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v7.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v6.8b, #7
	sli	v19.8h, v19.8h, #1
	sri	v14.8h, v18.8h, #5
	sri	v14.8h, v19.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
	tst	x0, #0x7
	b.eq	L_493
	tst	x0, #0x4
	b.eq	L_494
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	ld1	{ v5.4h }, [x8], #8
	add	x10, x10, #4
L_494
	tst	x0, #0x2
	b.eq	L_495
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	ld1	{ v4.h }[2], [x8], #2
	ld1	{ v4.h }[3], [x8], #2
	add	x10, x10, #2
L_495
	tst	x0, #0x1
	b.eq	L_496
	ld1	{ v24.b }[1], [x6], #1
	ld1	{ v4.h }[1], [x8], #2
	add	x10, x10, #1
L_496
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v24.8b, v9.8b
	umull	v2.8h, v24.8b, v10.8b
	umull	v3.8h, v24.8b, v11.8b
	mov	v4.d[1], v5.d[0]
	shrn	v25.8b, v4.8h, #8
	shrn	v26.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	urshr	v17.8h, v0.8h, #8
	urshr	v18.8h, v1.8h, #8
	urshr	v19.8h, v2.8h, #8
	urshr	v20.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v17.8h
	raddhn	v1.8b, v1.8h, v18.8h
	raddhn	v2.8b, v2.8h, v19.8h
	raddhn	v3.8b, v3.8h, v20.8h
	sri	v25.8b, v25.8b, #5
	sri	v26.8b, v26.8b, #6
	mvn	v3.8b, v3.8b
	shrn	v30.8b, v4.8h, #2
	umull	v18.8h, v3.8b, v25.8b
	umull	v19.8h, v3.8b, v26.8b
	umull	v20.8h, v3.8b, v30.8b
	tst	x9, #0xf
	b.eq	L_497
	add	x10, x10, #8
	sub	x9, x9, #1
L_497
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_498
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_498
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_498
	urshr	v5.8h, v18.8h, #8
	urshr	v6.8h, v19.8h, #8
	urshr	v7.8h, v20.8h, #8
	raddhn	v17.8b, v18.8h, v5.8h
	raddhn	v19.8b, v19.8h, v6.8h
	raddhn	v18.8b, v20.8h, v7.8h
	uqadd	v5.8b, v2.8b, v17.8b
	uqadd	v6.8b, v0.8b, v18.8b
	uqadd	v7.8b, v1.8b, v19.8b
	ushll	v14.8h, v5.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v7.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v6.8b, #7
	sli	v19.8h, v19.8h, #1
	sri	v14.8h, v18.8h, #5
	sri	v14.8h, v19.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_499
	st1	{ v29.4h }, [x2], #8
L_499
	tst	x0, #0x2
	b.eq	L_500
	st1	{ v28.s }[1], [x2], #4
L_500
	tst	x0, #0x1
	b.eq	L_501
	st1	{ v28.h }[1], [x2], #2
L_501
L_493
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x6, x6, x7
	sub	x2, x2, x0, lsl #1
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_479
L_502
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_478
	lsl	x15, x3, #1
	prfm	pldl1keep, [x8, x15]
	lsr	x15, x7, #0
	prfm	pldl1keep, [x6, x15]
	tst	x0, #0x8
	b.eq	L_503
	ld1	{ v4.4h, v5.4h }, [x8], #16
	ld1	{ v24.8b }, [x6], #8
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v24.8b, v9.8b
	umull	v2.8h, v24.8b, v10.8b
	umull	v3.8h, v24.8b, v11.8b
	mov	v4.d[1], v5.d[0]
	shrn	v25.8b, v4.8h, #8
	shrn	v26.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	urshr	v17.8h, v0.8h, #8
	urshr	v18.8h, v1.8h, #8
	urshr	v19.8h, v2.8h, #8
	urshr	v20.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v17.8h
	raddhn	v1.8b, v1.8h, v18.8h
	raddhn	v2.8b, v2.8h, v19.8h
	raddhn	v3.8b, v3.8h, v20.8h
	sri	v25.8b, v25.8b, #5
	sri	v26.8b, v26.8b, #6
	mvn	v3.8b, v3.8b
	shrn	v30.8b, v4.8h, #2
	umull	v18.8h, v3.8b, v25.8b
	umull	v19.8h, v3.8b, v26.8b
	umull	v20.8h, v3.8b, v30.8b
	urshr	v5.8h, v18.8h, #8
	urshr	v6.8h, v19.8h, #8
	urshr	v7.8h, v20.8h, #8
	raddhn	v17.8b, v18.8h, v5.8h
	raddhn	v19.8b, v19.8h, v6.8h
	raddhn	v18.8b, v20.8h, v7.8h
	uqadd	v5.8b, v2.8b, v17.8b
	uqadd	v6.8b, v0.8b, v18.8b
	uqadd	v7.8b, v1.8b, v19.8b
	ushll	v14.8h, v5.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v7.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v6.8b, #7
	sli	v19.8h, v19.8h, #1
	sri	v14.8h, v18.8h, #5
	sri	v14.8h, v19.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
L_503
	tst	x0, #0x7
	b.eq	L_504
	tst	x0, #0x4
	b.eq	L_505
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	ld1	{ v5.4h }, [x8], #8
L_505
	tst	x0, #0x2
	b.eq	L_506
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	ld1	{ v4.h }[2], [x8], #2
	ld1	{ v4.h }[3], [x8], #2
L_506
	tst	x0, #0x1
	b.eq	L_507
	ld1	{ v24.b }[1], [x6], #1
	ld1	{ v4.h }[1], [x8], #2
L_507
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v24.8b, v9.8b
	umull	v2.8h, v24.8b, v10.8b
	umull	v3.8h, v24.8b, v11.8b
	mov	v4.d[1], v5.d[0]
	shrn	v25.8b, v4.8h, #8
	shrn	v26.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	urshr	v17.8h, v0.8h, #8
	urshr	v18.8h, v1.8h, #8
	urshr	v19.8h, v2.8h, #8
	urshr	v20.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v17.8h
	raddhn	v1.8b, v1.8h, v18.8h
	raddhn	v2.8b, v2.8h, v19.8h
	raddhn	v3.8b, v3.8h, v20.8h
	sri	v25.8b, v25.8b, #5
	sri	v26.8b, v26.8b, #6
	mvn	v3.8b, v3.8b
	shrn	v30.8b, v4.8h, #2
	umull	v18.8h, v3.8b, v25.8b
	umull	v19.8h, v3.8b, v26.8b
	umull	v20.8h, v3.8b, v30.8b
	urshr	v5.8h, v18.8h, #8
	urshr	v6.8h, v19.8h, #8
	urshr	v7.8h, v20.8h, #8
	raddhn	v17.8b, v18.8h, v5.8h
	raddhn	v19.8b, v19.8h, v6.8h
	raddhn	v18.8b, v20.8h, v7.8h
	uqadd	v5.8b, v2.8b, v17.8b
	uqadd	v6.8b, v0.8b, v18.8b
	uqadd	v7.8b, v1.8b, v19.8b
	ushll	v14.8h, v5.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v7.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v6.8b, #7
	sli	v19.8h, v19.8h, #1
	sri	v14.8h, v18.8h, #5
	sri	v14.8h, v19.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_508
	st1	{ v29.4h }, [x2], #8
L_508
	tst	x0, #0x2
	b.eq	L_509
	st1	{ v28.h }[2], [x2], #2
	st1	{ v28.h }[3], [x2], #2
L_509
	tst	x0, #0x1
	b.eq	L_510
	st1	{ v28.h }[1], [x2], #2
L_510
L_504
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x6, x6, x7
	sub	x2, x2, x0, lsl #1
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_478
L_477
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_over_8888_n_0565_asm_neon
pixman_composite_over_8888_n_0565_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	mov	v24.s[0], w6
	dup	v24.8b, v24.b[3]
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_511
	cmp	x0, #16
	b.lt	L_512
L_513
	tst	x8, #0xf
	b.eq	L_514
	tst	x8, #0x2
	b.eq	L_515
	ld1	{ v8.s }[1], [x4], #4
	ld1	{ v4.h }[1], [x8], #2
	add	x10, x10, #1
	sub	x0, x0, #1
L_515
	tst	x8, #0x4
	b.eq	L_516
	ld1	{ v9.2s }, [x4], #8
	ld1	{ v4.h }[2], [x8], #2
	ld1	{ v4.h }[3], [x8], #2
	add	x10, x10, #2
	sub	x0, x0, #2
L_516
	tst	x8, #0x8
	b.eq	L_517
	ld1	{ v10.2s, v11.2s }, [x4], #16
	ld1	{ v5.4h }, [x8], #8
	add	x10, x10, #4
	sub	x0, x0, #4
L_517
	umov	x15, v16.d[0]
	uzp1	v16.8b, v8.8b, v9.8b
	uzp2	v9.8b, v8.8b, v9.8b
	mov	v8.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v10.8b, v11.8b
	uzp2	v11.8b, v10.8b, v11.8b
	mov	v10.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v9.8b, v11.8b
	uzp2	v11.8b, v9.8b, v11.8b
	mov	v9.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v8.8b, v10.8b
	uzp2	v10.8b, v8.8b, v10.8b
	mov	v8.8b, v16.8b
	mov	v16.d[0], x15
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v24.8b, v9.8b
	umull	v2.8h, v24.8b, v10.8b
	umull	v3.8h, v24.8b, v11.8b
	mov	v4.d[1], v5.d[0]
	shrn	v25.8b, v4.8h, #8
	shrn	v26.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	urshr	v17.8h, v0.8h, #8
	urshr	v18.8h, v1.8h, #8
	urshr	v19.8h, v2.8h, #8
	urshr	v20.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v17.8h
	raddhn	v1.8b, v1.8h, v18.8h
	raddhn	v2.8b, v2.8h, v19.8h
	raddhn	v3.8b, v3.8h, v20.8h
	sri	v25.8b, v25.8b, #5
	sri	v26.8b, v26.8b, #6
	mvn	v3.8b, v3.8b
	shrn	v30.8b, v4.8h, #2
	umull	v18.8h, v3.8b, v25.8b
	umull	v19.8h, v3.8b, v26.8b
	umull	v20.8h, v3.8b, v30.8b
	tst	x9, #0xf
	b.eq	L_518
	add	x10, x10, #8
	sub	x9, x9, #1
L_518
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	b.le	L_519
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_519
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
L_519
	urshr	v5.8h, v18.8h, #8
	urshr	v6.8h, v19.8h, #8
	urshr	v7.8h, v20.8h, #8
	raddhn	v17.8b, v18.8h, v5.8h
	raddhn	v19.8b, v19.8h, v6.8h
	raddhn	v18.8b, v20.8h, v7.8h
	uqadd	v5.8b, v2.8b, v17.8b
	uqadd	v6.8b, v0.8b, v18.8b
	uqadd	v7.8b, v1.8b, v19.8b
	ushll	v14.8h, v5.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v7.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v6.8b, #7
	sli	v19.8h, v19.8h, #1
	sri	v14.8h, v18.8h, #5
	sri	v14.8h, v19.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x2, #0x2
	b.eq	L_520
	st1	{ v28.h }[1], [x2], #2
L_520
	tst	x2, #0x4
	b.eq	L_521
	st1	{ v28.s }[1], [x2], #4
L_521
	tst	x2, #0x8
	b.eq	L_522
	st1	{ v29.4h }, [x2], #8
L_522
L_514
	ld1	{ v4.4h, v5.4h }, [x8], #16
	ld4	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x4], #32
	add	x10, x10, #8
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v24.8b, v9.8b
	umull	v2.8h, v24.8b, v10.8b
	umull	v3.8h, v24.8b, v11.8b
	mov	v4.d[1], v5.d[0]
	shrn	v25.8b, v4.8h, #8
	shrn	v26.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	urshr	v17.8h, v0.8h, #8
	urshr	v18.8h, v1.8h, #8
	urshr	v19.8h, v2.8h, #8
	urshr	v20.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v17.8h
	raddhn	v1.8b, v1.8h, v18.8h
	raddhn	v2.8b, v2.8h, v19.8h
	raddhn	v3.8b, v3.8h, v20.8h
	sri	v25.8b, v25.8b, #5
	sri	v26.8b, v26.8b, #6
	mvn	v3.8b, v3.8b
	shrn	v30.8b, v4.8h, #2
	umull	v18.8h, v3.8b, v25.8b
	umull	v19.8h, v3.8b, v26.8b
	umull	v20.8h, v3.8b, v30.8b
	tst	x9, #0xf
	b.eq	L_523
	add	x10, x10, #8
	sub	x9, x9, #1
L_523
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	b.le	L_524
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_524
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
L_524
	subs	x0, x0, #16
	b.lt	L_525
L_526
	urshr	v5.8h, v18.8h, #8
	urshr	v6.8h, v19.8h, #8
	urshr	v7.8h, v20.8h, #8
	raddhn	v17.8b, v18.8h, v5.8h
	raddhn	v19.8b, v19.8h, v6.8h
	raddhn	v18.8b, v20.8h, v7.8h
	uqadd	v5.8b, v2.8b, v17.8b
	uqadd	v6.8b, v0.8b, v18.8b
	uqadd	v7.8b, v1.8b, v19.8b
	ushll	v14.8h, v5.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v7.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v6.8b, #7
	sli	v19.8h, v19.8h, #1
	sri	v14.8h, v18.8h, #5
	sri	v14.8h, v19.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
	ld1	{ v4.4h, v5.4h }, [x8], #16
	ld4	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x4], #32
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v24.8b, v9.8b
	umull	v2.8h, v24.8b, v10.8b
	umull	v3.8h, v24.8b, v11.8b
	mov	v4.d[1], v5.d[0]
	shrn	v25.8b, v4.8h, #8
	shrn	v26.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	urshr	v17.8h, v0.8h, #8
	urshr	v18.8h, v1.8h, #8
	urshr	v19.8h, v2.8h, #8
	urshr	v20.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v17.8h
	raddhn	v1.8b, v1.8h, v18.8h
	raddhn	v2.8b, v2.8h, v19.8h
	raddhn	v3.8b, v3.8h, v20.8h
	sri	v25.8b, v25.8b, #5
	sri	v26.8b, v26.8b, #6
	mvn	v3.8b, v3.8b
	shrn	v30.8b, v4.8h, #2
	umull	v18.8h, v3.8b, v25.8b
	umull	v19.8h, v3.8b, v26.8b
	umull	v20.8h, v3.8b, v30.8b
	subs	x0, x0, #8
	b.ge	L_526
L_525
	urshr	v5.8h, v18.8h, #8
	urshr	v6.8h, v19.8h, #8
	urshr	v7.8h, v20.8h, #8
	raddhn	v17.8b, v18.8h, v5.8h
	raddhn	v19.8b, v19.8h, v6.8h
	raddhn	v18.8b, v20.8h, v7.8h
	uqadd	v5.8b, v2.8b, v17.8b
	uqadd	v6.8b, v0.8b, v18.8b
	uqadd	v7.8b, v1.8b, v19.8b
	ushll	v14.8h, v5.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v7.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v6.8b, #7
	sli	v19.8h, v19.8h, #1
	sri	v14.8h, v18.8h, #5
	sri	v14.8h, v19.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
	tst	x0, #0x7
	b.eq	L_527
	tst	x0, #0x4
	b.eq	L_528
	ld1	{ v10.2s, v11.2s }, [x4], #16
	ld1	{ v5.4h }, [x8], #8
	add	x10, x10, #4
L_528
	tst	x0, #0x2
	b.eq	L_529
	ld1	{ v9.2s }, [x4], #8
	ld1	{ v4.h }[2], [x8], #2
	ld1	{ v4.h }[3], [x8], #2
	add	x10, x10, #2
L_529
	tst	x0, #0x1
	b.eq	L_530
	ld1	{ v8.s }[1], [x4], #4
	ld1	{ v4.h }[1], [x8], #2
	add	x10, x10, #1
L_530
	umov	x15, v16.d[0]
	uzp1	v16.8b, v8.8b, v9.8b
	uzp2	v9.8b, v8.8b, v9.8b
	mov	v8.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v10.8b, v11.8b
	uzp2	v11.8b, v10.8b, v11.8b
	mov	v10.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v9.8b, v11.8b
	uzp2	v11.8b, v9.8b, v11.8b
	mov	v9.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v8.8b, v10.8b
	uzp2	v10.8b, v8.8b, v10.8b
	mov	v8.8b, v16.8b
	mov	v16.d[0], x15
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v24.8b, v9.8b
	umull	v2.8h, v24.8b, v10.8b
	umull	v3.8h, v24.8b, v11.8b
	mov	v4.d[1], v5.d[0]
	shrn	v25.8b, v4.8h, #8
	shrn	v26.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	urshr	v17.8h, v0.8h, #8
	urshr	v18.8h, v1.8h, #8
	urshr	v19.8h, v2.8h, #8
	urshr	v20.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v17.8h
	raddhn	v1.8b, v1.8h, v18.8h
	raddhn	v2.8b, v2.8h, v19.8h
	raddhn	v3.8b, v3.8h, v20.8h
	sri	v25.8b, v25.8b, #5
	sri	v26.8b, v26.8b, #6
	mvn	v3.8b, v3.8b
	shrn	v30.8b, v4.8h, #2
	umull	v18.8h, v3.8b, v25.8b
	umull	v19.8h, v3.8b, v26.8b
	umull	v20.8h, v3.8b, v30.8b
	tst	x9, #0xf
	b.eq	L_531
	add	x10, x10, #8
	sub	x9, x9, #1
L_531
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	b.le	L_532
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_532
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
L_532
	urshr	v5.8h, v18.8h, #8
	urshr	v6.8h, v19.8h, #8
	urshr	v7.8h, v20.8h, #8
	raddhn	v17.8b, v18.8h, v5.8h
	raddhn	v19.8b, v19.8h, v6.8h
	raddhn	v18.8b, v20.8h, v7.8h
	uqadd	v5.8b, v2.8b, v17.8b
	uqadd	v6.8b, v0.8b, v18.8b
	uqadd	v7.8b, v1.8b, v19.8b
	ushll	v14.8h, v5.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v7.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v6.8b, #7
	sli	v19.8h, v19.8h, #1
	sri	v14.8h, v18.8h, #5
	sri	v14.8h, v19.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_533
	st1	{ v29.4h }, [x2], #8
L_533
	tst	x0, #0x2
	b.eq	L_534
	st1	{ v28.s }[1], [x2], #4
L_534
	tst	x0, #0x1
	b.eq	L_535
	st1	{ v28.h }[1], [x2], #2
L_535
L_527
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x4, x4, x5, lsl #2
	sub	x2, x2, x0, lsl #1
	sub	x4, x4, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_513
L_536
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_512
	lsl	x15, x5, #2
	prfm	pldl1keep, [x4, x15]
	lsl	x15, x3, #1
	prfm	pldl1keep, [x8, x15]
	tst	x0, #0x8
	b.eq	L_537
	ld1	{ v4.4h, v5.4h }, [x8], #16
	ld4	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x4], #32
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v24.8b, v9.8b
	umull	v2.8h, v24.8b, v10.8b
	umull	v3.8h, v24.8b, v11.8b
	mov	v4.d[1], v5.d[0]
	shrn	v25.8b, v4.8h, #8
	shrn	v26.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	urshr	v17.8h, v0.8h, #8
	urshr	v18.8h, v1.8h, #8
	urshr	v19.8h, v2.8h, #8
	urshr	v20.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v17.8h
	raddhn	v1.8b, v1.8h, v18.8h
	raddhn	v2.8b, v2.8h, v19.8h
	raddhn	v3.8b, v3.8h, v20.8h
	sri	v25.8b, v25.8b, #5
	sri	v26.8b, v26.8b, #6
	mvn	v3.8b, v3.8b
	shrn	v30.8b, v4.8h, #2
	umull	v18.8h, v3.8b, v25.8b
	umull	v19.8h, v3.8b, v26.8b
	umull	v20.8h, v3.8b, v30.8b
	urshr	v5.8h, v18.8h, #8
	urshr	v6.8h, v19.8h, #8
	urshr	v7.8h, v20.8h, #8
	raddhn	v17.8b, v18.8h, v5.8h
	raddhn	v19.8b, v19.8h, v6.8h
	raddhn	v18.8b, v20.8h, v7.8h
	uqadd	v5.8b, v2.8b, v17.8b
	uqadd	v6.8b, v0.8b, v18.8b
	uqadd	v7.8b, v1.8b, v19.8b
	ushll	v14.8h, v5.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v7.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v6.8b, #7
	sli	v19.8h, v19.8h, #1
	sri	v14.8h, v18.8h, #5
	sri	v14.8h, v19.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
L_537
	tst	x0, #0x7
	b.eq	L_538
	tst	x0, #0x4
	b.eq	L_539
	ld1	{ v10.2s, v11.2s }, [x4], #16
	ld1	{ v5.4h }, [x8], #8
L_539
	tst	x0, #0x2
	b.eq	L_540
	ld1	{ v9.2s }, [x4], #8
	ld1	{ v4.h }[2], [x8], #2
	ld1	{ v4.h }[3], [x8], #2
L_540
	tst	x0, #0x1
	b.eq	L_541
	ld1	{ v8.s }[1], [x4], #4
	ld1	{ v4.h }[1], [x8], #2
L_541
	umov	x15, v16.d[0]
	uzp1	v16.8b, v8.8b, v9.8b
	uzp2	v9.8b, v8.8b, v9.8b
	mov	v8.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v10.8b, v11.8b
	uzp2	v11.8b, v10.8b, v11.8b
	mov	v10.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v9.8b, v11.8b
	uzp2	v11.8b, v9.8b, v11.8b
	mov	v9.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v8.8b, v10.8b
	uzp2	v10.8b, v8.8b, v10.8b
	mov	v8.8b, v16.8b
	mov	v16.d[0], x15
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v24.8b, v9.8b
	umull	v2.8h, v24.8b, v10.8b
	umull	v3.8h, v24.8b, v11.8b
	mov	v4.d[1], v5.d[0]
	shrn	v25.8b, v4.8h, #8
	shrn	v26.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	urshr	v17.8h, v0.8h, #8
	urshr	v18.8h, v1.8h, #8
	urshr	v19.8h, v2.8h, #8
	urshr	v20.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v17.8h
	raddhn	v1.8b, v1.8h, v18.8h
	raddhn	v2.8b, v2.8h, v19.8h
	raddhn	v3.8b, v3.8h, v20.8h
	sri	v25.8b, v25.8b, #5
	sri	v26.8b, v26.8b, #6
	mvn	v3.8b, v3.8b
	shrn	v30.8b, v4.8h, #2
	umull	v18.8h, v3.8b, v25.8b
	umull	v19.8h, v3.8b, v26.8b
	umull	v20.8h, v3.8b, v30.8b
	urshr	v5.8h, v18.8h, #8
	urshr	v6.8h, v19.8h, #8
	urshr	v7.8h, v20.8h, #8
	raddhn	v17.8b, v18.8h, v5.8h
	raddhn	v19.8b, v19.8h, v6.8h
	raddhn	v18.8b, v20.8h, v7.8h
	uqadd	v5.8b, v2.8b, v17.8b
	uqadd	v6.8b, v0.8b, v18.8b
	uqadd	v7.8b, v1.8b, v19.8b
	ushll	v14.8h, v5.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v7.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v6.8b, #7
	sli	v19.8h, v19.8h, #1
	sri	v14.8h, v18.8h, #5
	sri	v14.8h, v19.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_542
	st1	{ v29.4h }, [x2], #8
L_542
	tst	x0, #0x2
	b.eq	L_543
	st1	{ v28.h }[2], [x2], #2
	st1	{ v28.h }[3], [x2], #2
L_543
	tst	x0, #0x1
	b.eq	L_544
	st1	{ v28.h }[1], [x2], #2
L_544
L_538
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x4, x4, x5, lsl #2
	sub	x2, x2, x0, lsl #1
	sub	x4, x4, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_512
L_511
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_src_0565_0565_asm_neon
pixman_composite_src_0565_0565_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #6
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_545
	cmp	x0, #32
	b.lt	L_546
L_547
	tst	x8, #0xf
	b.eq	L_548
	tst	x8, #0x2
	b.eq	L_549
	ld1	{ v0.h }[1], [x4], #2
	add	x8, x8, #2
	add	x10, x10, #1
	sub	x0, x0, #1
L_549
	tst	x8, #0x4
	b.eq	L_550
	ld1	{ v0.h }[2], [x4], #2
	ld1	{ v0.h }[3], [x4], #2
	add	x8, x8, #4
	add	x10, x10, #2
	sub	x0, x0, #2
L_550
	tst	x8, #0x8
	b.eq	L_551
	ld1	{ v1.4h }, [x4], #8
	add	x8, x8, #8
	add	x10, x10, #4
	sub	x0, x0, #4
L_551
	ld1	{ v2.4h, v3.4h }, [x4], #16
	add	x8, x8, #16
	add	x10, x10, #8
	sub	x0, x0, #8
L_552
	tst	x9, #0xf
	b.eq	L_553
	add	x10, x10, #16
	sub	x9, x9, #1
L_553
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x11, x15]
	b.le	L_554
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_554
	add	x11, x11, x5, lsl #1
	ldrsb	x15, [x11]
L_554
	tst	x2, #0x2
	b.eq	L_555
	st1	{ v0.h }[1], [x2], #2
L_555
	tst	x2, #0x4
	b.eq	L_556
	st1	{ v0.s }[1], [x2], #4
L_556
	tst	x2, #0x8
	b.eq	L_557
	st1	{ v1.4h }, [x2], #8
L_557
	st1	{ v2.4h, v3.4h }, [x2], #16
L_558
L_548
	ld1	{ v0.4h, v1.4h, v2.4h, v3.4h }, [x4], #32
	add	x10, x10, #16
	tst	x9, #0xf
	b.eq	L_559
	add	x10, x10, #16
	sub	x9, x9, #1
L_559
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x11, x15]
	b.le	L_560
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_560
	add	x11, x11, x5, lsl #1
	ldrsb	x15, [x11]
L_560
	subs	x0, x0, #32
	b.lt	L_561
L_562
	st1	{ v0.4h, v1.4h, v2.4h, v3.4h }, [x2], #32
	ld1	{ v0.4h, v1.4h, v2.4h, v3.4h }, [x4], #32
	add	x10, x10, #16
	tst	x9, #0xf
	b.eq	L_563
	add	x10, x10, #16
	sub	x9, x9, #1
L_563
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x11, x15]
	b.le	L_564
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_564
	add	x11, x11, x5, lsl #1
	ldrsb	x15, [x11]
L_564
	subs	x0, x0, #16
	b.ge	L_562
L_561
	st1	{ v0.4h, v1.4h, v2.4h, v3.4h }, [x2], #32
	tst	x0, #0xf
	b.eq	L_565
	tst	x0, #0x8
	b.eq	L_566
	ld1	{ v2.4h, v3.4h }, [x4], #16
	add	x10, x10, #8
L_566
	tst	x0, #0x4
	b.eq	L_567
	ld1	{ v1.4h }, [x4], #8
	add	x10, x10, #4
L_567
	tst	x0, #0x2
	b.eq	L_568
	ld1	{ v0.h }[2], [x4], #2
	ld1	{ v0.h }[3], [x4], #2
	add	x10, x10, #2
L_568
	tst	x0, #0x1
	b.eq	L_569
	ld1	{ v0.h }[1], [x4], #2
	add	x10, x10, #1
L_569
	tst	x9, #0xf
	b.eq	L_570
	add	x10, x10, #16
	sub	x9, x9, #1
L_570
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x11, x15]
	b.le	L_571
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_571
	add	x11, x11, x5, lsl #1
	ldrsb	x15, [x11]
L_571
	tst	x0, #0x8
	b.eq	L_572
	st1	{ v2.4h, v3.4h }, [x2], #16
L_572
	tst	x0, #0x4
	b.eq	L_573
	st1	{ v1.4h }, [x2], #8
L_573
	tst	x0, #0x2
	b.eq	L_574
	st1	{ v0.s }[1], [x2], #4
L_574
	tst	x0, #0x1
	b.eq	L_575
	st1	{ v0.h }[1], [x2], #2
L_575
L_565
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x4, x4, x5, lsl #1
	sub	x2, x2, x0, lsl #1
	sub	x4, x4, x0, lsl #1
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_547
L_576
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_546
	lsl	x15, x5, #1
	prfm	pldl1keep, [x4, x15]
	tst	x0, #0x10
	b.eq	L_577
	ld1	{ v0.4h, v1.4h, v2.4h, v3.4h }, [x4], #32
	st1	{ v0.4h, v1.4h, v2.4h, v3.4h }, [x2], #32
L_577
	tst	x0, #0xf
	b.eq	L_578
	tst	x0, #0x8
	b.eq	L_579
	ld1	{ v2.4h, v3.4h }, [x4], #16
L_579
	tst	x0, #0x4
	b.eq	L_580
	ld1	{ v1.4h }, [x4], #8
L_580
	tst	x0, #0x2
	b.eq	L_581
	ld1	{ v0.h }[2], [x4], #2
	ld1	{ v0.h }[3], [x4], #2
L_581
	tst	x0, #0x1
	b.eq	L_582
	ld1	{ v0.h }[1], [x4], #2
L_582
	tst	x0, #0x8
	b.eq	L_583
	st1	{ v2.4h, v3.4h }, [x2], #16
L_583
	tst	x0, #0x4
	b.eq	L_584
	st1	{ v1.4h }, [x2], #8
L_584
	tst	x0, #0x2
	b.eq	L_585
	st1	{ v0.h }[2], [x2], #2
	st1	{ v0.h }[3], [x2], #2
L_585
	tst	x0, #0x1
	b.eq	L_586
	st1	{ v0.h }[1], [x2], #2
L_586
L_578
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x4, x4, x5, lsl #1
	sub	x2, x2, x0, lsl #1
	sub	x4, x4, x0, lsl #1
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_546
L_545
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_src_n_8_asm_neon
pixman_composite_src_n_8_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x8, x2
	mov	v0.s[0], w4
	dup	v3.8b, v0.b[0]
	dup	v2.8b, v0.b[0]
	dup	v1.8b, v0.b[0]
	dup	v0.8b, v0.b[0]
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_587
	cmp	x0, #64
	b.lt	L_588
L_589
	tst	x8, #0xf
	b.eq	L_590
	tst	x2, #0x1
	b.eq	L_591
	sub	x0, x0, #1
	st1	{ v0.b }[1], [x2], #1
L_591
	tst	x2, #0x2
	b.eq	L_592
	sub	x0, x0, #2
	st1	{ v0.h }[1], [x2], #2
L_592
	tst	x2, #0x4
	b.eq	L_593
	sub	x0, x0, #4
	st1	{ v0.s }[1], [x2], #4
L_593
	tst	x2, #0x8
	b.eq	L_594
	sub	x0, x0, #8
	st1	{ v1.8b }, [x2], #8
L_594
	sub	x0, x0, #16
	st1	{ v2.8b, v3.8b }, [x2], #16
L_595
L_590
	subs	x0, x0, #64
	b.lt	L_596
L_597
	st1	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], #32
	subs	x0, x0, #32
	b.ge	L_597
L_596
	st1	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], #32
	tst	x0, #0x1f
	b.eq	L_598
	tst	x0, #0x10
	b.eq	L_599
	st1	{ v2.8b, v3.8b }, [x2], #16
L_599
	tst	x0, #0x8
	b.eq	L_600
	st1	{ v1.8b }, [x2], #8
L_600
	tst	x0, #0x4
	b.eq	L_601
	st1	{ v0.s }[1], [x2], #4
L_601
	tst	x0, #0x2
	b.eq	L_602
	st1	{ v0.h }[1], [x2], #2
L_602
	tst	x0, #0x1
	b.eq	L_603
	st1	{ v0.b }[1], [x2], #1
L_603
L_598
	mov	x0, x14
	add	x2, x2, x3
	sub	x2, x2, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_589
L_604
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_588
	tst	x0, #0x20
	b.eq	L_605
	st1	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], #32
L_605
	tst	x0, #0x1f
	b.eq	L_606
	tst	x0, #0x10
	b.eq	L_607
	st1	{ v2.8b, v3.8b }, [x2], #16
L_607
	tst	x0, #0x8
	b.eq	L_608
	st1	{ v1.8b }, [x2], #8
L_608
	tst	x0, #0x4
	b.eq	L_609
	st1	{ v0.b }[4], [x2], #1
	st1	{ v0.b }[5], [x2], #1
	st1	{ v0.b }[6], [x2], #1
	st1	{ v0.b }[7], [x2], #1
L_609
	tst	x0, #0x2
	b.eq	L_610
	st1	{ v0.b }[2], [x2], #1
	st1	{ v0.b }[3], [x2], #1
L_610
	tst	x0, #0x1
	b.eq	L_611
	st1	{ v0.b }[1], [x2], #1
L_611
L_606
	mov	x0, x14
	add	x2, x2, x3
	sub	x2, x2, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_588
L_587
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_src_n_0565_asm_neon
pixman_composite_src_n_0565_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x8, x2
	mov	v0.s[0], w4
	dup	v3.4h, v0.h[0]
	dup	v2.4h, v0.h[0]
	dup	v1.4h, v0.h[0]
	dup	v0.4h, v0.h[0]
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_612
	cmp	x0, #32
	b.lt	L_613
L_614
	tst	x8, #0xf
	b.eq	L_615
	tst	x2, #0x2
	b.eq	L_616
	sub	x0, x0, #1
	st1	{ v0.h }[1], [x2], #2
L_616
	tst	x2, #0x4
	b.eq	L_617
	sub	x0, x0, #2
	st1	{ v0.s }[1], [x2], #4
L_617
	tst	x2, #0x8
	b.eq	L_618
	sub	x0, x0, #4
	st1	{ v1.4h }, [x2], #8
L_618
	sub	x0, x0, #8
	st1	{ v2.4h, v3.4h }, [x2], #16
L_619
L_615
	subs	x0, x0, #32
	b.lt	L_620
L_621
	st1	{ v0.4h, v1.4h, v2.4h, v3.4h }, [x2], #32
	subs	x0, x0, #16
	b.ge	L_621
L_620
	st1	{ v0.4h, v1.4h, v2.4h, v3.4h }, [x2], #32
	tst	x0, #0xf
	b.eq	L_622
	tst	x0, #0x8
	b.eq	L_623
	st1	{ v2.4h, v3.4h }, [x2], #16
L_623
	tst	x0, #0x4
	b.eq	L_624
	st1	{ v1.4h }, [x2], #8
L_624
	tst	x0, #0x2
	b.eq	L_625
	st1	{ v0.s }[1], [x2], #4
L_625
	tst	x0, #0x1
	b.eq	L_626
	st1	{ v0.h }[1], [x2], #2
L_626
L_622
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	sub	x2, x2, x0, lsl #1
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_614
L_627
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_613
	tst	x0, #0x10
	b.eq	L_628
	st1	{ v0.4h, v1.4h, v2.4h, v3.4h }, [x2], #32
L_628
	tst	x0, #0xf
	b.eq	L_629
	tst	x0, #0x8
	b.eq	L_630
	st1	{ v2.4h, v3.4h }, [x2], #16
L_630
	tst	x0, #0x4
	b.eq	L_631
	st1	{ v1.4h }, [x2], #8
L_631
	tst	x0, #0x2
	b.eq	L_632
	st1	{ v0.h }[2], [x2], #2
	st1	{ v0.h }[3], [x2], #2
L_632
	tst	x0, #0x1
	b.eq	L_633
	st1	{ v0.h }[1], [x2], #2
L_633
L_629
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	sub	x2, x2, x0, lsl #1
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_613
L_612
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_src_n_8888_asm_neon
pixman_composite_src_n_8888_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x8, x2
	mov	v0.s[0], w4
	dup	v3.2s, v0.s[0]
	dup	v2.2s, v0.s[0]
	dup	v1.2s, v0.s[0]
	dup	v0.2s, v0.s[0]
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_634
	cmp	x0, #16
	b.lt	L_635
L_636
	tst	x8, #0xf
	b.eq	L_637
	tst	x2, #0x4
	b.eq	L_638
	sub	x0, x0, #1
	st1	{ v0.s }[1], [x2], #4
L_638
	tst	x2, #0x8
	b.eq	L_639
	sub	x0, x0, #2
	st1	{ v1.2s }, [x2], #8
L_639
	sub	x0, x0, #4
	st1	{ v2.2s, v3.2s }, [x2], #16
L_640
L_637
	subs	x0, x0, #16
	b.lt	L_641
L_642
	st1	{ v0.2s, v1.2s, v2.2s, v3.2s }, [x2], #32
	subs	x0, x0, #8
	b.ge	L_642
L_641
	st1	{ v0.2s, v1.2s, v2.2s, v3.2s }, [x2], #32
	tst	x0, #0x7
	b.eq	L_643
	tst	x0, #0x4
	b.eq	L_644
	st1	{ v2.2s, v3.2s }, [x2], #16
L_644
	tst	x0, #0x2
	b.eq	L_645
	st1	{ v1.2s }, [x2], #8
L_645
	tst	x0, #0x1
	b.eq	L_646
	st1	{ v0.s }[1], [x2], #4
L_646
L_643
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	sub	x2, x2, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_636
L_647
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_635
	tst	x0, #0x8
	b.eq	L_648
	st1	{ v0.2s, v1.2s, v2.2s, v3.2s }, [x2], #32
L_648
	tst	x0, #0x7
	b.eq	L_649
	tst	x0, #0x4
	b.eq	L_650
	st1	{ v2.2s, v3.2s }, [x2], #16
L_650
	tst	x0, #0x2
	b.eq	L_651
	st1	{ v1.2s }, [x2], #8
L_651
	tst	x0, #0x1
	b.eq	L_652
	st1	{ v0.s }[1], [x2], #4
L_652
L_649
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	sub	x2, x2, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_635
L_634
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_src_8888_8888_asm_neon
pixman_composite_src_8888_8888_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #6
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_653
	cmp	x0, #16
	b.lt	L_654
L_655
	tst	x8, #0xf
	b.eq	L_656
	tst	x8, #0x4
	b.eq	L_657
	ld1	{ v0.s }[1], [x4], #4
	add	x8, x8, #4
	add	x10, x10, #1
	sub	x0, x0, #1
L_657
	tst	x8, #0x8
	b.eq	L_658
	ld1	{ v1.2s }, [x4], #8
	add	x8, x8, #8
	add	x10, x10, #2
	sub	x0, x0, #2
L_658
	ld1	{ v2.2s, v3.2s }, [x4], #16
	add	x8, x8, #16
	add	x10, x10, #4
	sub	x0, x0, #4
L_659
	tst	x9, #0xf
	b.eq	L_660
	add	x10, x10, #8
	sub	x9, x9, #1
L_660
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	b.le	L_661
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_661
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
L_661
	tst	x2, #0x4
	b.eq	L_662
	st1	{ v0.s }[1], [x2], #4
L_662
	tst	x2, #0x8
	b.eq	L_663
	st1	{ v1.2s }, [x2], #8
L_663
	st1	{ v2.2s, v3.2s }, [x2], #16
L_664
L_656
	ld1	{ v0.2s, v1.2s, v2.2s, v3.2s }, [x4], #32
	add	x10, x10, #8
	tst	x9, #0xf
	b.eq	L_665
	add	x10, x10, #8
	sub	x9, x9, #1
L_665
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	b.le	L_666
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_666
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
L_666
	subs	x0, x0, #16
	b.lt	L_667
L_668
	st1	{ v0.2s, v1.2s, v2.2s, v3.2s }, [x2], #32
	ld1	{ v0.2s, v1.2s, v2.2s, v3.2s }, [x4], #32
	add	x10, x10, #8
	tst	x9, #0xf
	b.eq	L_669
	add	x10, x10, #8
	sub	x9, x9, #1
L_669
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	b.le	L_670
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_670
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
L_670
	subs	x0, x0, #8
	b.ge	L_668
L_667
	st1	{ v0.2s, v1.2s, v2.2s, v3.2s }, [x2], #32
	tst	x0, #0x7
	b.eq	L_671
	tst	x0, #0x4
	b.eq	L_672
	ld1	{ v2.2s, v3.2s }, [x4], #16
	add	x10, x10, #4
L_672
	tst	x0, #0x2
	b.eq	L_673
	ld1	{ v1.2s }, [x4], #8
	add	x10, x10, #2
L_673
	tst	x0, #0x1
	b.eq	L_674
	ld1	{ v0.s }[1], [x4], #4
	add	x10, x10, #1
L_674
	tst	x9, #0xf
	b.eq	L_675
	add	x10, x10, #8
	sub	x9, x9, #1
L_675
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	b.le	L_676
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_676
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
L_676
	tst	x0, #0x4
	b.eq	L_677
	st1	{ v2.2s, v3.2s }, [x2], #16
L_677
	tst	x0, #0x2
	b.eq	L_678
	st1	{ v1.2s }, [x2], #8
L_678
	tst	x0, #0x1
	b.eq	L_679
	st1	{ v0.s }[1], [x2], #4
L_679
L_671
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_655
L_680
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_654
	lsl	x15, x5, #2
	prfm	pldl1keep, [x4, x15]
	tst	x0, #0x8
	b.eq	L_681
	ld1	{ v0.2s, v1.2s, v2.2s, v3.2s }, [x4], #32
	st1	{ v0.2s, v1.2s, v2.2s, v3.2s }, [x2], #32
L_681
	tst	x0, #0x7
	b.eq	L_682
	tst	x0, #0x4
	b.eq	L_683
	ld1	{ v2.2s, v3.2s }, [x4], #16
L_683
	tst	x0, #0x2
	b.eq	L_684
	ld1	{ v1.2s }, [x4], #8
L_684
	tst	x0, #0x1
	b.eq	L_685
	ld1	{ v0.s }[1], [x4], #4
L_685
	tst	x0, #0x4
	b.eq	L_686
	st1	{ v2.2s, v3.2s }, [x2], #16
L_686
	tst	x0, #0x2
	b.eq	L_687
	st1	{ v1.2s }, [x2], #8
L_687
	tst	x0, #0x1
	b.eq	L_688
	st1	{ v0.s }[1], [x2], #4
L_688
L_682
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_654
L_653
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_src_x888_8888_asm_neon
pixman_composite_src_x888_8888_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #6
	movi	v4.2s, #255, lsl #24
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_689
	cmp	x0, #16
	b.lt	L_690
L_691
	tst	x8, #0xf
	b.eq	L_692
	tst	x8, #0x4
	b.eq	L_693
	ld1	{ v0.s }[1], [x4], #4
	add	x8, x8, #4
	add	x10, x10, #1
	sub	x0, x0, #1
L_693
	tst	x8, #0x8
	b.eq	L_694
	ld1	{ v1.2s }, [x4], #8
	add	x8, x8, #8
	add	x10, x10, #2
	sub	x0, x0, #2
L_694
	ld1	{ v2.2s, v3.2s }, [x4], #16
	add	x8, x8, #16
	add	x10, x10, #4
	sub	x0, x0, #4
L_695
	orr	v0.8b, v0.8b, v4.8b
	orr	v1.8b, v1.8b, v4.8b
	orr	v2.8b, v2.8b, v4.8b
	orr	v3.8b, v3.8b, v4.8b
	tst	x9, #0xf
	b.eq	L_696
	add	x10, x10, #8
	sub	x9, x9, #1
L_696
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	b.le	L_697
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_697
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
L_697
	tst	x2, #0x4
	b.eq	L_698
	st1	{ v0.s }[1], [x2], #4
L_698
	tst	x2, #0x8
	b.eq	L_699
	st1	{ v1.2s }, [x2], #8
L_699
	st1	{ v2.2s, v3.2s }, [x2], #16
L_700
L_692
	ld1	{ v0.2s, v1.2s, v2.2s, v3.2s }, [x4], #32
	add	x10, x10, #8
	orr	v0.8b, v0.8b, v4.8b
	orr	v1.8b, v1.8b, v4.8b
	orr	v2.8b, v2.8b, v4.8b
	orr	v3.8b, v3.8b, v4.8b
	tst	x9, #0xf
	b.eq	L_701
	add	x10, x10, #8
	sub	x9, x9, #1
L_701
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	b.le	L_702
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_702
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
L_702
	subs	x0, x0, #16
	b.lt	L_703
L_704
	st1	{ v0.2s, v1.2s, v2.2s, v3.2s }, [x2], #32
	ld1	{ v0.2s, v1.2s, v2.2s, v3.2s }, [x4], #32
	orr	v0.8b, v0.8b, v4.8b
	orr	v1.8b, v1.8b, v4.8b
	orr	v2.8b, v2.8b, v4.8b
	orr	v3.8b, v3.8b, v4.8b
	add	x10, x10, #8
	tst	x9, #0xf
	b.eq	L_705
	add	x10, x10, #8
	sub	x9, x9, #1
L_705
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	b.le	L_706
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_706
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
L_706
	subs	x0, x0, #8
	b.ge	L_704
L_703
	st1	{ v0.2s, v1.2s, v2.2s, v3.2s }, [x2], #32
	tst	x0, #0x7
	b.eq	L_707
	tst	x0, #0x4
	b.eq	L_708
	ld1	{ v2.2s, v3.2s }, [x4], #16
	add	x10, x10, #4
L_708
	tst	x0, #0x2
	b.eq	L_709
	ld1	{ v1.2s }, [x4], #8
	add	x10, x10, #2
L_709
	tst	x0, #0x1
	b.eq	L_710
	ld1	{ v0.s }[1], [x4], #4
	add	x10, x10, #1
L_710
	orr	v0.8b, v0.8b, v4.8b
	orr	v1.8b, v1.8b, v4.8b
	orr	v2.8b, v2.8b, v4.8b
	orr	v3.8b, v3.8b, v4.8b
	tst	x9, #0xf
	b.eq	L_711
	add	x10, x10, #8
	sub	x9, x9, #1
L_711
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	b.le	L_712
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_712
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
L_712
	tst	x0, #0x4
	b.eq	L_713
	st1	{ v2.2s, v3.2s }, [x2], #16
L_713
	tst	x0, #0x2
	b.eq	L_714
	st1	{ v1.2s }, [x2], #8
L_714
	tst	x0, #0x1
	b.eq	L_715
	st1	{ v0.s }[1], [x2], #4
L_715
L_707
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_691
L_716
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_690
	lsl	x15, x5, #2
	prfm	pldl1keep, [x4, x15]
	tst	x0, #0x8
	b.eq	L_717
	ld1	{ v0.2s, v1.2s, v2.2s, v3.2s }, [x4], #32
	orr	v0.8b, v0.8b, v4.8b
	orr	v1.8b, v1.8b, v4.8b
	orr	v2.8b, v2.8b, v4.8b
	orr	v3.8b, v3.8b, v4.8b
	st1	{ v0.2s, v1.2s, v2.2s, v3.2s }, [x2], #32
L_717
	tst	x0, #0x7
	b.eq	L_718
	tst	x0, #0x4
	b.eq	L_719
	ld1	{ v2.2s, v3.2s }, [x4], #16
L_719
	tst	x0, #0x2
	b.eq	L_720
	ld1	{ v1.2s }, [x4], #8
L_720
	tst	x0, #0x1
	b.eq	L_721
	ld1	{ v0.s }[1], [x4], #4
L_721
	orr	v0.8b, v0.8b, v4.8b
	orr	v1.8b, v1.8b, v4.8b
	orr	v2.8b, v2.8b, v4.8b
	orr	v3.8b, v3.8b, v4.8b
	tst	x0, #0x4
	b.eq	L_722
	st1	{ v2.2s, v3.2s }, [x2], #16
L_722
	tst	x0, #0x2
	b.eq	L_723
	st1	{ v1.2s }, [x2], #8
L_723
	tst	x0, #0x1
	b.eq	L_724
	st1	{ v0.s }[1], [x2], #4
L_724
L_718
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_690
L_689
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_src_n_8_8888_asm_neon
pixman_composite_src_n_8_8888_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	mov	v3.s[0], w4
	dup	v0.8b, v3.b[0]
	dup	v1.8b, v3.b[1]
	dup	v2.8b, v3.b[2]
	dup	v3.8b, v3.b[3]
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_725
	cmp	x0, #16
	b.lt	L_726
L_727
	tst	x8, #0xf
	b.eq	L_728
	tst	x8, #0x4
	b.eq	L_729
	ld1	{ v24.b }[1], [x6], #1
	add	x8, x8, #4
	add	x10, x10, #1
	sub	x0, x0, #1
L_729
	tst	x8, #0x8
	b.eq	L_730
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	add	x8, x8, #8
	add	x10, x10, #2
	sub	x0, x0, #2
L_730
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	add	x8, x8, #16
	add	x10, x10, #4
	sub	x0, x0, #4
L_731
	umull	v8.8h, v24.8b, v0.8b
	umull	v9.8h, v24.8b, v1.8b
	umull	v10.8h, v24.8b, v2.8b
	umull	v11.8h, v24.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	tst	x9, #0xf
	b.eq	L_732
	add	x10, x10, #8
	sub	x9, x9, #1
L_732
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_733
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_733
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_733
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x2, #0x4
	b.eq	L_734
	st1	{ v28.s }[1], [x2], #4
L_734
	tst	x2, #0x8
	b.eq	L_735
	st1	{ v29.2s }, [x2], #8
L_735
	st1	{ v30.2s, v31.2s }, [x2], #16
L_736
L_728
	ld1	{ v24.8b }, [x6], #8
	add	x10, x10, #8
	umull	v8.8h, v24.8b, v0.8b
	umull	v9.8h, v24.8b, v1.8b
	umull	v10.8h, v24.8b, v2.8b
	umull	v11.8h, v24.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	tst	x9, #0xf
	b.eq	L_737
	add	x10, x10, #8
	sub	x9, x9, #1
L_737
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_738
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_738
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_738
	subs	x0, x0, #16
	b.lt	L_739
L_740
	ld1	{ v24.8b }, [x6], #8
	add	x10, x10, #8
	rshrn	v28.8b, v8.8h, #8
	tst	x9, #0xf
	rshrn	v29.8b, v9.8h, #8
	b.eq	L_741
	add	x10, x10, #8
L_741
	rshrn	v30.8b, v10.8h, #8
	b.eq	L_742
	sub	x9, x9, #1
L_742
	rshrn	v31.8b, v11.8h, #8
	cmp	x10, x14
	umull	v8.8h, v24.8b, v0.8b
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	umull	v9.8h, v24.8b, v1.8b
	b.le	L_743
	sub	x10, x10, x14
L_743
	umull	v10.8h, v24.8b, v2.8b
	b.le	L_744
	subs	x9, x9, #16
L_744
	umull	v11.8h, v24.8b, v3.8b
	b.le	L_745
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_745
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	subs	x0, x0, #8
	b.ge	L_740
L_739
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	tst	x0, #0x7
	b.eq	L_746
	tst	x0, #0x4
	b.eq	L_747
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	add	x10, x10, #4
L_747
	tst	x0, #0x2
	b.eq	L_748
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	add	x10, x10, #2
L_748
	tst	x0, #0x1
	b.eq	L_749
	ld1	{ v24.b }[1], [x6], #1
	add	x10, x10, #1
L_749
	umull	v8.8h, v24.8b, v0.8b
	umull	v9.8h, v24.8b, v1.8b
	umull	v10.8h, v24.8b, v2.8b
	umull	v11.8h, v24.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	tst	x9, #0xf
	b.eq	L_750
	add	x10, x10, #8
	sub	x9, x9, #1
L_750
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_751
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_751
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_751
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_752
	st1	{ v30.2s, v31.2s }, [x2], #16
L_752
	tst	x0, #0x2
	b.eq	L_753
	st1	{ v29.2s }, [x2], #8
L_753
	tst	x0, #0x1
	b.eq	L_754
	st1	{ v28.s }[1], [x2], #4
L_754
L_746
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x6, x6, x7
	sub	x2, x2, x0, lsl #2
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_727
L_755
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_726
	lsr	x15, x7, #0
	prfm	pldl1keep, [x6, x15]
	tst	x0, #0x8
	b.eq	L_756
	ld1	{ v24.8b }, [x6], #8
	umull	v8.8h, v24.8b, v0.8b
	umull	v9.8h, v24.8b, v1.8b
	umull	v10.8h, v24.8b, v2.8b
	umull	v11.8h, v24.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
L_756
	tst	x0, #0x7
	b.eq	L_757
	tst	x0, #0x4
	b.eq	L_758
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
L_758
	tst	x0, #0x2
	b.eq	L_759
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
L_759
	tst	x0, #0x1
	b.eq	L_760
	ld1	{ v24.b }[1], [x6], #1
L_760
	umull	v8.8h, v24.8b, v0.8b
	umull	v9.8h, v24.8b, v1.8b
	umull	v10.8h, v24.8b, v2.8b
	umull	v11.8h, v24.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_761
	st1	{ v30.2s, v31.2s }, [x2], #16
L_761
	tst	x0, #0x2
	b.eq	L_762
	st1	{ v29.2s }, [x2], #8
L_762
	tst	x0, #0x1
	b.eq	L_763
	st1	{ v28.s }[1], [x2], #4
L_763
L_757
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x6, x6, x7
	sub	x2, x2, x0, lsl #2
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_726
L_725
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_src_n_8_8_asm_neon
pixman_composite_src_n_8_8_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	mov	v16.s[0], w4
	dup	v16.8b, v16.b[3]
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_764
	cmp	x0, #64
	b.lt	L_765
L_766
	tst	x8, #0xf
	b.eq	L_767
	tst	x8, #0x1
	b.eq	L_768
	ld1	{ v24.b }[1], [x6], #1
	add	x8, x8, #1
	add	x10, x10, #1
	sub	x0, x0, #1
L_768
	tst	x8, #0x2
	b.eq	L_769
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	add	x8, x8, #2
	add	x10, x10, #2
	sub	x0, x0, #2
L_769
	tst	x8, #0x4
	b.eq	L_770
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	add	x8, x8, #4
	add	x10, x10, #4
	sub	x0, x0, #4
L_770
	tst	x8, #0x8
	b.eq	L_771
	ld1	{ v25.8b }, [x6], #8
	add	x8, x8, #8
	add	x10, x10, #8
	sub	x0, x0, #8
L_771
	ld1	{ v26.8b, v27.8b }, [x6], #16
	add	x8, x8, #16
	add	x10, x10, #16
	sub	x0, x0, #16
L_772
	umull	v0.8h, v24.8b, v16.8b
	umull	v1.8h, v25.8b, v16.8b
	umull	v2.8h, v26.8b, v16.8b
	umull	v3.8h, v27.8b, v16.8b
	ursra	v0.8h, v0.8h, #8
	ursra	v1.8h, v1.8h, #8
	ursra	v2.8h, v2.8h, #8
	ursra	v3.8h, v3.8h, #8
	tst	x9, #0xf
	b.eq	L_773
	add	x10, x10, #32
	sub	x9, x9, #1
L_773
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_774
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_774
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_774
	rshrn	v28.8b, v0.8h, #8
	rshrn	v29.8b, v1.8h, #8
	rshrn	v30.8b, v2.8h, #8
	rshrn	v31.8b, v3.8h, #8
	tst	x2, #0x1
	b.eq	L_775
	st1	{ v28.b }[1], [x2], #1
L_775
	tst	x2, #0x2
	b.eq	L_776
	st1	{ v28.h }[1], [x2], #2
L_776
	tst	x2, #0x4
	b.eq	L_777
	st1	{ v28.s }[1], [x2], #4
L_777
	tst	x2, #0x8
	b.eq	L_778
	st1	{ v29.8b }, [x2], #8
L_778
	st1	{ v30.8b, v31.8b }, [x2], #16
L_779
L_767
	ld1	{ v24.8b, v25.8b, v26.8b, v27.8b }, [x6], #32
	add	x10, x10, #32
	umull	v0.8h, v24.8b, v16.8b
	umull	v1.8h, v25.8b, v16.8b
	umull	v2.8h, v26.8b, v16.8b
	umull	v3.8h, v27.8b, v16.8b
	ursra	v0.8h, v0.8h, #8
	ursra	v1.8h, v1.8h, #8
	ursra	v2.8h, v2.8h, #8
	ursra	v3.8h, v3.8h, #8
	tst	x9, #0xf
	b.eq	L_780
	add	x10, x10, #32
	sub	x9, x9, #1
L_780
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_781
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_781
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_781
	subs	x0, x0, #64
	b.lt	L_782
L_783
	ld1	{ v24.8b, v25.8b, v26.8b, v27.8b }, [x6], #32
	add	x10, x10, #8
	rshrn	v28.8b, v0.8h, #8
	tst	x9, #0xf
	rshrn	v29.8b, v1.8h, #8
	b.eq	L_784
	add	x10, x10, #8
L_784
	rshrn	v30.8b, v2.8h, #8
	b.eq	L_785
	sub	x9, x9, #1
L_785
	rshrn	v31.8b, v3.8h, #8
	cmp	x10, x14
	umull	v0.8h, v24.8b, v16.8b
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	umull	v1.8h, v25.8b, v16.8b
	b.le	L_786
	sub	x10, x10, x14
L_786
	umull	v2.8h, v26.8b, v16.8b
	b.le	L_787
	subs	x9, x9, #16
L_787
	umull	v3.8h, v27.8b, v16.8b
	b.le	L_788
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_788
	st1	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	ursra	v0.8h, v0.8h, #8
	ursra	v1.8h, v1.8h, #8
	ursra	v2.8h, v2.8h, #8
	ursra	v3.8h, v3.8h, #8
	subs	x0, x0, #32
	b.ge	L_783
L_782
	rshrn	v28.8b, v0.8h, #8
	rshrn	v29.8b, v1.8h, #8
	rshrn	v30.8b, v2.8h, #8
	rshrn	v31.8b, v3.8h, #8
	st1	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	tst	x0, #0x1f
	b.eq	L_789
	tst	x0, #0x10
	b.eq	L_790
	ld1	{ v26.8b, v27.8b }, [x6], #16
	add	x10, x10, #16
L_790
	tst	x0, #0x8
	b.eq	L_791
	ld1	{ v25.8b }, [x6], #8
	add	x10, x10, #8
L_791
	tst	x0, #0x4
	b.eq	L_792
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	add	x10, x10, #4
L_792
	tst	x0, #0x2
	b.eq	L_793
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	add	x10, x10, #2
L_793
	tst	x0, #0x1
	b.eq	L_794
	ld1	{ v24.b }[1], [x6], #1
	add	x10, x10, #1
L_794
	umull	v0.8h, v24.8b, v16.8b
	umull	v1.8h, v25.8b, v16.8b
	umull	v2.8h, v26.8b, v16.8b
	umull	v3.8h, v27.8b, v16.8b
	ursra	v0.8h, v0.8h, #8
	ursra	v1.8h, v1.8h, #8
	ursra	v2.8h, v2.8h, #8
	ursra	v3.8h, v3.8h, #8
	tst	x9, #0xf
	b.eq	L_795
	add	x10, x10, #32
	sub	x9, x9, #1
L_795
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_796
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_796
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_796
	rshrn	v28.8b, v0.8h, #8
	rshrn	v29.8b, v1.8h, #8
	rshrn	v30.8b, v2.8h, #8
	rshrn	v31.8b, v3.8h, #8
	tst	x0, #0x10
	b.eq	L_797
	st1	{ v30.8b, v31.8b }, [x2], #16
L_797
	tst	x0, #0x8
	b.eq	L_798
	st1	{ v29.8b }, [x2], #8
L_798
	tst	x0, #0x4
	b.eq	L_799
	st1	{ v28.s }[1], [x2], #4
L_799
	tst	x0, #0x2
	b.eq	L_800
	st1	{ v28.h }[1], [x2], #2
L_800
	tst	x0, #0x1
	b.eq	L_801
	st1	{ v28.b }[1], [x2], #1
L_801
L_789
	mov	x0, x14
	add	x2, x2, x3
	add	x6, x6, x7
	sub	x2, x2, x0
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_766
L_802
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_765
	lsr	x15, x7, #0
	prfm	pldl1keep, [x6, x15]
	tst	x0, #0x20
	b.eq	L_803
	ld1	{ v24.8b, v25.8b, v26.8b, v27.8b }, [x6], #32
	umull	v0.8h, v24.8b, v16.8b
	umull	v1.8h, v25.8b, v16.8b
	umull	v2.8h, v26.8b, v16.8b
	umull	v3.8h, v27.8b, v16.8b
	ursra	v0.8h, v0.8h, #8
	ursra	v1.8h, v1.8h, #8
	ursra	v2.8h, v2.8h, #8
	ursra	v3.8h, v3.8h, #8
	rshrn	v28.8b, v0.8h, #8
	rshrn	v29.8b, v1.8h, #8
	rshrn	v30.8b, v2.8h, #8
	rshrn	v31.8b, v3.8h, #8
	st1	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
L_803
	tst	x0, #0x1f
	b.eq	L_804
	tst	x0, #0x10
	b.eq	L_805
	ld1	{ v26.8b, v27.8b }, [x6], #16
L_805
	tst	x0, #0x8
	b.eq	L_806
	ld1	{ v25.8b }, [x6], #8
L_806
	tst	x0, #0x4
	b.eq	L_807
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
L_807
	tst	x0, #0x2
	b.eq	L_808
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
L_808
	tst	x0, #0x1
	b.eq	L_809
	ld1	{ v24.b }[1], [x6], #1
L_809
	umull	v0.8h, v24.8b, v16.8b
	umull	v1.8h, v25.8b, v16.8b
	umull	v2.8h, v26.8b, v16.8b
	umull	v3.8h, v27.8b, v16.8b
	ursra	v0.8h, v0.8h, #8
	ursra	v1.8h, v1.8h, #8
	ursra	v2.8h, v2.8h, #8
	ursra	v3.8h, v3.8h, #8
	rshrn	v28.8b, v0.8h, #8
	rshrn	v29.8b, v1.8h, #8
	rshrn	v30.8b, v2.8h, #8
	rshrn	v31.8b, v3.8h, #8
	tst	x0, #0x10
	b.eq	L_810
	st1	{ v30.8b, v31.8b }, [x2], #16
L_810
	tst	x0, #0x8
	b.eq	L_811
	st1	{ v29.8b }, [x2], #8
L_811
	tst	x0, #0x4
	b.eq	L_812
	st1	{ v28.b }[4], [x2], #1
	st1	{ v28.b }[5], [x2], #1
	st1	{ v28.b }[6], [x2], #1
	st1	{ v28.b }[7], [x2], #1
L_812
	tst	x0, #0x2
	b.eq	L_813
	st1	{ v28.b }[2], [x2], #1
	st1	{ v28.b }[3], [x2], #1
L_813
	tst	x0, #0x1
	b.eq	L_814
	st1	{ v28.b }[1], [x2], #1
L_814
L_804
	mov	x0, x14
	add	x2, x2, x3
	add	x6, x6, x7
	sub	x2, x2, x0
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_765
L_764
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_over_n_8_8888_asm_neon
pixman_composite_over_n_8_8888_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	mov	v11.s[0], w4
	dup	v8.8b, v11.b[0]
	dup	v9.8b, v11.b[1]
	dup	v10.8b, v11.b[2]
	dup	v11.8b, v11.b[3]
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_815
	cmp	x0, #16
	b.lt	L_816
L_817
	tst	x8, #0xf
	b.eq	L_818
	tst	x8, #0x4
	b.eq	L_819
	ld1	{ v24.b }[1], [x6], #1
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
	sub	x0, x0, #1
L_819
	tst	x8, #0x8
	b.eq	L_820
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
	sub	x0, x0, #2
L_820
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
	sub	x0, x0, #4
L_821
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v12.8h, v24.8b, v8.8b
	umull	v13.8h, v24.8b, v9.8b
	umull	v14.8h, v24.8b, v10.8b
	umull	v15.8h, v24.8b, v11.8b
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v13.8h, #8
	urshr	v18.8h, v14.8h, #8
	urshr	v19.8h, v15.8h, #8
	raddhn	v0.8b, v12.8h, v16.8h
	raddhn	v1.8b, v13.8h, v17.8h
	raddhn	v2.8b, v14.8h, v18.8h
	raddhn	v3.8b, v15.8h, v19.8h
	mvn	v25.8b, v3.8b
	umull	v12.8h, v25.8b, v4.8b
	umull	v13.8h, v25.8b, v5.8b
	umull	v14.8h, v25.8b, v6.8b
	umull	v15.8h, v25.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_822
	add	x10, x10, #8
	sub	x9, x9, #1
L_822
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_823
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_823
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_823
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v13.8h, #8
	urshr	v18.8h, v14.8h, #8
	urshr	v19.8h, v15.8h, #8
	raddhn	v28.8b, v16.8h, v12.8h
	raddhn	v29.8b, v17.8h, v13.8h
	raddhn	v30.8b, v18.8h, v14.8h
	raddhn	v31.8b, v19.8h, v15.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x2, #0x4
	b.eq	L_824
	st1	{ v28.s }[1], [x2], #4
L_824
	tst	x2, #0x8
	b.eq	L_825
	st1	{ v29.2s }, [x2], #8
L_825
	st1	{ v30.2s, v31.2s }, [x2], #16
L_826
L_818
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld1	{ v24.8b }, [x6], #8
	add	x10, x10, #8
	umull	v12.8h, v24.8b, v8.8b
	umull	v13.8h, v24.8b, v9.8b
	umull	v14.8h, v24.8b, v10.8b
	umull	v15.8h, v24.8b, v11.8b
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v13.8h, #8
	urshr	v18.8h, v14.8h, #8
	urshr	v19.8h, v15.8h, #8
	raddhn	v0.8b, v12.8h, v16.8h
	raddhn	v1.8b, v13.8h, v17.8h
	raddhn	v2.8b, v14.8h, v18.8h
	raddhn	v3.8b, v15.8h, v19.8h
	mvn	v25.8b, v3.8b
	umull	v12.8h, v25.8b, v4.8b
	umull	v13.8h, v25.8b, v5.8b
	umull	v14.8h, v25.8b, v6.8b
	umull	v15.8h, v25.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_827
	add	x10, x10, #8
	sub	x9, x9, #1
L_827
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_828
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_828
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_828
	subs	x0, x0, #16
	b.lt	L_829
L_830
	urshr	v16.8h, v12.8h, #8
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	urshr	v17.8h, v13.8h, #8
	ld1	{ v24.8b }, [x6], #8
	urshr	v18.8h, v14.8h, #8
	add	x10, x10, #8
	urshr	v19.8h, v15.8h, #8
	tst	x9, #0xf
	raddhn	v28.8b, v16.8h, v12.8h
	b.eq	L_831
	add	x10, x10, #8
L_831
	raddhn	v29.8b, v17.8h, v13.8h
	b.eq	L_832
	sub	x9, x9, #1
L_832
	raddhn	v30.8b, v18.8h, v14.8h
	cmp	x10, x14
	raddhn	v31.8b, v19.8h, v15.8h
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	umull	v16.8h, v24.8b, v8.8b
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	umull	v17.8h, v24.8b, v9.8b
	b.le	L_833
	sub	x10, x10, x14
L_833
	umull	v18.8h, v24.8b, v10.8b
	b.le	L_834
	subs	x9, x9, #16
L_834
	umull	v19.8h, v24.8b, v11.8b
	b.le	L_835
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_835
	uqadd	v28.8b, v0.8b, v28.8b
	b.le	L_836
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_836
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	urshr	v12.8h, v16.8h, #8
	urshr	v13.8h, v17.8h, #8
	urshr	v14.8h, v18.8h, #8
	urshr	v15.8h, v19.8h, #8
	raddhn	v0.8b, v16.8h, v12.8h
	raddhn	v1.8b, v17.8h, v13.8h
	raddhn	v2.8b, v18.8h, v14.8h
	raddhn	v3.8b, v19.8h, v15.8h
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	mvn	v25.8b, v3.8b
	umull	v12.8h, v25.8b, v4.8b
	umull	v13.8h, v25.8b, v5.8b
	umull	v14.8h, v25.8b, v6.8b
	umull	v15.8h, v25.8b, v7.8b
	subs	x0, x0, #8
	b.ge	L_830
L_829
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v13.8h, #8
	urshr	v18.8h, v14.8h, #8
	urshr	v19.8h, v15.8h, #8
	raddhn	v28.8b, v16.8h, v12.8h
	raddhn	v29.8b, v17.8h, v13.8h
	raddhn	v30.8b, v18.8h, v14.8h
	raddhn	v31.8b, v19.8h, v15.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	tst	x0, #0x7
	b.eq	L_837
	tst	x0, #0x4
	b.eq	L_838
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
L_838
	tst	x0, #0x2
	b.eq	L_839
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
L_839
	tst	x0, #0x1
	b.eq	L_840
	ld1	{ v24.b }[1], [x6], #1
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
L_840
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v12.8h, v24.8b, v8.8b
	umull	v13.8h, v24.8b, v9.8b
	umull	v14.8h, v24.8b, v10.8b
	umull	v15.8h, v24.8b, v11.8b
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v13.8h, #8
	urshr	v18.8h, v14.8h, #8
	urshr	v19.8h, v15.8h, #8
	raddhn	v0.8b, v12.8h, v16.8h
	raddhn	v1.8b, v13.8h, v17.8h
	raddhn	v2.8b, v14.8h, v18.8h
	raddhn	v3.8b, v15.8h, v19.8h
	mvn	v25.8b, v3.8b
	umull	v12.8h, v25.8b, v4.8b
	umull	v13.8h, v25.8b, v5.8b
	umull	v14.8h, v25.8b, v6.8b
	umull	v15.8h, v25.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_841
	add	x10, x10, #8
	sub	x9, x9, #1
L_841
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_842
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_842
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_842
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v13.8h, #8
	urshr	v18.8h, v14.8h, #8
	urshr	v19.8h, v15.8h, #8
	raddhn	v28.8b, v16.8h, v12.8h
	raddhn	v29.8b, v17.8h, v13.8h
	raddhn	v30.8b, v18.8h, v14.8h
	raddhn	v31.8b, v19.8h, v15.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_843
	st1	{ v30.2s, v31.2s }, [x2], #16
L_843
	tst	x0, #0x2
	b.eq	L_844
	st1	{ v29.2s }, [x2], #8
L_844
	tst	x0, #0x1
	b.eq	L_845
	st1	{ v28.s }[1], [x2], #4
L_845
L_837
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x6, x6, x7
	sub	x2, x2, x0, lsl #2
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_817
L_846
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_816
	lsl	x15, x3, #2
	prfm	pldl1keep, [x8, x15]
	lsr	x15, x7, #0
	prfm	pldl1keep, [x6, x15]
	tst	x0, #0x8
	b.eq	L_847
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld1	{ v24.8b }, [x6], #8
	umull	v12.8h, v24.8b, v8.8b
	umull	v13.8h, v24.8b, v9.8b
	umull	v14.8h, v24.8b, v10.8b
	umull	v15.8h, v24.8b, v11.8b
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v13.8h, #8
	urshr	v18.8h, v14.8h, #8
	urshr	v19.8h, v15.8h, #8
	raddhn	v0.8b, v12.8h, v16.8h
	raddhn	v1.8b, v13.8h, v17.8h
	raddhn	v2.8b, v14.8h, v18.8h
	raddhn	v3.8b, v15.8h, v19.8h
	mvn	v25.8b, v3.8b
	umull	v12.8h, v25.8b, v4.8b
	umull	v13.8h, v25.8b, v5.8b
	umull	v14.8h, v25.8b, v6.8b
	umull	v15.8h, v25.8b, v7.8b
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v13.8h, #8
	urshr	v18.8h, v14.8h, #8
	urshr	v19.8h, v15.8h, #8
	raddhn	v28.8b, v16.8h, v12.8h
	raddhn	v29.8b, v17.8h, v13.8h
	raddhn	v30.8b, v18.8h, v14.8h
	raddhn	v31.8b, v19.8h, v15.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
L_847
	tst	x0, #0x7
	b.eq	L_848
	tst	x0, #0x4
	b.eq	L_849
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	ld1	{ v6.2s, v7.2s }, [x8], #16
L_849
	tst	x0, #0x2
	b.eq	L_850
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	ld1	{ v5.2s }, [x8], #8
L_850
	tst	x0, #0x1
	b.eq	L_851
	ld1	{ v24.b }[1], [x6], #1
	ld1	{ v4.s }[1], [x8], #4
L_851
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v12.8h, v24.8b, v8.8b
	umull	v13.8h, v24.8b, v9.8b
	umull	v14.8h, v24.8b, v10.8b
	umull	v15.8h, v24.8b, v11.8b
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v13.8h, #8
	urshr	v18.8h, v14.8h, #8
	urshr	v19.8h, v15.8h, #8
	raddhn	v0.8b, v12.8h, v16.8h
	raddhn	v1.8b, v13.8h, v17.8h
	raddhn	v2.8b, v14.8h, v18.8h
	raddhn	v3.8b, v15.8h, v19.8h
	mvn	v25.8b, v3.8b
	umull	v12.8h, v25.8b, v4.8b
	umull	v13.8h, v25.8b, v5.8b
	umull	v14.8h, v25.8b, v6.8b
	umull	v15.8h, v25.8b, v7.8b
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v13.8h, #8
	urshr	v18.8h, v14.8h, #8
	urshr	v19.8h, v15.8h, #8
	raddhn	v28.8b, v16.8h, v12.8h
	raddhn	v29.8b, v17.8h, v13.8h
	raddhn	v30.8b, v18.8h, v14.8h
	raddhn	v31.8b, v19.8h, v15.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_852
	st1	{ v30.2s, v31.2s }, [x2], #16
L_852
	tst	x0, #0x2
	b.eq	L_853
	st1	{ v29.2s }, [x2], #8
L_853
	tst	x0, #0x1
	b.eq	L_854
	st1	{ v28.s }[1], [x2], #4
L_854
L_848
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x6, x6, x7
	sub	x2, x2, x0, lsl #2
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_816
L_815
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_over_n_8_8_asm_neon
pixman_composite_over_n_8_8_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	mov	v8.s[0], w4
	dup	v8.8b, v8.b[3]
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_855
	cmp	x0, #64
	b.lt	L_856
L_857
	tst	x8, #0xf
	b.eq	L_858
	tst	x8, #0x1
	b.eq	L_859
	ld1	{ v24.b }[1], [x6], #1
	ld1	{ v4.b }[1], [x8], #1
	add	x10, x10, #1
	sub	x0, x0, #1
L_859
	tst	x8, #0x2
	b.eq	L_860
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	ld1	{ v4.b }[2], [x8], #1
	ld1	{ v4.b }[3], [x8], #1
	add	x10, x10, #2
	sub	x0, x0, #2
L_860
	tst	x8, #0x4
	b.eq	L_861
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	ld1	{ v4.b }[4], [x8], #1
	ld1	{ v4.b }[5], [x8], #1
	ld1	{ v4.b }[6], [x8], #1
	ld1	{ v4.b }[7], [x8], #1
	add	x10, x10, #4
	sub	x0, x0, #4
L_861
	tst	x8, #0x8
	b.eq	L_862
	ld1	{ v25.8b }, [x6], #8
	ld1	{ v5.8b }, [x8], #8
	add	x10, x10, #8
	sub	x0, x0, #8
L_862
	ld1	{ v26.8b, v27.8b }, [x6], #16
	ld1	{ v6.8b, v7.8b }, [x8], #16
	add	x10, x10, #16
	sub	x0, x0, #16
L_863
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v25.8b, v8.8b
	umull	v2.8h, v26.8b, v8.8b
	umull	v3.8h, v27.8b, v8.8b
	urshr	v10.8h, v0.8h, #8
	urshr	v11.8h, v1.8h, #8
	urshr	v12.8h, v2.8h, #8
	urshr	v13.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v10.8h
	raddhn	v1.8b, v1.8h, v11.8h
	raddhn	v2.8b, v2.8h, v12.8h
	raddhn	v3.8b, v3.8h, v13.8h
	mvn	v24.8b, v0.8b
	mvn	v25.8b, v1.8b
	mvn	v26.8b, v2.8b
	mvn	v27.8b, v3.8b
	umull	v10.8h, v24.8b, v4.8b
	umull	v11.8h, v25.8b, v5.8b
	umull	v12.8h, v26.8b, v6.8b
	umull	v13.8h, v27.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_864
	add	x10, x10, #32
	sub	x9, x9, #1
L_864
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_865
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_865
	add	x12, x12, x3
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_865
	urshr	v14.8h, v10.8h, #8
	urshr	v15.8h, v11.8h, #8
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v13.8h, #8
	raddhn	v28.8b, v14.8h, v10.8h
	raddhn	v29.8b, v15.8h, v11.8h
	raddhn	v30.8b, v16.8h, v12.8h
	raddhn	v31.8b, v17.8h, v13.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	tst	x2, #0x1
	b.eq	L_866
	st1	{ v28.b }[1], [x2], #1
L_866
	tst	x2, #0x2
	b.eq	L_867
	st1	{ v28.h }[1], [x2], #2
L_867
	tst	x2, #0x4
	b.eq	L_868
	st1	{ v28.s }[1], [x2], #4
L_868
	tst	x2, #0x8
	b.eq	L_869
	st1	{ v29.8b }, [x2], #8
L_869
	st1	{ v30.8b, v31.8b }, [x2], #16
L_870
L_858
	ld1	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld1	{ v24.8b, v25.8b, v26.8b, v27.8b }, [x6], #32
	add	x10, x10, #32
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v25.8b, v8.8b
	umull	v2.8h, v26.8b, v8.8b
	umull	v3.8h, v27.8b, v8.8b
	urshr	v10.8h, v0.8h, #8
	urshr	v11.8h, v1.8h, #8
	urshr	v12.8h, v2.8h, #8
	urshr	v13.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v10.8h
	raddhn	v1.8b, v1.8h, v11.8h
	raddhn	v2.8b, v2.8h, v12.8h
	raddhn	v3.8b, v3.8h, v13.8h
	mvn	v24.8b, v0.8b
	mvn	v25.8b, v1.8b
	mvn	v26.8b, v2.8b
	mvn	v27.8b, v3.8b
	umull	v10.8h, v24.8b, v4.8b
	umull	v11.8h, v25.8b, v5.8b
	umull	v12.8h, v26.8b, v6.8b
	umull	v13.8h, v27.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_871
	add	x10, x10, #32
	sub	x9, x9, #1
L_871
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_872
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_872
	add	x12, x12, x3
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_872
	subs	x0, x0, #64
	b.lt	L_873
L_874
	ld1	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	urshr	v14.8h, v10.8h, #8
	urshr	v15.8h, v11.8h, #8
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v13.8h, #8
	raddhn	v28.8b, v14.8h, v10.8h
	raddhn	v29.8b, v15.8h, v11.8h
	raddhn	v30.8b, v16.8h, v12.8h
	raddhn	v31.8b, v17.8h, v13.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	ld1	{ v24.8b, v25.8b, v26.8b, v27.8b }, [x6], #32
	add	x10, x10, #32
	tst	x9, #0xf
	b.eq	L_875
	add	x10, x10, #32
	sub	x9, x9, #1
L_875
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_876
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_876
	add	x12, x12, x3
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_876
	st1	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v25.8b, v8.8b
	umull	v2.8h, v26.8b, v8.8b
	umull	v3.8h, v27.8b, v8.8b
	urshr	v10.8h, v0.8h, #8
	urshr	v11.8h, v1.8h, #8
	urshr	v12.8h, v2.8h, #8
	urshr	v13.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v10.8h
	raddhn	v1.8b, v1.8h, v11.8h
	raddhn	v2.8b, v2.8h, v12.8h
	raddhn	v3.8b, v3.8h, v13.8h
	mvn	v24.8b, v0.8b
	mvn	v25.8b, v1.8b
	mvn	v26.8b, v2.8b
	mvn	v27.8b, v3.8b
	umull	v10.8h, v24.8b, v4.8b
	umull	v11.8h, v25.8b, v5.8b
	umull	v12.8h, v26.8b, v6.8b
	umull	v13.8h, v27.8b, v7.8b
	subs	x0, x0, #32
	b.ge	L_874
L_873
	urshr	v14.8h, v10.8h, #8
	urshr	v15.8h, v11.8h, #8
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v13.8h, #8
	raddhn	v28.8b, v14.8h, v10.8h
	raddhn	v29.8b, v15.8h, v11.8h
	raddhn	v30.8b, v16.8h, v12.8h
	raddhn	v31.8b, v17.8h, v13.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	st1	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	tst	x0, #0x1f
	b.eq	L_877
	tst	x0, #0x10
	b.eq	L_878
	ld1	{ v26.8b, v27.8b }, [x6], #16
	ld1	{ v6.8b, v7.8b }, [x8], #16
	add	x10, x10, #16
L_878
	tst	x0, #0x8
	b.eq	L_879
	ld1	{ v25.8b }, [x6], #8
	ld1	{ v5.8b }, [x8], #8
	add	x10, x10, #8
L_879
	tst	x0, #0x4
	b.eq	L_880
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	ld1	{ v4.b }[4], [x8], #1
	ld1	{ v4.b }[5], [x8], #1
	ld1	{ v4.b }[6], [x8], #1
	ld1	{ v4.b }[7], [x8], #1
	add	x10, x10, #4
L_880
	tst	x0, #0x2
	b.eq	L_881
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	ld1	{ v4.b }[2], [x8], #1
	ld1	{ v4.b }[3], [x8], #1
	add	x10, x10, #2
L_881
	tst	x0, #0x1
	b.eq	L_882
	ld1	{ v24.b }[1], [x6], #1
	ld1	{ v4.b }[1], [x8], #1
	add	x10, x10, #1
L_882
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v25.8b, v8.8b
	umull	v2.8h, v26.8b, v8.8b
	umull	v3.8h, v27.8b, v8.8b
	urshr	v10.8h, v0.8h, #8
	urshr	v11.8h, v1.8h, #8
	urshr	v12.8h, v2.8h, #8
	urshr	v13.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v10.8h
	raddhn	v1.8b, v1.8h, v11.8h
	raddhn	v2.8b, v2.8h, v12.8h
	raddhn	v3.8b, v3.8h, v13.8h
	mvn	v24.8b, v0.8b
	mvn	v25.8b, v1.8b
	mvn	v26.8b, v2.8b
	mvn	v27.8b, v3.8b
	umull	v10.8h, v24.8b, v4.8b
	umull	v11.8h, v25.8b, v5.8b
	umull	v12.8h, v26.8b, v6.8b
	umull	v13.8h, v27.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_883
	add	x10, x10, #32
	sub	x9, x9, #1
L_883
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_884
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_884
	add	x12, x12, x3
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_884
	urshr	v14.8h, v10.8h, #8
	urshr	v15.8h, v11.8h, #8
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v13.8h, #8
	raddhn	v28.8b, v14.8h, v10.8h
	raddhn	v29.8b, v15.8h, v11.8h
	raddhn	v30.8b, v16.8h, v12.8h
	raddhn	v31.8b, v17.8h, v13.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	tst	x0, #0x10
	b.eq	L_885
	st1	{ v30.8b, v31.8b }, [x2], #16
L_885
	tst	x0, #0x8
	b.eq	L_886
	st1	{ v29.8b }, [x2], #8
L_886
	tst	x0, #0x4
	b.eq	L_887
	st1	{ v28.s }[1], [x2], #4
L_887
	tst	x0, #0x2
	b.eq	L_888
	st1	{ v28.h }[1], [x2], #2
L_888
	tst	x0, #0x1
	b.eq	L_889
	st1	{ v28.b }[1], [x2], #1
L_889
L_877
	mov	x0, x14
	add	x2, x2, x3
	add	x6, x6, x7
	sub	x2, x2, x0
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_857
L_890
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_856
	lsr	x15, x3, #0
	prfm	pldl1keep, [x8, x15]
	lsr	x15, x7, #0
	prfm	pldl1keep, [x6, x15]
	tst	x0, #0x20
	b.eq	L_891
	ld1	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld1	{ v24.8b, v25.8b, v26.8b, v27.8b }, [x6], #32
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v25.8b, v8.8b
	umull	v2.8h, v26.8b, v8.8b
	umull	v3.8h, v27.8b, v8.8b
	urshr	v10.8h, v0.8h, #8
	urshr	v11.8h, v1.8h, #8
	urshr	v12.8h, v2.8h, #8
	urshr	v13.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v10.8h
	raddhn	v1.8b, v1.8h, v11.8h
	raddhn	v2.8b, v2.8h, v12.8h
	raddhn	v3.8b, v3.8h, v13.8h
	mvn	v24.8b, v0.8b
	mvn	v25.8b, v1.8b
	mvn	v26.8b, v2.8b
	mvn	v27.8b, v3.8b
	umull	v10.8h, v24.8b, v4.8b
	umull	v11.8h, v25.8b, v5.8b
	umull	v12.8h, v26.8b, v6.8b
	umull	v13.8h, v27.8b, v7.8b
	urshr	v14.8h, v10.8h, #8
	urshr	v15.8h, v11.8h, #8
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v13.8h, #8
	raddhn	v28.8b, v14.8h, v10.8h
	raddhn	v29.8b, v15.8h, v11.8h
	raddhn	v30.8b, v16.8h, v12.8h
	raddhn	v31.8b, v17.8h, v13.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	st1	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
L_891
	tst	x0, #0x1f
	b.eq	L_892
	tst	x0, #0x10
	b.eq	L_893
	ld1	{ v26.8b, v27.8b }, [x6], #16
	ld1	{ v6.8b, v7.8b }, [x8], #16
L_893
	tst	x0, #0x8
	b.eq	L_894
	ld1	{ v25.8b }, [x6], #8
	ld1	{ v5.8b }, [x8], #8
L_894
	tst	x0, #0x4
	b.eq	L_895
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	ld1	{ v4.b }[4], [x8], #1
	ld1	{ v4.b }[5], [x8], #1
	ld1	{ v4.b }[6], [x8], #1
	ld1	{ v4.b }[7], [x8], #1
L_895
	tst	x0, #0x2
	b.eq	L_896
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	ld1	{ v4.b }[2], [x8], #1
	ld1	{ v4.b }[3], [x8], #1
L_896
	tst	x0, #0x1
	b.eq	L_897
	ld1	{ v24.b }[1], [x6], #1
	ld1	{ v4.b }[1], [x8], #1
L_897
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v25.8b, v8.8b
	umull	v2.8h, v26.8b, v8.8b
	umull	v3.8h, v27.8b, v8.8b
	urshr	v10.8h, v0.8h, #8
	urshr	v11.8h, v1.8h, #8
	urshr	v12.8h, v2.8h, #8
	urshr	v13.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v10.8h
	raddhn	v1.8b, v1.8h, v11.8h
	raddhn	v2.8b, v2.8h, v12.8h
	raddhn	v3.8b, v3.8h, v13.8h
	mvn	v24.8b, v0.8b
	mvn	v25.8b, v1.8b
	mvn	v26.8b, v2.8b
	mvn	v27.8b, v3.8b
	umull	v10.8h, v24.8b, v4.8b
	umull	v11.8h, v25.8b, v5.8b
	umull	v12.8h, v26.8b, v6.8b
	umull	v13.8h, v27.8b, v7.8b
	urshr	v14.8h, v10.8h, #8
	urshr	v15.8h, v11.8h, #8
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v13.8h, #8
	raddhn	v28.8b, v14.8h, v10.8h
	raddhn	v29.8b, v15.8h, v11.8h
	raddhn	v30.8b, v16.8h, v12.8h
	raddhn	v31.8b, v17.8h, v13.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	tst	x0, #0x10
	b.eq	L_898
	st1	{ v30.8b, v31.8b }, [x2], #16
L_898
	tst	x0, #0x8
	b.eq	L_899
	st1	{ v29.8b }, [x2], #8
L_899
	tst	x0, #0x4
	b.eq	L_900
	st1	{ v28.b }[4], [x2], #1
	st1	{ v28.b }[5], [x2], #1
	st1	{ v28.b }[6], [x2], #1
	st1	{ v28.b }[7], [x2], #1
L_900
	tst	x0, #0x2
	b.eq	L_901
	st1	{ v28.b }[2], [x2], #1
	st1	{ v28.b }[3], [x2], #1
L_901
	tst	x0, #0x1
	b.eq	L_902
	st1	{ v28.b }[1], [x2], #1
L_902
L_892
	mov	x0, x14
	add	x2, x2, x3
	add	x6, x6, x7
	sub	x2, x2, x0
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_856
L_855
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_over_n_8888_8888_ca_asm_neon
pixman_composite_over_n_8888_8888_ca_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	mov	v13.s[0], w4
	dup	v8.8b, v13.b[0]
	dup	v9.8b, v13.b[1]
	dup	v10.8b, v13.b[2]
	dup	v11.8b, v13.b[3]
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_903
	cmp	x0, #16
	b.lt	L_904
L_905
	tst	x8, #0xf
	b.eq	L_906
	tst	x8, #0x4
	b.eq	L_907
	ld1	{ v24.s }[1], [x6], #4
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
	sub	x0, x0, #1
L_907
	tst	x8, #0x8
	b.eq	L_908
	ld1	{ v25.2s }, [x6], #8
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
	sub	x0, x0, #2
L_908
	ld1	{ v26.2s, v27.2s }, [x6], #16
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
	sub	x0, x0, #4
L_909
	umov	x15, v16.d[0]
	uzp1	v16.8b, v24.8b, v25.8b
	uzp2	v25.8b, v24.8b, v25.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v26.8b, v27.8b
	uzp2	v27.8b, v26.8b, v27.8b
	mov	v26.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v25.8b, v27.8b
	uzp2	v27.8b, v25.8b, v27.8b
	mov	v25.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v24.8b, v26.8b
	uzp2	v26.8b, v24.8b, v26.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v25.8b, v9.8b
	umull	v2.8h, v26.8b, v10.8b
	umull	v3.8h, v27.8b, v11.8b
	umull	v12.8h, v11.8b, v25.8b
	umull	v13.8h, v11.8b, v24.8b
	umull	v14.8h, v11.8b, v26.8b
	urshr	v15.8h, v0.8h, #8
	urshr	v16.8h, v1.8h, #8
	urshr	v17.8h, v2.8h, #8
	raddhn	v0.8b, v0.8h, v15.8h
	raddhn	v1.8b, v1.8h, v16.8h
	raddhn	v2.8b, v2.8h, v17.8h
	urshr	v15.8h, v13.8h, #8
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v14.8h, #8
	urshr	v18.8h, v3.8h, #8
	raddhn	v24.8b, v13.8h, v15.8h
	raddhn	v25.8b, v12.8h, v16.8h
	raddhn	v26.8b, v14.8h, v17.8h
	raddhn	v3.8b, v3.8h, v18.8h
	mvn	v24.8b, v24.8b
	mvn	v25.8b, v25.8b
	mvn	v26.8b, v26.8b
	mvn	v27.8b, v3.8b
	umull	v12.8h, v24.8b, v4.8b
	umull	v13.8h, v25.8b, v5.8b
	umull	v14.8h, v26.8b, v6.8b
	umull	v15.8h, v27.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_910
	add	x10, x10, #8
	sub	x9, x9, #1
L_910
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x13, x15]
	b.le	L_911
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_911
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7, lsl #2
	ldrsb	x15, [x13]
L_911
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v13.8h, #8
	urshr	v18.8h, v14.8h, #8
	urshr	v19.8h, v15.8h, #8
	raddhn	v28.8b, v16.8h, v12.8h
	raddhn	v29.8b, v17.8h, v13.8h
	raddhn	v30.8b, v18.8h, v14.8h
	raddhn	v31.8b, v19.8h, v15.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x2, #0x4
	b.eq	L_912
	st1	{ v28.s }[1], [x2], #4
L_912
	tst	x2, #0x8
	b.eq	L_913
	st1	{ v29.2s }, [x2], #8
L_913
	st1	{ v30.2s, v31.2s }, [x2], #16
L_914
L_906
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld4	{ v24.8b, v25.8b, v26.8b, v27.8b }, [x6], #32
	add	x10, x10, #8
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v25.8b, v9.8b
	umull	v2.8h, v26.8b, v10.8b
	umull	v3.8h, v27.8b, v11.8b
	umull	v12.8h, v11.8b, v25.8b
	umull	v13.8h, v11.8b, v24.8b
	umull	v14.8h, v11.8b, v26.8b
	urshr	v15.8h, v0.8h, #8
	urshr	v16.8h, v1.8h, #8
	urshr	v17.8h, v2.8h, #8
	raddhn	v0.8b, v0.8h, v15.8h
	raddhn	v1.8b, v1.8h, v16.8h
	raddhn	v2.8b, v2.8h, v17.8h
	urshr	v15.8h, v13.8h, #8
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v14.8h, #8
	urshr	v18.8h, v3.8h, #8
	raddhn	v24.8b, v13.8h, v15.8h
	raddhn	v25.8b, v12.8h, v16.8h
	raddhn	v26.8b, v14.8h, v17.8h
	raddhn	v3.8b, v3.8h, v18.8h
	mvn	v24.8b, v24.8b
	mvn	v25.8b, v25.8b
	mvn	v26.8b, v26.8b
	mvn	v27.8b, v3.8b
	umull	v12.8h, v24.8b, v4.8b
	umull	v13.8h, v25.8b, v5.8b
	umull	v14.8h, v26.8b, v6.8b
	umull	v15.8h, v27.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_915
	add	x10, x10, #8
	sub	x9, x9, #1
L_915
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x13, x15]
	b.le	L_916
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_916
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7, lsl #2
	ldrsb	x15, [x13]
L_916
	subs	x0, x0, #16
	b.lt	L_917
L_918
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v13.8h, #8
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	urshr	v18.8h, v14.8h, #8
	urshr	v19.8h, v15.8h, #8
	raddhn	v28.8b, v16.8h, v12.8h
	raddhn	v29.8b, v17.8h, v13.8h
	raddhn	v30.8b, v18.8h, v14.8h
	raddhn	v31.8b, v19.8h, v15.8h
	ld4	{ v24.8b, v25.8b, v26.8b, v27.8b }, [x6], #32
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	add	x10, x10, #8
	tst	x9, #0xf
	b.eq	L_919
	add	x10, x10, #8
	sub	x9, x9, #1
L_919
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x13, x15]
	b.le	L_920
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_920
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7, lsl #2
	ldrsb	x15, [x13]
L_920
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v25.8b, v9.8b
	umull	v2.8h, v26.8b, v10.8b
	umull	v3.8h, v27.8b, v11.8b
	umull	v12.8h, v11.8b, v25.8b
	umull	v13.8h, v11.8b, v24.8b
	umull	v14.8h, v11.8b, v26.8b
	urshr	v15.8h, v0.8h, #8
	urshr	v16.8h, v1.8h, #8
	urshr	v17.8h, v2.8h, #8
	raddhn	v0.8b, v0.8h, v15.8h
	raddhn	v1.8b, v1.8h, v16.8h
	raddhn	v2.8b, v2.8h, v17.8h
	urshr	v15.8h, v13.8h, #8
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v14.8h, #8
	urshr	v18.8h, v3.8h, #8
	raddhn	v24.8b, v13.8h, v15.8h
	raddhn	v25.8b, v12.8h, v16.8h
	raddhn	v26.8b, v14.8h, v17.8h
	raddhn	v3.8b, v3.8h, v18.8h
	mvn	v24.8b, v24.8b
	mvn	v25.8b, v25.8b
	mvn	v26.8b, v26.8b
	mvn	v27.8b, v3.8b
	umull	v12.8h, v24.8b, v4.8b
	umull	v13.8h, v25.8b, v5.8b
	umull	v14.8h, v26.8b, v6.8b
	umull	v15.8h, v27.8b, v7.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	subs	x0, x0, #8
	b.ge	L_918
L_917
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v13.8h, #8
	urshr	v18.8h, v14.8h, #8
	urshr	v19.8h, v15.8h, #8
	raddhn	v28.8b, v16.8h, v12.8h
	raddhn	v29.8b, v17.8h, v13.8h
	raddhn	v30.8b, v18.8h, v14.8h
	raddhn	v31.8b, v19.8h, v15.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	tst	x0, #0x7
	b.eq	L_921
	tst	x0, #0x4
	b.eq	L_922
	ld1	{ v26.2s, v27.2s }, [x6], #16
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
L_922
	tst	x0, #0x2
	b.eq	L_923
	ld1	{ v25.2s }, [x6], #8
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
L_923
	tst	x0, #0x1
	b.eq	L_924
	ld1	{ v24.s }[1], [x6], #4
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
L_924
	umov	x15, v16.d[0]
	uzp1	v16.8b, v24.8b, v25.8b
	uzp2	v25.8b, v24.8b, v25.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v26.8b, v27.8b
	uzp2	v27.8b, v26.8b, v27.8b
	mov	v26.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v25.8b, v27.8b
	uzp2	v27.8b, v25.8b, v27.8b
	mov	v25.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v24.8b, v26.8b
	uzp2	v26.8b, v24.8b, v26.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v25.8b, v9.8b
	umull	v2.8h, v26.8b, v10.8b
	umull	v3.8h, v27.8b, v11.8b
	umull	v12.8h, v11.8b, v25.8b
	umull	v13.8h, v11.8b, v24.8b
	umull	v14.8h, v11.8b, v26.8b
	urshr	v15.8h, v0.8h, #8
	urshr	v16.8h, v1.8h, #8
	urshr	v17.8h, v2.8h, #8
	raddhn	v0.8b, v0.8h, v15.8h
	raddhn	v1.8b, v1.8h, v16.8h
	raddhn	v2.8b, v2.8h, v17.8h
	urshr	v15.8h, v13.8h, #8
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v14.8h, #8
	urshr	v18.8h, v3.8h, #8
	raddhn	v24.8b, v13.8h, v15.8h
	raddhn	v25.8b, v12.8h, v16.8h
	raddhn	v26.8b, v14.8h, v17.8h
	raddhn	v3.8b, v3.8h, v18.8h
	mvn	v24.8b, v24.8b
	mvn	v25.8b, v25.8b
	mvn	v26.8b, v26.8b
	mvn	v27.8b, v3.8b
	umull	v12.8h, v24.8b, v4.8b
	umull	v13.8h, v25.8b, v5.8b
	umull	v14.8h, v26.8b, v6.8b
	umull	v15.8h, v27.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_925
	add	x10, x10, #8
	sub	x9, x9, #1
L_925
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x13, x15]
	b.le	L_926
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_926
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7, lsl #2
	ldrsb	x15, [x13]
L_926
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v13.8h, #8
	urshr	v18.8h, v14.8h, #8
	urshr	v19.8h, v15.8h, #8
	raddhn	v28.8b, v16.8h, v12.8h
	raddhn	v29.8b, v17.8h, v13.8h
	raddhn	v30.8b, v18.8h, v14.8h
	raddhn	v31.8b, v19.8h, v15.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_927
	st1	{ v30.2s, v31.2s }, [x2], #16
L_927
	tst	x0, #0x2
	b.eq	L_928
	st1	{ v29.2s }, [x2], #8
L_928
	tst	x0, #0x1
	b.eq	L_929
	st1	{ v28.s }[1], [x2], #4
L_929
L_921
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x6, x6, x7, lsl #2
	sub	x2, x2, x0, lsl #2
	sub	x6, x6, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_905
L_930
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_904
	lsl	x15, x3, #2
	prfm	pldl1keep, [x8, x15]
	lsl	x15, x7, #2
	prfm	pldl1keep, [x6, x15]
	tst	x0, #0x8
	b.eq	L_931
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld4	{ v24.8b, v25.8b, v26.8b, v27.8b }, [x6], #32
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v25.8b, v9.8b
	umull	v2.8h, v26.8b, v10.8b
	umull	v3.8h, v27.8b, v11.8b
	umull	v12.8h, v11.8b, v25.8b
	umull	v13.8h, v11.8b, v24.8b
	umull	v14.8h, v11.8b, v26.8b
	urshr	v15.8h, v0.8h, #8
	urshr	v16.8h, v1.8h, #8
	urshr	v17.8h, v2.8h, #8
	raddhn	v0.8b, v0.8h, v15.8h
	raddhn	v1.8b, v1.8h, v16.8h
	raddhn	v2.8b, v2.8h, v17.8h
	urshr	v15.8h, v13.8h, #8
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v14.8h, #8
	urshr	v18.8h, v3.8h, #8
	raddhn	v24.8b, v13.8h, v15.8h
	raddhn	v25.8b, v12.8h, v16.8h
	raddhn	v26.8b, v14.8h, v17.8h
	raddhn	v3.8b, v3.8h, v18.8h
	mvn	v24.8b, v24.8b
	mvn	v25.8b, v25.8b
	mvn	v26.8b, v26.8b
	mvn	v27.8b, v3.8b
	umull	v12.8h, v24.8b, v4.8b
	umull	v13.8h, v25.8b, v5.8b
	umull	v14.8h, v26.8b, v6.8b
	umull	v15.8h, v27.8b, v7.8b
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v13.8h, #8
	urshr	v18.8h, v14.8h, #8
	urshr	v19.8h, v15.8h, #8
	raddhn	v28.8b, v16.8h, v12.8h
	raddhn	v29.8b, v17.8h, v13.8h
	raddhn	v30.8b, v18.8h, v14.8h
	raddhn	v31.8b, v19.8h, v15.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
L_931
	tst	x0, #0x7
	b.eq	L_932
	tst	x0, #0x4
	b.eq	L_933
	ld1	{ v26.2s, v27.2s }, [x6], #16
	ld1	{ v6.2s, v7.2s }, [x8], #16
L_933
	tst	x0, #0x2
	b.eq	L_934
	ld1	{ v25.2s }, [x6], #8
	ld1	{ v5.2s }, [x8], #8
L_934
	tst	x0, #0x1
	b.eq	L_935
	ld1	{ v24.s }[1], [x6], #4
	ld1	{ v4.s }[1], [x8], #4
L_935
	umov	x15, v16.d[0]
	uzp1	v16.8b, v24.8b, v25.8b
	uzp2	v25.8b, v24.8b, v25.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v26.8b, v27.8b
	uzp2	v27.8b, v26.8b, v27.8b
	mov	v26.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v25.8b, v27.8b
	uzp2	v27.8b, v25.8b, v27.8b
	mov	v25.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v24.8b, v26.8b
	uzp2	v26.8b, v24.8b, v26.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v25.8b, v9.8b
	umull	v2.8h, v26.8b, v10.8b
	umull	v3.8h, v27.8b, v11.8b
	umull	v12.8h, v11.8b, v25.8b
	umull	v13.8h, v11.8b, v24.8b
	umull	v14.8h, v11.8b, v26.8b
	urshr	v15.8h, v0.8h, #8
	urshr	v16.8h, v1.8h, #8
	urshr	v17.8h, v2.8h, #8
	raddhn	v0.8b, v0.8h, v15.8h
	raddhn	v1.8b, v1.8h, v16.8h
	raddhn	v2.8b, v2.8h, v17.8h
	urshr	v15.8h, v13.8h, #8
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v14.8h, #8
	urshr	v18.8h, v3.8h, #8
	raddhn	v24.8b, v13.8h, v15.8h
	raddhn	v25.8b, v12.8h, v16.8h
	raddhn	v26.8b, v14.8h, v17.8h
	raddhn	v3.8b, v3.8h, v18.8h
	mvn	v24.8b, v24.8b
	mvn	v25.8b, v25.8b
	mvn	v26.8b, v26.8b
	mvn	v27.8b, v3.8b
	umull	v12.8h, v24.8b, v4.8b
	umull	v13.8h, v25.8b, v5.8b
	umull	v14.8h, v26.8b, v6.8b
	umull	v15.8h, v27.8b, v7.8b
	urshr	v16.8h, v12.8h, #8
	urshr	v17.8h, v13.8h, #8
	urshr	v18.8h, v14.8h, #8
	urshr	v19.8h, v15.8h, #8
	raddhn	v28.8b, v16.8h, v12.8h
	raddhn	v29.8b, v17.8h, v13.8h
	raddhn	v30.8b, v18.8h, v14.8h
	raddhn	v31.8b, v19.8h, v15.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_936
	st1	{ v30.2s, v31.2s }, [x2], #16
L_936
	tst	x0, #0x2
	b.eq	L_937
	st1	{ v29.2s }, [x2], #8
L_937
	tst	x0, #0x1
	b.eq	L_938
	st1	{ v28.s }[1], [x2], #4
L_938
L_932
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x6, x6, x7, lsl #2
	sub	x2, x2, x0, lsl #2
	sub	x6, x6, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_904
L_903
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_over_n_8888_0565_ca_asm_neon
pixman_composite_over_n_8888_0565_ca_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	mov	v13.s[0], w4
	dup	v8.8b, v13.b[0]
	dup	v9.8b, v13.b[1]
	dup	v10.8b, v13.b[2]
	dup	v11.8b, v13.b[3]
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_939
	cmp	x0, #16
	b.lt	L_940
L_941
	tst	x8, #0xf
	b.eq	L_942
	tst	x8, #0x2
	b.eq	L_943
	ld1	{ v24.s }[1], [x6], #4
	ld1	{ v4.h }[1], [x8], #2
	add	x10, x10, #1
	sub	x0, x0, #1
L_943
	tst	x8, #0x4
	b.eq	L_944
	ld1	{ v25.2s }, [x6], #8
	ld1	{ v4.h }[2], [x8], #2
	ld1	{ v4.h }[3], [x8], #2
	add	x10, x10, #2
	sub	x0, x0, #2
L_944
	tst	x8, #0x8
	b.eq	L_945
	ld1	{ v26.2s, v27.2s }, [x6], #16
	ld1	{ v5.4h }, [x8], #8
	add	x10, x10, #4
	sub	x0, x0, #4
L_945
	umov	x15, v16.d[0]
	uzp1	v16.8b, v24.8b, v25.8b
	uzp2	v25.8b, v24.8b, v25.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v26.8b, v27.8b
	uzp2	v27.8b, v26.8b, v27.8b
	mov	v26.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v25.8b, v27.8b
	uzp2	v27.8b, v25.8b, v27.8b
	mov	v25.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v24.8b, v26.8b
	uzp2	v26.8b, v24.8b, v26.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x15
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v25.8b, v9.8b
	umull	v2.8h, v26.8b, v10.8b
	umull	v12.8h, v11.8b, v24.8b
	umull	v13.8h, v11.8b, v25.8b
	umull	v14.8h, v11.8b, v26.8b
	urshr	v15.8h, v0.8h, #8
	urshr	v16.8h, v1.8h, #8
	urshr	v17.8h, v2.8h, #8
	raddhn	v0.8b, v0.8h, v15.8h
	raddhn	v1.8b, v1.8h, v16.8h
	raddhn	v2.8b, v2.8h, v17.8h
	urshr	v19.8h, v12.8h, #8
	urshr	v20.8h, v13.8h, #8
	urshr	v21.8h, v14.8h, #8
	raddhn	v24.8b, v12.8h, v19.8h
	raddhn	v25.8b, v13.8h, v20.8h
	mov	v4.d[1], v5.d[0]
	shrn	v17.8b, v4.8h, #3
	shrn	v18.8b, v4.8h, #8
	raddhn	v26.8b, v14.8h, v21.8h
	sli	v4.8h, v4.8h, #5
	sri	v18.8b, v18.8b, #5
	sri	v17.8b, v17.8b, #6
	mvn	v24.8b, v24.8b
	mvn	v25.8b, v25.8b
	shrn	v16.8b, v4.8h, #2
	mvn	v26.8b, v26.8b
	umull	v5.8h, v16.8b, v24.8b
	umull	v6.8h, v17.8b, v25.8b
	umull	v7.8h, v18.8b, v26.8b
	tst	x9, #0xf
	b.eq	L_946
	add	x10, x10, #8
	sub	x9, x9, #1
L_946
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x13, x15]
	b.le	L_947
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_947
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
	add	x13, x13, x7, lsl #2
	ldrsb	x15, [x13]
L_947
	urshr	v13.8h, v5.8h, #8
	urshr	v14.8h, v6.8h, #8
	urshr	v15.8h, v7.8h, #8
	raddhn	v16.8b, v13.8h, v5.8h
	raddhn	v17.8b, v14.8h, v6.8h
	raddhn	v18.8b, v15.8h, v7.8h
	uqadd	v16.8b, v0.8b, v16.8b
	uqadd	v17.8b, v1.8b, v17.8b
	uqadd	v18.8b, v2.8b, v18.8b
	ushll	v14.8h, v18.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v12.8h, v17.8b, #7
	sli	v12.8h, v12.8h, #1
	ushll	v13.8h, v16.8b, #7
	sli	v13.8h, v13.8h, #1
	sri	v14.8h, v12.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x2, #0x2
	b.eq	L_948
	st1	{ v28.h }[1], [x2], #2
L_948
	tst	x2, #0x4
	b.eq	L_949
	st1	{ v28.s }[1], [x2], #4
L_949
	tst	x2, #0x8
	b.eq	L_950
	st1	{ v29.4h }, [x2], #8
L_950
L_942
	ld1	{ v4.4h, v5.4h }, [x8], #16
	ld4	{ v24.8b, v25.8b, v26.8b, v27.8b }, [x6], #32
	add	x10, x10, #8
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v25.8b, v9.8b
	umull	v2.8h, v26.8b, v10.8b
	umull	v12.8h, v11.8b, v24.8b
	umull	v13.8h, v11.8b, v25.8b
	umull	v14.8h, v11.8b, v26.8b
	urshr	v15.8h, v0.8h, #8
	urshr	v16.8h, v1.8h, #8
	urshr	v17.8h, v2.8h, #8
	raddhn	v0.8b, v0.8h, v15.8h
	raddhn	v1.8b, v1.8h, v16.8h
	raddhn	v2.8b, v2.8h, v17.8h
	urshr	v19.8h, v12.8h, #8
	urshr	v20.8h, v13.8h, #8
	urshr	v21.8h, v14.8h, #8
	raddhn	v24.8b, v12.8h, v19.8h
	raddhn	v25.8b, v13.8h, v20.8h
	mov	v4.d[1], v5.d[0]
	shrn	v17.8b, v4.8h, #3
	shrn	v18.8b, v4.8h, #8
	raddhn	v26.8b, v14.8h, v21.8h
	sli	v4.8h, v4.8h, #5
	sri	v18.8b, v18.8b, #5
	sri	v17.8b, v17.8b, #6
	mvn	v24.8b, v24.8b
	mvn	v25.8b, v25.8b
	shrn	v16.8b, v4.8h, #2
	mvn	v26.8b, v26.8b
	umull	v5.8h, v16.8b, v24.8b
	umull	v6.8h, v17.8b, v25.8b
	umull	v7.8h, v18.8b, v26.8b
	tst	x9, #0xf
	b.eq	L_951
	add	x10, x10, #8
	sub	x9, x9, #1
L_951
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x13, x15]
	b.le	L_952
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_952
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
	add	x13, x13, x7, lsl #2
	ldrsb	x15, [x13]
L_952
	subs	x0, x0, #16
	b.lt	L_953
L_954
	ld4	{ v24.8b, v25.8b, v26.8b, v27.8b }, [x6], #32
	urshr	v13.8h, v5.8h, #8
	urshr	v14.8h, v6.8h, #8
	ld1	{ v4.8h }, [x8], #16
	urshr	v15.8h, v7.8h, #8
	raddhn	v16.8b, v13.8h, v5.8h
	raddhn	v17.8b, v14.8h, v6.8h
	raddhn	v18.8b, v15.8h, v7.8h
	mov	v5.d[0], v4.d[1]
	uqadd	v16.8b, v0.8b, v16.8b
	uqadd	v17.8b, v1.8b, v17.8b
	uqadd	v18.8b, v2.8b, v18.8b
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v25.8b, v9.8b
	umull	v2.8h, v26.8b, v10.8b
	ushll	v14.8h, v18.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v16.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v17.8b, #7
	sli	v19.8h, v19.8h, #1
	umull	v12.8h, v11.8b, v24.8b
	sri	v14.8h, v19.8h, #5
	umull	v13.8h, v11.8b, v25.8b
	umull	v15.8h, v11.8b, v26.8b
	sri	v14.8h, v18.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	add	x10, x10, #8
	tst	x9, #0xf
	b.eq	L_955
	add	x10, x10, #8
	sub	x9, x9, #1
L_955
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x13, x15]
	b.le	L_956
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_956
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
	add	x13, x13, x7, lsl #2
	ldrsb	x15, [x13]
L_956
	urshr	v16.8h, v0.8h, #8
	urshr	v17.8h, v1.8h, #8
	urshr	v18.8h, v2.8h, #8
	raddhn	v0.8b, v0.8h, v16.8h
	raddhn	v1.8b, v1.8h, v17.8h
	raddhn	v2.8b, v2.8h, v18.8h
	urshr	v19.8h, v12.8h, #8
	urshr	v20.8h, v13.8h, #8
	urshr	v21.8h, v15.8h, #8
	raddhn	v24.8b, v12.8h, v19.8h
	raddhn	v25.8b, v13.8h, v20.8h
	mov	v4.d[1], v5.d[0]
	shrn	v17.8b, v4.8h, #3
	shrn	v18.8b, v4.8h, #8
	raddhn	v26.8b, v15.8h, v21.8h
	sli	v4.8h, v4.8h, #5
	sri	v17.8b, v17.8b, #6
	sri	v18.8b, v18.8b, #5
	mvn	v24.8b, v24.8b
	mvn	v25.8b, v25.8b
	shrn	v16.8b, v4.8h, #2
	mvn	v26.8b, v26.8b
	umull	v5.8h, v16.8b, v24.8b
	umull	v6.8h, v17.8b, v25.8b
	umull	v7.8h, v18.8b, v26.8b
	st1	{ v14.8h }, [x2], #16
	subs	x0, x0, #8
	b.ge	L_954
L_953
	urshr	v13.8h, v5.8h, #8
	urshr	v14.8h, v6.8h, #8
	urshr	v15.8h, v7.8h, #8
	raddhn	v16.8b, v13.8h, v5.8h
	raddhn	v17.8b, v14.8h, v6.8h
	raddhn	v18.8b, v15.8h, v7.8h
	uqadd	v16.8b, v0.8b, v16.8b
	uqadd	v17.8b, v1.8b, v17.8b
	uqadd	v18.8b, v2.8b, v18.8b
	ushll	v14.8h, v18.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v12.8h, v17.8b, #7
	sli	v12.8h, v12.8h, #1
	ushll	v13.8h, v16.8b, #7
	sli	v13.8h, v13.8h, #1
	sri	v14.8h, v12.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
	tst	x0, #0x7
	b.eq	L_957
	tst	x0, #0x4
	b.eq	L_958
	ld1	{ v26.2s, v27.2s }, [x6], #16
	ld1	{ v5.4h }, [x8], #8
	add	x10, x10, #4
L_958
	tst	x0, #0x2
	b.eq	L_959
	ld1	{ v25.2s }, [x6], #8
	ld1	{ v4.h }[2], [x8], #2
	ld1	{ v4.h }[3], [x8], #2
	add	x10, x10, #2
L_959
	tst	x0, #0x1
	b.eq	L_960
	ld1	{ v24.s }[1], [x6], #4
	ld1	{ v4.h }[1], [x8], #2
	add	x10, x10, #1
L_960
	umov	x15, v16.d[0]
	uzp1	v16.8b, v24.8b, v25.8b
	uzp2	v25.8b, v24.8b, v25.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v26.8b, v27.8b
	uzp2	v27.8b, v26.8b, v27.8b
	mov	v26.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v25.8b, v27.8b
	uzp2	v27.8b, v25.8b, v27.8b
	mov	v25.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v24.8b, v26.8b
	uzp2	v26.8b, v24.8b, v26.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x15
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v25.8b, v9.8b
	umull	v2.8h, v26.8b, v10.8b
	umull	v12.8h, v11.8b, v24.8b
	umull	v13.8h, v11.8b, v25.8b
	umull	v14.8h, v11.8b, v26.8b
	urshr	v15.8h, v0.8h, #8
	urshr	v16.8h, v1.8h, #8
	urshr	v17.8h, v2.8h, #8
	raddhn	v0.8b, v0.8h, v15.8h
	raddhn	v1.8b, v1.8h, v16.8h
	raddhn	v2.8b, v2.8h, v17.8h
	urshr	v19.8h, v12.8h, #8
	urshr	v20.8h, v13.8h, #8
	urshr	v21.8h, v14.8h, #8
	raddhn	v24.8b, v12.8h, v19.8h
	raddhn	v25.8b, v13.8h, v20.8h
	mov	v4.d[1], v5.d[0]
	shrn	v17.8b, v4.8h, #3
	shrn	v18.8b, v4.8h, #8
	raddhn	v26.8b, v14.8h, v21.8h
	sli	v4.8h, v4.8h, #5
	sri	v18.8b, v18.8b, #5
	sri	v17.8b, v17.8b, #6
	mvn	v24.8b, v24.8b
	mvn	v25.8b, v25.8b
	shrn	v16.8b, v4.8h, #2
	mvn	v26.8b, v26.8b
	umull	v5.8h, v16.8b, v24.8b
	umull	v6.8h, v17.8b, v25.8b
	umull	v7.8h, v18.8b, v26.8b
	tst	x9, #0xf
	b.eq	L_961
	add	x10, x10, #8
	sub	x9, x9, #1
L_961
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x13, x15]
	b.le	L_962
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_962
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
	add	x13, x13, x7, lsl #2
	ldrsb	x15, [x13]
L_962
	urshr	v13.8h, v5.8h, #8
	urshr	v14.8h, v6.8h, #8
	urshr	v15.8h, v7.8h, #8
	raddhn	v16.8b, v13.8h, v5.8h
	raddhn	v17.8b, v14.8h, v6.8h
	raddhn	v18.8b, v15.8h, v7.8h
	uqadd	v16.8b, v0.8b, v16.8b
	uqadd	v17.8b, v1.8b, v17.8b
	uqadd	v18.8b, v2.8b, v18.8b
	ushll	v14.8h, v18.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v12.8h, v17.8b, #7
	sli	v12.8h, v12.8h, #1
	ushll	v13.8h, v16.8b, #7
	sli	v13.8h, v13.8h, #1
	sri	v14.8h, v12.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_963
	st1	{ v29.4h }, [x2], #8
L_963
	tst	x0, #0x2
	b.eq	L_964
	st1	{ v28.s }[1], [x2], #4
L_964
	tst	x0, #0x1
	b.eq	L_965
	st1	{ v28.h }[1], [x2], #2
L_965
L_957
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x6, x6, x7, lsl #2
	sub	x2, x2, x0, lsl #1
	sub	x6, x6, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_941
L_966
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_940
	lsl	x15, x3, #1
	prfm	pldl1keep, [x8, x15]
	lsl	x15, x7, #2
	prfm	pldl1keep, [x6, x15]
	tst	x0, #0x8
	b.eq	L_967
	ld1	{ v4.4h, v5.4h }, [x8], #16
	ld4	{ v24.8b, v25.8b, v26.8b, v27.8b }, [x6], #32
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v25.8b, v9.8b
	umull	v2.8h, v26.8b, v10.8b
	umull	v12.8h, v11.8b, v24.8b
	umull	v13.8h, v11.8b, v25.8b
	umull	v14.8h, v11.8b, v26.8b
	urshr	v15.8h, v0.8h, #8
	urshr	v16.8h, v1.8h, #8
	urshr	v17.8h, v2.8h, #8
	raddhn	v0.8b, v0.8h, v15.8h
	raddhn	v1.8b, v1.8h, v16.8h
	raddhn	v2.8b, v2.8h, v17.8h
	urshr	v19.8h, v12.8h, #8
	urshr	v20.8h, v13.8h, #8
	urshr	v21.8h, v14.8h, #8
	raddhn	v24.8b, v12.8h, v19.8h
	raddhn	v25.8b, v13.8h, v20.8h
	mov	v4.d[1], v5.d[0]
	shrn	v17.8b, v4.8h, #3
	shrn	v18.8b, v4.8h, #8
	raddhn	v26.8b, v14.8h, v21.8h
	sli	v4.8h, v4.8h, #5
	sri	v18.8b, v18.8b, #5
	sri	v17.8b, v17.8b, #6
	mvn	v24.8b, v24.8b
	mvn	v25.8b, v25.8b
	shrn	v16.8b, v4.8h, #2
	mvn	v26.8b, v26.8b
	umull	v5.8h, v16.8b, v24.8b
	umull	v6.8h, v17.8b, v25.8b
	umull	v7.8h, v18.8b, v26.8b
	urshr	v13.8h, v5.8h, #8
	urshr	v14.8h, v6.8h, #8
	urshr	v15.8h, v7.8h, #8
	raddhn	v16.8b, v13.8h, v5.8h
	raddhn	v17.8b, v14.8h, v6.8h
	raddhn	v18.8b, v15.8h, v7.8h
	uqadd	v16.8b, v0.8b, v16.8b
	uqadd	v17.8b, v1.8b, v17.8b
	uqadd	v18.8b, v2.8b, v18.8b
	ushll	v14.8h, v18.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v12.8h, v17.8b, #7
	sli	v12.8h, v12.8h, #1
	ushll	v13.8h, v16.8b, #7
	sli	v13.8h, v13.8h, #1
	sri	v14.8h, v12.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
L_967
	tst	x0, #0x7
	b.eq	L_968
	tst	x0, #0x4
	b.eq	L_969
	ld1	{ v26.2s, v27.2s }, [x6], #16
	ld1	{ v5.4h }, [x8], #8
L_969
	tst	x0, #0x2
	b.eq	L_970
	ld1	{ v25.2s }, [x6], #8
	ld1	{ v4.h }[2], [x8], #2
	ld1	{ v4.h }[3], [x8], #2
L_970
	tst	x0, #0x1
	b.eq	L_971
	ld1	{ v24.s }[1], [x6], #4
	ld1	{ v4.h }[1], [x8], #2
L_971
	umov	x15, v16.d[0]
	uzp1	v16.8b, v24.8b, v25.8b
	uzp2	v25.8b, v24.8b, v25.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v26.8b, v27.8b
	uzp2	v27.8b, v26.8b, v27.8b
	mov	v26.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v25.8b, v27.8b
	uzp2	v27.8b, v25.8b, v27.8b
	mov	v25.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v24.8b, v26.8b
	uzp2	v26.8b, v24.8b, v26.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x15
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v25.8b, v9.8b
	umull	v2.8h, v26.8b, v10.8b
	umull	v12.8h, v11.8b, v24.8b
	umull	v13.8h, v11.8b, v25.8b
	umull	v14.8h, v11.8b, v26.8b
	urshr	v15.8h, v0.8h, #8
	urshr	v16.8h, v1.8h, #8
	urshr	v17.8h, v2.8h, #8
	raddhn	v0.8b, v0.8h, v15.8h
	raddhn	v1.8b, v1.8h, v16.8h
	raddhn	v2.8b, v2.8h, v17.8h
	urshr	v19.8h, v12.8h, #8
	urshr	v20.8h, v13.8h, #8
	urshr	v21.8h, v14.8h, #8
	raddhn	v24.8b, v12.8h, v19.8h
	raddhn	v25.8b, v13.8h, v20.8h
	mov	v4.d[1], v5.d[0]
	shrn	v17.8b, v4.8h, #3
	shrn	v18.8b, v4.8h, #8
	raddhn	v26.8b, v14.8h, v21.8h
	sli	v4.8h, v4.8h, #5
	sri	v18.8b, v18.8b, #5
	sri	v17.8b, v17.8b, #6
	mvn	v24.8b, v24.8b
	mvn	v25.8b, v25.8b
	shrn	v16.8b, v4.8h, #2
	mvn	v26.8b, v26.8b
	umull	v5.8h, v16.8b, v24.8b
	umull	v6.8h, v17.8b, v25.8b
	umull	v7.8h, v18.8b, v26.8b
	urshr	v13.8h, v5.8h, #8
	urshr	v14.8h, v6.8h, #8
	urshr	v15.8h, v7.8h, #8
	raddhn	v16.8b, v13.8h, v5.8h
	raddhn	v17.8b, v14.8h, v6.8h
	raddhn	v18.8b, v15.8h, v7.8h
	uqadd	v16.8b, v0.8b, v16.8b
	uqadd	v17.8b, v1.8b, v17.8b
	uqadd	v18.8b, v2.8b, v18.8b
	ushll	v14.8h, v18.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v12.8h, v17.8b, #7
	sli	v12.8h, v12.8h, #1
	ushll	v13.8h, v16.8b, #7
	sli	v13.8h, v13.8h, #1
	sri	v14.8h, v12.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_972
	st1	{ v29.4h }, [x2], #8
L_972
	tst	x0, #0x2
	b.eq	L_973
	st1	{ v28.h }[2], [x2], #2
	st1	{ v28.h }[3], [x2], #2
L_973
	tst	x0, #0x1
	b.eq	L_974
	st1	{ v28.h }[1], [x2], #2
L_974
L_968
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x6, x6, x7, lsl #2
	sub	x2, x2, x0, lsl #1
	sub	x6, x6, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_940
L_939
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_in_n_8_asm_neon
pixman_composite_in_n_8_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	mov	v3.s[0], w4
	dup	v3.8b, v3.b[3]
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_975
	cmp	x0, #64
	b.lt	L_976
L_977
	tst	x8, #0xf
	b.eq	L_978
	tst	x8, #0x1
	b.eq	L_979
	ld1	{ v4.b }[1], [x8], #1
	add	x10, x10, #1
	sub	x0, x0, #1
L_979
	tst	x8, #0x2
	b.eq	L_980
	ld1	{ v4.b }[2], [x8], #1
	ld1	{ v4.b }[3], [x8], #1
	add	x10, x10, #2
	sub	x0, x0, #2
L_980
	tst	x8, #0x4
	b.eq	L_981
	ld1	{ v4.b }[4], [x8], #1
	ld1	{ v4.b }[5], [x8], #1
	ld1	{ v4.b }[6], [x8], #1
	ld1	{ v4.b }[7], [x8], #1
	add	x10, x10, #4
	sub	x0, x0, #4
L_981
	tst	x8, #0x8
	b.eq	L_982
	ld1	{ v5.8b }, [x8], #8
	add	x10, x10, #8
	sub	x0, x0, #8
L_982
	ld1	{ v6.8b, v7.8b }, [x8], #16
	add	x10, x10, #16
	sub	x0, x0, #16
L_983
	umull	v8.8h, v4.8b, v3.8b
	umull	v9.8h, v5.8b, v3.8b
	umull	v10.8h, v6.8b, v3.8b
	umull	v11.8h, v7.8b, v3.8b
	tst	x9, #0xf
	b.eq	L_984
	add	x10, x10, #32
	sub	x9, x9, #1
L_984
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x12, x15]
	b.le	L_985
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_985
	add	x12, x12, x3
	ldrsb	x15, [x12]
L_985
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v12.8h, v10.8h, #8
	urshr	v13.8h, v11.8h, #8
	raddhn	v28.8b, v8.8h, v14.8h
	raddhn	v29.8b, v9.8h, v15.8h
	raddhn	v30.8b, v10.8h, v12.8h
	raddhn	v31.8b, v11.8h, v13.8h
	tst	x2, #0x1
	b.eq	L_986
	st1	{ v28.b }[1], [x2], #1
L_986
	tst	x2, #0x2
	b.eq	L_987
	st1	{ v28.h }[1], [x2], #2
L_987
	tst	x2, #0x4
	b.eq	L_988
	st1	{ v28.s }[1], [x2], #4
L_988
	tst	x2, #0x8
	b.eq	L_989
	st1	{ v29.8b }, [x2], #8
L_989
	st1	{ v30.8b, v31.8b }, [x2], #16
L_990
L_978
	ld1	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	add	x10, x10, #32
	umull	v8.8h, v4.8b, v3.8b
	umull	v9.8h, v5.8b, v3.8b
	umull	v10.8h, v6.8b, v3.8b
	umull	v11.8h, v7.8b, v3.8b
	tst	x9, #0xf
	b.eq	L_991
	add	x10, x10, #32
	sub	x9, x9, #1
L_991
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x12, x15]
	b.le	L_992
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_992
	add	x12, x12, x3
	ldrsb	x15, [x12]
L_992
	subs	x0, x0, #64
	b.lt	L_993
L_994
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v12.8h, v10.8h, #8
	urshr	v13.8h, v11.8h, #8
	raddhn	v28.8b, v8.8h, v14.8h
	raddhn	v29.8b, v9.8h, v15.8h
	raddhn	v30.8b, v10.8h, v12.8h
	raddhn	v31.8b, v11.8h, v13.8h
	ld1	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	add	x10, x10, #32
	tst	x9, #0xf
	b.eq	L_995
	add	x10, x10, #32
	sub	x9, x9, #1
L_995
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x12, x15]
	b.le	L_996
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_996
	add	x12, x12, x3
	ldrsb	x15, [x12]
L_996
	umull	v8.8h, v4.8b, v3.8b
	umull	v9.8h, v5.8b, v3.8b
	umull	v10.8h, v6.8b, v3.8b
	umull	v11.8h, v7.8b, v3.8b
	st1	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	subs	x0, x0, #32
	b.ge	L_994
L_993
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v12.8h, v10.8h, #8
	urshr	v13.8h, v11.8h, #8
	raddhn	v28.8b, v8.8h, v14.8h
	raddhn	v29.8b, v9.8h, v15.8h
	raddhn	v30.8b, v10.8h, v12.8h
	raddhn	v31.8b, v11.8h, v13.8h
	st1	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	tst	x0, #0x1f
	b.eq	L_997
	tst	x0, #0x10
	b.eq	L_998
	ld1	{ v6.8b, v7.8b }, [x8], #16
	add	x10, x10, #16
L_998
	tst	x0, #0x8
	b.eq	L_999
	ld1	{ v5.8b }, [x8], #8
	add	x10, x10, #8
L_999
	tst	x0, #0x4
	b.eq	L_1000
	ld1	{ v4.b }[4], [x8], #1
	ld1	{ v4.b }[5], [x8], #1
	ld1	{ v4.b }[6], [x8], #1
	ld1	{ v4.b }[7], [x8], #1
	add	x10, x10, #4
L_1000
	tst	x0, #0x2
	b.eq	L_1001
	ld1	{ v4.b }[2], [x8], #1
	ld1	{ v4.b }[3], [x8], #1
	add	x10, x10, #2
L_1001
	tst	x0, #0x1
	b.eq	L_1002
	ld1	{ v4.b }[1], [x8], #1
	add	x10, x10, #1
L_1002
	umull	v8.8h, v4.8b, v3.8b
	umull	v9.8h, v5.8b, v3.8b
	umull	v10.8h, v6.8b, v3.8b
	umull	v11.8h, v7.8b, v3.8b
	tst	x9, #0xf
	b.eq	L_1003
	add	x10, x10, #32
	sub	x9, x9, #1
L_1003
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x12, x15]
	b.le	L_1004
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1004
	add	x12, x12, x3
	ldrsb	x15, [x12]
L_1004
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v12.8h, v10.8h, #8
	urshr	v13.8h, v11.8h, #8
	raddhn	v28.8b, v8.8h, v14.8h
	raddhn	v29.8b, v9.8h, v15.8h
	raddhn	v30.8b, v10.8h, v12.8h
	raddhn	v31.8b, v11.8h, v13.8h
	tst	x0, #0x10
	b.eq	L_1005
	st1	{ v30.8b, v31.8b }, [x2], #16
L_1005
	tst	x0, #0x8
	b.eq	L_1006
	st1	{ v29.8b }, [x2], #8
L_1006
	tst	x0, #0x4
	b.eq	L_1007
	st1	{ v28.s }[1], [x2], #4
L_1007
	tst	x0, #0x2
	b.eq	L_1008
	st1	{ v28.h }[1], [x2], #2
L_1008
	tst	x0, #0x1
	b.eq	L_1009
	st1	{ v28.b }[1], [x2], #1
L_1009
L_997
	mov	x0, x14
	add	x2, x2, x3
	sub	x2, x2, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_977
L_1010
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_976
	lsr	x15, x3, #0
	prfm	pldl1keep, [x8, x15]
	tst	x0, #0x20
	b.eq	L_1011
	ld1	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	umull	v8.8h, v4.8b, v3.8b
	umull	v9.8h, v5.8b, v3.8b
	umull	v10.8h, v6.8b, v3.8b
	umull	v11.8h, v7.8b, v3.8b
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v12.8h, v10.8h, #8
	urshr	v13.8h, v11.8h, #8
	raddhn	v28.8b, v8.8h, v14.8h
	raddhn	v29.8b, v9.8h, v15.8h
	raddhn	v30.8b, v10.8h, v12.8h
	raddhn	v31.8b, v11.8h, v13.8h
	st1	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
L_1011
	tst	x0, #0x1f
	b.eq	L_1012
	tst	x0, #0x10
	b.eq	L_1013
	ld1	{ v6.8b, v7.8b }, [x8], #16
L_1013
	tst	x0, #0x8
	b.eq	L_1014
	ld1	{ v5.8b }, [x8], #8
L_1014
	tst	x0, #0x4
	b.eq	L_1015
	ld1	{ v4.b }[4], [x8], #1
	ld1	{ v4.b }[5], [x8], #1
	ld1	{ v4.b }[6], [x8], #1
	ld1	{ v4.b }[7], [x8], #1
L_1015
	tst	x0, #0x2
	b.eq	L_1016
	ld1	{ v4.b }[2], [x8], #1
	ld1	{ v4.b }[3], [x8], #1
L_1016
	tst	x0, #0x1
	b.eq	L_1017
	ld1	{ v4.b }[1], [x8], #1
L_1017
	umull	v8.8h, v4.8b, v3.8b
	umull	v9.8h, v5.8b, v3.8b
	umull	v10.8h, v6.8b, v3.8b
	umull	v11.8h, v7.8b, v3.8b
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v12.8h, v10.8h, #8
	urshr	v13.8h, v11.8h, #8
	raddhn	v28.8b, v8.8h, v14.8h
	raddhn	v29.8b, v9.8h, v15.8h
	raddhn	v30.8b, v10.8h, v12.8h
	raddhn	v31.8b, v11.8h, v13.8h
	tst	x0, #0x10
	b.eq	L_1018
	st1	{ v30.8b, v31.8b }, [x2], #16
L_1018
	tst	x0, #0x8
	b.eq	L_1019
	st1	{ v29.8b }, [x2], #8
L_1019
	tst	x0, #0x4
	b.eq	L_1020
	st1	{ v28.b }[4], [x2], #1
	st1	{ v28.b }[5], [x2], #1
	st1	{ v28.b }[6], [x2], #1
	st1	{ v28.b }[7], [x2], #1
L_1020
	tst	x0, #0x2
	b.eq	L_1021
	st1	{ v28.b }[2], [x2], #1
	st1	{ v28.b }[3], [x2], #1
L_1021
	tst	x0, #0x1
	b.eq	L_1022
	st1	{ v28.b }[1], [x2], #1
L_1022
L_1012
	mov	x0, x14
	add	x2, x2, x3
	sub	x2, x2, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_976
L_975
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_add_n_8_8_asm_neon
pixman_composite_add_n_8_8_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	mov	v11.s[0], w4
	dup	v11.8b, v11.b[3]
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_1023
	cmp	x0, #64
	b.lt	L_1024
L_1025
	tst	x8, #0xf
	b.eq	L_1026
	tst	x8, #0x1
	b.eq	L_1027
	ld1	{ v24.b }[1], [x6], #1
	ld1	{ v4.b }[1], [x8], #1
	add	x10, x10, #1
	sub	x0, x0, #1
L_1027
	tst	x8, #0x2
	b.eq	L_1028
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	ld1	{ v4.b }[2], [x8], #1
	ld1	{ v4.b }[3], [x8], #1
	add	x10, x10, #2
	sub	x0, x0, #2
L_1028
	tst	x8, #0x4
	b.eq	L_1029
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	ld1	{ v4.b }[4], [x8], #1
	ld1	{ v4.b }[5], [x8], #1
	ld1	{ v4.b }[6], [x8], #1
	ld1	{ v4.b }[7], [x8], #1
	add	x10, x10, #4
	sub	x0, x0, #4
L_1029
	tst	x8, #0x8
	b.eq	L_1030
	ld1	{ v25.8b }, [x6], #8
	ld1	{ v5.8b }, [x8], #8
	add	x10, x10, #8
	sub	x0, x0, #8
L_1030
	ld1	{ v26.8b, v27.8b }, [x6], #16
	ld1	{ v6.8b, v7.8b }, [x8], #16
	add	x10, x10, #16
	sub	x0, x0, #16
L_1031
	umull	v0.8h, v24.8b, v11.8b
	umull	v1.8h, v25.8b, v11.8b
	umull	v2.8h, v26.8b, v11.8b
	umull	v3.8h, v27.8b, v11.8b
	urshr	v12.8h, v0.8h, #8
	urshr	v13.8h, v1.8h, #8
	urshr	v14.8h, v2.8h, #8
	urshr	v15.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v12.8h
	raddhn	v1.8b, v1.8h, v13.8h
	raddhn	v2.8b, v2.8h, v14.8h
	raddhn	v3.8b, v3.8h, v15.8h
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_1032
	add	x10, x10, #32
	sub	x9, x9, #1
L_1032
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1033
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1033
	add	x12, x12, x3
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1033
	tst	x2, #0x1
	b.eq	L_1034
	st1	{ v28.b }[1], [x2], #1
L_1034
	tst	x2, #0x2
	b.eq	L_1035
	st1	{ v28.h }[1], [x2], #2
L_1035
	tst	x2, #0x4
	b.eq	L_1036
	st1	{ v28.s }[1], [x2], #4
L_1036
	tst	x2, #0x8
	b.eq	L_1037
	st1	{ v29.8b }, [x2], #8
L_1037
	st1	{ v30.8b, v31.8b }, [x2], #16
L_1038
L_1026
	ld1	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld1	{ v24.8b, v25.8b, v26.8b, v27.8b }, [x6], #32
	add	x10, x10, #32
	umull	v0.8h, v24.8b, v11.8b
	umull	v1.8h, v25.8b, v11.8b
	umull	v2.8h, v26.8b, v11.8b
	umull	v3.8h, v27.8b, v11.8b
	urshr	v12.8h, v0.8h, #8
	urshr	v13.8h, v1.8h, #8
	urshr	v14.8h, v2.8h, #8
	urshr	v15.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v12.8h
	raddhn	v1.8b, v1.8h, v13.8h
	raddhn	v2.8b, v2.8h, v14.8h
	raddhn	v3.8b, v3.8h, v15.8h
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_1039
	add	x10, x10, #32
	sub	x9, x9, #1
L_1039
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1040
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1040
	add	x12, x12, x3
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1040
	subs	x0, x0, #64
	b.lt	L_1041
L_1042
	st1	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	ld1	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld1	{ v24.8b, v25.8b, v26.8b, v27.8b }, [x6], #32
	add	x10, x10, #32
	tst	x9, #0xf
	b.eq	L_1043
	add	x10, x10, #32
	sub	x9, x9, #1
L_1043
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1044
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1044
	add	x12, x12, x3
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1044
	umull	v0.8h, v24.8b, v11.8b
	umull	v1.8h, v25.8b, v11.8b
	umull	v2.8h, v26.8b, v11.8b
	umull	v3.8h, v27.8b, v11.8b
	urshr	v12.8h, v0.8h, #8
	urshr	v13.8h, v1.8h, #8
	urshr	v14.8h, v2.8h, #8
	urshr	v15.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v12.8h
	raddhn	v1.8b, v1.8h, v13.8h
	raddhn	v2.8b, v2.8h, v14.8h
	raddhn	v3.8b, v3.8h, v15.8h
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	subs	x0, x0, #32
	b.ge	L_1042
L_1041
	st1	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	tst	x0, #0x1f
	b.eq	L_1045
	tst	x0, #0x10
	b.eq	L_1046
	ld1	{ v26.8b, v27.8b }, [x6], #16
	ld1	{ v6.8b, v7.8b }, [x8], #16
	add	x10, x10, #16
L_1046
	tst	x0, #0x8
	b.eq	L_1047
	ld1	{ v25.8b }, [x6], #8
	ld1	{ v5.8b }, [x8], #8
	add	x10, x10, #8
L_1047
	tst	x0, #0x4
	b.eq	L_1048
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	ld1	{ v4.b }[4], [x8], #1
	ld1	{ v4.b }[5], [x8], #1
	ld1	{ v4.b }[6], [x8], #1
	ld1	{ v4.b }[7], [x8], #1
	add	x10, x10, #4
L_1048
	tst	x0, #0x2
	b.eq	L_1049
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	ld1	{ v4.b }[2], [x8], #1
	ld1	{ v4.b }[3], [x8], #1
	add	x10, x10, #2
L_1049
	tst	x0, #0x1
	b.eq	L_1050
	ld1	{ v24.b }[1], [x6], #1
	ld1	{ v4.b }[1], [x8], #1
	add	x10, x10, #1
L_1050
	umull	v0.8h, v24.8b, v11.8b
	umull	v1.8h, v25.8b, v11.8b
	umull	v2.8h, v26.8b, v11.8b
	umull	v3.8h, v27.8b, v11.8b
	urshr	v12.8h, v0.8h, #8
	urshr	v13.8h, v1.8h, #8
	urshr	v14.8h, v2.8h, #8
	urshr	v15.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v12.8h
	raddhn	v1.8b, v1.8h, v13.8h
	raddhn	v2.8b, v2.8h, v14.8h
	raddhn	v3.8b, v3.8h, v15.8h
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_1051
	add	x10, x10, #32
	sub	x9, x9, #1
L_1051
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1052
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1052
	add	x12, x12, x3
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1052
	tst	x0, #0x10
	b.eq	L_1053
	st1	{ v30.8b, v31.8b }, [x2], #16
L_1053
	tst	x0, #0x8
	b.eq	L_1054
	st1	{ v29.8b }, [x2], #8
L_1054
	tst	x0, #0x4
	b.eq	L_1055
	st1	{ v28.s }[1], [x2], #4
L_1055
	tst	x0, #0x2
	b.eq	L_1056
	st1	{ v28.h }[1], [x2], #2
L_1056
	tst	x0, #0x1
	b.eq	L_1057
	st1	{ v28.b }[1], [x2], #1
L_1057
L_1045
	mov	x0, x14
	add	x2, x2, x3
	add	x6, x6, x7
	sub	x2, x2, x0
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1025
L_1058
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1024
	lsr	x15, x3, #0
	prfm	pldl1keep, [x8, x15]
	lsr	x15, x7, #0
	prfm	pldl1keep, [x6, x15]
	tst	x0, #0x20
	b.eq	L_1059
	ld1	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld1	{ v24.8b, v25.8b, v26.8b, v27.8b }, [x6], #32
	umull	v0.8h, v24.8b, v11.8b
	umull	v1.8h, v25.8b, v11.8b
	umull	v2.8h, v26.8b, v11.8b
	umull	v3.8h, v27.8b, v11.8b
	urshr	v12.8h, v0.8h, #8
	urshr	v13.8h, v1.8h, #8
	urshr	v14.8h, v2.8h, #8
	urshr	v15.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v12.8h
	raddhn	v1.8b, v1.8h, v13.8h
	raddhn	v2.8b, v2.8h, v14.8h
	raddhn	v3.8b, v3.8h, v15.8h
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	st1	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
L_1059
	tst	x0, #0x1f
	b.eq	L_1060
	tst	x0, #0x10
	b.eq	L_1061
	ld1	{ v26.8b, v27.8b }, [x6], #16
	ld1	{ v6.8b, v7.8b }, [x8], #16
L_1061
	tst	x0, #0x8
	b.eq	L_1062
	ld1	{ v25.8b }, [x6], #8
	ld1	{ v5.8b }, [x8], #8
L_1062
	tst	x0, #0x4
	b.eq	L_1063
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	ld1	{ v4.b }[4], [x8], #1
	ld1	{ v4.b }[5], [x8], #1
	ld1	{ v4.b }[6], [x8], #1
	ld1	{ v4.b }[7], [x8], #1
L_1063
	tst	x0, #0x2
	b.eq	L_1064
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	ld1	{ v4.b }[2], [x8], #1
	ld1	{ v4.b }[3], [x8], #1
L_1064
	tst	x0, #0x1
	b.eq	L_1065
	ld1	{ v24.b }[1], [x6], #1
	ld1	{ v4.b }[1], [x8], #1
L_1065
	umull	v0.8h, v24.8b, v11.8b
	umull	v1.8h, v25.8b, v11.8b
	umull	v2.8h, v26.8b, v11.8b
	umull	v3.8h, v27.8b, v11.8b
	urshr	v12.8h, v0.8h, #8
	urshr	v13.8h, v1.8h, #8
	urshr	v14.8h, v2.8h, #8
	urshr	v15.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v12.8h
	raddhn	v1.8b, v1.8h, v13.8h
	raddhn	v2.8b, v2.8h, v14.8h
	raddhn	v3.8b, v3.8h, v15.8h
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	tst	x0, #0x10
	b.eq	L_1066
	st1	{ v30.8b, v31.8b }, [x2], #16
L_1066
	tst	x0, #0x8
	b.eq	L_1067
	st1	{ v29.8b }, [x2], #8
L_1067
	tst	x0, #0x4
	b.eq	L_1068
	st1	{ v28.b }[4], [x2], #1
	st1	{ v28.b }[5], [x2], #1
	st1	{ v28.b }[6], [x2], #1
	st1	{ v28.b }[7], [x2], #1
L_1068
	tst	x0, #0x2
	b.eq	L_1069
	st1	{ v28.b }[2], [x2], #1
	st1	{ v28.b }[3], [x2], #1
L_1069
	tst	x0, #0x1
	b.eq	L_1070
	st1	{ v28.b }[1], [x2], #1
L_1070
L_1060
	mov	x0, x14
	add	x2, x2, x3
	add	x6, x6, x7
	sub	x2, x2, x0
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1024
L_1023
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_add_8_8_8_asm_neon
pixman_composite_add_8_8_8_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_1071
	cmp	x0, #64
	b.lt	L_1072
L_1073
	tst	x8, #0xf
	b.eq	L_1074
	tst	x8, #0x1
	b.eq	L_1075
	ld1	{ v0.b }[1], [x4], #1
	ld1	{ v24.b }[1], [x6], #1
	ld1	{ v4.b }[1], [x8], #1
	add	x10, x10, #1
	sub	x0, x0, #1
L_1075
	tst	x8, #0x2
	b.eq	L_1076
	ld1	{ v0.b }[2], [x4], #1
	ld1	{ v0.b }[3], [x4], #1
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	ld1	{ v4.b }[2], [x8], #1
	ld1	{ v4.b }[3], [x8], #1
	add	x10, x10, #2
	sub	x0, x0, #2
L_1076
	tst	x8, #0x4
	b.eq	L_1077
	ld1	{ v0.b }[4], [x4], #1
	ld1	{ v0.b }[5], [x4], #1
	ld1	{ v0.b }[6], [x4], #1
	ld1	{ v0.b }[7], [x4], #1
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	ld1	{ v4.b }[4], [x8], #1
	ld1	{ v4.b }[5], [x8], #1
	ld1	{ v4.b }[6], [x8], #1
	ld1	{ v4.b }[7], [x8], #1
	add	x10, x10, #4
	sub	x0, x0, #4
L_1077
	tst	x8, #0x8
	b.eq	L_1078
	ld1	{ v1.8b }, [x4], #8
	ld1	{ v25.8b }, [x6], #8
	ld1	{ v5.8b }, [x8], #8
	add	x10, x10, #8
	sub	x0, x0, #8
L_1078
	ld1	{ v2.8b, v3.8b }, [x4], #16
	ld1	{ v26.8b, v27.8b }, [x6], #16
	ld1	{ v6.8b, v7.8b }, [x8], #16
	add	x10, x10, #16
	sub	x0, x0, #16
L_1079
	umull	v8.8h, v24.8b, v0.8b
	umull	v9.8h, v25.8b, v1.8b
	umull	v10.8h, v26.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	urshr	v0.8h, v8.8h, #8
	urshr	v1.8h, v9.8h, #8
	urshr	v12.8h, v10.8h, #8
	urshr	v13.8h, v11.8h, #8
	raddhn	v0.8b, v0.8h, v8.8h
	raddhn	v1.8b, v1.8h, v9.8h
	raddhn	v2.8b, v12.8h, v10.8h
	raddhn	v3.8b, v13.8h, v11.8h
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_1080
	add	x10, x10, #32
	sub	x9, x9, #1
L_1080
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x11, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1081
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1081
	add	x11, x11, x5
	ldrsb	x15, [x11]
	add	x12, x12, x3
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1081
	tst	x2, #0x1
	b.eq	L_1082
	st1	{ v28.b }[1], [x2], #1
L_1082
	tst	x2, #0x2
	b.eq	L_1083
	st1	{ v28.h }[1], [x2], #2
L_1083
	tst	x2, #0x4
	b.eq	L_1084
	st1	{ v28.s }[1], [x2], #4
L_1084
	tst	x2, #0x8
	b.eq	L_1085
	st1	{ v29.8b }, [x2], #8
L_1085
	st1	{ v30.8b, v31.8b }, [x2], #16
L_1086
L_1074
	ld1	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld1	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	ld1	{ v24.8b, v25.8b, v26.8b, v27.8b }, [x6], #32
	add	x10, x10, #32
	umull	v8.8h, v24.8b, v0.8b
	umull	v9.8h, v25.8b, v1.8b
	umull	v10.8h, v26.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	urshr	v0.8h, v8.8h, #8
	urshr	v1.8h, v9.8h, #8
	urshr	v12.8h, v10.8h, #8
	urshr	v13.8h, v11.8h, #8
	raddhn	v0.8b, v0.8h, v8.8h
	raddhn	v1.8b, v1.8h, v9.8h
	raddhn	v2.8b, v12.8h, v10.8h
	raddhn	v3.8b, v13.8h, v11.8h
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_1087
	add	x10, x10, #32
	sub	x9, x9, #1
L_1087
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x11, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1088
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1088
	add	x11, x11, x5
	ldrsb	x15, [x11]
	add	x12, x12, x3
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1088
	subs	x0, x0, #64
	b.lt	L_1089
L_1090
	st1	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	ld1	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld1	{ v24.8b, v25.8b, v26.8b, v27.8b }, [x6], #32
	ld1	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	add	x10, x10, #32
	tst	x9, #0xf
	b.eq	L_1091
	add	x10, x10, #32
	sub	x9, x9, #1
L_1091
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x11, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1092
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1092
	add	x11, x11, x5
	ldrsb	x15, [x11]
	add	x12, x12, x3
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1092
	umull	v8.8h, v24.8b, v0.8b
	umull	v9.8h, v25.8b, v1.8b
	umull	v10.8h, v26.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	urshr	v0.8h, v8.8h, #8
	urshr	v1.8h, v9.8h, #8
	urshr	v12.8h, v10.8h, #8
	urshr	v13.8h, v11.8h, #8
	raddhn	v0.8b, v0.8h, v8.8h
	raddhn	v1.8b, v1.8h, v9.8h
	raddhn	v2.8b, v12.8h, v10.8h
	raddhn	v3.8b, v13.8h, v11.8h
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	subs	x0, x0, #32
	b.ge	L_1090
L_1089
	st1	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	tst	x0, #0x1f
	b.eq	L_1093
	tst	x0, #0x10
	b.eq	L_1094
	ld1	{ v2.8b, v3.8b }, [x4], #16
	ld1	{ v26.8b, v27.8b }, [x6], #16
	ld1	{ v6.8b, v7.8b }, [x8], #16
	add	x10, x10, #16
L_1094
	tst	x0, #0x8
	b.eq	L_1095
	ld1	{ v1.8b }, [x4], #8
	ld1	{ v25.8b }, [x6], #8
	ld1	{ v5.8b }, [x8], #8
	add	x10, x10, #8
L_1095
	tst	x0, #0x4
	b.eq	L_1096
	ld1	{ v0.b }[4], [x4], #1
	ld1	{ v0.b }[5], [x4], #1
	ld1	{ v0.b }[6], [x4], #1
	ld1	{ v0.b }[7], [x4], #1
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	ld1	{ v4.b }[4], [x8], #1
	ld1	{ v4.b }[5], [x8], #1
	ld1	{ v4.b }[6], [x8], #1
	ld1	{ v4.b }[7], [x8], #1
	add	x10, x10, #4
L_1096
	tst	x0, #0x2
	b.eq	L_1097
	ld1	{ v0.b }[2], [x4], #1
	ld1	{ v0.b }[3], [x4], #1
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	ld1	{ v4.b }[2], [x8], #1
	ld1	{ v4.b }[3], [x8], #1
	add	x10, x10, #2
L_1097
	tst	x0, #0x1
	b.eq	L_1098
	ld1	{ v0.b }[1], [x4], #1
	ld1	{ v24.b }[1], [x6], #1
	ld1	{ v4.b }[1], [x8], #1
	add	x10, x10, #1
L_1098
	umull	v8.8h, v24.8b, v0.8b
	umull	v9.8h, v25.8b, v1.8b
	umull	v10.8h, v26.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	urshr	v0.8h, v8.8h, #8
	urshr	v1.8h, v9.8h, #8
	urshr	v12.8h, v10.8h, #8
	urshr	v13.8h, v11.8h, #8
	raddhn	v0.8b, v0.8h, v8.8h
	raddhn	v1.8b, v1.8h, v9.8h
	raddhn	v2.8b, v12.8h, v10.8h
	raddhn	v3.8b, v13.8h, v11.8h
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_1099
	add	x10, x10, #32
	sub	x9, x9, #1
L_1099
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x11, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1100
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1100
	add	x11, x11, x5
	ldrsb	x15, [x11]
	add	x12, x12, x3
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1100
	tst	x0, #0x10
	b.eq	L_1101
	st1	{ v30.8b, v31.8b }, [x2], #16
L_1101
	tst	x0, #0x8
	b.eq	L_1102
	st1	{ v29.8b }, [x2], #8
L_1102
	tst	x0, #0x4
	b.eq	L_1103
	st1	{ v28.s }[1], [x2], #4
L_1103
	tst	x0, #0x2
	b.eq	L_1104
	st1	{ v28.h }[1], [x2], #2
L_1104
	tst	x0, #0x1
	b.eq	L_1105
	st1	{ v28.b }[1], [x2], #1
L_1105
L_1093
	mov	x0, x14
	add	x2, x2, x3
	add	x4, x4, x5
	add	x6, x6, x7
	sub	x2, x2, x0
	sub	x4, x4, x0
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1073
L_1106
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1072
	lsr	x15, x5, #0
	prfm	pldl1keep, [x4, x15]
	lsr	x15, x3, #0
	prfm	pldl1keep, [x8, x15]
	lsr	x15, x7, #0
	prfm	pldl1keep, [x6, x15]
	tst	x0, #0x20
	b.eq	L_1107
	ld1	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld1	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	ld1	{ v24.8b, v25.8b, v26.8b, v27.8b }, [x6], #32
	umull	v8.8h, v24.8b, v0.8b
	umull	v9.8h, v25.8b, v1.8b
	umull	v10.8h, v26.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	urshr	v0.8h, v8.8h, #8
	urshr	v1.8h, v9.8h, #8
	urshr	v12.8h, v10.8h, #8
	urshr	v13.8h, v11.8h, #8
	raddhn	v0.8b, v0.8h, v8.8h
	raddhn	v1.8b, v1.8h, v9.8h
	raddhn	v2.8b, v12.8h, v10.8h
	raddhn	v3.8b, v13.8h, v11.8h
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	st1	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
L_1107
	tst	x0, #0x1f
	b.eq	L_1108
	tst	x0, #0x10
	b.eq	L_1109
	ld1	{ v2.8b, v3.8b }, [x4], #16
	ld1	{ v26.8b, v27.8b }, [x6], #16
	ld1	{ v6.8b, v7.8b }, [x8], #16
L_1109
	tst	x0, #0x8
	b.eq	L_1110
	ld1	{ v1.8b }, [x4], #8
	ld1	{ v25.8b }, [x6], #8
	ld1	{ v5.8b }, [x8], #8
L_1110
	tst	x0, #0x4
	b.eq	L_1111
	ld1	{ v0.b }[4], [x4], #1
	ld1	{ v0.b }[5], [x4], #1
	ld1	{ v0.b }[6], [x4], #1
	ld1	{ v0.b }[7], [x4], #1
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	ld1	{ v4.b }[4], [x8], #1
	ld1	{ v4.b }[5], [x8], #1
	ld1	{ v4.b }[6], [x8], #1
	ld1	{ v4.b }[7], [x8], #1
L_1111
	tst	x0, #0x2
	b.eq	L_1112
	ld1	{ v0.b }[2], [x4], #1
	ld1	{ v0.b }[3], [x4], #1
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	ld1	{ v4.b }[2], [x8], #1
	ld1	{ v4.b }[3], [x8], #1
L_1112
	tst	x0, #0x1
	b.eq	L_1113
	ld1	{ v0.b }[1], [x4], #1
	ld1	{ v24.b }[1], [x6], #1
	ld1	{ v4.b }[1], [x8], #1
L_1113
	umull	v8.8h, v24.8b, v0.8b
	umull	v9.8h, v25.8b, v1.8b
	umull	v10.8h, v26.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	urshr	v0.8h, v8.8h, #8
	urshr	v1.8h, v9.8h, #8
	urshr	v12.8h, v10.8h, #8
	urshr	v13.8h, v11.8h, #8
	raddhn	v0.8b, v0.8h, v8.8h
	raddhn	v1.8b, v1.8h, v9.8h
	raddhn	v2.8b, v12.8h, v10.8h
	raddhn	v3.8b, v13.8h, v11.8h
	uqadd	v28.8b, v0.8b, v4.8b
	uqadd	v29.8b, v1.8b, v5.8b
	uqadd	v30.8b, v2.8b, v6.8b
	uqadd	v31.8b, v3.8b, v7.8b
	tst	x0, #0x10
	b.eq	L_1114
	st1	{ v30.8b, v31.8b }, [x2], #16
L_1114
	tst	x0, #0x8
	b.eq	L_1115
	st1	{ v29.8b }, [x2], #8
L_1115
	tst	x0, #0x4
	b.eq	L_1116
	st1	{ v28.b }[4], [x2], #1
	st1	{ v28.b }[5], [x2], #1
	st1	{ v28.b }[6], [x2], #1
	st1	{ v28.b }[7], [x2], #1
L_1116
	tst	x0, #0x2
	b.eq	L_1117
	st1	{ v28.b }[2], [x2], #1
	st1	{ v28.b }[3], [x2], #1
L_1117
	tst	x0, #0x1
	b.eq	L_1118
	st1	{ v28.b }[1], [x2], #1
L_1118
L_1108
	mov	x0, x14
	add	x2, x2, x3
	add	x4, x4, x5
	add	x6, x6, x7
	sub	x2, x2, x0
	sub	x4, x4, x0
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1072
L_1071
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_add_8888_8888_8888_asm_neon
pixman_composite_add_8888_8888_8888_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #6
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_1119
	cmp	x0, #16
	b.lt	L_1120
L_1121
	tst	x8, #0xf
	b.eq	L_1122
	tst	x8, #0x4
	b.eq	L_1123
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v24.s }[1], [x6], #4
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
	sub	x0, x0, #1
L_1123
	tst	x8, #0x8
	b.eq	L_1124
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v25.2s }, [x6], #8
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
	sub	x0, x0, #2
L_1124
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v26.2s, v27.2s }, [x6], #16
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
	sub	x0, x0, #4
L_1125
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v24.8b, v25.8b
	uzp2	v25.8b, v24.8b, v25.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v26.8b, v27.8b
	uzp2	v27.8b, v26.8b, v27.8b
	mov	v26.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v25.8b, v27.8b
	uzp2	v27.8b, v25.8b, v27.8b
	mov	v25.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v24.8b, v26.8b
	uzp2	v26.8b, v24.8b, v26.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	tst	x9, #0xf
	b.eq	L_1126
	add	x10, x10, #8
	sub	x9, x9, #1
L_1126
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x13, x15]
	b.le	L_1127
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1127
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7, lsl #2
	ldrsb	x15, [x13]
L_1127
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x2, #0x4
	b.eq	L_1128
	st1	{ v28.s }[1], [x2], #4
L_1128
	tst	x2, #0x8
	b.eq	L_1129
	st1	{ v29.2s }, [x2], #8
L_1129
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1130
L_1122
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	ld4	{ v24.8b, v25.8b, v26.8b, v27.8b }, [x6], #32
	add	x10, x10, #8
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	tst	x9, #0xf
	b.eq	L_1131
	add	x10, x10, #8
	sub	x9, x9, #1
L_1131
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x13, x15]
	b.le	L_1132
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1132
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7, lsl #2
	ldrsb	x15, [x13]
L_1132
	subs	x0, x0, #16
	b.lt	L_1133
L_1134
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	rshrn	v28.8b, v8.8h, #8
	ld4	{ v24.8b, v25.8b, v26.8b, v27.8b }, [x6], #32
	rshrn	v29.8b, v9.8h, #8
	umull	v8.8h, v27.8b, v0.8b
	rshrn	v30.8b, v10.8h, #8
	umull	v9.8h, v27.8b, v1.8b
	rshrn	v31.8b, v11.8h, #8
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	ursra	v8.8h, v8.8h, #8
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ursra	v9.8h, v9.8h, #8
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	ursra	v10.8h, v10.8h, #8
	add	x10, x10, #8
	tst	x9, #0xf
	b.eq	L_1135
	add	x10, x10, #8
	sub	x9, x9, #1
L_1135
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x13, x15]
	b.le	L_1136
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1136
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7, lsl #2
	ldrsb	x15, [x13]
L_1136
	ursra	v11.8h, v11.8h, #8
	subs	x0, x0, #8
	b.ge	L_1134
L_1133
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	tst	x0, #0x7
	b.eq	L_1137
	tst	x0, #0x4
	b.eq	L_1138
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v26.2s, v27.2s }, [x6], #16
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
L_1138
	tst	x0, #0x2
	b.eq	L_1139
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v25.2s }, [x6], #8
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
L_1139
	tst	x0, #0x1
	b.eq	L_1140
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v24.s }[1], [x6], #4
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
L_1140
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v24.8b, v25.8b
	uzp2	v25.8b, v24.8b, v25.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v26.8b, v27.8b
	uzp2	v27.8b, v26.8b, v27.8b
	mov	v26.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v25.8b, v27.8b
	uzp2	v27.8b, v25.8b, v27.8b
	mov	v25.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v24.8b, v26.8b
	uzp2	v26.8b, v24.8b, v26.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	tst	x9, #0xf
	b.eq	L_1141
	add	x10, x10, #8
	sub	x9, x9, #1
L_1141
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x13, x15]
	b.le	L_1142
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1142
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7, lsl #2
	ldrsb	x15, [x13]
L_1142
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_1143
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1143
	tst	x0, #0x2
	b.eq	L_1144
	st1	{ v29.2s }, [x2], #8
L_1144
	tst	x0, #0x1
	b.eq	L_1145
	st1	{ v28.s }[1], [x2], #4
L_1145
L_1137
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	add	x6, x6, x7, lsl #2
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	sub	x6, x6, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1121
L_1146
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1120
	lsl	x15, x5, #2
	prfm	pldl1keep, [x4, x15]
	lsl	x15, x3, #2
	prfm	pldl1keep, [x8, x15]
	lsl	x15, x7, #2
	prfm	pldl1keep, [x6, x15]
	tst	x0, #0x8
	b.eq	L_1147
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	ld4	{ v24.8b, v25.8b, v26.8b, v27.8b }, [x6], #32
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
L_1147
	tst	x0, #0x7
	b.eq	L_1148
	tst	x0, #0x4
	b.eq	L_1149
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v26.2s, v27.2s }, [x6], #16
	ld1	{ v6.2s, v7.2s }, [x8], #16
L_1149
	tst	x0, #0x2
	b.eq	L_1150
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v25.2s }, [x6], #8
	ld1	{ v5.2s }, [x8], #8
L_1150
	tst	x0, #0x1
	b.eq	L_1151
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v24.s }[1], [x6], #4
	ld1	{ v4.s }[1], [x8], #4
L_1151
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v24.8b, v25.8b
	uzp2	v25.8b, v24.8b, v25.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v26.8b, v27.8b
	uzp2	v27.8b, v26.8b, v27.8b
	mov	v26.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v25.8b, v27.8b
	uzp2	v27.8b, v25.8b, v27.8b
	mov	v25.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v24.8b, v26.8b
	uzp2	v26.8b, v24.8b, v26.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_1152
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1152
	tst	x0, #0x2
	b.eq	L_1153
	st1	{ v29.2s }, [x2], #8
L_1153
	tst	x0, #0x1
	b.eq	L_1154
	st1	{ v28.s }[1], [x2], #4
L_1154
L_1148
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	add	x6, x6, x7, lsl #2
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	sub	x6, x6, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1120
L_1119
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_scanline_add_mask_asm_neon
pixman_composite_scanline_add_mask_asm_neon
	sxtw	x0, w0
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #64
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	mov	x4, x1
	cmp	x0, #8
	b.lt	L_1155
	tst	x4, #0xf
	b.eq	L_1156
	tst	x4, #0x4
	b.eq	L_1157
	ld1	{ v0.s }[1], [x2], #4
	ld1	{ v24.s }[1], [x3], #4
	ld1	{ v4.s }[1], [x4], #4
	sub	x0, x0, #1
L_1157
	tst	x4, #0x8
	b.eq	L_1158
	ld1	{ v1.2s }, [x2], #8
	ld1	{ v25.2s }, [x3], #8
	ld1	{ v5.2s }, [x4], #8
	sub	x0, x0, #2
L_1158
	ld1	{ v2.2s, v3.2s }, [x2], #16
	ld1	{ v26.2s, v27.2s }, [x3], #16
	ld1	{ v6.2s, v7.2s }, [x4], #16
	sub	x0, x0, #4
L_1159
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v24.8b, v25.8b
	uzp2	v25.8b, v24.8b, v25.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v26.8b, v27.8b
	uzp2	v27.8b, v26.8b, v27.8b
	mov	v26.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v25.8b, v27.8b
	uzp2	v27.8b, v25.8b, v27.8b
	mov	v25.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v24.8b, v26.8b
	uzp2	v26.8b, v24.8b, v26.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
L_1160
L_1161
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	tst	x1, #0x4
	b.eq	L_1162
	st1	{ v28.s }[1], [x1], #4
L_1162
	tst	x1, #0x8
	b.eq	L_1163
	st1	{ v29.2s }, [x1], #8
L_1163
	st1	{ v30.2s, v31.2s }, [x1], #16
L_1164
L_1156
	subs	x0, x0, #8
	b.lt	L_1165
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x4], #32
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], #32
	ld4	{ v24.8b, v25.8b, v26.8b, v27.8b }, [x3], #32
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	subs	x0, x0, #8
	b.lt	L_1166
L_1167
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], #32
	rshrn	v28.8b, v8.8h, #8
	ld4	{ v24.8b, v25.8b, v26.8b, v27.8b }, [x3], #32
	rshrn	v29.8b, v9.8h, #8
	umull	v8.8h, v27.8b, v0.8b
	rshrn	v30.8b, v10.8h, #8
	umull	v9.8h, v27.8b, v1.8b
	rshrn	v31.8b, v11.8h, #8
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	ursra	v8.8h, v8.8h, #8
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x4], #32
	ursra	v9.8h, v9.8h, #8
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x1], #32
	ursra	v10.8h, v10.8h, #8
L_1168
L_1169
	ursra	v11.8h, v11.8h, #8
	subs	x0, x0, #8
	b.ge	L_1167
L_1166
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x1], #32
L_1165
	tst	x0, #0x7
	b.eq	L_1170
	tst	x0, #0x4
	b.eq	L_1171
	ld1	{ v2.2s, v3.2s }, [x2], #16
	ld1	{ v26.2s, v27.2s }, [x3], #16
	ld1	{ v6.2s, v7.2s }, [x4], #16
L_1171
	tst	x0, #0x2
	b.eq	L_1172
	ld1	{ v1.2s }, [x2], #8
	ld1	{ v25.2s }, [x3], #8
	ld1	{ v5.2s }, [x4], #8
L_1172
	tst	x0, #0x1
	b.eq	L_1173
	ld1	{ v0.s }[1], [x2], #4
	ld1	{ v24.s }[1], [x3], #4
	ld1	{ v4.s }[1], [x4], #4
L_1173
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v24.8b, v25.8b
	uzp2	v25.8b, v24.8b, v25.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v26.8b, v27.8b
	uzp2	v27.8b, v26.8b, v27.8b
	mov	v26.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v25.8b, v27.8b
	uzp2	v27.8b, v25.8b, v27.8b
	mov	v25.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v24.8b, v26.8b
	uzp2	v26.8b, v24.8b, v26.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	tst	x0, #0x4
	b.eq	L_1174
	st1	{ v30.2s, v31.2s }, [x1], #16
L_1174
	tst	x0, #0x2
	b.eq	L_1175
	st1	{ v29.2s }, [x1], #8
L_1175
	tst	x0, #0x1
	b.eq	L_1176
	st1	{ v28.s }[1], [x1], #4
L_1176
L_1170
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1155
	tst	x0, #0x7
	b.eq	L_1177
	tst	x0, #0x4
	b.eq	L_1178
	ld1	{ v2.2s, v3.2s }, [x2], #16
	ld1	{ v26.2s, v27.2s }, [x3], #16
	ld1	{ v6.2s, v7.2s }, [x4], #16
L_1178
	tst	x0, #0x2
	b.eq	L_1179
	ld1	{ v1.2s }, [x2], #8
	ld1	{ v25.2s }, [x3], #8
	ld1	{ v5.2s }, [x4], #8
L_1179
	tst	x0, #0x1
	b.eq	L_1180
	ld1	{ v0.s }[1], [x2], #4
	ld1	{ v24.s }[1], [x3], #4
	ld1	{ v4.s }[1], [x4], #4
L_1180
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v24.8b, v25.8b
	uzp2	v25.8b, v24.8b, v25.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v26.8b, v27.8b
	uzp2	v27.8b, v26.8b, v27.8b
	mov	v26.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v25.8b, v27.8b
	uzp2	v27.8b, v25.8b, v27.8b
	mov	v25.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v24.8b, v26.8b
	uzp2	v26.8b, v24.8b, v26.8b
	mov	v24.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	tst	x0, #0x4
	b.eq	L_1181
	st1	{ v30.2s, v31.2s }, [x1], #16
L_1181
	tst	x0, #0x2
	b.eq	L_1182
	st1	{ v29.2s }, [x1], #8
L_1182
	tst	x0, #0x1
	b.eq	L_1183
	st1	{ v28.s }[1], [x1], #4
L_1183
L_1177
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_add_8888_8_8888_asm_neon
pixman_composite_add_8888_8_8888_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_1184
	cmp	x0, #16
	b.lt	L_1185
L_1186
	tst	x8, #0xf
	b.eq	L_1187
	tst	x8, #0x4
	b.eq	L_1188
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v27.b }[1], [x6], #1
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
	sub	x0, x0, #1
L_1188
	tst	x8, #0x8
	b.eq	L_1189
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v27.b }[2], [x6], #1
	ld1	{ v27.b }[3], [x6], #1
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
	sub	x0, x0, #2
L_1189
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v27.b }[4], [x6], #1
	ld1	{ v27.b }[5], [x6], #1
	ld1	{ v27.b }[6], [x6], #1
	ld1	{ v27.b }[7], [x6], #1
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
	sub	x0, x0, #4
L_1190
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	tst	x9, #0xf
	b.eq	L_1191
	add	x10, x10, #8
	sub	x9, x9, #1
L_1191
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1192
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1192
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1192
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x2, #0x4
	b.eq	L_1193
	st1	{ v28.s }[1], [x2], #4
L_1193
	tst	x2, #0x8
	b.eq	L_1194
	st1	{ v29.2s }, [x2], #8
L_1194
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1195
L_1187
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	ld1	{ v27.8b }, [x6], #8
	add	x10, x10, #8
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	tst	x9, #0xf
	b.eq	L_1196
	add	x10, x10, #8
	sub	x9, x9, #1
L_1196
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1197
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1197
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1197
	subs	x0, x0, #16
	b.lt	L_1198
L_1199
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	rshrn	v28.8b, v8.8h, #8
	ld1	{ v27.8b }, [x6], #8
	rshrn	v29.8b, v9.8h, #8
	umull	v8.8h, v27.8b, v0.8b
	rshrn	v30.8b, v10.8h, #8
	umull	v9.8h, v27.8b, v1.8b
	rshrn	v31.8b, v11.8h, #8
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	ursra	v8.8h, v8.8h, #8
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ursra	v9.8h, v9.8h, #8
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	ursra	v10.8h, v10.8h, #8
	add	x10, x10, #8
	tst	x9, #0xf
	b.eq	L_1200
	add	x10, x10, #8
	sub	x9, x9, #1
L_1200
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1201
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1201
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1201
	ursra	v11.8h, v11.8h, #8
	subs	x0, x0, #8
	b.ge	L_1199
L_1198
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	tst	x0, #0x7
	b.eq	L_1202
	tst	x0, #0x4
	b.eq	L_1203
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v27.b }[4], [x6], #1
	ld1	{ v27.b }[5], [x6], #1
	ld1	{ v27.b }[6], [x6], #1
	ld1	{ v27.b }[7], [x6], #1
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
L_1203
	tst	x0, #0x2
	b.eq	L_1204
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v27.b }[2], [x6], #1
	ld1	{ v27.b }[3], [x6], #1
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
L_1204
	tst	x0, #0x1
	b.eq	L_1205
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v27.b }[1], [x6], #1
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
L_1205
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	tst	x9, #0xf
	b.eq	L_1206
	add	x10, x10, #8
	sub	x9, x9, #1
L_1206
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1207
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1207
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1207
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_1208
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1208
	tst	x0, #0x2
	b.eq	L_1209
	st1	{ v29.2s }, [x2], #8
L_1209
	tst	x0, #0x1
	b.eq	L_1210
	st1	{ v28.s }[1], [x2], #4
L_1210
L_1202
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	add	x6, x6, x7
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1186
L_1211
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1185
	lsl	x15, x5, #2
	prfm	pldl1keep, [x4, x15]
	lsl	x15, x3, #2
	prfm	pldl1keep, [x8, x15]
	lsr	x15, x7, #0
	prfm	pldl1keep, [x6, x15]
	tst	x0, #0x8
	b.eq	L_1212
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	ld1	{ v27.8b }, [x6], #8
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
L_1212
	tst	x0, #0x7
	b.eq	L_1213
	tst	x0, #0x4
	b.eq	L_1214
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v27.b }[4], [x6], #1
	ld1	{ v27.b }[5], [x6], #1
	ld1	{ v27.b }[6], [x6], #1
	ld1	{ v27.b }[7], [x6], #1
	ld1	{ v6.2s, v7.2s }, [x8], #16
L_1214
	tst	x0, #0x2
	b.eq	L_1215
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v27.b }[2], [x6], #1
	ld1	{ v27.b }[3], [x6], #1
	ld1	{ v5.2s }, [x8], #8
L_1215
	tst	x0, #0x1
	b.eq	L_1216
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v27.b }[1], [x6], #1
	ld1	{ v4.s }[1], [x8], #4
L_1216
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_1217
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1217
	tst	x0, #0x2
	b.eq	L_1218
	st1	{ v29.2s }, [x2], #8
L_1218
	tst	x0, #0x1
	b.eq	L_1219
	st1	{ v28.s }[1], [x2], #4
L_1219
L_1213
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	add	x6, x6, x7
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1185
L_1184
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_add_n_8_8888_asm_neon
pixman_composite_add_n_8_8888_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	mov	v3.s[0], w4
	dup	v0.8b, v3.b[0]
	dup	v1.8b, v3.b[1]
	dup	v2.8b, v3.b[2]
	dup	v3.8b, v3.b[3]
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_1220
	cmp	x0, #16
	b.lt	L_1221
L_1222
	tst	x8, #0xf
	b.eq	L_1223
	tst	x8, #0x4
	b.eq	L_1224
	ld1	{ v27.b }[1], [x6], #1
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
	sub	x0, x0, #1
L_1224
	tst	x8, #0x8
	b.eq	L_1225
	ld1	{ v27.b }[2], [x6], #1
	ld1	{ v27.b }[3], [x6], #1
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
	sub	x0, x0, #2
L_1225
	ld1	{ v27.b }[4], [x6], #1
	ld1	{ v27.b }[5], [x6], #1
	ld1	{ v27.b }[6], [x6], #1
	ld1	{ v27.b }[7], [x6], #1
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
	sub	x0, x0, #4
L_1226
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	tst	x9, #0xf
	b.eq	L_1227
	add	x10, x10, #8
	sub	x9, x9, #1
L_1227
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1228
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1228
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1228
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x2, #0x4
	b.eq	L_1229
	st1	{ v28.s }[1], [x2], #4
L_1229
	tst	x2, #0x8
	b.eq	L_1230
	st1	{ v29.2s }, [x2], #8
L_1230
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1231
L_1223
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld1	{ v27.8b }, [x6], #8
	add	x10, x10, #8
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	tst	x9, #0xf
	b.eq	L_1232
	add	x10, x10, #8
	sub	x9, x9, #1
L_1232
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1233
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1233
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1233
	subs	x0, x0, #16
	b.lt	L_1234
L_1235
	rshrn	v28.8b, v8.8h, #8
	ld1	{ v27.8b }, [x6], #8
	rshrn	v29.8b, v9.8h, #8
	umull	v8.8h, v27.8b, v0.8b
	rshrn	v30.8b, v10.8h, #8
	umull	v9.8h, v27.8b, v1.8b
	rshrn	v31.8b, v11.8h, #8
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	ursra	v8.8h, v8.8h, #8
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ursra	v9.8h, v9.8h, #8
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	ursra	v10.8h, v10.8h, #8
	add	x10, x10, #8
	tst	x9, #0xf
	b.eq	L_1236
	add	x10, x10, #8
	sub	x9, x9, #1
L_1236
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1237
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1237
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1237
	ursra	v11.8h, v11.8h, #8
	subs	x0, x0, #8
	b.ge	L_1235
L_1234
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	tst	x0, #0x7
	b.eq	L_1238
	tst	x0, #0x4
	b.eq	L_1239
	ld1	{ v27.b }[4], [x6], #1
	ld1	{ v27.b }[5], [x6], #1
	ld1	{ v27.b }[6], [x6], #1
	ld1	{ v27.b }[7], [x6], #1
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
L_1239
	tst	x0, #0x2
	b.eq	L_1240
	ld1	{ v27.b }[2], [x6], #1
	ld1	{ v27.b }[3], [x6], #1
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
L_1240
	tst	x0, #0x1
	b.eq	L_1241
	ld1	{ v27.b }[1], [x6], #1
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
L_1241
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	tst	x9, #0xf
	b.eq	L_1242
	add	x10, x10, #8
	sub	x9, x9, #1
L_1242
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1243
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1243
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1243
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_1244
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1244
	tst	x0, #0x2
	b.eq	L_1245
	st1	{ v29.2s }, [x2], #8
L_1245
	tst	x0, #0x1
	b.eq	L_1246
	st1	{ v28.s }[1], [x2], #4
L_1246
L_1238
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x6, x6, x7
	sub	x2, x2, x0, lsl #2
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1222
L_1247
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1221
	lsl	x15, x3, #2
	prfm	pldl1keep, [x8, x15]
	lsr	x15, x7, #0
	prfm	pldl1keep, [x6, x15]
	tst	x0, #0x8
	b.eq	L_1248
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld1	{ v27.8b }, [x6], #8
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
L_1248
	tst	x0, #0x7
	b.eq	L_1249
	tst	x0, #0x4
	b.eq	L_1250
	ld1	{ v27.b }[4], [x6], #1
	ld1	{ v27.b }[5], [x6], #1
	ld1	{ v27.b }[6], [x6], #1
	ld1	{ v27.b }[7], [x6], #1
	ld1	{ v6.2s, v7.2s }, [x8], #16
L_1250
	tst	x0, #0x2
	b.eq	L_1251
	ld1	{ v27.b }[2], [x6], #1
	ld1	{ v27.b }[3], [x6], #1
	ld1	{ v5.2s }, [x8], #8
L_1251
	tst	x0, #0x1
	b.eq	L_1252
	ld1	{ v27.b }[1], [x6], #1
	ld1	{ v4.s }[1], [x8], #4
L_1252
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_1253
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1253
	tst	x0, #0x2
	b.eq	L_1254
	st1	{ v29.2s }, [x2], #8
L_1254
	tst	x0, #0x1
	b.eq	L_1255
	st1	{ v28.s }[1], [x2], #4
L_1255
L_1249
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x6, x6, x7
	sub	x2, x2, x0, lsl #2
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1221
L_1220
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_add_8888_n_8888_asm_neon
pixman_composite_add_8888_n_8888_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	mov	v27.s[0], w6
	dup	v27.8b, v27.b[3]
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_1256
	cmp	x0, #16
	b.lt	L_1257
L_1258
	tst	x8, #0xf
	b.eq	L_1259
	tst	x8, #0x4
	b.eq	L_1260
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
	sub	x0, x0, #1
L_1260
	tst	x8, #0x8
	b.eq	L_1261
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
	sub	x0, x0, #2
L_1261
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
	sub	x0, x0, #4
L_1262
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	tst	x9, #0xf
	b.eq	L_1263
	add	x10, x10, #8
	sub	x9, x9, #1
L_1263
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_1264
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1264
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_1264
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x2, #0x4
	b.eq	L_1265
	st1	{ v28.s }[1], [x2], #4
L_1265
	tst	x2, #0x8
	b.eq	L_1266
	st1	{ v29.2s }, [x2], #8
L_1266
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1267
L_1259
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	add	x10, x10, #8
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	tst	x9, #0xf
	b.eq	L_1268
	add	x10, x10, #8
	sub	x9, x9, #1
L_1268
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_1269
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1269
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_1269
	subs	x0, x0, #16
	b.lt	L_1270
L_1271
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	umull	v8.8h, v27.8b, v0.8b
	rshrn	v30.8b, v10.8h, #8
	umull	v9.8h, v27.8b, v1.8b
	rshrn	v31.8b, v11.8h, #8
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	ursra	v8.8h, v8.8h, #8
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ursra	v9.8h, v9.8h, #8
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	ursra	v10.8h, v10.8h, #8
	add	x10, x10, #8
	tst	x9, #0xf
	b.eq	L_1272
	add	x10, x10, #8
	sub	x9, x9, #1
L_1272
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_1273
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1273
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_1273
	ursra	v11.8h, v11.8h, #8
	subs	x0, x0, #8
	b.ge	L_1271
L_1270
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	tst	x0, #0x7
	b.eq	L_1274
	tst	x0, #0x4
	b.eq	L_1275
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
L_1275
	tst	x0, #0x2
	b.eq	L_1276
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
L_1276
	tst	x0, #0x1
	b.eq	L_1277
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
L_1277
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	tst	x9, #0xf
	b.eq	L_1278
	add	x10, x10, #8
	sub	x9, x9, #1
L_1278
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_1279
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1279
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_1279
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_1280
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1280
	tst	x0, #0x2
	b.eq	L_1281
	st1	{ v29.2s }, [x2], #8
L_1281
	tst	x0, #0x1
	b.eq	L_1282
	st1	{ v28.s }[1], [x2], #4
L_1282
L_1274
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1258
L_1283
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1257
	lsl	x15, x5, #2
	prfm	pldl1keep, [x4, x15]
	lsl	x15, x3, #2
	prfm	pldl1keep, [x8, x15]
	tst	x0, #0x8
	b.eq	L_1284
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
L_1284
	tst	x0, #0x7
	b.eq	L_1285
	tst	x0, #0x4
	b.eq	L_1286
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v6.2s, v7.2s }, [x8], #16
L_1286
	tst	x0, #0x2
	b.eq	L_1287
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v5.2s }, [x8], #8
L_1287
	tst	x0, #0x1
	b.eq	L_1288
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v4.s }[1], [x8], #4
L_1288
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v8.8h, v27.8b, v0.8b
	umull	v9.8h, v27.8b, v1.8b
	umull	v10.8h, v27.8b, v2.8b
	umull	v11.8h, v27.8b, v3.8b
	ursra	v8.8h, v8.8h, #8
	ursra	v9.8h, v9.8h, #8
	ursra	v10.8h, v10.8h, #8
	ursra	v11.8h, v11.8h, #8
	rshrn	v28.8b, v8.8h, #8
	rshrn	v29.8b, v9.8h, #8
	rshrn	v30.8b, v10.8h, #8
	rshrn	v31.8b, v11.8h, #8
	uqadd	v28.8b, v4.8b, v28.8b
	uqadd	v29.8b, v5.8b, v29.8b
	uqadd	v30.8b, v6.8b, v30.8b
	uqadd	v31.8b, v7.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_1289
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1289
	tst	x0, #0x2
	b.eq	L_1290
	st1	{ v29.2s }, [x2], #8
L_1290
	tst	x0, #0x1
	b.eq	L_1291
	st1	{ v28.s }[1], [x2], #4
L_1291
L_1285
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1257
L_1256
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_scanline_out_reverse_mask_asm_neon
pixman_composite_scanline_out_reverse_mask_asm_neon
	sxtw	x0, w0
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #64
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	mov	x4, x1
	cmp	x0, #8
	b.lt	L_1292
	tst	x4, #0xf
	b.eq	L_1293
	tst	x4, #0x4
	b.eq	L_1294
	ld1	{ v0.s }[1], [x2], #4
	ld1	{ v12.s }[1], [x3], #4
	ld1	{ v4.s }[1], [x4], #4
	sub	x0, x0, #1
L_1294
	tst	x4, #0x8
	b.eq	L_1295
	ld1	{ v1.2s }, [x2], #8
	ld1	{ v13.2s }, [x3], #8
	ld1	{ v5.2s }, [x4], #8
	sub	x0, x0, #2
L_1295
	ld1	{ v2.2s, v3.2s }, [x2], #16
	ld1	{ v14.2s, v15.2s }, [x3], #16
	ld1	{ v6.2s, v7.2s }, [x4], #16
	sub	x0, x0, #4
L_1296
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v12.8b, v13.8b
	uzp2	v13.8b, v12.8b, v13.8b
	mov	v12.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v14.8b, v15.8b
	uzp2	v15.8b, v14.8b, v15.8b
	mov	v14.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v13.8b, v15.8b
	uzp2	v15.8b, v13.8b, v15.8b
	mov	v13.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v12.8b, v14.8b
	uzp2	v14.8b, v12.8b, v14.8b
	mov	v12.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
L_1297
L_1298
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	tst	x1, #0x4
	b.eq	L_1299
	st1	{ v28.s }[1], [x1], #4
L_1299
	tst	x1, #0x8
	b.eq	L_1300
	st1	{ v29.2s }, [x1], #8
L_1300
	st1	{ v30.2s, v31.2s }, [x1], #16
L_1301
L_1293
	subs	x0, x0, #8
	b.lt	L_1302
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x4], #32
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], #32
	ld4	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x3], #32
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	subs	x0, x0, #8
	b.lt	L_1303
L_1304
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x4], #32
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], #32
L_1305
L_1306
	ld4	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x3], #32
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x1], #32
	subs	x0, x0, #8
	b.ge	L_1304
L_1303
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x1], #32
L_1302
	tst	x0, #0x7
	b.eq	L_1307
	tst	x0, #0x4
	b.eq	L_1308
	ld1	{ v2.2s, v3.2s }, [x2], #16
	ld1	{ v14.2s, v15.2s }, [x3], #16
	ld1	{ v6.2s, v7.2s }, [x4], #16
L_1308
	tst	x0, #0x2
	b.eq	L_1309
	ld1	{ v1.2s }, [x2], #8
	ld1	{ v13.2s }, [x3], #8
	ld1	{ v5.2s }, [x4], #8
L_1309
	tst	x0, #0x1
	b.eq	L_1310
	ld1	{ v0.s }[1], [x2], #4
	ld1	{ v12.s }[1], [x3], #4
	ld1	{ v4.s }[1], [x4], #4
L_1310
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v12.8b, v13.8b
	uzp2	v13.8b, v12.8b, v13.8b
	mov	v12.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v14.8b, v15.8b
	uzp2	v15.8b, v14.8b, v15.8b
	mov	v14.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v13.8b, v15.8b
	uzp2	v15.8b, v13.8b, v15.8b
	mov	v13.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v12.8b, v14.8b
	uzp2	v14.8b, v12.8b, v14.8b
	mov	v12.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	tst	x0, #0x4
	b.eq	L_1311
	st1	{ v30.2s, v31.2s }, [x1], #16
L_1311
	tst	x0, #0x2
	b.eq	L_1312
	st1	{ v29.2s }, [x1], #8
L_1312
	tst	x0, #0x1
	b.eq	L_1313
	st1	{ v28.s }[1], [x1], #4
L_1313
L_1307
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1292
	tst	x0, #0x7
	b.eq	L_1314
	tst	x0, #0x4
	b.eq	L_1315
	ld1	{ v2.2s, v3.2s }, [x2], #16
	ld1	{ v14.2s, v15.2s }, [x3], #16
	ld1	{ v6.2s, v7.2s }, [x4], #16
L_1315
	tst	x0, #0x2
	b.eq	L_1316
	ld1	{ v1.2s }, [x2], #8
	ld1	{ v13.2s }, [x3], #8
	ld1	{ v5.2s }, [x4], #8
L_1316
	tst	x0, #0x1
	b.eq	L_1317
	ld1	{ v0.s }[1], [x2], #4
	ld1	{ v12.s }[1], [x3], #4
	ld1	{ v4.s }[1], [x4], #4
L_1317
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v12.8b, v13.8b
	uzp2	v13.8b, v12.8b, v13.8b
	mov	v12.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v14.8b, v15.8b
	uzp2	v15.8b, v14.8b, v15.8b
	mov	v14.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v13.8b, v15.8b
	uzp2	v15.8b, v13.8b, v15.8b
	mov	v13.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v12.8b, v14.8b
	uzp2	v14.8b, v12.8b, v14.8b
	mov	v12.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	tst	x0, #0x4
	b.eq	L_1318
	st1	{ v30.2s, v31.2s }, [x1], #16
L_1318
	tst	x0, #0x2
	b.eq	L_1319
	st1	{ v29.2s }, [x1], #8
L_1319
	tst	x0, #0x1
	b.eq	L_1320
	st1	{ v28.s }[1], [x1], #4
L_1320
L_1314
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_over_8888_n_8888_asm_neon
pixman_composite_over_8888_n_8888_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	mov	v15.s[0], w6
	dup	v15.8b, v15.b[3]
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_1321
	cmp	x0, #16
	b.lt	L_1322
L_1323
	tst	x8, #0xf
	b.eq	L_1324
	tst	x8, #0x4
	b.eq	L_1325
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
	sub	x0, x0, #1
L_1325
	tst	x8, #0x8
	b.eq	L_1326
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
	sub	x0, x0, #2
L_1326
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
	sub	x0, x0, #4
L_1327
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_1328
	add	x10, x10, #8
	sub	x9, x9, #1
L_1328
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_1329
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1329
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_1329
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x2, #0x4
	b.eq	L_1330
	st1	{ v28.s }[1], [x2], #4
L_1330
	tst	x2, #0x8
	b.eq	L_1331
	st1	{ v29.2s }, [x2], #8
L_1331
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1332
L_1324
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	add	x10, x10, #8
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_1333
	add	x10, x10, #8
	sub	x9, x9, #1
L_1333
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_1334
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1334
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_1334
	subs	x0, x0, #16
	b.lt	L_1335
L_1336
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	add	x10, x10, #8
	tst	x9, #0xf
	b.eq	L_1337
	add	x10, x10, #8
	sub	x9, x9, #1
L_1337
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_1338
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1338
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_1338
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	subs	x0, x0, #8
	b.ge	L_1336
L_1335
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	tst	x0, #0x7
	b.eq	L_1339
	tst	x0, #0x4
	b.eq	L_1340
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
L_1340
	tst	x0, #0x2
	b.eq	L_1341
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
L_1341
	tst	x0, #0x1
	b.eq	L_1342
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
L_1342
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_1343
	add	x10, x10, #8
	sub	x9, x9, #1
L_1343
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_1344
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1344
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_1344
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_1345
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1345
	tst	x0, #0x2
	b.eq	L_1346
	st1	{ v29.2s }, [x2], #8
L_1346
	tst	x0, #0x1
	b.eq	L_1347
	st1	{ v28.s }[1], [x2], #4
L_1347
L_1339
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1323
L_1348
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1322
	lsl	x15, x5, #2
	prfm	pldl1keep, [x4, x15]
	lsl	x15, x3, #2
	prfm	pldl1keep, [x8, x15]
	tst	x0, #0x8
	b.eq	L_1349
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
L_1349
	tst	x0, #0x7
	b.eq	L_1350
	tst	x0, #0x4
	b.eq	L_1351
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v6.2s, v7.2s }, [x8], #16
L_1351
	tst	x0, #0x2
	b.eq	L_1352
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v5.2s }, [x8], #8
L_1352
	tst	x0, #0x1
	b.eq	L_1353
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v4.s }[1], [x8], #4
L_1353
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_1354
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1354
	tst	x0, #0x2
	b.eq	L_1355
	st1	{ v29.2s }, [x2], #8
L_1355
	tst	x0, #0x1
	b.eq	L_1356
	st1	{ v28.s }[1], [x2], #4
L_1356
L_1350
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1322
L_1321
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_over_8888_8888_8888_asm_neon
pixman_composite_over_8888_8888_8888_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_1357
	cmp	x0, #16
	b.lt	L_1358
L_1359
	tst	x8, #0xf
	b.eq	L_1360
	tst	x8, #0x4
	b.eq	L_1361
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v12.s }[1], [x6], #4
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
	sub	x0, x0, #1
L_1361
	tst	x8, #0x8
	b.eq	L_1362
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v13.2s }, [x6], #8
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
	sub	x0, x0, #2
L_1362
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v14.2s, v15.2s }, [x6], #16
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
	sub	x0, x0, #4
L_1363
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v12.8b, v13.8b
	uzp2	v13.8b, v12.8b, v13.8b
	mov	v12.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v14.8b, v15.8b
	uzp2	v15.8b, v14.8b, v15.8b
	mov	v14.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v13.8b, v15.8b
	uzp2	v15.8b, v13.8b, v15.8b
	mov	v13.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v12.8b, v14.8b
	uzp2	v14.8b, v12.8b, v14.8b
	mov	v12.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_1364
	add	x10, x10, #8
	sub	x9, x9, #1
L_1364
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x13, x15]
	b.le	L_1365
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1365
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7, lsl #2
	ldrsb	x15, [x13]
L_1365
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x2, #0x4
	b.eq	L_1366
	st1	{ v28.s }[1], [x2], #4
L_1366
	tst	x2, #0x8
	b.eq	L_1367
	st1	{ v29.2s }, [x2], #8
L_1367
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1368
L_1360
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	ld4	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x6], #32
	add	x10, x10, #8
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_1369
	add	x10, x10, #8
	sub	x9, x9, #1
L_1369
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x13, x15]
	b.le	L_1370
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1370
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7, lsl #2
	ldrsb	x15, [x13]
L_1370
	subs	x0, x0, #16
	b.lt	L_1371
L_1372
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	add	x10, x10, #8
	tst	x9, #0xf
	b.eq	L_1373
	add	x10, x10, #8
	sub	x9, x9, #1
L_1373
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x13, x15]
	b.le	L_1374
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1374
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7, lsl #2
	ldrsb	x15, [x13]
L_1374
	ld4	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x6], #32
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	subs	x0, x0, #8
	b.ge	L_1372
L_1371
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	tst	x0, #0x7
	b.eq	L_1375
	tst	x0, #0x4
	b.eq	L_1376
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v14.2s, v15.2s }, [x6], #16
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
L_1376
	tst	x0, #0x2
	b.eq	L_1377
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v13.2s }, [x6], #8
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
L_1377
	tst	x0, #0x1
	b.eq	L_1378
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v12.s }[1], [x6], #4
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
L_1378
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v12.8b, v13.8b
	uzp2	v13.8b, v12.8b, v13.8b
	mov	v12.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v14.8b, v15.8b
	uzp2	v15.8b, v14.8b, v15.8b
	mov	v14.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v13.8b, v15.8b
	uzp2	v15.8b, v13.8b, v15.8b
	mov	v13.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v12.8b, v14.8b
	uzp2	v14.8b, v12.8b, v14.8b
	mov	v12.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_1379
	add	x10, x10, #8
	sub	x9, x9, #1
L_1379
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x13, x15]
	b.le	L_1380
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1380
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7, lsl #2
	ldrsb	x15, [x13]
L_1380
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_1381
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1381
	tst	x0, #0x2
	b.eq	L_1382
	st1	{ v29.2s }, [x2], #8
L_1382
	tst	x0, #0x1
	b.eq	L_1383
	st1	{ v28.s }[1], [x2], #4
L_1383
L_1375
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	add	x6, x6, x7, lsl #2
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	sub	x6, x6, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1359
L_1384
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1358
	lsl	x15, x5, #2
	prfm	pldl1keep, [x4, x15]
	lsl	x15, x3, #2
	prfm	pldl1keep, [x8, x15]
	lsl	x15, x7, #2
	prfm	pldl1keep, [x6, x15]
	tst	x0, #0x8
	b.eq	L_1385
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	ld4	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x6], #32
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
L_1385
	tst	x0, #0x7
	b.eq	L_1386
	tst	x0, #0x4
	b.eq	L_1387
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v14.2s, v15.2s }, [x6], #16
	ld1	{ v6.2s, v7.2s }, [x8], #16
L_1387
	tst	x0, #0x2
	b.eq	L_1388
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v13.2s }, [x6], #8
	ld1	{ v5.2s }, [x8], #8
L_1388
	tst	x0, #0x1
	b.eq	L_1389
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v12.s }[1], [x6], #4
	ld1	{ v4.s }[1], [x8], #4
L_1389
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v12.8b, v13.8b
	uzp2	v13.8b, v12.8b, v13.8b
	mov	v12.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v14.8b, v15.8b
	uzp2	v15.8b, v14.8b, v15.8b
	mov	v14.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v13.8b, v15.8b
	uzp2	v15.8b, v13.8b, v15.8b
	mov	v13.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v12.8b, v14.8b
	uzp2	v14.8b, v12.8b, v14.8b
	mov	v12.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_1390
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1390
	tst	x0, #0x2
	b.eq	L_1391
	st1	{ v29.2s }, [x2], #8
L_1391
	tst	x0, #0x1
	b.eq	L_1392
	st1	{ v28.s }[1], [x2], #4
L_1392
L_1386
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	add	x6, x6, x7, lsl #2
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	sub	x6, x6, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1358
L_1357
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_scanline_over_mask_asm_neon
pixman_composite_scanline_over_mask_asm_neon
	sxtw	x0, w0
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #64
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	mov	x4, x1
	cmp	x0, #8
	b.lt	L_1393
	tst	x4, #0xf
	b.eq	L_1394
	tst	x4, #0x4
	b.eq	L_1395
	ld1	{ v0.s }[1], [x2], #4
	ld1	{ v12.s }[1], [x3], #4
	ld1	{ v4.s }[1], [x4], #4
	sub	x0, x0, #1
L_1395
	tst	x4, #0x8
	b.eq	L_1396
	ld1	{ v1.2s }, [x2], #8
	ld1	{ v13.2s }, [x3], #8
	ld1	{ v5.2s }, [x4], #8
	sub	x0, x0, #2
L_1396
	ld1	{ v2.2s, v3.2s }, [x2], #16
	ld1	{ v14.2s, v15.2s }, [x3], #16
	ld1	{ v6.2s, v7.2s }, [x4], #16
	sub	x0, x0, #4
L_1397
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v12.8b, v13.8b
	uzp2	v13.8b, v12.8b, v13.8b
	mov	v12.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v14.8b, v15.8b
	uzp2	v15.8b, v14.8b, v15.8b
	mov	v14.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v13.8b, v15.8b
	uzp2	v15.8b, v13.8b, v15.8b
	mov	v13.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v12.8b, v14.8b
	uzp2	v14.8b, v12.8b, v14.8b
	mov	v12.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
L_1398
L_1399
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	tst	x1, #0x4
	b.eq	L_1400
	st1	{ v28.s }[1], [x1], #4
L_1400
	tst	x1, #0x8
	b.eq	L_1401
	st1	{ v29.2s }, [x1], #8
L_1401
	st1	{ v30.2s, v31.2s }, [x1], #16
L_1402
L_1394
	subs	x0, x0, #8
	b.lt	L_1403
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x4], #32
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], #32
	ld4	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x3], #32
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	subs	x0, x0, #8
	b.lt	L_1404
L_1405
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x4], #32
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], #32
L_1406
L_1407
	ld4	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x3], #32
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x1], #32
	subs	x0, x0, #8
	b.ge	L_1405
L_1404
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x1], #32
L_1403
	tst	x0, #0x7
	b.eq	L_1408
	tst	x0, #0x4
	b.eq	L_1409
	ld1	{ v2.2s, v3.2s }, [x2], #16
	ld1	{ v14.2s, v15.2s }, [x3], #16
	ld1	{ v6.2s, v7.2s }, [x4], #16
L_1409
	tst	x0, #0x2
	b.eq	L_1410
	ld1	{ v1.2s }, [x2], #8
	ld1	{ v13.2s }, [x3], #8
	ld1	{ v5.2s }, [x4], #8
L_1410
	tst	x0, #0x1
	b.eq	L_1411
	ld1	{ v0.s }[1], [x2], #4
	ld1	{ v12.s }[1], [x3], #4
	ld1	{ v4.s }[1], [x4], #4
L_1411
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v12.8b, v13.8b
	uzp2	v13.8b, v12.8b, v13.8b
	mov	v12.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v14.8b, v15.8b
	uzp2	v15.8b, v14.8b, v15.8b
	mov	v14.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v13.8b, v15.8b
	uzp2	v15.8b, v13.8b, v15.8b
	mov	v13.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v12.8b, v14.8b
	uzp2	v14.8b, v12.8b, v14.8b
	mov	v12.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	tst	x0, #0x4
	b.eq	L_1412
	st1	{ v30.2s, v31.2s }, [x1], #16
L_1412
	tst	x0, #0x2
	b.eq	L_1413
	st1	{ v29.2s }, [x1], #8
L_1413
	tst	x0, #0x1
	b.eq	L_1414
	st1	{ v28.s }[1], [x1], #4
L_1414
L_1408
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1393
	tst	x0, #0x7
	b.eq	L_1415
	tst	x0, #0x4
	b.eq	L_1416
	ld1	{ v2.2s, v3.2s }, [x2], #16
	ld1	{ v14.2s, v15.2s }, [x3], #16
	ld1	{ v6.2s, v7.2s }, [x4], #16
L_1416
	tst	x0, #0x2
	b.eq	L_1417
	ld1	{ v1.2s }, [x2], #8
	ld1	{ v13.2s }, [x3], #8
	ld1	{ v5.2s }, [x4], #8
L_1417
	tst	x0, #0x1
	b.eq	L_1418
	ld1	{ v0.s }[1], [x2], #4
	ld1	{ v12.s }[1], [x3], #4
	ld1	{ v4.s }[1], [x4], #4
L_1418
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v12.8b, v13.8b
	uzp2	v13.8b, v12.8b, v13.8b
	mov	v12.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v14.8b, v15.8b
	uzp2	v15.8b, v14.8b, v15.8b
	mov	v14.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v13.8b, v15.8b
	uzp2	v15.8b, v13.8b, v15.8b
	mov	v13.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v12.8b, v14.8b
	uzp2	v14.8b, v12.8b, v14.8b
	mov	v12.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	tst	x0, #0x4
	b.eq	L_1419
	st1	{ v30.2s, v31.2s }, [x1], #16
L_1419
	tst	x0, #0x2
	b.eq	L_1420
	st1	{ v29.2s }, [x1], #8
L_1420
	tst	x0, #0x1
	b.eq	L_1421
	st1	{ v28.s }[1], [x1], #4
L_1421
L_1415
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_over_8888_8_8888_asm_neon
pixman_composite_over_8888_8_8888_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_1422
	cmp	x0, #16
	b.lt	L_1423
L_1424
	tst	x8, #0xf
	b.eq	L_1425
	tst	x8, #0x4
	b.eq	L_1426
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v15.b }[1], [x6], #1
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
	sub	x0, x0, #1
L_1426
	tst	x8, #0x8
	b.eq	L_1427
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v15.b }[2], [x6], #1
	ld1	{ v15.b }[3], [x6], #1
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
	sub	x0, x0, #2
L_1427
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v15.b }[4], [x6], #1
	ld1	{ v15.b }[5], [x6], #1
	ld1	{ v15.b }[6], [x6], #1
	ld1	{ v15.b }[7], [x6], #1
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
	sub	x0, x0, #4
L_1428
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_1429
	add	x10, x10, #8
	sub	x9, x9, #1
L_1429
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1430
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1430
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1430
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x2, #0x4
	b.eq	L_1431
	st1	{ v28.s }[1], [x2], #4
L_1431
	tst	x2, #0x8
	b.eq	L_1432
	st1	{ v29.2s }, [x2], #8
L_1432
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1433
L_1425
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	ld1	{ v15.8b }, [x6], #8
	add	x10, x10, #8
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_1434
	add	x10, x10, #8
	sub	x9, x9, #1
L_1434
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1435
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1435
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1435
	subs	x0, x0, #16
	b.lt	L_1436
L_1437
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	add	x10, x10, #8
	tst	x9, #0xf
	b.eq	L_1438
	add	x10, x10, #8
	sub	x9, x9, #1
L_1438
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1439
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1439
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1439
	ld1	{ v15.8b }, [x6], #8
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	subs	x0, x0, #8
	b.ge	L_1437
L_1436
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	tst	x0, #0x7
	b.eq	L_1440
	tst	x0, #0x4
	b.eq	L_1441
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v15.b }[4], [x6], #1
	ld1	{ v15.b }[5], [x6], #1
	ld1	{ v15.b }[6], [x6], #1
	ld1	{ v15.b }[7], [x6], #1
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
L_1441
	tst	x0, #0x2
	b.eq	L_1442
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v15.b }[2], [x6], #1
	ld1	{ v15.b }[3], [x6], #1
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
L_1442
	tst	x0, #0x1
	b.eq	L_1443
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v15.b }[1], [x6], #1
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
L_1443
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_1444
	add	x10, x10, #8
	sub	x9, x9, #1
L_1444
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1445
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1445
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1445
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_1446
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1446
	tst	x0, #0x2
	b.eq	L_1447
	st1	{ v29.2s }, [x2], #8
L_1447
	tst	x0, #0x1
	b.eq	L_1448
	st1	{ v28.s }[1], [x2], #4
L_1448
L_1440
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	add	x6, x6, x7
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1424
L_1449
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1423
	lsl	x15, x5, #2
	prfm	pldl1keep, [x4, x15]
	lsl	x15, x3, #2
	prfm	pldl1keep, [x8, x15]
	lsr	x15, x7, #0
	prfm	pldl1keep, [x6, x15]
	tst	x0, #0x8
	b.eq	L_1450
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	ld1	{ v15.8b }, [x6], #8
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
L_1450
	tst	x0, #0x7
	b.eq	L_1451
	tst	x0, #0x4
	b.eq	L_1452
	ld1	{ v2.2s, v3.2s }, [x4], #16
	ld1	{ v15.b }[4], [x6], #1
	ld1	{ v15.b }[5], [x6], #1
	ld1	{ v15.b }[6], [x6], #1
	ld1	{ v15.b }[7], [x6], #1
	ld1	{ v6.2s, v7.2s }, [x8], #16
L_1452
	tst	x0, #0x2
	b.eq	L_1453
	ld1	{ v1.2s }, [x4], #8
	ld1	{ v15.b }[2], [x6], #1
	ld1	{ v15.b }[3], [x6], #1
	ld1	{ v5.2s }, [x8], #8
L_1453
	tst	x0, #0x1
	b.eq	L_1454
	ld1	{ v0.s }[1], [x4], #4
	ld1	{ v15.b }[1], [x6], #1
	ld1	{ v4.s }[1], [x8], #4
L_1454
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umull	v11.8h, v15.8b, v3.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	urshr	v16.8h, v11.8h, #8
	urshr	v14.8h, v10.8h, #8
	urshr	v13.8h, v9.8h, #8
	urshr	v12.8h, v8.8h, #8
	raddhn	v3.8b, v11.8h, v16.8h
	raddhn	v2.8b, v10.8h, v14.8h
	raddhn	v1.8b, v9.8h, v13.8h
	raddhn	v0.8b, v8.8h, v12.8h
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	urshr	v16.8h, v8.8h, #8
	urshr	v17.8h, v9.8h, #8
	urshr	v18.8h, v10.8h, #8
	urshr	v19.8h, v11.8h, #8
	raddhn	v28.8b, v16.8h, v8.8h
	raddhn	v29.8b, v17.8h, v9.8h
	raddhn	v30.8b, v18.8h, v10.8h
	raddhn	v31.8b, v19.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_1455
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1455
	tst	x0, #0x2
	b.eq	L_1456
	st1	{ v29.2s }, [x2], #8
L_1456
	tst	x0, #0x1
	b.eq	L_1457
	st1	{ v28.s }[1], [x2], #4
L_1457
L_1451
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	add	x6, x6, x7
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1423
L_1422
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_src_0888_0888_asm_neon
pixman_composite_src_0888_0888_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x8, x2
	sub	x5, x5, x0
	sub	x5, x5, x0, lsl #1
	sub	x3, x3, x0
	sub	x3, x3, x0, lsl #1
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_1458
	cmp	x0, #16
	b.lt	L_1459
L_1460
L_1461
	ld3	{ v0.8b, v1.8b, v2.8b }, [x4], #24
L_1462
L_1463
	prfm	pldl1keep, [x4, #192]
	subs	x0, x0, #16
	b.lt	L_1464
L_1465
	st3	{ v0.8b, v1.8b, v2.8b }, [x2], #24
	ld3	{ v0.8b, v1.8b, v2.8b }, [x4], #24
L_1466
L_1467
	prfm	pldl1keep, [x4, #192]
	subs	x0, x0, #8
	b.ge	L_1465
L_1464
	st3	{ v0.8b, v1.8b, v2.8b }, [x2], #24
	tst	x0, #0x7
	b.eq	L_1468
	tst	x0, #0x4
	b.eq	L_1469
	ld3	{ v0.b, v1.b, v2.b }[4], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[5], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[6], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[7], [x4], #3
L_1469
	tst	x0, #0x2
	b.eq	L_1470
	ld3	{ v0.b, v1.b, v2.b }[2], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[3], [x4], #3
L_1470
	tst	x0, #0x1
	b.eq	L_1471
	ld3	{ v0.b, v1.b, v2.b }[1], [x4], #3
L_1471
L_1472
L_1473
	prfm	pldl1keep, [x4, #192]
	tst	x0, #0x4
	b.eq	L_1474
	st3	{ v0.b, v1.b, v2.b }[4], [x2], #3
	st3	{ v0.b, v1.b, v2.b }[5], [x2], #3
	st3	{ v0.b, v1.b, v2.b }[6], [x2], #3
	st3	{ v0.b, v1.b, v2.b }[7], [x2], #3
L_1474
	tst	x0, #0x2
	b.eq	L_1475
	st3	{ v0.b, v1.b, v2.b }[2], [x2], #3
	st3	{ v0.b, v1.b, v2.b }[3], [x2], #3
L_1475
	tst	x0, #0x1
	b.eq	L_1476
	st3	{ v0.b, v1.b, v2.b }[1], [x2], #3
L_1476
L_1468
	mov	x0, x14
	add	x2, x2, x3
	add	x4, x4, x5
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1460
L_1477
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1459
	tst	x0, #0x8
	b.eq	L_1478
	ld3	{ v0.8b, v1.8b, v2.8b }, [x4], #24
	st3	{ v0.8b, v1.8b, v2.8b }, [x2], #24
L_1478
	tst	x0, #0x7
	b.eq	L_1479
	tst	x0, #0x4
	b.eq	L_1480
	ld3	{ v0.b, v1.b, v2.b }[4], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[5], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[6], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[7], [x4], #3
L_1480
	tst	x0, #0x2
	b.eq	L_1481
	ld3	{ v0.b, v1.b, v2.b }[2], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[3], [x4], #3
L_1481
	tst	x0, #0x1
	b.eq	L_1482
	ld3	{ v0.b, v1.b, v2.b }[1], [x4], #3
L_1482
	tst	x0, #0x4
	b.eq	L_1483
	st3	{ v0.b, v1.b, v2.b }[4], [x2], #3
	st3	{ v0.b, v1.b, v2.b }[5], [x2], #3
	st3	{ v0.b, v1.b, v2.b }[6], [x2], #3
	st3	{ v0.b, v1.b, v2.b }[7], [x2], #3
L_1483
	tst	x0, #0x2
	b.eq	L_1484
	st3	{ v0.b, v1.b, v2.b }[2], [x2], #3
	st3	{ v0.b, v1.b, v2.b }[3], [x2], #3
L_1484
	tst	x0, #0x1
	b.eq	L_1485
	st3	{ v0.b, v1.b, v2.b }[1], [x2], #3
L_1485
L_1479
	mov	x0, x14
	add	x2, x2, x3
	add	x4, x4, x5
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1459
L_1458
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_src_0888_8888_rev_asm_neon
pixman_composite_src_0888_8888_rev_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x8, x2
	sub	x5, x5, x0
	sub	x5, x5, x0, lsl #1
	eor	v3.8b, v3.8b, v3.8b
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_1486
	cmp	x0, #16
	b.lt	L_1487
L_1488
	tst	x8, #0xf
	b.eq	L_1489
	tst	x8, #0x4
	b.eq	L_1490
	ld3	{ v0.b, v1.b, v2.b }[1], [x4], #3
	add	x8, x8, #4
	sub	x0, x0, #1
L_1490
	tst	x8, #0x8
	b.eq	L_1491
	ld3	{ v0.b, v1.b, v2.b }[2], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[3], [x4], #3
	add	x8, x8, #8
	sub	x0, x0, #2
L_1491
	ld3	{ v0.b, v1.b, v2.b }[4], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[5], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[6], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[7], [x4], #3
	add	x8, x8, #16
	sub	x0, x0, #4
L_1492
	mov	v31.8b, v2.8b
	mov	v2.8b, v0.8b
	mov	v0.8b, v31.8b
L_1493
L_1494
	prfm	pldl1keep, [x4, #192]
	umov	x15, v16.d[0]
	zip1	v16.8b, v0.8b, v2.8b
	zip2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v1.8b, v3.8b
	zip2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v2.8b, v3.8b
	zip2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v0.8b, v1.8b
	zip2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	tst	x2, #0x4
	b.eq	L_1495
	st1	{ v0.s }[1], [x2], #4
L_1495
	tst	x2, #0x8
	b.eq	L_1496
	st1	{ v1.2s }, [x2], #8
L_1496
	st1	{ v2.2s, v3.2s }, [x2], #16
L_1497
L_1489
	ld3	{ v0.8b, v1.8b, v2.8b }, [x4], #24
	mov	v31.8b, v2.8b
	mov	v2.8b, v0.8b
	mov	v0.8b, v31.8b
L_1498
L_1499
	prfm	pldl1keep, [x4, #192]
	subs	x0, x0, #16
	b.lt	L_1500
L_1501
	st4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], #32
	ld3	{ v0.8b, v1.8b, v2.8b }, [x4], #24
	mov	v31.8b, v2.8b
	mov	v2.8b, v0.8b
	mov	v0.8b, v31.8b
L_1502
L_1503
	prfm	pldl1keep, [x4, #192]
	subs	x0, x0, #8
	b.ge	L_1501
L_1500
	st4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], #32
	tst	x0, #0x7
	b.eq	L_1504
	tst	x0, #0x4
	b.eq	L_1505
	ld3	{ v0.b, v1.b, v2.b }[4], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[5], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[6], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[7], [x4], #3
L_1505
	tst	x0, #0x2
	b.eq	L_1506
	ld3	{ v0.b, v1.b, v2.b }[2], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[3], [x4], #3
L_1506
	tst	x0, #0x1
	b.eq	L_1507
	ld3	{ v0.b, v1.b, v2.b }[1], [x4], #3
L_1507
	mov	v31.8b, v2.8b
	mov	v2.8b, v0.8b
	mov	v0.8b, v31.8b
L_1508
L_1509
	prfm	pldl1keep, [x4, #192]
	umov	x15, v16.d[0]
	zip1	v16.8b, v0.8b, v2.8b
	zip2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v1.8b, v3.8b
	zip2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v2.8b, v3.8b
	zip2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v0.8b, v1.8b
	zip2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_1510
	st1	{ v2.2s, v3.2s }, [x2], #16
L_1510
	tst	x0, #0x2
	b.eq	L_1511
	st1	{ v1.2s }, [x2], #8
L_1511
	tst	x0, #0x1
	b.eq	L_1512
	st1	{ v0.s }[1], [x2], #4
L_1512
L_1504
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5
	sub	x2, x2, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1488
L_1513
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1487
	tst	x0, #0x8
	b.eq	L_1514
	ld3	{ v0.8b, v1.8b, v2.8b }, [x4], #24
	mov	v31.8b, v2.8b
	mov	v2.8b, v0.8b
	mov	v0.8b, v31.8b
	st4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], #32
L_1514
	tst	x0, #0x7
	b.eq	L_1515
	tst	x0, #0x4
	b.eq	L_1516
	ld3	{ v0.b, v1.b, v2.b }[4], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[5], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[6], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[7], [x4], #3
L_1516
	tst	x0, #0x2
	b.eq	L_1517
	ld3	{ v0.b, v1.b, v2.b }[2], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[3], [x4], #3
L_1517
	tst	x0, #0x1
	b.eq	L_1518
	ld3	{ v0.b, v1.b, v2.b }[1], [x4], #3
L_1518
	mov	v31.8b, v2.8b
	mov	v2.8b, v0.8b
	mov	v0.8b, v31.8b
	umov	x15, v16.d[0]
	zip1	v16.8b, v0.8b, v2.8b
	zip2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v1.8b, v3.8b
	zip2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v2.8b, v3.8b
	zip2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v0.8b, v1.8b
	zip2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_1519
	st1	{ v2.2s, v3.2s }, [x2], #16
L_1519
	tst	x0, #0x2
	b.eq	L_1520
	st1	{ v1.2s }, [x2], #8
L_1520
	tst	x0, #0x1
	b.eq	L_1521
	st1	{ v0.s }[1], [x2], #4
L_1521
L_1515
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5
	sub	x2, x2, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1487
L_1486
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_src_0888_0565_rev_asm_neon
pixman_composite_src_0888_0565_rev_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x8, x2
	sub	x5, x5, x0
	sub	x5, x5, x0, lsl #1
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_1522
	cmp	x0, #16
	b.lt	L_1523
L_1524
	tst	x8, #0xf
	b.eq	L_1525
	tst	x8, #0x2
	b.eq	L_1526
	ld3	{ v0.b, v1.b, v2.b }[1], [x4], #3
	add	x8, x8, #2
	sub	x0, x0, #1
L_1526
	tst	x8, #0x4
	b.eq	L_1527
	ld3	{ v0.b, v1.b, v2.b }[2], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[3], [x4], #3
	add	x8, x8, #4
	sub	x0, x0, #2
L_1527
	tst	x8, #0x8
	b.eq	L_1528
	ld3	{ v0.b, v1.b, v2.b }[4], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[5], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[6], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[7], [x4], #3
	add	x8, x8, #8
	sub	x0, x0, #4
L_1528
	ushll	v8.8h, v1.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v9.8h, v2.8b, #7
	sli	v9.8h, v9.8h, #1
L_1529
L_1530
	prfm	pldl1keep, [x4, #192]
	ushll	v14.8h, v0.8b, #7
	sli	v14.8h, v14.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x2, #0x2
	b.eq	L_1531
	st1	{ v28.h }[1], [x2], #2
L_1531
	tst	x2, #0x4
	b.eq	L_1532
	st1	{ v28.s }[1], [x2], #4
L_1532
	tst	x2, #0x8
	b.eq	L_1533
	st1	{ v29.4h }, [x2], #8
L_1533
L_1525
	ld3	{ v0.8b, v1.8b, v2.8b }, [x4], #24
	ushll	v8.8h, v1.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v9.8h, v2.8b, #7
	sli	v9.8h, v9.8h, #1
L_1534
L_1535
	prfm	pldl1keep, [x4, #192]
	subs	x0, x0, #16
	b.lt	L_1536
L_1537
	ushll	v14.8h, v0.8b, #7
	sli	v14.8h, v14.8h, #1
	ld3	{ v0.8b, v1.8b, v2.8b }, [x4], #24
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	ushll	v8.8h, v1.8b, #7
	sli	v8.8h, v8.8h, #1
	st1	{ v14.8h }, [x2], #16
	ushll	v9.8h, v2.8b, #7
	sli	v9.8h, v9.8h, #1
	prfm	pldl1keep, [x4, #192]
	subs	x0, x0, #8
	b.ge	L_1537
L_1536
	ushll	v14.8h, v0.8b, #7
	sli	v14.8h, v14.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
	tst	x0, #0x7
	b.eq	L_1538
	tst	x0, #0x4
	b.eq	L_1539
	ld3	{ v0.b, v1.b, v2.b }[4], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[5], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[6], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[7], [x4], #3
L_1539
	tst	x0, #0x2
	b.eq	L_1540
	ld3	{ v0.b, v1.b, v2.b }[2], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[3], [x4], #3
L_1540
	tst	x0, #0x1
	b.eq	L_1541
	ld3	{ v0.b, v1.b, v2.b }[1], [x4], #3
L_1541
	ushll	v8.8h, v1.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v9.8h, v2.8b, #7
	sli	v9.8h, v9.8h, #1
L_1542
L_1543
	prfm	pldl1keep, [x4, #192]
	ushll	v14.8h, v0.8b, #7
	sli	v14.8h, v14.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_1544
	st1	{ v29.4h }, [x2], #8
L_1544
	tst	x0, #0x2
	b.eq	L_1545
	st1	{ v28.s }[1], [x2], #4
L_1545
	tst	x0, #0x1
	b.eq	L_1546
	st1	{ v28.h }[1], [x2], #2
L_1546
L_1538
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x4, x4, x5
	sub	x2, x2, x0, lsl #1
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1524
L_1547
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1523
	tst	x0, #0x8
	b.eq	L_1548
	ld3	{ v0.8b, v1.8b, v2.8b }, [x4], #24
	ushll	v8.8h, v1.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v9.8h, v2.8b, #7
	sli	v9.8h, v9.8h, #1
	ushll	v14.8h, v0.8b, #7
	sli	v14.8h, v14.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
L_1548
	tst	x0, #0x7
	b.eq	L_1549
	tst	x0, #0x4
	b.eq	L_1550
	ld3	{ v0.b, v1.b, v2.b }[4], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[5], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[6], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[7], [x4], #3
L_1550
	tst	x0, #0x2
	b.eq	L_1551
	ld3	{ v0.b, v1.b, v2.b }[2], [x4], #3
	ld3	{ v0.b, v1.b, v2.b }[3], [x4], #3
L_1551
	tst	x0, #0x1
	b.eq	L_1552
	ld3	{ v0.b, v1.b, v2.b }[1], [x4], #3
L_1552
	ushll	v8.8h, v1.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v9.8h, v2.8b, #7
	sli	v9.8h, v9.8h, #1
	ushll	v14.8h, v0.8b, #7
	sli	v14.8h, v14.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_1553
	st1	{ v29.4h }, [x2], #8
L_1553
	tst	x0, #0x2
	b.eq	L_1554
	st1	{ v28.h }[2], [x2], #2
	st1	{ v28.h }[3], [x2], #2
L_1554
	tst	x0, #0x1
	b.eq	L_1555
	st1	{ v28.h }[1], [x2], #2
L_1555
L_1549
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x4, x4, x5
	sub	x2, x2, x0, lsl #1
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1523
L_1522
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_src_pixbuf_8888_asm_neon
pixman_composite_src_pixbuf_8888_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #6
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_1556
	cmp	x0, #16
	b.lt	L_1557
L_1558
	tst	x8, #0xf
	b.eq	L_1559
	tst	x8, #0x4
	b.eq	L_1560
	ld1	{ v0.s }[1], [x4], #4
	add	x8, x8, #4
	add	x10, x10, #1
	sub	x0, x0, #1
L_1560
	tst	x8, #0x8
	b.eq	L_1561
	ld1	{ v1.2s }, [x4], #8
	add	x8, x8, #8
	add	x10, x10, #2
	sub	x0, x0, #2
L_1561
	ld1	{ v2.2s, v3.2s }, [x4], #16
	add	x8, x8, #16
	add	x10, x10, #4
	sub	x0, x0, #4
L_1562
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umull	v8.8h, v3.8b, v0.8b
	umull	v9.8h, v3.8b, v1.8b
	umull	v10.8h, v3.8b, v2.8b
	tst	x9, #0xf
	b.eq	L_1563
	add	x10, x10, #8
	sub	x9, x9, #1
L_1563
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	b.le	L_1564
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1564
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
L_1564
	urshr	v11.8h, v8.8h, #8
	mov	v30.8b, v31.8b
	mov	v31.8b, v3.8b
	mov	v3.8b, v30.8b
	urshr	v12.8h, v9.8h, #8
	urshr	v13.8h, v10.8h, #8
	raddhn	v30.8b, v11.8h, v8.8h
	raddhn	v29.8b, v12.8h, v9.8h
	raddhn	v28.8b, v13.8h, v10.8h
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x2, #0x4
	b.eq	L_1565
	st1	{ v28.s }[1], [x2], #4
L_1565
	tst	x2, #0x8
	b.eq	L_1566
	st1	{ v29.2s }, [x2], #8
L_1566
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1567
L_1559
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	add	x10, x10, #8
	umull	v8.8h, v3.8b, v0.8b
	umull	v9.8h, v3.8b, v1.8b
	umull	v10.8h, v3.8b, v2.8b
	tst	x9, #0xf
	b.eq	L_1568
	add	x10, x10, #8
	sub	x9, x9, #1
L_1568
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	b.le	L_1569
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1569
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
L_1569
	subs	x0, x0, #16
	b.lt	L_1570
L_1571
	urshr	v11.8h, v8.8h, #8
	mov	v30.8b, v31.8b
	mov	v31.8b, v3.8b
	mov	v3.8b, v31.8b
	urshr	v12.8h, v9.8h, #8
	urshr	v13.8h, v10.8h, #8
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	raddhn	v30.8b, v11.8h, v8.8h
	add	x10, x10, #8
	tst	x9, #0xf
	b.eq	L_1572
	add	x10, x10, #8
	sub	x9, x9, #1
L_1572
	raddhn	v29.8b, v12.8h, v9.8h
	raddhn	v28.8b, v13.8h, v10.8h
	umull	v8.8h, v3.8b, v0.8b
	umull	v9.8h, v3.8b, v1.8b
	umull	v10.8h, v3.8b, v2.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	b.le	L_1573
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1573
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
L_1573
	subs	x0, x0, #8
	b.ge	L_1571
L_1570
	urshr	v11.8h, v8.8h, #8
	mov	v30.8b, v31.8b
	mov	v31.8b, v3.8b
	mov	v3.8b, v30.8b
	urshr	v12.8h, v9.8h, #8
	urshr	v13.8h, v10.8h, #8
	raddhn	v30.8b, v11.8h, v8.8h
	raddhn	v29.8b, v12.8h, v9.8h
	raddhn	v28.8b, v13.8h, v10.8h
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	tst	x0, #0x7
	b.eq	L_1574
	tst	x0, #0x4
	b.eq	L_1575
	ld1	{ v2.2s, v3.2s }, [x4], #16
	add	x10, x10, #4
L_1575
	tst	x0, #0x2
	b.eq	L_1576
	ld1	{ v1.2s }, [x4], #8
	add	x10, x10, #2
L_1576
	tst	x0, #0x1
	b.eq	L_1577
	ld1	{ v0.s }[1], [x4], #4
	add	x10, x10, #1
L_1577
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umull	v8.8h, v3.8b, v0.8b
	umull	v9.8h, v3.8b, v1.8b
	umull	v10.8h, v3.8b, v2.8b
	tst	x9, #0xf
	b.eq	L_1578
	add	x10, x10, #8
	sub	x9, x9, #1
L_1578
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	b.le	L_1579
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1579
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
L_1579
	urshr	v11.8h, v8.8h, #8
	mov	v30.8b, v31.8b
	mov	v31.8b, v3.8b
	mov	v3.8b, v30.8b
	urshr	v12.8h, v9.8h, #8
	urshr	v13.8h, v10.8h, #8
	raddhn	v30.8b, v11.8h, v8.8h
	raddhn	v29.8b, v12.8h, v9.8h
	raddhn	v28.8b, v13.8h, v10.8h
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_1580
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1580
	tst	x0, #0x2
	b.eq	L_1581
	st1	{ v29.2s }, [x2], #8
L_1581
	tst	x0, #0x1
	b.eq	L_1582
	st1	{ v28.s }[1], [x2], #4
L_1582
L_1574
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1558
L_1583
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1557
	lsl	x15, x5, #2
	prfm	pldl1keep, [x4, x15]
	tst	x0, #0x8
	b.eq	L_1584
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	umull	v8.8h, v3.8b, v0.8b
	umull	v9.8h, v3.8b, v1.8b
	umull	v10.8h, v3.8b, v2.8b
	urshr	v11.8h, v8.8h, #8
	mov	v30.8b, v31.8b
	mov	v31.8b, v3.8b
	mov	v3.8b, v30.8b
	urshr	v12.8h, v9.8h, #8
	urshr	v13.8h, v10.8h, #8
	raddhn	v30.8b, v11.8h, v8.8h
	raddhn	v29.8b, v12.8h, v9.8h
	raddhn	v28.8b, v13.8h, v10.8h
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
L_1584
	tst	x0, #0x7
	b.eq	L_1585
	tst	x0, #0x4
	b.eq	L_1586
	ld1	{ v2.2s, v3.2s }, [x4], #16
L_1586
	tst	x0, #0x2
	b.eq	L_1587
	ld1	{ v1.2s }, [x4], #8
L_1587
	tst	x0, #0x1
	b.eq	L_1588
	ld1	{ v0.s }[1], [x4], #4
L_1588
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umull	v8.8h, v3.8b, v0.8b
	umull	v9.8h, v3.8b, v1.8b
	umull	v10.8h, v3.8b, v2.8b
	urshr	v11.8h, v8.8h, #8
	mov	v30.8b, v31.8b
	mov	v31.8b, v3.8b
	mov	v3.8b, v30.8b
	urshr	v12.8h, v9.8h, #8
	urshr	v13.8h, v10.8h, #8
	raddhn	v30.8b, v11.8h, v8.8h
	raddhn	v29.8b, v12.8h, v9.8h
	raddhn	v28.8b, v13.8h, v10.8h
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_1589
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1589
	tst	x0, #0x2
	b.eq	L_1590
	st1	{ v29.2s }, [x2], #8
L_1590
	tst	x0, #0x1
	b.eq	L_1591
	st1	{ v28.s }[1], [x2], #4
L_1591
L_1585
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1557
L_1556
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_src_rpixbuf_8888_asm_neon
pixman_composite_src_rpixbuf_8888_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #6
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_1592
	cmp	x0, #16
	b.lt	L_1593
L_1594
	tst	x8, #0xf
	b.eq	L_1595
	tst	x8, #0x4
	b.eq	L_1596
	ld1	{ v0.s }[1], [x4], #4
	add	x8, x8, #4
	add	x10, x10, #1
	sub	x0, x0, #1
L_1596
	tst	x8, #0x8
	b.eq	L_1597
	ld1	{ v1.2s }, [x4], #8
	add	x8, x8, #8
	add	x10, x10, #2
	sub	x0, x0, #2
L_1597
	ld1	{ v2.2s, v3.2s }, [x4], #16
	add	x8, x8, #16
	add	x10, x10, #4
	sub	x0, x0, #4
L_1598
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umull	v8.8h, v3.8b, v0.8b
	umull	v9.8h, v3.8b, v1.8b
	umull	v10.8h, v3.8b, v2.8b
	tst	x9, #0xf
	b.eq	L_1599
	add	x10, x10, #8
	sub	x9, x9, #1
L_1599
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	b.le	L_1600
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1600
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
L_1600
	urshr	v11.8h, v8.8h, #8
	mov	v30.8b, v31.8b
	mov	v31.8b, v3.8b
	mov	v3.8b, v30.8b
	urshr	v12.8h, v9.8h, #8
	urshr	v13.8h, v10.8h, #8
	raddhn	v28.8b, v11.8h, v8.8h
	raddhn	v29.8b, v12.8h, v9.8h
	raddhn	v30.8b, v13.8h, v10.8h
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x2, #0x4
	b.eq	L_1601
	st1	{ v28.s }[1], [x2], #4
L_1601
	tst	x2, #0x8
	b.eq	L_1602
	st1	{ v29.2s }, [x2], #8
L_1602
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1603
L_1595
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	add	x10, x10, #8
	umull	v8.8h, v3.8b, v0.8b
	umull	v9.8h, v3.8b, v1.8b
	umull	v10.8h, v3.8b, v2.8b
	tst	x9, #0xf
	b.eq	L_1604
	add	x10, x10, #8
	sub	x9, x9, #1
L_1604
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	b.le	L_1605
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1605
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
L_1605
	subs	x0, x0, #16
	b.lt	L_1606
L_1607
	urshr	v11.8h, v8.8h, #8
	mov	v30.8b, v31.8b
	mov	v31.8b, v3.8b
	mov	v3.8b, v30.8b
	urshr	v12.8h, v9.8h, #8
	urshr	v13.8h, v10.8h, #8
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	raddhn	v28.8b, v11.8h, v8.8h
	add	x10, x10, #8
	tst	x9, #0xf
	b.eq	L_1608
	add	x10, x10, #8
	sub	x9, x9, #1
L_1608
	raddhn	v29.8b, v12.8h, v9.8h
	raddhn	v30.8b, v13.8h, v10.8h
	umull	v8.8h, v3.8b, v0.8b
	umull	v9.8h, v3.8b, v1.8b
	umull	v10.8h, v3.8b, v2.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	b.le	L_1609
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1609
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
L_1609
	subs	x0, x0, #8
	b.ge	L_1607
L_1606
	urshr	v11.8h, v8.8h, #8
	mov	v30.8b, v31.8b
	mov	v31.8b, v3.8b
	mov	v3.8b, v30.8b
	urshr	v12.8h, v9.8h, #8
	urshr	v13.8h, v10.8h, #8
	raddhn	v28.8b, v11.8h, v8.8h
	raddhn	v29.8b, v12.8h, v9.8h
	raddhn	v30.8b, v13.8h, v10.8h
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	tst	x0, #0x7
	b.eq	L_1610
	tst	x0, #0x4
	b.eq	L_1611
	ld1	{ v2.2s, v3.2s }, [x4], #16
	add	x10, x10, #4
L_1611
	tst	x0, #0x2
	b.eq	L_1612
	ld1	{ v1.2s }, [x4], #8
	add	x10, x10, #2
L_1612
	tst	x0, #0x1
	b.eq	L_1613
	ld1	{ v0.s }[1], [x4], #4
	add	x10, x10, #1
L_1613
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umull	v8.8h, v3.8b, v0.8b
	umull	v9.8h, v3.8b, v1.8b
	umull	v10.8h, v3.8b, v2.8b
	tst	x9, #0xf
	b.eq	L_1614
	add	x10, x10, #8
	sub	x9, x9, #1
L_1614
	cmp	x10, x14
	lsl	x15, x10, #2
	prfm	pldl1keep, [x11, x15]
	b.le	L_1615
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1615
	add	x11, x11, x5, lsl #2
	ldrsb	x15, [x11]
L_1615
	urshr	v11.8h, v8.8h, #8
	mov	v30.8b, v31.8b
	mov	v31.8b, v3.8b
	mov	v3.8b, v30.8b
	urshr	v12.8h, v9.8h, #8
	urshr	v13.8h, v10.8h, #8
	raddhn	v28.8b, v11.8h, v8.8h
	raddhn	v29.8b, v12.8h, v9.8h
	raddhn	v30.8b, v13.8h, v10.8h
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_1616
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1616
	tst	x0, #0x2
	b.eq	L_1617
	st1	{ v29.2s }, [x2], #8
L_1617
	tst	x0, #0x1
	b.eq	L_1618
	st1	{ v28.s }[1], [x2], #4
L_1618
L_1610
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1594
L_1619
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1593
	lsl	x15, x5, #2
	prfm	pldl1keep, [x4, x15]
	tst	x0, #0x8
	b.eq	L_1620
	ld4	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x4], #32
	umull	v8.8h, v3.8b, v0.8b
	umull	v9.8h, v3.8b, v1.8b
	umull	v10.8h, v3.8b, v2.8b
	urshr	v11.8h, v8.8h, #8
	mov	v30.8b, v31.8b
	mov	v31.8b, v3.8b
	mov	v3.8b, v30.8b
	urshr	v12.8h, v9.8h, #8
	urshr	v13.8h, v10.8h, #8
	raddhn	v28.8b, v11.8h, v8.8h
	raddhn	v29.8b, v12.8h, v9.8h
	raddhn	v30.8b, v13.8h, v10.8h
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
L_1620
	tst	x0, #0x7
	b.eq	L_1621
	tst	x0, #0x4
	b.eq	L_1622
	ld1	{ v2.2s, v3.2s }, [x4], #16
L_1622
	tst	x0, #0x2
	b.eq	L_1623
	ld1	{ v1.2s }, [x4], #8
L_1623
	tst	x0, #0x1
	b.eq	L_1624
	ld1	{ v0.s }[1], [x4], #4
L_1624
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x15
	umull	v8.8h, v3.8b, v0.8b
	umull	v9.8h, v3.8b, v1.8b
	umull	v10.8h, v3.8b, v2.8b
	urshr	v11.8h, v8.8h, #8
	mov	v30.8b, v31.8b
	mov	v31.8b, v3.8b
	mov	v3.8b, v30.8b
	urshr	v12.8h, v9.8h, #8
	urshr	v13.8h, v10.8h, #8
	raddhn	v28.8b, v11.8h, v8.8h
	raddhn	v29.8b, v12.8h, v9.8h
	raddhn	v30.8b, v13.8h, v10.8h
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_1625
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1625
	tst	x0, #0x2
	b.eq	L_1626
	st1	{ v29.2s }, [x2], #8
L_1626
	tst	x0, #0x1
	b.eq	L_1627
	st1	{ v28.s }[1], [x2], #4
L_1627
L_1621
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5, lsl #2
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0, lsl #2
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1593
L_1592
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_over_0565_8_0565_asm_neon
pixman_composite_over_0565_8_0565_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_1628
	cmp	x0, #16
	b.lt	L_1629
L_1630
	tst	x8, #0xf
	b.eq	L_1631
	tst	x8, #0x2
	b.eq	L_1632
	ld1	{ v8.h }[1], [x4], #2
	ld1	{ v15.b }[1], [x6], #1
	ld1	{ v10.h }[1], [x8], #2
	add	x10, x10, #1
	sub	x0, x0, #1
L_1632
	tst	x8, #0x4
	b.eq	L_1633
	ld1	{ v8.h }[2], [x4], #2
	ld1	{ v8.h }[3], [x4], #2
	ld1	{ v15.b }[2], [x6], #1
	ld1	{ v15.b }[3], [x6], #1
	ld1	{ v10.h }[2], [x8], #2
	ld1	{ v10.h }[3], [x8], #2
	add	x10, x10, #2
	sub	x0, x0, #2
L_1633
	tst	x8, #0x8
	b.eq	L_1634
	ld1	{ v9.4h }, [x4], #8
	ld1	{ v15.b }[4], [x6], #1
	ld1	{ v15.b }[5], [x6], #1
	ld1	{ v15.b }[6], [x6], #1
	ld1	{ v15.b }[7], [x6], #1
	ld1	{ v11.4h }, [x8], #8
	add	x10, x10, #4
	sub	x0, x0, #4
L_1634
	mov	v4.d[0], v8.d[0]
	mov	v4.d[1], v9.d[0]
	mov	v13.d[0], v10.d[0]
	mov	v13.d[1], v11.d[0]
	shrn	v2.8b, v4.8h, #8
	shrn	v1.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v2.8b, v2.8b, #5
	sri	v1.8b, v1.8b, #6
	shrn	v0.8b, v4.8h, #2
	shrn	v6.8b, v13.8h, #8
	shrn	v5.8b, v13.8h, #3
	sli	v13.8h, v13.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v13.8h, #2
	mvn	v7.8b, v15.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	umull	v11.8h, v7.8b, v4.8b
	umull	v12.8h, v7.8b, v5.8b
	umull	v13.8h, v7.8b, v6.8b
	urshr	v19.8h, v10.8h, #8
	urshr	v18.8h, v9.8h, #8
	urshr	v17.8h, v8.8h, #8
	raddhn	v2.8b, v10.8h, v19.8h
	raddhn	v1.8b, v9.8h, v18.8h
	raddhn	v0.8b, v8.8h, v17.8h
	tst	x9, #0xf
	b.eq	L_1635
	add	x10, x10, #8
	sub	x9, x9, #1
L_1635
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1636
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1636
	add	x11, x11, x5, lsl #1
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1636
	urshr	v17.8h, v11.8h, #8
	urshr	v18.8h, v12.8h, #8
	urshr	v19.8h, v13.8h, #8
	raddhn	v28.8b, v17.8h, v11.8h
	raddhn	v29.8b, v18.8h, v12.8h
	raddhn	v30.8b, v19.8h, v13.8h
	uqadd	v0.8b, v0.8b, v28.8b
	uqadd	v1.8b, v1.8b, v29.8b
	uqadd	v2.8b, v2.8b, v30.8b
	ushll	v30.8h, v1.8b, #7
	shl	v30.8h, v30.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v13.8h, v0.8b, #7
	shl	v13.8h, v13.8h, #1
	sri	v14.8h, v30.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x2, #0x2
	b.eq	L_1637
	st1	{ v28.h }[1], [x2], #2
L_1637
	tst	x2, #0x4
	b.eq	L_1638
	st1	{ v28.s }[1], [x2], #4
L_1638
	tst	x2, #0x8
	b.eq	L_1639
	st1	{ v29.4h }, [x2], #8
L_1639
L_1631
	ld1	{ v10.4h, v11.4h }, [x8], #16
	ld1	{ v8.4h, v9.4h }, [x4], #16
	ld1	{ v15.8b }, [x6], #8
	add	x10, x10, #8
	mov	v4.d[0], v8.d[0]
	mov	v4.d[1], v9.d[0]
	mov	v13.d[0], v10.d[0]
	mov	v13.d[1], v11.d[0]
	shrn	v2.8b, v4.8h, #8
	shrn	v1.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v2.8b, v2.8b, #5
	sri	v1.8b, v1.8b, #6
	shrn	v0.8b, v4.8h, #2
	shrn	v6.8b, v13.8h, #8
	shrn	v5.8b, v13.8h, #3
	sli	v13.8h, v13.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v13.8h, #2
	mvn	v7.8b, v15.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	umull	v11.8h, v7.8b, v4.8b
	umull	v12.8h, v7.8b, v5.8b
	umull	v13.8h, v7.8b, v6.8b
	urshr	v19.8h, v10.8h, #8
	urshr	v18.8h, v9.8h, #8
	urshr	v17.8h, v8.8h, #8
	raddhn	v2.8b, v10.8h, v19.8h
	raddhn	v1.8b, v9.8h, v18.8h
	raddhn	v0.8b, v8.8h, v17.8h
	tst	x9, #0xf
	b.eq	L_1640
	add	x10, x10, #8
	sub	x9, x9, #1
L_1640
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1641
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1641
	add	x11, x11, x5, lsl #1
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1641
	subs	x0, x0, #16
	b.lt	L_1642
L_1643
	ld1	{ v15.8b }, [x6], #8
	urshr	v17.8h, v11.8h, #8
	urshr	v18.8h, v12.8h, #8
	urshr	v19.8h, v13.8h, #8
	raddhn	v28.8b, v17.8h, v11.8h
	raddhn	v29.8b, v18.8h, v12.8h
	raddhn	v30.8b, v19.8h, v13.8h
	uqadd	v0.8b, v0.8b, v28.8b
	uqadd	v1.8b, v1.8b, v29.8b
	uqadd	v2.8b, v2.8b, v30.8b
	ushll	v30.8h, v1.8b, #7
	shl	v30.8h, v30.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v13.8h, v0.8b, #7
	shl	v13.8h, v13.8h, #1
	sri	v14.8h, v30.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	ld1	{ v8.4h, v9.4h }, [x4], #16
	ld1	{ v10.4h, v11.4h }, [x8], #16
	add	x10, x10, #8
	tst	x9, #0xf
	b.eq	L_1644
	add	x10, x10, #8
	sub	x9, x9, #1
L_1644
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1645
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1645
	add	x11, x11, x5, lsl #1
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1645
	mov	v4.d[0], v8.d[0]
	mov	v4.d[1], v9.d[0]
	mov	v13.d[0], v10.d[0]
	mov	v13.d[1], v11.d[0]
	shrn	v2.8b, v4.8h, #8
	shrn	v1.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v2.8b, v2.8b, #5
	sri	v1.8b, v1.8b, #6
	shrn	v0.8b, v4.8h, #2
	shrn	v6.8b, v13.8h, #8
	shrn	v5.8b, v13.8h, #3
	sli	v13.8h, v13.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v13.8h, #2
	mvn	v7.8b, v15.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	umull	v11.8h, v7.8b, v4.8b
	umull	v12.8h, v7.8b, v5.8b
	umull	v13.8h, v7.8b, v6.8b
	urshr	v19.8h, v10.8h, #8
	urshr	v18.8h, v9.8h, #8
	urshr	v17.8h, v8.8h, #8
	raddhn	v2.8b, v10.8h, v19.8h
	raddhn	v1.8b, v9.8h, v18.8h
	raddhn	v0.8b, v8.8h, v17.8h
	st1	{ v14.8h }, [x2], #16
	subs	x0, x0, #8
	b.ge	L_1643
L_1642
	urshr	v17.8h, v11.8h, #8
	urshr	v18.8h, v12.8h, #8
	urshr	v19.8h, v13.8h, #8
	raddhn	v28.8b, v17.8h, v11.8h
	raddhn	v29.8b, v18.8h, v12.8h
	raddhn	v30.8b, v19.8h, v13.8h
	uqadd	v0.8b, v0.8b, v28.8b
	uqadd	v1.8b, v1.8b, v29.8b
	uqadd	v2.8b, v2.8b, v30.8b
	ushll	v30.8h, v1.8b, #7
	shl	v30.8h, v30.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v13.8h, v0.8b, #7
	shl	v13.8h, v13.8h, #1
	sri	v14.8h, v30.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
	tst	x0, #0x7
	b.eq	L_1646
	tst	x0, #0x4
	b.eq	L_1647
	ld1	{ v9.4h }, [x4], #8
	ld1	{ v15.b }[4], [x6], #1
	ld1	{ v15.b }[5], [x6], #1
	ld1	{ v15.b }[6], [x6], #1
	ld1	{ v15.b }[7], [x6], #1
	ld1	{ v11.4h }, [x8], #8
	add	x10, x10, #4
L_1647
	tst	x0, #0x2
	b.eq	L_1648
	ld1	{ v8.h }[2], [x4], #2
	ld1	{ v8.h }[3], [x4], #2
	ld1	{ v15.b }[2], [x6], #1
	ld1	{ v15.b }[3], [x6], #1
	ld1	{ v10.h }[2], [x8], #2
	ld1	{ v10.h }[3], [x8], #2
	add	x10, x10, #2
L_1648
	tst	x0, #0x1
	b.eq	L_1649
	ld1	{ v8.h }[1], [x4], #2
	ld1	{ v15.b }[1], [x6], #1
	ld1	{ v10.h }[1], [x8], #2
	add	x10, x10, #1
L_1649
	mov	v4.d[0], v8.d[0]
	mov	v4.d[1], v9.d[0]
	mov	v13.d[0], v10.d[0]
	mov	v13.d[1], v11.d[0]
	shrn	v2.8b, v4.8h, #8
	shrn	v1.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v2.8b, v2.8b, #5
	sri	v1.8b, v1.8b, #6
	shrn	v0.8b, v4.8h, #2
	shrn	v6.8b, v13.8h, #8
	shrn	v5.8b, v13.8h, #3
	sli	v13.8h, v13.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v13.8h, #2
	mvn	v7.8b, v15.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	umull	v11.8h, v7.8b, v4.8b
	umull	v12.8h, v7.8b, v5.8b
	umull	v13.8h, v7.8b, v6.8b
	urshr	v19.8h, v10.8h, #8
	urshr	v18.8h, v9.8h, #8
	urshr	v17.8h, v8.8h, #8
	raddhn	v2.8b, v10.8h, v19.8h
	raddhn	v1.8b, v9.8h, v18.8h
	raddhn	v0.8b, v8.8h, v17.8h
	tst	x9, #0xf
	b.eq	L_1650
	add	x10, x10, #8
	sub	x9, x9, #1
L_1650
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1651
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1651
	add	x11, x11, x5, lsl #1
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1651
	urshr	v17.8h, v11.8h, #8
	urshr	v18.8h, v12.8h, #8
	urshr	v19.8h, v13.8h, #8
	raddhn	v28.8b, v17.8h, v11.8h
	raddhn	v29.8b, v18.8h, v12.8h
	raddhn	v30.8b, v19.8h, v13.8h
	uqadd	v0.8b, v0.8b, v28.8b
	uqadd	v1.8b, v1.8b, v29.8b
	uqadd	v2.8b, v2.8b, v30.8b
	ushll	v30.8h, v1.8b, #7
	shl	v30.8h, v30.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v13.8h, v0.8b, #7
	shl	v13.8h, v13.8h, #1
	sri	v14.8h, v30.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_1652
	st1	{ v29.4h }, [x2], #8
L_1652
	tst	x0, #0x2
	b.eq	L_1653
	st1	{ v28.s }[1], [x2], #4
L_1653
	tst	x0, #0x1
	b.eq	L_1654
	st1	{ v28.h }[1], [x2], #2
L_1654
L_1646
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x4, x4, x5, lsl #1
	add	x6, x6, x7
	sub	x2, x2, x0, lsl #1
	sub	x4, x4, x0, lsl #1
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1630
L_1655
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1629
	lsl	x15, x5, #1
	prfm	pldl1keep, [x4, x15]
	lsl	x15, x3, #1
	prfm	pldl1keep, [x8, x15]
	lsr	x15, x7, #0
	prfm	pldl1keep, [x6, x15]
	tst	x0, #0x8
	b.eq	L_1656
	ld1	{ v10.4h, v11.4h }, [x8], #16
	ld1	{ v8.4h, v9.4h }, [x4], #16
	ld1	{ v15.8b }, [x6], #8
	mov	v4.d[0], v8.d[0]
	mov	v4.d[1], v9.d[0]
	mov	v13.d[0], v10.d[0]
	mov	v13.d[1], v11.d[0]
	shrn	v2.8b, v4.8h, #8
	shrn	v1.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v2.8b, v2.8b, #5
	sri	v1.8b, v1.8b, #6
	shrn	v0.8b, v4.8h, #2
	shrn	v6.8b, v13.8h, #8
	shrn	v5.8b, v13.8h, #3
	sli	v13.8h, v13.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v13.8h, #2
	mvn	v7.8b, v15.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	umull	v11.8h, v7.8b, v4.8b
	umull	v12.8h, v7.8b, v5.8b
	umull	v13.8h, v7.8b, v6.8b
	urshr	v19.8h, v10.8h, #8
	urshr	v18.8h, v9.8h, #8
	urshr	v17.8h, v8.8h, #8
	raddhn	v2.8b, v10.8h, v19.8h
	raddhn	v1.8b, v9.8h, v18.8h
	raddhn	v0.8b, v8.8h, v17.8h
	urshr	v17.8h, v11.8h, #8
	urshr	v18.8h, v12.8h, #8
	urshr	v19.8h, v13.8h, #8
	raddhn	v28.8b, v17.8h, v11.8h
	raddhn	v29.8b, v18.8h, v12.8h
	raddhn	v30.8b, v19.8h, v13.8h
	uqadd	v0.8b, v0.8b, v28.8b
	uqadd	v1.8b, v1.8b, v29.8b
	uqadd	v2.8b, v2.8b, v30.8b
	ushll	v30.8h, v1.8b, #7
	shl	v30.8h, v30.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v13.8h, v0.8b, #7
	shl	v13.8h, v13.8h, #1
	sri	v14.8h, v30.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
L_1656
	tst	x0, #0x7
	b.eq	L_1657
	tst	x0, #0x4
	b.eq	L_1658
	ld1	{ v9.4h }, [x4], #8
	ld1	{ v15.b }[4], [x6], #1
	ld1	{ v15.b }[5], [x6], #1
	ld1	{ v15.b }[6], [x6], #1
	ld1	{ v15.b }[7], [x6], #1
	ld1	{ v11.4h }, [x8], #8
L_1658
	tst	x0, #0x2
	b.eq	L_1659
	ld1	{ v8.h }[2], [x4], #2
	ld1	{ v8.h }[3], [x4], #2
	ld1	{ v15.b }[2], [x6], #1
	ld1	{ v15.b }[3], [x6], #1
	ld1	{ v10.h }[2], [x8], #2
	ld1	{ v10.h }[3], [x8], #2
L_1659
	tst	x0, #0x1
	b.eq	L_1660
	ld1	{ v8.h }[1], [x4], #2
	ld1	{ v15.b }[1], [x6], #1
	ld1	{ v10.h }[1], [x8], #2
L_1660
	mov	v4.d[0], v8.d[0]
	mov	v4.d[1], v9.d[0]
	mov	v13.d[0], v10.d[0]
	mov	v13.d[1], v11.d[0]
	shrn	v2.8b, v4.8h, #8
	shrn	v1.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v2.8b, v2.8b, #5
	sri	v1.8b, v1.8b, #6
	shrn	v0.8b, v4.8h, #2
	shrn	v6.8b, v13.8h, #8
	shrn	v5.8b, v13.8h, #3
	sli	v13.8h, v13.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v13.8h, #2
	mvn	v7.8b, v15.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	umull	v11.8h, v7.8b, v4.8b
	umull	v12.8h, v7.8b, v5.8b
	umull	v13.8h, v7.8b, v6.8b
	urshr	v19.8h, v10.8h, #8
	urshr	v18.8h, v9.8h, #8
	urshr	v17.8h, v8.8h, #8
	raddhn	v2.8b, v10.8h, v19.8h
	raddhn	v1.8b, v9.8h, v18.8h
	raddhn	v0.8b, v8.8h, v17.8h
	urshr	v17.8h, v11.8h, #8
	urshr	v18.8h, v12.8h, #8
	urshr	v19.8h, v13.8h, #8
	raddhn	v28.8b, v17.8h, v11.8h
	raddhn	v29.8b, v18.8h, v12.8h
	raddhn	v30.8b, v19.8h, v13.8h
	uqadd	v0.8b, v0.8b, v28.8b
	uqadd	v1.8b, v1.8b, v29.8b
	uqadd	v2.8b, v2.8b, v30.8b
	ushll	v30.8h, v1.8b, #7
	shl	v30.8h, v30.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v13.8h, v0.8b, #7
	shl	v13.8h, v13.8h, #1
	sri	v14.8h, v30.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_1661
	st1	{ v29.4h }, [x2], #8
L_1661
	tst	x0, #0x2
	b.eq	L_1662
	st1	{ v28.h }[2], [x2], #2
	st1	{ v28.h }[3], [x2], #2
L_1662
	tst	x0, #0x1
	b.eq	L_1663
	st1	{ v28.h }[1], [x2], #2
L_1663
L_1657
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x4, x4, x5, lsl #1
	add	x6, x6, x7
	sub	x2, x2, x0, lsl #1
	sub	x4, x4, x0, lsl #1
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1629
L_1628
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_over_0565_n_0565_asm_neon
pixman_composite_over_0565_n_0565_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	mov	v15.s[0], w6
	dup	v15.8b, v15.b[3]
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_1664
	cmp	x0, #16
	b.lt	L_1665
L_1666
	tst	x8, #0xf
	b.eq	L_1667
	tst	x8, #0x2
	b.eq	L_1668
	ld1	{ v8.h }[1], [x4], #2
	ld1	{ v10.h }[1], [x8], #2
	add	x10, x10, #1
	sub	x0, x0, #1
L_1668
	tst	x8, #0x4
	b.eq	L_1669
	ld1	{ v8.h }[2], [x4], #2
	ld1	{ v8.h }[3], [x4], #2
	ld1	{ v10.h }[2], [x8], #2
	ld1	{ v10.h }[3], [x8], #2
	add	x10, x10, #2
	sub	x0, x0, #2
L_1669
	tst	x8, #0x8
	b.eq	L_1670
	ld1	{ v9.4h }, [x4], #8
	ld1	{ v11.4h }, [x8], #8
	add	x10, x10, #4
	sub	x0, x0, #4
L_1670
	mov	v4.d[0], v8.d[0]
	mov	v4.d[1], v9.d[0]
	mov	v13.d[0], v10.d[0]
	mov	v13.d[1], v11.d[0]
	shrn	v2.8b, v4.8h, #8
	shrn	v1.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v2.8b, v2.8b, #5
	sri	v1.8b, v1.8b, #6
	shrn	v0.8b, v4.8h, #2
	shrn	v6.8b, v13.8h, #8
	shrn	v5.8b, v13.8h, #3
	sli	v13.8h, v13.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v13.8h, #2
	mvn	v7.8b, v15.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	umull	v11.8h, v7.8b, v4.8b
	umull	v12.8h, v7.8b, v5.8b
	umull	v13.8h, v7.8b, v6.8b
	urshr	v19.8h, v10.8h, #8
	urshr	v18.8h, v9.8h, #8
	urshr	v17.8h, v8.8h, #8
	raddhn	v2.8b, v10.8h, v19.8h
	raddhn	v1.8b, v9.8h, v18.8h
	raddhn	v0.8b, v8.8h, v17.8h
	tst	x9, #0xf
	b.eq	L_1671
	add	x10, x10, #8
	sub	x9, x9, #1
L_1671
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	b.le	L_1672
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1672
	add	x11, x11, x5, lsl #1
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
L_1672
	urshr	v17.8h, v11.8h, #8
	urshr	v18.8h, v12.8h, #8
	urshr	v19.8h, v13.8h, #8
	raddhn	v28.8b, v17.8h, v11.8h
	raddhn	v29.8b, v18.8h, v12.8h
	raddhn	v30.8b, v19.8h, v13.8h
	uqadd	v0.8b, v0.8b, v28.8b
	uqadd	v1.8b, v1.8b, v29.8b
	uqadd	v2.8b, v2.8b, v30.8b
	ushll	v30.8h, v1.8b, #7
	shl	v30.8h, v30.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v13.8h, v0.8b, #7
	shl	v13.8h, v13.8h, #1
	sri	v14.8h, v30.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x2, #0x2
	b.eq	L_1673
	st1	{ v28.h }[1], [x2], #2
L_1673
	tst	x2, #0x4
	b.eq	L_1674
	st1	{ v28.s }[1], [x2], #4
L_1674
	tst	x2, #0x8
	b.eq	L_1675
	st1	{ v29.4h }, [x2], #8
L_1675
L_1667
	ld1	{ v10.4h, v11.4h }, [x8], #16
	ld1	{ v8.4h, v9.4h }, [x4], #16
	add	x10, x10, #8
	mov	v4.d[0], v8.d[0]
	mov	v4.d[1], v9.d[0]
	mov	v13.d[0], v10.d[0]
	mov	v13.d[1], v11.d[0]
	shrn	v2.8b, v4.8h, #8
	shrn	v1.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v2.8b, v2.8b, #5
	sri	v1.8b, v1.8b, #6
	shrn	v0.8b, v4.8h, #2
	shrn	v6.8b, v13.8h, #8
	shrn	v5.8b, v13.8h, #3
	sli	v13.8h, v13.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v13.8h, #2
	mvn	v7.8b, v15.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	umull	v11.8h, v7.8b, v4.8b
	umull	v12.8h, v7.8b, v5.8b
	umull	v13.8h, v7.8b, v6.8b
	urshr	v19.8h, v10.8h, #8
	urshr	v18.8h, v9.8h, #8
	urshr	v17.8h, v8.8h, #8
	raddhn	v2.8b, v10.8h, v19.8h
	raddhn	v1.8b, v9.8h, v18.8h
	raddhn	v0.8b, v8.8h, v17.8h
	tst	x9, #0xf
	b.eq	L_1676
	add	x10, x10, #8
	sub	x9, x9, #1
L_1676
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	b.le	L_1677
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1677
	add	x11, x11, x5, lsl #1
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
L_1677
	subs	x0, x0, #16
	b.lt	L_1678
L_1679
	urshr	v17.8h, v11.8h, #8
	urshr	v18.8h, v12.8h, #8
	urshr	v19.8h, v13.8h, #8
	raddhn	v28.8b, v17.8h, v11.8h
	raddhn	v29.8b, v18.8h, v12.8h
	raddhn	v30.8b, v19.8h, v13.8h
	uqadd	v0.8b, v0.8b, v28.8b
	uqadd	v1.8b, v1.8b, v29.8b
	uqadd	v2.8b, v2.8b, v30.8b
	ushll	v30.8h, v1.8b, #7
	shl	v30.8h, v30.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v13.8h, v0.8b, #7
	shl	v13.8h, v13.8h, #1
	sri	v14.8h, v30.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	ld1	{ v8.4h, v9.4h }, [x4], #16
	ld1	{ v10.4h, v11.4h }, [x8], #16
	add	x10, x10, #8
	tst	x9, #0xf
	b.eq	L_1680
	add	x10, x10, #8
	sub	x9, x9, #1
L_1680
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	b.le	L_1681
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1681
	add	x11, x11, x5, lsl #1
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
L_1681
	mov	v4.d[0], v8.d[0]
	mov	v4.d[1], v9.d[0]
	mov	v13.d[0], v10.d[0]
	mov	v13.d[1], v11.d[0]
	shrn	v2.8b, v4.8h, #8
	shrn	v1.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v2.8b, v2.8b, #5
	sri	v1.8b, v1.8b, #6
	shrn	v0.8b, v4.8h, #2
	shrn	v6.8b, v13.8h, #8
	shrn	v5.8b, v13.8h, #3
	sli	v13.8h, v13.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v13.8h, #2
	mvn	v7.8b, v15.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	umull	v11.8h, v7.8b, v4.8b
	umull	v12.8h, v7.8b, v5.8b
	umull	v13.8h, v7.8b, v6.8b
	urshr	v19.8h, v10.8h, #8
	urshr	v18.8h, v9.8h, #8
	urshr	v17.8h, v8.8h, #8
	raddhn	v2.8b, v10.8h, v19.8h
	raddhn	v1.8b, v9.8h, v18.8h
	raddhn	v0.8b, v8.8h, v17.8h
	st1	{ v14.8h }, [x2], #16
	subs	x0, x0, #8
	b.ge	L_1679
L_1678
	urshr	v17.8h, v11.8h, #8
	urshr	v18.8h, v12.8h, #8
	urshr	v19.8h, v13.8h, #8
	raddhn	v28.8b, v17.8h, v11.8h
	raddhn	v29.8b, v18.8h, v12.8h
	raddhn	v30.8b, v19.8h, v13.8h
	uqadd	v0.8b, v0.8b, v28.8b
	uqadd	v1.8b, v1.8b, v29.8b
	uqadd	v2.8b, v2.8b, v30.8b
	ushll	v30.8h, v1.8b, #7
	shl	v30.8h, v30.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v13.8h, v0.8b, #7
	shl	v13.8h, v13.8h, #1
	sri	v14.8h, v30.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
	tst	x0, #0x7
	b.eq	L_1682
	tst	x0, #0x4
	b.eq	L_1683
	ld1	{ v9.4h }, [x4], #8
	ld1	{ v11.4h }, [x8], #8
	add	x10, x10, #4
L_1683
	tst	x0, #0x2
	b.eq	L_1684
	ld1	{ v8.h }[2], [x4], #2
	ld1	{ v8.h }[3], [x4], #2
	ld1	{ v10.h }[2], [x8], #2
	ld1	{ v10.h }[3], [x8], #2
	add	x10, x10, #2
L_1684
	tst	x0, #0x1
	b.eq	L_1685
	ld1	{ v8.h }[1], [x4], #2
	ld1	{ v10.h }[1], [x8], #2
	add	x10, x10, #1
L_1685
	mov	v4.d[0], v8.d[0]
	mov	v4.d[1], v9.d[0]
	mov	v13.d[0], v10.d[0]
	mov	v13.d[1], v11.d[0]
	shrn	v2.8b, v4.8h, #8
	shrn	v1.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v2.8b, v2.8b, #5
	sri	v1.8b, v1.8b, #6
	shrn	v0.8b, v4.8h, #2
	shrn	v6.8b, v13.8h, #8
	shrn	v5.8b, v13.8h, #3
	sli	v13.8h, v13.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v13.8h, #2
	mvn	v7.8b, v15.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	umull	v11.8h, v7.8b, v4.8b
	umull	v12.8h, v7.8b, v5.8b
	umull	v13.8h, v7.8b, v6.8b
	urshr	v19.8h, v10.8h, #8
	urshr	v18.8h, v9.8h, #8
	urshr	v17.8h, v8.8h, #8
	raddhn	v2.8b, v10.8h, v19.8h
	raddhn	v1.8b, v9.8h, v18.8h
	raddhn	v0.8b, v8.8h, v17.8h
	tst	x9, #0xf
	b.eq	L_1686
	add	x10, x10, #8
	sub	x9, x9, #1
L_1686
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	b.le	L_1687
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1687
	add	x11, x11, x5, lsl #1
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
L_1687
	urshr	v17.8h, v11.8h, #8
	urshr	v18.8h, v12.8h, #8
	urshr	v19.8h, v13.8h, #8
	raddhn	v28.8b, v17.8h, v11.8h
	raddhn	v29.8b, v18.8h, v12.8h
	raddhn	v30.8b, v19.8h, v13.8h
	uqadd	v0.8b, v0.8b, v28.8b
	uqadd	v1.8b, v1.8b, v29.8b
	uqadd	v2.8b, v2.8b, v30.8b
	ushll	v30.8h, v1.8b, #7
	shl	v30.8h, v30.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v13.8h, v0.8b, #7
	shl	v13.8h, v13.8h, #1
	sri	v14.8h, v30.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_1688
	st1	{ v29.4h }, [x2], #8
L_1688
	tst	x0, #0x2
	b.eq	L_1689
	st1	{ v28.s }[1], [x2], #4
L_1689
	tst	x0, #0x1
	b.eq	L_1690
	st1	{ v28.h }[1], [x2], #2
L_1690
L_1682
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x4, x4, x5, lsl #1
	sub	x2, x2, x0, lsl #1
	sub	x4, x4, x0, lsl #1
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1666
L_1691
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1665
	lsl	x15, x5, #1
	prfm	pldl1keep, [x4, x15]
	lsl	x15, x3, #1
	prfm	pldl1keep, [x8, x15]
	tst	x0, #0x8
	b.eq	L_1692
	ld1	{ v10.4h, v11.4h }, [x8], #16
	ld1	{ v8.4h, v9.4h }, [x4], #16
	mov	v4.d[0], v8.d[0]
	mov	v4.d[1], v9.d[0]
	mov	v13.d[0], v10.d[0]
	mov	v13.d[1], v11.d[0]
	shrn	v2.8b, v4.8h, #8
	shrn	v1.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v2.8b, v2.8b, #5
	sri	v1.8b, v1.8b, #6
	shrn	v0.8b, v4.8h, #2
	shrn	v6.8b, v13.8h, #8
	shrn	v5.8b, v13.8h, #3
	sli	v13.8h, v13.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v13.8h, #2
	mvn	v7.8b, v15.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	umull	v11.8h, v7.8b, v4.8b
	umull	v12.8h, v7.8b, v5.8b
	umull	v13.8h, v7.8b, v6.8b
	urshr	v19.8h, v10.8h, #8
	urshr	v18.8h, v9.8h, #8
	urshr	v17.8h, v8.8h, #8
	raddhn	v2.8b, v10.8h, v19.8h
	raddhn	v1.8b, v9.8h, v18.8h
	raddhn	v0.8b, v8.8h, v17.8h
	urshr	v17.8h, v11.8h, #8
	urshr	v18.8h, v12.8h, #8
	urshr	v19.8h, v13.8h, #8
	raddhn	v28.8b, v17.8h, v11.8h
	raddhn	v29.8b, v18.8h, v12.8h
	raddhn	v30.8b, v19.8h, v13.8h
	uqadd	v0.8b, v0.8b, v28.8b
	uqadd	v1.8b, v1.8b, v29.8b
	uqadd	v2.8b, v2.8b, v30.8b
	ushll	v30.8h, v1.8b, #7
	shl	v30.8h, v30.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v13.8h, v0.8b, #7
	shl	v13.8h, v13.8h, #1
	sri	v14.8h, v30.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
L_1692
	tst	x0, #0x7
	b.eq	L_1693
	tst	x0, #0x4
	b.eq	L_1694
	ld1	{ v9.4h }, [x4], #8
	ld1	{ v11.4h }, [x8], #8
L_1694
	tst	x0, #0x2
	b.eq	L_1695
	ld1	{ v8.h }[2], [x4], #2
	ld1	{ v8.h }[3], [x4], #2
	ld1	{ v10.h }[2], [x8], #2
	ld1	{ v10.h }[3], [x8], #2
L_1695
	tst	x0, #0x1
	b.eq	L_1696
	ld1	{ v8.h }[1], [x4], #2
	ld1	{ v10.h }[1], [x8], #2
L_1696
	mov	v4.d[0], v8.d[0]
	mov	v4.d[1], v9.d[0]
	mov	v13.d[0], v10.d[0]
	mov	v13.d[1], v11.d[0]
	shrn	v2.8b, v4.8h, #8
	shrn	v1.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v2.8b, v2.8b, #5
	sri	v1.8b, v1.8b, #6
	shrn	v0.8b, v4.8h, #2
	shrn	v6.8b, v13.8h, #8
	shrn	v5.8b, v13.8h, #3
	sli	v13.8h, v13.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v13.8h, #2
	mvn	v7.8b, v15.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	umull	v11.8h, v7.8b, v4.8b
	umull	v12.8h, v7.8b, v5.8b
	umull	v13.8h, v7.8b, v6.8b
	urshr	v19.8h, v10.8h, #8
	urshr	v18.8h, v9.8h, #8
	urshr	v17.8h, v8.8h, #8
	raddhn	v2.8b, v10.8h, v19.8h
	raddhn	v1.8b, v9.8h, v18.8h
	raddhn	v0.8b, v8.8h, v17.8h
	urshr	v17.8h, v11.8h, #8
	urshr	v18.8h, v12.8h, #8
	urshr	v19.8h, v13.8h, #8
	raddhn	v28.8b, v17.8h, v11.8h
	raddhn	v29.8b, v18.8h, v12.8h
	raddhn	v30.8b, v19.8h, v13.8h
	uqadd	v0.8b, v0.8b, v28.8b
	uqadd	v1.8b, v1.8b, v29.8b
	uqadd	v2.8b, v2.8b, v30.8b
	ushll	v30.8h, v1.8b, #7
	shl	v30.8h, v30.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v13.8h, v0.8b, #7
	shl	v13.8h, v13.8h, #1
	sri	v14.8h, v30.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_1697
	st1	{ v29.4h }, [x2], #8
L_1697
	tst	x0, #0x2
	b.eq	L_1698
	st1	{ v28.h }[2], [x2], #2
	st1	{ v28.h }[3], [x2], #2
L_1698
	tst	x0, #0x1
	b.eq	L_1699
	st1	{ v28.h }[1], [x2], #2
L_1699
L_1693
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x4, x4, x5, lsl #1
	sub	x2, x2, x0, lsl #1
	sub	x4, x4, x0, lsl #1
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1665
L_1664
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_add_0565_8_0565_asm_neon
pixman_composite_add_0565_8_0565_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_1700
	cmp	x0, #16
	b.lt	L_1701
L_1702
	tst	x8, #0xf
	b.eq	L_1703
	tst	x8, #0x2
	b.eq	L_1704
	ld1	{ v8.h }[1], [x4], #2
	ld1	{ v15.b }[1], [x6], #1
	ld1	{ v10.h }[1], [x8], #2
	add	x10, x10, #1
	sub	x0, x0, #1
L_1704
	tst	x8, #0x4
	b.eq	L_1705
	ld1	{ v8.h }[2], [x4], #2
	ld1	{ v8.h }[3], [x4], #2
	ld1	{ v15.b }[2], [x6], #1
	ld1	{ v15.b }[3], [x6], #1
	ld1	{ v10.h }[2], [x8], #2
	ld1	{ v10.h }[3], [x8], #2
	add	x10, x10, #2
	sub	x0, x0, #2
L_1705
	tst	x8, #0x8
	b.eq	L_1706
	ld1	{ v9.4h }, [x4], #8
	ld1	{ v15.b }[4], [x6], #1
	ld1	{ v15.b }[5], [x6], #1
	ld1	{ v15.b }[6], [x6], #1
	ld1	{ v15.b }[7], [x6], #1
	ld1	{ v11.4h }, [x8], #8
	add	x10, x10, #4
	sub	x0, x0, #4
L_1706
	mov	v4.d[0], v8.d[0]
	mov	v4.d[1], v9.d[0]
	mov	v13.d[0], v10.d[0]
	mov	v13.d[1], v11.d[0]
	shrn	v2.8b, v4.8h, #8
	shrn	v1.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v2.8b, v2.8b, #5
	sri	v1.8b, v1.8b, #6
	shrn	v0.8b, v4.8h, #2
	shrn	v6.8b, v13.8h, #8
	shrn	v5.8b, v13.8h, #3
	sli	v13.8h, v13.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v13.8h, #2
	umull	v9.8h, v15.8b, v2.8b
	umull	v8.8h, v15.8b, v1.8b
	umull	v7.8h, v15.8b, v0.8b
	urshr	v12.8h, v9.8h, #8
	urshr	v11.8h, v8.8h, #8
	urshr	v10.8h, v7.8h, #8
	raddhn	v2.8b, v9.8h, v12.8h
	raddhn	v1.8b, v8.8h, v11.8h
	raddhn	v0.8b, v7.8h, v10.8h
	tst	x9, #0xf
	b.eq	L_1707
	add	x10, x10, #8
	sub	x9, x9, #1
L_1707
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1708
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1708
	add	x11, x11, x5, lsl #1
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1708
	uqadd	v0.8b, v0.8b, v4.8b
	uqadd	v1.8b, v1.8b, v5.8b
	uqadd	v2.8b, v2.8b, v6.8b
	ushll	v30.8h, v1.8b, #7
	shl	v30.8h, v30.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v13.8h, v0.8b, #7
	shl	v13.8h, v13.8h, #1
	sri	v14.8h, v30.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x2, #0x2
	b.eq	L_1709
	st1	{ v28.h }[1], [x2], #2
L_1709
	tst	x2, #0x4
	b.eq	L_1710
	st1	{ v28.s }[1], [x2], #4
L_1710
	tst	x2, #0x8
	b.eq	L_1711
	st1	{ v29.4h }, [x2], #8
L_1711
L_1703
	ld1	{ v10.4h, v11.4h }, [x8], #16
	ld1	{ v8.4h, v9.4h }, [x4], #16
	ld1	{ v15.8b }, [x6], #8
	add	x10, x10, #8
	mov	v4.d[0], v8.d[0]
	mov	v4.d[1], v9.d[0]
	mov	v13.d[0], v10.d[0]
	mov	v13.d[1], v11.d[0]
	shrn	v2.8b, v4.8h, #8
	shrn	v1.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v2.8b, v2.8b, #5
	sri	v1.8b, v1.8b, #6
	shrn	v0.8b, v4.8h, #2
	shrn	v6.8b, v13.8h, #8
	shrn	v5.8b, v13.8h, #3
	sli	v13.8h, v13.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v13.8h, #2
	umull	v9.8h, v15.8b, v2.8b
	umull	v8.8h, v15.8b, v1.8b
	umull	v7.8h, v15.8b, v0.8b
	urshr	v12.8h, v9.8h, #8
	urshr	v11.8h, v8.8h, #8
	urshr	v10.8h, v7.8h, #8
	raddhn	v2.8b, v9.8h, v12.8h
	raddhn	v1.8b, v8.8h, v11.8h
	raddhn	v0.8b, v7.8h, v10.8h
	tst	x9, #0xf
	b.eq	L_1712
	add	x10, x10, #8
	sub	x9, x9, #1
L_1712
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1713
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1713
	add	x11, x11, x5, lsl #1
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1713
	subs	x0, x0, #16
	b.lt	L_1714
L_1715
	ld1	{ v15.8b }, [x6], #8
	uqadd	v0.8b, v0.8b, v4.8b
	uqadd	v1.8b, v1.8b, v5.8b
	uqadd	v2.8b, v2.8b, v6.8b
	ushll	v30.8h, v1.8b, #7
	shl	v30.8h, v30.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v13.8h, v0.8b, #7
	shl	v13.8h, v13.8h, #1
	sri	v14.8h, v30.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	ld1	{ v8.4h, v9.4h }, [x4], #16
	ld1	{ v10.4h, v11.4h }, [x8], #16
	add	x10, x10, #8
	tst	x9, #0xf
	b.eq	L_1716
	add	x10, x10, #8
	sub	x9, x9, #1
L_1716
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1717
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1717
	add	x11, x11, x5, lsl #1
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1717
	mov	v4.d[0], v8.d[0]
	mov	v4.d[1], v9.d[0]
	mov	v13.d[0], v10.d[0]
	mov	v13.d[1], v11.d[0]
	shrn	v2.8b, v4.8h, #8
	shrn	v1.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v2.8b, v2.8b, #5
	sri	v1.8b, v1.8b, #6
	shrn	v0.8b, v4.8h, #2
	shrn	v6.8b, v13.8h, #8
	shrn	v5.8b, v13.8h, #3
	sli	v13.8h, v13.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v13.8h, #2
	umull	v9.8h, v15.8b, v2.8b
	umull	v8.8h, v15.8b, v1.8b
	umull	v7.8h, v15.8b, v0.8b
	urshr	v12.8h, v9.8h, #8
	urshr	v11.8h, v8.8h, #8
	urshr	v10.8h, v7.8h, #8
	raddhn	v2.8b, v9.8h, v12.8h
	raddhn	v1.8b, v8.8h, v11.8h
	raddhn	v0.8b, v7.8h, v10.8h
	st1	{ v14.8h }, [x2], #16
	subs	x0, x0, #8
	b.ge	L_1715
L_1714
	uqadd	v0.8b, v0.8b, v4.8b
	uqadd	v1.8b, v1.8b, v5.8b
	uqadd	v2.8b, v2.8b, v6.8b
	ushll	v30.8h, v1.8b, #7
	shl	v30.8h, v30.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v13.8h, v0.8b, #7
	shl	v13.8h, v13.8h, #1
	sri	v14.8h, v30.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
	tst	x0, #0x7
	b.eq	L_1718
	tst	x0, #0x4
	b.eq	L_1719
	ld1	{ v9.4h }, [x4], #8
	ld1	{ v15.b }[4], [x6], #1
	ld1	{ v15.b }[5], [x6], #1
	ld1	{ v15.b }[6], [x6], #1
	ld1	{ v15.b }[7], [x6], #1
	ld1	{ v11.4h }, [x8], #8
	add	x10, x10, #4
L_1719
	tst	x0, #0x2
	b.eq	L_1720
	ld1	{ v8.h }[2], [x4], #2
	ld1	{ v8.h }[3], [x4], #2
	ld1	{ v15.b }[2], [x6], #1
	ld1	{ v15.b }[3], [x6], #1
	ld1	{ v10.h }[2], [x8], #2
	ld1	{ v10.h }[3], [x8], #2
	add	x10, x10, #2
L_1720
	tst	x0, #0x1
	b.eq	L_1721
	ld1	{ v8.h }[1], [x4], #2
	ld1	{ v15.b }[1], [x6], #1
	ld1	{ v10.h }[1], [x8], #2
	add	x10, x10, #1
L_1721
	mov	v4.d[0], v8.d[0]
	mov	v4.d[1], v9.d[0]
	mov	v13.d[0], v10.d[0]
	mov	v13.d[1], v11.d[0]
	shrn	v2.8b, v4.8h, #8
	shrn	v1.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v2.8b, v2.8b, #5
	sri	v1.8b, v1.8b, #6
	shrn	v0.8b, v4.8h, #2
	shrn	v6.8b, v13.8h, #8
	shrn	v5.8b, v13.8h, #3
	sli	v13.8h, v13.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v13.8h, #2
	umull	v9.8h, v15.8b, v2.8b
	umull	v8.8h, v15.8b, v1.8b
	umull	v7.8h, v15.8b, v0.8b
	urshr	v12.8h, v9.8h, #8
	urshr	v11.8h, v8.8h, #8
	urshr	v10.8h, v7.8h, #8
	raddhn	v2.8b, v9.8h, v12.8h
	raddhn	v1.8b, v8.8h, v11.8h
	raddhn	v0.8b, v7.8h, v10.8h
	tst	x9, #0xf
	b.eq	L_1722
	add	x10, x10, #8
	sub	x9, x9, #1
L_1722
	cmp	x10, x14
	lsl	x15, x10, #1
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	lsr	x15, x10, #0
	prfm	pldl1keep, [x13, x15]
	b.le	L_1723
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1723
	add	x11, x11, x5, lsl #1
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
	add	x13, x13, x7
	ldrsb	x15, [x13]
L_1723
	uqadd	v0.8b, v0.8b, v4.8b
	uqadd	v1.8b, v1.8b, v5.8b
	uqadd	v2.8b, v2.8b, v6.8b
	ushll	v30.8h, v1.8b, #7
	shl	v30.8h, v30.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v13.8h, v0.8b, #7
	shl	v13.8h, v13.8h, #1
	sri	v14.8h, v30.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_1724
	st1	{ v29.4h }, [x2], #8
L_1724
	tst	x0, #0x2
	b.eq	L_1725
	st1	{ v28.s }[1], [x2], #4
L_1725
	tst	x0, #0x1
	b.eq	L_1726
	st1	{ v28.h }[1], [x2], #2
L_1726
L_1718
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x4, x4, x5, lsl #1
	add	x6, x6, x7
	sub	x2, x2, x0, lsl #1
	sub	x4, x4, x0, lsl #1
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1702
L_1727
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1701
	lsl	x15, x5, #1
	prfm	pldl1keep, [x4, x15]
	lsl	x15, x3, #1
	prfm	pldl1keep, [x8, x15]
	lsr	x15, x7, #0
	prfm	pldl1keep, [x6, x15]
	tst	x0, #0x8
	b.eq	L_1728
	ld1	{ v10.4h, v11.4h }, [x8], #16
	ld1	{ v8.4h, v9.4h }, [x4], #16
	ld1	{ v15.8b }, [x6], #8
	mov	v4.d[0], v8.d[0]
	mov	v4.d[1], v9.d[0]
	mov	v13.d[0], v10.d[0]
	mov	v13.d[1], v11.d[0]
	shrn	v2.8b, v4.8h, #8
	shrn	v1.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v2.8b, v2.8b, #5
	sri	v1.8b, v1.8b, #6
	shrn	v0.8b, v4.8h, #2
	shrn	v6.8b, v13.8h, #8
	shrn	v5.8b, v13.8h, #3
	sli	v13.8h, v13.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v13.8h, #2
	umull	v9.8h, v15.8b, v2.8b
	umull	v8.8h, v15.8b, v1.8b
	umull	v7.8h, v15.8b, v0.8b
	urshr	v12.8h, v9.8h, #8
	urshr	v11.8h, v8.8h, #8
	urshr	v10.8h, v7.8h, #8
	raddhn	v2.8b, v9.8h, v12.8h
	raddhn	v1.8b, v8.8h, v11.8h
	raddhn	v0.8b, v7.8h, v10.8h
	uqadd	v0.8b, v0.8b, v4.8b
	uqadd	v1.8b, v1.8b, v5.8b
	uqadd	v2.8b, v2.8b, v6.8b
	ushll	v30.8h, v1.8b, #7
	shl	v30.8h, v30.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v13.8h, v0.8b, #7
	shl	v13.8h, v13.8h, #1
	sri	v14.8h, v30.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
L_1728
	tst	x0, #0x7
	b.eq	L_1729
	tst	x0, #0x4
	b.eq	L_1730
	ld1	{ v9.4h }, [x4], #8
	ld1	{ v15.b }[4], [x6], #1
	ld1	{ v15.b }[5], [x6], #1
	ld1	{ v15.b }[6], [x6], #1
	ld1	{ v15.b }[7], [x6], #1
	ld1	{ v11.4h }, [x8], #8
L_1730
	tst	x0, #0x2
	b.eq	L_1731
	ld1	{ v8.h }[2], [x4], #2
	ld1	{ v8.h }[3], [x4], #2
	ld1	{ v15.b }[2], [x6], #1
	ld1	{ v15.b }[3], [x6], #1
	ld1	{ v10.h }[2], [x8], #2
	ld1	{ v10.h }[3], [x8], #2
L_1731
	tst	x0, #0x1
	b.eq	L_1732
	ld1	{ v8.h }[1], [x4], #2
	ld1	{ v15.b }[1], [x6], #1
	ld1	{ v10.h }[1], [x8], #2
L_1732
	mov	v4.d[0], v8.d[0]
	mov	v4.d[1], v9.d[0]
	mov	v13.d[0], v10.d[0]
	mov	v13.d[1], v11.d[0]
	shrn	v2.8b, v4.8h, #8
	shrn	v1.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v2.8b, v2.8b, #5
	sri	v1.8b, v1.8b, #6
	shrn	v0.8b, v4.8h, #2
	shrn	v6.8b, v13.8h, #8
	shrn	v5.8b, v13.8h, #3
	sli	v13.8h, v13.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v13.8h, #2
	umull	v9.8h, v15.8b, v2.8b
	umull	v8.8h, v15.8b, v1.8b
	umull	v7.8h, v15.8b, v0.8b
	urshr	v12.8h, v9.8h, #8
	urshr	v11.8h, v8.8h, #8
	urshr	v10.8h, v7.8h, #8
	raddhn	v2.8b, v9.8h, v12.8h
	raddhn	v1.8b, v8.8h, v11.8h
	raddhn	v0.8b, v7.8h, v10.8h
	uqadd	v0.8b, v0.8b, v4.8b
	uqadd	v1.8b, v1.8b, v5.8b
	uqadd	v2.8b, v2.8b, v6.8b
	ushll	v30.8h, v1.8b, #7
	shl	v30.8h, v30.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v13.8h, v0.8b, #7
	shl	v13.8h, v13.8h, #1
	sri	v14.8h, v30.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_1733
	st1	{ v29.4h }, [x2], #8
L_1733
	tst	x0, #0x2
	b.eq	L_1734
	st1	{ v28.h }[2], [x2], #2
	st1	{ v28.h }[3], [x2], #2
L_1734
	tst	x0, #0x1
	b.eq	L_1735
	st1	{ v28.h }[1], [x2], #2
L_1735
L_1729
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x4, x4, x5, lsl #1
	add	x6, x6, x7
	sub	x2, x2, x0, lsl #1
	sub	x4, x4, x0, lsl #1
	sub	x6, x6, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1701
L_1700
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_out_reverse_8_0565_asm_neon
pixman_composite_out_reverse_8_0565_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_1736
	cmp	x0, #16
	b.lt	L_1737
L_1738
	tst	x8, #0xf
	b.eq	L_1739
	tst	x8, #0x2
	b.eq	L_1740
	ld1	{ v15.b }[1], [x4], #1
	ld1	{ v10.h }[1], [x8], #2
	add	x10, x10, #1
	sub	x0, x0, #1
L_1740
	tst	x8, #0x4
	b.eq	L_1741
	ld1	{ v15.b }[2], [x4], #1
	ld1	{ v15.b }[3], [x4], #1
	ld1	{ v10.h }[2], [x8], #2
	ld1	{ v10.h }[3], [x8], #2
	add	x10, x10, #2
	sub	x0, x0, #2
L_1741
	tst	x8, #0x8
	b.eq	L_1742
	ld1	{ v15.b }[4], [x4], #1
	ld1	{ v15.b }[5], [x4], #1
	ld1	{ v15.b }[6], [x4], #1
	ld1	{ v15.b }[7], [x4], #1
	ld1	{ v11.4h }, [x8], #8
	add	x10, x10, #4
	sub	x0, x0, #4
L_1742
	mov	v12.d[0], v10.d[0]
	mov	v12.d[1], v11.d[0]
	shrn	v6.8b, v12.8h, #8
	shrn	v5.8b, v12.8h, #3
	sli	v12.8h, v12.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v12.8h, #2
	mvn	v24.8b, v15.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	tst	x9, #0xf
	b.eq	L_1743
	add	x10, x10, #8
	sub	x9, x9, #1
L_1743
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	b.le	L_1744
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1744
	add	x11, x11, x5
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
L_1744
	urshr	v11.8h, v8.8h, #8
	urshr	v12.8h, v9.8h, #8
	urshr	v13.8h, v10.8h, #8
	raddhn	v0.8b, v11.8h, v8.8h
	raddhn	v1.8b, v12.8h, v9.8h
	raddhn	v2.8b, v13.8h, v10.8h
	ushll	v12.8h, v1.8b, #7
	shl	v12.8h, v12.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v3.8h, v0.8b, #7
	shl	v3.8h, v3.8h, #1
	sri	v14.8h, v12.8h, #5
	sri	v14.8h, v3.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x2, #0x2
	b.eq	L_1745
	st1	{ v28.h }[1], [x2], #2
L_1745
	tst	x2, #0x4
	b.eq	L_1746
	st1	{ v28.s }[1], [x2], #4
L_1746
	tst	x2, #0x8
	b.eq	L_1747
	st1	{ v29.4h }, [x2], #8
L_1747
L_1739
	ld1	{ v10.4h, v11.4h }, [x8], #16
	ld1	{ v15.8b }, [x4], #8
	add	x10, x10, #8
	mov	v12.d[0], v10.d[0]
	mov	v12.d[1], v11.d[0]
	shrn	v6.8b, v12.8h, #8
	shrn	v5.8b, v12.8h, #3
	sli	v12.8h, v12.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v12.8h, #2
	mvn	v24.8b, v15.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	tst	x9, #0xf
	b.eq	L_1748
	add	x10, x10, #8
	sub	x9, x9, #1
L_1748
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	b.le	L_1749
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1749
	add	x11, x11, x5
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
L_1749
	subs	x0, x0, #16
	b.lt	L_1750
L_1751
	ld1	{ v15.8b }, [x4], #8
	urshr	v11.8h, v8.8h, #8
	urshr	v12.8h, v9.8h, #8
	urshr	v13.8h, v10.8h, #8
	raddhn	v0.8b, v11.8h, v8.8h
	raddhn	v1.8b, v12.8h, v9.8h
	raddhn	v2.8b, v13.8h, v10.8h
	ushll	v12.8h, v1.8b, #7
	shl	v12.8h, v12.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v3.8h, v0.8b, #7
	shl	v3.8h, v3.8h, #1
	sri	v14.8h, v12.8h, #5
	sri	v14.8h, v3.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	ld1	{ v10.4h, v11.4h }, [x8], #16
	add	x10, x10, #8
	tst	x9, #0xf
	b.eq	L_1752
	add	x10, x10, #8
	sub	x9, x9, #1
L_1752
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	b.le	L_1753
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1753
	add	x11, x11, x5
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
L_1753
	mov	v12.d[0], v10.d[0]
	mov	v12.d[1], v11.d[0]
	shrn	v6.8b, v12.8h, #8
	shrn	v5.8b, v12.8h, #3
	sli	v12.8h, v12.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v12.8h, #2
	mvn	v24.8b, v15.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	st1	{ v14.8h }, [x2], #16
	subs	x0, x0, #8
	b.ge	L_1751
L_1750
	urshr	v11.8h, v8.8h, #8
	urshr	v12.8h, v9.8h, #8
	urshr	v13.8h, v10.8h, #8
	raddhn	v0.8b, v11.8h, v8.8h
	raddhn	v1.8b, v12.8h, v9.8h
	raddhn	v2.8b, v13.8h, v10.8h
	ushll	v12.8h, v1.8b, #7
	shl	v12.8h, v12.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v3.8h, v0.8b, #7
	shl	v3.8h, v3.8h, #1
	sri	v14.8h, v12.8h, #5
	sri	v14.8h, v3.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
	tst	x0, #0x7
	b.eq	L_1754
	tst	x0, #0x4
	b.eq	L_1755
	ld1	{ v15.b }[4], [x4], #1
	ld1	{ v15.b }[5], [x4], #1
	ld1	{ v15.b }[6], [x4], #1
	ld1	{ v15.b }[7], [x4], #1
	ld1	{ v11.4h }, [x8], #8
	add	x10, x10, #4
L_1755
	tst	x0, #0x2
	b.eq	L_1756
	ld1	{ v15.b }[2], [x4], #1
	ld1	{ v15.b }[3], [x4], #1
	ld1	{ v10.h }[2], [x8], #2
	ld1	{ v10.h }[3], [x8], #2
	add	x10, x10, #2
L_1756
	tst	x0, #0x1
	b.eq	L_1757
	ld1	{ v15.b }[1], [x4], #1
	ld1	{ v10.h }[1], [x8], #2
	add	x10, x10, #1
L_1757
	mov	v12.d[0], v10.d[0]
	mov	v12.d[1], v11.d[0]
	shrn	v6.8b, v12.8h, #8
	shrn	v5.8b, v12.8h, #3
	sli	v12.8h, v12.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v12.8h, #2
	mvn	v24.8b, v15.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	tst	x9, #0xf
	b.eq	L_1758
	add	x10, x10, #8
	sub	x9, x9, #1
L_1758
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #1
	prfm	pldl1keep, [x12, x15]
	b.le	L_1759
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1759
	add	x11, x11, x5
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #1
	ldrsb	x15, [x12]
L_1759
	urshr	v11.8h, v8.8h, #8
	urshr	v12.8h, v9.8h, #8
	urshr	v13.8h, v10.8h, #8
	raddhn	v0.8b, v11.8h, v8.8h
	raddhn	v1.8b, v12.8h, v9.8h
	raddhn	v2.8b, v13.8h, v10.8h
	ushll	v12.8h, v1.8b, #7
	shl	v12.8h, v12.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v3.8h, v0.8b, #7
	shl	v3.8h, v3.8h, #1
	sri	v14.8h, v12.8h, #5
	sri	v14.8h, v3.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_1760
	st1	{ v29.4h }, [x2], #8
L_1760
	tst	x0, #0x2
	b.eq	L_1761
	st1	{ v28.s }[1], [x2], #4
L_1761
	tst	x0, #0x1
	b.eq	L_1762
	st1	{ v28.h }[1], [x2], #2
L_1762
L_1754
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x4, x4, x5
	sub	x2, x2, x0, lsl #1
	sub	x4, x4, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1738
L_1763
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1737
	lsr	x15, x5, #0
	prfm	pldl1keep, [x4, x15]
	lsl	x15, x3, #1
	prfm	pldl1keep, [x8, x15]
	tst	x0, #0x8
	b.eq	L_1764
	ld1	{ v10.4h, v11.4h }, [x8], #16
	ld1	{ v15.8b }, [x4], #8
	mov	v12.d[0], v10.d[0]
	mov	v12.d[1], v11.d[0]
	shrn	v6.8b, v12.8h, #8
	shrn	v5.8b, v12.8h, #3
	sli	v12.8h, v12.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v12.8h, #2
	mvn	v24.8b, v15.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	urshr	v11.8h, v8.8h, #8
	urshr	v12.8h, v9.8h, #8
	urshr	v13.8h, v10.8h, #8
	raddhn	v0.8b, v11.8h, v8.8h
	raddhn	v1.8b, v12.8h, v9.8h
	raddhn	v2.8b, v13.8h, v10.8h
	ushll	v12.8h, v1.8b, #7
	shl	v12.8h, v12.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v3.8h, v0.8b, #7
	shl	v3.8h, v3.8h, #1
	sri	v14.8h, v12.8h, #5
	sri	v14.8h, v3.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x2], #16
L_1764
	tst	x0, #0x7
	b.eq	L_1765
	tst	x0, #0x4
	b.eq	L_1766
	ld1	{ v15.b }[4], [x4], #1
	ld1	{ v15.b }[5], [x4], #1
	ld1	{ v15.b }[6], [x4], #1
	ld1	{ v15.b }[7], [x4], #1
	ld1	{ v11.4h }, [x8], #8
L_1766
	tst	x0, #0x2
	b.eq	L_1767
	ld1	{ v15.b }[2], [x4], #1
	ld1	{ v15.b }[3], [x4], #1
	ld1	{ v10.h }[2], [x8], #2
	ld1	{ v10.h }[3], [x8], #2
L_1767
	tst	x0, #0x1
	b.eq	L_1768
	ld1	{ v15.b }[1], [x4], #1
	ld1	{ v10.h }[1], [x8], #2
L_1768
	mov	v12.d[0], v10.d[0]
	mov	v12.d[1], v11.d[0]
	shrn	v6.8b, v12.8h, #8
	shrn	v5.8b, v12.8h, #3
	sli	v12.8h, v12.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v12.8h, #2
	mvn	v24.8b, v15.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	urshr	v11.8h, v8.8h, #8
	urshr	v12.8h, v9.8h, #8
	urshr	v13.8h, v10.8h, #8
	raddhn	v0.8b, v11.8h, v8.8h
	raddhn	v1.8b, v12.8h, v9.8h
	raddhn	v2.8b, v13.8h, v10.8h
	ushll	v12.8h, v1.8b, #7
	shl	v12.8h, v12.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v3.8h, v0.8b, #7
	shl	v3.8h, v3.8h, #1
	sri	v14.8h, v12.8h, #5
	sri	v14.8h, v3.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_1769
	st1	{ v29.4h }, [x2], #8
L_1769
	tst	x0, #0x2
	b.eq	L_1770
	st1	{ v28.h }[2], [x2], #2
	st1	{ v28.h }[3], [x2], #2
L_1770
	tst	x0, #0x1
	b.eq	L_1771
	st1	{ v28.h }[1], [x2], #2
L_1771
L_1765
	mov	x0, x14
	add	x2, x2, x3, lsl #1
	add	x4, x4, x5
	sub	x2, x2, x0, lsl #1
	sub	x4, x4, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1737
L_1736
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_composite_out_reverse_8_8888_asm_neon
pixman_composite_out_reverse_8_8888_asm_neon
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #232
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	stp	x14, x15, [x29, #-128]
	stp	x16, x17, [x29, #-144]
	stp	x18, x19, [x29, #-160]
	stp	x20, x21, [x29, #-176]
	stp	x22, x23, [x29, #-192]
	stp	x24, x25, [x29, #-208]
	stp	x26, x27, [x29, #-224]
	stur	x28, [x29, #-232]
	sxtw	x0, w0
	sxtw	x1, w1
	sxtw	x3, w3
	sxtw	x5, w5
	sxtw	x7, w7
	mov	x10, #0
	mov	x8, x2
	mov	x11, x4
	mov	x12, x8
	mov	x13, x6
	lsl	x9, x1, #4
	sub	x9, x9, #11
	subs	x1, x1, #1
	mov	x14, x0
	b.lt	L_1772
	cmp	x0, #16
	b.lt	L_1773
L_1774
	tst	x8, #0xf
	b.eq	L_1775
	tst	x8, #0x4
	b.eq	L_1776
	ld1	{ v0.b }[1], [x4], #1
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
	sub	x0, x0, #1
L_1776
	tst	x8, #0x8
	b.eq	L_1777
	ld1	{ v0.b }[2], [x4], #1
	ld1	{ v0.b }[3], [x4], #1
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
	sub	x0, x0, #2
L_1777
	ld1	{ v0.b }[4], [x4], #1
	ld1	{ v0.b }[5], [x4], #1
	ld1	{ v0.b }[6], [x4], #1
	ld1	{ v0.b }[7], [x4], #1
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
	sub	x0, x0, #4
L_1778
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	mvn	v1.8b, v0.8b
	umull	v8.8h, v1.8b, v4.8b
	umull	v9.8h, v1.8b, v5.8b
	umull	v10.8h, v1.8b, v6.8b
	umull	v11.8h, v1.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_1779
	add	x10, x10, #8
	sub	x9, x9, #1
L_1779
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_1780
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1780
	add	x11, x11, x5
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_1780
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v12.8h, v10.8h, #8
	urshr	v13.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v12.8h, v10.8h
	raddhn	v31.8b, v13.8h, v11.8h
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x2, #0x4
	b.eq	L_1781
	st1	{ v28.s }[1], [x2], #4
L_1781
	tst	x2, #0x8
	b.eq	L_1782
	st1	{ v29.2s }, [x2], #8
L_1782
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1783
L_1775
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld1	{ v0.8b }, [x4], #8
	add	x10, x10, #8
	mvn	v1.8b, v0.8b
	umull	v8.8h, v1.8b, v4.8b
	umull	v9.8h, v1.8b, v5.8b
	umull	v10.8h, v1.8b, v6.8b
	umull	v11.8h, v1.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_1784
	add	x10, x10, #8
	sub	x9, x9, #1
L_1784
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_1785
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1785
	add	x11, x11, x5
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_1785
	subs	x0, x0, #16
	b.lt	L_1786
L_1787
	ld1	{ v0.8b }, [x4], #8
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v12.8h, v10.8h, #8
	urshr	v13.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v12.8h, v10.8h
	raddhn	v31.8b, v13.8h, v11.8h
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	add	x10, x10, #8
	tst	x9, #0xf
	b.eq	L_1788
	add	x10, x10, #8
	sub	x9, x9, #1
L_1788
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_1789
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1789
	add	x11, x11, x5
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_1789
	mvn	v1.8b, v0.8b
	umull	v8.8h, v1.8b, v4.8b
	umull	v9.8h, v1.8b, v5.8b
	umull	v10.8h, v1.8b, v6.8b
	umull	v11.8h, v1.8b, v7.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	subs	x0, x0, #8
	b.ge	L_1787
L_1786
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v12.8h, v10.8h, #8
	urshr	v13.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v12.8h, v10.8h
	raddhn	v31.8b, v13.8h, v11.8h
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
	tst	x0, #0x7
	b.eq	L_1790
	tst	x0, #0x4
	b.eq	L_1791
	ld1	{ v0.b }[4], [x4], #1
	ld1	{ v0.b }[5], [x4], #1
	ld1	{ v0.b }[6], [x4], #1
	ld1	{ v0.b }[7], [x4], #1
	ld1	{ v6.2s, v7.2s }, [x8], #16
	add	x10, x10, #4
L_1791
	tst	x0, #0x2
	b.eq	L_1792
	ld1	{ v0.b }[2], [x4], #1
	ld1	{ v0.b }[3], [x4], #1
	ld1	{ v5.2s }, [x8], #8
	add	x10, x10, #2
L_1792
	tst	x0, #0x1
	b.eq	L_1793
	ld1	{ v0.b }[1], [x4], #1
	ld1	{ v4.s }[1], [x8], #4
	add	x10, x10, #1
L_1793
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	mvn	v1.8b, v0.8b
	umull	v8.8h, v1.8b, v4.8b
	umull	v9.8h, v1.8b, v5.8b
	umull	v10.8h, v1.8b, v6.8b
	umull	v11.8h, v1.8b, v7.8b
	tst	x9, #0xf
	b.eq	L_1794
	add	x10, x10, #8
	sub	x9, x9, #1
L_1794
	cmp	x10, x14
	lsr	x15, x10, #0
	prfm	pldl1keep, [x11, x15]
	lsl	x15, x10, #2
	prfm	pldl1keep, [x12, x15]
	b.le	L_1795
	sub	x10, x10, x14
	subs	x9, x9, #16
	b.le	L_1795
	add	x11, x11, x5
	ldrsb	x15, [x11]
	add	x12, x12, x3, lsl #2
	ldrsb	x15, [x12]
L_1795
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v12.8h, v10.8h, #8
	urshr	v13.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v12.8h, v10.8h
	raddhn	v31.8b, v13.8h, v11.8h
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_1796
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1796
	tst	x0, #0x2
	b.eq	L_1797
	st1	{ v29.2s }, [x2], #8
L_1797
	tst	x0, #0x1
	b.eq	L_1798
	st1	{ v28.s }[1], [x2], #4
L_1798
L_1790
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1774
L_1799
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1773
	lsr	x15, x5, #0
	prfm	pldl1keep, [x4, x15]
	lsl	x15, x3, #2
	prfm	pldl1keep, [x8, x15]
	tst	x0, #0x8
	b.eq	L_1800
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x8], #32
	ld1	{ v0.8b }, [x4], #8
	mvn	v1.8b, v0.8b
	umull	v8.8h, v1.8b, v4.8b
	umull	v9.8h, v1.8b, v5.8b
	umull	v10.8h, v1.8b, v6.8b
	umull	v11.8h, v1.8b, v7.8b
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v12.8h, v10.8h, #8
	urshr	v13.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v12.8h, v10.8h
	raddhn	v31.8b, v13.8h, v11.8h
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x2], #32
L_1800
	tst	x0, #0x7
	b.eq	L_1801
	tst	x0, #0x4
	b.eq	L_1802
	ld1	{ v0.b }[4], [x4], #1
	ld1	{ v0.b }[5], [x4], #1
	ld1	{ v0.b }[6], [x4], #1
	ld1	{ v0.b }[7], [x4], #1
	ld1	{ v6.2s, v7.2s }, [x8], #16
L_1802
	tst	x0, #0x2
	b.eq	L_1803
	ld1	{ v0.b }[2], [x4], #1
	ld1	{ v0.b }[3], [x4], #1
	ld1	{ v5.2s }, [x8], #8
L_1803
	tst	x0, #0x1
	b.eq	L_1804
	ld1	{ v0.b }[1], [x4], #1
	ld1	{ v4.s }[1], [x8], #4
L_1804
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x15
	mvn	v1.8b, v0.8b
	umull	v8.8h, v1.8b, v4.8b
	umull	v9.8h, v1.8b, v5.8b
	umull	v10.8h, v1.8b, v6.8b
	umull	v11.8h, v1.8b, v7.8b
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v12.8h, v10.8h, #8
	urshr	v13.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v12.8h, v10.8h
	raddhn	v31.8b, v13.8h, v11.8h
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x15
	umov	x15, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x15
	tst	x0, #0x4
	b.eq	L_1805
	st1	{ v30.2s, v31.2s }, [x2], #16
L_1805
	tst	x0, #0x2
	b.eq	L_1806
	st1	{ v29.2s }, [x2], #8
L_1806
	tst	x0, #0x1
	b.eq	L_1807
	st1	{ v28.s }[1], [x2], #4
L_1807
L_1801
	mov	x0, x14
	add	x2, x2, x3, lsl #2
	add	x4, x4, x5
	sub	x2, x2, x0, lsl #2
	sub	x4, x4, x0
	subs	x1, x1, #1
	mov	x8, x2
	b.ge	L_1773
L_1772
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-112]
	ldp	x14, x15, [x29, #-128]
	ldp	x16, x17, [x29, #-144]
	ldp	x18, x19, [x29, #-160]
	ldp	x20, x21, [x29, #-176]
	ldp	x22, x23, [x29, #-192]
	ldp	x24, x25, [x29, #-208]
	ldp	x26, x27, [x29, #-224]
	ldur	x28, [x29, #-232]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon
pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon
	sxtw	x0, w0
	sxtw	x3, w3
	sxtw	x4, w4
	sxtw	x5, w5
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #88
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stur	x10, [x29, #-88]
	mov	x10, x1
	cmp	x0, #8
	b.lt	L_1808
	tst	x10, #0xf
	b.eq	L_1809
	tst	x10, #0x4
	b.eq	L_1810
	asr	x30, x3, #16
	mov	x8, x30
	adds	x3, x3, x4
	b.mi	L_1811
L_1812
	subs	x3, x3, x5
	b.pl	L_1812
L_1811
	add	x8, x2, x8, lsl #2
	ld1	{ v0.s }[1], [x8]
	ld1	{ v4.s }[1], [x10], #4
	sub	x0, x0, #1
L_1810
	tst	x10, #0x8
	b.eq	L_1813
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1814
L_1815
	subs	x3, x3, x5
	b.pl	L_1815
L_1814
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1816
L_1817
	subs	x3, x3, x5
	b.pl	L_1817
L_1816
	add	x9, x2, x9, lsl #2
	ld1	{ v1.s }[0], [x8]
	ld1	{ v1.s }[1], [x9]
	ld1	{ v5.2s }, [x10], #8
	sub	x0, x0, #2
L_1813
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1818
L_1819
	subs	x3, x3, x5
	b.pl	L_1819
L_1818
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1820
L_1821
	subs	x3, x3, x5
	b.pl	L_1821
L_1820
	add	x9, x2, x9, lsl #2
	ld1	{ v2.s }[0], [x8]
	ld1	{ v2.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1822
L_1823
	subs	x3, x3, x5
	b.pl	L_1823
L_1822
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1824
L_1825
	subs	x3, x3, x5
	b.pl	L_1825
L_1824
	add	x9, x2, x9, lsl #2
	ld1	{ v3.s }[0], [x8]
	ld1	{ v3.s }[1], [x9]
	ld1	{ v6.2s, v7.2s }, [x10], #16
	sub	x0, x0, #4
L_1826
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
L_1827
L_1828
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	tst	x1, #0x4
	b.eq	L_1829
	st1	{ v28.s }[1], [x1], #4
L_1829
	tst	x1, #0x8
	b.eq	L_1830
	st1	{ v29.2s }, [x1], #8
L_1830
	st1	{ v30.2s, v31.2s }, [x1], #16
L_1831
L_1809
	subs	x0, x0, #8
	b.lt	L_1832
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x10], #32
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1833
L_1834
	subs	x3, x3, x5
	b.pl	L_1834
L_1833
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1835
L_1836
	subs	x3, x3, x5
	b.pl	L_1836
L_1835
	add	x9, x2, x9, lsl #2
	ld1	{ v0.s }[0], [x8]
	ld1	{ v0.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1837
L_1838
	subs	x3, x3, x5
	b.pl	L_1838
L_1837
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1839
L_1840
	subs	x3, x3, x5
	b.pl	L_1840
L_1839
	add	x9, x2, x9, lsl #2
	ld1	{ v1.s }[0], [x8]
	ld1	{ v1.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1841
L_1842
	subs	x3, x3, x5
	b.pl	L_1842
L_1841
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1843
L_1844
	subs	x3, x3, x5
	b.pl	L_1844
L_1843
	add	x9, x2, x9, lsl #2
	ld1	{ v2.s }[0], [x8]
	ld1	{ v2.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1845
L_1846
	subs	x3, x3, x5
	b.pl	L_1846
L_1845
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1847
L_1848
	subs	x3, x3, x5
	b.pl	L_1848
L_1847
	add	x9, x2, x9, lsl #2
	ld1	{ v3.s }[0], [x8]
	ld1	{ v3.s }[1], [x9]
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	subs	x0, x0, #8
	b.lt	L_1849
L_1850
	ld4	{ v4.8b, v5.8b, v6.8b, v7.8b }, [x10], #32
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
L_1851
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1852
L_1853
	subs	x3, x3, x5
	b.pl	L_1853
L_1852
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1854
L_1855
	subs	x3, x3, x5
	b.pl	L_1855
L_1854
	add	x9, x2, x9, lsl #2
	ld1	{ v0.s }[0], [x8]
	ld1	{ v0.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1856
L_1857
	subs	x3, x3, x5
	b.pl	L_1857
L_1856
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1858
L_1859
	subs	x3, x3, x5
	b.pl	L_1859
L_1858
	add	x9, x2, x9, lsl #2
	ld1	{ v1.s }[0], [x8]
	ld1	{ v1.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1860
L_1861
	subs	x3, x3, x5
	b.pl	L_1861
L_1860
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1862
L_1863
	subs	x3, x3, x5
	b.pl	L_1863
L_1862
	add	x9, x2, x9, lsl #2
	ld1	{ v2.s }[0], [x8]
	ld1	{ v2.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1864
L_1865
	subs	x3, x3, x5
	b.pl	L_1865
L_1864
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1866
L_1867
	subs	x3, x3, x5
	b.pl	L_1867
L_1866
	add	x9, x2, x9, lsl #2
	ld1	{ v3.s }[0], [x8]
	ld1	{ v3.s }[1], [x9]
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	mvn	v22.8b, v3.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x1], #32
L_1868
	umull	v8.8h, v22.8b, v4.8b
L_1869
	umull	v9.8h, v22.8b, v5.8b
L_1870
	umull	v10.8h, v22.8b, v6.8b
L_1871
	umull	v11.8h, v22.8b, v7.8b
	subs	x0, x0, #8
	b.ge	L_1850
L_1849
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x1], #32
L_1832
	tst	x0, #0x7
	b.eq	L_1872
	tst	x0, #0x4
	b.eq	L_1873
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1874
L_1875
	subs	x3, x3, x5
	b.pl	L_1875
L_1874
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1876
L_1877
	subs	x3, x3, x5
	b.pl	L_1877
L_1876
	add	x9, x2, x9, lsl #2
	ld1	{ v2.s }[0], [x8]
	ld1	{ v2.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1878
L_1879
	subs	x3, x3, x5
	b.pl	L_1879
L_1878
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1880
L_1881
	subs	x3, x3, x5
	b.pl	L_1881
L_1880
	add	x9, x2, x9, lsl #2
	ld1	{ v3.s }[0], [x8]
	ld1	{ v3.s }[1], [x9]
	ld1	{ v6.2s, v7.2s }, [x10], #16
L_1873
	tst	x0, #0x2
	b.eq	L_1882
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1883
L_1884
	subs	x3, x3, x5
	b.pl	L_1884
L_1883
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1885
L_1886
	subs	x3, x3, x5
	b.pl	L_1886
L_1885
	add	x9, x2, x9, lsl #2
	ld1	{ v1.s }[0], [x8]
	ld1	{ v1.s }[1], [x9]
	ld1	{ v5.2s }, [x10], #8
L_1882
	tst	x0, #0x1
	b.eq	L_1887
	asr	x30, x3, #16
	mov	x8, x30
	adds	x3, x3, x4
	b.mi	L_1888
L_1889
	subs	x3, x3, x5
	b.pl	L_1889
L_1888
	add	x8, x2, x8, lsl #2
	ld1	{ v0.s }[1], [x8]
	ld1	{ v4.s }[1], [x10], #4
L_1887
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	tst	x0, #0x4
	b.eq	L_1890
	st1	{ v30.2s, v31.2s }, [x1], #16
L_1890
	tst	x0, #0x2
	b.eq	L_1891
	st1	{ v29.2s }, [x1], #8
L_1891
	tst	x0, #0x1
	b.eq	L_1892
	st1	{ v28.s }[1], [x1], #4
L_1892
L_1872
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldur	x10, [x29, #-96]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1808
	tst	x0, #0x7
	b.eq	L_1893
	tst	x0, #0x4
	b.eq	L_1894
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1895
L_1896
	subs	x3, x3, x5
	b.pl	L_1896
L_1895
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1897
L_1898
	subs	x3, x3, x5
	b.pl	L_1898
L_1897
	add	x9, x2, x9, lsl #2
	ld1	{ v2.s }[0], [x8]
	ld1	{ v2.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1899
L_1900
	subs	x3, x3, x5
	b.pl	L_1900
L_1899
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1901
L_1902
	subs	x3, x3, x5
	b.pl	L_1902
L_1901
	add	x9, x2, x9, lsl #2
	ld1	{ v3.s }[0], [x8]
	ld1	{ v3.s }[1], [x9]
	ld1	{ v6.2s, v7.2s }, [x10], #16
L_1894
	tst	x0, #0x2
	b.eq	L_1903
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1904
L_1905
	subs	x3, x3, x5
	b.pl	L_1905
L_1904
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1906
L_1907
	subs	x3, x3, x5
	b.pl	L_1907
L_1906
	add	x9, x2, x9, lsl #2
	ld1	{ v1.s }[0], [x8]
	ld1	{ v1.s }[1], [x9]
	ld1	{ v5.2s }, [x10], #8
L_1903
	tst	x0, #0x1
	b.eq	L_1908
	asr	x30, x3, #16
	mov	x8, x30
	adds	x3, x3, x4
	b.mi	L_1909
L_1910
	subs	x3, x3, x5
	b.pl	L_1910
L_1909
	add	x8, x2, x8, lsl #2
	ld1	{ v0.s }[1], [x8]
	ld1	{ v4.s }[1], [x10], #4
L_1908
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v5.8b
	uzp2	v5.8b, v4.8b, v5.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v6.8b, v7.8b
	uzp2	v7.8b, v6.8b, v7.8b
	mov	v6.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v5.8b, v7.8b
	uzp2	v7.8b, v5.8b, v7.8b
	mov	v5.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v4.8b, v6.8b
	uzp2	v6.8b, v4.8b, v6.8b
	mov	v4.8b, v16.8b
	mov	v16.d[0], x30
	mvn	v24.8b, v3.8b
	umull	v8.8h, v24.8b, v4.8b
	umull	v9.8h, v24.8b, v5.8b
	umull	v10.8h, v24.8b, v6.8b
	umull	v11.8h, v24.8b, v7.8b
	urshr	v14.8h, v8.8h, #8
	urshr	v15.8h, v9.8h, #8
	urshr	v16.8h, v10.8h, #8
	urshr	v17.8h, v11.8h, #8
	raddhn	v28.8b, v14.8h, v8.8h
	raddhn	v29.8b, v15.8h, v9.8h
	raddhn	v30.8b, v16.8h, v10.8h
	raddhn	v31.8b, v17.8h, v11.8h
	uqadd	v28.8b, v0.8b, v28.8b
	uqadd	v29.8b, v1.8b, v29.8b
	uqadd	v30.8b, v2.8b, v30.8b
	uqadd	v31.8b, v3.8b, v31.8b
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	tst	x0, #0x4
	b.eq	L_1911
	st1	{ v30.2s, v31.2s }, [x1], #16
L_1911
	tst	x0, #0x2
	b.eq	L_1912
	st1	{ v29.2s }, [x1], #8
L_1912
	tst	x0, #0x1
	b.eq	L_1913
	st1	{ v28.s }[1], [x1], #4
L_1913
L_1893
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldur	x10, [x29, #-88]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon
pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon
	sxtw	x0, w0
	sxtw	x3, w3
	sxtw	x4, w4
	sxtw	x5, w5
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #88
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stur	x10, [x29, #-88]
	mov	x10, x1
	cmp	x0, #8
	b.lt	L_1914
	tst	x10, #0xf
	b.eq	L_1915
	tst	x10, #0x2
	b.eq	L_1916
	asr	x30, x3, #16
	mov	x8, x30
	adds	x3, x3, x4
	b.mi	L_1917
L_1918
	subs	x3, x3, x5
	b.pl	L_1918
L_1917
	add	x8, x2, x8, lsl #2
	ld1	{ v0.s }[1], [x8]
	ld1	{ v4.h }[1], [x10], #2
	sub	x0, x0, #1
L_1916
	tst	x10, #0x4
	b.eq	L_1919
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1920
L_1921
	subs	x3, x3, x5
	b.pl	L_1921
L_1920
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1922
L_1923
	subs	x3, x3, x5
	b.pl	L_1923
L_1922
	add	x9, x2, x9, lsl #2
	ld1	{ v1.s }[0], [x8]
	ld1	{ v1.s }[1], [x9]
	ld1	{ v4.h }[2], [x10], #2
	ld1	{ v4.h }[3], [x10], #2
	sub	x0, x0, #2
L_1919
	tst	x10, #0x8
	b.eq	L_1924
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1925
L_1926
	subs	x3, x3, x5
	b.pl	L_1926
L_1925
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1927
L_1928
	subs	x3, x3, x5
	b.pl	L_1928
L_1927
	add	x9, x2, x9, lsl #2
	ld1	{ v2.s }[0], [x8]
	ld1	{ v2.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1929
L_1930
	subs	x3, x3, x5
	b.pl	L_1930
L_1929
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1931
L_1932
	subs	x3, x3, x5
	b.pl	L_1932
L_1931
	add	x9, x2, x9, lsl #2
	ld1	{ v3.s }[0], [x8]
	ld1	{ v3.s }[1], [x9]
	ld1	{ v5.4h }, [x10], #8
	sub	x0, x0, #4
L_1924
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	mov	v4.d[1], v5.d[0]
	shrn	v6.8b, v4.8h, #8
	shrn	v7.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v6.8b, v6.8b, #5
	mvn	v3.8b, v3.8b
	sri	v7.8b, v7.8b, #6
	shrn	v30.8b, v4.8h, #2
	umull	v10.8h, v3.8b, v6.8b
	umull	v11.8h, v3.8b, v7.8b
	umull	v12.8h, v3.8b, v30.8b
	urshr	v17.8h, v10.8h, #8
	urshr	v18.8h, v11.8h, #8
	urshr	v19.8h, v12.8h, #8
	raddhn	v20.8b, v10.8h, v17.8h
	raddhn	v23.8b, v11.8h, v18.8h
	raddhn	v22.8b, v12.8h, v19.8h
L_1933
L_1934
	uqadd	v17.8b, v2.8b, v20.8b
	uqadd	v18.8b, v0.8b, v22.8b
	uqadd	v19.8b, v1.8b, v23.8b
	ushll	v14.8h, v17.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v8.8h, v19.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v9.8h, v18.8b, #7
	sli	v9.8h, v9.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x1, #0x2
	b.eq	L_1935
	st1	{ v28.h }[1], [x1], #2
L_1935
	tst	x1, #0x4
	b.eq	L_1936
	st1	{ v28.s }[1], [x1], #4
L_1936
	tst	x1, #0x8
	b.eq	L_1937
	st1	{ v29.4h }, [x1], #8
L_1937
L_1915
	subs	x0, x0, #8
	b.lt	L_1938
	ld1	{ v4.4h, v5.4h }, [x10], #16
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1939
L_1940
	subs	x3, x3, x5
	b.pl	L_1940
L_1939
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1941
L_1942
	subs	x3, x3, x5
	b.pl	L_1942
L_1941
	add	x9, x2, x9, lsl #2
	ld1	{ v0.s }[0], [x8]
	ld1	{ v0.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1943
L_1944
	subs	x3, x3, x5
	b.pl	L_1944
L_1943
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1945
L_1946
	subs	x3, x3, x5
	b.pl	L_1946
L_1945
	add	x9, x2, x9, lsl #2
	ld1	{ v1.s }[0], [x8]
	ld1	{ v1.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1947
L_1948
	subs	x3, x3, x5
	b.pl	L_1948
L_1947
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1949
L_1950
	subs	x3, x3, x5
	b.pl	L_1950
L_1949
	add	x9, x2, x9, lsl #2
	ld1	{ v2.s }[0], [x8]
	ld1	{ v2.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1951
L_1952
	subs	x3, x3, x5
	b.pl	L_1952
L_1951
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1953
L_1954
	subs	x3, x3, x5
	b.pl	L_1954
L_1953
	add	x9, x2, x9, lsl #2
	ld1	{ v3.s }[0], [x8]
	ld1	{ v3.s }[1], [x9]
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	mov	v4.d[1], v5.d[0]
	shrn	v6.8b, v4.8h, #8
	shrn	v7.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v6.8b, v6.8b, #5
	mvn	v3.8b, v3.8b
	sri	v7.8b, v7.8b, #6
	shrn	v30.8b, v4.8h, #2
	umull	v10.8h, v3.8b, v6.8b
	umull	v11.8h, v3.8b, v7.8b
	umull	v12.8h, v3.8b, v30.8b
	urshr	v17.8h, v10.8h, #8
	urshr	v18.8h, v11.8h, #8
	urshr	v19.8h, v12.8h, #8
	raddhn	v20.8b, v10.8h, v17.8h
	raddhn	v23.8b, v11.8h, v18.8h
	raddhn	v22.8b, v12.8h, v19.8h
	subs	x0, x0, #8
	b.lt	L_1955
L_1956
	uqadd	v17.8b, v2.8b, v20.8b
	ld1	{ v4.4h, v5.4h }, [x10], #16
	mov	v4.d[1], v5.d[0]
	uqadd	v18.8b, v0.8b, v22.8b
	uqadd	v19.8b, v1.8b, v23.8b
	shrn	v6.8b, v4.8h, #8
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1957
L_1958
	subs	x3, x3, x5
	b.pl	L_1958
L_1957
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1959
L_1960
	subs	x3, x3, x5
	b.pl	L_1960
L_1959
	add	x9, x2, x9, lsl #2
	ld1	{ v0.s }[0], [x8]
	ld1	{ v0.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1961
L_1962
	subs	x3, x3, x5
	b.pl	L_1962
L_1961
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1963
L_1964
	subs	x3, x3, x5
	b.pl	L_1964
L_1963
	add	x9, x2, x9, lsl #2
	ld1	{ v1.s }[0], [x8]
	ld1	{ v1.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1965
L_1966
	subs	x3, x3, x5
	b.pl	L_1966
L_1965
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1967
L_1968
	subs	x3, x3, x5
	b.pl	L_1968
L_1967
	add	x9, x2, x9, lsl #2
	ld1	{ v2.s }[0], [x8]
	ld1	{ v2.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1969
L_1970
	subs	x3, x3, x5
	b.pl	L_1970
L_1969
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1971
L_1972
	subs	x3, x3, x5
	b.pl	L_1972
L_1971
	add	x9, x2, x9, lsl #2
	ld1	{ v3.s }[0], [x8]
	ld1	{ v3.s }[1], [x9]
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	shrn	v7.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	ushll	v14.8h, v17.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v8.8h, v19.8b, #7
	sli	v8.8h, v8.8h, #1
	sri	v6.8b, v6.8b, #5
L_1973
	mvn	v3.8b, v3.8b
L_1974
	sri	v7.8b, v7.8b, #6
	shrn	v30.8b, v4.8h, #2
	umull	v10.8h, v3.8b, v6.8b
	umull	v11.8h, v3.8b, v7.8b
	umull	v12.8h, v3.8b, v30.8b
	sri	v14.8h, v8.8h, #5
	ushll	v9.8h, v18.8b, #7
	sli	v9.8h, v9.8h, #1
	urshr	v17.8h, v10.8h, #8
L_1975
	urshr	v19.8h, v11.8h, #8
	urshr	v18.8h, v12.8h, #8
L_1976
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
L_1977
	raddhn	v20.8b, v10.8h, v17.8h
	raddhn	v23.8b, v11.8h, v19.8h
L_1978
	raddhn	v22.8b, v12.8h, v18.8h
	st1	{ v14.8h }, [x1], #16
	subs	x0, x0, #8
	b.ge	L_1956
L_1955
	uqadd	v17.8b, v2.8b, v20.8b
	uqadd	v18.8b, v0.8b, v22.8b
	uqadd	v19.8b, v1.8b, v23.8b
	ushll	v14.8h, v17.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v8.8h, v19.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v9.8h, v18.8b, #7
	sli	v9.8h, v9.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x1], #16
L_1938
	tst	x0, #0x7
	b.eq	L_1979
	tst	x0, #0x4
	b.eq	L_1980
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1981
L_1982
	subs	x3, x3, x5
	b.pl	L_1982
L_1981
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1983
L_1984
	subs	x3, x3, x5
	b.pl	L_1984
L_1983
	add	x9, x2, x9, lsl #2
	ld1	{ v2.s }[0], [x8]
	ld1	{ v2.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1985
L_1986
	subs	x3, x3, x5
	b.pl	L_1986
L_1985
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1987
L_1988
	subs	x3, x3, x5
	b.pl	L_1988
L_1987
	add	x9, x2, x9, lsl #2
	ld1	{ v3.s }[0], [x8]
	ld1	{ v3.s }[1], [x9]
	ld1	{ v5.4h }, [x10], #8
L_1980
	tst	x0, #0x2
	b.eq	L_1989
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_1990
L_1991
	subs	x3, x3, x5
	b.pl	L_1991
L_1990
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_1992
L_1993
	subs	x3, x3, x5
	b.pl	L_1993
L_1992
	add	x9, x2, x9, lsl #2
	ld1	{ v1.s }[0], [x8]
	ld1	{ v1.s }[1], [x9]
	ld1	{ v4.h }[2], [x10], #2
	ld1	{ v4.h }[3], [x10], #2
L_1989
	tst	x0, #0x1
	b.eq	L_1994
	asr	x30, x3, #16
	mov	x8, x30
	adds	x3, x3, x4
	b.mi	L_1995
L_1996
	subs	x3, x3, x5
	b.pl	L_1996
L_1995
	add	x8, x2, x8, lsl #2
	ld1	{ v0.s }[1], [x8]
	ld1	{ v4.h }[1], [x10], #2
L_1994
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	mov	v4.d[1], v5.d[0]
	shrn	v6.8b, v4.8h, #8
	shrn	v7.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v6.8b, v6.8b, #5
	mvn	v3.8b, v3.8b
	sri	v7.8b, v7.8b, #6
	shrn	v30.8b, v4.8h, #2
	umull	v10.8h, v3.8b, v6.8b
	umull	v11.8h, v3.8b, v7.8b
	umull	v12.8h, v3.8b, v30.8b
	urshr	v17.8h, v10.8h, #8
	urshr	v18.8h, v11.8h, #8
	urshr	v19.8h, v12.8h, #8
	raddhn	v20.8b, v10.8h, v17.8h
	raddhn	v23.8b, v11.8h, v18.8h
	raddhn	v22.8b, v12.8h, v19.8h
	uqadd	v17.8b, v2.8b, v20.8b
	uqadd	v18.8b, v0.8b, v22.8b
	uqadd	v19.8b, v1.8b, v23.8b
	ushll	v14.8h, v17.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v8.8h, v19.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v9.8h, v18.8b, #7
	sli	v9.8h, v9.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_1997
	st1	{ v29.4h }, [x1], #8
L_1997
	tst	x0, #0x2
	b.eq	L_1998
	st1	{ v28.s }[1], [x1], #4
L_1998
	tst	x0, #0x1
	b.eq	L_1999
	st1	{ v28.h }[1], [x1], #2
L_1999
L_1979
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldur	x10, [x29, #-96]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_1914
	tst	x0, #0x7
	b.eq	L_2000
	tst	x0, #0x4
	b.eq	L_2001
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2002
L_2003
	subs	x3, x3, x5
	b.pl	L_2003
L_2002
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2004
L_2005
	subs	x3, x3, x5
	b.pl	L_2005
L_2004
	add	x9, x2, x9, lsl #2
	ld1	{ v2.s }[0], [x8]
	ld1	{ v2.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2006
L_2007
	subs	x3, x3, x5
	b.pl	L_2007
L_2006
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2008
L_2009
	subs	x3, x3, x5
	b.pl	L_2009
L_2008
	add	x9, x2, x9, lsl #2
	ld1	{ v3.s }[0], [x8]
	ld1	{ v3.s }[1], [x9]
	ld1	{ v5.4h }, [x10], #8
L_2001
	tst	x0, #0x2
	b.eq	L_2010
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2011
L_2012
	subs	x3, x3, x5
	b.pl	L_2012
L_2011
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2013
L_2014
	subs	x3, x3, x5
	b.pl	L_2014
L_2013
	add	x9, x2, x9, lsl #2
	ld1	{ v1.s }[0], [x8]
	ld1	{ v1.s }[1], [x9]
	ld1	{ v4.h }[2], [x10], #2
	ld1	{ v4.h }[3], [x10], #2
L_2010
	tst	x0, #0x1
	b.eq	L_2015
	asr	x30, x3, #16
	mov	x8, x30
	adds	x3, x3, x4
	b.mi	L_2016
L_2017
	subs	x3, x3, x5
	b.pl	L_2017
L_2016
	add	x8, x2, x8, lsl #2
	ld1	{ v0.s }[1], [x8]
	ld1	{ v4.h }[1], [x10], #2
L_2015
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	mov	v4.d[1], v5.d[0]
	shrn	v6.8b, v4.8h, #8
	shrn	v7.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v6.8b, v6.8b, #5
	mvn	v3.8b, v3.8b
	sri	v7.8b, v7.8b, #6
	shrn	v30.8b, v4.8h, #2
	umull	v10.8h, v3.8b, v6.8b
	umull	v11.8h, v3.8b, v7.8b
	umull	v12.8h, v3.8b, v30.8b
	urshr	v17.8h, v10.8h, #8
	urshr	v18.8h, v11.8h, #8
	urshr	v19.8h, v12.8h, #8
	raddhn	v20.8b, v10.8h, v17.8h
	raddhn	v23.8b, v11.8h, v18.8h
	raddhn	v22.8b, v12.8h, v19.8h
	uqadd	v17.8b, v2.8b, v20.8b
	uqadd	v18.8b, v0.8b, v22.8b
	uqadd	v19.8b, v1.8b, v23.8b
	ushll	v14.8h, v17.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v8.8h, v19.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v9.8h, v18.8b, #7
	sli	v9.8h, v9.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_2018
	st1	{ v29.4h }, [x1], #8
L_2018
	tst	x0, #0x2
	b.eq	L_2019
	st1	{ v28.h }[2], [x1], #2
	st1	{ v28.h }[3], [x1], #2
L_2019
	tst	x0, #0x1
	b.eq	L_2020
	st1	{ v28.h }[1], [x1], #2
L_2020
L_2000
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldur	x10, [x29, #-88]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon
pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon
	sxtw	x0, w0
	sxtw	x3, w3
	sxtw	x4, w4
	sxtw	x5, w5
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #88
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stur	x10, [x29, #-88]
	mov	x10, x1
	cmp	x0, #8
	b.lt	L_2021
	tst	x10, #0xf
	b.eq	L_2022
	tst	x10, #0x2
	b.eq	L_2023
	asr	x30, x3, #16
	mov	x8, x30
	adds	x3, x3, x4
	b.mi	L_2024
L_2025
	subs	x3, x3, x5
	b.pl	L_2025
L_2024
	add	x8, x2, x8, lsl #2
	ld1	{ v0.s }[1], [x8]
	add	x10, x10, #2
	sub	x0, x0, #1
L_2023
	tst	x10, #0x4
	b.eq	L_2026
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2027
L_2028
	subs	x3, x3, x5
	b.pl	L_2028
L_2027
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2029
L_2030
	subs	x3, x3, x5
	b.pl	L_2030
L_2029
	add	x9, x2, x9, lsl #2
	ld1	{ v1.s }[0], [x8]
	ld1	{ v1.s }[1], [x9]
	add	x10, x10, #4
	sub	x0, x0, #2
L_2026
	tst	x10, #0x8
	b.eq	L_2031
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2032
L_2033
	subs	x3, x3, x5
	b.pl	L_2033
L_2032
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2034
L_2035
	subs	x3, x3, x5
	b.pl	L_2035
L_2034
	add	x9, x2, x9, lsl #2
	ld1	{ v2.s }[0], [x8]
	ld1	{ v2.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2036
L_2037
	subs	x3, x3, x5
	b.pl	L_2037
L_2036
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2038
L_2039
	subs	x3, x3, x5
	b.pl	L_2039
L_2038
	add	x9, x2, x9, lsl #2
	ld1	{ v3.s }[0], [x8]
	ld1	{ v3.s }[1], [x9]
	add	x10, x10, #8
	sub	x0, x0, #4
L_2031
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	ushll	v8.8h, v1.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v14.8h, v2.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v9.8h, v0.8b, #7
	sli	v9.8h, v9.8h, #1
L_2040
L_2041
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x1, #0x2
	b.eq	L_2042
	st1	{ v28.h }[1], [x1], #2
L_2042
	tst	x1, #0x4
	b.eq	L_2043
	st1	{ v28.s }[1], [x1], #4
L_2043
	tst	x1, #0x8
	b.eq	L_2044
	st1	{ v29.4h }, [x1], #8
L_2044
L_2022
	subs	x0, x0, #8
	b.lt	L_2045
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2046
L_2047
	subs	x3, x3, x5
	b.pl	L_2047
L_2046
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2048
L_2049
	subs	x3, x3, x5
	b.pl	L_2049
L_2048
	add	x9, x2, x9, lsl #2
	ld1	{ v0.s }[0], [x8]
	ld1	{ v0.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2050
L_2051
	subs	x3, x3, x5
	b.pl	L_2051
L_2050
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2052
L_2053
	subs	x3, x3, x5
	b.pl	L_2053
L_2052
	add	x9, x2, x9, lsl #2
	ld1	{ v1.s }[0], [x8]
	ld1	{ v1.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2054
L_2055
	subs	x3, x3, x5
	b.pl	L_2055
L_2054
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2056
L_2057
	subs	x3, x3, x5
	b.pl	L_2057
L_2056
	add	x9, x2, x9, lsl #2
	ld1	{ v2.s }[0], [x8]
	ld1	{ v2.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2058
L_2059
	subs	x3, x3, x5
	b.pl	L_2059
L_2058
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2060
L_2061
	subs	x3, x3, x5
	b.pl	L_2061
L_2060
	add	x9, x2, x9, lsl #2
	ld1	{ v3.s }[0], [x8]
	ld1	{ v3.s }[1], [x9]
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	ushll	v8.8h, v1.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v14.8h, v2.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v9.8h, v0.8b, #7
	sli	v9.8h, v9.8h, #1
	subs	x0, x0, #8
	b.lt	L_2062
L_2063
	sri	v14.8h, v8.8h, #5
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2064
L_2065
	subs	x3, x3, x5
	b.pl	L_2065
L_2064
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2066
L_2067
	subs	x3, x3, x5
	b.pl	L_2067
L_2066
	add	x9, x2, x9, lsl #2
	ld1	{ v0.s }[0], [x8]
	ld1	{ v0.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2068
L_2069
	subs	x3, x3, x5
	b.pl	L_2069
L_2068
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2070
L_2071
	subs	x3, x3, x5
	b.pl	L_2071
L_2070
	add	x9, x2, x9, lsl #2
	ld1	{ v1.s }[0], [x8]
	ld1	{ v1.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2072
L_2073
	subs	x3, x3, x5
	b.pl	L_2073
L_2072
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2074
L_2075
	subs	x3, x3, x5
	b.pl	L_2075
L_2074
	add	x9, x2, x9, lsl #2
	ld1	{ v2.s }[0], [x8]
	ld1	{ v2.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2076
L_2077
	subs	x3, x3, x5
	b.pl	L_2077
L_2076
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2078
L_2079
	subs	x3, x3, x5
	b.pl	L_2079
L_2078
	add	x9, x2, x9, lsl #2
	ld1	{ v3.s }[0], [x8]
	ld1	{ v3.s }[1], [x9]
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
L_2080
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	ushll	v8.8h, v1.8b, #7
	sli	v8.8h, v8.8h, #1
	st1	{ v14.8h }, [x1], #16
L_2081
	ushll	v14.8h, v2.8b, #7
	sli	v14.8h, v14.8h, #1
L_2082
	ushll	v9.8h, v0.8b, #7
	sli	v9.8h, v9.8h, #1
	subs	x0, x0, #8
	b.ge	L_2063
L_2062
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x1], #16
L_2045
	tst	x0, #0x7
	b.eq	L_2083
	tst	x0, #0x4
	b.eq	L_2084
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2085
L_2086
	subs	x3, x3, x5
	b.pl	L_2086
L_2085
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2087
L_2088
	subs	x3, x3, x5
	b.pl	L_2088
L_2087
	add	x9, x2, x9, lsl #2
	ld1	{ v2.s }[0], [x8]
	ld1	{ v2.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2089
L_2090
	subs	x3, x3, x5
	b.pl	L_2090
L_2089
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2091
L_2092
	subs	x3, x3, x5
	b.pl	L_2092
L_2091
	add	x9, x2, x9, lsl #2
	ld1	{ v3.s }[0], [x8]
	ld1	{ v3.s }[1], [x9]
L_2084
	tst	x0, #0x2
	b.eq	L_2093
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2094
L_2095
	subs	x3, x3, x5
	b.pl	L_2095
L_2094
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2096
L_2097
	subs	x3, x3, x5
	b.pl	L_2097
L_2096
	add	x9, x2, x9, lsl #2
	ld1	{ v1.s }[0], [x8]
	ld1	{ v1.s }[1], [x9]
L_2093
	tst	x0, #0x1
	b.eq	L_2098
	asr	x30, x3, #16
	mov	x8, x30
	adds	x3, x3, x4
	b.mi	L_2099
L_2100
	subs	x3, x3, x5
	b.pl	L_2100
L_2099
	add	x8, x2, x8, lsl #2
	ld1	{ v0.s }[1], [x8]
L_2098
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	ushll	v8.8h, v1.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v14.8h, v2.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v9.8h, v0.8b, #7
	sli	v9.8h, v9.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_2101
	st1	{ v29.4h }, [x1], #8
L_2101
	tst	x0, #0x2
	b.eq	L_2102
	st1	{ v28.s }[1], [x1], #4
L_2102
	tst	x0, #0x1
	b.eq	L_2103
	st1	{ v28.h }[1], [x1], #2
L_2103
L_2083
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldur	x10, [x29, #-96]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_2021
	tst	x0, #0x7
	b.eq	L_2104
	tst	x0, #0x4
	b.eq	L_2105
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2106
L_2107
	subs	x3, x3, x5
	b.pl	L_2107
L_2106
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2108
L_2109
	subs	x3, x3, x5
	b.pl	L_2109
L_2108
	add	x9, x2, x9, lsl #2
	ld1	{ v2.s }[0], [x8]
	ld1	{ v2.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2110
L_2111
	subs	x3, x3, x5
	b.pl	L_2111
L_2110
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2112
L_2113
	subs	x3, x3, x5
	b.pl	L_2113
L_2112
	add	x9, x2, x9, lsl #2
	ld1	{ v3.s }[0], [x8]
	ld1	{ v3.s }[1], [x9]
L_2105
	tst	x0, #0x2
	b.eq	L_2114
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2115
L_2116
	subs	x3, x3, x5
	b.pl	L_2116
L_2115
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2117
L_2118
	subs	x3, x3, x5
	b.pl	L_2118
L_2117
	add	x9, x2, x9, lsl #2
	ld1	{ v1.s }[0], [x8]
	ld1	{ v1.s }[1], [x9]
L_2114
	tst	x0, #0x1
	b.eq	L_2119
	asr	x30, x3, #16
	mov	x8, x30
	adds	x3, x3, x4
	b.mi	L_2120
L_2121
	subs	x3, x3, x5
	b.pl	L_2121
L_2120
	add	x8, x2, x8, lsl #2
	ld1	{ v0.s }[1], [x8]
L_2119
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v16.8b
	mov	v16.d[0], x30
	ushll	v8.8h, v1.8b, #7
	sli	v8.8h, v8.8h, #1
	ushll	v14.8h, v2.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v9.8h, v0.8b, #7
	sli	v9.8h, v9.8h, #1
	sri	v14.8h, v8.8h, #5
	sri	v14.8h, v9.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_2122
	st1	{ v29.4h }, [x1], #8
L_2122
	tst	x0, #0x2
	b.eq	L_2123
	st1	{ v28.h }[2], [x1], #2
	st1	{ v28.h }[3], [x1], #2
L_2123
	tst	x0, #0x1
	b.eq	L_2124
	st1	{ v28.h }[1], [x1], #2
L_2124
L_2104
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldur	x10, [x29, #-88]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon
pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon
	sxtw	x0, w0
	sxtw	x3, w3
	sxtw	x4, w4
	sxtw	x5, w5
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #88
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stur	x10, [x29, #-88]
	mov	x10, x1
	cmp	x0, #8
	b.lt	L_2125
	tst	x10, #0xf
	b.eq	L_2126
	tst	x10, #0x4
	b.eq	L_2127
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2128
L_2129
	subs	x3, x3, x5
	b.pl	L_2129
L_2128
	add	x8, x2, x8, lsl #1
	ld1	{ v0.h }[1], [x8]
	add	x10, x10, #4
	sub	x0, x0, #1
L_2127
	tst	x10, #0x8
	b.eq	L_2130
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2131
L_2132
	subs	x3, x3, x5
	b.pl	L_2132
L_2131
	add	x8, x2, x8, lsl #1
	ld1	{ v0.h }[2], [x8]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2133
L_2134
	subs	x3, x3, x5
	b.pl	L_2134
L_2133
	add	x8, x2, x8, lsl #1
	ld1	{ v0.h }[3], [x8]
	add	x10, x10, #8
	sub	x0, x0, #2
L_2130
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2135
L_2136
	subs	x3, x3, x5
	b.pl	L_2136
L_2135
	add	x8, x2, x8, lsl #1
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2137
L_2138
	subs	x3, x3, x5
	b.pl	L_2138
L_2137
	add	x9, x2, x9, lsl #1
	ld1	{ v1.h }[0], [x8]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2139
L_2140
	subs	x3, x3, x5
	b.pl	L_2140
L_2139
	add	x8, x2, x8, lsl #1
	ld1	{ v1.h }[1], [x9]
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2141
L_2142
	subs	x3, x3, x5
	b.pl	L_2142
L_2141
	add	x9, x2, x9, lsl #1
	ld1	{ v1.h }[2], [x8]
	ld1	{ v1.h }[3], [x9]
	add	x10, x10, #16
	sub	x0, x0, #4
L_2143
	mov	v0.d[1], v1.d[0]
	shrn	v30.8b, v0.8h, #8
	shrn	v29.8b, v0.8h, #3
	sli	v0.8h, v0.8h, #5
	movi	v31.8b, #255
	sri	v30.8b, v30.8b, #5
	sri	v29.8b, v29.8b, #6
	shrn	v28.8b, v0.8h, #2
L_2144
L_2145
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	tst	x1, #0x4
	b.eq	L_2146
	st1	{ v28.s }[1], [x1], #4
L_2146
	tst	x1, #0x8
	b.eq	L_2147
	st1	{ v29.2s }, [x1], #8
L_2147
	st1	{ v30.2s, v31.2s }, [x1], #16
L_2148
L_2126
	subs	x0, x0, #8
	b.lt	L_2149
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2150
L_2151
	subs	x3, x3, x5
	b.pl	L_2151
L_2150
	add	x8, x2, x8, lsl #1
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2152
L_2153
	subs	x3, x3, x5
	b.pl	L_2153
L_2152
	add	x9, x2, x9, lsl #1
	ld1	{ v0.h }[0], [x8]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2154
L_2155
	subs	x3, x3, x5
	b.pl	L_2155
L_2154
	add	x8, x2, x8, lsl #1
	ld1	{ v0.h }[1], [x9]
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2156
L_2157
	subs	x3, x3, x5
	b.pl	L_2157
L_2156
	add	x9, x2, x9, lsl #1
	ld1	{ v0.h }[2], [x8]
	ld1	{ v0.h }[3], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2158
L_2159
	subs	x3, x3, x5
	b.pl	L_2159
L_2158
	add	x8, x2, x8, lsl #1
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2160
L_2161
	subs	x3, x3, x5
	b.pl	L_2161
L_2160
	add	x9, x2, x9, lsl #1
	ld1	{ v1.h }[0], [x8]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2162
L_2163
	subs	x3, x3, x5
	b.pl	L_2163
L_2162
	add	x8, x2, x8, lsl #1
	ld1	{ v1.h }[1], [x9]
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2164
L_2165
	subs	x3, x3, x5
	b.pl	L_2165
L_2164
	add	x9, x2, x9, lsl #1
	ld1	{ v1.h }[2], [x8]
	ld1	{ v1.h }[3], [x9]
	mov	v0.d[1], v1.d[0]
	shrn	v30.8b, v0.8h, #8
	shrn	v29.8b, v0.8h, #3
	sli	v0.8h, v0.8h, #5
	movi	v31.8b, #255
	sri	v30.8b, v30.8b, #5
	sri	v29.8b, v29.8b, #6
	shrn	v28.8b, v0.8h, #2
	subs	x0, x0, #8
	b.lt	L_2166
L_2167
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x1], #32
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2168
L_2169
	subs	x3, x3, x5
	b.pl	L_2169
L_2168
	add	x8, x2, x8, lsl #1
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2170
L_2171
	subs	x3, x3, x5
	b.pl	L_2171
L_2170
	add	x9, x2, x9, lsl #1
	ld1	{ v0.h }[0], [x8]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2172
L_2173
	subs	x3, x3, x5
	b.pl	L_2173
L_2172
	add	x8, x2, x8, lsl #1
	ld1	{ v0.h }[1], [x9]
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2174
L_2175
	subs	x3, x3, x5
	b.pl	L_2175
L_2174
	add	x9, x2, x9, lsl #1
	ld1	{ v0.h }[2], [x8]
	ld1	{ v0.h }[3], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2176
L_2177
	subs	x3, x3, x5
	b.pl	L_2177
L_2176
	add	x8, x2, x8, lsl #1
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2178
L_2179
	subs	x3, x3, x5
	b.pl	L_2179
L_2178
	add	x9, x2, x9, lsl #1
	ld1	{ v1.h }[0], [x8]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2180
L_2181
	subs	x3, x3, x5
	b.pl	L_2181
L_2180
	add	x8, x2, x8, lsl #1
	ld1	{ v1.h }[1], [x9]
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2182
L_2183
	subs	x3, x3, x5
	b.pl	L_2183
L_2182
	add	x9, x2, x9, lsl #1
	ld1	{ v1.h }[2], [x8]
	ld1	{ v1.h }[3], [x9]
	mov	v0.d[1], v1.d[0]
	shrn	v30.8b, v0.8h, #8
	shrn	v29.8b, v0.8h, #3
	sli	v0.8h, v0.8h, #5
	movi	v31.8b, #255
	sri	v30.8b, v30.8b, #5
	sri	v29.8b, v29.8b, #6
	shrn	v28.8b, v0.8h, #2
L_2184
L_2185
	subs	x0, x0, #8
	b.ge	L_2167
L_2166
	st4	{ v28.8b, v29.8b, v30.8b, v31.8b }, [x1], #32
L_2149
	tst	x0, #0x7
	b.eq	L_2186
	tst	x0, #0x4
	b.eq	L_2187
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2188
L_2189
	subs	x3, x3, x5
	b.pl	L_2189
L_2188
	add	x8, x2, x8, lsl #1
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2190
L_2191
	subs	x3, x3, x5
	b.pl	L_2191
L_2190
	add	x9, x2, x9, lsl #1
	ld1	{ v1.h }[0], [x8]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2192
L_2193
	subs	x3, x3, x5
	b.pl	L_2193
L_2192
	add	x8, x2, x8, lsl #1
	ld1	{ v1.h }[1], [x9]
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2194
L_2195
	subs	x3, x3, x5
	b.pl	L_2195
L_2194
	add	x9, x2, x9, lsl #1
	ld1	{ v1.h }[2], [x8]
	ld1	{ v1.h }[3], [x9]
L_2187
	tst	x0, #0x2
	b.eq	L_2196
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2197
L_2198
	subs	x3, x3, x5
	b.pl	L_2198
L_2197
	add	x8, x2, x8, lsl #1
	ld1	{ v0.h }[2], [x8]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2199
L_2200
	subs	x3, x3, x5
	b.pl	L_2200
L_2199
	add	x8, x2, x8, lsl #1
	ld1	{ v0.h }[3], [x8]
L_2196
	tst	x0, #0x1
	b.eq	L_2201
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2202
L_2203
	subs	x3, x3, x5
	b.pl	L_2203
L_2202
	add	x8, x2, x8, lsl #1
	ld1	{ v0.h }[1], [x8]
L_2201
	mov	v0.d[1], v1.d[0]
	shrn	v30.8b, v0.8h, #8
	shrn	v29.8b, v0.8h, #3
	sli	v0.8h, v0.8h, #5
	movi	v31.8b, #255
	sri	v30.8b, v30.8b, #5
	sri	v29.8b, v29.8b, #6
	shrn	v28.8b, v0.8h, #2
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	tst	x0, #0x4
	b.eq	L_2204
	st1	{ v30.2s, v31.2s }, [x1], #16
L_2204
	tst	x0, #0x2
	b.eq	L_2205
	st1	{ v29.2s }, [x1], #8
L_2205
	tst	x0, #0x1
	b.eq	L_2206
	st1	{ v28.s }[1], [x1], #4
L_2206
L_2186
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldur	x10, [x29, #-96]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_2125
	tst	x0, #0x7
	b.eq	L_2207
	tst	x0, #0x4
	b.eq	L_2208
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2209
L_2210
	subs	x3, x3, x5
	b.pl	L_2210
L_2209
	add	x8, x2, x8, lsl #1
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2211
L_2212
	subs	x3, x3, x5
	b.pl	L_2212
L_2211
	add	x9, x2, x9, lsl #1
	ld1	{ v1.h }[0], [x8]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2213
L_2214
	subs	x3, x3, x5
	b.pl	L_2214
L_2213
	add	x8, x2, x8, lsl #1
	ld1	{ v1.h }[1], [x9]
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2215
L_2216
	subs	x3, x3, x5
	b.pl	L_2216
L_2215
	add	x9, x2, x9, lsl #1
	ld1	{ v1.h }[2], [x8]
	ld1	{ v1.h }[3], [x9]
L_2208
	tst	x0, #0x2
	b.eq	L_2217
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2218
L_2219
	subs	x3, x3, x5
	b.pl	L_2219
L_2218
	add	x8, x2, x8, lsl #1
	ld1	{ v0.h }[2], [x8]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2220
L_2221
	subs	x3, x3, x5
	b.pl	L_2221
L_2220
	add	x8, x2, x8, lsl #1
	ld1	{ v0.h }[3], [x8]
L_2217
	tst	x0, #0x1
	b.eq	L_2222
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2223
L_2224
	subs	x3, x3, x5
	b.pl	L_2224
L_2223
	add	x8, x2, x8, lsl #1
	ld1	{ v0.h }[1], [x8]
L_2222
	mov	v0.d[1], v1.d[0]
	shrn	v30.8b, v0.8h, #8
	shrn	v29.8b, v0.8h, #3
	sli	v0.8h, v0.8h, #5
	movi	v31.8b, #255
	sri	v30.8b, v30.8b, #5
	sri	v29.8b, v29.8b, #6
	shrn	v28.8b, v0.8h, #2
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v30.8b
	zip2	v30.8b, v28.8b, v30.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v29.8b, v31.8b
	zip2	v31.8b, v29.8b, v31.8b
	mov	v29.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v30.8b, v31.8b
	zip2	v31.8b, v30.8b, v31.8b
	mov	v30.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	zip1	v16.8b, v28.8b, v29.8b
	zip2	v29.8b, v28.8b, v29.8b
	mov	v28.8b, v16.8b
	mov	v16.d[0], x30
	tst	x0, #0x4
	b.eq	L_2225
	st1	{ v30.2s, v31.2s }, [x1], #16
L_2225
	tst	x0, #0x2
	b.eq	L_2226
	st1	{ v29.2s }, [x1], #8
L_2226
	tst	x0, #0x1
	b.eq	L_2227
	st1	{ v28.s }[1], [x1], #4
L_2227
L_2207
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldur	x10, [x29, #-88]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon
pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon
	sxtw	x0, w0
	sxtw	x3, w3
	sxtw	x4, w4
	sxtw	x5, w5
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #88
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stur	x10, [x29, #-88]
	mov	x10, x1
	cmp	x0, #8
	b.lt	L_2228
	tst	x10, #0xf
	b.eq	L_2229
	tst	x10, #0x2
	b.eq	L_2230
	asr	x30, x3, #16
	mov	x8, x30
	adds	x3, x3, x4
	b.mi	L_2231
L_2232
	subs	x3, x3, x5
	b.pl	L_2232
L_2231
	add	x8, x2, x8, lsl #2
	ld1	{ v8.s }[1], [x8]
	ld1	{ v24.b }[1], [x6], #1
	ld1	{ v4.h }[1], [x10], #2
	sub	x0, x0, #1
L_2230
	tst	x10, #0x4
	b.eq	L_2233
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2234
L_2235
	subs	x3, x3, x5
	b.pl	L_2235
L_2234
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2236
L_2237
	subs	x3, x3, x5
	b.pl	L_2237
L_2236
	add	x9, x2, x9, lsl #2
	ld1	{ v9.s }[0], [x8]
	ld1	{ v9.s }[1], [x9]
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	ld1	{ v4.h }[2], [x10], #2
	ld1	{ v4.h }[3], [x10], #2
	sub	x0, x0, #2
L_2233
	tst	x10, #0x8
	b.eq	L_2238
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2239
L_2240
	subs	x3, x3, x5
	b.pl	L_2240
L_2239
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2241
L_2242
	subs	x3, x3, x5
	b.pl	L_2242
L_2241
	add	x9, x2, x9, lsl #2
	ld1	{ v10.s }[0], [x8]
	ld1	{ v10.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2243
L_2244
	subs	x3, x3, x5
	b.pl	L_2244
L_2243
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2245
L_2246
	subs	x3, x3, x5
	b.pl	L_2246
L_2245
	add	x9, x2, x9, lsl #2
	ld1	{ v11.s }[0], [x8]
	ld1	{ v11.s }[1], [x9]
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	ld1	{ v5.4h }, [x10], #8
	sub	x0, x0, #4
L_2238
	umov	x30, v16.d[0]
	uzp1	v16.8b, v8.8b, v9.8b
	uzp2	v9.8b, v8.8b, v9.8b
	mov	v8.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v10.8b, v11.8b
	uzp2	v11.8b, v10.8b, v11.8b
	mov	v10.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v9.8b, v11.8b
	uzp2	v11.8b, v9.8b, v11.8b
	mov	v9.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v8.8b, v10.8b
	uzp2	v10.8b, v8.8b, v10.8b
	mov	v8.8b, v16.8b
	mov	v16.d[0], x30
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v24.8b, v9.8b
	umull	v2.8h, v24.8b, v10.8b
	umull	v3.8h, v24.8b, v11.8b
	mov	v4.d[1], v5.d[0]
	shrn	v25.8b, v4.8h, #8
	shrn	v26.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	urshr	v17.8h, v0.8h, #8
	urshr	v18.8h, v1.8h, #8
	urshr	v19.8h, v2.8h, #8
	urshr	v20.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v17.8h
	raddhn	v1.8b, v1.8h, v18.8h
	raddhn	v2.8b, v2.8h, v19.8h
	raddhn	v3.8b, v3.8h, v20.8h
	sri	v25.8b, v25.8b, #5
	sri	v26.8b, v26.8b, #6
	mvn	v3.8b, v3.8b
	shrn	v30.8b, v4.8h, #2
	umull	v18.8h, v3.8b, v25.8b
	umull	v19.8h, v3.8b, v26.8b
	umull	v20.8h, v3.8b, v30.8b
L_2247
L_2248
	urshr	v5.8h, v18.8h, #8
	urshr	v6.8h, v19.8h, #8
	urshr	v7.8h, v20.8h, #8
	raddhn	v17.8b, v18.8h, v5.8h
	raddhn	v19.8b, v19.8h, v6.8h
	raddhn	v18.8b, v20.8h, v7.8h
	uqadd	v5.8b, v2.8b, v17.8b
	uqadd	v6.8b, v0.8b, v18.8b
	uqadd	v7.8b, v1.8b, v19.8b
	ushll	v14.8h, v5.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v7.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v6.8b, #7
	sli	v19.8h, v19.8h, #1
	sri	v14.8h, v18.8h, #5
	sri	v14.8h, v19.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x1, #0x2
	b.eq	L_2249
	st1	{ v28.h }[1], [x1], #2
L_2249
	tst	x1, #0x4
	b.eq	L_2250
	st1	{ v28.s }[1], [x1], #4
L_2250
	tst	x1, #0x8
	b.eq	L_2251
	st1	{ v29.4h }, [x1], #8
L_2251
L_2229
	subs	x0, x0, #8
	b.lt	L_2252
	ld1	{ v4.4h, v5.4h }, [x10], #16
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2253
L_2254
	subs	x3, x3, x5
	b.pl	L_2254
L_2253
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2255
L_2256
	subs	x3, x3, x5
	b.pl	L_2256
L_2255
	add	x9, x2, x9, lsl #2
	ld1	{ v8.s }[0], [x8]
	ld1	{ v8.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2257
L_2258
	subs	x3, x3, x5
	b.pl	L_2258
L_2257
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2259
L_2260
	subs	x3, x3, x5
	b.pl	L_2260
L_2259
	add	x9, x2, x9, lsl #2
	ld1	{ v9.s }[0], [x8]
	ld1	{ v9.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2261
L_2262
	subs	x3, x3, x5
	b.pl	L_2262
L_2261
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2263
L_2264
	subs	x3, x3, x5
	b.pl	L_2264
L_2263
	add	x9, x2, x9, lsl #2
	ld1	{ v10.s }[0], [x8]
	ld1	{ v10.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2265
L_2266
	subs	x3, x3, x5
	b.pl	L_2266
L_2265
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2267
L_2268
	subs	x3, x3, x5
	b.pl	L_2268
L_2267
	add	x9, x2, x9, lsl #2
	ld1	{ v11.s }[0], [x8]
	ld1	{ v11.s }[1], [x9]
	umov	x30, v16.d[0]
	uzp1	v16.8b, v8.8b, v9.8b
	uzp2	v9.8b, v8.8b, v9.8b
	mov	v8.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v10.8b, v11.8b
	uzp2	v11.8b, v10.8b, v11.8b
	mov	v10.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v9.8b, v11.8b
	uzp2	v11.8b, v9.8b, v11.8b
	mov	v9.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v8.8b, v10.8b
	uzp2	v10.8b, v8.8b, v10.8b
	mov	v8.8b, v16.8b
	mov	v16.d[0], x30
	ld1	{ v24.8b }, [x6], #8
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v24.8b, v9.8b
	umull	v2.8h, v24.8b, v10.8b
	umull	v3.8h, v24.8b, v11.8b
	mov	v4.d[1], v5.d[0]
	shrn	v25.8b, v4.8h, #8
	shrn	v26.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	urshr	v17.8h, v0.8h, #8
	urshr	v18.8h, v1.8h, #8
	urshr	v19.8h, v2.8h, #8
	urshr	v20.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v17.8h
	raddhn	v1.8b, v1.8h, v18.8h
	raddhn	v2.8b, v2.8h, v19.8h
	raddhn	v3.8b, v3.8h, v20.8h
	sri	v25.8b, v25.8b, #5
	sri	v26.8b, v26.8b, #6
	mvn	v3.8b, v3.8b
	shrn	v30.8b, v4.8h, #2
	umull	v18.8h, v3.8b, v25.8b
	umull	v19.8h, v3.8b, v26.8b
	umull	v20.8h, v3.8b, v30.8b
	subs	x0, x0, #8
	b.lt	L_2269
L_2270
	urshr	v5.8h, v18.8h, #8
	urshr	v6.8h, v19.8h, #8
	urshr	v7.8h, v20.8h, #8
	raddhn	v17.8b, v18.8h, v5.8h
	raddhn	v19.8b, v19.8h, v6.8h
	raddhn	v18.8b, v20.8h, v7.8h
	uqadd	v5.8b, v2.8b, v17.8b
	uqadd	v6.8b, v0.8b, v18.8b
	uqadd	v7.8b, v1.8b, v19.8b
	ushll	v14.8h, v5.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v7.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v6.8b, #7
	sli	v19.8h, v19.8h, #1
	sri	v14.8h, v18.8h, #5
	sri	v14.8h, v19.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x1], #16
	ld1	{ v4.4h, v5.4h }, [x10], #16
	ld1	{ v24.8b }, [x6], #8
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2271
L_2272
	subs	x3, x3, x5
	b.pl	L_2272
L_2271
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2273
L_2274
	subs	x3, x3, x5
	b.pl	L_2274
L_2273
	add	x9, x2, x9, lsl #2
	ld1	{ v8.s }[0], [x8]
	ld1	{ v8.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2275
L_2276
	subs	x3, x3, x5
	b.pl	L_2276
L_2275
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2277
L_2278
	subs	x3, x3, x5
	b.pl	L_2278
L_2277
	add	x9, x2, x9, lsl #2
	ld1	{ v9.s }[0], [x8]
	ld1	{ v9.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2279
L_2280
	subs	x3, x3, x5
	b.pl	L_2280
L_2279
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2281
L_2282
	subs	x3, x3, x5
	b.pl	L_2282
L_2281
	add	x9, x2, x9, lsl #2
	ld1	{ v10.s }[0], [x8]
	ld1	{ v10.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2283
L_2284
	subs	x3, x3, x5
	b.pl	L_2284
L_2283
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2285
L_2286
	subs	x3, x3, x5
	b.pl	L_2286
L_2285
	add	x9, x2, x9, lsl #2
	ld1	{ v11.s }[0], [x8]
	ld1	{ v11.s }[1], [x9]
	umov	x30, v16.d[0]
	uzp1	v16.8b, v8.8b, v9.8b
	uzp2	v9.8b, v8.8b, v9.8b
	mov	v8.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v10.8b, v11.8b
	uzp2	v11.8b, v10.8b, v11.8b
	mov	v10.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v9.8b, v11.8b
	uzp2	v11.8b, v9.8b, v11.8b
	mov	v9.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v8.8b, v10.8b
	uzp2	v10.8b, v8.8b, v10.8b
	mov	v8.8b, v16.8b
	mov	v16.d[0], x30
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v24.8b, v9.8b
	umull	v2.8h, v24.8b, v10.8b
	umull	v3.8h, v24.8b, v11.8b
	mov	v4.d[1], v5.d[0]
	shrn	v25.8b, v4.8h, #8
	shrn	v26.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	urshr	v17.8h, v0.8h, #8
	urshr	v18.8h, v1.8h, #8
	urshr	v19.8h, v2.8h, #8
	urshr	v20.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v17.8h
	raddhn	v1.8b, v1.8h, v18.8h
	raddhn	v2.8b, v2.8h, v19.8h
	raddhn	v3.8b, v3.8h, v20.8h
	sri	v25.8b, v25.8b, #5
	sri	v26.8b, v26.8b, #6
	mvn	v3.8b, v3.8b
	shrn	v30.8b, v4.8h, #2
	umull	v18.8h, v3.8b, v25.8b
	umull	v19.8h, v3.8b, v26.8b
	umull	v20.8h, v3.8b, v30.8b
	subs	x0, x0, #8
	b.ge	L_2270
L_2269
	urshr	v5.8h, v18.8h, #8
	urshr	v6.8h, v19.8h, #8
	urshr	v7.8h, v20.8h, #8
	raddhn	v17.8b, v18.8h, v5.8h
	raddhn	v19.8b, v19.8h, v6.8h
	raddhn	v18.8b, v20.8h, v7.8h
	uqadd	v5.8b, v2.8b, v17.8b
	uqadd	v6.8b, v0.8b, v18.8b
	uqadd	v7.8b, v1.8b, v19.8b
	ushll	v14.8h, v5.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v7.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v6.8b, #7
	sli	v19.8h, v19.8h, #1
	sri	v14.8h, v18.8h, #5
	sri	v14.8h, v19.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x1], #16
L_2252
	tst	x0, #0x7
	b.eq	L_2287
	tst	x0, #0x4
	b.eq	L_2288
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2289
L_2290
	subs	x3, x3, x5
	b.pl	L_2290
L_2289
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2291
L_2292
	subs	x3, x3, x5
	b.pl	L_2292
L_2291
	add	x9, x2, x9, lsl #2
	ld1	{ v10.s }[0], [x8]
	ld1	{ v10.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2293
L_2294
	subs	x3, x3, x5
	b.pl	L_2294
L_2293
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2295
L_2296
	subs	x3, x3, x5
	b.pl	L_2296
L_2295
	add	x9, x2, x9, lsl #2
	ld1	{ v11.s }[0], [x8]
	ld1	{ v11.s }[1], [x9]
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	ld1	{ v5.4h }, [x10], #8
L_2288
	tst	x0, #0x2
	b.eq	L_2297
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2298
L_2299
	subs	x3, x3, x5
	b.pl	L_2299
L_2298
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2300
L_2301
	subs	x3, x3, x5
	b.pl	L_2301
L_2300
	add	x9, x2, x9, lsl #2
	ld1	{ v9.s }[0], [x8]
	ld1	{ v9.s }[1], [x9]
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	ld1	{ v4.h }[2], [x10], #2
	ld1	{ v4.h }[3], [x10], #2
L_2297
	tst	x0, #0x1
	b.eq	L_2302
	asr	x30, x3, #16
	mov	x8, x30
	adds	x3, x3, x4
	b.mi	L_2303
L_2304
	subs	x3, x3, x5
	b.pl	L_2304
L_2303
	add	x8, x2, x8, lsl #2
	ld1	{ v8.s }[1], [x8]
	ld1	{ v24.b }[1], [x6], #1
	ld1	{ v4.h }[1], [x10], #2
L_2302
	umov	x30, v16.d[0]
	uzp1	v16.8b, v8.8b, v9.8b
	uzp2	v9.8b, v8.8b, v9.8b
	mov	v8.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v10.8b, v11.8b
	uzp2	v11.8b, v10.8b, v11.8b
	mov	v10.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v9.8b, v11.8b
	uzp2	v11.8b, v9.8b, v11.8b
	mov	v9.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v8.8b, v10.8b
	uzp2	v10.8b, v8.8b, v10.8b
	mov	v8.8b, v16.8b
	mov	v16.d[0], x30
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v24.8b, v9.8b
	umull	v2.8h, v24.8b, v10.8b
	umull	v3.8h, v24.8b, v11.8b
	mov	v4.d[1], v5.d[0]
	shrn	v25.8b, v4.8h, #8
	shrn	v26.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	urshr	v17.8h, v0.8h, #8
	urshr	v18.8h, v1.8h, #8
	urshr	v19.8h, v2.8h, #8
	urshr	v20.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v17.8h
	raddhn	v1.8b, v1.8h, v18.8h
	raddhn	v2.8b, v2.8h, v19.8h
	raddhn	v3.8b, v3.8h, v20.8h
	sri	v25.8b, v25.8b, #5
	sri	v26.8b, v26.8b, #6
	mvn	v3.8b, v3.8b
	shrn	v30.8b, v4.8h, #2
	umull	v18.8h, v3.8b, v25.8b
	umull	v19.8h, v3.8b, v26.8b
	umull	v20.8h, v3.8b, v30.8b
	urshr	v5.8h, v18.8h, #8
	urshr	v6.8h, v19.8h, #8
	urshr	v7.8h, v20.8h, #8
	raddhn	v17.8b, v18.8h, v5.8h
	raddhn	v19.8b, v19.8h, v6.8h
	raddhn	v18.8b, v20.8h, v7.8h
	uqadd	v5.8b, v2.8b, v17.8b
	uqadd	v6.8b, v0.8b, v18.8b
	uqadd	v7.8b, v1.8b, v19.8b
	ushll	v14.8h, v5.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v7.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v6.8b, #7
	sli	v19.8h, v19.8h, #1
	sri	v14.8h, v18.8h, #5
	sri	v14.8h, v19.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_2305
	st1	{ v29.4h }, [x1], #8
L_2305
	tst	x0, #0x2
	b.eq	L_2306
	st1	{ v28.s }[1], [x1], #4
L_2306
	tst	x0, #0x1
	b.eq	L_2307
	st1	{ v28.h }[1], [x1], #2
L_2307
L_2287
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldur	x10, [x29, #-96]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_2228
	tst	x0, #0x7
	b.eq	L_2308
	tst	x0, #0x4
	b.eq	L_2309
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2310
L_2311
	subs	x3, x3, x5
	b.pl	L_2311
L_2310
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2312
L_2313
	subs	x3, x3, x5
	b.pl	L_2313
L_2312
	add	x9, x2, x9, lsl #2
	ld1	{ v10.s }[0], [x8]
	ld1	{ v10.s }[1], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2314
L_2315
	subs	x3, x3, x5
	b.pl	L_2315
L_2314
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2316
L_2317
	subs	x3, x3, x5
	b.pl	L_2317
L_2316
	add	x9, x2, x9, lsl #2
	ld1	{ v11.s }[0], [x8]
	ld1	{ v11.s }[1], [x9]
	ld1	{ v24.b }[4], [x6], #1
	ld1	{ v24.b }[5], [x6], #1
	ld1	{ v24.b }[6], [x6], #1
	ld1	{ v24.b }[7], [x6], #1
	ld1	{ v5.4h }, [x10], #8
L_2309
	tst	x0, #0x2
	b.eq	L_2318
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2319
L_2320
	subs	x3, x3, x5
	b.pl	L_2320
L_2319
	add	x8, x2, x8, lsl #2
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2321
L_2322
	subs	x3, x3, x5
	b.pl	L_2322
L_2321
	add	x9, x2, x9, lsl #2
	ld1	{ v9.s }[0], [x8]
	ld1	{ v9.s }[1], [x9]
	ld1	{ v24.b }[2], [x6], #1
	ld1	{ v24.b }[3], [x6], #1
	ld1	{ v4.h }[2], [x10], #2
	ld1	{ v4.h }[3], [x10], #2
L_2318
	tst	x0, #0x1
	b.eq	L_2323
	asr	x30, x3, #16
	mov	x8, x30
	adds	x3, x3, x4
	b.mi	L_2324
L_2325
	subs	x3, x3, x5
	b.pl	L_2325
L_2324
	add	x8, x2, x8, lsl #2
	ld1	{ v8.s }[1], [x8]
	ld1	{ v24.b }[1], [x6], #1
	ld1	{ v4.h }[1], [x10], #2
L_2323
	umov	x30, v16.d[0]
	uzp1	v16.8b, v8.8b, v9.8b
	uzp2	v9.8b, v8.8b, v9.8b
	mov	v8.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v10.8b, v11.8b
	uzp2	v11.8b, v10.8b, v11.8b
	mov	v10.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v9.8b, v11.8b
	uzp2	v11.8b, v9.8b, v11.8b
	mov	v9.8b, v16.8b
	mov	v16.d[0], x30
	umov	x30, v16.d[0]
	uzp1	v16.8b, v8.8b, v10.8b
	uzp2	v10.8b, v8.8b, v10.8b
	mov	v8.8b, v16.8b
	mov	v16.d[0], x30
	umull	v0.8h, v24.8b, v8.8b
	umull	v1.8h, v24.8b, v9.8b
	umull	v2.8h, v24.8b, v10.8b
	umull	v3.8h, v24.8b, v11.8b
	mov	v4.d[1], v5.d[0]
	shrn	v25.8b, v4.8h, #8
	shrn	v26.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	urshr	v17.8h, v0.8h, #8
	urshr	v18.8h, v1.8h, #8
	urshr	v19.8h, v2.8h, #8
	urshr	v20.8h, v3.8h, #8
	raddhn	v0.8b, v0.8h, v17.8h
	raddhn	v1.8b, v1.8h, v18.8h
	raddhn	v2.8b, v2.8h, v19.8h
	raddhn	v3.8b, v3.8h, v20.8h
	sri	v25.8b, v25.8b, #5
	sri	v26.8b, v26.8b, #6
	mvn	v3.8b, v3.8b
	shrn	v30.8b, v4.8h, #2
	umull	v18.8h, v3.8b, v25.8b
	umull	v19.8h, v3.8b, v26.8b
	umull	v20.8h, v3.8b, v30.8b
	urshr	v5.8h, v18.8h, #8
	urshr	v6.8h, v19.8h, #8
	urshr	v7.8h, v20.8h, #8
	raddhn	v17.8b, v18.8h, v5.8h
	raddhn	v19.8b, v19.8h, v6.8h
	raddhn	v18.8b, v20.8h, v7.8h
	uqadd	v5.8b, v2.8b, v17.8b
	uqadd	v6.8b, v0.8b, v18.8b
	uqadd	v7.8b, v1.8b, v19.8b
	ushll	v14.8h, v5.8b, #7
	sli	v14.8h, v14.8h, #1
	ushll	v18.8h, v7.8b, #7
	sli	v18.8h, v18.8h, #1
	ushll	v19.8h, v6.8b, #7
	sli	v19.8h, v19.8h, #1
	sri	v14.8h, v18.8h, #5
	sri	v14.8h, v19.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_2326
	st1	{ v29.4h }, [x1], #8
L_2326
	tst	x0, #0x2
	b.eq	L_2327
	st1	{ v28.h }[2], [x1], #2
	st1	{ v28.h }[3], [x1], #2
L_2327
	tst	x0, #0x1
	b.eq	L_2328
	st1	{ v28.h }[1], [x1], #2
L_2328
L_2308
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldur	x10, [x29, #-88]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon
pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon
	sxtw	x0, w0
	sxtw	x3, w3
	sxtw	x4, w4
	sxtw	x5, w5
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #88
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stur	x10, [x29, #-88]
	mov	x10, x1
	cmp	x0, #8
	b.lt	L_2329
	tst	x10, #0xf
	b.eq	L_2330
	tst	x10, #0x2
	b.eq	L_2331
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2332
L_2333
	subs	x3, x3, x5
	b.pl	L_2333
L_2332
	add	x8, x2, x8, lsl #1
	ld1	{ v8.h }[1], [x8]
	ld1	{ v15.b }[1], [x6], #1
	ld1	{ v10.h }[1], [x10], #2
	sub	x0, x0, #1
L_2331
	tst	x10, #0x4
	b.eq	L_2334
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2335
L_2336
	subs	x3, x3, x5
	b.pl	L_2336
L_2335
	add	x8, x2, x8, lsl #1
	ld1	{ v8.h }[2], [x8]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2337
L_2338
	subs	x3, x3, x5
	b.pl	L_2338
L_2337
	add	x8, x2, x8, lsl #1
	ld1	{ v8.h }[3], [x8]
	ld1	{ v15.b }[2], [x6], #1
	ld1	{ v15.b }[3], [x6], #1
	ld1	{ v10.h }[2], [x10], #2
	ld1	{ v10.h }[3], [x10], #2
	sub	x0, x0, #2
L_2334
	tst	x10, #0x8
	b.eq	L_2339
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2340
L_2341
	subs	x3, x3, x5
	b.pl	L_2341
L_2340
	add	x8, x2, x8, lsl #1
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2342
L_2343
	subs	x3, x3, x5
	b.pl	L_2343
L_2342
	add	x9, x2, x9, lsl #1
	ld1	{ v9.h }[0], [x8]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2344
L_2345
	subs	x3, x3, x5
	b.pl	L_2345
L_2344
	add	x8, x2, x8, lsl #1
	ld1	{ v9.h }[1], [x9]
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2346
L_2347
	subs	x3, x3, x5
	b.pl	L_2347
L_2346
	add	x9, x2, x9, lsl #1
	ld1	{ v9.h }[2], [x8]
	ld1	{ v9.h }[3], [x9]
	ld1	{ v15.b }[4], [x6], #1
	ld1	{ v15.b }[5], [x6], #1
	ld1	{ v15.b }[6], [x6], #1
	ld1	{ v15.b }[7], [x6], #1
	ld1	{ v11.4h }, [x10], #8
	sub	x0, x0, #4
L_2339
	mov	v4.d[0], v8.d[0]
	mov	v4.d[1], v9.d[0]
	mov	v13.d[0], v10.d[0]
	mov	v13.d[1], v11.d[0]
	shrn	v2.8b, v4.8h, #8
	shrn	v1.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v2.8b, v2.8b, #5
	sri	v1.8b, v1.8b, #6
	shrn	v0.8b, v4.8h, #2
	shrn	v6.8b, v13.8h, #8
	shrn	v5.8b, v13.8h, #3
	sli	v13.8h, v13.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v13.8h, #2
	mvn	v7.8b, v15.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	umull	v11.8h, v7.8b, v4.8b
	umull	v12.8h, v7.8b, v5.8b
	umull	v13.8h, v7.8b, v6.8b
	urshr	v19.8h, v10.8h, #8
	urshr	v18.8h, v9.8h, #8
	urshr	v17.8h, v8.8h, #8
	raddhn	v2.8b, v10.8h, v19.8h
	raddhn	v1.8b, v9.8h, v18.8h
	raddhn	v0.8b, v8.8h, v17.8h
L_2348
L_2349
	urshr	v17.8h, v11.8h, #8
	urshr	v18.8h, v12.8h, #8
	urshr	v19.8h, v13.8h, #8
	raddhn	v28.8b, v17.8h, v11.8h
	raddhn	v29.8b, v18.8h, v12.8h
	raddhn	v30.8b, v19.8h, v13.8h
	uqadd	v0.8b, v0.8b, v28.8b
	uqadd	v1.8b, v1.8b, v29.8b
	uqadd	v2.8b, v2.8b, v30.8b
	ushll	v30.8h, v1.8b, #7
	shl	v30.8h, v30.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v13.8h, v0.8b, #7
	shl	v13.8h, v13.8h, #1
	sri	v14.8h, v30.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x1, #0x2
	b.eq	L_2350
	st1	{ v28.h }[1], [x1], #2
L_2350
	tst	x1, #0x4
	b.eq	L_2351
	st1	{ v28.s }[1], [x1], #4
L_2351
	tst	x1, #0x8
	b.eq	L_2352
	st1	{ v29.4h }, [x1], #8
L_2352
L_2330
	subs	x0, x0, #8
	b.lt	L_2353
	ld1	{ v10.4h, v11.4h }, [x10], #16
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2354
L_2355
	subs	x3, x3, x5
	b.pl	L_2355
L_2354
	add	x8, x2, x8, lsl #1
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2356
L_2357
	subs	x3, x3, x5
	b.pl	L_2357
L_2356
	add	x9, x2, x9, lsl #1
	ld1	{ v8.h }[0], [x8]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2358
L_2359
	subs	x3, x3, x5
	b.pl	L_2359
L_2358
	add	x8, x2, x8, lsl #1
	ld1	{ v8.h }[1], [x9]
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2360
L_2361
	subs	x3, x3, x5
	b.pl	L_2361
L_2360
	add	x9, x2, x9, lsl #1
	ld1	{ v8.h }[2], [x8]
	ld1	{ v8.h }[3], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2362
L_2363
	subs	x3, x3, x5
	b.pl	L_2363
L_2362
	add	x8, x2, x8, lsl #1
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2364
L_2365
	subs	x3, x3, x5
	b.pl	L_2365
L_2364
	add	x9, x2, x9, lsl #1
	ld1	{ v9.h }[0], [x8]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2366
L_2367
	subs	x3, x3, x5
	b.pl	L_2367
L_2366
	add	x8, x2, x8, lsl #1
	ld1	{ v9.h }[1], [x9]
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2368
L_2369
	subs	x3, x3, x5
	b.pl	L_2369
L_2368
	add	x9, x2, x9, lsl #1
	ld1	{ v9.h }[2], [x8]
	ld1	{ v9.h }[3], [x9]
	ld1	{ v15.8b }, [x6], #8
	mov	v4.d[0], v8.d[0]
	mov	v4.d[1], v9.d[0]
	mov	v13.d[0], v10.d[0]
	mov	v13.d[1], v11.d[0]
	shrn	v2.8b, v4.8h, #8
	shrn	v1.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v2.8b, v2.8b, #5
	sri	v1.8b, v1.8b, #6
	shrn	v0.8b, v4.8h, #2
	shrn	v6.8b, v13.8h, #8
	shrn	v5.8b, v13.8h, #3
	sli	v13.8h, v13.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v13.8h, #2
	mvn	v7.8b, v15.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	umull	v11.8h, v7.8b, v4.8b
	umull	v12.8h, v7.8b, v5.8b
	umull	v13.8h, v7.8b, v6.8b
	urshr	v19.8h, v10.8h, #8
	urshr	v18.8h, v9.8h, #8
	urshr	v17.8h, v8.8h, #8
	raddhn	v2.8b, v10.8h, v19.8h
	raddhn	v1.8b, v9.8h, v18.8h
	raddhn	v0.8b, v8.8h, v17.8h
	subs	x0, x0, #8
	b.lt	L_2370
L_2371
	ld1	{ v15.8b }, [x6], #8
	urshr	v17.8h, v11.8h, #8
	urshr	v18.8h, v12.8h, #8
	urshr	v19.8h, v13.8h, #8
	raddhn	v28.8b, v17.8h, v11.8h
	raddhn	v29.8b, v18.8h, v12.8h
	raddhn	v30.8b, v19.8h, v13.8h
	uqadd	v0.8b, v0.8b, v28.8b
	uqadd	v1.8b, v1.8b, v29.8b
	uqadd	v2.8b, v2.8b, v30.8b
	ushll	v30.8h, v1.8b, #7
	shl	v30.8h, v30.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v13.8h, v0.8b, #7
	shl	v13.8h, v13.8h, #1
	sri	v14.8h, v30.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2372
L_2373
	subs	x3, x3, x5
	b.pl	L_2373
L_2372
	add	x8, x2, x8, lsl #1
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2374
L_2375
	subs	x3, x3, x5
	b.pl	L_2375
L_2374
	add	x9, x2, x9, lsl #1
	ld1	{ v8.h }[0], [x8]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2376
L_2377
	subs	x3, x3, x5
	b.pl	L_2377
L_2376
	add	x8, x2, x8, lsl #1
	ld1	{ v8.h }[1], [x9]
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2378
L_2379
	subs	x3, x3, x5
	b.pl	L_2379
L_2378
	add	x9, x2, x9, lsl #1
	ld1	{ v8.h }[2], [x8]
	ld1	{ v8.h }[3], [x9]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2380
L_2381
	subs	x3, x3, x5
	b.pl	L_2381
L_2380
	add	x8, x2, x8, lsl #1
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2382
L_2383
	subs	x3, x3, x5
	b.pl	L_2383
L_2382
	add	x9, x2, x9, lsl #1
	ld1	{ v9.h }[0], [x8]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2384
L_2385
	subs	x3, x3, x5
	b.pl	L_2385
L_2384
	add	x8, x2, x8, lsl #1
	ld1	{ v9.h }[1], [x9]
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2386
L_2387
	subs	x3, x3, x5
	b.pl	L_2387
L_2386
	add	x9, x2, x9, lsl #1
	ld1	{ v9.h }[2], [x8]
	ld1	{ v9.h }[3], [x9]
	ld1	{ v10.4h, v11.4h }, [x10], #16
L_2388
L_2389
	mov	v4.d[0], v8.d[0]
	mov	v4.d[1], v9.d[0]
	mov	v13.d[0], v10.d[0]
	mov	v13.d[1], v11.d[0]
	shrn	v2.8b, v4.8h, #8
	shrn	v1.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v2.8b, v2.8b, #5
	sri	v1.8b, v1.8b, #6
	shrn	v0.8b, v4.8h, #2
	shrn	v6.8b, v13.8h, #8
	shrn	v5.8b, v13.8h, #3
	sli	v13.8h, v13.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v13.8h, #2
	mvn	v7.8b, v15.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	umull	v11.8h, v7.8b, v4.8b
	umull	v12.8h, v7.8b, v5.8b
	umull	v13.8h, v7.8b, v6.8b
	urshr	v19.8h, v10.8h, #8
	urshr	v18.8h, v9.8h, #8
	urshr	v17.8h, v8.8h, #8
	raddhn	v2.8b, v10.8h, v19.8h
	raddhn	v1.8b, v9.8h, v18.8h
	raddhn	v0.8b, v8.8h, v17.8h
	st1	{ v14.8h }, [x1], #16
	subs	x0, x0, #8
	b.ge	L_2371
L_2370
	urshr	v17.8h, v11.8h, #8
	urshr	v18.8h, v12.8h, #8
	urshr	v19.8h, v13.8h, #8
	raddhn	v28.8b, v17.8h, v11.8h
	raddhn	v29.8b, v18.8h, v12.8h
	raddhn	v30.8b, v19.8h, v13.8h
	uqadd	v0.8b, v0.8b, v28.8b
	uqadd	v1.8b, v1.8b, v29.8b
	uqadd	v2.8b, v2.8b, v30.8b
	ushll	v30.8h, v1.8b, #7
	shl	v30.8h, v30.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v13.8h, v0.8b, #7
	shl	v13.8h, v13.8h, #1
	sri	v14.8h, v30.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	st1	{ v28.4h, v29.4h }, [x1], #16
L_2353
	tst	x0, #0x7
	b.eq	L_2390
	tst	x0, #0x4
	b.eq	L_2391
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2392
L_2393
	subs	x3, x3, x5
	b.pl	L_2393
L_2392
	add	x8, x2, x8, lsl #1
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2394
L_2395
	subs	x3, x3, x5
	b.pl	L_2395
L_2394
	add	x9, x2, x9, lsl #1
	ld1	{ v9.h }[0], [x8]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2396
L_2397
	subs	x3, x3, x5
	b.pl	L_2397
L_2396
	add	x8, x2, x8, lsl #1
	ld1	{ v9.h }[1], [x9]
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2398
L_2399
	subs	x3, x3, x5
	b.pl	L_2399
L_2398
	add	x9, x2, x9, lsl #1
	ld1	{ v9.h }[2], [x8]
	ld1	{ v9.h }[3], [x9]
	ld1	{ v15.b }[4], [x6], #1
	ld1	{ v15.b }[5], [x6], #1
	ld1	{ v15.b }[6], [x6], #1
	ld1	{ v15.b }[7], [x6], #1
	ld1	{ v11.4h }, [x10], #8
L_2391
	tst	x0, #0x2
	b.eq	L_2400
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2401
L_2402
	subs	x3, x3, x5
	b.pl	L_2402
L_2401
	add	x8, x2, x8, lsl #1
	ld1	{ v8.h }[2], [x8]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2403
L_2404
	subs	x3, x3, x5
	b.pl	L_2404
L_2403
	add	x8, x2, x8, lsl #1
	ld1	{ v8.h }[3], [x8]
	ld1	{ v15.b }[2], [x6], #1
	ld1	{ v15.b }[3], [x6], #1
	ld1	{ v10.h }[2], [x10], #2
	ld1	{ v10.h }[3], [x10], #2
L_2400
	tst	x0, #0x1
	b.eq	L_2405
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2406
L_2407
	subs	x3, x3, x5
	b.pl	L_2407
L_2406
	add	x8, x2, x8, lsl #1
	ld1	{ v8.h }[1], [x8]
	ld1	{ v15.b }[1], [x6], #1
	ld1	{ v10.h }[1], [x10], #2
L_2405
	mov	v4.d[0], v8.d[0]
	mov	v4.d[1], v9.d[0]
	mov	v13.d[0], v10.d[0]
	mov	v13.d[1], v11.d[0]
	shrn	v2.8b, v4.8h, #8
	shrn	v1.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v2.8b, v2.8b, #5
	sri	v1.8b, v1.8b, #6
	shrn	v0.8b, v4.8h, #2
	shrn	v6.8b, v13.8h, #8
	shrn	v5.8b, v13.8h, #3
	sli	v13.8h, v13.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v13.8h, #2
	mvn	v7.8b, v15.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	umull	v11.8h, v7.8b, v4.8b
	umull	v12.8h, v7.8b, v5.8b
	umull	v13.8h, v7.8b, v6.8b
	urshr	v19.8h, v10.8h, #8
	urshr	v18.8h, v9.8h, #8
	urshr	v17.8h, v8.8h, #8
	raddhn	v2.8b, v10.8h, v19.8h
	raddhn	v1.8b, v9.8h, v18.8h
	raddhn	v0.8b, v8.8h, v17.8h
	urshr	v17.8h, v11.8h, #8
	urshr	v18.8h, v12.8h, #8
	urshr	v19.8h, v13.8h, #8
	raddhn	v28.8b, v17.8h, v11.8h
	raddhn	v29.8b, v18.8h, v12.8h
	raddhn	v30.8b, v19.8h, v13.8h
	uqadd	v0.8b, v0.8b, v28.8b
	uqadd	v1.8b, v1.8b, v29.8b
	uqadd	v2.8b, v2.8b, v30.8b
	ushll	v30.8h, v1.8b, #7
	shl	v30.8h, v30.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v13.8h, v0.8b, #7
	shl	v13.8h, v13.8h, #1
	sri	v14.8h, v30.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_2408
	st1	{ v29.4h }, [x1], #8
L_2408
	tst	x0, #0x2
	b.eq	L_2409
	st1	{ v28.s }[1], [x1], #4
L_2409
	tst	x0, #0x1
	b.eq	L_2410
	st1	{ v28.h }[1], [x1], #2
L_2410
L_2390
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldur	x10, [x29, #-96]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
L_2329
	tst	x0, #0x7
	b.eq	L_2411
	tst	x0, #0x4
	b.eq	L_2412
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2413
L_2414
	subs	x3, x3, x5
	b.pl	L_2414
L_2413
	add	x8, x2, x8, lsl #1
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2415
L_2416
	subs	x3, x3, x5
	b.pl	L_2416
L_2415
	add	x9, x2, x9, lsl #1
	ld1	{ v9.h }[0], [x8]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2417
L_2418
	subs	x3, x3, x5
	b.pl	L_2418
L_2417
	add	x8, x2, x8, lsl #1
	ld1	{ v9.h }[1], [x9]
	asr	x9, x3, #16
	adds	x3, x3, x4
	b.mi	L_2419
L_2420
	subs	x3, x3, x5
	b.pl	L_2420
L_2419
	add	x9, x2, x9, lsl #1
	ld1	{ v9.h }[2], [x8]
	ld1	{ v9.h }[3], [x9]
	ld1	{ v15.b }[4], [x6], #1
	ld1	{ v15.b }[5], [x6], #1
	ld1	{ v15.b }[6], [x6], #1
	ld1	{ v15.b }[7], [x6], #1
	ld1	{ v11.4h }, [x10], #8
L_2412
	tst	x0, #0x2
	b.eq	L_2421
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2422
L_2423
	subs	x3, x3, x5
	b.pl	L_2423
L_2422
	add	x8, x2, x8, lsl #1
	ld1	{ v8.h }[2], [x8]
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2424
L_2425
	subs	x3, x3, x5
	b.pl	L_2425
L_2424
	add	x8, x2, x8, lsl #1
	ld1	{ v8.h }[3], [x8]
	ld1	{ v15.b }[2], [x6], #1
	ld1	{ v15.b }[3], [x6], #1
	ld1	{ v10.h }[2], [x10], #2
	ld1	{ v10.h }[3], [x10], #2
L_2421
	tst	x0, #0x1
	b.eq	L_2426
	asr	x8, x3, #16
	adds	x3, x3, x4
	b.mi	L_2427
L_2428
	subs	x3, x3, x5
	b.pl	L_2428
L_2427
	add	x8, x2, x8, lsl #1
	ld1	{ v8.h }[1], [x8]
	ld1	{ v15.b }[1], [x6], #1
	ld1	{ v10.h }[1], [x10], #2
L_2426
	mov	v4.d[0], v8.d[0]
	mov	v4.d[1], v9.d[0]
	mov	v13.d[0], v10.d[0]
	mov	v13.d[1], v11.d[0]
	shrn	v2.8b, v4.8h, #8
	shrn	v1.8b, v4.8h, #3
	sli	v4.8h, v4.8h, #5
	sri	v2.8b, v2.8b, #5
	sri	v1.8b, v1.8b, #6
	shrn	v0.8b, v4.8h, #2
	shrn	v6.8b, v13.8h, #8
	shrn	v5.8b, v13.8h, #3
	sli	v13.8h, v13.8h, #5
	sri	v6.8b, v6.8b, #5
	sri	v5.8b, v5.8b, #6
	shrn	v4.8b, v13.8h, #2
	mvn	v7.8b, v15.8b
	umull	v10.8h, v15.8b, v2.8b
	umull	v9.8h, v15.8b, v1.8b
	umull	v8.8h, v15.8b, v0.8b
	umull	v11.8h, v7.8b, v4.8b
	umull	v12.8h, v7.8b, v5.8b
	umull	v13.8h, v7.8b, v6.8b
	urshr	v19.8h, v10.8h, #8
	urshr	v18.8h, v9.8h, #8
	urshr	v17.8h, v8.8h, #8
	raddhn	v2.8b, v10.8h, v19.8h
	raddhn	v1.8b, v9.8h, v18.8h
	raddhn	v0.8b, v8.8h, v17.8h
	urshr	v17.8h, v11.8h, #8
	urshr	v18.8h, v12.8h, #8
	urshr	v19.8h, v13.8h, #8
	raddhn	v28.8b, v17.8h, v11.8h
	raddhn	v29.8b, v18.8h, v12.8h
	raddhn	v30.8b, v19.8h, v13.8h
	uqadd	v0.8b, v0.8b, v28.8b
	uqadd	v1.8b, v1.8b, v29.8b
	uqadd	v2.8b, v2.8b, v30.8b
	ushll	v30.8h, v1.8b, #7
	shl	v30.8h, v30.8h, #1
	ushll	v14.8h, v2.8b, #7
	shl	v14.8h, v14.8h, #1
	ushll	v13.8h, v0.8b, #7
	shl	v13.8h, v13.8h, #1
	sri	v14.8h, v30.8h, #5
	sri	v14.8h, v13.8h, #11
	mov	v28.d[0], v14.d[0]
	mov	v29.d[0], v14.d[1]
	tst	x0, #0x4
	b.eq	L_2429
	st1	{ v29.4h }, [x1], #8
L_2429
	tst	x0, #0x2
	b.eq	L_2430
	st1	{ v28.h }[2], [x1], #2
	st1	{ v28.h }[3], [x1], #2
L_2430
	tst	x0, #0x1
	b.eq	L_2431
	st1	{ v28.h }[1], [x1], #2
L_2431
L_2411
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldur	x10, [x29, #-88]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_scaled_bilinear_scanline_8888_8888_SRC_asm_neon
pixman_scaled_bilinear_scanline_8888_8888_SRC_asm_neon
	sxtw	x3, w3
	sxtw	x4, w4
	sxtw	x5, w5
	sxtw	x6, w6
	sxtw	x7, w7
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #112
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	mov	x10, #28
	mul	x10, x10, x6
	subs	x13, x2, x1
	cmp	x7, #0
	b.le	L_2432
	dup	v12.8h, w5
	dup	v13.8h, w6
	dup	v28.8b, w3
	dup	v29.8b, w4
	mov	v25.d[0], v12.d[1]
	mov	v26.d[0], v13.d[0]
	add	v25.4h, v25.4h, v26.4h
	mov	v12.d[1], v25.d[0]
	cmp	x7, #1
	b.lt	L_2433
	tst	x0, #0x4
	b.eq	L_2433
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v0.2s }, [x8], x13
	ld1	{ v1.2s }, [x8]
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	st1	{ v0.s }[0], [x0], #4
	sub	x7, x7, #1
L_2433
	add	v13.8h, v13.8h, v13.8h
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	cmp	x7, #2
	b.lt	L_2434
	tst	x0, #0x8
	b.eq	L_2434
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v2.2s }, [x8], x13
	ld1	{ v3.2s }, [x8]
	umull	v1.8h, v2.8b, v28.8b
	umlal	v1.8h, v3.8b, v29.8b
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v20.2s }, [x8], x13
	ld1	{ v21.2s }, [x8]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
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
	st1	{ v0.2s }, [x0], #8
	sub	x7, x7, #2
L_2434
	subs	x7, x7, #4
	b.lt	L_2435
	asr	x10, x10, #14
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	asr	x9, x5, #16
	add	x5, x5, x6
	add	x9, x1, x9, lsl #2
	ld1	{ v22.2s }, [x8], x13
	ld1	{ v23.2s }, [x8]
	asr	x11, x5, #16
	add	x5, x5, x6
	add	x11, x1, x11, lsl #2
	umull	v8.8h, v22.8b, v28.8b
	umlal	v8.8h, v23.8b, v29.8b
	ld1	{ v22.2s }, [x9], x13
	ld1	{ v23.2s }, [x9]
	asr	x12, x5, #16
	add	x5, x5, x6
	add	x12, x1, x12, lsl #2
	umull	v9.8h, v22.8b, v28.8b
	umlal	v9.8h, v23.8b, v29.8b
	ld1	{ v22.2s }, [x11], x13
	ld1	{ v23.2s }, [x11]
	umull	v10.8h, v22.8b, v28.8b
	umlal	v10.8h, v23.8b, v29.8b
	ushll	v0.4s, v8.4h, #7
	umlsl	v0.4s, v8.4h, v15.h[0]
	umlal2	v0.4s, v8.8h, v15.h[0]
	prfm	pldl1keep, [x12, x10]
	ld1	{ v16.2s }, [x12], x13
	ld1	{ v17.2s }, [x12]
	prfm	pldl1keep, [x12, x10]
	umull	v11.8h, v16.8b, v28.8b
	umlal	v11.8h, v17.8b, v29.8b
	ushll	v1.4s, v9.4h, #7
	umlsl	v1.4s, v9.4h, v15.h[4]
	subs	x7, x7, #4
	b.lt	L_2436
L_2437
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	asr	x9, x5, #16
	add	x5, x5, x6
	add	x9, x1, x9, lsl #2
	umlal2	v1.4s, v9.8h, v15.h[4]
	ushr	v15.8h, v12.8h, #9
	ushll	v2.4s, v10.4h, #7
	umlsl	v2.4s, v10.4h, v15.h[0]
	umlal2	v2.4s, v10.8h, v15.h[0]
	ushll	v3.4s, v11.4h, #7
	ld1	{ v20.2s }, [x8], x13
	umlsl	v3.4s, v11.4h, v15.h[4]
	umlal2	v3.4s, v11.8h, v15.h[4]
	ld1	{ v21.2s }, [x8]
	umull	v8.8h, v20.8b, v28.8b
	umlal	v8.8h, v21.8b, v29.8b
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v1.4s, #14
	shrn	v4.4h, v2.4s, #14
	ld1	{ v22.2s }, [x9], x13
	shrn2	v4.8h, v3.4s, #14
	add	v12.8h, v12.8h, v13.8h
	ld1	{ v23.2s }, [x9]
	umull	v9.8h, v22.8b, v28.8b
	asr	x11, x5, #16
	add	x5, x5, x6
	add	x11, x1, x11, lsl #2
	asr	x12, x5, #16
	add	x5, x5, x6
	add	x12, x1, x12, lsl #2
	umlal	v9.8h, v23.8b, v29.8b
	ld1	{ v22.2s }, [x11], x13
	ushr	v15.8h, v12.8h, #9
	ld1	{ v23.2s }, [x11]
	umull	v10.8h, v22.8b, v28.8b
	umlal	v10.8h, v23.8b, v29.8b
	xtn	v6.8b, v0.8h
	ushll	v0.4s, v8.4h, #7
	xtn	v7.8b, v4.8h
	umlsl	v0.4s, v8.4h, v15.h[0]
	umlal2	v0.4s, v8.8h, v15.h[0]
	prfm	pldl1keep, [x12, x10]
	ld1	{ v16.2s }, [x12], x13
	add	v12.8h, v12.8h, v13.8h
	ld1	{ v17.2s }, [x12]
	prfm	pldl1keep, [x12, x10]
	umull	v11.8h, v16.8b, v28.8b
	umlal	v11.8h, v17.8b, v29.8b
	st1	{ v6.2s, v7.2s }, [x0], #16
	ushll	v1.4s, v9.4h, #7
	umlsl	v1.4s, v9.4h, v15.h[4]
	subs	x7, x7, #4
	b.ge	L_2437
L_2436
	umlal2	v1.4s, v9.8h, v15.h[4]
	ushr	v15.8h, v12.8h, #9
	ushll	v2.4s, v10.4h, #7
	umlsl	v2.4s, v10.4h, v15.h[0]
	umlal2	v2.4s, v10.8h, v15.h[0]
	ushll	v3.4s, v11.4h, #7
	umlsl	v3.4s, v11.4h, v15.h[4]
	umlal2	v3.4s, v11.8h, v15.h[4]
	add	v12.8h, v12.8h, v13.8h
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v1.4s, #14
	shrn	v2.4h, v2.4s, #14
	ushr	v15.8h, v12.8h, #9
	shrn2	v2.8h, v3.4s, #14
	xtn	v6.8b, v0.8h
	xtn	v7.8b, v2.8h
	add	v12.8h, v12.8h, v13.8h
	st1	{ v6.2s, v7.2s }, [x0], #16
L_2435
	tst	x7, #0x2
	b.eq	L_2438
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v2.2s }, [x8], x13
	ld1	{ v3.2s }, [x8]
	umull	v1.8h, v2.8b, v28.8b
	umlal	v1.8h, v3.8b, v29.8b
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v20.2s }, [x8], x13
	ld1	{ v21.2s }, [x8]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
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
	st1	{ v0.2s }, [x0], #8
L_2438
	tst	x7, #0x1
	b.eq	L_2432
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v0.2s }, [x8], x13
	ld1	{ v1.2s }, [x8]
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	st1	{ v0.s }[0], [x0], #4
L_2432
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-104]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_scaled_bilinear_scanline_8888_0565_SRC_asm_neon
pixman_scaled_bilinear_scanline_8888_0565_SRC_asm_neon
	sxtw	x3, w3
	sxtw	x4, w4
	sxtw	x5, w5
	sxtw	x6, w6
	sxtw	x7, w7
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #112
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	mov	x10, #28
	mul	x10, x10, x6
	subs	x13, x2, x1
	cmp	x7, #0
	b.le	L_2439
	dup	v12.8h, w5
	dup	v13.8h, w6
	dup	v28.8b, w3
	dup	v29.8b, w4
	mov	v25.d[0], v12.d[1]
	mov	v26.d[0], v13.d[0]
	add	v25.4h, v25.4h, v26.4h
	mov	v12.d[1], v25.d[0]
	cmp	x7, #1
	b.lt	L_2440
	tst	x0, #0x2
	b.eq	L_2440
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v0.2s }, [x8], x13
	ld1	{ v1.2s }, [x8]
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	ushll	v3.8h, v1.8b, #7
	shl	v3.8h, v3.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v4.8h, v0.8b, #7
	shl	v4.8h, v4.8h, #1
	sri	v1.8h, v3.8h, #5
	sri	v1.8h, v4.8h, #11
	st1	{ v1.h }[0], [x0], #2
	sub	x7, x7, #1
L_2440
	add	v13.8h, v13.8h, v13.8h
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	cmp	x7, #2
	b.lt	L_2441
	tst	x0, #0x4
	b.eq	L_2441
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v2.2s }, [x8], x13
	ld1	{ v3.2s }, [x8]
	umull	v1.8h, v2.8b, v28.8b
	umlal	v1.8h, v3.8b, v29.8b
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v20.2s }, [x8], x13
	ld1	{ v21.2s }, [x8]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
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
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	ushll	v3.8h, v1.8b, #7
	shl	v3.8h, v3.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v4.8h, v0.8b, #7
	shl	v4.8h, v4.8h, #1
	sri	v1.8h, v3.8h, #5
	sri	v1.8h, v4.8h, #11
	st1	{ v1.s }[0], [x0], #4
	sub	x7, x7, #2
L_2441
	cmp	x7, #4
	b.lt	L_2442
	tst	x0, #0x8
	b.eq	L_2442
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v14.2s }, [x8], x13
	ld1	{ v20.2s }, [x8]
	umull	v1.8h, v14.8b, v28.8b
	umlal	v1.8h, v20.8b, v29.8b
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v16.2s }, [x8], x13
	ld1	{ v17.2s }, [x8]
	umull	v11.8h, v16.8b, v28.8b
	umlal	v11.8h, v17.8b, v29.8b
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v24.2s }, [x8], x13
	ld1	{ v25.2s }, [x8]
	umull	v3.8h, v24.8b, v28.8b
	umlal	v3.8h, v25.8b, v29.8b
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v26.2s }, [x8], x13
	ld1	{ v27.2s }, [x8]
	umull	v9.8h, v26.8b, v28.8b
	umlal	v9.8h, v27.8b, v29.8b
	prfm	pldl1keep, [x8, x10]
	sub	x8, x8, x13
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
	prfm	pldl1keep, [x9, x10]
	umlsl	v8.4s, v9.4h, v15.h[4]
	umlal2	v8.4s, v9.8h, v15.h[4]
	add	v12.8h, v12.8h, v13.8h
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	shrn	v2.4h, v2.4s, #14
	shrn2	v2.8h, v8.4s, #14
	ushr	v15.8h, v12.8h, #9
	xtn	v0.8b, v0.8h
	xtn	v1.8b, v2.8h
	add	v12.8h, v12.8h, v13.8h
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	ushll	v3.8h, v1.8b, #7
	shl	v3.8h, v3.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v4.8h, v0.8b, #7
	shl	v4.8h, v4.8h, #1
	sri	v1.8h, v3.8h, #5
	sri	v1.8h, v4.8h, #11
	st1	{ v1.4h }, [x0], #8
	sub	x7, x7, #4
L_2442
	subs	x7, x7, #8
	b.lt	L_2443
	asr	x10, x10, #14
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v14.2s }, [x8], x13
	ld1	{ v20.2s }, [x8]
	umull	v1.8h, v14.8b, v28.8b
	umlal	v1.8h, v20.8b, v29.8b
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v16.2s }, [x8], x13
	ld1	{ v17.2s }, [x8]
	umull	v11.8h, v16.8b, v28.8b
	umlal	v11.8h, v17.8b, v29.8b
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v24.2s }, [x8], x13
	ld1	{ v25.2s }, [x8]
	umull	v3.8h, v24.8b, v28.8b
	umlal	v3.8h, v25.8b, v29.8b
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v26.2s }, [x8], x13
	ld1	{ v27.2s }, [x8]
	umull	v9.8h, v26.8b, v28.8b
	umlal	v9.8h, v27.8b, v29.8b
	prfm	pldl1keep, [x8, x10]
	sub	x8, x8, x13
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
	prfm	pldl1keep, [x9, x10]
	umlsl	v8.4s, v9.4h, v15.h[4]
	umlal2	v8.4s, v9.8h, v15.h[4]
	add	v12.8h, v12.8h, v13.8h
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	shrn	v2.4h, v2.4s, #14
	shrn2	v2.8h, v8.4s, #14
	ushr	v15.8h, v12.8h, #9
	xtn	v0.8b, v0.8h
	xtn	v1.8b, v2.8h
	add	v12.8h, v12.8h, v13.8h
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	ushll	v3.8h, v1.8b, #7
	shl	v3.8h, v3.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v4.8h, v0.8b, #7
	shl	v4.8h, v4.8h, #1
	sri	v1.8h, v3.8h, #5
	sri	v1.8h, v4.8h, #11
	st1	{ v1.4h }, [x0], #8
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v14.2s }, [x8], x13
	ld1	{ v20.2s }, [x8]
	umull	v1.8h, v14.8b, v28.8b
	umlal	v1.8h, v20.8b, v29.8b
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v16.2s }, [x8], x13
	ld1	{ v17.2s }, [x8]
	umull	v11.8h, v16.8b, v28.8b
	umlal	v11.8h, v17.8b, v29.8b
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v24.2s }, [x8], x13
	ld1	{ v25.2s }, [x8]
	umull	v3.8h, v24.8b, v28.8b
	umlal	v3.8h, v25.8b, v29.8b
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v26.2s }, [x8], x13
	ld1	{ v27.2s }, [x8]
	umull	v9.8h, v26.8b, v28.8b
	umlal	v9.8h, v27.8b, v29.8b
	prfm	pldl1keep, [x8, x10]
	sub	x8, x8, x13
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
	prfm	pldl1keep, [x9, x10]
	umlsl	v8.4s, v9.4h, v15.h[4]
	umlal2	v8.4s, v9.8h, v15.h[4]
	add	v12.8h, v12.8h, v13.8h
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	shrn	v2.4h, v2.4s, #14
	shrn2	v2.8h, v8.4s, #14
	ushr	v15.8h, v12.8h, #9
	xtn	v0.8b, v0.8h
	xtn	v1.8b, v2.8h
	add	v12.8h, v12.8h, v13.8h
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	ushll	v3.8h, v1.8b, #7
	shl	v3.8h, v3.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v4.8h, v0.8b, #7
	shl	v4.8h, v4.8h, #1
	sri	v1.8h, v3.8h, #5
	sri	v1.8h, v4.8h, #11
	st1	{ v1.4h }, [x0], #8
	subs	x7, x7, #8
	b.lt	L_2444
L_2445
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v14.2s }, [x8], x13
	ld1	{ v20.2s }, [x8]
	umull	v1.8h, v14.8b, v28.8b
	umlal	v1.8h, v20.8b, v29.8b
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v16.2s }, [x8], x13
	ld1	{ v17.2s }, [x8]
	umull	v11.8h, v16.8b, v28.8b
	umlal	v11.8h, v17.8b, v29.8b
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v24.2s }, [x8], x13
	ld1	{ v25.2s }, [x8]
	umull	v3.8h, v24.8b, v28.8b
	umlal	v3.8h, v25.8b, v29.8b
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v26.2s }, [x8], x13
	ld1	{ v27.2s }, [x8]
	umull	v9.8h, v26.8b, v28.8b
	umlal	v9.8h, v27.8b, v29.8b
	prfm	pldl1keep, [x8, x10]
	sub	x8, x8, x13
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
	prfm	pldl1keep, [x9, x10]
	umlsl	v8.4s, v9.4h, v15.h[4]
	umlal2	v8.4s, v9.8h, v15.h[4]
	add	v12.8h, v12.8h, v13.8h
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	shrn	v2.4h, v2.4s, #14
	shrn2	v2.8h, v8.4s, #14
	ushr	v15.8h, v12.8h, #9
	xtn	v0.8b, v0.8h
	xtn	v1.8b, v2.8h
	add	v12.8h, v12.8h, v13.8h
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	ushll	v3.8h, v1.8b, #7
	shl	v3.8h, v3.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v4.8h, v0.8b, #7
	shl	v4.8h, v4.8h, #1
	sri	v1.8h, v3.8h, #5
	sri	v1.8h, v4.8h, #11
	st1	{ v1.4h }, [x0], #8
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v14.2s }, [x8], x13
	ld1	{ v20.2s }, [x8]
	umull	v1.8h, v14.8b, v28.8b
	umlal	v1.8h, v20.8b, v29.8b
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v16.2s }, [x8], x13
	ld1	{ v17.2s }, [x8]
	umull	v11.8h, v16.8b, v28.8b
	umlal	v11.8h, v17.8b, v29.8b
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v24.2s }, [x8], x13
	ld1	{ v25.2s }, [x8]
	umull	v3.8h, v24.8b, v28.8b
	umlal	v3.8h, v25.8b, v29.8b
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v26.2s }, [x8], x13
	ld1	{ v27.2s }, [x8]
	umull	v9.8h, v26.8b, v28.8b
	umlal	v9.8h, v27.8b, v29.8b
	prfm	pldl1keep, [x8, x10]
	sub	x8, x8, x13
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
	prfm	pldl1keep, [x9, x10]
	umlsl	v8.4s, v9.4h, v15.h[4]
	umlal2	v8.4s, v9.8h, v15.h[4]
	add	v12.8h, v12.8h, v13.8h
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	shrn	v2.4h, v2.4s, #14
	shrn2	v2.8h, v8.4s, #14
	ushr	v15.8h, v12.8h, #9
	xtn	v0.8b, v0.8h
	xtn	v1.8b, v2.8h
	add	v12.8h, v12.8h, v13.8h
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	ushll	v3.8h, v1.8b, #7
	shl	v3.8h, v3.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v4.8h, v0.8b, #7
	shl	v4.8h, v4.8h, #1
	sri	v1.8h, v3.8h, #5
	sri	v1.8h, v4.8h, #11
	st1	{ v1.4h }, [x0], #8
	subs	x7, x7, #8
	b.ge	L_2445
L_2444
L_2443
	tst	x7, #0x4
	b.eq	L_2446
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v14.2s }, [x8], x13
	ld1	{ v20.2s }, [x8]
	umull	v1.8h, v14.8b, v28.8b
	umlal	v1.8h, v20.8b, v29.8b
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v16.2s }, [x8], x13
	ld1	{ v17.2s }, [x8]
	umull	v11.8h, v16.8b, v28.8b
	umlal	v11.8h, v17.8b, v29.8b
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v24.2s }, [x8], x13
	ld1	{ v25.2s }, [x8]
	umull	v3.8h, v24.8b, v28.8b
	umlal	v3.8h, v25.8b, v29.8b
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v26.2s }, [x8], x13
	ld1	{ v27.2s }, [x8]
	umull	v9.8h, v26.8b, v28.8b
	umlal	v9.8h, v27.8b, v29.8b
	prfm	pldl1keep, [x8, x10]
	sub	x8, x8, x13
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
	prfm	pldl1keep, [x9, x10]
	umlsl	v8.4s, v9.4h, v15.h[4]
	umlal2	v8.4s, v9.8h, v15.h[4]
	add	v12.8h, v12.8h, v13.8h
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	shrn	v2.4h, v2.4s, #14
	shrn2	v2.8h, v8.4s, #14
	ushr	v15.8h, v12.8h, #9
	xtn	v0.8b, v0.8h
	xtn	v1.8b, v2.8h
	add	v12.8h, v12.8h, v13.8h
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	ushll	v3.8h, v1.8b, #7
	shl	v3.8h, v3.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v4.8h, v0.8b, #7
	shl	v4.8h, v4.8h, #1
	sri	v1.8h, v3.8h, #5
	sri	v1.8h, v4.8h, #11
	st1	{ v1.4h }, [x0], #8
L_2446
	tst	x7, #0x2
	b.eq	L_2447
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v2.2s }, [x8], x13
	ld1	{ v3.2s }, [x8]
	umull	v1.8h, v2.8b, v28.8b
	umlal	v1.8h, v3.8b, v29.8b
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v20.2s }, [x8], x13
	ld1	{ v21.2s }, [x8]
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
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
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	ushll	v3.8h, v1.8b, #7
	shl	v3.8h, v3.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v4.8h, v0.8b, #7
	shl	v4.8h, v4.8h, #1
	sri	v1.8h, v3.8h, #5
	sri	v1.8h, v4.8h, #11
	st1	{ v1.s }[0], [x0], #4
L_2447
	tst	x7, #0x1
	b.eq	L_2439
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #2
	ld1	{ v0.2s }, [x8], x13
	ld1	{ v1.2s }, [x8]
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	ushll	v3.8h, v1.8b, #7
	shl	v3.8h, v3.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v4.8h, v0.8b, #7
	shl	v4.8h, v4.8h, #1
	sri	v1.8h, v3.8h, #5
	sri	v1.8h, v4.8h, #11
	st1	{ v1.h }[0], [x0], #2
L_2439
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-104]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_scaled_bilinear_scanline_0565_x888_SRC_asm_neon
pixman_scaled_bilinear_scanline_0565_x888_SRC_asm_neon
	sxtw	x3, w3
	sxtw	x4, w4
	sxtw	x5, w5
	sxtw	x6, w6
	sxtw	x7, w7
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #112
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	mov	x10, #28
	mul	x10, x10, x6
	subs	x13, x2, x1
	cmp	x7, #0
	b.le	L_2448
	dup	v12.8h, w5
	dup	v13.8h, w6
	dup	v28.8b, w3
	dup	v29.8b, w4
	mov	v25.d[0], v12.d[1]
	mov	v26.d[0], v13.d[0]
	add	v25.4h, v25.4h, v26.4h
	mov	v12.d[1], v25.d[0]
	cmp	x7, #1
	b.lt	L_2449
	tst	x0, #0x4
	b.eq	L_2449
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #1
	ld1	{ v1.s }[0], [x8], x13
	ld1	{ v1.s }[1], [x8]
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
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	st1	{ v0.s }[0], [x0], #4
	sub	x7, x7, #1
L_2449
	add	v13.8h, v13.8h, v13.8h
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	cmp	x7, #2
	b.lt	L_2450
	tst	x0, #0x8
	b.eq	L_2450
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #1
	asr	x9, x5, #16
	add	x5, x5, x6
	add	x9, x1, x9, lsl #1
	ld1	{ v11.s }[0], [x8], x13
	ld1	{ v11.s }[2], [x9], x13
	ld1	{ v11.s }[1], [x8]
	ld1	{ v11.s }[3], [x9]
	shrn	v20.8b, v11.8h, #8
	shrn	v3.8b, v11.8h, #3
	sli	v11.8h, v11.8h, #5
	sri	v20.8b, v20.8b, #5
	sri	v3.8b, v3.8b, #6
	shrn	v2.8b, v11.8h, #2
	umov	x12, v31.d[0]
	zip1	v31.8b, v2.8b, v20.8b
	zip2	v20.8b, v2.8b, v20.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	zip1	v31.8b, v3.8b, v21.8b
	zip2	v21.8b, v3.8b, v21.8b
	mov	v3.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	zip1	v31.8b, v20.8b, v21.8b
	zip2	v21.8b, v20.8b, v21.8b
	mov	v20.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	zip1	v31.8b, v2.8b, v3.8b
	zip2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umull	v1.8h, v2.8b, v28.8b
	umlal	v1.8h, v3.8b, v29.8b
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
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
	st1	{ v0.2s }, [x0], #8
	sub	x7, x7, #2
L_2450
	subs	x7, x7, #4
	b.lt	L_2451
	asr	x10, x10, #15
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #1
	asr	x9, x5, #16
	add	x5, x5, x6
	add	x9, x1, x9, lsl #1
	ld1	{ v11.s }[0], [x8], x13
	ld1	{ v11.s }[2], [x9], x13
	ld1	{ v11.s }[1], [x8]
	ld1	{ v11.s }[3], [x9]
	shrn	v16.8b, v11.8h, #8
	shrn	v20.8b, v11.8h, #3
	sli	v11.8h, v11.8h, #5
	sri	v16.8b, v16.8b, #5
	sri	v20.8b, v20.8b, #6
	shrn	v14.8b, v11.8h, #2
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #1
	asr	x9, x5, #16
	add	x5, x5, x6
	add	x9, x1, x9, lsl #1
	ld1	{ v9.s }[0], [x8], x13
	umov	x12, v31.d[0]
	zip1	v31.8b, v14.8b, v16.8b
	zip2	v16.8b, v14.8b, v16.8b
	mov	v14.8b, v31.8b
	mov	v31.d[0], x12
	ld1	{ v9.s }[2], [x9], x13
	umov	x12, v31.d[0]
	zip1	v31.8b, v20.8b, v17.8b
	zip2	v17.8b, v20.8b, v17.8b
	mov	v20.8b, v31.8b
	mov	v31.d[0], x12
	ld1	{ v9.s }[1], [x8]
	umov	x12, v31.d[0]
	zip1	v31.8b, v16.8b, v17.8b
	zip2	v17.8b, v16.8b, v17.8b
	mov	v16.8b, v31.8b
	mov	v31.d[0], x12
	ld1	{ v9.s }[3], [x9]
	umov	x12, v31.d[0]
	zip1	v31.8b, v14.8b, v20.8b
	zip2	v20.8b, v14.8b, v20.8b
	mov	v14.8b, v31.8b
	mov	v31.d[0], x12
	shrn	v26.8b, v9.8h, #8
	shrn	v25.8b, v9.8h, #3
	sli	v9.8h, v9.8h, #5
	sri	v26.8b, v26.8b, #5
	sri	v25.8b, v25.8b, #6
	shrn	v24.8b, v9.8h, #2
	umull	v1.8h, v14.8b, v28.8b
	umov	x12, v31.d[0]
	zip1	v31.8b, v24.8b, v26.8b
	zip2	v26.8b, v24.8b, v26.8b
	mov	v24.8b, v31.8b
	mov	v31.d[0], x12
	umlal	v1.8h, v20.8b, v29.8b
	umov	x12, v31.d[0]
	zip1	v31.8b, v25.8b, v27.8b
	zip2	v27.8b, v25.8b, v27.8b
	mov	v25.8b, v31.8b
	mov	v31.d[0], x12
	umull	v11.8h, v16.8b, v28.8b
	umov	x12, v31.d[0]
	zip1	v31.8b, v26.8b, v27.8b
	zip2	v27.8b, v26.8b, v27.8b
	mov	v26.8b, v31.8b
	mov	v31.d[0], x12
	umlal	v11.8h, v17.8b, v29.8b
	umov	x12, v31.d[0]
	zip1	v31.8b, v24.8b, v25.8b
	zip2	v25.8b, v24.8b, v25.8b
	mov	v24.8b, v31.8b
	mov	v31.d[0], x12
	umull	v3.8h, v24.8b, v28.8b
	umlal	v3.8h, v25.8b, v29.8b
	umull	v9.8h, v26.8b, v28.8b
	umlal	v9.8h, v27.8b, v29.8b
	prfm	pldl1keep, [x8, x10]
	sub	x8, x8, x13
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
	prfm	pldl1keep, [x9, x10]
	umlsl	v8.4s, v9.4h, v15.h[4]
	umlal2	v8.4s, v9.8h, v15.h[4]
	add	v12.8h, v12.8h, v13.8h
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	shrn	v2.4h, v2.4s, #14
	shrn2	v2.8h, v8.4s, #14
	ushr	v15.8h, v12.8h, #9
	xtn	v0.8b, v0.8h
	xtn	v1.8b, v2.8h
	add	v12.8h, v12.8h, v13.8h
	st1	{ v0.2s, v1.2s }, [x0], #16
	subs	x7, x7, #4
	b.lt	L_2452
L_2453
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #1
	asr	x9, x5, #16
	add	x5, x5, x6
	add	x9, x1, x9, lsl #1
	ld1	{ v11.s }[0], [x8], x13
	ld1	{ v11.s }[2], [x9], x13
	ld1	{ v11.s }[1], [x8]
	ld1	{ v11.s }[3], [x9]
	shrn	v16.8b, v11.8h, #8
	shrn	v20.8b, v11.8h, #3
	sli	v11.8h, v11.8h, #5
	sri	v16.8b, v16.8b, #5
	sri	v20.8b, v20.8b, #6
	shrn	v14.8b, v11.8h, #2
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #1
	asr	x9, x5, #16
	add	x5, x5, x6
	add	x9, x1, x9, lsl #1
	ld1	{ v9.s }[0], [x8], x13
	umov	x12, v31.d[0]
	zip1	v31.8b, v14.8b, v16.8b
	zip2	v16.8b, v14.8b, v16.8b
	mov	v14.8b, v31.8b
	mov	v31.d[0], x12
	ld1	{ v9.s }[2], [x9], x13
	umov	x12, v31.d[0]
	zip1	v31.8b, v20.8b, v17.8b
	zip2	v17.8b, v20.8b, v17.8b
	mov	v20.8b, v31.8b
	mov	v31.d[0], x12
	ld1	{ v9.s }[1], [x8]
	umov	x12, v31.d[0]
	zip1	v31.8b, v16.8b, v17.8b
	zip2	v17.8b, v16.8b, v17.8b
	mov	v16.8b, v31.8b
	mov	v31.d[0], x12
	ld1	{ v9.s }[3], [x9]
	umov	x12, v31.d[0]
	zip1	v31.8b, v14.8b, v20.8b
	zip2	v20.8b, v14.8b, v20.8b
	mov	v14.8b, v31.8b
	mov	v31.d[0], x12
	shrn	v26.8b, v9.8h, #8
	shrn	v25.8b, v9.8h, #3
	sli	v9.8h, v9.8h, #5
	sri	v26.8b, v26.8b, #5
	sri	v25.8b, v25.8b, #6
	shrn	v24.8b, v9.8h, #2
	umull	v1.8h, v14.8b, v28.8b
	umov	x12, v31.d[0]
	zip1	v31.8b, v24.8b, v26.8b
	zip2	v26.8b, v24.8b, v26.8b
	mov	v24.8b, v31.8b
	mov	v31.d[0], x12
	umlal	v1.8h, v20.8b, v29.8b
	umov	x12, v31.d[0]
	zip1	v31.8b, v25.8b, v27.8b
	zip2	v27.8b, v25.8b, v27.8b
	mov	v25.8b, v31.8b
	mov	v31.d[0], x12
	umull	v11.8h, v16.8b, v28.8b
	umov	x12, v31.d[0]
	zip1	v31.8b, v26.8b, v27.8b
	zip2	v27.8b, v26.8b, v27.8b
	mov	v26.8b, v31.8b
	mov	v31.d[0], x12
	umlal	v11.8h, v17.8b, v29.8b
	umov	x12, v31.d[0]
	zip1	v31.8b, v24.8b, v25.8b
	zip2	v25.8b, v24.8b, v25.8b
	mov	v24.8b, v31.8b
	mov	v31.d[0], x12
	umull	v3.8h, v24.8b, v28.8b
	umlal	v3.8h, v25.8b, v29.8b
	umull	v9.8h, v26.8b, v28.8b
	umlal	v9.8h, v27.8b, v29.8b
	prfm	pldl1keep, [x8, x10]
	sub	x8, x8, x13
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
	prfm	pldl1keep, [x9, x10]
	umlsl	v8.4s, v9.4h, v15.h[4]
	umlal2	v8.4s, v9.8h, v15.h[4]
	add	v12.8h, v12.8h, v13.8h
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	shrn	v2.4h, v2.4s, #14
	shrn2	v2.8h, v8.4s, #14
	ushr	v15.8h, v12.8h, #9
	xtn	v0.8b, v0.8h
	xtn	v1.8b, v2.8h
	add	v12.8h, v12.8h, v13.8h
	st1	{ v0.2s, v1.2s }, [x0], #16
	subs	x7, x7, #4
	b.ge	L_2453
L_2452
L_2451
	tst	x7, #0x2
	b.eq	L_2454
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #1
	asr	x9, x5, #16
	add	x5, x5, x6
	add	x9, x1, x9, lsl #1
	ld1	{ v11.s }[0], [x8], x13
	ld1	{ v11.s }[2], [x9], x13
	ld1	{ v11.s }[1], [x8]
	ld1	{ v11.s }[3], [x9]
	shrn	v20.8b, v11.8h, #8
	shrn	v3.8b, v11.8h, #3
	sli	v11.8h, v11.8h, #5
	sri	v20.8b, v20.8b, #5
	sri	v3.8b, v3.8b, #6
	shrn	v2.8b, v11.8h, #2
	umov	x12, v31.d[0]
	zip1	v31.8b, v2.8b, v20.8b
	zip2	v20.8b, v2.8b, v20.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	zip1	v31.8b, v3.8b, v21.8b
	zip2	v21.8b, v3.8b, v21.8b
	mov	v3.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	zip1	v31.8b, v20.8b, v21.8b
	zip2	v21.8b, v20.8b, v21.8b
	mov	v20.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	zip1	v31.8b, v2.8b, v3.8b
	zip2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umull	v1.8h, v2.8b, v28.8b
	umlal	v1.8h, v3.8b, v29.8b
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
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
	st1	{ v0.2s }, [x0], #8
L_2454
	tst	x7, #0x1
	b.eq	L_2448
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #1
	ld1	{ v1.s }[0], [x8], x13
	ld1	{ v1.s }[1], [x8]
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
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	st1	{ v0.s }[0], [x0], #4
L_2448
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-104]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret
	EXPORT pixman_scaled_bilinear_scanline_0565_0565_SRC_asm_neon
pixman_scaled_bilinear_scanline_0565_0565_SRC_asm_neon
	sxtw	x3, w3
	sxtw	x4, w4
	sxtw	x5, w5
	sxtw	x6, w6
	sxtw	x7, w7
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	sub	sp, sp, #112
	sub	x29, x29, #64
	st1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	st1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	stp	x8, x9, [x29, #-80]
	stp	x10, x11, [x29, #-96]
	stp	x12, x13, [x29, #-112]
	mov	x10, #28
	mul	x10, x10, x6
	subs	x13, x2, x1
	cmp	x7, #0
	b.le	L_2455
	dup	v12.8h, w5
	dup	v13.8h, w6
	dup	v28.8b, w3
	dup	v29.8b, w4
	mov	v25.d[0], v12.d[1]
	mov	v26.d[0], v13.d[0]
	add	v25.4h, v25.4h, v26.4h
	mov	v12.d[1], v25.d[0]
	cmp	x7, #1
	b.lt	L_2456
	tst	x0, #0x2
	b.eq	L_2456
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #1
	ld1	{ v1.s }[0], [x8], x13
	ld1	{ v1.s }[1], [x8]
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
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	ushll	v3.8h, v1.8b, #7
	shl	v3.8h, v3.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v4.8h, v0.8b, #7
	shl	v4.8h, v4.8h, #1
	sri	v1.8h, v3.8h, #5
	sri	v1.8h, v4.8h, #11
	st1	{ v1.h }[0], [x0], #2
	sub	x7, x7, #1
L_2456
	add	v13.8h, v13.8h, v13.8h
	ushr	v15.8h, v12.8h, #9
	add	v12.8h, v12.8h, v13.8h
	cmp	x7, #2
	b.lt	L_2457
	tst	x0, #0x4
	b.eq	L_2457
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #1
	asr	x9, x5, #16
	add	x5, x5, x6
	add	x9, x1, x9, lsl #1
	ld1	{ v11.s }[0], [x8], x13
	ld1	{ v11.s }[2], [x9], x13
	ld1	{ v11.s }[1], [x8]
	ld1	{ v11.s }[3], [x9]
	shrn	v20.8b, v11.8h, #8
	shrn	v3.8b, v11.8h, #3
	sli	v11.8h, v11.8h, #5
	sri	v20.8b, v20.8b, #5
	sri	v3.8b, v3.8b, #6
	shrn	v2.8b, v11.8h, #2
	umov	x12, v31.d[0]
	zip1	v31.8b, v2.8b, v20.8b
	zip2	v20.8b, v2.8b, v20.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	zip1	v31.8b, v3.8b, v21.8b
	zip2	v21.8b, v3.8b, v21.8b
	mov	v3.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	zip1	v31.8b, v20.8b, v21.8b
	zip2	v21.8b, v20.8b, v21.8b
	mov	v20.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	zip1	v31.8b, v2.8b, v3.8b
	zip2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umull	v1.8h, v2.8b, v28.8b
	umlal	v1.8h, v3.8b, v29.8b
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
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
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	ushll	v3.8h, v1.8b, #7
	shl	v3.8h, v3.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v4.8h, v0.8b, #7
	shl	v4.8h, v4.8h, #1
	sri	v1.8h, v3.8h, #5
	sri	v1.8h, v4.8h, #11
	st1	{ v1.s }[0], [x0], #4
	sub	x7, x7, #2
L_2457
	subs	x7, x7, #4
	b.lt	L_2458
	asr	x10, x10, #15
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #1
	asr	x9, x5, #16
	add	x5, x5, x6
	add	x9, x1, x9, lsl #1
	ld1	{ v11.s }[0], [x8], x13
	ld1	{ v11.s }[2], [x9], x13
	ld1	{ v11.s }[1], [x8]
	ld1	{ v11.s }[3], [x9]
	shrn	v16.8b, v11.8h, #8
	shrn	v20.8b, v11.8h, #3
	sli	v11.8h, v11.8h, #5
	sri	v16.8b, v16.8b, #5
	sri	v20.8b, v20.8b, #6
	shrn	v14.8b, v11.8h, #2
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #1
	asr	x9, x5, #16
	add	x5, x5, x6
	add	x9, x1, x9, lsl #1
	ld1	{ v9.s }[0], [x8], x13
	umov	x12, v31.d[0]
	zip1	v31.8b, v14.8b, v16.8b
	zip2	v16.8b, v14.8b, v16.8b
	mov	v14.8b, v31.8b
	mov	v31.d[0], x12
	ld1	{ v9.s }[2], [x9], x13
	umov	x12, v31.d[0]
	zip1	v31.8b, v20.8b, v17.8b
	zip2	v17.8b, v20.8b, v17.8b
	mov	v20.8b, v31.8b
	mov	v31.d[0], x12
	ld1	{ v9.s }[1], [x8]
	umov	x12, v31.d[0]
	zip1	v31.8b, v16.8b, v17.8b
	zip2	v17.8b, v16.8b, v17.8b
	mov	v16.8b, v31.8b
	mov	v31.d[0], x12
	ld1	{ v9.s }[3], [x9]
	umov	x12, v31.d[0]
	zip1	v31.8b, v14.8b, v20.8b
	zip2	v20.8b, v14.8b, v20.8b
	mov	v14.8b, v31.8b
	mov	v31.d[0], x12
	shrn	v26.8b, v9.8h, #8
	shrn	v25.8b, v9.8h, #3
	sli	v9.8h, v9.8h, #5
	sri	v26.8b, v26.8b, #5
	sri	v25.8b, v25.8b, #6
	shrn	v24.8b, v9.8h, #2
	umull	v1.8h, v14.8b, v28.8b
	umov	x12, v31.d[0]
	zip1	v31.8b, v24.8b, v26.8b
	zip2	v26.8b, v24.8b, v26.8b
	mov	v24.8b, v31.8b
	mov	v31.d[0], x12
	umlal	v1.8h, v20.8b, v29.8b
	umov	x12, v31.d[0]
	zip1	v31.8b, v25.8b, v27.8b
	zip2	v27.8b, v25.8b, v27.8b
	mov	v25.8b, v31.8b
	mov	v31.d[0], x12
	umull	v11.8h, v16.8b, v28.8b
	umov	x12, v31.d[0]
	zip1	v31.8b, v26.8b, v27.8b
	zip2	v27.8b, v26.8b, v27.8b
	mov	v26.8b, v31.8b
	mov	v31.d[0], x12
	umlal	v11.8h, v17.8b, v29.8b
	umov	x12, v31.d[0]
	zip1	v31.8b, v24.8b, v25.8b
	zip2	v25.8b, v24.8b, v25.8b
	mov	v24.8b, v31.8b
	mov	v31.d[0], x12
	umull	v3.8h, v24.8b, v28.8b
	umlal	v3.8h, v25.8b, v29.8b
	umull	v9.8h, v26.8b, v28.8b
	umlal	v9.8h, v27.8b, v29.8b
	prfm	pldl1keep, [x8, x10]
	sub	x8, x8, x13
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
	prfm	pldl1keep, [x9, x10]
	umlsl	v8.4s, v9.4h, v15.h[4]
	umlal2	v8.4s, v9.8h, v15.h[4]
	add	v12.8h, v12.8h, v13.8h
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	shrn	v2.4h, v2.4s, #14
	shrn2	v2.8h, v8.4s, #14
	ushr	v15.8h, v12.8h, #9
	xtn	v0.8b, v0.8h
	xtn	v1.8b, v2.8h
	add	v12.8h, v12.8h, v13.8h
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	ushll	v3.8h, v1.8b, #7
	shl	v3.8h, v3.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v4.8h, v0.8b, #7
	shl	v4.8h, v4.8h, #1
	sri	v1.8h, v3.8h, #5
	sri	v1.8h, v4.8h, #11
	st1	{ v1.4h }, [x0], #8
	subs	x7, x7, #4
	b.lt	L_2459
L_2460
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #1
	asr	x9, x5, #16
	add	x5, x5, x6
	add	x9, x1, x9, lsl #1
	ld1	{ v11.s }[0], [x8], x13
	ld1	{ v11.s }[2], [x9], x13
	ld1	{ v11.s }[1], [x8]
	ld1	{ v11.s }[3], [x9]
	shrn	v16.8b, v11.8h, #8
	shrn	v20.8b, v11.8h, #3
	sli	v11.8h, v11.8h, #5
	sri	v16.8b, v16.8b, #5
	sri	v20.8b, v20.8b, #6
	shrn	v14.8b, v11.8h, #2
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #1
	asr	x9, x5, #16
	add	x5, x5, x6
	add	x9, x1, x9, lsl #1
	ld1	{ v9.s }[0], [x8], x13
	umov	x12, v31.d[0]
	zip1	v31.8b, v14.8b, v16.8b
	zip2	v16.8b, v14.8b, v16.8b
	mov	v14.8b, v31.8b
	mov	v31.d[0], x12
	ld1	{ v9.s }[2], [x9], x13
	umov	x12, v31.d[0]
	zip1	v31.8b, v20.8b, v17.8b
	zip2	v17.8b, v20.8b, v17.8b
	mov	v20.8b, v31.8b
	mov	v31.d[0], x12
	ld1	{ v9.s }[1], [x8]
	umov	x12, v31.d[0]
	zip1	v31.8b, v16.8b, v17.8b
	zip2	v17.8b, v16.8b, v17.8b
	mov	v16.8b, v31.8b
	mov	v31.d[0], x12
	ld1	{ v9.s }[3], [x9]
	umov	x12, v31.d[0]
	zip1	v31.8b, v14.8b, v20.8b
	zip2	v20.8b, v14.8b, v20.8b
	mov	v14.8b, v31.8b
	mov	v31.d[0], x12
	shrn	v26.8b, v9.8h, #8
	shrn	v25.8b, v9.8h, #3
	sli	v9.8h, v9.8h, #5
	sri	v26.8b, v26.8b, #5
	sri	v25.8b, v25.8b, #6
	shrn	v24.8b, v9.8h, #2
	umull	v1.8h, v14.8b, v28.8b
	umov	x12, v31.d[0]
	zip1	v31.8b, v24.8b, v26.8b
	zip2	v26.8b, v24.8b, v26.8b
	mov	v24.8b, v31.8b
	mov	v31.d[0], x12
	umlal	v1.8h, v20.8b, v29.8b
	umov	x12, v31.d[0]
	zip1	v31.8b, v25.8b, v27.8b
	zip2	v27.8b, v25.8b, v27.8b
	mov	v25.8b, v31.8b
	mov	v31.d[0], x12
	umull	v11.8h, v16.8b, v28.8b
	umov	x12, v31.d[0]
	zip1	v31.8b, v26.8b, v27.8b
	zip2	v27.8b, v26.8b, v27.8b
	mov	v26.8b, v31.8b
	mov	v31.d[0], x12
	umlal	v11.8h, v17.8b, v29.8b
	umov	x12, v31.d[0]
	zip1	v31.8b, v24.8b, v25.8b
	zip2	v25.8b, v24.8b, v25.8b
	mov	v24.8b, v31.8b
	mov	v31.d[0], x12
	umull	v3.8h, v24.8b, v28.8b
	umlal	v3.8h, v25.8b, v29.8b
	umull	v9.8h, v26.8b, v28.8b
	umlal	v9.8h, v27.8b, v29.8b
	prfm	pldl1keep, [x8, x10]
	sub	x8, x8, x13
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
	prfm	pldl1keep, [x9, x10]
	umlsl	v8.4s, v9.4h, v15.h[4]
	umlal2	v8.4s, v9.8h, v15.h[4]
	add	v12.8h, v12.8h, v13.8h
	shrn	v0.4h, v0.4s, #14
	shrn2	v0.8h, v10.4s, #14
	shrn	v2.4h, v2.4s, #14
	shrn2	v2.8h, v8.4s, #14
	ushr	v15.8h, v12.8h, #9
	xtn	v0.8b, v0.8h
	xtn	v1.8b, v2.8h
	add	v12.8h, v12.8h, v13.8h
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	ushll	v3.8h, v1.8b, #7
	shl	v3.8h, v3.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v4.8h, v0.8b, #7
	shl	v4.8h, v4.8h, #1
	sri	v1.8h, v3.8h, #5
	sri	v1.8h, v4.8h, #11
	st1	{ v1.4h }, [x0], #8
	subs	x7, x7, #4
	b.ge	L_2460
L_2459
L_2458
	tst	x7, #0x2
	b.eq	L_2461
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #1
	asr	x9, x5, #16
	add	x5, x5, x6
	add	x9, x1, x9, lsl #1
	ld1	{ v11.s }[0], [x8], x13
	ld1	{ v11.s }[2], [x9], x13
	ld1	{ v11.s }[1], [x8]
	ld1	{ v11.s }[3], [x9]
	shrn	v20.8b, v11.8h, #8
	shrn	v3.8b, v11.8h, #3
	sli	v11.8h, v11.8h, #5
	sri	v20.8b, v20.8b, #5
	sri	v3.8b, v3.8b, #6
	shrn	v2.8b, v11.8h, #2
	umov	x12, v31.d[0]
	zip1	v31.8b, v2.8b, v20.8b
	zip2	v20.8b, v2.8b, v20.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	zip1	v31.8b, v3.8b, v21.8b
	zip2	v21.8b, v3.8b, v21.8b
	mov	v3.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	zip1	v31.8b, v20.8b, v21.8b
	zip2	v21.8b, v20.8b, v21.8b
	mov	v20.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	zip1	v31.8b, v2.8b, v3.8b
	zip2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umull	v1.8h, v2.8b, v28.8b
	umlal	v1.8h, v3.8b, v29.8b
	umull	v11.8h, v20.8b, v28.8b
	umlal	v11.8h, v21.8b, v29.8b
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
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	ushll	v3.8h, v1.8b, #7
	shl	v3.8h, v3.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v4.8h, v0.8b, #7
	shl	v4.8h, v4.8h, #1
	sri	v1.8h, v3.8h, #5
	sri	v1.8h, v4.8h, #11
	st1	{ v1.s }[0], [x0], #4
L_2461
	tst	x7, #0x1
	b.eq	L_2455
	asr	x8, x5, #16
	add	x5, x5, x6
	add	x8, x1, x8, lsl #1
	ld1	{ v1.s }[0], [x8], x13
	ld1	{ v1.s }[1], [x8]
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
	umull	v2.8h, v0.8b, v28.8b
	umlal	v2.8h, v1.8b, v29.8b
	ushll	v0.4s, v2.4h, #7
	umlsl	v0.4s, v2.4h, v15.h[0]
	umlal2	v0.4s, v2.8h, v15.h[0]
	shrn	v0.4h, v0.4s, #14
	xtn	v0.8b, v0.8h
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v1.8b
	uzp2	v1.8b, v0.8b, v1.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v2.8b, v3.8b
	uzp2	v3.8b, v2.8b, v3.8b
	mov	v2.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v1.8b, v3.8b
	uzp2	v3.8b, v1.8b, v3.8b
	mov	v1.8b, v31.8b
	mov	v31.d[0], x12
	umov	x12, v31.d[0]
	uzp1	v31.8b, v0.8b, v2.8b
	uzp2	v2.8b, v0.8b, v2.8b
	mov	v0.8b, v31.8b
	mov	v31.d[0], x12
	ushll	v3.8h, v1.8b, #7
	shl	v3.8h, v3.8h, #1
	ushll	v1.8h, v2.8b, #7
	shl	v1.8h, v1.8h, #1
	ushll	v4.8h, v0.8b, #7
	shl	v4.8h, v4.8h, #1
	sri	v1.8h, v3.8h, #5
	sri	v1.8h, v4.8h, #11
	st1	{ v1.h }[0], [x0], #2
L_2455
	sub	x29, x29, #64
	ld1	{ v8.8b, v9.8b, v10.8b, v11.8b }, [x29], #32
	ld1	{ v12.8b, v13.8b, v14.8b, v15.8b }, [x29], #32
	ldp	x8, x9, [x29, #-80]
	ldp	x10, x11, [x29, #-96]
	ldp	x12, x13, [x29, #-104]
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret

	END
