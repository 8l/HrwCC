#ifndef CPU_H
#define CPU_H

#include <iostream>
#include <vector>
#include <string>

#include "Memory.h"
#include "InstructionsFetcher.h"
#include "Instruction.h"
#include "Utils.h"
#include "VMConfig.h"
#include "Register.h"

using namespace std;

class CPU
{
	private:
		int pc;
		int stackSize;
		Register registers[10];
		Eflag_register eflag;
		Memory *memory;

		/**
		 * Get the address given by the tokens
		 */
		int getAddressByTokens( Tokens tokens );

		/**
		 * Test if there is something like %s oder %34234s in string fmt
		 */
		int containsStrInFmt(char* fmt);

	public:
		/**
		 * constructor for the CPU class
		 * which initializes all necessary data structures
		 */
		CPU(Memory *_memory);

		/**
		 * destructor for a CPU object
		 */		
		~CPU();

		/**
		 * execute the next instruction from the InstructionsFetcher
		 * instructions buffer. returns VM_EOF if the program terminated
		 */
		int executeNextInstruction();

		/**
		 * decode an instruction
		 */
		int decodeInstruction(Instruction *);

		void setValuel(Tokens, int);
		int getValuel(Tokens);
		

		void setValueb(Tokens, char);
		char getValueb(Tokens);

		int resolveRegister(string);
		void showRegisters();
		void showStack();
		void adjustStack();

		void wrapFunction(string);
		char *getString (int);
};

#endif
