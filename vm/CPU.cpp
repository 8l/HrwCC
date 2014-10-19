#include "CPU.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <ctype.h>
#include <fcntl.h>
#include <unistd.h>
#include <assert.h>

CPU::CPU(Memory *_memory)
{
	pc        = 0;
	stackSize = VM_VIRTUAL_MEM_STACK_SIZE;
	memory    = _memory;

//	I----------- %eax -----------I
//	I------------I------%ax------I
//	I------------I--%ah--I--%al--I

	registers[0].value = 0; // %eax
	registers[1].value = 0; // %ebx
	registers[2].value = 0; // %ecx
	registers[3].value = 0; // %edx
	registers[4].value = 0; // %edi
	registers[5].value = 0; // %esi
	registers[6].value = 0; // %ebp
	registers[7].value = 0;
	registers[8].value = 0; // %eip
	registers[9].value = VM_STACK_INIT_ADDR; // %esp

	// print memory
	/*for ( int i = 0; i < 1000; i++ )
	{
		cout << i << ": \t"<< memory->getb(i) << endl;
	}*/

}

CPU::~CPU()
{
}

int CPU::executeNextInstruction()
{
	// fetch instructions as long as there ar esome
	Instruction *instruction = InstructionsFetcher::getInstance()->getInstruction(pc);

	return decodeInstruction(instruction);
}

int CPU::decodeInstruction( Instruction *instruction )
{
	//cout << "Instruction: " << instruction->getOpcode() << "\t PC: " << pc << "\t line: " << instruction->getOp1().line_no << endl;

	//fgetc(stdin);

	// data transfer instructions:
	if ( instruction->getOpcode() == "movl" )
	{
		setValuel(instruction->getOp2(), getValuel(instruction->getOp1()));
	}
	else if ( instruction->getOpcode() == "movb" )
	{
		setValueb(instruction->getOp2(), getValueb(instruction->getOp1()));
	}
	else if ( instruction->getOpcode() == "popl" )
	{

		setValuel(instruction->getOp1(), memory->getl(registers[9].value));
		// increment %esp
		registers[9].value += 4;
	}
	else if ( instruction->getOpcode() == "pushl" )
	{
		// decrement %esp
		registers[9].value -= 4;
		memory->setl(registers[9].value, getValuel(instruction->getOp1()));
	}
	else if ( instruction->getOpcode() == "popb" )
	{
		setValueb(instruction->getOp1(), memory->getb(registers[9].value));
		// increment %esp
		registers[9].value++;
	}
	else if ( instruction->getOpcode() == "pushb" )
	{
		registers[9].value--;
		memory->setb(registers[9].value, getValueb(instruction->getOp1()));	
	}

	// interger instructions:
	else if ( instruction->getOpcode() == "addl" )
	{
		setValuel(instruction->getOp2(), getValuel(instruction->getOp2()) + getValuel(instruction->getOp1()));
	}
	else if ( instruction->getOpcode() == "cmpl" )
	{
		int left = getValuel(instruction->getOp1());
		int right = getValuel(instruction->getOp2());


		eflag.zf = right-left == 0 ? 1 : 0;
		eflag.sf = right-left < 0 ? 1 : 0;
	}
	else if ( instruction->getOpcode() == "idivl" )
	{
		// write remainder into edx
		registers[3].value = registers[0].value % getValuel(instruction->getOp1());
		// write quotient into eax
		registers[0].value = registers[0].value / getValuel(instruction->getOp1());
	}
	else if ( instruction->getOpcode() == "imull" )
	{
		setValuel(instruction->getOp2(), getValuel(instruction->getOp2()) * getValuel(instruction->getOp1()));
	}
	else if ( instruction->getOpcode() == "negl" )
	{
		setValuel(instruction->getOp1(), -getValuel(instruction->getOp1()));
	}
	else if ( instruction->getOpcode() == "subl" )
	{
		setValuel(instruction->getOp2(), getValuel(instruction->getOp2()) - getValuel(instruction->getOp1()));
	}
	else if ( instruction->getOpcode() == "andl" )
	{
		setValuel(instruction->getOp2(), getValuel(instruction->getOp2()) & getValuel(instruction->getOp1()));
	}
	else if ( instruction->getOpcode() == "notl" )
	{
		// create complement by XORing
		setValuel(instruction->getOp1(), getValuel(instruction->getOp1()) ^ 0xFFFFFFFF);
	}
	else if ( instruction->getOpcode() == "orl" )
	{
		setValuel(instruction->getOp2(), getValuel(instruction->getOp2()) | getValuel(instruction->getOp1()));
	}
	else if ( instruction->getOpcode() == "xorl" )
	{
		setValuel(instruction->getOp2(), getValuel(instruction->getOp2()) ^ getValuel(instruction->getOp1()));
	}
	else if ( instruction->getOpcode() == "testl" )
	{
		eflag.zf =  (getValuel(instruction->getOp2()) & getValuel(instruction->getOp1())) == 0
						? 1: 0; 

		eflag.sf =  (getValuel(instruction->getOp2()) & getValuel(instruction->getOp1())) < 0
						? 1: 0; 

	}
	else if ( instruction->getOpcode() == "movsbl" )
	{
		int msb = 0;
		if((0x80 & getValueb(instruction->getOp1())) != 0)
		{
			msb = 1;
		}
		if ( msb )
		{
			setValuel(instruction->getOp2(), getValueb(instruction->getOp1())  | 0xffffff00);
		}
		else
		{
			setValuel(instruction->getOp2(), getValueb(instruction->getOp1())  & 0x000000ff);
		}
		
	}
	// byte instructions:
	else if ( instruction->getOpcode() == "addb" )
	{
		setValueb(instruction->getOp2(), getValueb(instruction->getOp2()) + getValueb(instruction->getOp1()));
	}
	else if ( instruction->getOpcode() == "cmpb" )
	{

		eflag.zf = (getValueb(instruction->getOp2()) - getValueb(instruction->getOp1())) == 0
						? 1 : 0;

		eflag.sf = (getValueb(instruction->getOp2()) - getValueb(instruction->getOp1())) < 0
						? 1 : 0;
	}
	else if ( instruction->getOpcode() == "idivb" )
	{
		// write quotient into eax
		registers[3].value = getValueb(instruction->getOp2()) / getValueb(instruction->getOp1());
		// write remainder into edx
		registers[4].value = getValueb(instruction->getOp2()) % getValueb(instruction->getOp1());
	}
	else if ( instruction->getOpcode() == "imulb" )
	{
		setValueb(instruction->getOp2(), getValueb(instruction->getOp2()) * getValueb(instruction->getOp1()));
	}
	else if ( instruction->getOpcode() == "negb" )
	{
		setValueb(instruction->getOp1(), -getValueb(instruction->getOp1()));
	}
	else if ( instruction->getOpcode() == "subb" )
	{
		setValueb(instruction->getOp2(), getValueb(instruction->getOp2()) - getValueb(instruction->getOp1()));
	}
	else if ( instruction->getOpcode() == "andb" )
	{
		setValueb(instruction->getOp2(), getValueb(instruction->getOp2()) & getValueb(instruction->getOp1()));
	}
	else if ( instruction->getOpcode() == "notb" )
	{
		// create complement by XORing
		setValueb(instruction->getOp1(), getValueb(instruction->getOp1()) ^ 0x000000FF);
	}
	else if ( instruction->getOpcode() == "orb" )
	{
		setValueb(instruction->getOp2(), getValueb(instruction->getOp2()) | getValueb(instruction->getOp1()));
	}
	else if ( instruction->getOpcode() == "xorb" )
	{
		setValueb(instruction->getOp2(), getValueb(instruction->getOp2()) ^ getValueb(instruction->getOp1()));
	}
	else if ( instruction->getOpcode() == "testb" )
	{
		eflag.zf =  (getValueb(instruction->getOp2()) & getValueb(instruction->getOp1())) == 0 
						? 1 : 0;

		eflag.sf =  (getValueb(instruction->getOp2()) & getValueb(instruction->getOp1())) < 0 
						? 1 : 0;
	}

	// flow-control instructions:
	else if ( instruction->getOpcode() == "call" )
	{
		registers[9].value -= 4;
		memory->setl(registers[9].value, pc + 1);
		//registers[8].value = pc;
		
		// wrap the call-function
		wrapFunction(instruction->getOp1()[0]);
	}
	else if ( instruction->getOpcode() == "jmp" )
	{
		// pc is incremented later anyway
		pc = Utils::stringToInt(instruction->getOp1()[0]) - 1;
	}
	else if ( instruction->getOpcode() == "je" )
	{
		if ( eflag.zf == 1 )
		{
			pc = Utils::stringToInt(instruction->getOp1()[0]) - 1;
		}
	}
	else if ( instruction->getOpcode() == "jne" )
	{
		if ( eflag.zf == 0 )
		{
			pc = Utils::stringToInt(instruction->getOp1()[0]) - 1;
		}
	}
	else if ( instruction->getOpcode() == "jz" )
	{
		if ( eflag.zf == 1 )
		{
			pc = Utils::stringToInt(instruction->getOp1()[0]) - 1;
		}
	}
	else if ( instruction->getOpcode() == "jnz" )
	{
		if ( eflag.zf == 0 )
		{
			pc = Utils::stringToInt(instruction->getOp1()[0]) - 1;
		}
	}
	else if ( instruction->getOpcode() == "jg" )
	{
		//Not 0 and not < 0 --> >0
		if ( eflag.zf==0 && eflag.sf == 0  )
		{
			pc = Utils::stringToInt(instruction->getOp1()[0]) - 1;
		}
	}
	else if ( instruction->getOpcode() == "jge" )
	{
		//Not < 0 --> >= 0
		if ( eflag.sf == 0 )
		{
			pc = Utils::stringToInt(instruction->getOp1()[0]) - 1;
		}

	}
	else if ( instruction->getOpcode() == "jl" )
	{
		if ( eflag.sf == 1 )
		{
			pc = Utils::stringToInt(instruction->getOp1()[0]) - 1;
		}

	}
	else if ( instruction->getOpcode() == "jle" )
	{
		// <0 or =0 --> <= 0
		if ( (eflag.zf == 1) || (eflag.sf == 1) )
		{
			pc = Utils::stringToInt(instruction->getOp1()[0]) - 1;
		}

	}
	else if ( instruction->getOpcode() == "ret" )
	{
		registers[8].value = memory->getl(registers[9].value);
		pc = registers[8].value - 1;
		registers[9].value += 4;	
	}
	// is there a keyword to exit??
	else
	{
		return VM_EOF;
	}

	// increment the programmcounter after each instruction
	pc++;
	//showRegisters();
	//printf("zf=%d, sf=%d\n", eflag.zf, eflag.sf);
	//showStack();

	// should the stack grow downwards
	adjustStack();
	return 0;
}

void CPU::adjustStack()
{
	if ( !memory->memory[registers[9].value / VM_VIRTUAL_MEM_BLOCK_SIZE] )
	{
		int idx = registers[9].value / VM_VIRTUAL_MEM_BLOCK_SIZE;

		while( !memory->memory[idx] )
		{
			memory->memory[idx] = new byte[VM_VIRTUAL_MEM_BLOCK_SIZE];
			idx ++;
		}
	}
}


/**
 * Get the address given by tokens (like 45(%ebp, %esi, 3) or 564 or (%eax))
 */
int CPU::getAddressByTokens( Tokens tokens )
{
		int offset = 0;
		int base = 0;
		int index = 0;
		int size = 1;


		//Index, where base register is
		int ibase = 2;

		//Offset given --> base register is at index 2
		if( tokens[0] != "(" )
		{
				offset = Utils::stringToInt( tokens[0] );
				ibase = 3;
		}

		// The part after offset is given
		if( tokens.size() > 1 )
		{
				base = registers[ resolveRegister(tokens[ibase]) ].value;

				//Index register is given too
				if( tokens[ibase+1] == "," )
				{
						index = registers[ resolveRegister(tokens[ibase+3]) ].value;

						//Size is given too
						if( tokens[ibase+3] == "," )
						{
							size = Utils::stringToInt( tokens[ibase+5] );
						}
				}
		}


		return offset + base + index*size;
}

/**
 * Set value to memory or register given by tokens (right resp. second operand)
 */
void CPU::setValuel(Tokens tokens, int value)
{
		//Second operand can be:
		//		register  -->  %reg
		//		address   --> [offset][(% base[, % index[, size]])]
		

		//Register
		if( tokens[0] == "%")
		{
				registers[ resolveRegister(tokens[1]) ].value = value;
		}
		//Address
		else
		{	
				//Set value
				memory->setl( getAddressByTokens(tokens), value);
		}
}


// parse tokens and return a value
int CPU::getValuel(Tokens tokens)
{
		//First operand can be:
		//		immediate --> $ value
		//		register  -->  %reg
		//		address   --> [offset][(% base[, % index[, size]])]
		

		//Immediate value
		if( tokens[0] == "$")
		{
				return Utils::stringToInt( tokens[1] );
		}

		//Register
		else if( tokens[0] == "%")
		{
				return registers[ resolveRegister(tokens[1]) ].value;
		}
		//Address
		else
		{	
				//Set value
				return memory->getl( getAddressByTokens(tokens) );
		}

}

void CPU::setValueb(Tokens tokens, char value)
{
		//Second operand can be:
		//		register  -->  %reg
		//		address   --> [offset][(%base[, %index[, size]])]
		

		//Register
		if( tokens[0] == "%")
		{
				//Register of the form %[a-d][h,l]. i.e. %ah, %bl, %ch

				int regnr = tokens[1][0] - 'a';
				int high = tokens[1][1] == 'h' ? 1 : 0;

				registers[regnr].value_hl[high] = value;
		}
		//Address
		else
		{
				//Set value
				memory->setb( getAddressByTokens(tokens), value);
		}
}

char CPU::getValueb(Tokens tokens)
{

		//First operand can be:
		//		immediate --> $ value
		//		register  -->  %reg
		//		address   --> [offset][(% base[, % index[, size]])]
		

		//Immediate value
		if( tokens[0] == "$")
		{
				return Utils::stringToInt( tokens[1] );
		}

		//Register
		else if( tokens[0] == "%")
		{
				//Register of the form %[a-d][h,l]. i.e. %ah, %bl, %ch

				int regnr = tokens[1][0] - 'a';
				int high = tokens[1][1] == 'h' ? 1 : 0;

				return registers[regnr].value_hl[high];
		}
		//Address
		else
		{	
				//Set value
				return memory->getb( getAddressByTokens(tokens) );
		}
}

// returns the number of a given register
int CPU::resolveRegister (string reg)
{
	if ( reg == "eax" )
		return 0;
	else if ( reg == "ebx" )
		return 1;
	else if ( reg == "ecx" )
		return 2;
	else if ( reg == "edx" )
		return 3;
	else if ( reg == "edi" )
		return 4;
	else if ( reg == "esi" )
		return 5;
	else if ( reg == "ebp" )
		return 6;
	else if ( reg == "eflags" )
		return 7;
	else if ( reg == "eip" )
		return 8;
	else if ( reg == "esp" )
		return 9;
	else
		throw GenericException("Register [" + reg + "] unknown");
}


/**
 * Test if there is something like %s oder %34234s in string fmt
 */
int CPU::containsStrInFmt(char* fmt)
{
	int idx=0;
	const int len = (int) strlen(fmt);

	while( idx < len )
	{
			//Search for %
			while( idx<len  &&  fmt[idx]!='%' ) 
				idx++;

			//Skip %
			idx++;

			//Skip know numbers
			while( idx<len  &&  isdigit(fmt[idx]) )
				idx++;

			//Found a 's'
			if( idx<len  &&  fmt[idx]=='s')
				return 1;

			//Go on...
			idx++;
	}

	return 0;
}


void CPU::wrapFunction (string function_name)
{
	if ( function_name == "puts" )
	{
		puts( getString(memory->getl(registers[9].value + 4)) );
		free( getString(memory->getl(registers[9].value + 4)) );
	}
	else if ( function_name == "printf" )
	{
		char *str = getString(memory->getl(registers[9].value + 4));
		int arg1  = memory->getl(registers[9].value + 8);


		//Dirty hack: By %s we need a pointer of this UNIX process, not
		//a adress of the virtual memory.
		//No %s found
		if( containsStrInFmt(str) )
		{
			char *val = getString(arg1);
			printf (str, val);
			free(val);
		}
		else
		{
			printf (str, arg1);
		}
		free(str);
	}
	else if ( function_name == "sprintf" )
	{
		char str[VM_MAX_STRING_LENGTH];
		char *format = getString(memory->getl(registers[9].value + 8));
		int arg1     = memory->getl(registers[9].value + 12);
		int ret;
		int dest	 = memory->getl(registers[9].value+4);
		int i;

		//Dirty hack: By %s we need a pointer of this UNIX process, not
		//a adress of the virtual memory.
		//No %s found
		if( containsStrInFmt(format) )
		{
			char *val = getString(arg1);
			ret = sprintf (str, format, val);
		}
		else
		{
			ret = sprintf (str, format, arg1);
		}

		for(i=0; str[i] != '\0'; i++)
		{
				memory->setb(dest+i, str[i]);
		}

		// '\0' is needed too!
		memory->setb(dest+i, str[i]);

		registers[0].value = ret;
		free(format);
	}
	else if ( function_name == "open" )
	{
		char *file = getString(memory->getl(registers[9].value + 4));
		int flag = memory->getl(registers[9].value + 8);
		int mode = memory->getl(registers[9].value + 12);

		registers[0].value = open(file, flag, mode);

		free(file);
	}
	else if ( function_name == "read" )
	{
		int val;
		int fd     = memory->getl(registers[9].value + 4);
		//void *buf  = (void*)memory->getl(registers[9].value + 8);
		int size   = memory->getl(registers[9].value + 12);

		char buffer[size];

		val = read(fd, buffer, size);
		for (int idx = 0; idx < val; idx++)
		{
			memory->setb(memory->getl(registers[9].value + 8) + idx, buffer[idx]);
		}
		registers[0].value = val;
	}
	else if ( function_name == "write" )
	{
		int val;
		int fd     = memory->getl(registers[9].value + 4);
		//void *buf  = (void*)memory->getl(registers[9].value + 8);
		int size   = memory->getl(registers[9].value + 12);

		char buffer[size];

		for (int idx = 0; idx < size; idx++)
		{
			buffer[idx] = memory->getb(memory->getl(registers[9].value + 8) + idx);
		}

		val = write(fd, buffer, size);

		registers[0].value = val;
	}
	else if ( function_name == "close" )
	{
		int fd = memory->getl(registers[9].value + 4);

		close(fd);
	}
	else if ( function_name == "memset" )
	{
		int val  = memory->getl(registers[9].value + 8);
		int size = memory->getl(registers[9].value + 12);
		int idx  = 0;
		
		while ( idx < size )
		{
			memory->setb(memory->getl(registers[9].value + 4) + idx, val);
			idx ++;
		}
	}
	else if ( function_name == "memcpy" )
	{
		int size = memory->getl(registers[9].value + 12);
		int idx  = 0;
		int dest = memory->getl(registers[9].value + 4);
		int src = memory->getl(registers[9].value + 8);

		// wrap memset by using setb
		while ( idx < size )
		{
			memory->setb(dest + idx, memory->getb(src + idx));
			idx ++;
		}
	}
	else if ( function_name == "malloc" )
	{
		registers[0].value = memory->allocate(memory->getl(registers[9].value + 4));
	}
	else if ( function_name == "realloc" )
	{
		int ptr  = memory->getl(registers[9].value + 4);
		int size = memory->getl(registers[9].value + 8);
		int new_ptr;
		int oldsize = memory->getSizeOfMalloc(ptr);

		new_ptr = memory->allocate(size);
		for ( int idx = 0; idx < oldsize; idx++ )
		{
			memory->setb(new_ptr + idx, memory->getb(ptr + idx));
		}
		memory->free(ptr);
		registers[0].value = new_ptr;
	}
	else if ( function_name == "free" )
	{
		memory->free(memory->getl(registers[9].value + 4));
	}
	else if ( function_name == "exit" )
	{
		registers[0].value = memory->getl(registers[9].value + 4);
		exit(registers[0].value);
	}
	else if ( function_name == "isalnum" )
	{
		registers[0].value = memory->getl(registers[9].value + 4);
		registers[0].value = isalnum(registers[0].value);
	}
	else if ( function_name == "isalpha" )
	{
		registers[0].value = memory->getl(registers[9].value + 4);
		registers[0].value = isalpha(registers[0].value);
	}
	else if ( function_name == "isdigit" )
	{
		registers[0].value = memory->getl(registers[9].value + 4);
		registers[0].value = isdigit(registers[0].value);
	}
	else if ( function_name == "isblank" )
	{
		registers[0].value = memory->getl(registers[9].value + 4);
		registers[0].value = isblank(registers[0].value);
	}
	else if ( function_name == "tolower" )
	{
		registers[0].value = memory->getl(registers[9].value + 4);
		registers[0].value = tolower(registers[0].value);
	}
	else if ( function_name == "toupper" )
	{
		registers[0].value = memory->getl(registers[9].value + 4);
		registers[0].value = toupper(registers[0].value);
	}
	else if ( function_name == "atoi" )
	{
		char* str = getString(memory->getl(registers[9].value + 4));
		registers[0].value = atoi(str);
	}
	else if ( function_name == "strcpy" )
	{
		unsigned int idx = 0;
		char* str = getString(memory->getl(registers[9].value + 8));
		
		while ( idx < strlen(str) )
		{
			memory->setb(memory->getl(registers[9].value + 4) + idx, str[idx]);
			idx++;
		}
		memory->setb(memory->getl(registers[9].value + 4) + idx, '\0');
	}
	else if ( function_name == "strncpy" )
	{
		int maxsize = memory->getl(registers[9].value + 12);
		int idx = 0;
		char* str = getString(memory->getl(registers[9].value + 8));

		while ( idx < maxsize  && idx < (int)strlen(str) )
		{
			memory->setb(memory->getl(registers[9].value + 4) + idx, str[idx]);
			idx++;
		}

		//Write terminating zero if we have not written maxsize-many chars
		if( idx < maxsize)
			memory->setb(memory->getl(registers[9].value + 4) + idx, '\0');
		free(str);
	}
	else if ( function_name == "strcat" )
	{
		unsigned int idx = 0;
		char* src = getString(memory->getl(registers[9].value + 8));
		char* dest = getString(memory->getl(registers[9].value + 4));

		while ( idx < strlen(src))
		{
			memory->setb(memory->getl(registers[9].value + 4) + strlen(dest) + idx, src[idx]);
			idx++;
		}

		//Last terminating zero.
		memory->setb(memory->getl(registers[9].value + 4) + strlen(dest) + idx, '\0');
		registers[0].value = memory->getl(registers[9].value + 4);

		free(src);
		free(dest);
	}
	else if ( function_name == "strncat" )
	{
		int maxsize = memory->getl(registers[9].value + 12);
		char* src = getString(memory->getl(registers[9].value + 8));
		char* dest = getString(memory->getl(registers[9].value + 4));

		int idx = 0;

		while ( idx <  maxsize && idx < (int)strlen(src) )
		{
			memory->setb(memory->getl(registers[9].value + 4) + strlen(dest) + idx, src[idx]);
			idx++;
		}
		memory->setb(memory->getl(registers[9].value + 4) + strlen(dest) + idx, '\0');

		//Write terminating zero if we have not written maxsize-many chars
		if( idx < maxsize)
			memory->setb(memory->getl(registers[9].value + 4) + strlen(dest) + idx, '\0');

		registers[0].value = memory->getl(registers[9].value + 4);

		free(src);
		free(dest);
	}
	else if ( function_name == "strcmp" )
	{
		char* val1 = getString(memory->getl(registers[9].value + 4));
		char* val2 = getString(memory->getl(registers[9].value + 8));
		registers[0].value = strcmp(val1, val2);

		free(val1);
		free(val2);
	}
	else if ( function_name == "strncmp" )
	{
		char* val1 = getString(memory->getl(registers[9].value + 4));
		char* val2 = getString(memory->getl(registers[9].value + 8));

		registers[0].value = strncmp(val1, val2 , memory->getl(registers[9].value + 12) );

		free(val1);
		free(val2);
	}
	else if ( function_name == "strlen" )
	{
		char* val = getString(memory->getl(registers[9].value + 4));
		registers[0].value = strlen(val);

		free(val);
	}
	else
	{
		// simulate push for non 'special' funcs
		registers[9].value -= 4;
		registers[8].value = Utils::stringToInt(function_name);
		pc = Utils::stringToInt(function_name) - 1;
	}
	// simulate pop
	registers[9].value += 4;
}

char *CPU::getString (int addr)
{
	int idx      = 0;
	char *offset = (char*)malloc(VM_MAX_STRING_LENGTH);


	// get all bytes from a given address until the occurrence of '\0'
	while ( memory->getb(addr + idx) != '\0' && idx<VM_MAX_STRING_LENGTH-1 )
	{
		offset[idx] = memory->getb( addr + idx );
		idx++;
	}
	offset[idx] = '\0';

	return offset;
}

// print all the registers
void CPU::showRegisters ()
{
	for (int i = 0; i < 10; i++)
	{
		printf("R%d: %d [0x%lx]\n", i, registers[i].value, (long unsigned) registers[i].value);
	}
	cout << endl;
}

void CPU::showStack ()
{
	int esp;

	esp = registers[9].value;

	for (int i = min(esp+40, VM_STACK_BASE_ADDR-1); i>=esp; i-=4)
	{
		printf("%d: %d [0x%lx]\n", i, memory->getl(i), (long unsigned)memory->getl(i));
	}
	cout << endl;
}
