#include "Instruction.h"

Instruction::Instruction()
{
	opcode = "";
	op1.clear();
	op2.clear();
}

Instruction::~Instruction()
{
}

void Instruction::setOpcode(string opcode)
{
	this->opcode = opcode;
}

string Instruction::getOpcode()
{
	return opcode;
}

void Instruction::setOp1(Tokens op)
{
	this->op1 = op;
}

Tokens Instruction::getOp1()
{
	return op1;
}

void Instruction::setOp2(Tokens op)
{
	this->op2 = op;
}

Tokens Instruction::getOp2()
{
	return op2;
}
