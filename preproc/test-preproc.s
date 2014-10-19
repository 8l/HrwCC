
.section	.text

.globl	main
.type	main,@function
main	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$20749,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-20749,%eax
	movl	%eax,0(%esp)
	movl	$symtab+0,4(%esp)
	call	preproc_create
	addl	$8,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-20749,%eax
	movl	%eax,0(%esp)
	movl	$symtab+36,4(%esp)
	call	preproc_addDefine
	addl	$8,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-20749,%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-17,%eax
	movl	%eax,4(%esp)
	call	preproc_getNext
	addl	$8,%esp
	movl	%eax,-4(%ebp)

main_while_0	:	
	movl	-4(%ebp),%ebx
	cmpl	$1,%ebx
	movl	$1,%eax
	jne	main_reltrue_1
	movl	$0,%eax
main_reltrue_1	:	
	testl	%eax,%eax
	jz	main_endwhile_0

	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	main_reltrue_3
	movl	$0,%eax
main_reltrue_3	:	
	testl	%eax,%eax
	jnz	main_ifbl_2
	jmp	main_elsebl_2
main_ifbl_2	:	

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-20749,%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-17,%eax
	addl	$1,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	preproc_getFilename
	addl	$8,%esp
	movl	%eax,-21(%ebp)

	subl	$8,%esp
	movl	$symtab+46,0(%esp)
	movl	-4(%ebp),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$8,%esp
	movl	$symtab+72,0(%esp)
	movl	%ebp,%eax
	addl	$-17,%eax
	addl	$1,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$8,%esp
	movl	$symtab+81,0(%esp)
	movl	-21(%ebp),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$8,%esp
	movl	$symtab+86,0(%esp)
	movl	%ebp,%eax
	addl	$-17,%eax
	addl	$5,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$8,%esp
	movl	$symtab+100,0(%esp)
	movl	%ebp,%eax
	addl	$-17,%eax
	addl	$9,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$4,%esp
	movl	$0,0(%esp)
	call	exit
	addl	$4,%esp
	jmp	main_endif_2
main_elsebl_2	:	
main_endif_2	:	

	subl	$8,%esp
	movl	$symtab+114,0(%esp)
	movl	%ebp,%eax
	addl	$-17,%eax
	addl	$0,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-20749,%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-17,%eax
	movl	%eax,4(%esp)
	call	preproc_getNext
	addl	$8,%esp
	movl	%eax,-4(%ebp)
	jmp	main_while_0
main_endwhile_0	:	

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-20749,%eax
	movl	%eax,0(%esp)
	call	preproc_destroy
	addl	$4,%esp

	movl	$0,%eax
	jmp	main_ret
main_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.section	.data
symtab	:	
.string	"../symbolTable/test-symbolTable.cpp"
.string	"__HRWCC__"
.string	"\n       EXIT-STATUS: [%d]"
.string	" in [%d]"
.string	"[%s]"
.string	" on line [%d]"
.string	" column [%d]\n"
.string	"%c"
