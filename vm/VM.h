#ifndef VM_H
#define VM_H

#include <iostream>
#include <fstream>
#include "VMConfig.h"

#include "CPU.h"
#include "Memory.h"

using namespace std;

class VM
{
	private:
		CPU *cpu;
		Memory *memory;

	public:
		VM(ifstream &_input);
		~VM();
		void setDebug(bool _state);
		void setProgramArguments(int argc, char **argv);
		int executeNextInstruction();
		bool isEof(int _state);
};

#endif
