/**
 * The parser implementation.
 */


#include "parser.h"

#include "../include/hrwcccomp.h"

#include "syntaxTreeNode.h"
#include "../scanner/scanner.h"
#include "../codegen/codegen.h"


//#define DEBUG_PARSER_SYMTABLE
//#define DEBUG_PARSER_TRACE



int parse_logExpr( parser* parser, syntaxTreeNode* root);
int parse_arithExpr( parser* parser, syntaxTreeNode* root);
int parse_statement( parser* parser, syntaxTreeNode* root);


/** Report the error */
void report_error(parser* parser, char* errstr)
{
		char* filename;

		//Error occured
		parser->cnterrors = parser->cnterrors + 1;

		//Error in scanner...
		if( parser->curr->type < 0 )
			return;


		//Get filename
		filename = preproc_getFilename( parser->scan->pp, parser->curr->pos_fileid);

		//Print the error messages
		printf("PARSER_ERROR: %d, ", parser->curr->pos_col);
		printf("%d, ", parser->curr->pos_line);
		
		if( filename )
			printf("%s:\n", filename);
		else
			printf("[ERR filename] (%p)\n", filename);

		printf("\tToken is '%s' ::   ", parser->curr->content);
		printf("%s\n", errstr);
}


/** Print calling stack of parsing */
void parse_tracemsg(parser* parser, char* msg)
{
		token* tok;
		tok = &parser->tokbuffer[0];


#ifdef DEBUG_PARSER_TRACE
		printf("%s", msg);
		printf(": token %d", tok->type);
		printf(": %s\n", tok->content);
#endif

}


/**
 * Shift the shift register to left side and read new token from scanner.
 */
void eatToken( parser* parser )
{
		int idx;
		idx = 0;

		//Move all tokens to lower position
		while( idx < PARSER_TOKBUFFER_SIZE-1 )
		{
				//Maybe use memcpy here? - This would avoid structure copying
				parser->tokbuffer[idx] = parser->tokbuffer[idx+1];
				idx = idx+1;
		}

		//Get next token from scanner
		scanner_getToken( parser->scan, &parser->tokbuffer[PARSER_TOKBUFFER_SIZE-1] );
}


/**
 * Add a token as  tree-node-child and eat it from scanner
 */
void addAndEatToken( parser* parser, syntaxTreeNode* root)
{
		parse_tracemsg( parser, "ADD AND EAT");

		//Add this token to root
		syntax_AddChildNode( root, parser->tokbuffer[0] );
		eatToken( parser );
}


/**
 * Add and eat a specific token. Print errstr if not there.
 */
int addAndEatSpecificToken( parser* parser, syntaxTreeNode* root, int toktype, char* errstr)
{

		//If this token is not there, print error and return error
		if( parser->curr->type != toktype)
		{
				report_error(parser, errstr);
				return -1;
		}

		//Otherwise eat the token and return successful
		addAndEatToken( parser, root);
		
		return 0;
}






/*
 *
 * Here in the following you can find the production functions which are used for
 * recursive decent parsing.
 *
 */




/** After error, find a symbol where we can parse further on. */
void sync_toStrongKeyword(parser* parser)
{
		parse_tracemsg( parser, "sync_toStrongKeyword");

		eatToken(parser);

		//As long as there are no strong symbols
		while( parser->curr->type != TOK_EOF &&
				parser->curr->type != TOK_CURPAR_END &&
				parser->curr->type != TOK_INT &&
				parser->curr->type != TOK_CHAR &&
				parser->curr->type != TOK_VOID &&
				parser->curr->type != TOK_IF &&
				parser->curr->type != TOK_WHILE &&
				parser->curr->type != TOK_RETURN &&
				parser->curr->type != TOK_STRUCT )
		{
				eatToken(parser);
		}


		parse_tracemsg( parser, "synced");		
}


/** <data_type> ::= ( "int" | "char" | "void" | <ident>) {"*"} */
int parse_dataType( parser* parser, syntaxTreeNode* root)
{
		parse_tracemsg( parser, "parse_dataType");

		if( parser->curr->type == TOK_INT ||
			parser->curr->type == TOK_CHAR ||
			parser->curr->type == TOK_VOID ||
			parser->curr->type == TOK_IDENT )
		{
				addAndEatToken( parser, root );

				while( parser->curr->type == TOK_STAR )
					addAndEatToken( parser, root );

				return 0;
		}

		report_error(parser, "Expected data type here.");
		return -1;
}


/** <sizeof_expr> ::= "sizeof" "(" <data_type> ")" */
int parse_sizeofExpr( parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* dataType;

		parse_tracemsg( parser, "parse_sizeofExpr");


		if( addAndEatSpecificToken( parser, root, 
			TOK_SIZEOF, "Expected 'sizeof' token here.") != 0)
				return -1;

		if( addAndEatSpecificToken( parser, root, 
			TOK_RNDPAR_BEGIN, "Expected '(' token after sizeof.") != 0)
				return -1;

			
		dataType = syntax_CreateTreeNode();
		syntax_AddChildTree(root, dataType);

		if( parse_dataType( parser, dataType ) != 0 )
				return -1;

		if( addAndEatSpecificToken( parser, root, 
			TOK_RNDPAR_END, "Missing ')' token.") != 0)
				return -1;
		

		return 0;
}


/** <typed_ident> ::= <data_type> <ident> */
int parse_typedIdent( parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* dataType;


		parse_tracemsg( parser, "parse_typedIdent");

		dataType = syntax_CreateTreeNode();
		syntax_AddChildTree(root, dataType);
	
		if( parse_dataType( parser, dataType ) != 0 )
				return -1;

		if( addAndEatSpecificToken( parser, root, 
			TOK_IDENT, "Missing identifier.") != 0)
				return -1;

		return 0;
}

/** <func_call> ::= <ident> "(" [ <log_expr> {"," <log_expr> } ] ")" */
int parse_funcCall( parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* logExpr;


		parse_tracemsg( parser, "parse_funcCall");

		if( addAndEatSpecificToken( parser, root, 
			TOK_IDENT, "Expected identifier of function here.") != 0)
				return -1;

		if( addAndEatSpecificToken( parser, root, 
			TOK_RNDPAR_BEGIN, "Expected '(' after function-identifier.") != 0)
				return -1;


		//Is this the end of of argument list?
		if( parser->curr->type == TOK_RNDPAR_END)
		{
				//Eat the ')' and return
				addAndEatToken( parser, root);
				return 0;
		}

		//Otherwise, get the logical expression
		logExpr = syntax_CreateTreeNode();
		syntax_AddChildTree( root, logExpr );

		//Get first logical expression
		if( parse_logExpr( parser, logExpr ) != 0)
				return -1;

		//Here, the question is: what binds tighter: The ',' or the ')'
		//I think, that a ',' is less often forgotten than a ')', in
		//particular because of nested log_expr expressions.
		
		while( parser->curr->type == TOK_KOMMA )
		{
				//Eat the komma and scan for further log expressions
				addAndEatToken( parser, root );


				//Create new subtree for logical expression
				logExpr = syntax_CreateTreeNode();
				syntax_AddChildTree( root, logExpr );

				//Get first logical expression
				if( parse_logExpr( parser, logExpr ) != 0)
						return -1;
		}


		if( addAndEatSpecificToken( parser, root, 
			TOK_RNDPAR_END, "Missing ')' after function call.") != 0)
				return -1;

		return 0;
}


/** <variable_expr> ::= ["*" | "&"] <ident> { ("->" | ".") <ident> } ["[" <log_expr>  "]"] */
int parse_variableExpr( parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* logExpr;


		parse_tracemsg( parser, "parse_variableExpr");


		//Scan the alternative "*" or "&"
		if( parser->curr->type == TOK_STAR )
				addAndEatToken( parser, root );

		//Scan the alternative "*" or "&"
		else if( parser->curr->type == TOK_AND )
				addAndEatToken( parser, root );

		

		if( addAndEatSpecificToken( parser, root, 
			TOK_IDENT, "Expected identifier of variable here.") != 0)
				return -1;


		//As long as there are arrows or points...
		while( parser->curr->type == TOK_ARROW ||
				parser->curr->type == TOK_POINT )
		{
				//Eat them
				addAndEatToken( parser, root);

				//And get the ident as selector
				if( addAndEatSpecificToken( parser, root, 
					TOK_IDENT, "Expected identifier of variable as selector here.") != 0)
						return -1;
		}
		

		//Ok, we get an array-selection too
		if( parser->curr->type == TOK_RECPAR_BEGIN )
		{
				//Eat the beginning
				addAndEatToken( parser, root );

				//Create a log-expr subtree and at it
				logExpr = syntax_CreateTreeNode();
				syntax_AddChildTree(root, logExpr);


				//Get first logical expression
				if( parse_logExpr( parser, logExpr ) != 0)
						return -1;


				//And end of array selection
				if( addAndEatSpecificToken( parser, root, 
					TOK_RECPAR_END, "Missing ']' token to terminate array selection.") != 0)
						return -1;
		}

		return 0;
}


/** 
 * <atomic_val_expr> ::= <variable_expr> | <string> | <number> | <singlechar> |
 * 						<func_call> | <sizeof_expr>  
 */
int parse_atomicValExpr( parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* subtree;
		int idx;
		token* next;
		
		parse_tracemsg( parser, "parse_atomicValExpr");
		next = &parser->tokbuffer[1];


		//Strings are put into symboltable too
		if( parser->curr->type == TOK_STRING )
		{
				//This is the index of the new eaten
				idx = syntax_CountChilds( root );
				addAndEatToken( parser, root);

				//Clean-up symbol-table
				if( parser->symTable)
						symbol_DefineString( parser->symTable, syntax_GetChild(root,idx) );

				return 0;
		}

		if(	parser->curr->type == TOK_NUMBER ||
			parser->curr->type == TOK_SINGLECHAR )
		{
				addAndEatToken( parser, root );
				return 0;
		}


		//Ok, we have to parse deeper -- create the subtree and at it
		subtree = syntax_CreateTreeNode();
		syntax_AddChildTree( root, subtree);

		
		if( parser->curr->type == TOK_SIZEOF )
				return parse_sizeofExpr( parser, subtree );


		//We need LL(2) here
		if( parser->curr->type == TOK_IDENT &&
			next->type == TOK_RNDPAR_BEGIN )
				return parse_funcCall( parser, subtree );


		//The last possibility is the variable expression

		return parse_variableExpr( parser, subtree );
}


/** <arith_factor> ::= ["~"] <atomic_val_expr> | "(" <arith_expr> ")" */
int parse_arithFactor( parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* subtree;


		parse_tracemsg( parser, "parse_arithFactor");


		//The nested alternative
		if( parser->curr->type == TOK_RNDPAR_BEGIN )
		{
				addAndEatToken( parser, root );
	
				//Add the subtree
				subtree = syntax_CreateTreeNode();
				syntax_AddChildTree( root, subtree );	

				if( parse_logExpr( parser, subtree ) != 0)
						return -1;

				if( addAndEatSpecificToken( parser, root, 
					TOK_RNDPAR_END, "Missing ')' token to terminate nested arithmetic expression.") != 0)
						return -1;

				return 0;
		}


		//Otherwise the atomic value
		
		if( parser->curr->type == TOK_SNAKE )
				addAndEatToken( parser, root );


		//Add the subtree
		subtree = syntax_CreateTreeNode();
		syntax_AddChildTree( root, subtree );

		if( parse_atomicValExpr( parser, subtree ) != 0)
				return -1;

		return 0;
}


/** <arith_term> ::= <arith_factor> { ("&" | "^" | "*" | "/" | "%" ) <arith_factor> } */
int parse_arithTerm( parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* subtree;

		
		parse_tracemsg( parser, "parse_arithTerm");

		subtree = syntax_CreateTreeNode();
		syntax_AddChildTree( root, subtree );
	
		if( parse_arithFactor( parser, subtree ) != 0)
				return -1;


		//Repeat until no other factor succeeds
		while( parser->curr->type == TOK_AND ||
			parser->curr->type == TOK_HAT ||
			parser->curr->type == TOK_STAR ||
			parser->curr->type == TOK_DIV ||
			parser->curr->type == TOK_PERCENT )
		{
				//Eat operator
				addAndEatToken( parser, root );

				//Further factor
				subtree = syntax_CreateTreeNode();
				syntax_AddChildTree( root, subtree );
	
				if( parse_arithFactor( parser, subtree ) != 0)
						return -1;

		}

		return 0;
}


/** <arith_expr> ::= ["-"] <arith_term> { ("+", "-", "|") <arith_term> }  */
int parse_arithExpr( parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* subtree;


		parse_tracemsg( parser, "parse_arithExpr");


		if( parser->curr->type == TOK_MINUS )
			addAndEatToken( parser, root );


		subtree = syntax_CreateTreeNode();
		syntax_AddChildTree( root, subtree );
	
		if( parse_arithTerm( parser, subtree ) != 0)
				return -1;


		//Repeat until no other factor succeeds
		while( parser->curr->type == TOK_PLUS ||
			parser->curr->type == TOK_MINUS ||
			parser->curr->type == TOK_PIPE )
		{
				//Eat operator
				addAndEatToken( parser, root );

				//Further factor
				subtree = syntax_CreateTreeNode();
				syntax_AddChildTree( root, subtree );
	
				if( parse_arithTerm( parser, subtree ) != 0)
						return -1;

		}

		return 0;
}


/** <rel_expr> ::= <arith_expr> [ ("==", "!=", "<", "<=", ">", ">=") <arith_expr> ] */
int parse_relExpr( parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* subtree;


		parse_tracemsg( parser, "parse_relExpr");


		subtree = syntax_CreateTreeNode();
		syntax_AddChildTree( root, subtree );
	
		if( parse_arithExpr( parser, subtree ) != 0)
				return -1;


		if( parser->curr->type == TOK_DBLEQUAL ||
			parser->curr->type == TOK_NOTEQUAL ||
			parser->curr->type == TOK_LESS ||
			parser->curr->type == TOK_LESSEQUAL ||
			parser->curr->type == TOK_MORE ||
			parser->curr->type == TOK_MOREEQUAL )
		{
				//Eat operator
				addAndEatToken( parser, root );

				//Further factor
				subtree = syntax_CreateTreeNode();
				syntax_AddChildTree( root, subtree );
	
				if( parse_arithExpr( parser, subtree ) != 0)
						return -1;
		}

		return 0;
}


/** <log_factor> ::= ["!"] <rel_expr> | "(" <log_expr> ")" */
int parse_logFactor( parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* subtree;

	
		parse_tracemsg( parser, "parse_logFactor");
		
		if( parser->curr->type == TOK_CALLSIGN )
				addAndEatToken( parser, root );


		//Add the subtree
		subtree = syntax_CreateTreeNode();
		syntax_AddChildTree( root, subtree );

		if( parse_relExpr( parser, subtree ) != 0)
				return -1;

		return 0;
}


/** <log_term> ::= <log_factor> { "&&" <log_factor> } */
int parse_logTerm( parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* subtree;


		parse_tracemsg( parser, "parse_logTerm");

		subtree = syntax_CreateTreeNode();
		syntax_AddChildTree( root, subtree );
	
		if( parse_logFactor( parser, subtree ) != 0)
				return -1;


		//Repeat until no other factor succeeds
		while( parser->curr->type == TOK_DBLAND )
		{
				//Eat operator
				addAndEatToken( parser, root );

				//Further factor
				subtree = syntax_CreateTreeNode();
				syntax_AddChildTree( root, subtree );
	
				if( parse_logFactor( parser, subtree ) != 0)
						return -1;

		}

		return 0;
}


/** <log_expr> ::= <log_term> { "||" <log_term> } */
int parse_logExpr( parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* subtree;


		parse_tracemsg( parser, "parse_logExpr");

		subtree = syntax_CreateTreeNode();
		syntax_AddChildTree( root, subtree );
	
		if( parse_logTerm( parser, subtree ) != 0)
				return -1;


		while( parser->curr->type == TOK_DBLPIPE )
		{
				//Eat operator
				addAndEatToken( parser, root );

				//Further factor
				subtree = syntax_CreateTreeNode();
				syntax_AddChildTree( root, subtree );
	
				if( parse_logTerm( parser, subtree ) != 0)
						return -1;
		}

		return 0;
}


/** <continue_stmt> ::= "continue" ";" */
int parse_continueStmt( parser* parser, syntaxTreeNode* root)
{
		parse_tracemsg( parser, "parse_continueStmt");


		if( addAndEatSpecificToken( parser, root, 
			TOK_CONTINUE, "Missing 'continue' token.") != 0)
				return -1;


		//Emit the continue
		if( parser->cg )
			codegen_EmitContinue( parser->cg, root );


		//Do not care about missing semicolon
		if( addAndEatSpecificToken( parser, root, 
			TOK_SEMIKOLON, "Missing semikolon after continue.") != 0)
				return 0;

		return 0;
}



/** <break_stmt> ::= "break" ";" */
int parse_breakStmt( parser* parser, syntaxTreeNode* root)
{
		parse_tracemsg( parser, "parse_breakStmt");


		if( addAndEatSpecificToken( parser, root, 
			TOK_BREAK, "Missing 'break' token.") != 0)
				return -1;


		//Emit the break
		if( parser->cg )
			codegen_EmitBreak( parser->cg, root );


		//Do not care about missing semicolon
		if( addAndEatSpecificToken( parser, root, 
			TOK_SEMIKOLON, "Missing semikolon after break.") != 0)
				return 0;

		return 0;
}


/** <return_stmt> ::= "return" [<log_expr>] ";" */
int parse_returnStmt( parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* subtree;

		parse_tracemsg( parser, "parse_returnStmt");


		if( addAndEatSpecificToken( parser, root, 
			TOK_RETURN, "Missing 'return' token.") != 0)
				return -1;


		if( parser->curr->type != TOK_SEMIKOLON )
		{
				subtree = syntax_CreateTreeNode();
				syntax_AddChildTree( root, subtree );

				if( parse_logExpr( parser, subtree ) != 0)
					return -1;
		}


		//Do not care about missing semicolon
		if( addAndEatSpecificToken( parser, root, 
			TOK_SEMIKOLON, "Missing semikolon in return statement.") != 0)
				return 0;


		//Emit the return
		if( parser->cg )
			codegen_EmitReturn( parser->cg, root );

		return 0;
}


/** <stmt_block> ::= "{" {<statement>} "}" | <statement> */
int parse_stmtBlock( parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* subtree;

		parse_tracemsg( parser, "parse_stmtBlock");


		if( parser->curr->type == TOK_CURPAR_BEGIN )
		{
				//eat {
				addAndEatToken(parser, root);
			
				//Parse statements
				while( parser->curr->type != TOK_CURPAR_END)
				{
						subtree = syntax_CreateTreeNode();
						syntax_AddChildTree( root, subtree );

						//Error occured --> sync to strong keyword
						if( parse_statement( parser, subtree ) != 0)
						{
							sync_toStrongKeyword(parser);

							//If can not be handled by us --> skip
							if( parser->curr->type != TOK_CURPAR_END &&
								parser->curr->type != TOK_IF &&
								parser->curr->type != TOK_WHILE &&
								parser->curr->type != TOK_RETURN )
							{
									return -1;
							}
						}
				}

				//eat }
				if( addAndEatSpecificToken( parser, root, 
					TOK_CURPAR_END, "Missing '}' for terminating statement block.") != 0)
						return -1;

				return 0;
		}

		subtree = syntax_CreateTreeNode();
		syntax_AddChildTree( root, subtree );

		return parse_statement( parser, subtree );
}


/** <while_stmt> ::= "while" "(" <log_expr> ")" <stmt_block> */
int parse_whileStmt( parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* subtree;
		int cg_blnr;
		int cg_oldwhilenr;

		parse_tracemsg( parser, "parse_whileStmt");


		if( addAndEatSpecificToken( parser, root, 
			TOK_WHILE, "Missing 'while' token.") != 0)
				return -1;

		if( addAndEatSpecificToken( parser, root, 
			TOK_RNDPAR_BEGIN, "Missing '(' token after while.") != 0)
				return -1;

		subtree = syntax_CreateTreeNode();
		syntax_AddChildTree( root, subtree );


		if( parse_logExpr( parser, subtree ) != 0)
				return -1;

		if( addAndEatSpecificToken( parser, root, 
			TOK_RNDPAR_END, "Expected ')' token after while-condition.") != 0)
				return -1;


		//Print code about while
		if( parser->cg )
		{
			cg_oldwhilenr = parser->cg->currWhileNr;
			codegen_EmitBeginWhile( parser->cg, root, &cg_blnr );
			parser->cg->currWhileNr = cg_blnr;
		}


		subtree = syntax_CreateTreeNode();
		syntax_AddChildTree( root, subtree );


		if( parse_stmtBlock( parser, subtree ) != 0)
				return -1;


		//Print code of endif
		if( parser->cg )
		{
			parser->cg->currWhileNr = cg_oldwhilenr;
			codegen_EmitEndWhile( parser->cg, root, cg_blnr);
		}

		return 0;
}



/** <if_stmt> ::= "if" "(" <log_expr> ")" <stmt_block> "else" <stmt_block> */
int parse_ifStmt( parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* subtree;
		int cg_blnr;

		parse_tracemsg( parser, "parse_ifStmt");


		if( addAndEatSpecificToken( parser, root, 
			TOK_IF, "Missing 'if' token.") != 0)
				return -1;

		if( addAndEatSpecificToken( parser, root, 
			TOK_RNDPAR_BEGIN, "Missing '(' token after if.") != 0)
				return -1;

		subtree = syntax_CreateTreeNode();
		syntax_AddChildTree( root, subtree );


		if( parse_logExpr( parser, subtree ) != 0)
				return -1;

		if( addAndEatSpecificToken( parser, root, 
			TOK_RNDPAR_END, "Expected ')' token after if-condition.") != 0)
				return -1;


		//Print code about if
		if( parser->cg )
			codegen_EmitBeginIf( parser->cg, root, &cg_blnr );


		subtree = syntax_CreateTreeNode();
		syntax_AddChildTree( root, subtree );

		if( parse_stmtBlock( parser, subtree ) != 0)
				return -1;


		//Print code of else
		if( parser->cg )
			codegen_EmitElseIf( parser->cg, root, cg_blnr);
	

		//Optional else branch
		if( parser->curr->type == TOK_ELSE )
		{
				addAndEatToken(parser, root);

				subtree = syntax_CreateTreeNode();
				syntax_AddChildTree( root, subtree );

				if( parse_stmtBlock( parser, subtree ) != 0)
						return -1;
		}

		//Print code of endif
		if( parser->cg )
			codegen_EmitEndIf( parser->cg, root, cg_blnr);


		return 0;
}


/** <assign_stmt> ::= <variable_expr> "=" <log_expr> ";" */ 
int parse_assignStmt( parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* subtree;

		parse_tracemsg( parser, "parse_assignStmt");


		subtree = syntax_CreateTreeNode();
		syntax_AddChildTree( root, subtree );

		if( parse_variableExpr( parser, subtree ) != 0)
				return -1;


		if( addAndEatSpecificToken( parser, root, 
			TOK_EQUAL, "Missing '=' token after variable-expression of assignment.") != 0)
				return -1;

		
		subtree = syntax_CreateTreeNode();
		syntax_AddChildTree( root, subtree );

		if( parse_logExpr( parser, subtree ) != 0)
				return -1;

		//Do not care about missing semicolon
		if( addAndEatSpecificToken( parser, root, 
			TOK_SEMIKOLON, "Expected ';' token after assignment.") != 0)
				return 0;

		return 0;
}


/** <func_call_stmt> ::= <func_call> ";" */ 
int parse_funcCallStmt( parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* subtree;
		char resbuf[CODEGEN_MAXLINE_SIZE];

		parse_tracemsg( parser, "parse_funcCallStmt");

		
		subtree = syntax_CreateTreeNode();
		syntax_AddChildTree( root, subtree );

		if( parse_funcCall( parser, subtree ) != 0)
				return -1;

		//Do not care about missing semicolon
		if( addAndEatSpecificToken( parser, root, 
			TOK_SEMIKOLON, "Expected ';' token after function call.") != 0)
				return 0;


		//Emit code for function call
		if( parser->cg )
				codegen_EmitFuncCallExpr( parser->cg, subtree, resbuf);

		return 0;
}



/** <statement> ::= <assign_stmt> | <func_call_stmt> | <if_stmt> |
						<while_stmt> | <return_stmt> | <break_stmt> | <continue_stmt> */
int parse_statement( parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* subtree;
		int ret;
		token* next;

		parse_tracemsg( parser, "parse_statement");

		next = &parser->tokbuffer[1];
		subtree = syntax_CreateTreeNode();
		syntax_AddChildTree( root, subtree );


		//No variable declaration allowed here
		if( parser->curr->type == TOK_INT ||
			parser->curr->type == TOK_CHAR ||
			parser->curr->type == TOK_VOID )
		{
				report_error(parser, "No variable declaration allowed after statements.");
				return -1;
		}

		//No statement here
		if( parser->curr->type == TOK_EOF ||
			parser->curr->type == TOK_STRUCT )
		{
				report_error(parser, "Expected a statement here.");
				return -1;
		}

		//No statement here
		if( parser->curr->type == TOK_SEMIKOLON )
		{
				report_error(parser, "Do not expected semikolon here.");
				eatToken(parser);
				return 0;
		}

		//A else without if
		if( parser->curr->type == TOK_ELSE )
		{
				report_error(parser, "Else detected without if.");
				return -1;
		}


		if( parser->curr->type == TOK_IF )
				return parse_ifStmt( parser, subtree);

		if( parser->curr->type == TOK_WHILE )
				return parse_whileStmt( parser, subtree);

		if( parser->curr->type == TOK_RETURN )
				return parse_returnStmt( parser, subtree);

		if( parser->curr->type == TOK_BREAK )
				return parse_breakStmt( parser, subtree);

		if( parser->curr->type == TOK_CONTINUE )
				return parse_continueStmt( parser, subtree);

		//This is a point where our language is at least in LL(2)
		if( parser->curr->type == TOK_IDENT &&
			next->type == TOK_RNDPAR_BEGIN )
				return parse_funcCallStmt( parser, subtree);


		//Last possibility: assignment
		ret = parse_assignStmt(parser, subtree);

		//Emit assignment
		if( ret>=0 && parser->cg )
			codegen_EmitAssign(parser->cg, subtree);

		return ret;
}


/** <var_decl> ::= <typed_ident> [ "[" <number> "]" ] ";"
 *
 * ATTENTION: Its important, that variable declarations are of the same form than variable
 * declarations in function bodies or structs (parse_varDecl)
 */
int parse_varDecl( parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* subtree;
		token tok;

		parse_tracemsg( parser, "parse_varDecl");


		subtree = syntax_CreateTreeNode();
		syntax_AddChildTree( root, subtree );

		if( parse_typedIdent( parser, subtree ) != 0)
				return -1;


		//Array spec
		if( parser->curr->type == TOK_RECPAR_BEGIN )
		{
				addAndEatToken( parser, root);

				if( addAndEatSpecificToken( parser, root, 
					TOK_NUMBER, "Expected number token in array size specifier.") != 0)
						return -1;

				if( addAndEatSpecificToken( parser, root, 
					TOK_RECPAR_END, "Missing ']' token terminating array size specifier.") != 0)
						return -1;
		}


		if( addAndEatSpecificToken( parser, root, 
			TOK_SEMIKOLON, "Expected semicolon token after variable declaration.") != 0)
		{
				//Dummy add semicolon 
				strcpy( tok.content, ";");
				tok.type = TOK_SEMIKOLON;
					
				syntax_AddChildNode( root, tok );
		}

		return 0;
}



/** <func_body> ::= "{" {<var_decl} {<statement>} "}" */
int parse_funcBody( parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* subtree;
		token* next;


		next = &parser->tokbuffer[1];

		parse_tracemsg( parser, "parse_funcBody");

		if( addAndEatSpecificToken( parser, root, 
			TOK_CURPAR_BEGIN, "Missing '{' to init function body.") != 0)
				return -1;


		//Test how long we will parse variable declarations...
		//COMMENT:
		//   variable declarations begin with a type followed by an ident
		//   and statements do not.
		//   - if we have int, char or void, the situation is clear
		//   - if we have an ident this could only be a assignment or function-call
		//     statement. But in both cases there can't be an star or an ident
		//     at the next position. Reverse: In an variable declaration an ident
		//     can only be followed by an star and and ident.
		//
		//This is another point where our language is in LL(2)
		while( parser->curr->type == TOK_INT ||
				parser->curr->type == TOK_CHAR ||
				parser->curr->type == TOK_VOID ||
				(parser->curr->type == TOK_IDENT &&
				 (next->type == TOK_STAR ||
				 next->type == TOK_IDENT )) )
		{
				subtree = syntax_CreateTreeNode();
				syntax_AddChildTree( root, subtree );

				//Error occured --> find sync symbol
				if( parse_varDecl( parser, subtree ) != 0)
				{
					sync_toStrongKeyword(parser);

					//If can not be handled by us --> skip
					if( parser->curr->type != TOK_CURPAR_END &&
						parser->curr->type != TOK_INT &&
						parser->curr->type != TOK_CHAR &&
						parser->curr->type != TOK_VOID &&
						parser->curr->type != TOK_IF &&
						parser->curr->type != TOK_WHILE &&
						parser->curr->type != TOK_RETURN )
					{
							return -1;
					}
				}
				//No error occured
				else
				{
						//If symtable exists, define the local variable
						//If error occures, do not parse further on...
						if( parser->symTable )
							symbol_DefineLocalVariable( parser->symTable, subtree);
				}
		}


#ifdef DEBUG_PARSER_SYMTABLE
		//Maybe some debug?
		if( parser->symTable )
		{
				printf("Current symbol table:\n");
				symbol_printTable( parser->symTable );
		}
#endif

		//Generate code for function definition
		if( parser->cg )		
				codegen_EmitBeginFunction( parser->cg);



		//Rest of statements
		while( parser->curr->type != TOK_CURPAR_END )
		{
				subtree = syntax_CreateTreeNode();
				syntax_AddChildTree( root, subtree );

				//Error occured --> find sync symbol
				if( parse_statement( parser, subtree ) != 0)
				{
					sync_toStrongKeyword(parser);

					//If can not be handled by us --> skip
					if( parser->curr->type != TOK_CURPAR_END &&
						parser->curr->type != TOK_INT &&
						parser->curr->type != TOK_CHAR &&
						parser->curr->type != TOK_VOID &&
						parser->curr->type != TOK_IF &&
						parser->curr->type != TOK_WHILE &&
						parser->curr->type != TOK_RETURN )
					{
							return -1;
					}
				}
		}


		//Ead '{'.
		addAndEatToken(parser, root);

		//Generate code for function definition
		if( parser->cg )
				codegen_EmitEndFunction( parser->cg);


		return 0;
}



/** <arg_list_def> ::= "(" [ <typed_ident>  { "," <typed_ident> } ] ")"  */
int parse_argListDef( parser* parser, syntaxTreeNode* root )
{
		syntaxTreeNode* subtree;
		syntaxTreeNode* arg;

		parse_tracemsg( parser, "parse_argListDef");


		if( addAndEatSpecificToken( parser, root, 
			TOK_RNDPAR_BEGIN, "Missing '(' to init argument list definition.") != 0)
				return -1;


		if( parser->curr->type != TOK_RNDPAR_END)
		{
				//<arg_def>
				arg = syntax_CreateTreeNode();
				syntax_AddChildTree( root, arg );
				//<typed_ident>
				subtree = syntax_CreateTreeNode();
				syntax_AddChildTree( arg, subtree );

				if( parse_typedIdent( parser, subtree ) != 0)
					return -1;


				while( parser->curr->type == TOK_KOMMA )
				{
						addAndEatToken( parser, root);

						//<arg_def>
						arg = syntax_CreateTreeNode();
						syntax_AddChildTree( root, arg );
						//<typed_ident>
						subtree = syntax_CreateTreeNode();
						syntax_AddChildTree( arg, subtree );

						if( parse_typedIdent( parser, subtree ) != 0)
							return -1;

				}
		}


		if( addAndEatSpecificToken( parser, root, 
			TOK_RNDPAR_END, "Missing ')' to init argument list definition.") != 0)
				return -1;

		return 0;
}


/** <varfunc_defdec> ::= <typed_ident>  ( [ "[" <number> "]" ] ";" | <arg_list_def> ( ";" | <func_body> )) 
 *
 * ATTENTION: Its important, that variable declarations are of the same form than variable
 * declarations in function bodies or structs (parse_varDecl)
 * */
int parse_varfuncDefdec (parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* subtree;
		syntaxTreeNode* nametree;
		token tok;
		token name;

		parse_tracemsg( parser, "parse_varfuncDefdec");


		subtree = syntax_CreateTreeNode();
		syntax_AddChildTree( root, subtree );

		if( parse_typedIdent( parser, subtree ) != 0)
			return -1;

		//Get name token
		nametree = syntax_GetChild(root,0);
		nametree = syntax_GetChild(nametree, 1);
		name = nametree->tok;


		if( parser->curr->type == TOK_SEMIKOLON )
		{
				addAndEatToken( parser, root );

				//Define global variable
				if( parser->symTable )
					symbol_DefineGlobalVariable( parser->symTable, root );
		}


		//Array specification found
		else if( parser->curr->type == TOK_RECPAR_BEGIN )
		{
				addAndEatToken( parser, root);

				if( addAndEatSpecificToken( parser, root,
					TOK_NUMBER, "Missing number in array specification.") != 0)
						return -1;

				if( addAndEatSpecificToken( parser, root,
					TOK_RECPAR_END, "Expected ']' token for terminating array size.") != 0)
						return -1;

				//Do not care for semicolon
				if( addAndEatSpecificToken( parser, root,
					TOK_SEMIKOLON, "Expected semicolon after variable declaration.") != 0)
				{
						//Dummy add semicolon 
						strcpy( tok.content, ";");
						tok.type = TOK_SEMIKOLON;
						
						syntax_AddChildNode( root, tok );
				}

				//Define global variable
				if( parser->symTable )
					symbol_DefineGlobalVariable( parser->symTable, root );
		}

		else
		{
				subtree = syntax_CreateTreeNode();
				syntax_AddChildTree( root, subtree );

				if( parse_argListDef( parser, subtree ) != 0)
					return -1;


				//Semicolon decides, if we choose function declaratin or definition
				if( parser->curr->type == TOK_SEMIKOLON )
				{
						//Take semiclon
						addAndEatToken( parser, root );
												
						//Declare function
						if( parser->symTable )
							symbol_DeclareFunction( parser->symTable, root );

				}
				else
				{
						subtree = syntax_CreateTreeNode();
						syntax_AddChildTree( root, subtree );

						//Define function
						if( parser->symTable )
							symbol_DefineFunction( parser->symTable, root );

#ifdef DEBUG_PARSER_SYMTABLE
						//Maybe some debug?
						if( parser->symTable )
								printf("Enter body of function %s:\n", name.content);
#endif

						//Set function name
						if( parser->cg )
							parser->cg->currFuncName = name;



						//Parser errors occured...
						if( parse_funcBody( parser, subtree ) != 0)
						{
							//Clean-up symbol-table
							if( parser->symTable)
								symbol_ClearNonGlobalVariables( parser->symTable );

							return -1;
						}
						
						//Clean-up symbol-table
						if( parser->symTable)
							symbol_ClearNonGlobalVariables( parser->symTable );
				}
		}

		return 0;
}


/** <struct_def> ::= "struct" <ident> "{" <var_decl> {<var_decl>} "}" ";" */
int parse_structDef( parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* subtree;
		token tok;

		parse_tracemsg( parser, "parse_structDef");


		if( addAndEatSpecificToken( parser, root, 
			TOK_STRUCT, "Missing struct in struct definition.") != 0)
				return -1;

		if( addAndEatSpecificToken( parser, root, 
			TOK_IDENT, "Missing identifier for struct definition.") != 0)
				return -1;

		if( addAndEatSpecificToken( parser, root, 
			TOK_CURPAR_BEGIN, "Missing '{' token for struct body.") != 0)
				return -1;


		subtree = syntax_CreateTreeNode();
		syntax_AddChildTree( root, subtree );

		//I'm not happy with empty structs
		if( parse_varDecl( parser, subtree ) != 0)
		{
			sync_toStrongKeyword(parser);

			if( parser->curr->type != TOK_IDENT &&
				parser->curr->type != TOK_INT &&
				parser->curr->type != TOK_CHAR &&
				parser->curr->type != TOK_VOID &&
				parser->curr->type != TOK_CURPAR_END &&
				parser->curr->type != TOK_EOF
				)
			{
					return -1;
			}
		}


		while( parser->curr->type != TOK_CURPAR_END )
		{
				subtree = syntax_CreateTreeNode();
				syntax_AddChildTree( root, subtree );

				if( parse_varDecl( parser, subtree ) != 0)
				{						
					sync_toStrongKeyword(parser);

					if( parser->curr->type != TOK_IDENT &&
						parser->curr->type != TOK_INT &&
						parser->curr->type != TOK_CHAR &&
						parser->curr->type != TOK_VOID &&
						parser->curr->type != TOK_CURPAR_END &&
						parser->curr->type != TOK_EOF
						)
					{
							return -1;
					}
				}
		}

		if( addAndEatSpecificToken( parser, root, 
			TOK_CURPAR_END, "Missing '}' token for terminating struct body.") != 0)
				return -1;


	

		//Do not care about missing semicolon
		if( addAndEatSpecificToken( parser, root, 
			TOK_SEMIKOLON, "Expected semicolon token after struct body.") != 0)
		{
			//Dummy ad semicolon --> this is need for a correct calculation
			//of struct size!!
			strcpy( tok.content, ";");
			tok.type = TOK_SEMIKOLON;
				
			syntax_AddChildNode( root, tok );
		}


		//If symbol table exists --> add struct
		if( parser->symTable )
				symbol_DefineStruct( parser->symTable, root );

		return 0;
}


/** <program> ::= { <struct_def> | <varfunc_defdec> }  EOF  */
int parse_program( parser* parser, syntaxTreeNode* root)
{
		syntaxTreeNode* subtree;

		parse_tracemsg( parser, "parse_program");


		//Write down kickoff code
		if( parser->cg )
			codegen_EmitProgrammStart( parser->cg);


		//As long as EOF or error does not occur
		while( parser->curr->type > TOK_EOF )
		{
				subtree = syntax_CreateTreeNode();
				syntax_AddChildTree( root, subtree );


				if(parser->curr->type == TOK_STRUCT )
				{
						if( parse_structDef( parser, subtree ) != 0)
						{
								while( parser->curr->type != TOK_STRUCT &&
										parser->curr->type != TOK_IDENT &&
										parser->curr->type != TOK_INT &&
										parser->curr->type != TOK_CHAR &&
										parser->curr->type != TOK_VOID &&
										parser->curr->type != TOK_EOF
									)
								{
										sync_toStrongKeyword(parser);
								}
						}
				}
				else
				{
						if( parse_varfuncDefdec( parser, subtree ) != 0)
						{
								while( parser->curr->type != TOK_STRUCT &&
										parser->curr->type != TOK_IDENT &&
										parser->curr->type != TOK_INT &&
										parser->curr->type != TOK_CHAR &&
										parser->curr->type != TOK_VOID &&
										parser->curr->type != TOK_EOF
									 )
								{
										sync_toStrongKeyword(parser);
								}
						}
				}
		}


		//Finished, yeah!
		addAndEatToken( parser, root);

		//Emit symbol table
		if( parser->cg)
			codegen_EmitSymboltable(parser->cg);

		return 0;
}




/*
 *
 * End of recursive decent parsing functions.
 *
 */




/**
 * Set the symbol table which is used by parser
 */
void parser_setSymbolTable( parser* parser, symbolTable* symTable)
{
		parser->symTable = symTable;
}

/**
 * Set the code generator of parser
 */
void parser_setCodegen( parser* parser, codegen* cg)
{
		parser->cg = cg;
}

/**
 * Init the parser 'parser' with the scanner 'scanner'
 */
int parser_init( parser* parser, scanner* scan)
{
		int idx;

		//Set the scanner of the parser
		parser->scan = scan;
		parser->cnterrors = 0;
		parser->symTable = 0;
		parser->cg = 0;
		parser->curr = &parser->tokbuffer[0];

		//Fill buffer with look-ahead tokens
		idx = 0;
		while( idx < PARSER_TOKBUFFER_SIZE )
		{
				//Fill with token
				scanner_getToken( parser->scan, &parser->tokbuffer[idx] );
				idx = idx + 1;
		}


		return 0;
}


/**
 * Build the syntax tree from the tokens of the scanner
 */
int parser_buildSyntaxTree( parser* parser, syntaxTreeNode* root)
{
		return parse_program( parser, root );
}


