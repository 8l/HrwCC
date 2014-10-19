	movl	8(%eax),%eax
.section	.text
.globl	main
main	:	
	movl	$1,%ebdx
	movl	%a,%d
	jmp	foo
	jnz	bar
	jmp	foo
	movl	%eadx,%ebdx
foo	:	
	popl	%eax
	pushl	%ebx
bar	:	
	popl	%ecx
	pushl	%ecx
.section	.data
.string	"foo\\ x\n"
.string	"../include"
.string	"Could not allocate new memory"
.string	"Found filename [%s] exceeds MAX_FILENAME_LENGTH"
.string	"Could not find system-include for [%s]"
.string	"Filestack exceeded"
.string	"Could not include [%s]"
.string	"No newline at end of file [%s]"
