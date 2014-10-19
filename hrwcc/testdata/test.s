
.section	.text

.globl	main
.type	main,@function
main	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$8,%esp

	movl	symtab+0,%eax
	movl	%eax,-4(%ebp)

	movl	8(%ebp),%eax
	movl	%eax,-4(%ebp)

	movl	-8(%ebp),%eax
	movl	%eax,-4(%ebp)
main_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.section	.data
symtab	:	

.long	0
