
.section	.text

.globl	preproc_create
.type	preproc_create,@function
preproc_create	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	fstack_init
	addl	$4,%esp

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	commstage_init
	addl	$4,%esp

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	substage_init
	addl	$4,%esp

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	directivestage_init
	addl	$4,%esp

	subl	$12,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	12(%ebp),%eax
	movl	%eax,4(%esp)
	movl	$0,8(%esp)
	call	fstack_pushFile
	addl	$12,%esp
	jmp	preproc_create_ret
preproc_create_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	preproc_destroy
.type	preproc_destroy,@function
preproc_destroy	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	directivestage_destroy
	addl	$4,%esp

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	substage_destroy
	addl	$4,%esp

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	commstage_destroy
	addl	$4,%esp

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	fstack_destroy
	addl	$4,%esp
preproc_destroy_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	preproc_getNext
.type	preproc_getNext,@function
preproc_getNext	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	subl	$12,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$4,4(%esp)
	movl	12(%ebp),%eax
	movl	%eax,8(%esp)
	call	prevstage_getNext
	addl	$12,%esp
	jmp	preproc_getNext_ret
preproc_getNext_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	preproc_getFilename
.type	preproc_getFilename,@function
preproc_getFilename	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	12(%ebp),%eax
	movl	%eax,4(%esp)
	call	fstack_getFilename
	addl	$8,%esp
	jmp	preproc_getFilename_ret
preproc_getFilename_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	preproc_addDefine
.type	preproc_addDefine,@function
preproc_addDefine	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	12(%ebp),%eax
	movl	%eax,4(%esp)
	call	directivestage_addDefine
	addl	$8,%esp
	jmp	preproc_addDefine_ret
preproc_addDefine_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.section	.data
symtab	:	
