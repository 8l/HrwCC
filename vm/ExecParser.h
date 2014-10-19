#ifndef EXEC_PARSER_H
#define EXEC_PARSER_H

#include <iostream>
#include <vector>
#include <string>
#include <fstream>
#include "Memory.h"
#include "InstructionsFetcher.h"
#include "Instruction.h"
#include "GenericException.h"

using namespace std;

class ExecParser
{
	private:
		ifstream &input;
		Memory *memory;
	protected:
		void parseTokens(string line, Tokens &tokens);
		int getDataSize(Tokens &tokens);

	public:
		ExecParser(ifstream &_input, Memory *_memory);
		~ExecParser();
		void parse() throw(GenericException);
		static void replaceEscapeChrs(string &str);
};

#endif
