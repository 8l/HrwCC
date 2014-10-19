/**
 * This file contains all necessary functions for code generation.
 */

#include "../symbolTable/symbolTable.h"
#include "../parser/parser.h"
#include "../preproc/preproc.h"



#ifndef CODEGEN_H
#define CODEGEN_H



/**
 * The maximum size of a asm-line. (Must be a proper amount bigger than TOKEN_MAX_SIZE!)
 * Attention: Our language does not support things like TOKEN_MAX_SIZE+64 or so!
 */
#define CODEGEN_MAXLINE_SIZE 160



/** 
 * Code generation stuff like FD of output file.
 */
struct codegen
{
		/**Output-file file-descriptor*/
		int fd;

		/**Error and warning counter*/
		int cnterrors;
		int cntwarnings;

		/**Set it for printing debug comments in output*/
		int emitdebug;

		/** Optimize: Use fast variable assignment */
		int enOptFastassign;

		/** The parser which uses this code generator */
		parser* parse;

		/** Amount of if, while, ... block created. */
		int cntBlocks;

		/** Current marker of while loop */
		int currWhileNr;
		/** Current marker of function */
		token currFuncName;
};




/** Initialize code generation structure 
 *	@param fd The file descriptor
 *	@param parser The parser which uses this generator
 * */
void codegen_CreateCodeGen( codegen* cg, int fd, parser* parser);



/*
 * The following functions work all the same way:
 * - They take a syntax-sub-tree and 
 * - Write down gas-assembler code to calculate the wanted information
 * - 'result' contains, how the result is accessed. If the result is just a number
 *   it is maybe $87. If its a local variable, it might be -33(%ebp). In this cases
 *   no code generation is necessary.
 *   If the result is not that easy built, code must be really generated an the result
 *   might be %eax which means, that the result is accessed via %eax. Like adding
 *   two local variables or so.
 *
 *  return value is -1 if an error occured
 */

int codegen_EmitProgrammStart( codegen* cg);
int codegen_EmitSymboltable( codegen* cg);

int codegen_EmitBeginFunction( codegen* cg);
int codegen_EmitEndFunction( codegen* cg);

int codegen_EmitBeginIf( codegen* cg, syntaxTreeNode* tree, int* blocknr );
int codegen_EmitElseIf( codegen* cg, syntaxTreeNode* tree, int blocknr);
int codegen_EmitEndIf( codegen* cg, syntaxTreeNode* tree, int blocknr);

int codegen_EmitBeginWhile( codegen* cg, syntaxTreeNode* tree, int* blocknr );
int codegen_EmitEndWhile( codegen* cg, syntaxTreeNode* tree, int blocknr);

int codegen_EmitBreak( codegen* cg, syntaxTreeNode* tree );
int codegen_EmitContinue( codegen* cg, syntaxTreeNode* tree );
int codegen_EmitReturn( codegen* cg, syntaxTreeNode* tree );

/**Here result is the empty string if void is return type*/
int codegen_EmitFuncCallExpr( codegen* cg, syntaxTreeNode* tree, char* result);
int codegen_EmitAssign( codegen* cg, syntaxTreeNode* tree);

int codegen_EmitSizeofExpr(codegen* cg, syntaxTreeNode* tree, char* result);
int codegen_EmitNumber(codegen* cg, syntaxTreeNode* tree, char* result);






#endif




