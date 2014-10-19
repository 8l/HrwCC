#ifndef INSTRUCTIONS_DECODER_H
#define INSTRUCTIONS_DECODER_H

#include <iostream>
#include <string>
#include <vector>

#include "GenericException.h"
#include "Instruction.h"

using namespace std;

typedef vector<Instruction*> Instructions;

class InstructionsFetcher
{
	private:
		static InstructionsFetcher* instance;
		Instructions instructions;

	public:
		InstructionsFetcher();
		~InstructionsFetcher();
		static InstructionsFetcher *getInstance();
		void addInstructionTokens(Tokens tokens) throw(GenericException);

		int getInstructionsSize();
		Instruction *getInstruction(int idx);
		void print();
};

#endif
