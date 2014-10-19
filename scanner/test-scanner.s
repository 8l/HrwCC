
.section	.text

.globl	main
.type	main,@function
main	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$20893,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-20728,%eax
	movl	%eax,0(%esp)
	movl	$symtab+0,4(%esp)
	call	preproc_create
	addl	$8,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-20749,%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-20728,%eax
	movl	%eax,4(%esp)
	call	scanner_init
	addl	$8,%esp

	movl	%ebp,%eax
	addl	$-20893,%eax
	addl	$0,%eax
	movl	%eax,%ebx
	movl	$1,(%ebx)

main_while_0	:	
	movl	%ebp,%eax
	addl	$-20893,%eax
	addl	$0,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jg	main_reltrue_1
	movl	$0,%eax
main_reltrue_1	:	
	testl	%eax,%eax
	jz	main_endwhile_0

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-20749,%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-20893,%eax
	movl	%eax,4(%esp)
	call	scanner_getToken
	addl	$8,%esp

	subl	$8,%esp
	movl	$symtab+8,0(%esp)
	movl	%ebp,%eax
	addl	$-20893,%eax
	addl	$0,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$8,%esp
	movl	$symtab+12,0(%esp)
	movl	%ebp,%eax
	addl	$-20893,%eax
	addl	$16,%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$8,%esp
	movl	$symtab+19,0(%esp)
	movl	%ebp,%eax
	addl	$-20893,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$8,%esp
	movl	$symtab+28,0(%esp)
	movl	%ebp,%eax
	addl	$-20893,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$8,%esp
	movl	$symtab+34,0(%esp)
	movl	%ebp,%eax
	addl	$-20893,%eax
	addl	$4,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	movl	%ebp,%eax
	addl	$-20893,%eax
	addl	$0,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	main_reltrue_3
	movl	$0,%eax
main_reltrue_3	:	
	testl	%eax,%eax
	jnz	main_ifbl_2
	jmp	main_elsebl_2
main_ifbl_2	:	

	subl	$4,%esp
	movl	$symtab+41,0(%esp)
	call	puts
	addl	$4,%esp
	jmp	main_endif_2
main_elsebl_2	:	
main_endif_2	:	
	jmp	main_while_0
main_endwhile_0	:	

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-20728,%eax
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
.string	"input.c"
.string	"%2d"
.string	": %20s"
.string	"  \t@ %2d"
.string	", %3d"
.string	", %2d\n"
.string	"Error occured."
