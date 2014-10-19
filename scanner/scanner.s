
.section	.text

.globl	isIdentChar
.type	isIdentChar,@function
isIdentChar	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	subl	$4,%esp
	movb	8(%ebp),%ah
	movsbl	%ah,%eax
	movl	%eax,0(%esp)
	call	isalnum
	addl	$4,%esp
	testl	%eax,%eax
	jnz	isIdentChar_logexprtrue_0
	movsbl	8(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$95,%ebx
	movl	$1,%eax
	je	isIdentChar_reltrue_1
	movl	$0,%eax
isIdentChar_reltrue_1	:	
	testl	%eax,%eax
	jnz	isIdentChar_logexprtrue_0
	movl	$0,%eax
	jmp	isIdentChar_logexprfalse_0
isIdentChar_logexprtrue_0	:	
	movl	$1,%eax
isIdentChar_logexprfalse_0	:	
	jmp	isIdentChar_ret
isIdentChar_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	getTokenCode
.type	getTokenCode,@function
getTokenCode	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	8(%ebp),%ebx
	cmpl	$1000,%ebx
	movl	$1,%eax
	jl	getTokenCode_reltrue_3
	movl	$0,%eax
getTokenCode_reltrue_3	:	
	testl	%eax,%eax
	jnz	getTokenCode_ifbl_2
	jmp	getTokenCode_elsebl_2
getTokenCode_ifbl_2	:	

	movl	$1043,8(%ebp)
	jmp	getTokenCode_endif_2
getTokenCode_elsebl_2	:	
getTokenCode_endif_2	:	

	movl	8(%ebp),%ebx
	subl	$1000,%ebx
	movl	%ebx,%eax
	jmp	getTokenCode_ret
getTokenCode_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	scanner_transFunc
.type	scanner_transFunc,@function
scanner_transFunc	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	8(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_5
	movl	$0,%eax
scanner_transFunc_reltrue_5	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_4
	jmp	scanner_transFunc_elsebl_4
scanner_transFunc_ifbl_4	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_7
	movl	$0,%eax
scanner_transFunc_reltrue_7	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_6
	jmp	scanner_transFunc_elsebl_6
scanner_transFunc_ifbl_6	:	

	movl	$1000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_6	:	
scanner_transFunc_endif_6	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$123,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_9
	movl	$0,%eax
scanner_transFunc_reltrue_9	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_8
	jmp	scanner_transFunc_elsebl_8
scanner_transFunc_ifbl_8	:	

	movl	$1001,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_8	:	
scanner_transFunc_endif_8	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$125,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_11
	movl	$0,%eax
scanner_transFunc_reltrue_11	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_10
	jmp	scanner_transFunc_elsebl_10
scanner_transFunc_ifbl_10	:	

	movl	$1002,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_10	:	
scanner_transFunc_endif_10	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$91,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_13
	movl	$0,%eax
scanner_transFunc_reltrue_13	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_12
	jmp	scanner_transFunc_elsebl_12
scanner_transFunc_ifbl_12	:	

	movl	$1003,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_12	:	
scanner_transFunc_endif_12	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$93,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_15
	movl	$0,%eax
scanner_transFunc_reltrue_15	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_14
	jmp	scanner_transFunc_elsebl_14
scanner_transFunc_ifbl_14	:	

	movl	$1004,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_14	:	
scanner_transFunc_endif_14	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$40,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_17
	movl	$0,%eax
scanner_transFunc_reltrue_17	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_16
	jmp	scanner_transFunc_elsebl_16
scanner_transFunc_ifbl_16	:	

	movl	$1005,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_16	:	
scanner_transFunc_endif_16	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$41,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_19
	movl	$0,%eax
scanner_transFunc_reltrue_19	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_18
	jmp	scanner_transFunc_elsebl_18
scanner_transFunc_ifbl_18	:	

	movl	$1006,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_18	:	
scanner_transFunc_endif_18	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$44,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_21
	movl	$0,%eax
scanner_transFunc_reltrue_21	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_20
	jmp	scanner_transFunc_elsebl_20
scanner_transFunc_ifbl_20	:	

	movl	$1007,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_20	:	
scanner_transFunc_endif_20	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$59,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_23
	movl	$0,%eax
scanner_transFunc_reltrue_23	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_22
	jmp	scanner_transFunc_elsebl_22
scanner_transFunc_ifbl_22	:	

	movl	$1008,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_22	:	
scanner_transFunc_endif_22	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$46,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_25
	movl	$0,%eax
scanner_transFunc_reltrue_25	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_24
	jmp	scanner_transFunc_elsebl_24
scanner_transFunc_ifbl_24	:	

	movl	$1009,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_24	:	
scanner_transFunc_endif_24	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$43,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_27
	movl	$0,%eax
scanner_transFunc_reltrue_27	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_26
	jmp	scanner_transFunc_elsebl_26
scanner_transFunc_ifbl_26	:	

	movl	$1016,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_26	:	
scanner_transFunc_endif_26	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$45,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_29
	movl	$0,%eax
scanner_transFunc_reltrue_29	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_28
	jmp	scanner_transFunc_elsebl_28
scanner_transFunc_ifbl_28	:	

	movl	$1017,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_28	:	
scanner_transFunc_endif_28	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$42,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_31
	movl	$0,%eax
scanner_transFunc_reltrue_31	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_30
	jmp	scanner_transFunc_elsebl_30
scanner_transFunc_ifbl_30	:	

	movl	$1018,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_30	:	
scanner_transFunc_endif_30	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$47,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_33
	movl	$0,%eax
scanner_transFunc_reltrue_33	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_32
	jmp	scanner_transFunc_elsebl_32
scanner_transFunc_ifbl_32	:	

	movl	$1019,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_32	:	
scanner_transFunc_endif_32	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$37,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_35
	movl	$0,%eax
scanner_transFunc_reltrue_35	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_34
	jmp	scanner_transFunc_elsebl_34
scanner_transFunc_ifbl_34	:	

	movl	$1020,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_34	:	
scanner_transFunc_endif_34	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$38,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_37
	movl	$0,%eax
scanner_transFunc_reltrue_37	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_36
	jmp	scanner_transFunc_elsebl_36
scanner_transFunc_ifbl_36	:	

	movl	$1021,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_36	:	
scanner_transFunc_endif_36	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$124,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_39
	movl	$0,%eax
scanner_transFunc_reltrue_39	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_38
	jmp	scanner_transFunc_elsebl_38
scanner_transFunc_ifbl_38	:	

	movl	$1022,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_38	:	
scanner_transFunc_endif_38	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$94,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_41
	movl	$0,%eax
scanner_transFunc_reltrue_41	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_40
	jmp	scanner_transFunc_elsebl_40
scanner_transFunc_ifbl_40	:	

	movl	$1023,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_40	:	
scanner_transFunc_endif_40	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$33,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_43
	movl	$0,%eax
scanner_transFunc_reltrue_43	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_42
	jmp	scanner_transFunc_elsebl_42
scanner_transFunc_ifbl_42	:	

	movl	$1033,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_42	:	
scanner_transFunc_endif_42	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$61,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_45
	movl	$0,%eax
scanner_transFunc_reltrue_45	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_44
	jmp	scanner_transFunc_elsebl_44
scanner_transFunc_ifbl_44	:	

	movl	$1011,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_44	:	
scanner_transFunc_endif_44	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$60,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_47
	movl	$0,%eax
scanner_transFunc_reltrue_47	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_46
	jmp	scanner_transFunc_elsebl_46
scanner_transFunc_ifbl_46	:	

	movl	$1028,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_46	:	
scanner_transFunc_endif_46	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$62,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_49
	movl	$0,%eax
scanner_transFunc_reltrue_49	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_48
	jmp	scanner_transFunc_elsebl_48
scanner_transFunc_ifbl_48	:	

	movl	$1030,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_48	:	
scanner_transFunc_endif_48	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$126,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_51
	movl	$0,%eax
scanner_transFunc_reltrue_51	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_50
	jmp	scanner_transFunc_elsebl_50
scanner_transFunc_ifbl_50	:	

	movl	$1032,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_50	:	
scanner_transFunc_endif_50	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$105,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_53
	movl	$0,%eax
scanner_transFunc_reltrue_53	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_52
	jmp	scanner_transFunc_elsebl_52
scanner_transFunc_ifbl_52	:	

	movl	$1,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_52	:	
scanner_transFunc_endif_52	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$115,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_55
	movl	$0,%eax
scanner_transFunc_reltrue_55	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_54
	jmp	scanner_transFunc_elsebl_54
scanner_transFunc_ifbl_54	:	

	movl	$5,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_54	:	
scanner_transFunc_endif_54	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$101,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_57
	movl	$0,%eax
scanner_transFunc_reltrue_57	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_56
	jmp	scanner_transFunc_elsebl_56
scanner_transFunc_ifbl_56	:	

	movl	$11,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_56	:	
scanner_transFunc_endif_56	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$119,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_59
	movl	$0,%eax
scanner_transFunc_reltrue_59	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_58
	jmp	scanner_transFunc_elsebl_58
scanner_transFunc_ifbl_58	:	

	movl	$15,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_58	:	
scanner_transFunc_endif_58	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$114,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_61
	movl	$0,%eax
scanner_transFunc_reltrue_61	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_60
	jmp	scanner_transFunc_elsebl_60
scanner_transFunc_ifbl_60	:	

	movl	$20,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_60	:	
scanner_transFunc_endif_60	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$99,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_63
	movl	$0,%eax
scanner_transFunc_reltrue_63	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_62
	jmp	scanner_transFunc_elsebl_62
scanner_transFunc_ifbl_62	:	

	movl	$26,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_62	:	
scanner_transFunc_endif_62	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$118,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_65
	movl	$0,%eax
scanner_transFunc_reltrue_65	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_64
	jmp	scanner_transFunc_elsebl_64
scanner_transFunc_ifbl_64	:	

	movl	$34,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_64	:	
scanner_transFunc_endif_64	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$116,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_67
	movl	$0,%eax
scanner_transFunc_reltrue_67	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_66
	jmp	scanner_transFunc_elsebl_66
scanner_transFunc_ifbl_66	:	

	movl	$43,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_66	:	
scanner_transFunc_endif_66	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$98,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_69
	movl	$0,%eax
scanner_transFunc_reltrue_69	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_68
	jmp	scanner_transFunc_elsebl_68
scanner_transFunc_ifbl_68	:	

	movl	$49,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_68	:	
scanner_transFunc_endif_68	:	

	subl	$4,%esp
	movb	12(%ebp),%ah
	movsbl	%ah,%eax
	movl	%eax,0(%esp)
	call	isdigit
	addl	$4,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_70
	jmp	scanner_transFunc_elsebl_70
scanner_transFunc_ifbl_70	:	

	movl	$1044,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_70	:	
scanner_transFunc_endif_70	:	

	subl	$4,%esp
	movb	12(%ebp),%ah
	movsbl	%ah,%eax
	movl	%eax,0(%esp)
	call	isalpha
	addl	$4,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_72
	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$95,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_73
	movl	$0,%eax
scanner_transFunc_reltrue_73	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_72
	movl	$0,%eax
	jmp	scanner_transFunc_logexprfalse_72
scanner_transFunc_logexprtrue_72	:	
	movl	$1,%eax
scanner_transFunc_logexprfalse_72	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_71
	jmp	scanner_transFunc_elsebl_71
scanner_transFunc_ifbl_71	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_71	:	
scanner_transFunc_endif_71	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$34,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_75
	movl	$0,%eax
scanner_transFunc_reltrue_75	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_74
	jmp	scanner_transFunc_elsebl_74
scanner_transFunc_ifbl_74	:	

	movl	$37,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_74	:	
scanner_transFunc_endif_74	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$39,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_77
	movl	$0,%eax
scanner_transFunc_reltrue_77	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_76
	jmp	scanner_transFunc_elsebl_76
scanner_transFunc_ifbl_76	:	

	movl	$38,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_76	:	
scanner_transFunc_endif_76	:	

	subl	$4,%esp
	movb	12(%ebp),%ah
	movsbl	%ah,%eax
	movl	%eax,0(%esp)
	call	isblank
	addl	$4,%esp
	movl	%eax,%ebx
	cmpl	$1,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_80
	movl	$0,%eax
scanner_transFunc_reltrue_80	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_79
	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$10,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_81
	movl	$0,%eax
scanner_transFunc_reltrue_81	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_79
	movl	$0,%eax
	jmp	scanner_transFunc_logexprfalse_79
scanner_transFunc_logexprtrue_79	:	
	movl	$1,%eax
scanner_transFunc_logexprfalse_79	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_78
	jmp	scanner_transFunc_elsebl_78
scanner_transFunc_ifbl_78	:	

	movl	$0,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_78	:	
scanner_transFunc_endif_78	:	

	subl	$8,%esp
	movl	$symtab+0,0(%esp)
	movb	12(%ebp),%ah
	movsbl	%ah,%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$8,%esp
	movl	$symtab+44,0(%esp)
	movb	12(%ebp),%ah
	movsbl	%ah,%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	movl	$0,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_4	:	

	movl	8(%ebp),%ebx
	cmpl	$1017,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_83
	movl	$0,%eax
scanner_transFunc_reltrue_83	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_82
	jmp	scanner_transFunc_elsebl_82
scanner_transFunc_ifbl_82	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$62,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_85
	movl	$0,%eax
scanner_transFunc_reltrue_85	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_84
	jmp	scanner_transFunc_elsebl_84
scanner_transFunc_ifbl_84	:	

	movl	$1010,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_84	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_84	:	
	jmp	scanner_transFunc_endif_82
scanner_transFunc_elsebl_82	:	

	movl	8(%ebp),%ebx
	cmpl	$1021,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_87
	movl	$0,%eax
scanner_transFunc_reltrue_87	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_86
	jmp	scanner_transFunc_elsebl_86
scanner_transFunc_ifbl_86	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$38,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_89
	movl	$0,%eax
scanner_transFunc_reltrue_89	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_88
	jmp	scanner_transFunc_elsebl_88
scanner_transFunc_ifbl_88	:	

	movl	$1024,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_88	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_88	:	
	jmp	scanner_transFunc_endif_86
scanner_transFunc_elsebl_86	:	

	movl	8(%ebp),%ebx
	cmpl	$1022,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_91
	movl	$0,%eax
scanner_transFunc_reltrue_91	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_90
	jmp	scanner_transFunc_elsebl_90
scanner_transFunc_ifbl_90	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$124,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_93
	movl	$0,%eax
scanner_transFunc_reltrue_93	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_92
	jmp	scanner_transFunc_elsebl_92
scanner_transFunc_ifbl_92	:	

	movl	$1025,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_92	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_92	:	
	jmp	scanner_transFunc_endif_90
scanner_transFunc_elsebl_90	:	

	movl	8(%ebp),%ebx
	cmpl	$1033,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_95
	movl	$0,%eax
scanner_transFunc_reltrue_95	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_94
	jmp	scanner_transFunc_elsebl_94
scanner_transFunc_ifbl_94	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$61,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_97
	movl	$0,%eax
scanner_transFunc_reltrue_97	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_96
	jmp	scanner_transFunc_elsebl_96
scanner_transFunc_ifbl_96	:	

	movl	$1027,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_96	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_96	:	
	jmp	scanner_transFunc_endif_94
scanner_transFunc_elsebl_94	:	

	movl	8(%ebp),%ebx
	cmpl	$1011,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_99
	movl	$0,%eax
scanner_transFunc_reltrue_99	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_98
	jmp	scanner_transFunc_elsebl_98
scanner_transFunc_ifbl_98	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$61,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_101
	movl	$0,%eax
scanner_transFunc_reltrue_101	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_100
	jmp	scanner_transFunc_elsebl_100
scanner_transFunc_ifbl_100	:	

	movl	$1026,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_100	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_100	:	
	jmp	scanner_transFunc_endif_98
scanner_transFunc_elsebl_98	:	

	movl	8(%ebp),%ebx
	cmpl	$1028,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_103
	movl	$0,%eax
scanner_transFunc_reltrue_103	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_102
	jmp	scanner_transFunc_elsebl_102
scanner_transFunc_ifbl_102	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$61,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_105
	movl	$0,%eax
scanner_transFunc_reltrue_105	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_104
	jmp	scanner_transFunc_elsebl_104
scanner_transFunc_ifbl_104	:	

	movl	$1029,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_104	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_104	:	
	jmp	scanner_transFunc_endif_102
scanner_transFunc_elsebl_102	:	

	movl	8(%ebp),%ebx
	cmpl	$1030,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_107
	movl	$0,%eax
scanner_transFunc_reltrue_107	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_106
	jmp	scanner_transFunc_elsebl_106
scanner_transFunc_ifbl_106	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$61,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_109
	movl	$0,%eax
scanner_transFunc_reltrue_109	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_108
	jmp	scanner_transFunc_elsebl_108
scanner_transFunc_ifbl_108	:	

	movl	$1031,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_108	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_108	:	
	jmp	scanner_transFunc_endif_106
scanner_transFunc_elsebl_106	:	

	movl	8(%ebp),%ebx
	cmpl	$1,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_111
	movl	$0,%eax
scanner_transFunc_reltrue_111	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_110
	jmp	scanner_transFunc_elsebl_110
scanner_transFunc_ifbl_110	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$102,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_113
	movl	$0,%eax
scanner_transFunc_reltrue_113	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_112
	jmp	scanner_transFunc_elsebl_112
scanner_transFunc_ifbl_112	:	

	movl	$1012,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_112	:	
scanner_transFunc_endif_112	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$110,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_115
	movl	$0,%eax
scanner_transFunc_reltrue_115	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_114
	jmp	scanner_transFunc_elsebl_114
scanner_transFunc_ifbl_114	:	

	movl	$3,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_114	:	
scanner_transFunc_endif_114	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_116
	jmp	scanner_transFunc_elsebl_116
scanner_transFunc_ifbl_116	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_116	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_116	:	
	jmp	scanner_transFunc_endif_110
scanner_transFunc_elsebl_110	:	

	movl	8(%ebp),%ebx
	cmpl	$3,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_118
	movl	$0,%eax
scanner_transFunc_reltrue_118	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_117
	jmp	scanner_transFunc_elsebl_117
scanner_transFunc_ifbl_117	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$116,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_120
	movl	$0,%eax
scanner_transFunc_reltrue_120	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_119
	jmp	scanner_transFunc_elsebl_119
scanner_transFunc_ifbl_119	:	

	movl	$1036,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_119	:	
scanner_transFunc_endif_119	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_121
	jmp	scanner_transFunc_elsebl_121
scanner_transFunc_ifbl_121	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_121	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_121	:	
	jmp	scanner_transFunc_endif_117
scanner_transFunc_elsebl_117	:	

	movl	8(%ebp),%ebx
	cmpl	$1036,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_123
	movl	$0,%eax
scanner_transFunc_reltrue_123	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_122
	jmp	scanner_transFunc_elsebl_122
scanner_transFunc_ifbl_122	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_124
	jmp	scanner_transFunc_elsebl_124
scanner_transFunc_ifbl_124	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_124	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_124	:	
	jmp	scanner_transFunc_endif_122
scanner_transFunc_elsebl_122	:	

	movl	8(%ebp),%ebx
	cmpl	$1012,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_126
	movl	$0,%eax
scanner_transFunc_reltrue_126	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_125
	jmp	scanner_transFunc_elsebl_125
scanner_transFunc_ifbl_125	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_127
	jmp	scanner_transFunc_elsebl_127
scanner_transFunc_ifbl_127	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_127	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_127	:	
	jmp	scanner_transFunc_endif_125
scanner_transFunc_elsebl_125	:	

	movl	8(%ebp),%ebx
	cmpl	$5,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_129
	movl	$0,%eax
scanner_transFunc_reltrue_129	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_128
	jmp	scanner_transFunc_elsebl_128
scanner_transFunc_ifbl_128	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$116,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_131
	movl	$0,%eax
scanner_transFunc_reltrue_131	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_130
	jmp	scanner_transFunc_elsebl_130
scanner_transFunc_ifbl_130	:	

	movl	$6,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_130	:	
scanner_transFunc_endif_130	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$105,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_133
	movl	$0,%eax
scanner_transFunc_reltrue_133	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_132
	jmp	scanner_transFunc_elsebl_132
scanner_transFunc_ifbl_132	:	

	movl	$39,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_132	:	
scanner_transFunc_endif_132	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_134
	jmp	scanner_transFunc_elsebl_134
scanner_transFunc_ifbl_134	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_134	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_134	:	
	jmp	scanner_transFunc_endif_128
scanner_transFunc_elsebl_128	:	

	movl	8(%ebp),%ebx
	cmpl	$6,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_136
	movl	$0,%eax
scanner_transFunc_reltrue_136	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_135
	jmp	scanner_transFunc_elsebl_135
scanner_transFunc_ifbl_135	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$114,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_138
	movl	$0,%eax
scanner_transFunc_reltrue_138	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_137
	jmp	scanner_transFunc_elsebl_137
scanner_transFunc_ifbl_137	:	

	movl	$7,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_137	:	
scanner_transFunc_endif_137	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_139
	jmp	scanner_transFunc_elsebl_139
scanner_transFunc_ifbl_139	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_139	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_139	:	
	jmp	scanner_transFunc_endif_135
scanner_transFunc_elsebl_135	:	

	movl	8(%ebp),%ebx
	cmpl	$7,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_141
	movl	$0,%eax
scanner_transFunc_reltrue_141	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_140
	jmp	scanner_transFunc_elsebl_140
scanner_transFunc_ifbl_140	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$117,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_143
	movl	$0,%eax
scanner_transFunc_reltrue_143	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_142
	jmp	scanner_transFunc_elsebl_142
scanner_transFunc_ifbl_142	:	

	movl	$8,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_142	:	
scanner_transFunc_endif_142	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_144
	jmp	scanner_transFunc_elsebl_144
scanner_transFunc_ifbl_144	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_144	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_144	:	
	jmp	scanner_transFunc_endif_140
scanner_transFunc_elsebl_140	:	

	movl	8(%ebp),%ebx
	cmpl	$8,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_146
	movl	$0,%eax
scanner_transFunc_reltrue_146	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_145
	jmp	scanner_transFunc_elsebl_145
scanner_transFunc_ifbl_145	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$99,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_148
	movl	$0,%eax
scanner_transFunc_reltrue_148	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_147
	jmp	scanner_transFunc_elsebl_147
scanner_transFunc_ifbl_147	:	

	movl	$9,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_147	:	
scanner_transFunc_endif_147	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_149
	jmp	scanner_transFunc_elsebl_149
scanner_transFunc_ifbl_149	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_149	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_149	:	
	jmp	scanner_transFunc_endif_145
scanner_transFunc_elsebl_145	:	

	movl	8(%ebp),%ebx
	cmpl	$9,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_151
	movl	$0,%eax
scanner_transFunc_reltrue_151	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_150
	jmp	scanner_transFunc_elsebl_150
scanner_transFunc_ifbl_150	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$116,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_153
	movl	$0,%eax
scanner_transFunc_reltrue_153	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_152
	jmp	scanner_transFunc_elsebl_152
scanner_transFunc_ifbl_152	:	

	movl	$1034,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_152	:	
scanner_transFunc_endif_152	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_154
	jmp	scanner_transFunc_elsebl_154
scanner_transFunc_ifbl_154	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_154	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_154	:	
	jmp	scanner_transFunc_endif_150
scanner_transFunc_elsebl_150	:	

	movl	8(%ebp),%ebx
	cmpl	$1034,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_156
	movl	$0,%eax
scanner_transFunc_reltrue_156	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_155
	jmp	scanner_transFunc_elsebl_155
scanner_transFunc_ifbl_155	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_157
	jmp	scanner_transFunc_elsebl_157
scanner_transFunc_ifbl_157	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_157	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_157	:	
	jmp	scanner_transFunc_endif_155
scanner_transFunc_elsebl_155	:	

	movl	8(%ebp),%ebx
	cmpl	$39,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_159
	movl	$0,%eax
scanner_transFunc_reltrue_159	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_158
	jmp	scanner_transFunc_elsebl_158
scanner_transFunc_ifbl_158	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$122,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_161
	movl	$0,%eax
scanner_transFunc_reltrue_161	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_160
	jmp	scanner_transFunc_elsebl_160
scanner_transFunc_ifbl_160	:	

	movl	$40,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_160	:	
scanner_transFunc_endif_160	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_162
	jmp	scanner_transFunc_elsebl_162
scanner_transFunc_ifbl_162	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_162	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_162	:	
	jmp	scanner_transFunc_endif_158
scanner_transFunc_elsebl_158	:	

	movl	8(%ebp),%ebx
	cmpl	$40,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_164
	movl	$0,%eax
scanner_transFunc_reltrue_164	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_163
	jmp	scanner_transFunc_elsebl_163
scanner_transFunc_ifbl_163	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$101,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_166
	movl	$0,%eax
scanner_transFunc_reltrue_166	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_165
	jmp	scanner_transFunc_elsebl_165
scanner_transFunc_ifbl_165	:	

	movl	$41,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_165	:	
scanner_transFunc_endif_165	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_167
	jmp	scanner_transFunc_elsebl_167
scanner_transFunc_ifbl_167	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_167	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_167	:	
	jmp	scanner_transFunc_endif_163
scanner_transFunc_elsebl_163	:	

	movl	8(%ebp),%ebx
	cmpl	$41,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_169
	movl	$0,%eax
scanner_transFunc_reltrue_169	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_168
	jmp	scanner_transFunc_elsebl_168
scanner_transFunc_ifbl_168	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$111,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_171
	movl	$0,%eax
scanner_transFunc_reltrue_171	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_170
	jmp	scanner_transFunc_elsebl_170
scanner_transFunc_ifbl_170	:	

	movl	$42,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_170	:	
scanner_transFunc_endif_170	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_172
	jmp	scanner_transFunc_elsebl_172
scanner_transFunc_ifbl_172	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_172	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_172	:	
	jmp	scanner_transFunc_endif_168
scanner_transFunc_elsebl_168	:	

	movl	8(%ebp),%ebx
	cmpl	$42,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_174
	movl	$0,%eax
scanner_transFunc_reltrue_174	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_173
	jmp	scanner_transFunc_elsebl_173
scanner_transFunc_ifbl_173	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$102,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_176
	movl	$0,%eax
scanner_transFunc_reltrue_176	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_175
	jmp	scanner_transFunc_elsebl_175
scanner_transFunc_ifbl_175	:	

	movl	$1039,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_175	:	
scanner_transFunc_endif_175	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_177
	jmp	scanner_transFunc_elsebl_177
scanner_transFunc_ifbl_177	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_177	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_177	:	
	jmp	scanner_transFunc_endif_173
scanner_transFunc_elsebl_173	:	

	movl	8(%ebp),%ebx
	cmpl	$1039,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_179
	movl	$0,%eax
scanner_transFunc_reltrue_179	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_178
	jmp	scanner_transFunc_elsebl_178
scanner_transFunc_ifbl_178	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_180
	jmp	scanner_transFunc_elsebl_180
scanner_transFunc_ifbl_180	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_180	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_180	:	
	jmp	scanner_transFunc_endif_178
scanner_transFunc_elsebl_178	:	

	movl	8(%ebp),%ebx
	cmpl	$11,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_182
	movl	$0,%eax
scanner_transFunc_reltrue_182	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_181
	jmp	scanner_transFunc_elsebl_181
scanner_transFunc_ifbl_181	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$108,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_184
	movl	$0,%eax
scanner_transFunc_reltrue_184	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_183
	jmp	scanner_transFunc_elsebl_183
scanner_transFunc_ifbl_183	:	

	movl	$12,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_183	:	
scanner_transFunc_endif_183	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_185
	jmp	scanner_transFunc_elsebl_185
scanner_transFunc_ifbl_185	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_185	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_185	:	
	jmp	scanner_transFunc_endif_181
scanner_transFunc_elsebl_181	:	

	movl	8(%ebp),%ebx
	cmpl	$12,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_187
	movl	$0,%eax
scanner_transFunc_reltrue_187	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_186
	jmp	scanner_transFunc_elsebl_186
scanner_transFunc_ifbl_186	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$115,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_189
	movl	$0,%eax
scanner_transFunc_reltrue_189	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_188
	jmp	scanner_transFunc_elsebl_188
scanner_transFunc_ifbl_188	:	

	movl	$13,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_188	:	
scanner_transFunc_endif_188	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_190
	jmp	scanner_transFunc_elsebl_190
scanner_transFunc_ifbl_190	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_190	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_190	:	
	jmp	scanner_transFunc_endif_186
scanner_transFunc_elsebl_186	:	

	movl	8(%ebp),%ebx
	cmpl	$13,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_192
	movl	$0,%eax
scanner_transFunc_reltrue_192	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_191
	jmp	scanner_transFunc_elsebl_191
scanner_transFunc_ifbl_191	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$101,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_194
	movl	$0,%eax
scanner_transFunc_reltrue_194	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_193
	jmp	scanner_transFunc_elsebl_193
scanner_transFunc_ifbl_193	:	

	movl	$1013,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_193	:	
scanner_transFunc_endif_193	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_195
	jmp	scanner_transFunc_elsebl_195
scanner_transFunc_ifbl_195	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_195	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_195	:	
	jmp	scanner_transFunc_endif_191
scanner_transFunc_elsebl_191	:	

	movl	8(%ebp),%ebx
	cmpl	$1013,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_197
	movl	$0,%eax
scanner_transFunc_reltrue_197	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_196
	jmp	scanner_transFunc_elsebl_196
scanner_transFunc_ifbl_196	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_198
	jmp	scanner_transFunc_elsebl_198
scanner_transFunc_ifbl_198	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_198	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_198	:	
	jmp	scanner_transFunc_endif_196
scanner_transFunc_elsebl_196	:	

	movl	8(%ebp),%ebx
	cmpl	$15,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_200
	movl	$0,%eax
scanner_transFunc_reltrue_200	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_199
	jmp	scanner_transFunc_elsebl_199
scanner_transFunc_ifbl_199	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$104,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_202
	movl	$0,%eax
scanner_transFunc_reltrue_202	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_201
	jmp	scanner_transFunc_elsebl_201
scanner_transFunc_ifbl_201	:	

	movl	$16,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_201	:	
scanner_transFunc_endif_201	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_203
	jmp	scanner_transFunc_elsebl_203
scanner_transFunc_ifbl_203	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_203	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_203	:	
	jmp	scanner_transFunc_endif_199
scanner_transFunc_elsebl_199	:	

	movl	8(%ebp),%ebx
	cmpl	$16,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_205
	movl	$0,%eax
scanner_transFunc_reltrue_205	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_204
	jmp	scanner_transFunc_elsebl_204
scanner_transFunc_ifbl_204	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$105,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_207
	movl	$0,%eax
scanner_transFunc_reltrue_207	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_206
	jmp	scanner_transFunc_elsebl_206
scanner_transFunc_ifbl_206	:	

	movl	$17,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_206	:	
scanner_transFunc_endif_206	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_208
	jmp	scanner_transFunc_elsebl_208
scanner_transFunc_ifbl_208	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_208	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_208	:	
	jmp	scanner_transFunc_endif_204
scanner_transFunc_elsebl_204	:	

	movl	8(%ebp),%ebx
	cmpl	$17,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_210
	movl	$0,%eax
scanner_transFunc_reltrue_210	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_209
	jmp	scanner_transFunc_elsebl_209
scanner_transFunc_ifbl_209	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$108,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_212
	movl	$0,%eax
scanner_transFunc_reltrue_212	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_211
	jmp	scanner_transFunc_elsebl_211
scanner_transFunc_ifbl_211	:	

	movl	$18,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_211	:	
scanner_transFunc_endif_211	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_213
	jmp	scanner_transFunc_elsebl_213
scanner_transFunc_ifbl_213	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_213	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_213	:	
	jmp	scanner_transFunc_endif_209
scanner_transFunc_elsebl_209	:	

	movl	8(%ebp),%ebx
	cmpl	$18,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_215
	movl	$0,%eax
scanner_transFunc_reltrue_215	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_214
	jmp	scanner_transFunc_elsebl_214
scanner_transFunc_ifbl_214	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$101,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_217
	movl	$0,%eax
scanner_transFunc_reltrue_217	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_216
	jmp	scanner_transFunc_elsebl_216
scanner_transFunc_ifbl_216	:	

	movl	$1014,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_216	:	
scanner_transFunc_endif_216	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_218
	jmp	scanner_transFunc_elsebl_218
scanner_transFunc_ifbl_218	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_218	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_218	:	
	jmp	scanner_transFunc_endif_214
scanner_transFunc_elsebl_214	:	

	movl	8(%ebp),%ebx
	cmpl	$1014,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_220
	movl	$0,%eax
scanner_transFunc_reltrue_220	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_219
	jmp	scanner_transFunc_elsebl_219
scanner_transFunc_ifbl_219	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_221
	jmp	scanner_transFunc_elsebl_221
scanner_transFunc_ifbl_221	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_221	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_221	:	
	jmp	scanner_transFunc_endif_219
scanner_transFunc_elsebl_219	:	

	movl	8(%ebp),%ebx
	cmpl	$20,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_223
	movl	$0,%eax
scanner_transFunc_reltrue_223	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_222
	jmp	scanner_transFunc_elsebl_222
scanner_transFunc_ifbl_222	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$101,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_225
	movl	$0,%eax
scanner_transFunc_reltrue_225	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_224
	jmp	scanner_transFunc_elsebl_224
scanner_transFunc_ifbl_224	:	

	movl	$21,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_224	:	
scanner_transFunc_endif_224	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_226
	jmp	scanner_transFunc_elsebl_226
scanner_transFunc_ifbl_226	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_226	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_226	:	
	jmp	scanner_transFunc_endif_222
scanner_transFunc_elsebl_222	:	

	movl	8(%ebp),%ebx
	cmpl	$21,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_228
	movl	$0,%eax
scanner_transFunc_reltrue_228	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_227
	jmp	scanner_transFunc_elsebl_227
scanner_transFunc_ifbl_227	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$116,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_230
	movl	$0,%eax
scanner_transFunc_reltrue_230	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_229
	jmp	scanner_transFunc_elsebl_229
scanner_transFunc_ifbl_229	:	

	movl	$22,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_229	:	
scanner_transFunc_endif_229	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_231
	jmp	scanner_transFunc_elsebl_231
scanner_transFunc_ifbl_231	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_231	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_231	:	
	jmp	scanner_transFunc_endif_227
scanner_transFunc_elsebl_227	:	

	movl	8(%ebp),%ebx
	cmpl	$22,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_233
	movl	$0,%eax
scanner_transFunc_reltrue_233	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_232
	jmp	scanner_transFunc_elsebl_232
scanner_transFunc_ifbl_232	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$117,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_235
	movl	$0,%eax
scanner_transFunc_reltrue_235	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_234
	jmp	scanner_transFunc_elsebl_234
scanner_transFunc_ifbl_234	:	

	movl	$23,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_234	:	
scanner_transFunc_endif_234	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_236
	jmp	scanner_transFunc_elsebl_236
scanner_transFunc_ifbl_236	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_236	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_236	:	
	jmp	scanner_transFunc_endif_232
scanner_transFunc_elsebl_232	:	

	movl	8(%ebp),%ebx
	cmpl	$23,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_238
	movl	$0,%eax
scanner_transFunc_reltrue_238	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_237
	jmp	scanner_transFunc_elsebl_237
scanner_transFunc_ifbl_237	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$114,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_240
	movl	$0,%eax
scanner_transFunc_reltrue_240	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_239
	jmp	scanner_transFunc_elsebl_239
scanner_transFunc_ifbl_239	:	

	movl	$24,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_239	:	
scanner_transFunc_endif_239	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_241
	jmp	scanner_transFunc_elsebl_241
scanner_transFunc_ifbl_241	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_241	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_241	:	
	jmp	scanner_transFunc_endif_237
scanner_transFunc_elsebl_237	:	

	movl	8(%ebp),%ebx
	cmpl	$24,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_243
	movl	$0,%eax
scanner_transFunc_reltrue_243	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_242
	jmp	scanner_transFunc_elsebl_242
scanner_transFunc_ifbl_242	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$110,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_245
	movl	$0,%eax
scanner_transFunc_reltrue_245	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_244
	jmp	scanner_transFunc_elsebl_244
scanner_transFunc_ifbl_244	:	

	movl	$1015,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_244	:	
scanner_transFunc_endif_244	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_246
	jmp	scanner_transFunc_elsebl_246
scanner_transFunc_ifbl_246	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_246	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_246	:	
	jmp	scanner_transFunc_endif_242
scanner_transFunc_elsebl_242	:	

	movl	8(%ebp),%ebx
	cmpl	$1015,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_248
	movl	$0,%eax
scanner_transFunc_reltrue_248	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_247
	jmp	scanner_transFunc_elsebl_247
scanner_transFunc_ifbl_247	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_249
	jmp	scanner_transFunc_elsebl_249
scanner_transFunc_ifbl_249	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_249	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_249	:	
	jmp	scanner_transFunc_endif_247
scanner_transFunc_elsebl_247	:	

	movl	8(%ebp),%ebx
	cmpl	$26,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_251
	movl	$0,%eax
scanner_transFunc_reltrue_251	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_250
	jmp	scanner_transFunc_elsebl_250
scanner_transFunc_ifbl_250	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$111,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_253
	movl	$0,%eax
scanner_transFunc_reltrue_253	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_252
	jmp	scanner_transFunc_elsebl_252
scanner_transFunc_ifbl_252	:	

	movl	$27,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_252	:	
scanner_transFunc_endif_252	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$104,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_255
	movl	$0,%eax
scanner_transFunc_reltrue_255	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_254
	jmp	scanner_transFunc_elsebl_254
scanner_transFunc_ifbl_254	:	

	movl	$31,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_254	:	
scanner_transFunc_endif_254	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_256
	jmp	scanner_transFunc_elsebl_256
scanner_transFunc_ifbl_256	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_256	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_256	:	
	jmp	scanner_transFunc_endif_250
scanner_transFunc_elsebl_250	:	

	movl	8(%ebp),%ebx
	cmpl	$27,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_258
	movl	$0,%eax
scanner_transFunc_reltrue_258	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_257
	jmp	scanner_transFunc_elsebl_257
scanner_transFunc_ifbl_257	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$110,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_260
	movl	$0,%eax
scanner_transFunc_reltrue_260	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_259
	jmp	scanner_transFunc_elsebl_259
scanner_transFunc_ifbl_259	:	

	movl	$28,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_259	:	
scanner_transFunc_endif_259	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_261
	jmp	scanner_transFunc_elsebl_261
scanner_transFunc_ifbl_261	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_261	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_261	:	
	jmp	scanner_transFunc_endif_257
scanner_transFunc_elsebl_257	:	

	movl	8(%ebp),%ebx
	cmpl	$28,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_263
	movl	$0,%eax
scanner_transFunc_reltrue_263	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_262
	jmp	scanner_transFunc_elsebl_262
scanner_transFunc_ifbl_262	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$115,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_265
	movl	$0,%eax
scanner_transFunc_reltrue_265	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_264
	jmp	scanner_transFunc_elsebl_264
scanner_transFunc_ifbl_264	:	

	movl	$29,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_264	:	
scanner_transFunc_endif_264	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$116,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_267
	movl	$0,%eax
scanner_transFunc_reltrue_267	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_266
	jmp	scanner_transFunc_elsebl_266
scanner_transFunc_ifbl_266	:	

	movl	$53,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_266	:	
scanner_transFunc_endif_266	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_268
	jmp	scanner_transFunc_elsebl_268
scanner_transFunc_ifbl_268	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_268	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_268	:	
	jmp	scanner_transFunc_endif_262
scanner_transFunc_elsebl_262	:	

	movl	8(%ebp),%ebx
	cmpl	$29,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_270
	movl	$0,%eax
scanner_transFunc_reltrue_270	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_269
	jmp	scanner_transFunc_elsebl_269
scanner_transFunc_ifbl_269	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$116,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_272
	movl	$0,%eax
scanner_transFunc_reltrue_272	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_271
	jmp	scanner_transFunc_elsebl_271
scanner_transFunc_ifbl_271	:	

	movl	$1035,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_271	:	
scanner_transFunc_endif_271	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_273
	jmp	scanner_transFunc_elsebl_273
scanner_transFunc_ifbl_273	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_273	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_273	:	
	jmp	scanner_transFunc_endif_269
scanner_transFunc_elsebl_269	:	

	movl	8(%ebp),%ebx
	cmpl	$1035,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_275
	movl	$0,%eax
scanner_transFunc_reltrue_275	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_274
	jmp	scanner_transFunc_elsebl_274
scanner_transFunc_ifbl_274	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_276
	jmp	scanner_transFunc_elsebl_276
scanner_transFunc_ifbl_276	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_276	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_276	:	
	jmp	scanner_transFunc_endif_274
scanner_transFunc_elsebl_274	:	

	movl	8(%ebp),%ebx
	cmpl	$53,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_278
	movl	$0,%eax
scanner_transFunc_reltrue_278	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_277
	jmp	scanner_transFunc_elsebl_277
scanner_transFunc_ifbl_277	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$105,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_280
	movl	$0,%eax
scanner_transFunc_reltrue_280	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_279
	jmp	scanner_transFunc_elsebl_279
scanner_transFunc_ifbl_279	:	

	movl	$54,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_279	:	
scanner_transFunc_endif_279	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_281
	jmp	scanner_transFunc_elsebl_281
scanner_transFunc_ifbl_281	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_281	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_281	:	
	jmp	scanner_transFunc_endif_277
scanner_transFunc_elsebl_277	:	

	movl	8(%ebp),%ebx
	cmpl	$54,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_283
	movl	$0,%eax
scanner_transFunc_reltrue_283	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_282
	jmp	scanner_transFunc_elsebl_282
scanner_transFunc_ifbl_282	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$110,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_285
	movl	$0,%eax
scanner_transFunc_reltrue_285	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_284
	jmp	scanner_transFunc_elsebl_284
scanner_transFunc_ifbl_284	:	

	movl	$55,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_284	:	
scanner_transFunc_endif_284	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_286
	jmp	scanner_transFunc_elsebl_286
scanner_transFunc_ifbl_286	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_286	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_286	:	
	jmp	scanner_transFunc_endif_282
scanner_transFunc_elsebl_282	:	

	movl	8(%ebp),%ebx
	cmpl	$55,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_288
	movl	$0,%eax
scanner_transFunc_reltrue_288	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_287
	jmp	scanner_transFunc_elsebl_287
scanner_transFunc_ifbl_287	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$117,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_290
	movl	$0,%eax
scanner_transFunc_reltrue_290	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_289
	jmp	scanner_transFunc_elsebl_289
scanner_transFunc_ifbl_289	:	

	movl	$56,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_289	:	
scanner_transFunc_endif_289	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_291
	jmp	scanner_transFunc_elsebl_291
scanner_transFunc_ifbl_291	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_291	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_291	:	
	jmp	scanner_transFunc_endif_287
scanner_transFunc_elsebl_287	:	

	movl	8(%ebp),%ebx
	cmpl	$56,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_293
	movl	$0,%eax
scanner_transFunc_reltrue_293	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_292
	jmp	scanner_transFunc_elsebl_292
scanner_transFunc_ifbl_292	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$101,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_295
	movl	$0,%eax
scanner_transFunc_reltrue_295	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_294
	jmp	scanner_transFunc_elsebl_294
scanner_transFunc_ifbl_294	:	

	movl	$1042,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_294	:	
scanner_transFunc_endif_294	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_296
	jmp	scanner_transFunc_elsebl_296
scanner_transFunc_ifbl_296	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_296	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_296	:	
	jmp	scanner_transFunc_endif_292
scanner_transFunc_elsebl_292	:	

	movl	8(%ebp),%ebx
	cmpl	$1042,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_298
	movl	$0,%eax
scanner_transFunc_reltrue_298	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_297
	jmp	scanner_transFunc_elsebl_297
scanner_transFunc_ifbl_297	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_299
	jmp	scanner_transFunc_elsebl_299
scanner_transFunc_ifbl_299	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_299	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_299	:	
	jmp	scanner_transFunc_endif_297
scanner_transFunc_elsebl_297	:	

	movl	8(%ebp),%ebx
	cmpl	$31,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_301
	movl	$0,%eax
scanner_transFunc_reltrue_301	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_300
	jmp	scanner_transFunc_elsebl_300
scanner_transFunc_ifbl_300	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$97,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_303
	movl	$0,%eax
scanner_transFunc_reltrue_303	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_302
	jmp	scanner_transFunc_elsebl_302
scanner_transFunc_ifbl_302	:	

	movl	$32,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_302	:	
scanner_transFunc_endif_302	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_304
	jmp	scanner_transFunc_elsebl_304
scanner_transFunc_ifbl_304	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_304	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_304	:	
	jmp	scanner_transFunc_endif_300
scanner_transFunc_elsebl_300	:	

	movl	8(%ebp),%ebx
	cmpl	$32,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_306
	movl	$0,%eax
scanner_transFunc_reltrue_306	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_305
	jmp	scanner_transFunc_elsebl_305
scanner_transFunc_ifbl_305	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$114,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_308
	movl	$0,%eax
scanner_transFunc_reltrue_308	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_307
	jmp	scanner_transFunc_elsebl_307
scanner_transFunc_ifbl_307	:	

	movl	$1037,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_307	:	
scanner_transFunc_endif_307	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_309
	jmp	scanner_transFunc_elsebl_309
scanner_transFunc_ifbl_309	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_309	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_309	:	
	jmp	scanner_transFunc_endif_305
scanner_transFunc_elsebl_305	:	

	movl	8(%ebp),%ebx
	cmpl	$1037,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_311
	movl	$0,%eax
scanner_transFunc_reltrue_311	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_310
	jmp	scanner_transFunc_elsebl_310
scanner_transFunc_ifbl_310	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_312
	jmp	scanner_transFunc_elsebl_312
scanner_transFunc_ifbl_312	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_312	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_312	:	
	jmp	scanner_transFunc_endif_310
scanner_transFunc_elsebl_310	:	

	movl	8(%ebp),%ebx
	cmpl	$34,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_314
	movl	$0,%eax
scanner_transFunc_reltrue_314	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_313
	jmp	scanner_transFunc_elsebl_313
scanner_transFunc_ifbl_313	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$111,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_316
	movl	$0,%eax
scanner_transFunc_reltrue_316	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_315
	jmp	scanner_transFunc_elsebl_315
scanner_transFunc_ifbl_315	:	

	movl	$35,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_315	:	
scanner_transFunc_endif_315	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_317
	jmp	scanner_transFunc_elsebl_317
scanner_transFunc_ifbl_317	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_317	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_317	:	
	jmp	scanner_transFunc_endif_313
scanner_transFunc_elsebl_313	:	

	movl	8(%ebp),%ebx
	cmpl	$35,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_319
	movl	$0,%eax
scanner_transFunc_reltrue_319	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_318
	jmp	scanner_transFunc_elsebl_318
scanner_transFunc_ifbl_318	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$105,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_321
	movl	$0,%eax
scanner_transFunc_reltrue_321	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_320
	jmp	scanner_transFunc_elsebl_320
scanner_transFunc_ifbl_320	:	

	movl	$36,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_320	:	
scanner_transFunc_endif_320	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_322
	jmp	scanner_transFunc_elsebl_322
scanner_transFunc_ifbl_322	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_322	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_322	:	
	jmp	scanner_transFunc_endif_318
scanner_transFunc_elsebl_318	:	

	movl	8(%ebp),%ebx
	cmpl	$36,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_324
	movl	$0,%eax
scanner_transFunc_reltrue_324	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_323
	jmp	scanner_transFunc_elsebl_323
scanner_transFunc_ifbl_323	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$100,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_326
	movl	$0,%eax
scanner_transFunc_reltrue_326	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_325
	jmp	scanner_transFunc_elsebl_325
scanner_transFunc_ifbl_325	:	

	movl	$1038,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_325	:	
scanner_transFunc_endif_325	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_327
	jmp	scanner_transFunc_elsebl_327
scanner_transFunc_ifbl_327	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_327	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_327	:	
	jmp	scanner_transFunc_endif_323
scanner_transFunc_elsebl_323	:	

	movl	8(%ebp),%ebx
	cmpl	$1038,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_329
	movl	$0,%eax
scanner_transFunc_reltrue_329	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_328
	jmp	scanner_transFunc_elsebl_328
scanner_transFunc_ifbl_328	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_330
	jmp	scanner_transFunc_elsebl_330
scanner_transFunc_ifbl_330	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_330	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_330	:	
	jmp	scanner_transFunc_endif_328
scanner_transFunc_elsebl_328	:	

	movl	8(%ebp),%ebx
	cmpl	$43,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_332
	movl	$0,%eax
scanner_transFunc_reltrue_332	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_331
	jmp	scanner_transFunc_elsebl_331
scanner_transFunc_ifbl_331	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$121,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_334
	movl	$0,%eax
scanner_transFunc_reltrue_334	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_333
	jmp	scanner_transFunc_elsebl_333
scanner_transFunc_ifbl_333	:	

	movl	$44,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_333	:	
scanner_transFunc_endif_333	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_335
	jmp	scanner_transFunc_elsebl_335
scanner_transFunc_ifbl_335	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_335	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_335	:	
	jmp	scanner_transFunc_endif_331
scanner_transFunc_elsebl_331	:	

	movl	8(%ebp),%ebx
	cmpl	$44,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_337
	movl	$0,%eax
scanner_transFunc_reltrue_337	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_336
	jmp	scanner_transFunc_elsebl_336
scanner_transFunc_ifbl_336	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$112,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_339
	movl	$0,%eax
scanner_transFunc_reltrue_339	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_338
	jmp	scanner_transFunc_elsebl_338
scanner_transFunc_ifbl_338	:	

	movl	$45,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_338	:	
scanner_transFunc_endif_338	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_340
	jmp	scanner_transFunc_elsebl_340
scanner_transFunc_ifbl_340	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_340	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_340	:	
	jmp	scanner_transFunc_endif_336
scanner_transFunc_elsebl_336	:	

	movl	8(%ebp),%ebx
	cmpl	$45,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_342
	movl	$0,%eax
scanner_transFunc_reltrue_342	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_341
	jmp	scanner_transFunc_elsebl_341
scanner_transFunc_ifbl_341	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$101,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_344
	movl	$0,%eax
scanner_transFunc_reltrue_344	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_343
	jmp	scanner_transFunc_elsebl_343
scanner_transFunc_ifbl_343	:	

	movl	$46,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_343	:	
scanner_transFunc_endif_343	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_345
	jmp	scanner_transFunc_elsebl_345
scanner_transFunc_ifbl_345	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_345	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_345	:	
	jmp	scanner_transFunc_endif_341
scanner_transFunc_elsebl_341	:	

	movl	8(%ebp),%ebx
	cmpl	$46,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_347
	movl	$0,%eax
scanner_transFunc_reltrue_347	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_346
	jmp	scanner_transFunc_elsebl_346
scanner_transFunc_ifbl_346	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$100,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_349
	movl	$0,%eax
scanner_transFunc_reltrue_349	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_348
	jmp	scanner_transFunc_elsebl_348
scanner_transFunc_ifbl_348	:	

	movl	$47,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_348	:	
scanner_transFunc_endif_348	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_350
	jmp	scanner_transFunc_elsebl_350
scanner_transFunc_ifbl_350	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_350	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_350	:	
	jmp	scanner_transFunc_endif_346
scanner_transFunc_elsebl_346	:	

	movl	8(%ebp),%ebx
	cmpl	$47,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_352
	movl	$0,%eax
scanner_transFunc_reltrue_352	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_351
	jmp	scanner_transFunc_elsebl_351
scanner_transFunc_ifbl_351	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$101,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_354
	movl	$0,%eax
scanner_transFunc_reltrue_354	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_353
	jmp	scanner_transFunc_elsebl_353
scanner_transFunc_ifbl_353	:	

	movl	$48,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_353	:	
scanner_transFunc_endif_353	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_355
	jmp	scanner_transFunc_elsebl_355
scanner_transFunc_ifbl_355	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_355	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_355	:	
	jmp	scanner_transFunc_endif_351
scanner_transFunc_elsebl_351	:	

	movl	8(%ebp),%ebx
	cmpl	$48,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_357
	movl	$0,%eax
scanner_transFunc_reltrue_357	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_356
	jmp	scanner_transFunc_elsebl_356
scanner_transFunc_ifbl_356	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$102,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_359
	movl	$0,%eax
scanner_transFunc_reltrue_359	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_358
	jmp	scanner_transFunc_elsebl_358
scanner_transFunc_ifbl_358	:	

	movl	$1040,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_358	:	
scanner_transFunc_endif_358	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_360
	jmp	scanner_transFunc_elsebl_360
scanner_transFunc_ifbl_360	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_360	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_360	:	
	jmp	scanner_transFunc_endif_356
scanner_transFunc_elsebl_356	:	

	movl	8(%ebp),%ebx
	cmpl	$1040,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_362
	movl	$0,%eax
scanner_transFunc_reltrue_362	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_361
	jmp	scanner_transFunc_elsebl_361
scanner_transFunc_ifbl_361	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_363
	jmp	scanner_transFunc_elsebl_363
scanner_transFunc_ifbl_363	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_363	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_363	:	
	jmp	scanner_transFunc_endif_361
scanner_transFunc_elsebl_361	:	

	movl	8(%ebp),%ebx
	cmpl	$49,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_365
	movl	$0,%eax
scanner_transFunc_reltrue_365	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_364
	jmp	scanner_transFunc_elsebl_364
scanner_transFunc_ifbl_364	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$114,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_367
	movl	$0,%eax
scanner_transFunc_reltrue_367	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_366
	jmp	scanner_transFunc_elsebl_366
scanner_transFunc_ifbl_366	:	

	movl	$50,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_366	:	
scanner_transFunc_endif_366	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_368
	jmp	scanner_transFunc_elsebl_368
scanner_transFunc_ifbl_368	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_368	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_368	:	
	jmp	scanner_transFunc_endif_364
scanner_transFunc_elsebl_364	:	

	movl	8(%ebp),%ebx
	cmpl	$50,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_370
	movl	$0,%eax
scanner_transFunc_reltrue_370	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_369
	jmp	scanner_transFunc_elsebl_369
scanner_transFunc_ifbl_369	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$101,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_372
	movl	$0,%eax
scanner_transFunc_reltrue_372	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_371
	jmp	scanner_transFunc_elsebl_371
scanner_transFunc_ifbl_371	:	

	movl	$51,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_371	:	
scanner_transFunc_endif_371	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_373
	jmp	scanner_transFunc_elsebl_373
scanner_transFunc_ifbl_373	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_373	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_373	:	
	jmp	scanner_transFunc_endif_369
scanner_transFunc_elsebl_369	:	

	movl	8(%ebp),%ebx
	cmpl	$51,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_375
	movl	$0,%eax
scanner_transFunc_reltrue_375	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_374
	jmp	scanner_transFunc_elsebl_374
scanner_transFunc_ifbl_374	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$97,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_377
	movl	$0,%eax
scanner_transFunc_reltrue_377	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_376
	jmp	scanner_transFunc_elsebl_376
scanner_transFunc_ifbl_376	:	

	movl	$52,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_376	:	
scanner_transFunc_endif_376	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_378
	jmp	scanner_transFunc_elsebl_378
scanner_transFunc_ifbl_378	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_378	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_378	:	
	jmp	scanner_transFunc_endif_374
scanner_transFunc_elsebl_374	:	

	movl	8(%ebp),%ebx
	cmpl	$52,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_380
	movl	$0,%eax
scanner_transFunc_reltrue_380	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_379
	jmp	scanner_transFunc_elsebl_379
scanner_transFunc_ifbl_379	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$107,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_382
	movl	$0,%eax
scanner_transFunc_reltrue_382	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_381
	jmp	scanner_transFunc_elsebl_381
scanner_transFunc_ifbl_381	:	

	movl	$1041,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_381	:	
scanner_transFunc_endif_381	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_383
	jmp	scanner_transFunc_elsebl_383
scanner_transFunc_ifbl_383	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_383	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_383	:	
	jmp	scanner_transFunc_endif_379
scanner_transFunc_elsebl_379	:	

	movl	8(%ebp),%ebx
	cmpl	$1041,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_385
	movl	$0,%eax
scanner_transFunc_reltrue_385	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_384
	jmp	scanner_transFunc_elsebl_384
scanner_transFunc_ifbl_384	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_386
	jmp	scanner_transFunc_elsebl_386
scanner_transFunc_ifbl_386	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_386	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_386	:	
	jmp	scanner_transFunc_endif_384
scanner_transFunc_elsebl_384	:	

	movl	8(%ebp),%ebx
	cmpl	$1000,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_389
	movl	$0,%eax
scanner_transFunc_reltrue_389	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1001,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_390
	movl	$0,%eax
scanner_transFunc_reltrue_390	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1002,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_391
	movl	$0,%eax
scanner_transFunc_reltrue_391	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1003,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_392
	movl	$0,%eax
scanner_transFunc_reltrue_392	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1004,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_393
	movl	$0,%eax
scanner_transFunc_reltrue_393	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1005,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_394
	movl	$0,%eax
scanner_transFunc_reltrue_394	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1006,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_395
	movl	$0,%eax
scanner_transFunc_reltrue_395	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1007,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_396
	movl	$0,%eax
scanner_transFunc_reltrue_396	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1008,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_397
	movl	$0,%eax
scanner_transFunc_reltrue_397	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1009,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_398
	movl	$0,%eax
scanner_transFunc_reltrue_398	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1010,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_399
	movl	$0,%eax
scanner_transFunc_reltrue_399	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1016,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_400
	movl	$0,%eax
scanner_transFunc_reltrue_400	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1018,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_401
	movl	$0,%eax
scanner_transFunc_reltrue_401	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1019,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_402
	movl	$0,%eax
scanner_transFunc_reltrue_402	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1020,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_403
	movl	$0,%eax
scanner_transFunc_reltrue_403	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1023,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_404
	movl	$0,%eax
scanner_transFunc_reltrue_404	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1024,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_405
	movl	$0,%eax
scanner_transFunc_reltrue_405	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1025,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_406
	movl	$0,%eax
scanner_transFunc_reltrue_406	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1026,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_407
	movl	$0,%eax
scanner_transFunc_reltrue_407	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1027,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_408
	movl	$0,%eax
scanner_transFunc_reltrue_408	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1029,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_409
	movl	$0,%eax
scanner_transFunc_reltrue_409	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1031,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_410
	movl	$0,%eax
scanner_transFunc_reltrue_410	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1032,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_411
	movl	$0,%eax
scanner_transFunc_reltrue_411	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1045,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_412
	movl	$0,%eax
scanner_transFunc_reltrue_412	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	8(%ebp),%ebx
	cmpl	$1046,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_413
	movl	$0,%eax
scanner_transFunc_reltrue_413	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_logexprtrue_388
	movl	$0,%eax
	jmp	scanner_transFunc_logexprfalse_388
scanner_transFunc_logexprtrue_388	:	
	movl	$1,%eax
scanner_transFunc_logexprfalse_388	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_387
	jmp	scanner_transFunc_elsebl_387
scanner_transFunc_ifbl_387	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_387	:	

	movl	8(%ebp),%ebx
	cmpl	$1043,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_415
	movl	$0,%eax
scanner_transFunc_reltrue_415	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_414
	jmp	scanner_transFunc_elsebl_414
scanner_transFunc_ifbl_414	:	

	subl	$1,%esp
	movb	12(%ebp),%ah
	movb	%ah,0(%esp)
	call	isIdentChar
	addl	$1,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_416
	jmp	scanner_transFunc_elsebl_416
scanner_transFunc_ifbl_416	:	

	movl	$1043,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_416	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_416	:	
	jmp	scanner_transFunc_endif_414
scanner_transFunc_elsebl_414	:	

	movl	8(%ebp),%ebx
	cmpl	$1044,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_418
	movl	$0,%eax
scanner_transFunc_reltrue_418	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_417
	jmp	scanner_transFunc_elsebl_417
scanner_transFunc_ifbl_417	:	

	subl	$4,%esp
	movb	12(%ebp),%ah
	movsbl	%ah,%eax
	movl	%eax,0(%esp)
	call	isdigit
	addl	$4,%esp
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_419
	jmp	scanner_transFunc_elsebl_419
scanner_transFunc_ifbl_419	:	

	movl	$1044,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_419	:	

	movl	$2000,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_419	:	
	jmp	scanner_transFunc_endif_417
scanner_transFunc_elsebl_417	:	

	movl	8(%ebp),%ebx
	cmpl	$37,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_421
	movl	$0,%eax
scanner_transFunc_reltrue_421	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_420
	jmp	scanner_transFunc_elsebl_420
scanner_transFunc_ifbl_420	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$34,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_423
	movl	$0,%eax
scanner_transFunc_reltrue_423	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_422
	jmp	scanner_transFunc_elsebl_422
scanner_transFunc_ifbl_422	:	

	movl	$1045,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_422	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$92,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_425
	movl	$0,%eax
scanner_transFunc_reltrue_425	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_424
	jmp	scanner_transFunc_elsebl_424
scanner_transFunc_ifbl_424	:	

	movl	$57,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_424	:	

	movl	$37,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_424	:	
scanner_transFunc_endif_422	:	
	jmp	scanner_transFunc_endif_420
scanner_transFunc_elsebl_420	:	

	movl	8(%ebp),%ebx
	cmpl	$38,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_427
	movl	$0,%eax
scanner_transFunc_reltrue_427	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_426
	jmp	scanner_transFunc_elsebl_426
scanner_transFunc_ifbl_426	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$39,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_429
	movl	$0,%eax
scanner_transFunc_reltrue_429	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_428
	jmp	scanner_transFunc_elsebl_428
scanner_transFunc_ifbl_428	:	

	movl	$1046,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_428	:	

	movsbl	12(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$92,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_431
	movl	$0,%eax
scanner_transFunc_reltrue_431	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_430
	jmp	scanner_transFunc_elsebl_430
scanner_transFunc_ifbl_430	:	

	movl	$58,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_430	:	

	movl	$38,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_endif_430	:	
scanner_transFunc_endif_428	:	
	jmp	scanner_transFunc_endif_426
scanner_transFunc_elsebl_426	:	

	movl	8(%ebp),%ebx
	cmpl	$57,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_433
	movl	$0,%eax
scanner_transFunc_reltrue_433	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_432
	jmp	scanner_transFunc_elsebl_432
scanner_transFunc_ifbl_432	:	

	movl	$37,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_432	:	

	movl	8(%ebp),%ebx
	cmpl	$58,%ebx
	movl	$1,%eax
	je	scanner_transFunc_reltrue_435
	movl	$0,%eax
scanner_transFunc_reltrue_435	:	
	testl	%eax,%eax
	jnz	scanner_transFunc_ifbl_434
	jmp	scanner_transFunc_elsebl_434
scanner_transFunc_ifbl_434	:	

	movl	$38,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_elsebl_434	:	
scanner_transFunc_endif_434	:	
scanner_transFunc_endif_432	:	
scanner_transFunc_endif_426	:	
scanner_transFunc_endif_420	:	
scanner_transFunc_endif_417	:	
scanner_transFunc_endif_414	:	
scanner_transFunc_endif_387	:	
scanner_transFunc_endif_384	:	
scanner_transFunc_endif_379	:	
scanner_transFunc_endif_374	:	
scanner_transFunc_endif_369	:	
scanner_transFunc_endif_364	:	
scanner_transFunc_endif_361	:	
scanner_transFunc_endif_356	:	
scanner_transFunc_endif_351	:	
scanner_transFunc_endif_346	:	
scanner_transFunc_endif_341	:	
scanner_transFunc_endif_336	:	
scanner_transFunc_endif_331	:	
scanner_transFunc_endif_328	:	
scanner_transFunc_endif_323	:	
scanner_transFunc_endif_318	:	
scanner_transFunc_endif_313	:	
scanner_transFunc_endif_310	:	
scanner_transFunc_endif_305	:	
scanner_transFunc_endif_300	:	
scanner_transFunc_endif_297	:	
scanner_transFunc_endif_292	:	
scanner_transFunc_endif_287	:	
scanner_transFunc_endif_282	:	
scanner_transFunc_endif_277	:	
scanner_transFunc_endif_274	:	
scanner_transFunc_endif_269	:	
scanner_transFunc_endif_262	:	
scanner_transFunc_endif_257	:	
scanner_transFunc_endif_250	:	
scanner_transFunc_endif_247	:	
scanner_transFunc_endif_242	:	
scanner_transFunc_endif_237	:	
scanner_transFunc_endif_232	:	
scanner_transFunc_endif_227	:	
scanner_transFunc_endif_222	:	
scanner_transFunc_endif_219	:	
scanner_transFunc_endif_214	:	
scanner_transFunc_endif_209	:	
scanner_transFunc_endif_204	:	
scanner_transFunc_endif_199	:	
scanner_transFunc_endif_196	:	
scanner_transFunc_endif_191	:	
scanner_transFunc_endif_186	:	
scanner_transFunc_endif_181	:	
scanner_transFunc_endif_178	:	
scanner_transFunc_endif_173	:	
scanner_transFunc_endif_168	:	
scanner_transFunc_endif_163	:	
scanner_transFunc_endif_158	:	
scanner_transFunc_endif_155	:	
scanner_transFunc_endif_150	:	
scanner_transFunc_endif_145	:	
scanner_transFunc_endif_140	:	
scanner_transFunc_endif_135	:	
scanner_transFunc_endif_128	:	
scanner_transFunc_endif_125	:	
scanner_transFunc_endif_122	:	
scanner_transFunc_endif_117	:	
scanner_transFunc_endif_110	:	
scanner_transFunc_endif_106	:	
scanner_transFunc_endif_102	:	
scanner_transFunc_endif_98	:	
scanner_transFunc_endif_94	:	
scanner_transFunc_endif_90	:	
scanner_transFunc_endif_86	:	
scanner_transFunc_endif_82	:	
scanner_transFunc_endif_4	:	

	subl	$8,%esp
	movl	$symtab+69,0(%esp)
	movl	8(%ebp),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	movl	$0,%ebx
	subl	$2,%ebx
	movl	%ebx,%eax
	jmp	scanner_transFunc_ret
scanner_transFunc_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	scanner_readChar
.type	scanner_readChar,@function
scanner_readChar	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$17,%eax
	movl	(%eax),%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	%eax,4(%esp)
	call	preproc_getNext
	addl	$8,%esp
scanner_readChar_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	scanner_init
.type	scanner_init,@function
scanner_init	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	subl	$12,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$0,4(%esp)
	movl	$21,8(%esp)
	call	memset
	addl	$12,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$17,%eax
	pushl	%eax
	movl	12(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$13,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	scanner_readChar
	addl	$4,%esp

	movl	$0,%eax
	jmp	scanner_init_ret
scanner_init_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	scanner_getToken
.type	scanner_getToken,@function
scanner_getToken	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$8,%esp

	movl	$0,-4(%ebp)

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$13,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	scanner_getToken_reltrue_437
	movl	$0,%eax
scanner_getToken_reltrue_437	:	
	testl	%eax,%eax
	jnz	scanner_getToken_ifbl_436
	jmp	scanner_getToken_elsebl_436
scanner_getToken_ifbl_436	:	

	subl	$8,%esp
	movl	$symtab+140,0(%esp)
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$13,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	pushl	%eax
	movl	$0,%ebx
	subl	$3,%ebx
	movl	%ebx,%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	scanner_getToken_ret
scanner_getToken_elsebl_436	:	
scanner_getToken_endif_436	:	

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	pushl	%eax
	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	pushl	%eax
	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$12,%eax
	pushl	%eax
	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	movl	%eax,(%ebx)

scanner_getToken_while_438	:	
	movl	$1,%eax
	testl	%eax,%eax
	jz	scanner_getToken_endwhile_438

	pushl	-4(%ebp)
	movl	$128,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	cmpl	%eax,%ebx
	movl	$1,%eax
	jge	scanner_getToken_reltrue_440
	movl	$0,%eax
scanner_getToken_reltrue_440	:	
	testl	%eax,%eax
	jnz	scanner_getToken_ifbl_439
	jmp	scanner_getToken_elsebl_439
scanner_getToken_ifbl_439	:	

	subl	$8,%esp
	movl	$symtab+189,0(%esp)
	movl	$128,4(%esp)
	call	printf
	addl	$8,%esp
	jmp	scanner_getToken_endwhile_438
scanner_getToken_elsebl_439	:	
scanner_getToken_endif_439	:	

	subl	$5,%esp
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$13,%eax
	movl	(%eax),%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	addl	$0,%eax
	movb	(%eax),%al
	movb	%al,4(%esp)
	call	scanner_transFunc
	addl	$5,%esp
	movl	%eax,-8(%ebp)

	movl	-8(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	scanner_getToken_reltrue_443
	movl	$0,%eax
scanner_getToken_reltrue_443	:	
	testl	%eax,%eax
	jz	scanner_getToken_logtermfalse_442
	movl	-8(%ebp),%ebx
	cmpl	$2000,%ebx
	movl	$1,%eax
	jne	scanner_getToken_reltrue_444
	movl	$0,%eax
scanner_getToken_reltrue_444	:	
	testl	%eax,%eax
	jz	scanner_getToken_logtermfalse_442
	movl	$1,%eax
	jmp	scanner_getToken_logtermtrue_442
scanner_getToken_logtermfalse_442	:	
	movl	$0,%eax
scanner_getToken_logtermtrue_442	:	
	testl	%eax,%eax
	jnz	scanner_getToken_ifbl_441
	jmp	scanner_getToken_elsebl_441
scanner_getToken_ifbl_441	:	

	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$16,%eax
	popl	%esi
	addl	%esi,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	addl	$0,%eax
	movb	(%eax),%al
	popl	%ebx
	movb	%al,(%ebx)

	movl	-4(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)

	movl	-4(%ebp),%ebx
	cmpl	$1,%ebx
	movl	$1,%eax
	je	scanner_getToken_reltrue_446
	movl	$0,%eax
scanner_getToken_reltrue_446	:	
	testl	%eax,%eax
	jnz	scanner_getToken_ifbl_445
	jmp	scanner_getToken_elsebl_445
scanner_getToken_ifbl_445	:	

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	addl	$5,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	addl	$9,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$12,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	addl	$1,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)
	jmp	scanner_getToken_endif_445
scanner_getToken_elsebl_445	:	
scanner_getToken_endif_445	:	
	jmp	scanner_getToken_endif_441
scanner_getToken_elsebl_441	:	
scanner_getToken_endif_441	:	

	movl	-8(%ebp),%ebx
	cmpl	$2000,%ebx
	movl	$1,%eax
	je	scanner_getToken_reltrue_448
	movl	$0,%eax
scanner_getToken_reltrue_448	:	
	testl	%eax,%eax
	jnz	scanner_getToken_ifbl_447
	jmp	scanner_getToken_elsebl_447
scanner_getToken_ifbl_447	:	

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	pushl	%eax
	subl	$4,%esp
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$13,%eax
	movl	(%eax),%eax
	movl	%eax,0(%esp)
	call	getTokenCode
	addl	$4,%esp
	popl	%ebx
	movl	%eax,(%ebx)
	jmp	scanner_getToken_endwhile_438
scanner_getToken_elsebl_447	:	
scanner_getToken_endif_447	:	

	movl	-8(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	scanner_getToken_reltrue_450
	movl	$0,%eax
scanner_getToken_reltrue_450	:	
	testl	%eax,%eax
	jnz	scanner_getToken_ifbl_449
	jmp	scanner_getToken_elsebl_449
scanner_getToken_ifbl_449	:	

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	pushl	%eax
	movl	-8(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	scanner_readChar
	addl	$4,%esp
	jmp	scanner_getToken_endwhile_438
scanner_getToken_elsebl_449	:	
scanner_getToken_endif_449	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$13,%eax
	pushl	%eax
	movl	-8(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	scanner_readChar
	addl	$4,%esp
	jmp	scanner_getToken_while_438
scanner_getToken_endwhile_438	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$13,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)

	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$16,%eax
	popl	%esi
	addl	%esi,%eax
	movl	%eax,%ebx
	movb	$0,(%ebx)

	movl	$0,%eax
	jmp	scanner_getToken_ret
scanner_getToken_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.section	.data
symtab	:	
.string	"SCANNER_WARNING: Invalid input character %c"
.string	" (0x%hhx) at (ignored).\n"
.string	"SCANNER_ERROR: Scanner state not handled by transition function! (%d)\n"
.string	"SCANNER_ERROR: Scanner was not intialized. (%d)\n"
.string	"SCANNER_ERROR: Scanner reached max. token size. (%d)\n"
