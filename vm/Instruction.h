#ifndef INSTRUCTION_H
#define INSTRUCTION_H

	#include <string>
	#include <vector>

	using namespace std;

	/**
	 * yeah, not the nicest solution but very convenient
	 */
	class Tokens : public vector<string>
	{
		//this is basically just a vector
		//extended with some meta-information about our code
		public:
			int line_no;
	};

	/**
	 * an instruction object represents an actual instruction
	 * that will be executed by the CPU
	 * operand 1 and (possibly) operand 2 are just tokens
	 * that have to be resolved during executing (different addressing modes etc.)
	 */
	class Instruction
	{
		private:
			string opcode;
			Tokens op1;
			Tokens op2;

		public:
			Instruction();
			~Instruction();
			void setOpcode(string opcode);
			string getOpcode();
			void setOp1(Tokens op);
			Tokens getOp1();
			void setOp2(Tokens op);
			Tokens getOp2();
	};

#endif
