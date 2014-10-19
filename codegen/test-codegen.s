
.section	.text

.globl	main
.type	main,@function
main	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$21800,%esp

	movl	8(%ebp),%ebx
	cmpl	$1,%ebx
	movl	$1,%eax
	je	main_reltrue_1
	movl	$0,%eax
main_reltrue_1	:	
	testl	%eax,%eax
	jnz	main_ifbl_0
	jmp	main_elsebl_0
main_ifbl_0	:	

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-21792,%eax
	movl	%eax,0(%esp)
	movl	$symtab+0,4(%esp)
	call	strcpy
	addl	$8,%esp
	jmp	main_endif_0
main_elsebl_0	:	

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-21792,%eax
	movl	%eax,0(%esp)
	pushl	$1
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	imull	$4,%esi
	addl	%esi,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	strcpy
	addl	$8,%esp
main_endif_0	:	

	subl	$8,%esp
	movl	$symtab+16,0(%esp)
	movl	%ebp,%eax
	addl	$-21792,%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$4,%esp
	movl	$symtab+31,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-20728,%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-21792,%eax
	movl	%eax,4(%esp)
	call	preproc_create
	addl	$8,%esp
	testl	%eax,%eax
	jnz	main_ifbl_2
	jmp	main_elsebl_2
main_ifbl_2	:	

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	main_ret
main_elsebl_2	:	
main_endif_2	:	

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-20728,%eax
	movl	%eax,0(%esp)
	movl	$symtab+49,4(%esp)
	call	preproc_addDefine
	addl	$8,%esp

	subl	$4,%esp
	movl	$symtab+59,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-20749,%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-20728,%eax
	movl	%eax,4(%esp)
	call	scanner_init
	addl	$8,%esp

	subl	$4,%esp
	movl	$symtab+75,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-21345,%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-20749,%eax
	movl	%eax,4(%esp)
	call	parser_init
	addl	$8,%esp

	subl	$4,%esp
	movl	$symtab+90,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-21345,%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-21361,%eax
	movl	%eax,4(%esp)
	call	symbol_CreateSymbolTable
	addl	$8,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-21345,%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-21361,%eax
	movl	%eax,4(%esp)
	call	parser_setSymbolTable
	addl	$8,%esp

	subl	$4,%esp
	movl	$symtab+114,0(%esp)
	call	puts
	addl	$4,%esp

	subl	$12,%esp
	movl	$symtab+140,0(%esp)
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
	movl	$6,%ebx
	imull	$8,%ebx
	movl	%ebx,%eax
	popl	%ebx
	addl	%eax,%ebx
	addl	$4,%ebx
	movl	%ebx,%eax
	movl	%eax,8(%esp)
	call	open
	addl	$12,%esp
	movl	%eax,-21800(%ebp)

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-21537,%eax
	movl	%eax,0(%esp)
	movl	-21800(%ebp),%eax
	movl	%eax,4(%esp)
	movl	%ebp,%eax
	addl	$-21345,%eax
	movl	%eax,8(%esp)
	call	codegen_CreateCodeGen
	addl	$12,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-21345,%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-21537,%eax
	movl	%eax,4(%esp)
	call	parser_setCodegen
	addl	$8,%esp

	movl	%ebp,%eax
	addl	$-21537,%eax
	addl	$12,%eax
	movl	%eax,%ebx
	movl	$1,(%ebx)

	movl	%ebp,%eax
	addl	$-21537,%eax
	addl	$16,%eax
	movl	%eax,%ebx
	movl	$1,(%ebx)

	subl	$0,%esp
	call	syntax_CreateTreeNode
	addl	$0,%esp
	movl	%eax,-21796(%ebp)

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-21345,%eax
	movl	%eax,0(%esp)
	movl	-21796(%ebp),%eax
	movl	%eax,4(%esp)
	call	parser_buildSyntaxTree
	addl	$8,%esp

	subl	$8,%esp
	movl	$symtab+151,0(%esp)
	movl	%ebp,%eax
	addl	$-21345,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$8,%esp
	movl	$symtab+180,0(%esp)
	movl	%ebp,%eax
	addl	$-21361,%eax
	addl	$4,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$8,%esp
	movl	$symtab+208,0(%esp)
	movl	%ebp,%eax
	addl	$-21537,%eax
	addl	$4,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$8,%esp
	movl	$symtab+237,0(%esp)
	movl	%ebp,%eax
	addl	$-21537,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$4,%esp
	movl	-21796(%ebp),%eax
	movl	%eax,0(%esp)
	call	syntax_FreeSyntaxTree
	addl	$4,%esp

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-21361,%eax
	movl	%eax,0(%esp)
	call	symbol_destroy
	addl	$4,%esp

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-20728,%eax
	movl	%eax,0(%esp)
	call	preproc_destroy
	addl	$4,%esp

	subl	$4,%esp
	movl	-21800(%ebp),%eax
	movl	%eax,0(%esp)
	call	close
	addl	$4,%esp

	movl	$0,%eax
	jmp	main_ret
main_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.section	.data
symtab	:	
.string	"testdata/main.c"
.string	"Compiling %s:\n"
.string	"Create preproc..."
.string	"__HRWCC__"
.string	"Init scanner..."
.string	"Init parser..."
.string	"Create symbol table...\n"
.string	"Create code generator...\n"
.string	"./output.s"
.string	"\nDetected %d parser errors.\n"
.string	"Detected %d symbol errors.\n"
.string	"Detected %d codegen errors.\n"
.string	"Detected %d codegen warnings.\n"
