/**
 * This file describes the interface of the parser.
 */


#ifndef PARSER_H
#define PARSER_H



#include "syntaxTreeNode.h"
#include "../scanner/token.h"
#include "../scanner/scanner.h"

#ifndef __HRWCC__
struct parser;
struct symbolTable;
struct codegen;
#endif

#include "../symbolTable/symbolTable.h"



/**Size of look-ahead-buffer for parser*/
#define PARSER_TOKBUFFER_SIZE 4


/**
 * A parser and its properties and members.
 */
struct parser
{
		/**The scanner to get the tokens from*/
		scanner* scan;

		/**The symbol table which is used*/
		symbolTable* symTable;

		/**The code generator which is used*/
		codegen* cg;

		/**Error occured*/
		int cnterrors;

		/** pointer to zero-th element in tokbuffer */
		token* curr;

		/**The look-ahead buffer of tokens (is used as look-ahead-queue)*/
		token tokbuffer[PARSER_TOKBUFFER_SIZE];
};


/**
 * Init the parser 'parser' with the scanner 'scanner'
 */
int parser_init( parser* parser, scanner* scan);

/**
 * Set the symbol table which is used by parser
 */
void parser_setSymbolTable( parser* parser, symbolTable* symTable);

/**
 * Set the code generator of parser
 */
void parser_setCodegen( parser* parser, codegen* cg);

/**
 * Build the syntax tree from the tokens of the scanner
 */
int parser_buildSyntaxTree( parser* parser, syntaxTreeNode* root);





#endif



