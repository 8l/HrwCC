
.section .text

.globl _while_start
	movl %sp, %eax
	jeq _while_end
	addl $9, %eax

_while_start:
	cmp %eax, %ebx
	jeq _while_end
	
	addb $1, %al

_while_end:

	pushl _hello_world_string
	call _test
	


_test:
.type fooo
	movl %esp, %ebp
	

#Program constants
.section .data

_hello_world_string:
	.long 0
	.rept 32
		.byte 0
	.endr
		.string "XXXXXXX"
