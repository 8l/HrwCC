#include "VM.h"
#include "ExecParser.h"

VM::VM(ifstream &_input)
{
	//initialize the memory
	this->memory = new Memory();

	//parse input file	
	ExecParser parser(_input, this->memory);
	parser.parse();

	//the instructions are parsed and stored accordingly in the InstructionsDecoder
	//and the data section is parsed and allocated in memory

	//let's initialize the CPU
	this->cpu = new CPU(this->memory);
}

VM::~VM()
{
	free(this->cpu);
	free(this->memory);
}

void VM::setDebug(bool _state)
{
}

void VM::setProgramArguments(int argc, char **argv)
{
	this->memory->setProgramArguments(argc, argv);
}

int VM::executeNextInstruction()
{
	return cpu->executeNextInstruction();
}

bool VM::isEof(int _state)
{
	return (_state == VM_EOF);
}
