
.section	.text

.globl	euklidggt
.type	euklidggt,@function
euklidggt	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$8,%esp

	movl	8(%ebp),%ebx
	cmpl	12(%ebp),%ebx
	movl	$1,%eax
	jl	euklidggt_reltrue_2
	movl	$0,%eax
euklidggt_reltrue_2	:	
	testl	%eax,%eax
	jz	euklidggt_logtermfalse_1
	movl	12(%ebp),%ebx
	cmpl	8(%ebp),%ebx
	movl	$1,%eax
	jg	euklidggt_reltrue_3
	movl	$0,%eax
euklidggt_reltrue_3	:	
	testl	%eax,%eax
	jz	euklidggt_logtermfalse_1
	movl	$1,%eax
	jmp	euklidggt_logtermtrue_1
euklidggt_logtermfalse_1	:	
	movl	$0,%eax
euklidggt_logtermtrue_1	:	
	testl	%eax,%eax
	jnz	euklidggt_ifbl_0
	jmp	euklidggt_elsebl_0
euklidggt_ifbl_0	:	

	movl	8(%ebp),%eax
	movl	%eax,-4(%ebp)

	movl	12(%ebp),%eax
	movl	%eax,8(%ebp)

	movl	-4(%ebp),%eax
	movl	%eax,12(%ebp)
	jmp	euklidggt_endif_0
euklidggt_elsebl_0	:	
euklidggt_endif_0	:	

euklidggt_while_4	:	
	movl	12(%ebp),%ebx
	cmpl	$1,%ebx
	movl	$1,%eax
	jg	euklidggt_reltrue_6
	movl	$0,%eax
euklidggt_reltrue_6	:	
	testl	%eax,%eax
	jnz	euklidggt_logexprtrue_5
	movl	$0,%eax
	testl	%eax,%eax
	jnz	euklidggt_logexprtrue_5
	movl	$0,%eax
	jmp	euklidggt_logexprfalse_5
euklidggt_logexprtrue_5	:	
	movl	$1,%eax
euklidggt_logexprfalse_5	:	
	testl	%eax,%eax
	jz	euklidggt_endwhile_4

	movl	8(%ebp),%eax
	movl	$0,%edx
	idivl	12(%ebp)
	movl	%eax,-4(%ebp)

	movl	8(%ebp),%eax
	movl	$0,%edx
	idivl	12(%ebp)
	movl	%edx,%eax
	movl	%eax,-8(%ebp)

	movl	12(%ebp),%eax
	movl	%eax,8(%ebp)

	movl	-8(%ebp),%eax
	movl	%eax,12(%ebp)
	jmp	euklidggt_while_4
euklidggt_endwhile_4	:	

	movl	8(%ebp),%ebx
	imull	$1,%ebx
	movl	%ebx,%eax
	pushl	%eax
	pushl	$6
	movl	$2,%eax
	movl	%eax,%ebx
	popl	%eax
	movl	$0,%edx
	idivl	%ebx
	movl	%edx,%eax
	popl	%ebx
	addl	%eax,%ebx
	pushl	%ebx
	pushl	$2
	movl	$4,%eax
	movl	%eax,%ebx
	popl	%eax
	movl	$0,%edx
	idivl	%ebx
	popl	%ebx
	addl	%eax,%ebx
	movl	%ebx,%eax
	jmp	euklidggt_ret
euklidggt_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	test
.type	test,@function
test	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$4,%esp

	pushl	$0
	movb	8(%ebp),%ah
	popl	%esi
	movb	%ah,-4(%ebp,%esi,1)

	movl	$1,%esi
	movb	$10,-4(%ebp,%esi,1)

	movl	$2,%esi
	movb	$0,-4(%ebp,%esi,1)

	subl	$4,%esp
	movl	$symtab+0,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-4,%eax
	movl	%eax,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$4,%esp
	movl	$symtab+0,0(%esp)
	call	puts
	addl	$4,%esp
test_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	main
.type	main,@function
main	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$9,%esp

	movl	%ebp,%eax
	addl	$-1,%eax
	movl	%eax,-5(%ebp)

	movl	$symtab,%eax
	addl	$7,%eax
	addl	$0,%eax
	movl	%eax,symtab+39

	movl	$symtab,%eax
	addl	$23,%eax
	addl	$12,%eax
	pushl	%eax
	movl	$symtab,%eax
	addl	$7,%eax
	popl	%ebx
	movl	%eax,(%ebx)

	pushl	symtab+39
	movl	$symtab,%eax
	addl	$23,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%ebx
	cmpl	%eax,%ebx
	movl	$1,%eax
	je	main_reltrue_8
	movl	$0,%eax
main_reltrue_8	:	
	testl	%eax,%eax
	jnz	main_ifbl_7
	jmp	main_elsebl_7
main_ifbl_7	:	

	subl	$4,%esp
	movl	$symtab+43,0(%esp)
	call	puts
	addl	$4,%esp
	jmp	main_endif_7
main_elsebl_7	:	
main_endif_7	:	

	movl	$97,-9(%ebp)

	subl	$1,%esp
	movl	-9(%ebp),%eax
	movb	%al,0(%esp)
	call	test
	addl	$1,%esp

	pushl	$0
	movl	$symtab,%eax
	addl	$23,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	addl	$0,%eax
	popl	%esi
	imull	$4,%esi
	addl	%esi,%eax
	movl	%eax,%ebx
	movl	$25,(%ebx)

	movb	$11,-1(%ebp)

	movl	%ebp,%eax
	addl	$-5,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	movb	$30,(%ebx)

	subl	$16,%esp
	movl	$symtab+60,0(%esp)
	pushl	$0
	movl	$symtab,%eax
	addl	$39,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	imull	$4,%esi
	addl	%esi,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	movl	%ebp,%eax
	addl	$-5,%eax
	movl	(%eax),%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,8(%esp)
	subl	$8,%esp
	pushl	$0
	movl	$symtab,%eax
	addl	$7,%eax
	addl	$0,%eax
	addl	$0,%eax
	popl	%esi
	imull	$4,%esi
	addl	%esi,%eax
	movl	(%eax),%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-5,%eax
	movl	(%eax),%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,4(%esp)
	call	euklidggt
	addl	$8,%esp
	movl	%eax,12(%esp)
	call	printf
	addl	$16,%esp

	subl	$8,%esp
	pushl	$0
	movl	$symtab,%eax
	addl	$23,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	addl	$0,%eax
	popl	%esi
	imull	$4,%esi
	addl	%esi,%eax
	movl	(%eax),%eax
	movl	%eax,0(%esp)
	movb	-1(%ebp),%ah
	movsbl	%ah,%eax
	movl	%eax,4(%esp)
	call	euklidggt
	addl	$8,%esp
	jmp	main_ret
main_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.section	.data
symtab	:	
.string	"hello\n"

.rept	16
.byte	0
.endr	

.rept	16
.byte	0
.endr	

.long	0
.string	"Pointer test ok."
.string	"GCD of %d and %d is %d.\n"
