#include "InstructionsFetcher.h"

InstructionsFetcher* InstructionsFetcher::instance = 0;

InstructionsFetcher::InstructionsFetcher()
{
	instructions.clear();
}

InstructionsFetcher::~InstructionsFetcher()
{
	//clear the instructions:
	for ( Instructions::iterator it=instructions.begin(); it!=instructions.end(); it++ )
	{
		delete (*it);
		instructions.erase(it);
	}
}

InstructionsFetcher *InstructionsFetcher::getInstance()
{
	if ( instance == 0 )
		instance = new InstructionsFetcher();

	return instance;
}

void InstructionsFetcher::addInstructionTokens(Tokens tokens) throw(GenericException)
{
	Instruction *new_instruction = new Instruction();
	new_instruction->setOpcode(tokens[0]); //token 0 is opcode
	//remove token 0 from the vector
	tokens.erase(tokens.begin());

	//collect tokens for operands
	Tokens op;

	//collect first operand till we find a comma
	Tokens::iterator end_token = tokens.end();

	int parenthesis_count = 0;
	for ( Tokens::iterator it=tokens.begin(); it!=tokens.end(); it++ )
	{
		if ( parenthesis_count==0 && (*it)=="," )
		{
			end_token = it;
			break;
		}
		
		if ( (*it) == "(" )
			parenthesis_count++;

		if ( (*it) == ")" )
			parenthesis_count--;

		//push it back into the new Tokens buffer
		op.push_back((*it));
	}

	//remove these tokens from the original buffer
	tokens.erase(tokens.begin(), end_token);

	//if the parenthesis were not nested appropriate
	//we throw a syntax exception
	if ( parenthesis_count != 0 )
		throw GenericException("wrong parenthesis nesting for operand 1", tokens.line_no);
	
	//seems to be a valid operand 1
	//copy the collected tokens to operand1 of our instruction
	op.line_no = tokens.line_no;
	new_instruction->setOp1(op);

	//now we expect a second operand (indicated by comma) or we are at the end (only one operand)
	if ( tokens.size() != 0 )
	{
		if ( tokens[0] != "," )
			//this is an impossible case since we leave the above loop only if EOF or ,
			throw GenericException("wrong operand seperator found", tokens.line_no);

		//we got a second operand we need to parse
		op.clear(); //clear the tokens from op1 since we reuse this object
		tokens.erase(tokens.begin()); //remove the comma from the tokens

		end_token         = tokens.end();
		parenthesis_count = 0;
		for ( Tokens::iterator it=tokens.begin(); it!=tokens.end(); it++ )
		{
			if ( (*it) == "(" )
				parenthesis_count++;
	
			if ( (*it) == ")" )
				parenthesis_count--;
	
			//push it back into the new Tokens buffer
			op.push_back((*it));
		}

		//if the parenthesis were not nested appropriate
		//we throw a syntax exception
		if ( parenthesis_count != 0 )
			throw GenericException("wrong parenthesis nesting for operand 2", tokens.line_no);

		//seems to be a valid operand 2
		//copy the collected tokens to operand2 of our instruction
		op.line_no = tokens.line_no;
		new_instruction->setOp2(op);
	}

	//finally add the instruction to our instruction vector
	instructions.push_back(new_instruction);

}

int InstructionsFetcher::getInstructionsSize()
{
	return instructions.size() + 1;
}

Instruction *InstructionsFetcher::getInstruction(int idx)
{
	return instructions.at(idx);
}

void InstructionsFetcher::print()
{
	for ( int idx=0; idx<getInstructionsSize(); idx++ )
	{
		Instruction *instruction = getInstruction(idx);
		
		cout << idx << " CMD: " << instruction->getOpcode() << endl;

		int cnt = 0;
		for ( Tokens::iterator it=instruction->getOp1().begin(); it!=instruction->getOp1().end(); it++ )
		{
		   	cout << cnt << ") " << *it << endl;
	   	   	cnt++;
		}

		cout << endl;

		cnt = 0;
		for ( Tokens::iterator it=instruction->getOp2().begin(); it!=instruction->getOp2().end(); it++ )
		{
		   	cout << cnt << ") " << *it << endl;
	   	   	cnt++;
		}
	
		cout << endl;
	}
}
