
.section	.text

.globl	main
.type	main,@function
main	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$16,%esp

	subl	$4,%esp
	movl	$1,%ebx
	imull	$10,%ebx
	movl	%ebx,%eax
	movl	%eax,0(%esp)
	call	malloc
	addl	$4,%esp
	movl	%eax,-16(%ebp)

	movl	8(%ebp),%ebx
	cmpl	$3,%ebx
	movl	$1,%eax
	jne	main_reltrue_1
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

	subl	$8,%esp
	movl	$symtab+18,0(%esp)
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
	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,0(%esp)
	call	exit
	addl	$4,%esp
	jmp	main_endif_0
main_elsebl_0	:	
main_endif_0	:	

	subl	$12,%esp
	pushl	$1
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	imull	$4,%esi
	addl	%esi,%eax
	movl	(%eax),%eax
	movl	%eax,0(%esp)
	movl	$0,4(%esp)
	movl	$0,8(%esp)
	call	open
	addl	$12,%esp
	movl	%eax,-4(%ebp)

	subl	$12,%esp
	pushl	$2
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	imull	$4,%esi
	addl	%esi,%eax
	movl	(%eax),%eax
	movl	%eax,0(%esp)
	movl	$64,%ebx
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

main_while_2	:	
	movl	$1,%eax
	testl	%eax,%eax
	jz	main_endwhile_2

	subl	$12,%esp
	movl	-4(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-16(%ebp),%eax
	movl	%eax,4(%esp)
	movl	$1,%ebx
	imull	$10,%ebx
	movl	%ebx,%eax
	movl	%eax,8(%esp)
	call	read
	addl	$12,%esp
	movl	%eax,-12(%ebp)

	movl	-12(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	main_reltrue_4
	movl	$0,%eax
main_reltrue_4	:	
	testl	%eax,%eax
	jnz	main_ifbl_3
	jmp	main_elsebl_3
main_ifbl_3	:	
	jmp	main_endwhile_2
main_elsebl_3	:	
main_endif_3	:	

	subl	$12,%esp
	movl	-8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-16(%ebp),%eax
	movl	%eax,4(%esp)
	movl	-12(%ebp),%eax
	movl	%eax,8(%esp)
	call	write
	addl	$12,%esp
	jmp	main_while_2
main_endwhile_2	:	

	subl	$4,%esp
	movl	-4(%ebp),%eax
	movl	%eax,0(%esp)
	call	close
	addl	$4,%esp

	subl	$4,%esp
	movl	-8(%ebp),%eax
	movl	%eax,0(%esp)
	call	close
	addl	$4,%esp

	subl	$4,%esp
	movl	-16(%ebp),%eax
	movl	%eax,0(%esp)
	call	free
	addl	$4,%esp
main_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.section	.data
symtab	:	
.string	"Please invoke by:"
.string	"   %s  infile outfile"
