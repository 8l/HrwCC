
.section	.text

.globl	main
.type	main,@function
main	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$64,%esp

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-64,%eax
	movl	%eax,0(%esp)
	call	linker_create
	addl	$4,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	main_reltrue_1
	movl	$0,%eax
main_reltrue_1	:	
	testl	%eax,%eax
	jnz	main_ifbl_0
	jmp	main_elsebl_0
main_ifbl_0	:	

	subl	$4,%esp
	movl	$symtab+0,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$1,0(%esp)
	call	exit
	addl	$4,%esp
	jmp	main_endif_0
main_elsebl_0	:	
main_endif_0	:	

	subl	$12,%esp
	movl	$symtab+29,0(%esp)
	movl	$0,4(%esp)
	movl	$0,8(%esp)
	call	open
	addl	$12,%esp
	movl	%eax,-4(%ebp)

	subl	$12,%esp
	movl	$symtab+46,0(%esp)
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
	movl	%eax,-8(%ebp)

	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	main_reltrue_4
	movl	$0,%eax
main_reltrue_4	:	
	testl	%eax,%eax
	jnz	main_logexprtrue_3
	movl	-8(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	main_reltrue_5
	movl	$0,%eax
main_reltrue_5	:	
	testl	%eax,%eax
	jnz	main_logexprtrue_3
	movl	$0,%eax
	jmp	main_logexprfalse_3
main_logexprtrue_3	:	
	movl	$1,%eax
main_logexprfalse_3	:	
	testl	%eax,%eax
	jnz	main_ifbl_2
	jmp	main_elsebl_2
main_ifbl_2	:	

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-64,%eax
	movl	%eax,0(%esp)
	call	linker_destroy
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+63,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$1,0(%esp)
	call	exit
	addl	$4,%esp
	jmp	main_endif_2
main_elsebl_2	:	
main_endif_2	:	

	subl	$8,%esp
	movl	-4(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-8(%ebp),%eax
	movl	%eax,4(%esp)
	call	asmopt_execute
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	main_reltrue_7
	movl	$0,%eax
main_reltrue_7	:	
	testl	%eax,%eax
	jnz	main_ifbl_6
	jmp	main_elsebl_6
main_ifbl_6	:	

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-64,%eax
	movl	%eax,0(%esp)
	call	linker_destroy
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+84,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$1,0(%esp)
	call	exit
	addl	$4,%esp
	jmp	main_endif_6
main_elsebl_6	:	
main_endif_6	:	

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-64,%eax
	movl	%eax,0(%esp)
	movl	$symtab+46,4(%esp)
	movl	$1,8(%esp)
	call	linker_appendFile
	addl	$12,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	main_reltrue_9
	movl	$0,%eax
main_reltrue_9	:	
	testl	%eax,%eax
	jnz	main_ifbl_8
	jmp	main_elsebl_8
main_ifbl_8	:	

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-64,%eax
	movl	%eax,0(%esp)
	call	linker_destroy
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+109,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$1,0(%esp)
	call	exit
	addl	$4,%esp
	jmp	main_endif_8
main_elsebl_8	:	
main_endif_8	:	

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-64,%eax
	movl	%eax,0(%esp)
	movl	$symtab+132,4(%esp)
	movl	$1,8(%esp)
	call	linker_appendFile
	addl	$12,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	main_reltrue_11
	movl	$0,%eax
main_reltrue_11	:	
	testl	%eax,%eax
	jnz	main_ifbl_10
	jmp	main_elsebl_10
main_ifbl_10	:	

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-64,%eax
	movl	%eax,0(%esp)
	call	linker_destroy
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+109,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$1,0(%esp)
	call	exit
	addl	$4,%esp
	jmp	main_endif_10
main_elsebl_10	:	
main_endif_10	:	

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-64,%eax
	movl	%eax,0(%esp)
	movl	$symtab+151,4(%esp)
	call	linker_produce
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	main_reltrue_13
	movl	$0,%eax
main_reltrue_13	:	
	testl	%eax,%eax
	jnz	main_ifbl_12
	jmp	main_elsebl_12
main_ifbl_12	:	

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-64,%eax
	movl	%eax,0(%esp)
	call	linker_destroy
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+162,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$1,0(%esp)
	call	exit
	addl	$4,%esp
	jmp	main_endif_12
main_elsebl_12	:	
main_endif_12	:	

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-64,%eax
	movl	%eax,0(%esp)
	call	linker_destroy
	addl	$4,%esp

	movl	$0,%eax
	jmp	main_ret
main_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.section	.data
symtab	:	
.string	"Could not initialize linker\n"
.string	"testfiles/test.n"
.string	"testfiles/test.s"
.string	"Could not open file\n"
.string	"Could not optimize file\n"
.string	"Could not append file\n"
.string	"testfiles/output.s"
.string	"output.exe"
.string	"Could not produce exec file\n"
