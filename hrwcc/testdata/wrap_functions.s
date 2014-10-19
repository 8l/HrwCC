# gas-assembler code generated by HrwCC

.section .text
.globl main
.type main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$55, %esp


	movl	%ebp, %eax
	addl	$-1, %eax
	pushl	%eax
	popl	%ebx
	movb	$97, (%ebx)
	movl	%ebp, %eax
	addl	$-5, %eax
	pushl	%eax
	popl	%ebx
	movl	$97, (%ebx)
	subl	$4, %esp
	movl	$symtab+0, 0(%esp)
	call	puts
	addl	$4, %esp
	subl	$4, %esp
	movl	%ebp, %eax
	addl	$-1, %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	movl	%eax, 0(%esp)
	call	isalnum
	addl	$4, %esp
	testl	%eax, %eax
	jnz	main_ifbl_0
	jmp	main_elsebl_0
main_ifbl_0:
	subl	$8, %esp
	movl	$symtab+22, 0(%esp)
	movl	%ebp, %eax
	addl	$-1, %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	movl	%eax, 4(%esp)
	call	printf
	addl	$8, %esp
	jmp	main_endif_0

main_elsebl_0:

main_endif_0:

	subl	$4, %esp
	movl	%ebp, %eax
	addl	$-1, %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	movl	%eax, 0(%esp)
	call	isalpha
	addl	$4, %esp
	testl	%eax, %eax
	jnz	main_ifbl_1
	jmp	main_elsebl_1
main_ifbl_1:
	subl	$8, %esp
	movl	$symtab+56, 0(%esp)
	movl	%ebp, %eax
	addl	$-1, %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	movl	%eax, 4(%esp)
	call	printf
	addl	$8, %esp
	jmp	main_endif_1

main_elsebl_1:

main_endif_1:

	movl	%ebp, %eax
	addl	$-1, %eax
	pushl	%eax
	popl	%ebx
	movb	$51, (%ebx)
	subl	$4, %esp
	movl	%ebp, %eax
	addl	$-1, %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	movl	%eax, 0(%esp)
	call	isdigit
	addl	$4, %esp
	testl	%eax, %eax
	jnz	main_ifbl_2
	jmp	main_elsebl_2
main_ifbl_2:
	subl	$8, %esp
	movl	$symtab+88, 0(%esp)
	movl	%ebp, %eax
	addl	$-1, %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	movl	%eax, 4(%esp)
	call	printf
	addl	$8, %esp
	jmp	main_endif_2

main_elsebl_2:

main_endif_2:

	movl	%ebp, %eax
	addl	$-1, %eax
	pushl	%eax
	popl	%ebx
	movb	$32, (%ebx)
	subl	$4, %esp
	movl	%ebp, %eax
	addl	$-1, %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	movl	%eax, 0(%esp)
	call	isblank
	addl	$4, %esp
	testl	%eax, %eax
	jnz	main_ifbl_3
	jmp	main_elsebl_3
main_ifbl_3:
	subl	$8, %esp
	movl	$symtab+105, 0(%esp)
	movl	%ebp, %eax
	addl	$-1, %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	movl	%eax, 4(%esp)
	call	printf
	addl	$8, %esp
	jmp	main_endif_3

main_elsebl_3:

main_endif_3:

	movl	%ebp, %eax
	addl	$-1, %eax
	pushl	%eax
	subl	$4, %esp
	movl	%ebp, %eax
	addl	$-5, %eax
	movl	(%eax), %eax
	movl	%eax, 0(%esp)
	call	toupper
	addl	$4, %esp
	popl	%ebx
	movb	%al, (%ebx)
	subl	$8, %esp
	movl	$symtab+122, 0(%esp)
	movl	%ebp, %eax
	addl	$-1, %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	movl	%eax, 4(%esp)
	call	printf
	addl	$8, %esp
	movl	%ebp, %eax
	addl	$-1, %eax
	pushl	%eax
	subl	$4, %esp
	movl	%ebp, %eax
	addl	$-5, %eax
	movl	(%eax), %eax
	movl	%eax, 0(%esp)
	call	tolower
	addl	$4, %esp
	popl	%ebx
	movb	%al, (%ebx)
	subl	$8, %esp
	movl	$symtab+135, 0(%esp)
	movl	%ebp, %eax
	addl	$-1, %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	movl	%eax, 4(%esp)
	call	printf
	addl	$8, %esp
	movl	%ebp, %eax
	addl	$-1, %eax
	pushl	%eax
	popl	%ebx
	movb	$97, (%ebx)
	movl	%ebp, %eax
	addl	$-5, %eax
	pushl	%eax
	subl	$4, %esp
	movl	$symtab+150, 0(%esp)
	call	atoi
	addl	$4, %esp
	popl	%ebx
	movl	%eax, (%ebx)
	subl	$8, %esp
	movl	$symtab+153, 0(%esp)
	movl	%ebp, %eax
	addl	$-5, %eax
	movl	(%eax), %eax
	movl	%eax, 4(%esp)
	call	printf
	addl	$8, %esp
	subl	$4, %esp
	movl	$symtab+170, 0(%esp)
	call	puts
	addl	$4, %esp
	subl	$8, %esp
	movl	%ebp, %eax
	addl	$-55, %eax
	movl	%eax, 0(%esp)
	movl	$symtab+171, 4(%esp)
	call	strcpy
	addl	$8, %esp
	subl	$4, %esp
	movl	%ebp, %eax
	addl	$-55, %eax
	movl	%eax, 0(%esp)
	call	puts
	addl	$4, %esp
	subl	$12, %esp
	movl	%ebp, %eax
	addl	$-55, %eax
	movl	%eax, 0(%esp)
	movl	$symtab+192, 4(%esp)
	movl	$6, 8(%esp)
	call	strncpy
	addl	$12, %esp
	subl	$4, %esp
	movl	%ebp, %eax
	addl	$-55, %eax
	movl	%eax, 0(%esp)
	call	puts
	addl	$4, %esp
	subl	$8, %esp
	movl	%ebp, %eax
	addl	$-55, %eax
	movl	%eax, 0(%esp)
	movl	$symtab+199, 4(%esp)
	call	strcpy
	addl	$8, %esp
	subl	$8, %esp
	movl	%ebp, %eax
	addl	$-55, %eax
	movl	%eax, 0(%esp)
	movl	$symtab+213, 4(%esp)
	call	strcat
	addl	$8, %esp
	subl	$4, %esp
	movl	%ebp, %eax
	addl	$-55, %eax
	movl	%eax, 0(%esp)
	call	puts
	addl	$4, %esp
	subl	$12, %esp
	movl	%ebp, %eax
	addl	$-55, %eax
	movl	%eax, 0(%esp)
	movl	$symtab+221, 4(%esp)
	movl	$4, 8(%esp)
	call	strncat
	addl	$12, %esp
	subl	$4, %esp
	movl	%ebp, %eax
	addl	$-55, %eax
	movl	%eax, 0(%esp)
	call	puts
	addl	$4, %esp
	subl	$8, %esp
	movl	$symtab+227, 0(%esp)
	movl	$symtab+230, 4(%esp)
	call	strcmp
	addl	$8, %esp
	pushl	%eax
	popl	%ebx
	cmpl	$0, %ebx
	movl	$1, %eax
	jl	main_reltrue_5
	movl	$0, %eax
main_reltrue_5:
	testl	%eax, %eax
	jnz	main_ifbl_4
	jmp	main_elsebl_4
main_ifbl_4:
	subl	$4, %esp
	movl	$symtab+233, 0(%esp)
	call	puts
	addl	$4, %esp
	jmp	main_endif_4

main_elsebl_4:

main_endif_4:

	subl	$12, %esp
	movl	$symtab+227, 0(%esp)
	movl	$symtab+230, 4(%esp)
	movl	$2, 8(%esp)
	call	strncmp
	addl	$12, %esp
	pushl	%eax
	popl	%ebx
	cmpl	$0, %ebx
	movl	$1, %eax
	jl	main_reltrue_7
	movl	$0, %eax
main_reltrue_7:
	testl	%eax, %eax
	jnz	main_ifbl_6
	jmp	main_elsebl_6
main_ifbl_6:
	subl	$4, %esp
	movl	$symtab+233, 0(%esp)
	call	puts
	addl	$4, %esp
	jmp	main_endif_6

main_elsebl_6:

main_endif_6:

	subl	$8, %esp
	movl	$symtab+241, 0(%esp)
	subl	$4, %esp
	movl	$symtab+263, 0(%esp)
	call	strlen
	addl	$4, %esp
	movl	%eax, 4(%esp)
	call	printf
	addl	$8, %esp
	subl	$4, %esp
	movl	$symtab+170, 0(%esp)
	call	puts
	addl	$4, %esp
	subl	$8, %esp
	movl	%ebp, %eax
	addl	$-55, %eax
	movl	%eax, 0(%esp)
	movl	$symtab+267, 4(%esp)
	call	strcpy
	addl	$8, %esp
	subl	$12, %esp
	movl	%ebp, %eax
	addl	$-55, %eax
	movl	%eax, 0(%esp)
	movl	$45, 4(%esp)
	movl	$6, 8(%esp)
	call	memset
	addl	$12, %esp
	subl	$4, %esp
	movl	%ebp, %eax
	addl	$-55, %eax
	movl	%eax, 0(%esp)
	call	puts
	addl	$4, %esp
	subl	$8, %esp
	movl	%ebp, %eax
	addl	$-55, %eax
	movl	%eax, 0(%esp)
	movl	$symtab+311, 4(%esp)
	call	strcpy
	addl	$8, %esp
	subl	$12, %esp
	movl	%ebp, %eax
	addl	$-55, %eax
	movl	%eax, 0(%esp)
	movl	$symtab+313, 4(%esp)
	movl	$19, 8(%esp)
	call	memcpy
	addl	$12, %esp
	subl	$4, %esp
	movl	%ebp, %eax
	addl	$-55, %eax
	movl	%eax, 0(%esp)
	call	puts
	addl	$4, %esp
	subl	$4, %esp
	movl	$10, 0(%esp)
	call	malloc
	addl	$4, %esp
	movl	%ebp, %eax
	addl	$-5, %eax
	pushl	%eax
	subl	$4, %esp
	movl	$20, 0(%esp)
	call	malloc
	addl	$4, %esp
	popl	%ebx
	movl	%eax, (%ebx)
	subl	$8, %esp
	movl	$symtab+332, 0(%esp)
	movl	%ebp, %eax
	addl	$-5, %eax
	movl	(%eax), %eax
	movl	%eax, 4(%esp)
	call	printf
	addl	$8, %esp
	subl	$4, %esp
	movl	$30, 0(%esp)
	call	malloc
	addl	$4, %esp
	subl	$4, %esp
	movl	%ebp, %eax
	addl	$-5, %eax
	movl	(%eax), %eax
	movl	%eax, 0(%esp)
	call	free
	addl	$4, %esp
	subl	$4, %esp
	movl	$symtab+351, 0(%esp)
	call	puts
	addl	$4, %esp
	movl	%ebp, %eax
	addl	$-5, %eax
	pushl	%eax
	subl	$4, %esp
	movl	$20, 0(%esp)
	call	malloc
	addl	$4, %esp
	popl	%ebx
	movl	%eax, (%ebx)
	subl	$8, %esp
	movl	$symtab+356, 0(%esp)
	movl	%ebp, %eax
	addl	$-5, %eax
	movl	(%eax), %eax
	movl	%eax, 4(%esp)
	call	printf
	addl	$8, %esp
	movl	%ebp, %eax
	addl	$-5, %eax
	pushl	%eax
	subl	$8, %esp
	movl	%ebp, %eax
	addl	$-5, %eax
	movl	(%eax), %eax
	movl	%eax, 0(%esp)
	movl	$30, 4(%esp)
	call	realloc
	addl	$8, %esp
	popl	%ebx
	movl	%eax, (%ebx)
	subl	$8, %esp
	movl	$symtab+393, 0(%esp)
	movl	%ebp, %eax
	addl	$-5, %eax
	movl	(%eax), %eax
	movl	%eax, 4(%esp)
	call	printf
	addl	$8, %esp


main_ret:
	movl	%ebp, %esp
	popl	%ebp
	ret




# The symbol table 

.section .data
symtab:
	.string	"Wrapping functions..."
	.string	"[%c] is a alphanumeric character\n"
	.string	"[%c] is a alphabetic character\n"
	.string	"[%c] is a digit\n"
	.string	"[%c] is a blank\n"
	.string	"[%c] is big\n"
	.string	"[%c] is small\n"
	.string	"45"
	.string	"atoi(45): [%d] \n"
	.string	""
	.string	"strcpy  successfull!"
	.string	"------"
	.string	"concatenated "
	.string	"string!"
	.string	" 1234"
	.string	"ab"
	.string	"ac"
	.string	"ab < ac"
	.string	"abc is %d chars long\n"
	.string	"abc"
	.string	"almost every programmer should know memset!"
	.string	" "
	.string	"memcpy successfull"
	.string	"malloc returns %d\n"
	.string	"free"
	.string	"malloc should return same value: %d\n"
	.string	"realloc should return value 50 greater: %d\n"

