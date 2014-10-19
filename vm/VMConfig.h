#ifndef VM_CONFIG_H
#define VM_CONFIG_H

	#define VM_EOF                        1  //EOF - means termination of the running program

	//some defines for virtual memory (VM still stands for virtual machine :D)
	#define VM_VIRTUAL_MEM_SIZE        2048 //in bytes; 2GB address-space
	#define VM_VIRTUAL_MEM_BLOCK_SIZE  (1024*1024) //in bytes; each block in the virtual memory has 1MB
	#define VM_VIRTUAL_MEM_STACK_SIZE     2 //in mb; how many blocks are allocated for the stack
	#define VM_STACK_BASE_ADDR (VM_VIRTUAL_MEM_SIZE*VM_VIRTUAL_MEM_BLOCK_SIZE) //base addr means the TOP address
	#define VM_STACK_INIT_ADDR			VM_STACK_BASE_ADDR-4*1024 //where esp is initialized -- space above is for cli args...


	#define VM_BYTE_SIZE                  8 //used for bytewise int handling
	#define VM_MALLOC_SIZE				100*VM_VIRTUAL_MEM_BLOCK_SIZE	//Number of bytes which can be malloced is 20MB

	#define VM_MAX_STRING_LENGTH            512

#endif
