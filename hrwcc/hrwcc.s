
.section	.text

.globl	hrwcc_asmOptimize
.type	hrwcc_asmOptimize,@function
hrwcc_asmOptimize	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$268,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-268,%eax
	movl	%eax,0(%esp)
	movl	8(%ebp),%eax
	movl	%eax,4(%esp)
	call	strcpy
	addl	$8,%esp

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-268,%eax
	movl	%eax,0(%esp)
	call	hrwcc_setToAsm
	addl	$4,%esp

	subl	$12,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$0,4(%esp)
	movl	$0,8(%esp)
	call	open
	addl	$12,%esp
	movl	%eax,-8(%ebp)

	movl	-8(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	hrwcc_asmOptimize_reltrue_1
	movl	$0,%eax
hrwcc_asmOptimize_reltrue_1	:	
	testl	%eax,%eax
	jnz	hrwcc_asmOptimize_ifbl_0
	jmp	hrwcc_asmOptimize_elsebl_0
hrwcc_asmOptimize_ifbl_0	:	

	subl	$4,%esp
	movl	$symtab+0,0(%esp)
	call	puts
	addl	$4,%esp

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	hrwcc_asmOptimize_ret
hrwcc_asmOptimize_elsebl_0	:	
hrwcc_asmOptimize_endif_0	:	

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-268,%eax
	movl	%eax,0(%esp)
	movl	$64,%ebx
	orl	$512,%ebx
	orl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,4(%esp)
	movl	$6,%ebx
	imull	$8,%ebx
	imull	$8,%ebx
	movl	%ebx,%eax
	pushl	%eax
	movl	$4,%ebx
	imull	$8,%ebx
	movl	%ebx,%eax
	popl	%ebx
	addl	%eax,%ebx
	addl	$4,%ebx
	movl	%ebx,%eax
	movl	%eax,8(%esp)
	call	open
	addl	$12,%esp
	movl	%eax,-12(%ebp)

	movl	-12(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	hrwcc_asmOptimize_reltrue_3
	movl	$0,%eax
hrwcc_asmOptimize_reltrue_3	:	
	testl	%eax,%eax
	jnz	hrwcc_asmOptimize_ifbl_2
	jmp	hrwcc_asmOptimize_elsebl_2
hrwcc_asmOptimize_ifbl_2	:	

	subl	$4,%esp
	movl	-8(%ebp),%eax
	movl	%eax,0(%esp)
	call	close
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+30,0(%esp)
	call	puts
	addl	$4,%esp

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	hrwcc_asmOptimize_ret
hrwcc_asmOptimize_elsebl_2	:	
hrwcc_asmOptimize_endif_2	:	

	subl	$8,%esp
	movl	-8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-12(%ebp),%eax
	movl	%eax,4(%esp)
	call	asmopt_execute
	addl	$8,%esp
	movl	%eax,-4(%ebp)

	subl	$4,%esp
	movl	-8(%ebp),%eax
	movl	%eax,0(%esp)
	call	close
	addl	$4,%esp

	subl	$4,%esp
	movl	-12(%ebp),%eax
	movl	%eax,0(%esp)
	call	close
	addl	$4,%esp

	movl	-4(%ebp),%eax
	jmp	hrwcc_asmOptimize_ret
hrwcc_asmOptimize_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	hrwcc_compile
.type	hrwcc_compile,@function
hrwcc_compile	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$21553,%esp

	subl	$8,%esp
	movl	$symtab+63,0(%esp)
	movl	8(%ebp),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$12,%esp
	movl	12(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$64,%ebx
	orl	$512,%ebx
	orl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,4(%esp)
	movl	$6,%ebx
	imull	$8,%ebx
	imull	$8,%ebx
	movl	%ebx,%eax
	pushl	%eax
	movl	$4,%ebx
	imull	$8,%ebx
	movl	%ebx,%eax
	popl	%ebx
	addl	%eax,%ebx
	addl	$4,%ebx
	movl	%ebx,%eax
	movl	%eax,8(%esp)
	call	open
	addl	$12,%esp
	movl	%eax,-4(%ebp)

	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	hrwcc_compile_reltrue_5
	movl	$0,%eax
hrwcc_compile_reltrue_5	:	
	testl	%eax,%eax
	jnz	hrwcc_compile_ifbl_4
	jmp	hrwcc_compile_elsebl_4
hrwcc_compile_ifbl_4	:	

	subl	$4,%esp
	movl	$symtab+79,0(%esp)
	call	puts
	addl	$4,%esp

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	hrwcc_compile_ret
hrwcc_compile_elsebl_4	:	
hrwcc_compile_endif_4	:	

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-20740,%eax
	movl	%eax,0(%esp)
	movl	8(%ebp),%eax
	movl	%eax,4(%esp)
	call	preproc_create
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	hrwcc_compile_reltrue_7
	movl	$0,%eax
hrwcc_compile_reltrue_7	:	
	testl	%eax,%eax
	jnz	hrwcc_compile_ifbl_6
	jmp	hrwcc_compile_elsebl_6
hrwcc_compile_ifbl_6	:	

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	hrwcc_compile_ret
hrwcc_compile_elsebl_6	:	
hrwcc_compile_endif_6	:	

	movl	$0,-8(%ebp)

hrwcc_compile_while_8	:	
	movl	-8(%ebp),%ebx
	cmpl	32(%ebp),%ebx
	movl	$1,%eax
	jl	hrwcc_compile_reltrue_9
	movl	$0,%eax
hrwcc_compile_reltrue_9	:	
	testl	%eax,%eax
	jz	hrwcc_compile_endwhile_8

	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$28,%eax
	movl	(%eax),%eax
	popl	%esi
	imull	$4,%esi
	addl	%esi,%eax
	movl	(%eax),%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$24,%eax
	movl	(%eax),%eax
	popl	%esi
	imull	$4,%esi
	addl	%esi,%eax
	movl	(%eax),%eax
	movl	%eax,-12(%ebp)

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-20740,%eax
	movl	%eax,0(%esp)
	pushl	$2
	movl	%ebp,%eax
	addl	$-12,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movl	%eax,4(%esp)
	call	preproc_addDefine
	addl	$8,%esp

	movl	-8(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-8(%ebp)
	jmp	hrwcc_compile_while_8
hrwcc_compile_endwhile_8	:	

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-20740,%eax
	movl	%eax,0(%esp)
	movl	$symtab+105,4(%esp)
	call	preproc_addDefine
	addl	$8,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-20761,%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-20740,%eax
	movl	%eax,4(%esp)
	call	scanner_init
	addl	$8,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-21357,%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-20761,%eax
	movl	%eax,4(%esp)
	call	parser_init
	addl	$8,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-21357,%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-21373,%eax
	movl	%eax,4(%esp)
	call	symbol_CreateSymbolTable
	addl	$8,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-21357,%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-21373,%eax
	movl	%eax,4(%esp)
	call	parser_setSymbolTable
	addl	$8,%esp

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-21549,%eax
	movl	%eax,0(%esp)
	movl	-4(%ebp),%eax
	movl	%eax,4(%esp)
	movl	%ebp,%eax
	addl	$-21357,%eax
	movl	%eax,8(%esp)
	call	codegen_CreateCodeGen
	addl	$12,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-21357,%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-21549,%eax
	movl	%eax,4(%esp)
	call	parser_setCodegen
	addl	$8,%esp

	movl	%ebp,%eax
	addl	$-21549,%eax
	addl	$12,%eax
	pushl	%eax
	movl	16(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$-21549,%eax
	addl	$16,%eax
	pushl	%eax
	movl	36(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	subl	$0,%esp
	call	syntax_CreateTreeNode
	addl	$0,%esp
	movl	%eax,-21553(%ebp)

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-21357,%eax
	movl	%eax,0(%esp)
	movl	-21553(%ebp),%eax
	movl	%eax,4(%esp)
	call	parser_buildSyntaxTree
	addl	$8,%esp

	movl	20(%ebp),%eax
	testl	%eax,%eax
	jnz	hrwcc_compile_ifbl_10
	jmp	hrwcc_compile_elsebl_10
hrwcc_compile_ifbl_10	:	

	subl	$4,%esp
	movl	-21553(%ebp),%eax
	movl	%eax,0(%esp)
	call	syntax_printTree
	addl	$4,%esp
	jmp	hrwcc_compile_endif_10
hrwcc_compile_elsebl_10	:	
hrwcc_compile_endif_10	:	

	subl	$4,%esp
	movl	$symtab+115,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$8,%esp
	movl	$symtab+129,0(%esp)
	movl	%ebp,%eax
	addl	$-21357,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$8,%esp
	movl	$symtab+148,0(%esp)
	movl	%ebp,%eax
	addl	$-21373,%eax
	addl	$4,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$8,%esp
	movl	$symtab+173,0(%esp)
	movl	%ebp,%eax
	addl	$-21549,%eax
	addl	$4,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$8,%esp
	movl	$symtab+193,0(%esp)
	movl	%ebp,%eax
	addl	$-21549,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$4,%esp
	movl	$symtab+215,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	-4(%ebp),%eax
	movl	%eax,0(%esp)
	call	close
	addl	$4,%esp

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-20740,%eax
	movl	%eax,0(%esp)
	call	preproc_destroy
	addl	$4,%esp

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-21373,%eax
	movl	%eax,0(%esp)
	call	symbol_destroy
	addl	$4,%esp

	subl	$4,%esp
	movl	-21553(%ebp),%eax
	movl	%eax,0(%esp)
	call	syntax_FreeSyntaxTree
	addl	$4,%esp

	movl	%ebp,%eax
	addl	$-21357,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$-21373,%eax
	addl	$4,%eax
	movl	(%eax),%eax
	popl	%ebx
	addl	%eax,%ebx
	pushl	%ebx
	movl	%ebp,%eax
	addl	$-21549,%eax
	addl	$4,%eax
	movl	(%eax),%eax
	popl	%ebx
	addl	%eax,%ebx
	pushl	%ebx
	movl	%ebp,%eax
	addl	$-21549,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	popl	%ebx
	addl	%eax,%ebx
	movl	%ebx,%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jg	hrwcc_compile_reltrue_12
	movl	$0,%eax
hrwcc_compile_reltrue_12	:	
	testl	%eax,%eax
	jnz	hrwcc_compile_ifbl_11
	jmp	hrwcc_compile_elsebl_11
hrwcc_compile_ifbl_11	:	

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	hrwcc_compile_ret
hrwcc_compile_elsebl_11	:	
hrwcc_compile_endif_11	:	

	movl	$0,%eax
	jmp	hrwcc_compile_ret
hrwcc_compile_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	hrwcc_preprocess
.type	hrwcc_preprocess,@function
hrwcc_preprocess	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$21009,%esp

	subl	$8,%esp
	movl	$symtab+216,0(%esp)
	movl	8(%ebp),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-256,%eax
	movl	%eax,0(%esp)
	movl	8(%ebp),%eax
	movl	%eax,4(%esp)
	call	strcpy
	addl	$8,%esp

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-256,%eax
	movl	%eax,0(%esp)
	call	hrwcc_setToNonpreprocC
	addl	$4,%esp

	subl	$8,%esp
	movl	$symtab+235,0(%esp)
	movl	%ebp,%eax
	addl	$-256,%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-256,%eax
	movl	%eax,0(%esp)
	movl	$64,%ebx
	orl	$512,%ebx
	orl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,4(%esp)
	movl	$6,%ebx
	imull	$8,%ebx
	imull	$8,%ebx
	movl	%ebx,%eax
	pushl	%eax
	movl	$4,%ebx
	imull	$8,%ebx
	movl	%ebx,%eax
	popl	%ebx
	addl	%eax,%ebx
	addl	$4,%ebx
	movl	%ebx,%eax
	movl	%eax,8(%esp)
	call	open
	addl	$12,%esp
	movl	%eax,-260(%ebp)

	movl	-260(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	hrwcc_preprocess_reltrue_14
	movl	$0,%eax
hrwcc_preprocess_reltrue_14	:	
	testl	%eax,%eax
	jnz	hrwcc_preprocess_ifbl_13
	jmp	hrwcc_preprocess_elsebl_13
hrwcc_preprocess_ifbl_13	:	

	subl	$4,%esp
	movl	$symtab+79,0(%esp)
	call	puts
	addl	$4,%esp

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	hrwcc_preprocess_ret
hrwcc_preprocess_elsebl_13	:	
hrwcc_preprocess_endif_13	:	

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-21009,%eax
	movl	%eax,0(%esp)
	movl	8(%ebp),%eax
	movl	%eax,4(%esp)
	call	preproc_create
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	hrwcc_preprocess_reltrue_16
	movl	$0,%eax
hrwcc_preprocess_reltrue_16	:	
	testl	%eax,%eax
	jnz	hrwcc_preprocess_ifbl_15
	jmp	hrwcc_preprocess_elsebl_15
hrwcc_preprocess_ifbl_15	:	

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	hrwcc_preprocess_ret
hrwcc_preprocess_elsebl_15	:	
hrwcc_preprocess_endif_15	:	

	movl	$0,-264(%ebp)

hrwcc_preprocess_while_17	:	
	movl	-264(%ebp),%ebx
	cmpl	20(%ebp),%ebx
	movl	$1,%eax
	jl	hrwcc_preprocess_reltrue_18
	movl	$0,%eax
hrwcc_preprocess_reltrue_18	:	
	testl	%eax,%eax
	jz	hrwcc_preprocess_endwhile_17

	pushl	-264(%ebp)
	movl	%ebp,%eax
	addl	$16,%eax
	movl	(%eax),%eax
	popl	%esi
	imull	$4,%esi
	addl	%esi,%eax
	movl	(%eax),%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	imull	$4,%esi
	addl	%esi,%eax
	movl	(%eax),%eax
	movl	%eax,-268(%ebp)

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-21009,%eax
	movl	%eax,0(%esp)
	pushl	$2
	movl	%ebp,%eax
	addl	$-268,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movl	%eax,4(%esp)
	call	preproc_addDefine
	addl	$8,%esp

	movl	-264(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-264(%ebp)
	jmp	hrwcc_preprocess_while_17
hrwcc_preprocess_endwhile_17	:	

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-21009,%eax
	movl	%eax,0(%esp)
	movl	$symtab+105,4(%esp)
	call	preproc_addDefine
	addl	$8,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-21009,%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-281,%eax
	movl	%eax,4(%esp)
	call	preproc_getNext
	addl	$8,%esp

hrwcc_preprocess_while_19	:	
	movl	%ebp,%eax
	addl	$-281,%eax
	addl	$0,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	hrwcc_preprocess_reltrue_20
	movl	$0,%eax
hrwcc_preprocess_reltrue_20	:	
	testl	%eax,%eax
	jz	hrwcc_preprocess_endwhile_19

	subl	$12,%esp
	movl	-260(%ebp),%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-281,%eax
	addl	$0,%eax
	movl	%eax,4(%esp)
	movl	$1,8(%esp)
	call	write
	addl	$12,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-21009,%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-281,%eax
	movl	%eax,4(%esp)
	call	preproc_getNext
	addl	$8,%esp
	jmp	hrwcc_preprocess_while_19
hrwcc_preprocess_endwhile_19	:	

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-21009,%eax
	movl	%eax,0(%esp)
	call	preproc_destroy
	addl	$4,%esp

	movl	$0,%eax
	jmp	hrwcc_preprocess_ret
hrwcc_preprocess_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	hrwcc_linkit
.type	hrwcc_linkit,@function
hrwcc_linkit	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$64,%esp

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-56,%eax
	movl	%eax,0(%esp)
	call	linker_create
	addl	$4,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	hrwcc_linkit_reltrue_22
	movl	$0,%eax
hrwcc_linkit_reltrue_22	:	
	testl	%eax,%eax
	jnz	hrwcc_linkit_ifbl_21
	jmp	hrwcc_linkit_elsebl_21
hrwcc_linkit_ifbl_21	:	

	subl	$8,%esp
	movl	$symtab+248,0(%esp)
	movl	8(%ebp),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	hrwcc_linkit_ret
hrwcc_linkit_elsebl_21	:	
hrwcc_linkit_endif_21	:	

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-60(%ebp)

hrwcc_linkit_while_23	:	
	movl	-60(%ebp),%ebx
	cmpl	20(%ebp),%ebx
	movl	$1,%eax
	jl	hrwcc_linkit_reltrue_24
	movl	$0,%eax
hrwcc_linkit_reltrue_24	:	
	testl	%eax,%eax
	jz	hrwcc_linkit_endwhile_23

	movl	-60(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-60(%ebp)

	pushl	-60(%ebp)
	movl	%ebp,%eax
	addl	$16,%eax
	movl	(%eax),%eax
	popl	%esi
	imull	$4,%esi
	addl	%esi,%eax
	movl	(%eax),%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	imull	$4,%esi
	addl	%esi,%eax
	movl	(%eax),%eax
	movl	%eax,-64(%ebp)

	subl	$4,%esp
	movl	-64(%ebp),%eax
	movl	%eax,0(%esp)
	call	hrwcc_getFiletype
	addl	$4,%esp
	movl	%eax,%ebx
	cmpl	$2,%ebx
	movl	$1,%eax
	jne	hrwcc_linkit_reltrue_26
	movl	$0,%eax
hrwcc_linkit_reltrue_26	:	
	testl	%eax,%eax
	jnz	hrwcc_linkit_ifbl_25
	jmp	hrwcc_linkit_elsebl_25
hrwcc_linkit_ifbl_25	:	
	jmp	hrwcc_linkit_while_23
hrwcc_linkit_elsebl_25	:	
hrwcc_linkit_endif_25	:	

	subl	$8,%esp
	movl	$symtab+280,0(%esp)
	movl	-64(%ebp),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-56,%eax
	movl	%eax,0(%esp)
	movl	-64(%ebp),%eax
	movl	%eax,4(%esp)
	movl	24(%ebp),%eax
	movl	%eax,8(%esp)
	call	linker_appendFile
	addl	$12,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	hrwcc_linkit_reltrue_28
	movl	$0,%eax
hrwcc_linkit_reltrue_28	:	
	testl	%eax,%eax
	jnz	hrwcc_linkit_ifbl_27
	jmp	hrwcc_linkit_elsebl_27
hrwcc_linkit_ifbl_27	:	

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-56,%eax
	movl	%eax,0(%esp)
	call	linker_destroy
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+299,0(%esp)
	call	puts
	addl	$4,%esp

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	hrwcc_linkit_ret
hrwcc_linkit_elsebl_27	:	
hrwcc_linkit_endif_27	:	
	jmp	hrwcc_linkit_while_23
hrwcc_linkit_endwhile_23	:	

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-56,%eax
	movl	%eax,0(%esp)
	movl	8(%ebp),%eax
	movl	%eax,4(%esp)
	call	linker_produce
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	hrwcc_linkit_reltrue_30
	movl	$0,%eax
hrwcc_linkit_reltrue_30	:	
	testl	%eax,%eax
	jnz	hrwcc_linkit_ifbl_29
	jmp	hrwcc_linkit_elsebl_29
hrwcc_linkit_ifbl_29	:	

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-56,%eax
	movl	%eax,0(%esp)
	call	linker_destroy
	addl	$4,%esp

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	hrwcc_linkit_ret
hrwcc_linkit_elsebl_29	:	
hrwcc_linkit_endif_29	:	

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-56,%eax
	movl	%eax,0(%esp)
	call	linker_destroy
	addl	$4,%esp

	movl	$0,%eax
	jmp	hrwcc_linkit_ret
hrwcc_linkit_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	printUsage
.type	printUsage,@function
printUsage	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	subl	$4,%esp
	movl	$symtab+322,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+215,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+215,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+360,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$8,%esp
	movl	$symtab+367,0(%esp)
	pushl	$0
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	imull	$4,%esi
	addl	%esi,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$4,%esp
	movl	$symtab+215,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+439,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+442,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+466,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+470,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+509,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+512,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+540,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+543,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+564,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+575,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+590,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+598,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+631,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+634,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+656,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+669,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+705,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+714,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+215,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+215,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+744,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+803,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+863,0(%esp)
	call	puts
	addl	$4,%esp
printUsage_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	hrwcc_getFiletype
.type	hrwcc_getFiletype,@function
hrwcc_getFiletype	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$260,%esp

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	strlen
	addl	$4,%esp
	movl	%eax,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)

hrwcc_getFiletype_while_31	:	
	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jge	hrwcc_getFiletype_reltrue_32
	movl	$0,%eax
hrwcc_getFiletype_reltrue_32	:	
	testl	%eax,%eax
	jz	hrwcc_getFiletype_endwhile_31

	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,%ebx
	cmpl	$46,%ebx
	movl	$1,%eax
	je	hrwcc_getFiletype_reltrue_34
	movl	$0,%eax
hrwcc_getFiletype_reltrue_34	:	
	testl	%eax,%eax
	jnz	hrwcc_getFiletype_ifbl_33
	jmp	hrwcc_getFiletype_elsebl_33
hrwcc_getFiletype_ifbl_33	:	
	jmp	hrwcc_getFiletype_endwhile_31
hrwcc_getFiletype_elsebl_33	:	
hrwcc_getFiletype_endif_33	:	

	movl	-4(%ebp),%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)
	jmp	hrwcc_getFiletype_while_31
hrwcc_getFiletype_endwhile_31	:	

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-260,%eax
	movl	%eax,0(%esp)
	movl	-4(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movl	%eax,4(%esp)
	call	strcpy
	addl	$8,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-260,%eax
	movl	%eax,0(%esp)
	movl	$symtab+879,4(%esp)
	call	strcmp
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	hrwcc_getFiletype_reltrue_36
	movl	$0,%eax
hrwcc_getFiletype_reltrue_36	:	
	testl	%eax,%eax
	jnz	hrwcc_getFiletype_ifbl_35
	jmp	hrwcc_getFiletype_elsebl_35
hrwcc_getFiletype_ifbl_35	:	

	movl	$1,%eax
	jmp	hrwcc_getFiletype_ret
hrwcc_getFiletype_elsebl_35	:	
hrwcc_getFiletype_endif_35	:	

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-260,%eax
	movl	%eax,0(%esp)
	movl	$symtab+881,4(%esp)
	call	strcmp
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	hrwcc_getFiletype_reltrue_38
	movl	$0,%eax
hrwcc_getFiletype_reltrue_38	:	
	testl	%eax,%eax
	jnz	hrwcc_getFiletype_ifbl_37
	jmp	hrwcc_getFiletype_elsebl_37
hrwcc_getFiletype_ifbl_37	:	

	movl	$1,%eax
	jmp	hrwcc_getFiletype_ret
hrwcc_getFiletype_elsebl_37	:	
hrwcc_getFiletype_endif_37	:	

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-260,%eax
	movl	%eax,0(%esp)
	movl	$symtab+885,4(%esp)
	call	strcmp
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	hrwcc_getFiletype_reltrue_40
	movl	$0,%eax
hrwcc_getFiletype_reltrue_40	:	
	testl	%eax,%eax
	jnz	hrwcc_getFiletype_ifbl_39
	jmp	hrwcc_getFiletype_elsebl_39
hrwcc_getFiletype_ifbl_39	:	

	movl	$2,%eax
	jmp	hrwcc_getFiletype_ret
hrwcc_getFiletype_elsebl_39	:	
hrwcc_getFiletype_endif_39	:	

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	hrwcc_getFiletype_ret
hrwcc_getFiletype_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	hrwcc_setToAsm
.type	hrwcc_setToAsm,@function
hrwcc_setToAsm	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$8,%esp

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	strlen
	addl	$4,%esp
	movl	%eax,-8(%ebp)

	movl	-8(%ebp),%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)

hrwcc_setToAsm_while_41	:	
	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jge	hrwcc_setToAsm_reltrue_42
	movl	$0,%eax
hrwcc_setToAsm_reltrue_42	:	
	testl	%eax,%eax
	jz	hrwcc_setToAsm_endwhile_41

	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,%ebx
	cmpl	$46,%ebx
	movl	$1,%eax
	je	hrwcc_setToAsm_reltrue_44
	movl	$0,%eax
hrwcc_setToAsm_reltrue_44	:	
	testl	%eax,%eax
	jnz	hrwcc_setToAsm_ifbl_43
	jmp	hrwcc_setToAsm_elsebl_43
hrwcc_setToAsm_ifbl_43	:	
	jmp	hrwcc_setToAsm_endwhile_41
hrwcc_setToAsm_elsebl_43	:	
hrwcc_setToAsm_endif_43	:	

	movl	-4(%ebp),%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)
	jmp	hrwcc_setToAsm_while_41
hrwcc_setToAsm_endwhile_41	:	

	pushl	-4(%ebp)
	movl	-8(%ebp),%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	cmpl	%eax,%ebx
	movl	$1,%eax
	jl	hrwcc_setToAsm_reltrue_46
	movl	$0,%eax
hrwcc_setToAsm_reltrue_46	:	
	testl	%eax,%eax
	jnz	hrwcc_setToAsm_ifbl_45
	jmp	hrwcc_setToAsm_elsebl_45
hrwcc_setToAsm_ifbl_45	:	

	movl	-4(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movl	%eax,%ebx
	movb	$115,(%ebx)

	movl	-4(%ebp),%ebx
	addl	$2,%ebx
	movl	%ebx,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movl	%eax,%ebx
	movb	$0,(%ebx)
	jmp	hrwcc_setToAsm_endif_45
hrwcc_setToAsm_elsebl_45	:	
hrwcc_setToAsm_endif_45	:	
hrwcc_setToAsm_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	hrwcc_setToNonoptAsm
.type	hrwcc_setToNonoptAsm,@function
hrwcc_setToNonoptAsm	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$8,%esp

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	strlen
	addl	$4,%esp
	movl	%eax,-8(%ebp)

	movl	-8(%ebp),%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)

hrwcc_setToNonoptAsm_while_47	:	
	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jge	hrwcc_setToNonoptAsm_reltrue_48
	movl	$0,%eax
hrwcc_setToNonoptAsm_reltrue_48	:	
	testl	%eax,%eax
	jz	hrwcc_setToNonoptAsm_endwhile_47

	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,%ebx
	cmpl	$46,%ebx
	movl	$1,%eax
	je	hrwcc_setToNonoptAsm_reltrue_50
	movl	$0,%eax
hrwcc_setToNonoptAsm_reltrue_50	:	
	testl	%eax,%eax
	jnz	hrwcc_setToNonoptAsm_ifbl_49
	jmp	hrwcc_setToNonoptAsm_elsebl_49
hrwcc_setToNonoptAsm_ifbl_49	:	
	jmp	hrwcc_setToNonoptAsm_endwhile_47
hrwcc_setToNonoptAsm_elsebl_49	:	
hrwcc_setToNonoptAsm_endif_49	:	

	movl	-4(%ebp),%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)
	jmp	hrwcc_setToNonoptAsm_while_47
hrwcc_setToNonoptAsm_endwhile_47	:	

	pushl	-4(%ebp)
	movl	-8(%ebp),%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	cmpl	%eax,%ebx
	movl	$1,%eax
	jl	hrwcc_setToNonoptAsm_reltrue_52
	movl	$0,%eax
hrwcc_setToNonoptAsm_reltrue_52	:	
	testl	%eax,%eax
	jnz	hrwcc_setToNonoptAsm_ifbl_51
	jmp	hrwcc_setToNonoptAsm_elsebl_51
hrwcc_setToNonoptAsm_ifbl_51	:	

	movl	-4(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movl	%eax,%ebx
	movb	$110,(%ebx)

	movl	-4(%ebp),%ebx
	addl	$2,%ebx
	movl	%ebx,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movl	%eax,%ebx
	movb	$0,(%ebx)
	jmp	hrwcc_setToNonoptAsm_endif_51
hrwcc_setToNonoptAsm_elsebl_51	:	
hrwcc_setToNonoptAsm_endif_51	:	
hrwcc_setToNonoptAsm_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	hrwcc_setToNonpreprocC
.type	hrwcc_setToNonpreprocC,@function
hrwcc_setToNonpreprocC	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$8,%esp

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	strlen
	addl	$4,%esp
	movl	%eax,-8(%ebp)

	movl	-8(%ebp),%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)

hrwcc_setToNonpreprocC_while_53	:	
	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jge	hrwcc_setToNonpreprocC_reltrue_54
	movl	$0,%eax
hrwcc_setToNonpreprocC_reltrue_54	:	
	testl	%eax,%eax
	jz	hrwcc_setToNonpreprocC_endwhile_53

	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,%ebx
	cmpl	$46,%ebx
	movl	$1,%eax
	je	hrwcc_setToNonpreprocC_reltrue_56
	movl	$0,%eax
hrwcc_setToNonpreprocC_reltrue_56	:	
	testl	%eax,%eax
	jnz	hrwcc_setToNonpreprocC_ifbl_55
	jmp	hrwcc_setToNonpreprocC_elsebl_55
hrwcc_setToNonpreprocC_ifbl_55	:	
	jmp	hrwcc_setToNonpreprocC_endwhile_53
hrwcc_setToNonpreprocC_elsebl_55	:	
hrwcc_setToNonpreprocC_endif_55	:	

	movl	-4(%ebp),%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)
	jmp	hrwcc_setToNonpreprocC_while_53
hrwcc_setToNonpreprocC_endwhile_53	:	

	pushl	-4(%ebp)
	movl	-8(%ebp),%ebx
	subl	$2,%ebx
	movl	%ebx,%eax
	popl	%ebx
	cmpl	%eax,%ebx
	movl	$1,%eax
	jl	hrwcc_setToNonpreprocC_reltrue_58
	movl	$0,%eax
hrwcc_setToNonpreprocC_reltrue_58	:	
	testl	%eax,%eax
	jnz	hrwcc_setToNonpreprocC_ifbl_57
	jmp	hrwcc_setToNonpreprocC_elsebl_57
hrwcc_setToNonpreprocC_ifbl_57	:	

	movl	-4(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movl	%eax,%ebx
	movb	$105,(%ebx)

	movl	-4(%ebp),%ebx
	addl	$2,%ebx
	movl	%ebx,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movl	%eax,%ebx
	movb	$105,(%ebx)

	movl	-4(%ebp),%ebx
	addl	$3,%ebx
	movl	%ebx,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movl	%eax,%ebx
	movb	$0,(%ebx)
	jmp	hrwcc_setToNonpreprocC_endif_57
hrwcc_setToNonpreprocC_elsebl_57	:	

	pushl	-4(%ebp)
	movl	-8(%ebp),%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	cmpl	%eax,%ebx
	movl	$1,%eax
	jl	hrwcc_setToNonpreprocC_reltrue_60
	movl	$0,%eax
hrwcc_setToNonpreprocC_reltrue_60	:	
	testl	%eax,%eax
	jnz	hrwcc_setToNonpreprocC_ifbl_59
	jmp	hrwcc_setToNonpreprocC_elsebl_59
hrwcc_setToNonpreprocC_ifbl_59	:	

	movl	-4(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movl	%eax,%ebx
	movb	$105,(%ebx)

	movl	-4(%ebp),%ebx
	addl	$2,%ebx
	movl	%ebx,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movl	%eax,%ebx
	movb	$0,(%ebx)
	jmp	hrwcc_setToNonpreprocC_endif_59
hrwcc_setToNonpreprocC_elsebl_59	:	
hrwcc_setToNonpreprocC_endif_59	:	
hrwcc_setToNonpreprocC_endif_57	:	
hrwcc_setToNonpreprocC_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	main
.type	main,@function
main	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$724,%esp

	movl	8(%ebp),%ebx
	cmpl	$1,%ebx
	movl	$1,%eax
	je	main_reltrue_62
	movl	$0,%eax
main_reltrue_62	:	
	testl	%eax,%eax
	jnz	main_ifbl_61
	jmp	main_elsebl_61
main_ifbl_61	:	

	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	12(%ebp),%eax
	movl	%eax,4(%esp)
	call	printUsage
	addl	$8,%esp

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	main_ret
main_elsebl_61	:	
main_endif_61	:	

	movl	$0,-24(%ebp)

	movl	$0,-28(%ebp)

	movl	$0,-32(%ebp)

	movl	$0,-36(%ebp)

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-292,%eax
	movl	%eax,0(%esp)
	movl	$symtab+887,4(%esp)
	call	strcpy
	addl	$8,%esp

	movl	$0,-296(%ebp)

	movl	$0,-300(%ebp)

	movl	$0,-384(%ebp)

	movl	$0,-468(%ebp)

	movl	$0,-20(%ebp)

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-464,%eax
	movl	%eax,0(%esp)
	movl	$0,4(%esp)
	movl	$4,%ebx
	imull	$20,%ebx
	movl	%ebx,%eax
	movl	%eax,8(%esp)
	call	memset
	addl	$12,%esp

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-380,%eax
	movl	%eax,0(%esp)
	movl	$0,4(%esp)
	movl	$4,%ebx
	imull	$20,%ebx
	movl	%ebx,%eax
	movl	%eax,8(%esp)
	call	memset
	addl	$12,%esp

	movl	$0,-4(%ebp)

main_while_63	:	
	pushl	-4(%ebp)
	movl	8(%ebp),%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	cmpl	%eax,%ebx
	movl	$1,%eax
	jl	main_reltrue_64
	movl	$0,%eax
main_reltrue_64	:	
	testl	%eax,%eax
	jz	main_endwhile_63

	movl	-4(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)

	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	imull	$4,%esi
	addl	%esi,%eax
	movl	(%eax),%eax
	movl	%eax,-8(%ebp)

	pushl	$0
	movl	%ebp,%eax
	addl	$-8,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,%ebx
	cmpl	$45,%ebx
	movl	$1,%eax
	je	main_reltrue_66
	movl	$0,%eax
main_reltrue_66	:	
	testl	%eax,%eax
	jnz	main_ifbl_65
	jmp	main_elsebl_65
main_ifbl_65	:	

	subl	$8,%esp
	movl	-8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+439,4(%esp)
	call	strcmp
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	main_reltrue_68
	movl	$0,%eax
main_reltrue_68	:	
	testl	%eax,%eax
	jnz	main_ifbl_67
	jmp	main_elsebl_67
main_ifbl_67	:	

	movl	$1,-28(%ebp)
	jmp	main_endif_67
main_elsebl_67	:	

	subl	$8,%esp
	movl	-8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+509,4(%esp)
	call	strcmp
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	main_reltrue_70
	movl	$0,%eax
main_reltrue_70	:	
	testl	%eax,%eax
	jnz	main_ifbl_69
	jmp	main_elsebl_69
main_ifbl_69	:	

	movl	$1,-36(%ebp)
	jmp	main_endif_69
main_elsebl_69	:	

	subl	$8,%esp
	movl	-8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+895,4(%esp)
	call	strcmp
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	main_reltrue_72
	movl	$0,%eax
main_reltrue_72	:	
	testl	%eax,%eax
	jnz	main_ifbl_71
	jmp	main_elsebl_71
main_ifbl_71	:	

	movl	$1,-32(%ebp)
	jmp	main_endif_71
main_elsebl_71	:	

	subl	$8,%esp
	movl	-8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+540,4(%esp)
	call	strcmp
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	main_reltrue_74
	movl	$0,%eax
main_reltrue_74	:	
	testl	%eax,%eax
	jnz	main_ifbl_73
	jmp	main_elsebl_73
main_ifbl_73	:	

	movl	$1,-24(%ebp)
	jmp	main_endif_73
main_elsebl_73	:	

	subl	$8,%esp
	movl	-8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+898,4(%esp)
	call	strcmp
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	main_reltrue_76
	movl	$0,%eax
main_reltrue_76	:	
	testl	%eax,%eax
	jnz	main_ifbl_75
	jmp	main_elsebl_75
main_ifbl_75	:	

	movl	-384(%ebp),%ebx
	cmpl	$20,%ebx
	movl	$1,%eax
	je	main_reltrue_78
	movl	$0,%eax
main_reltrue_78	:	
	testl	%eax,%eax
	jnz	main_ifbl_77
	jmp	main_elsebl_77
main_ifbl_77	:	

	subl	$4,%esp
	movl	$symtab+901,0(%esp)
	call	puts
	addl	$4,%esp

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	main_ret
main_elsebl_77	:	
main_endif_77	:	

	pushl	-384(%ebp)
	movl	-4(%ebp),%eax
	popl	%esi
	movl	%eax,-380(%ebp,%esi,4)

	movl	-384(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-384(%ebp)
	jmp	main_endif_75
main_elsebl_75	:	

	subl	$8,%esp
	movl	-8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+631,4(%esp)
	call	strcmp
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	main_reltrue_80
	movl	$0,%eax
main_reltrue_80	:	
	testl	%eax,%eax
	jnz	main_ifbl_79
	jmp	main_elsebl_79
main_ifbl_79	:	

	movl	$1,-296(%ebp)

	movl	$1,-300(%ebp)
	jmp	main_endif_79
main_elsebl_79	:	

	subl	$8,%esp
	movl	-8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+656,4(%esp)
	call	strcmp
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	main_reltrue_82
	movl	$0,%eax
main_reltrue_82	:	
	testl	%eax,%eax
	jnz	main_ifbl_81
	jmp	main_elsebl_81
main_ifbl_81	:	

	movl	$1,-300(%ebp)
	jmp	main_endif_81
main_elsebl_81	:	

	subl	$8,%esp
	movl	-8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+705,4(%esp)
	call	strcmp
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	main_reltrue_84
	movl	$0,%eax
main_reltrue_84	:	
	testl	%eax,%eax
	jnz	main_ifbl_83
	jmp	main_elsebl_83
main_ifbl_83	:	

	movl	$1,-296(%ebp)
	jmp	main_endif_83
main_elsebl_83	:	

	subl	$8,%esp
	movl	-8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+949,4(%esp)
	call	strcmp
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	main_reltrue_86
	movl	$0,%eax
main_reltrue_86	:	
	testl	%eax,%eax
	jnz	main_ifbl_85
	jmp	main_elsebl_85
main_ifbl_85	:	

	movl	-4(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)

	movl	-4(%ebp),%ebx
	cmpl	8(%ebp),%ebx
	movl	$1,%eax
	je	main_reltrue_88
	movl	$0,%eax
main_reltrue_88	:	
	testl	%eax,%eax
	jnz	main_ifbl_87
	jmp	main_elsebl_87
main_ifbl_87	:	

	subl	$4,%esp
	movl	$symtab+952,0(%esp)
	call	puts
	addl	$4,%esp

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	main_ret
main_elsebl_87	:	
main_endif_87	:	

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-292,%eax
	movl	%eax,0(%esp)
	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	imull	$4,%esi
	addl	%esi,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	movl	$256,8(%esp)
	call	strncpy
	addl	$12,%esp
	jmp	main_endif_85
main_elsebl_85	:	

	subl	$8,%esp
	movl	$symtab+981,0(%esp)
	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	imull	$4,%esi
	addl	%esi,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	12(%ebp),%eax
	movl	%eax,4(%esp)
	call	printUsage
	addl	$8,%esp

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	main_ret
main_endif_85	:	
main_endif_83	:	
main_endif_81	:	
main_endif_79	:	
main_endif_75	:	
main_endif_73	:	
main_endif_71	:	
main_endif_69	:	
main_endif_67	:	
	jmp	main_while_63
main_elsebl_65	:	
main_endif_65	:	

	movl	-468(%ebp),%ebx
	cmpl	$20,%ebx
	movl	$1,%eax
	je	main_reltrue_90
	movl	$0,%eax
main_reltrue_90	:	
	testl	%eax,%eax
	jnz	main_ifbl_89
	jmp	main_elsebl_89
main_ifbl_89	:	

	subl	$4,%esp
	movl	$symtab+1011,0(%esp)
	call	puts
	addl	$4,%esp

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	main_ret
main_elsebl_89	:	
main_endif_89	:	

	pushl	-468(%ebp)
	movl	-4(%ebp),%eax
	popl	%esi
	movl	%eax,-464(%ebp,%esi,4)

	movl	-468(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-468(%ebp)
	jmp	main_while_63
main_endwhile_63	:	

	movl	$0,-4(%ebp)

main_while_91	:	
	movl	-4(%ebp),%ebx
	cmpl	-468(%ebp),%ebx
	movl	$1,%eax
	jl	main_reltrue_92
	movl	$0,%eax
main_reltrue_92	:	
	testl	%eax,%eax
	jz	main_endwhile_91

	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$-464,%eax
	popl	%esi
	imull	$4,%esi
	addl	%esi,%eax
	movl	(%eax),%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	imull	$4,%esi
	addl	%esi,%eax
	movl	(%eax),%eax
	movl	%eax,-12(%ebp)

	subl	$4,%esp
	movl	-12(%ebp),%eax
	movl	%eax,0(%esp)
	call	hrwcc_getFiletype
	addl	$4,%esp
	movl	%eax,-16(%ebp)

	movl	-16(%ebp),%ebx
	cmpl	$1,%ebx
	movl	$1,%eax
	je	main_reltrue_94
	movl	$0,%eax
main_reltrue_94	:	
	testl	%eax,%eax
	jnz	main_ifbl_93
	jmp	main_elsebl_93
main_ifbl_93	:	

	movl	-36(%ebp),%eax
	testl	%eax,%eax
	movl	$1,%eax
	jz	main_logfactfalse_96
	movl	$0,%eax
main_logfactfalse_96	:	
	testl	%eax,%eax
	jnz	main_ifbl_95
	jmp	main_elsebl_95
main_ifbl_95	:	

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-724,%eax
	movl	%eax,0(%esp)
	movl	-12(%ebp),%eax
	movl	%eax,4(%esp)
	call	strcpy
	addl	$8,%esp

	movl	-296(%ebp),%eax
	testl	%eax,%eax
	jnz	main_ifbl_97
	jmp	main_elsebl_97
main_ifbl_97	:	

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-724,%eax
	movl	%eax,0(%esp)
	call	hrwcc_setToNonoptAsm
	addl	$4,%esp
	jmp	main_endif_97
main_elsebl_97	:	

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-724,%eax
	movl	%eax,0(%esp)
	call	hrwcc_setToAsm
	addl	$4,%esp
main_endif_97	:	

	subl	$32,%esp
	movl	-12(%ebp),%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-724,%eax
	movl	%eax,4(%esp)
	movl	-28(%ebp),%eax
	movl	%eax,8(%esp)
	movl	-24(%ebp),%eax
	movl	%eax,12(%esp)
	movl	12(%ebp),%eax
	movl	%eax,16(%esp)
	movl	%ebp,%eax
	addl	$-380,%eax
	movl	%eax,20(%esp)
	movl	-384(%ebp),%eax
	movl	%eax,24(%esp)
	movl	-300(%ebp),%eax
	movl	%eax,28(%esp)
	call	hrwcc_compile
	addl	$32,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	main_reltrue_99
	movl	$0,%eax
main_reltrue_99	:	
	testl	%eax,%eax
	jnz	main_ifbl_98
	jmp	main_elsebl_98
main_ifbl_98	:	

	movl	$1,-20(%ebp)
	jmp	main_endif_98
main_elsebl_98	:	
main_endif_98	:	

	movl	-296(%ebp),%eax
	testl	%eax,%eax
	jnz	main_ifbl_100
	jmp	main_elsebl_100
main_ifbl_100	:	

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-724,%eax
	movl	%eax,0(%esp)
	call	hrwcc_asmOptimize
	addl	$4,%esp
	jmp	main_endif_100
main_elsebl_100	:	
main_endif_100	:	

	subl	$4,%esp
	movl	-12(%ebp),%eax
	movl	%eax,0(%esp)
	call	hrwcc_setToAsm
	addl	$4,%esp
	jmp	main_endif_95
main_elsebl_95	:	

	subl	$16,%esp
	movl	-12(%ebp),%eax
	movl	%eax,0(%esp)
	movl	12(%ebp),%eax
	movl	%eax,4(%esp)
	movl	%ebp,%eax
	addl	$-380,%eax
	movl	%eax,8(%esp)
	movl	-384(%ebp),%eax
	movl	%eax,12(%esp)
	call	hrwcc_preprocess
	addl	$16,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	main_reltrue_102
	movl	$0,%eax
main_reltrue_102	:	
	testl	%eax,%eax
	jnz	main_ifbl_101
	jmp	main_elsebl_101
main_ifbl_101	:	

	movl	$1,-20(%ebp)
	jmp	main_endif_101
main_elsebl_101	:	
main_endif_101	:	

	subl	$4,%esp
	movl	-12(%ebp),%eax
	movl	%eax,0(%esp)
	call	hrwcc_setToNonpreprocC
	addl	$4,%esp
main_endif_95	:	
	jmp	main_endif_93
main_elsebl_93	:	
main_endif_93	:	

	movl	-4(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)
	jmp	main_while_91
main_endwhile_91	:	

	movl	-36(%ebp),%eax
	testl	%eax,%eax
	movl	$1,%eax
	jz	main_logfactfalse_105
	movl	$0,%eax
main_logfactfalse_105	:	
	testl	%eax,%eax
	jz	main_logtermfalse_104
	movl	-32(%ebp),%eax
	testl	%eax,%eax
	movl	$1,%eax
	jz	main_logfactfalse_106
	movl	$0,%eax
main_logfactfalse_106	:	
	testl	%eax,%eax
	jz	main_logtermfalse_104
	movl	$1,%eax
	jmp	main_logtermtrue_104
main_logtermfalse_104	:	
	movl	$0,%eax
main_logtermtrue_104	:	
	testl	%eax,%eax
	jnz	main_ifbl_103
	jmp	main_elsebl_103
main_ifbl_103	:	

	subl	$20,%esp
	movl	%ebp,%eax
	addl	$-292,%eax
	movl	%eax,0(%esp)
	movl	12(%ebp),%eax
	movl	%eax,4(%esp)
	movl	%ebp,%eax
	addl	$-464,%eax
	movl	%eax,8(%esp)
	movl	-468(%ebp),%eax
	movl	%eax,12(%esp)
	movl	-28(%ebp),%eax
	movl	%eax,16(%esp)
	call	hrwcc_linkit
	addl	$20,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	main_reltrue_108
	movl	$0,%eax
main_reltrue_108	:	
	testl	%eax,%eax
	jnz	main_ifbl_107
	jmp	main_elsebl_107
main_ifbl_107	:	

	movl	$1,-20(%ebp)
	jmp	main_endif_107
main_elsebl_107	:	
main_endif_107	:	
	jmp	main_endif_103
main_elsebl_103	:	
main_endif_103	:	

	movl	-20(%ebp),%eax
	testl	%eax,%eax
	jnz	main_ifbl_109
	jmp	main_elsebl_109
main_ifbl_109	:	

	subl	$4,%esp
	movl	$symtab+1057,0(%esp)
	call	puts
	addl	$4,%esp

	movl	$0,%ebx
	subl	$2,%ebx
	movl	%ebx,%eax
	jmp	main_ret
main_elsebl_109	:	
main_endif_109	:	

	subl	$4,%esp
	movl	$symtab+1089,0(%esp)
	call	puts
	addl	$4,%esp

	movl	$0,%eax
	jmp	main_ret
main_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.section	.data
symtab	:	
.string	"Can not open asmopt inputfile"
.string	"Can not create asmopt outputfile"
.string	"Compile %s ...\n"
.string	"Can not create outputfile"
.string	"__HRWCC__"
.string	"Finished with"
.string	"\t%d parser errors\n"
.string	"\t%d symbol table errors\n"
.string	"\t%d codegen errors\n"
.string	"\t%d codegen warnings\n"
.string	""
.string	"Preprocess %s ...\n"
.string	"Outfile: %s\n"
.string	"Cann not create output-file %s\n"
.string	"Add to linker: %s\n"
.string	"Could not append file."
.string	"HrwCC -- a self-compiling C compiler!"
.string	"Usage:"
.string	"\t%s [-g] [-c | -E] [-T] [-o outfile] [-Dmacro] [-O] [-fXXX] infiles...\n"
.string	"-g"
.string	"\tInsert debug messages."
.string	"-c\n"
.string	"\tStop after compilation, do not link.\n"
.string	"-E"
.string	"\tStop after preprocessing.\n"
.string	"-T"
.string	"\tPrint syntax tree.\n"
.string	"-o outfile"
.string	"\tOutput file.\n"
.string	"-Dmacro"
.string	"\tDefine macro for preprocessor.\n"
.string	"-O"
.string	"\tEnable optimization."
.string	"-ffastassign"
.string	"\tOptimize: Fast variable assignment"
.string	"-fasmpat"
.string	"\tOptimize: Assembler patterns"
.string	"Input files are detected by their file ending. Therefore a"
.string	"*.cpp file is preprocessed, compiled and linked. A *.s file"
.string	"is just linked."
.string	"c"
.string	"cpp"
.string	"s"
.string	"outfile"
.string	"-c"
.string	"-D"
.string	"Error: Maximum number of macro defines reached!"
.string	"-o"
.string	"Error: No output file given!"
.string	"Error: Invalid argument: %s\n\n"
.string	"Error: Maximum number of input files reached!"
.string	"Error occured while compiling!\n"
.string	"0 errors at all.\n"
