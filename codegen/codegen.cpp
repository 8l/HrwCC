
#include "codegen.h"

#include "../include/hrwcccomp.h"

#include "typearith.h"


/** Report error of code generator. */
void codegen_reportError( codegen* cg, char* errstr, token name)
{
		char* filename;

		//Increment error counter
		cg->cnterrors = cg->cnterrors +1;

		//Get filename
		filename = preproc_getFilename( cg->parse->scan->pp, name.pos_fileid);


		//Print the error messages
		printf("CODEGEN_ERROR: %d, ", cg->parse->curr->pos_col);
		printf("%d, ", cg->parse->curr->pos_line);
		
		if( filename )
			printf("%s:\n", filename);
		else
			printf("[ERR filename] (%p)\n", filename);

		printf("\tToken is '%s' ::   ", name.content);
		printf("%s\n", errstr);



}


/** Report warning of code generator. */
void codegen_reportWarning( codegen* cg, char* errstr, token name)
{
		char* filename;

		//Increment error counter
		cg->cntwarnings = cg->cntwarnings +1;

		//Get filename
		filename = preproc_getFilename( cg->parse->scan->pp, name.pos_fileid);

		//Print the error messages
		printf("CODEGEN_WARNING: %s", errstr);
		printf(" Token is %d", name.type);
		printf(", %s", name.content);
		printf(" @ %d", name.pos_line);
		printf(",%d, ", name.pos_col);


		//Print filename too
		if( filename )
			printf("%s\n", filename);
		else
			puts("[ERR filename]\n");
}



/** Write down code... */
void codegen_emit( codegen* cg, char* text )
{
		int res;

		//No FD set!
		if( cg->fd < 0 )
			return;

		//Write down the text
		res = write(cg->fd, text, strlen(text));

		//Check for error
		if( res < 0)
		{
				puts("CODEGEN_ERROR: Error emitting code to file!");
				cg->cnterrors = cg->cnterrors + 1;

				//Show only once!
				cg->fd = -1;
		}
}


/** Emit whole tree down... */
void codegen_emitTree( codegen* cg, syntaxTreeNode* tree)
{
		int idx;
		int cnt;

		//Don't print debug
		if( tree == 0 )
			return;


		//Print data
		if( tree->tok.type != 0)
		{
			codegen_emit(cg, tree->tok.content);
			codegen_emit(cg, " ");
		}

		cnt = syntax_CountChilds(tree);
		idx = 0;

		//Print all children
		while( idx < cnt)
		{
				codegen_emitTree(cg, syntax_GetChild(tree,idx));
				idx = idx+1;
		}
}


/** Print debug info */
void codegen_debug( codegen* cg, char* text, syntaxTreeNode* tree)
{
		//Don't print debug
		if( ! cg->emitdebug )
			return;


		//Emit text and then the rest
		codegen_emit(cg, "\t#debug: ");
		codegen_emit(cg, text);
		codegen_emitTree(cg, tree);
		codegen_emit(cg, "\n");
}



/** Initialize code generation structure 
 *	@param fd The file descriptor
 *	@param parser The parser which uses this generator
 * */
void codegen_CreateCodeGen( codegen* cg, int fd, parser* parser)
{
		cg->cnterrors = 0;
		cg->cntwarnings = 0;
		cg->fd = fd;
		cg->parse = parser;
		cg->emitdebug = 0;

		cg->enOptFastassign = 0;
		
		//Set current states to "zero"
		cg->cntBlocks = 0;
		cg->currWhileNr = -1;
		strcpy( cg->currFuncName.content, "");
}



syntaxTreeNode* codegen_EmitLogExpr( codegen* cg, syntaxTreeNode* tree, char* result);
syntaxTreeNode* codegen_EmitVariableExpr( codegen* cg, syntaxTreeNode* tree, char* result);
syntaxTreeNode* codegen_EmitFuncCall( codegen* cg, syntaxTreeNode* tree, char* result);
syntaxTreeNode* codegen_CastToInt( codegen* cg, token tok, char* result,  syntaxTreeNode* tree );
syntaxTreeNode* codegen_CastToChar( codegen* cg, token tok, char* result,  syntaxTreeNode* tree );
syntaxTreeNode* codegen_EmitVarExprAdress( codegen* cg, syntaxTreeNode* tree, char* result);
syntaxTreeNode* codegen_CreateVoidPntType();


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


/** If result is not a register, then move it to eax. Works only for int!  */
void codegen_EmitAvoidConstant(codegen* cg, char* result)
{
		//Not a register
		if( result[0] == '$')
		{
				codegen_emit(cg, "\tmovl\t");
				codegen_emit(cg, result);
				codegen_emit(cg, ", %eax\n");
				strcpy(result, "%eax");
		}
}


/** If result is register-indirect access, move it to eax or al. Works only with non-struct  */
void codegen_EmitAvoidIndirect(codegen* cg, char* result, syntaxTreeNode* type)
{
		//Indirect means: symtab+4  or  (%ebp)
		//  Or: Non-indirect: %eax or $3  
		if( result[0] != '%'  &&  result[0] != '$' )
		{
				if( type_IsByteSized(type) )
					codegen_emit(cg, "\tmovb\t");

				else
					codegen_emit(cg, "\tmovl\t");

				codegen_emit(cg, result);


				if( type_IsByteSized(type) )
				{
					codegen_emit(cg, ", %ah\n");
					strcpy(result, "%ah");
				}
				else
				{
					codegen_emit(cg, ", %eax\n");
					strcpy(result, "%eax");
				}
		}
}


int codegen_EmitProgrammStart( codegen* cg)
{
		codegen_emit(cg, "# gas-assembler code generated by HrwCC\n\n");
		codegen_emit(cg, ".section .text\n");
		/*
		codegen_emit(cg, ".globl _start\n");
		codegen_emit(cg, "_start:\n");
		codegen_emit(cg, "\tcall main\n");
		codegen_emit(cg, "\tmovl\t%eax, %ebx\n");
		codegen_emit(cg, "\tmovl\t$1, %eax\n");
		codegen_emit(cg, "\tret\n\n\n");
		*/

		return 0;
}


int codegen_EmitSymboltable( codegen* cg)
{
		char tmp[CODEGEN_MAXLINE_SIZE];
		int idx;
		int cnt;
		symbolTableNode* node;
		syntaxTreeNode* tree;
		syntaxTreeNode* type;

		codegen_emit(cg, "# The symbol table \n\n");
		codegen_emit(cg, ".section .data\n");		
		codegen_emit(cg, "symtab:\n");


		idx = 0;
		symbol_ClearNonGlobalVariables(cg->parse->symTable);
		cnt = symbol_CountEntries(cg->parse->symTable);


		//Scan for all nodes...
		while( idx < cnt)
		{
				//Get symbol table entry
				node = symbol_GetEntry(cg->parse->symTable, idx);
				tree = node->structure;


				//String, put it down
				if( node->type == SYMBOL_TYPE_STRING )
				{
						codegen_emit(cg, "\t.string\t"); 
						codegen_emit(cg, tree->tok.content);
						codegen_emit(cg, "\n"); 
				}

				//Global variable
				if( node->type == SYMBOL_TYPE_GLOBALVAR )
				{
						type = type_CreateType(tree);

						//Print debug info
						codegen_debug(cg, "global-var: ", tree);

						//If array or struct...
						if( type_IsAArrayVar(tree) || type_IsAStructVar(tree) )
						{
								sprintf(tmp, "\t.rept %d\n", symbol_Sizeof_Symbol(cg->parse->symTable, node));
								codegen_emit(cg, tmp);
								codegen_emit(cg, "\t\t.byte 0\n");
								codegen_emit(cg, "\t.endr\n");
						}
						
						//If long sized
						else if( type_IsLongSized(type) )
							codegen_emit(cg, "\t.long 0\n");

						//If byte sized
						else if( type_IsByteSized(type) )
							codegen_emit(cg, "\t.byte 0\n");

						else
						{
							syntax_printTree(tree);
							printf("struct: %d\n", type_IsAStructVar(tree));
							codegen_emit(cg, "\tunknown type of symtab-entry!\n");
						}


						syntax_FreeSyntaxTree(type);

				}

				idx = idx+1;
		}


		//A last NL
		codegen_emit(cg, "\n");

		return 0;
}

/**
 * Start sequence of a function definition
 */
int codegen_EmitBeginFunction( codegen* cg)
{
		symbolTable* symtab;
		symbolTableNode* node;
		char buffer[CODEGEN_MAXLINE_SIZE];


		//Get the symbol table
		symtab = cg->parse->symTable;
		node = symbol_FindFunction(symtab, cg->currFuncName);

		if(node != 0)
			codegen_debug(cg, "func-def: ", syntax_GetChild(node->structure, 1));

		//.globl functionname
		codegen_emit(cg, ".globl ");
		codegen_emit(cg, cg->currFuncName.content);
		codegen_emit(cg, "\n");

		//.type functionname, @function
		codegen_emit(cg, ".type ");
		codegen_emit(cg, cg->currFuncName.content);
		codegen_emit(cg, ", @function\n");

		//functionname:
		codegen_emit(cg, cg->currFuncName.content);
		codegen_emit(cg, ":\n");


		codegen_emit(cg, "\tpushl\t%ebp\n");
		codegen_emit(cg, "\tmovl\t%esp, %ebp\n");

		sprintf(buffer, "\tsubl\t$%d, %%esp\n", symbol_GetLocalVarBlockSize(symtab));
		codegen_emit(cg, buffer);

		codegen_emit(cg, "\n\n");

		return 0;
}


/**
 * End sequence of a function definition
 */
int codegen_EmitEndFunction( codegen* cg)
{
		symbolTable* symtab;

		//Get the symbol table
		symtab = cg->parse->symTable;

		//functioncg->currFuncName:
		codegen_emit(cg, "\n\n");
		codegen_emit(cg, cg->currFuncName.content);
		codegen_emit(cg, "_ret:\n");

		codegen_emit(cg, "\tmovl\t%ebp, %esp\n");
		codegen_emit(cg, "\tpopl\t%ebp\n");
		codegen_emit(cg, "\tret\n");

		codegen_emit(cg, "\n\n\n\n");

		return 0;
}


int codegen_EmitBeginIf( codegen* cg, syntaxTreeNode* tree, int* blocknr)
{
		char resbuf [CODEGEN_MAXLINE_SIZE];
		char tmp [CODEGEN_MAXLINE_SIZE];
		syntaxTreeNode* type;
		syntaxTreeNode* subtree;


		*blocknr = cg->cntBlocks;
		cg->cntBlocks = cg->cntBlocks + 1;

		//Print debug info
		codegen_debug(cg, "if: ", syntax_GetChild(tree,2));

		//Emit log expr calculation
		type = codegen_EmitLogExpr( cg, syntax_GetChild(tree, 2), resbuf);
		subtree = syntax_GetChild(tree,0);
		type = codegen_CastToInt( cg, subtree->tok, resbuf, type);

		//Move result to register
		codegen_EmitAvoidConstant(cg, resbuf);
		codegen_EmitAvoidIndirect(cg, resbuf, type);

		syntax_FreeSyntaxTree(type);

		codegen_emit(cg, "\ttestl\t");
		codegen_emit(cg, resbuf);
		codegen_emit(cg, ", ");
		codegen_emit(cg, resbuf);
		codegen_emit(cg, "\n");


		sprintf(tmp, "\tjnz\t%s_ifbl_%%d\n", cg->currFuncName.content);
		sprintf(resbuf, tmp, *blocknr);
		codegen_emit(cg, resbuf );
		sprintf(tmp, "\tjmp\t%s_elsebl_%%d\n", cg->currFuncName.content);
		sprintf(resbuf, tmp, *blocknr);
		codegen_emit(cg, resbuf );

		sprintf(tmp, "%s_ifbl_%%d:\n", cg->currFuncName.content);
		sprintf(resbuf, tmp, *blocknr);
		codegen_emit(cg, resbuf );


		return 1;
}


int codegen_EmitElseIf( codegen* cg, syntaxTreeNode* tree, int blocknr)
{
		char resbuf [CODEGEN_MAXLINE_SIZE];
		char tmp [CODEGEN_MAXLINE_SIZE];

		sprintf(tmp, "\tjmp\t%s_endif_%%d\n\n", cg->currFuncName.content);
		sprintf(resbuf, tmp, blocknr);
		codegen_emit(cg, resbuf );

		sprintf(tmp, "%s_elsebl_%%d:\n\n", cg->currFuncName.content);
		sprintf(resbuf, tmp, blocknr);
		codegen_emit(cg, resbuf );
		
		return 1;
}


int codegen_EmitEndIf( codegen* cg, syntaxTreeNode* tree, int blocknr)
{
		char resbuf [CODEGEN_MAXLINE_SIZE];
		char tmp [CODEGEN_MAXLINE_SIZE];

		sprintf(tmp, "%s_endif_%%d:\n\n", cg->currFuncName.content);
		sprintf(resbuf, tmp, blocknr);
		codegen_emit(cg, resbuf );

		return 1;
}


int codegen_EmitBeginWhile( codegen* cg, syntaxTreeNode* tree, int* blocknr )
{
		char resbuf [CODEGEN_MAXLINE_SIZE];
		char tmp [CODEGEN_MAXLINE_SIZE];
		syntaxTreeNode* type;
		syntaxTreeNode* subtree;


		*blocknr = cg->cntBlocks;
		cg->cntBlocks = cg->cntBlocks + 1;


		//Print debug info
		codegen_debug(cg, "while: ", syntax_GetChild(tree,2));

		sprintf(tmp, "%s_while_%%d:\n", cg->currFuncName.content);
		sprintf(resbuf, tmp, *blocknr);
		codegen_emit(cg, resbuf );

		//Emit log expr calculation
		type = codegen_EmitLogExpr( cg, syntax_GetChild(tree, 2), resbuf);
		subtree = syntax_GetChild(tree, 0);
		type = codegen_CastToInt( cg, subtree->tok, resbuf, type);

		//Move result to register
		codegen_EmitAvoidConstant(cg, resbuf);
		codegen_EmitAvoidIndirect(cg, resbuf, type);
		syntax_FreeSyntaxTree(type);

		codegen_emit(cg, "\ttestl\t");
		codegen_emit(cg, resbuf);
		codegen_emit(cg, ", ");
		codegen_emit(cg, resbuf);
		codegen_emit(cg, "\n");

		sprintf(tmp, "\tjz\t%s_endwhile_%%d\n\n", cg->currFuncName.content);
		sprintf(resbuf, tmp, *blocknr);
		codegen_emit(cg, resbuf );


		return 1;
}


int codegen_EmitEndWhile( codegen* cg, syntaxTreeNode* tree, int blocknr)
{
		char resbuf [CODEGEN_MAXLINE_SIZE];
		char tmp [CODEGEN_MAXLINE_SIZE];

		sprintf(tmp, "\tjmp\t%s_while_%%d\n", cg->currFuncName.content);
		sprintf(resbuf, tmp, blocknr);
		codegen_emit(cg, resbuf );

		sprintf(tmp, "%s_endwhile_%%d:\n\n", cg->currFuncName.content);
		sprintf(resbuf, tmp, blocknr);
		codegen_emit(cg, resbuf );

		return 1;
}


int codegen_EmitBreak( codegen* cg, syntaxTreeNode* tree )
{
		char resbuf [CODEGEN_MAXLINE_SIZE];
		char tmp [CODEGEN_MAXLINE_SIZE];
		syntaxTreeNode* subtree;

		if( cg->currWhileNr < 0 )
		{
				subtree = syntax_GetChild(tree,0);
				codegen_reportError( cg, "Detected a break-statement which is not bounded by a while.",
						subtree->tok );
				return -1;
		}

		sprintf(tmp, "\tjmp\t%s_endwhile_%%d\n", cg->currFuncName.content);
		sprintf(resbuf, tmp, cg->currWhileNr);
		codegen_emit(cg, resbuf );

		return 1;
}

int codegen_EmitContinue( codegen* cg, syntaxTreeNode* tree )
{
		char resbuf [CODEGEN_MAXLINE_SIZE];
		char tmp [CODEGEN_MAXLINE_SIZE];
		syntaxTreeNode* subtree;

		if( cg->currWhileNr < 0 )
		{
				subtree = syntax_GetChild(tree,0);
				codegen_reportError( cg, "Detected a continue-statement which is not bounded by a while.",
						subtree->tok );
				return -1;
		}

		sprintf(tmp, "\tjmp\t%s_while_%%d\n", cg->currFuncName.content);
		sprintf(resbuf, tmp, cg->currWhileNr);
		codegen_emit(cg, resbuf );

		return 1;
}



int codegen_EmitReturn( codegen* cg, syntaxTreeNode* tree )
{
		char resbuf [CODEGEN_MAXLINE_SIZE];
		int retpresent;
		symbolTableNode* funcNode;
		syntaxTreeNode* retTree;
		syntaxTreeNode *type;
		syntaxTreeNode* subtree;
		

		//Print debug info
		codegen_debug(cg, "return: ", tree);

		//Get return data-type
		funcNode = symbol_FindFunction( cg->parse->symTable, cg->currFuncName);
		subtree = syntax_GetChild(tree,0);

		if( funcNode == 0)
			return -1;

		
		//Check if return value is present
		if( syntax_CountChilds(tree) > 2 ) 
			retpresent = 1;
		else
			retpresent = 0;

		//If return value is defined and given
		if( syntax_CountChilds(tree) > 2 &&
			! symbol_IsReturnTypeVoid(cg->parse->symTable, funcNode->structure) )
		{
			retTree = funcNode->structure;
			retTree = symbol_GetReturnType( cg->parse->symTable, retTree);

			//Evaluate the return value
			type = codegen_EmitLogExpr( cg, syntax_GetChild(tree,1), resbuf);


			//Casting
			if( type_IsAIntType(retTree) || type_IsAPointerType(retTree) )
				type = codegen_CastToInt( cg, subtree->tok, resbuf, type);

			else if( type_IsACharType(retTree) )
				type = codegen_CastToChar( cg, subtree->tok, resbuf, type);

			else // rettype == struct!
				codegen_reportError(cg, "Return-type of struct-instance is not supported.\n",
								subtree->tok);


			//Move return value to eax, if necessary
			if( strcmp(resbuf, "%eax") != 0)
			{
				codegen_emit( cg, "\tmovl\t");
				codegen_emit( cg, resbuf );
				codegen_emit( cg, ", %eax\n");
			}


			//Remove returned type
			syntax_FreeSyntaxTree(type);
		}

		
		sprintf(resbuf, "\tjmp\t%s_ret\n", cg->currFuncName.content);
		codegen_emit(cg, resbuf );


		//Error with return value presence
		if( symbol_IsReturnTypeVoid(cg->parse->symTable, funcNode->structure) == retpresent )
		{
				codegen_reportError( cg, "Non-void return-typed functions need return value!",
					subtree->tok);
				return -1;
		}

		return 1;
}


/**Here result is the empty string if void is return type*/
int codegen_EmitFuncCallExpr( codegen* cg, syntaxTreeNode* tree, char* result)
{
		syntaxTreeNode* restype;


		//Print debug info
		codegen_debug(cg, "func-call: ", tree);

		restype = codegen_EmitFuncCall(cg, tree, result);
		syntax_FreeSyntaxTree(restype);

		return 1;
}


/** Check if casting from source to target is valid! */
int codegen_CheckCasting( codegen* cg, syntaxTreeNode* target, syntaxTreeNode* source, token errtok)
{
		/**
		 * Allowed (and automatic) castings:
		 * char <-> int <-> pointer
		 * pointer <-> void*
		 *
		 * So if pointers are assigned, they must have same type or at least one is a void pointer!
		 */

		syntaxTreeNode* subtree;


		//If both are pointers -- check if conversion is ok
		if( type_IsAPointerType(target) && type_IsAPointerType(source))
		{
				subtree = codegen_CreateVoidPntType();

				//Error in casting! Either one of both is void* or they must be equal
				if( source != 0 &&
					!syntax_EqualTrees(subtree, target) && 
					!syntax_EqualTrees(subtree, source) && 
					!syntax_EqualTrees(source, target) )
				{
					codegen_reportWarning(cg, "Pointer types must be equal or one of both is void* typed.", errtok);
				}

				syntax_FreeSyntaxTree(subtree);
				return -1;
		}

		//If one of both is a struct -- exact matching is needed
		if( type_IsAStructType(target) || type_IsAStructType(source) )
		{
				//Unequal types...
				if( !syntax_EqualTrees(target,source) )
				{
					codegen_reportError(cg, "Casting between struct-instances not allowed.", errtok);
				}
		}


		return 0;
}


/**
 * Copy size-many bytes from src-addr to dest-addr
 */
int codegen_EmitCopyJunk( codegen* cg, char* destaddr, char* srcaddr, int size)
{
		int cntlong;
		int cntbyte;
		int idx;
		char tmpreg[CODEGEN_MAXLINE_SIZE];

		//Count how many long and how many bytes we have to move
		cntlong = size/4;
		cntbyte = size%4;


		//Check, that both addresses are in registers
		if( destaddr[0] != '%' )
		{
				//Src is already in eax
				if( strcmp(srcaddr, "%eax")==0)
				{
						//Copy in ebx
						codegen_emit(cg, "\tmovl\t");
						codegen_emit(cg, destaddr);
						codegen_emit(cg, ", %ebx\n");

						strcpy(destaddr, "%ebx");
				}
				else
				{
						//Copy in ebx
						codegen_emit(cg, "\tmovl\t");
						codegen_emit(cg, destaddr);
						codegen_emit(cg, ", %eax\n");

						strcpy(destaddr, "%eax");
				}
		}

		//Check, that both addresses are in registers
		if( srcaddr[0] != '%' )
		{
				//Src is already in eax
				if( strcmp(destaddr, "%eax")==0)
				{
						//Copy in ebx
						codegen_emit(cg, "\tmovl\t");
						codegen_emit(cg, srcaddr);
						codegen_emit(cg, ", %ebx\n");

						strcpy(srcaddr, "%ebx");
				}
				else
				{
						//Copy in ebx
						codegen_emit(cg, "\tmovl\t");
						codegen_emit(cg, srcaddr);
						codegen_emit(cg, ", %eax\n");

						strcpy(srcaddr, "%eax");
				}
		}


		//Find a third register:
		//%eax is free
		if( strcmp(srcaddr, "%eax")!=0 && strcmp(destaddr, "%eax")!=0)
			strcpy(tmpreg, "%eax");
		//%ebx is free
		else if( strcmp(srcaddr, "%ebx")!=0 && strcmp(destaddr, "%ebx")!=0)
			strcpy(tmpreg, "%ebx");
		//Last chance: srcaddr and destaddr can't be three registers a time
		else
			strcpy(tmpreg, "%ecx");


		idx=0;
		while(idx < cntlong)
		{
				//Move (%src) --> %esi --> (%dest)
				//We are now allowed to use two memory references
				//in a single assembler command.
				codegen_emit(cg, "\tmovl\t(");
				codegen_emit(cg, srcaddr);
				codegen_emit(cg, "), ");
				codegen_emit(cg, tmpreg);
				codegen_emit(cg, "\n");

				codegen_emit(cg, "\tmovl\t");
				codegen_emit(cg, tmpreg);
				codegen_emit(cg, ", (");
				codegen_emit(cg, destaddr);
				codegen_emit(cg, ")\n");

				//Increment both addresses by 4
				codegen_emit(cg, "\taddl\t$4, ");
				codegen_emit(cg, srcaddr);
				codegen_emit(cg, "\n");
				codegen_emit(cg, "\taddl\t$4, ");
				codegen_emit(cg, destaddr);
				codegen_emit(cg, "\n");

				idx = idx+1;
		}



		//Move tmpreg to byte register
		tmpreg[1] = tmpreg[2];
		tmpreg[2] = 'l';
		tmpreg[3] = '\0';


		idx=0;
		while(idx < cntbyte)
		{
				//Move (%src) --> %esi --> (%dest)
				//We are now allowed to use two memory references
				//in a single assembler command.
				codegen_emit(cg, "\tmovb\t(");
				codegen_emit(cg, srcaddr);
				codegen_emit(cg, "), ");
				codegen_emit(cg, tmpreg);
				codegen_emit(cg, "\n");

				codegen_emit(cg, "\tmovb\t");
				codegen_emit(cg, tmpreg);
				codegen_emit(cg, ", (");
				codegen_emit(cg, destaddr);
				codegen_emit(cg, ")\n");

				//Increment both addresses by 4
				codegen_emit(cg, "\taddl\t$1, ");
				codegen_emit(cg, srcaddr);
				codegen_emit(cg, "\n");
				codegen_emit(cg, "\taddl\t$1, ");
				codegen_emit(cg, destaddr);
				codegen_emit(cg, "\n");

				idx = idx+1;
		}	

		return 0;
}


/**
 * Emit fast assignment for some frequently-used cases. This function returns 1
 * if code has been emitted. And <1 if error occured or no case matched.
 */
int codegen_EmitFastAssign( codegen* cg, syntaxTreeNode* tree)
{
		// Some special cases 
		// 
		// a = rhs
		//    --> a is local, param, or global
		//    --> a is not an array and not a struct
		//    	--> movl rhs, -4(%ebp)
		//    	--> movl rhs, 4(%ebp)
		//    	--> movl rhs, symtab+offset
		//
		// a[3] = rhs
		//    --> a is local, param or global
		//    --> a is an array  but not of structs
		//    	--> movl $3, %edi
		//		--> movl rhs, -4(%ebp, %edi, 4)
		//		--> movl rhs, 4(%ebp, %edi, 4)
		//		--> movl rhs, symtab+offst(, %edi, 4)
		
		syntaxTreeNode* lhs;
		syntaxTreeNode* rhs;

		int cnt;
		int cntresol;
		int idxspec;
		int addrop;

		symbolTableNode* varNode;
		syntaxTreeNode* valType;
		syntaxTreeNode* varType;
		syntaxTreeNode* elmType;
		char result[CODEGEN_MAXLINE_SIZE];

		syntaxTreeNode* subtree;
		syntaxTreeNode* type;
		syntaxTreeNode* vardef;
		symbolTable* symtab;


		//Set left-hand-side and righ-hand-side
		lhs = syntax_GetChild(tree, 0);
		rhs = syntax_GetChild(tree, 2);


		symtab = cg->parse->symTable;

		//Count tokens and resolutions
		cnt = syntax_CountChilds(lhs);
		cntresol = type_CountVarexprResolutions(lhs);

		//Check if idxspec is present
		subtree = syntax_GetChild(lhs,cnt-1);
		if( subtree->tok.type == TOK_RECPAR_END )
			idxspec = 1;
		else
			idxspec = 0;

		//Check if derefspec is present
		subtree = syntax_GetChild(lhs,0);
		if( subtree->tok.type != TOK_IDENT )
			addrop = 1;
		else
			addrop = 0;



		//Get type of (first variable of nested expr of)  lhs
		subtree = syntax_GetChild(lhs, addrop);
		varNode = symbol_FindVariable(symtab, subtree->tok );

		//Unknown variable
		if( varNode == 0 )
		{
				syntax_printTree(subtree);
				codegen_reportError(cg, "Unknown variable.\n", subtree->tok);
				return -1;
		}


		vardef = varNode->structure;
		varType = type_CreateType(varNode->structure);


		//No address operator and no index-specifier and no nested variables
		//This is the case: 'a = 3' and similar
		if( addrop==0 && idxspec==0 && cntresol==1 && !type_IsAStructType(varType) &&
			!type_IsAArrayVar(vardef) )
		{
				//Evaluate right hand side
				valType = codegen_EmitLogExpr(cg, rhs, result);
				codegen_EmitAvoidIndirect(cg, result, valType);


				//Check if casting is ok
				subtree = syntax_GetChild(tree,1);
				codegen_CheckCasting(cg, varType, valType, subtree->tok);


				//All comands are of the form 'movx result, ???'

				//Left hand side is long type
				if( type_IsLongSized(varType) )
				{
						//Cast to int
						valType = codegen_CastToInt(cg, subtree->tok, result, valType);

						codegen_emit(cg, "\tmovl\t");
						codegen_emit(cg, result);
						codegen_emit(cg, ", ");
				}

				//Left hand side is byte type
				else if( type_IsByteSized(varType) )
				{
						//Cast to int
						valType = codegen_CastToChar(cg, subtree->tok, result, valType);

						codegen_emit(cg, "\tmovb\t");
						codegen_emit(cg, result);
						codegen_emit(cg, ", ");
				}
				else
				{
						subtree = syntax_GetChild(tree,1);
						codegen_reportError(cg, "Internal compiler error: EmitFastAssign", subtree->tok);

						syntax_FreeSyntaxTree(varType);
						return -1;
				}


				
				//Emit code for the destination of result
				if( varNode->type == SYMBOL_TYPE_LOCALVAR || varNode->type == SYMBOL_TYPE_PARVAR )
						sprintf(result, "%d(%%ebp)", symbol_GetNonGlobalOffset(symtab, varNode));
				else //if( varNode->type == SYMBOL_TYPE_GLOBALVAR )
						sprintf(result, "symtab+%d", symbol_GetGlobalOffset(symtab, varNode));

				codegen_emit(cg, result);
				codegen_emit(cg, "\n");

				syntax_FreeSyntaxTree(varType);
				return 1;
		}


		//No address operator but index-specifier and no nested variables
		//This is the case: 'a[2] = 3' and similar
		if(  addrop==0 && idxspec==1 && cntresol==1 &&  type_IsAArrayVar(vardef) )
		{
				//Determine element type of array/pointer
				elmType = type_CreateArrayElmType(vardef);

				//Don't want struct elements
				//ATTENTION: We use expressions like 'const (%ebp, %esi, size)'
				//below. So the element-size 'size' of the array has to be
				//1, 2, 4, or 8. Therefore structs are not allowed. Btw, assigning
				//structs would lead to copying data by multiple moves anyway.
				if( type_IsAStructType(elmType) )
				{
						syntax_FreeSyntaxTree(varType);
						syntax_FreeSyntaxTree(elmType);
						return 0;
				}


				//Evaluate and cast index
				subtree = syntax_GetChild(lhs,cnt-1);
				type = codegen_EmitLogExpr(cg, syntax_GetChild(lhs,cnt-2), result);
				type = codegen_CastToInt(cg, subtree->tok, result, type);
				syntax_FreeSyntaxTree(type);

				//Save index on stack
				codegen_emit(cg, "\tpushl\t");
				codegen_emit(cg, result);
				codegen_emit(cg, "\n");

				
				//Evaluate right hand side
				valType = codegen_EmitLogExpr(cg, rhs, result);
				codegen_EmitAvoidIndirect(cg, result, valType);
			
				//Check if casting is ok
				subtree = syntax_GetChild(tree,1);
				codegen_CheckCasting(cg, elmType, valType, subtree->tok);


				//Save index to %esi
				codegen_emit(cg, "\tpopl\t%esi\n");


				//All comands are of the form 'movx result, ???'

				//Left hand side is long type
				if( type_IsLongSized(elmType) )
				{
						//Cast to int
						valType = codegen_CastToInt(cg, subtree->tok, result, valType);

						codegen_emit(cg, "\tmovl\t");
						codegen_emit(cg, result);
						codegen_emit(cg, ", ");
				}

				//Left hand side is byte type
				else if( type_IsByteSized(elmType) )
				{
						//Cast to int
						valType = codegen_CastToChar(cg, subtree->tok, result, valType);

						codegen_emit(cg, "\tmovb\t");
						codegen_emit(cg, result);
						codegen_emit(cg, ", ");
				}
				else
				{
						subtree = syntax_GetChild(tree,1);
						codegen_reportError(cg, "Internal compiler error: EmitFastAssign", subtree->tok);

						syntax_FreeSyntaxTree(varType);
						syntax_FreeSyntaxTree(elmType);
						return -1;
				}


				
				//Emit code for the destination of result
				if( varNode->type == SYMBOL_TYPE_LOCALVAR || varNode->type == SYMBOL_TYPE_PARVAR )
				{
						sprintf(result, "%d", symbol_GetNonGlobalOffset(symtab, varNode));
						codegen_emit(cg, result);

						sprintf(result, "(%%ebp, %%esi, %d)\n", type_GetArrayElmSize(symtab, vardef));
						codegen_emit(cg, result);
				}
				else //if( varNode->type == SYMBOL_TYPE_GLOBALVAR )
				{
						sprintf(result, "symtab+%d", symbol_GetGlobalOffset(symtab, varNode));
						codegen_emit(cg, result);

						sprintf(result, "(, %%esi, %d)\n", type_GetArrayElmSize(symtab, vardef));
						codegen_emit(cg, result);
				}

				

				syntax_FreeSyntaxTree(varType);
				syntax_FreeSyntaxTree(elmType);
				return 1;
		}
	


		syntax_FreeSyntaxTree(varType);
		return 0;
}


int codegen_EmitAssign( codegen* cg, syntaxTreeNode* tree)
{
		char result[CODEGEN_MAXLINE_SIZE];
		char addr[CODEGEN_MAXLINE_SIZE];
		syntaxTreeNode* varType;
		syntaxTreeNode* valType;
		syntaxTreeNode* subtree;
		int ret;


		//Print debug info
		codegen_debug(cg, "assignment: ", tree);
		strcpy(result, "");


		//Try to emit code for some special cases
		if( cg->enOptFastassign )
		{
			//Do fast assignment
			ret =  codegen_EmitFastAssign(cg, tree);

			//Error or fine
			if( ret != 0 )
				return ret;
		}


		//We must evaluate the address before the result
		//because we cant push bytes, if the result is of type char or so.

		//Evaluate the adress of the variable
		varType = codegen_EmitVarExprAdress(cg, syntax_GetChild(tree,0), result);
		//And push addr to stack
		codegen_emit(cg, "\tpushl\t");
		codegen_emit(cg, result);
		codegen_emit(cg, "\n");


		//Evaluate right hand side
		valType = codegen_EmitLogExpr(cg, syntax_GetChild(tree,2), result);
		codegen_EmitAvoidIndirect(cg, result, valType);

		//Determine where to pop the addr from stack
		if( strcmp(result, "ebx") == 0)
			strcpy(addr, "%eax");
		else
			strcpy(addr, "%ebx");

		codegen_emit(cg, "\tpopl\t");
		codegen_emit(cg, addr);
		codegen_emit(cg, "\n");


		//Check if casting is ok
		subtree = syntax_GetChild(tree,1);
		codegen_CheckCasting(cg, varType, valType, subtree->tok);

	

		//Left hand side is long type
		if( type_IsLongSized(varType) )
		{
				//Cast to int
				valType = codegen_CastToInt(cg, subtree->tok, result, valType);

				codegen_emit(cg, "\tmovl\t");
				codegen_emit(cg, result);
				codegen_emit(cg, ", (");
				codegen_emit(cg, addr);
				codegen_emit(cg, ")\n");
		}

		//Left hand side is byte type
		else if( type_IsByteSized(varType) )
		{
				//Cast to int
				valType = codegen_CastToChar(cg, subtree->tok, result, valType);

				codegen_emit(cg, "\tmovb\t");
				codegen_emit(cg, result);
				codegen_emit(cg, ", (");
				codegen_emit(cg, addr);
				codegen_emit(cg, ")\n");
		}
		//Copy structs
		else if( type_IsAStructType(varType) )
		{
				//Copy junk of memory, namely the struct-instance
				codegen_EmitCopyJunk(cg, addr, result, symbol_Sizeof_DataType(cg->parse->symTable, varType));
		}
		else
		{
				codegen_reportError(cg, "Internal Error: Unhandled case in assignment.", subtree->tok);
		}


	

		syntax_FreeSyntaxTree(varType);
		syntax_FreeSyntaxTree(valType);
	
		return 1;
}





/**
 * The next instructions need all type information. They are build the same way
 * and use the same semantics:
 *
 * - Every Function returns syntaxTreeNode* and creates the type which results. If
 *   return value is 0, no type is assigned. Every function which calls one of them
 *   has to free the tree after using.
 *
 */ 







/**
 * Create type tree for int
 */
syntaxTreeNode* codegen_CreateIntType( )
{
		syntaxTreeNode* tree;
		token tok;

		strcpy(tok.content, "int");
		tok.type = TOK_INT;

		tree = syntax_CreateTreeNode();
		syntax_AddChildNode(tree, tok);

		return tree;
}

/**
 * Create type tree for char
 */
syntaxTreeNode* codegen_CreateCharType( )
{
		syntaxTreeNode* tree;
		token tok;

		strcpy(tok.content, "char");
		tok.type = TOK_CHAR;

		tree = syntax_CreateTreeNode();
		syntax_AddChildNode(tree, tok);

		return tree;
}

/**
 * Create type for void*
 */
syntaxTreeNode* codegen_CreateVoidPntType()
{
		syntaxTreeNode* tree;
		token tok;

		tree = syntax_CreateTreeNode();

		tok.type = TOK_VOID;
		strcpy(tok.content, "void");
		syntax_AddChildNode(tree, tok);

		tok.type = TOK_STAR;
		strcpy(tok.content, "*");
		syntax_AddChildNode(tree, tok);

		return tree;
}



/** Cast 'result' to a int value if necessary. */
syntaxTreeNode* codegen_CastToInt( codegen* cg, token tok, char* result,  syntaxTreeNode* tree )
{
		//Was untyped -- type it
		if( tree == 0)
			return codegen_CreateIntType();

		//Finished ;-)
		if( type_IsAIntType(tree) )
			return tree;

		//Do real cast
		if( type_IsACharType(tree) )
		{
				//We preserve the sign!
				codegen_emit(cg, "\tmovsbl\t");
				codegen_emit(cg, result);
				codegen_emit(cg, ", %eax\n");

				strcpy(result, "%eax");
		}
		else if( type_IsAPointerType(tree) )
		{
		}
		else
			codegen_reportError(cg, "Can not cast to int.", tok);


		syntax_FreeSyntaxTree(tree);
		return codegen_CreateIntType();
}


/** Cast 'result' to a char value if necessary. */
syntaxTreeNode* codegen_CastToChar( codegen* cg, token tok, char* result,  syntaxTreeNode* tree )
{
		char regname;

		//Was untyped -- type it
		if( tree == 0)
			return codegen_CreateCharType();

		//Finished ;-)
		if( type_IsACharType(tree) )
			return tree;

		//Do real cast
		if( type_IsAIntType(tree) )
		{
				//A register, convert name from %e?x to %?l
				if( result[0] == '%' )
				{
						regname = result[2];
						strcpy(result, "%Xl");
						result[1] = regname;
				}
		}
		else
			codegen_reportError(cg, "Can not cast to char.", tok);


		syntax_FreeSyntaxTree(tree);
		return codegen_CreateCharType();
}



syntaxTreeNode* codegen_EmitAtomicValue( codegen* cg, syntaxTreeNode* tree, char* result)
{
		symbolTableNode* node;
		syntaxTreeNode* subtree;

		//Get first element...
		tree = syntax_GetChild(tree,0);

		
		if( tree->tok.type == TOK_NUMBER )
		{
				//Result: $number
				strcpy( result+1, tree->tok.content );
				result[0] = '$';
				return 0;
		}

		if( tree->tok.type == TOK_SINGLECHAR )
		{
				//Result: $number
				sprintf(result, "$%d", type_ConvertSinglechar(tree->tok.content));
				return 0;
		}


		if( tree->tok.type == TOK_STRING )
		{				
				//Result: symtab+offset
				node = symbol_FindString( cg->parse->symTable, tree->tok);
				sprintf(result, "$symtab+%d", symbol_GetGlobalOffset(cg->parse->symTable, node));
				return 0;
		}


		//Now we thate there are at least one children

		subtree = syntax_GetChild(tree,0);
		if( subtree->tok.type == TOK_SIZEOF )
		{
				sprintf(result, "$%d", symbol_Sizeof_DataType(cg->parse->symTable, 
							syntax_GetChild(tree,2)));
				return 0;
		}

		//We have a function call
		if( syntax_CountChilds(tree)>1)
		{
				subtree = syntax_GetChild(tree,1);

				if( subtree->tok.type == TOK_RNDPAR_BEGIN )
					return codegen_EmitFuncCall(cg, tree, result);
		}


		return codegen_EmitVariableExpr(cg, tree, result);
}


syntaxTreeNode* codegen_EmitArithFactor( codegen* cg, syntaxTreeNode* tree, char* result)
{
		syntaxTreeNode* subtree;
		syntaxTreeNode* type;


		//If have just this one term, return it
		if( syntax_CountChilds(tree) == 1)
			return codegen_EmitAtomicValue(cg, syntax_GetChild(tree, 0), result);


		//We have ~ <atomic_val_expr>
		if( syntax_CountChilds(tree) == 2)
		{
				subtree = syntax_GetChild(tree,0);

				//Get atomic value and cast
				type = codegen_EmitAtomicValue(cg, syntax_GetChild(tree,1), result);
				type = codegen_CastToInt(cg, subtree->tok, result, type);

				//Move result to eax and negate bits
				if( strcmp(result, "%eax") != 0)
				{
						codegen_emit(cg, "\tmovl\t");
						codegen_emit(cg, result);
						codegen_emit(cg, ", %eax\n");
				}

				codegen_emit(cg, "\tnotl\t%eax\n");

				//Copy result
				strcpy(result, "%eax");
				return type;
		}


		//Otherwise evaluate logical expression in brackets
		return codegen_EmitLogExpr( cg, syntax_GetChild(tree,1), result);
}


syntaxTreeNode* codegen_EmitArithTerm( codegen* cg, syntaxTreeNode* tree, char* result)
{
		syntaxTreeNode* subtree;
		syntaxTreeNode* type;
		int cnt;
		int idx;
		char result2[CODEGEN_MAXLINE_SIZE];


		//If have just this one term, return it
		if( syntax_CountChilds(tree) == 1)
			return codegen_EmitArithFactor(cg, syntax_GetChild(tree, 0), result);


		cnt = syntax_CountChilds(tree);
		subtree = syntax_GetChild(tree,0);

		//Evalute first term
		type = codegen_EmitArithFactor(cg, subtree, result);
				
		//Cast to int
		subtree = syntax_GetChild(tree, 1);
		type = codegen_CastToInt(cg, subtree->tok, result, type);

		codegen_emit(cg, "\tpushl\t");
		codegen_emit(cg, result);
		codegen_emit(cg, "\n");

		//We begin with index 2
		idx = 2;
		


		//Get further operands and operate on them
		while( idx < cnt)
		{
				//Operator
				subtree = syntax_GetChild(tree, idx-1);

				//Evaluate next operand
				syntax_FreeSyntaxTree(type);
				type = codegen_EmitArithFactor(cg, syntax_GetChild(tree, idx), result2);
				type = codegen_CastToInt(cg, subtree->tok, result2, type);

							
				//Division is a little bit more trickier
				if( subtree->tok.type == TOK_DIV ||
					subtree->tok.type == TOK_PERCENT)
				{
						codegen_EmitAvoidConstant(cg, result2);

						//Divisor is in eax, mov him to ebx
						if( strcmp(result2, "%eax") == 0)
						{
								codegen_emit(cg, "\tmovl\t");
								codegen_emit(cg, result2);
								codegen_emit(cg, ", %ebx\n");
								
								strcpy(result2, "%ebx");
						}

						//Get dividend to %eax
						codegen_emit(cg, "\tpopl\t%eax\n");
						codegen_emit(cg, "\tmovl\t$0, %edx\n");

						//edx:eax / result2  = eax
						//edx:eax % result2  = edx
						codegen_emit(cg, "\tidivl\t");
						codegen_emit(cg, result2);
						codegen_emit(cg, "\n");

						//Save modul to eax
						if( subtree->tok.type == TOK_DIV )
							strcpy(result, "%eax");
						else
							strcpy(result, "%edx");
				}
				else
				{
						//Determine destination of last result
						if( strcmp(result2, "%ebx") == 0)
							strcpy(result, "%eax");
						else
							strcpy(result, "%ebx");


						//Get last operand
						codegen_emit(cg, "\tpopl\t");
						codegen_emit(cg, result);
						codegen_emit(cg, "\n");

						//Subtract result2 from result
						if( subtree->tok.type == TOK_AND )
							codegen_emit(cg, "\tandl\t");
						if( subtree->tok.type == TOK_HAT )
							codegen_emit(cg, "\txorl\t");
						if( subtree->tok.type == TOK_STAR )
							codegen_emit(cg, "\timull\t");

						// op 2nd -> 1st
						codegen_emit(cg, result2);
						codegen_emit(cg, ", ");
						codegen_emit(cg, result);
						codegen_emit(cg, "\n");		
				}


				//Save new 1st
				codegen_emit(cg, "\tpushl\t");
				codegen_emit(cg, result);
				codegen_emit(cg, "\n");


				//Goto next operand
				idx = idx+2;
		}


		//Get result
		codegen_emit(cg, "\tpopl\t%eax\n");

		strcpy(result, "%eax");
		return type;
}


syntaxTreeNode* codegen_EmitArithExpr( codegen* cg, syntaxTreeNode* tree, char* result)
{
		syntaxTreeNode* subtree;
		syntaxTreeNode* type;
		syntaxTreeNode* oldtype;
		int cnt;
		int idx;
		char result2[CODEGEN_MAXLINE_SIZE];
		char result3[CODEGEN_MAXLINE_SIZE];


		//If have just this one term, return it
		if( syntax_CountChilds(tree) == 1)
			return codegen_EmitArithTerm(cg, syntax_GetChild(tree, 0), result);


		cnt = syntax_CountChilds(tree);
		subtree = syntax_GetChild(tree,0);

		//First element is minus --> we begin with zero
		if( subtree->tok.type == TOK_MINUS )
		{
				codegen_emit(cg, "\tpushl\t$0\n");
				type = codegen_CreateIntType();
				//We begin with index one!
				idx = 1;
		}
		//Otherwise we begin with the first term
		else
		{
				//Evalute first term
				type = codegen_EmitArithTerm(cg, subtree, result);
				
				//Cast to .long
				subtree = syntax_GetChild(tree, 1);

				//Pointer types are not converted. See later...
				if( !type_IsAPointerType(type) )
					type = codegen_CastToInt(cg, subtree->tok, result, type);

				codegen_emit(cg, "\tpushl\t");
				codegen_emit(cg, result);
				codegen_emit(cg, "\n");

				//We begin with index 2
				idx = 2;
		}


		//Get further operands and operate on them
		while( idx < cnt)
		{
				//Operator
				subtree = syntax_GetChild(tree, idx-1);

				//Evaluate next operand
				oldtype = type;
				type = codegen_EmitArithTerm(cg, syntax_GetChild(tree, idx), result2);
				type = codegen_CastToInt(cg, subtree->tok, result2, type);

				//Determine destination of last result
				if( strcmp(result2, "%ebx") == 0)
					strcpy(result, "%eax");
				else
					strcpy(result, "%ebx");

				//Get last operand
				codegen_emit(cg, "\tpopl\t");
				codegen_emit(cg, result);
				codegen_emit(cg, "\n");

				
				
				//Last operator
				subtree = syntax_GetChild(tree, idx-1);

				//Old type was a pointer!
				//This changes everything: let 'type* p' be a pointer
				//then p+1 means that to p is sizeof(type) added.
				//But this makes only sence if we have + or - operator
				if( type_IsAPointerType(oldtype) &&
					( subtree->tok.type == TOK_PLUS || subtree->tok.type == TOK_MINUS) )
				{
						//First move the sizeof to %esi
						subtree = type_RemoveStarFromType(oldtype);
						sprintf(result3, "\tmovl\t$%d, %%esi\n",
								symbol_Sizeof_DataType(cg->parse->symTable, subtree));
						codegen_emit(cg, result3);

						//And multiply it with the summand
						codegen_emit(cg, "\timull\t");
						codegen_emit(cg, result2);
						codegen_emit(cg, ", %esi\n");

						//This is the new overall summand
						strcpy(result2, "%esi");
						syntax_FreeSyntaxTree(subtree);

						//Swap oldtype and type
						//Because now type should be freed and
						//oldtype is propagated
						subtree = oldtype;
						oldtype = type;
						type = subtree;
				}


				//Last operator
				subtree = syntax_GetChild(tree, idx-1);

				//Subtract result2 from result
				if( subtree->tok.type == TOK_PLUS )
					codegen_emit(cg, "\taddl\t");
				if( subtree->tok.type == TOK_MINUS )
					codegen_emit(cg, "\tsubl\t");
				if( subtree->tok.type == TOK_PIPE )
					codegen_emit(cg, "\torl\t");

				// op 2nd -> 1st
				codegen_emit(cg, result2);
				codegen_emit(cg, ", ");
				codegen_emit(cg, result);
				codegen_emit(cg, "\n");

				//Save new 1st
				codegen_emit(cg, "\tpushl\t");
				codegen_emit(cg, result);
				codegen_emit(cg, "\n");


				//Goto next operand
				idx = idx+2;

				//Remove the old type
				syntax_FreeSyntaxTree(oldtype);
		}


		//Get result
		codegen_emit(cg, "\tpopl\t%eax\n");

		strcpy(result, "%eax");
		return type;
}


syntaxTreeNode* codegen_EmitRelExpr( codegen* cg, syntaxTreeNode* tree, char* result)
{
		int blocknr;
		char result2[CODEGEN_MAXLINE_SIZE];
		char tmp [CODEGEN_MAXLINE_SIZE];
		token* reltok;
		syntaxTreeNode* type;
		syntaxTreeNode* subtree;



		//If have just this one term, return it
		if( syntax_CountChilds(tree) == 1)
			return codegen_EmitArithExpr(cg, syntax_GetChild(tree, 0), result);


		subtree = syntax_GetChild(tree,1);
		blocknr = cg->cntBlocks;
		cg->cntBlocks = cg->cntBlocks + 1;

		
		//Get first argument
		type =  codegen_EmitArithExpr(cg, syntax_GetChild(tree, 0), result);
		type = codegen_CastToInt(cg, subtree->tok, result, type);

		//Save result
		codegen_emit(cg, "\tpushl\t");
		codegen_emit(cg, result);
		codegen_emit(cg, "\n");


		//So we have to invert result
		syntax_FreeSyntaxTree(type);
		type = codegen_EmitArithExpr(cg, syntax_GetChild(tree, 2), result2);
		type = codegen_CastToInt(cg, subtree->tok, result2, type);

		//If result2 is saved in ebx, than pop first result to eax
		if( strcmp(result2, "%ebx") == 0)
			strcpy(result, "%eax");
		else
			strcpy(result, "%ebx");
		

		codegen_emit(cg, "\tpopl\t");
		codegen_emit(cg, result);
		codegen_emit(cg, "\n");


		//ATTENTION:
		//We swapped result and result2 here, because 'cmpl' does not allow
		//an immediate value ($1 i.e.) as second operand. But according to
		//this change, we have to swap the orde-relational ops too. 'jl'
		//becomes 'jg' and 'jle' become 'jge' and vice-versa.

		codegen_emit(cg, "\tcmpl\t");
		codegen_emit(cg, result2);
		codegen_emit(cg, ", ");
		codegen_emit(cg, result);
		codegen_emit(cg, "\n");

		codegen_emit(cg, "\tmovl\t$1, %eax\n");


		//Get token which carries relation-op
		reltok = &subtree->tok;

		// jg a, b means that b > a. They see it relative to second argument
		if( reltok->type == TOK_DBLEQUAL )
			codegen_emit(cg, "\tje\t");
		else if( reltok->type == TOK_NOTEQUAL )
			codegen_emit(cg, "\tjne\t");
		else if( reltok->type == TOK_LESS )
			codegen_emit(cg, "\tjl\t");
		else if( reltok->type == TOK_LESSEQUAL )
			codegen_emit(cg, "\tjle\t");
		else if( reltok->type == TOK_MORE )
			codegen_emit(cg, "\tjg\t");
		else if( reltok->type == TOK_MOREEQUAL )
			codegen_emit(cg, "\tjge\t");
		else
			codegen_reportError(cg, "Unknown relational operator.", *reltok);
	

		sprintf(tmp, "%s_reltrue_%%d\n", cg->currFuncName.content);
		sprintf(result, tmp, blocknr);
		codegen_emit(cg, result);

		codegen_emit(cg, "\tmovl\t$0, %eax\n");

		sprintf(tmp, "%s_reltrue_%%d:\n", cg->currFuncName.content);
		sprintf(result, tmp, blocknr);
		codegen_emit(cg, result);

		//Save what we made
		strcpy(result, "%eax");
		return type;
}




syntaxTreeNode* codegen_EmitLogFactor( codegen* cg, syntaxTreeNode* tree, char* result)
{		
		int blocknr;
		syntaxTreeNode* type;
		syntaxTreeNode* subtree;
		char tmp [CODEGEN_MAXLINE_SIZE];


		subtree = syntax_GetChild(tree,0);

		//If have just this one term, return it
		if( syntax_CountChilds(tree) == 1)
			return codegen_EmitRelExpr(cg, subtree, result);


		blocknr = cg->cntBlocks;
		cg->cntBlocks = cg->cntBlocks + 1;

		//So we have to invert result
		type = codegen_EmitRelExpr(cg, syntax_GetChild(tree, 1), result);
		type = codegen_CastToInt(cg, subtree->tok, result, type);
		//Move result to register
		codegen_EmitAvoidConstant(cg, result);
		codegen_EmitAvoidIndirect(cg, result, type);


		//Test if true or false
		codegen_emit(cg, "\ttestl\t");
		codegen_emit(cg, result);
		codegen_emit(cg, ", ");
		codegen_emit(cg, result);
		codegen_emit(cg, "\n");

		codegen_emit(cg, "\tmovl\t$1, %eax\n");
		
		sprintf(tmp, "\tjz\t%s_logfactfalse_%%d\n", cg->currFuncName.content);
		sprintf(result, tmp, blocknr);
		codegen_emit(cg, result);

		codegen_emit(cg, "\tmovl\t$0, %eax\n");

		sprintf(tmp, "%s_logfactfalse_%%d:\n", cg->currFuncName.content);
		sprintf(result, tmp, blocknr);
		codegen_emit(cg, result);

		//Save what we made
		strcpy(result, "%eax");
		return type;
}


syntaxTreeNode* codegen_EmitLogTerm( codegen* cg, syntaxTreeNode* tree, char* result)
{
		int idx;
		int cnt;
		int ret;
		int blocknr;
		syntaxTreeNode* type;
		syntaxTreeNode* subtree;
		char tmp [CODEGEN_MAXLINE_SIZE];


		//If have just this one term, return it
		if( syntax_CountChilds(tree) == 1)
			return codegen_EmitLogFactor(cg, syntax_GetChild(tree, 0), result);


		subtree = syntax_GetChild(tree,1);

		//Count how many children we have
		cnt = (syntax_CountChilds(tree)+1)/2;
		idx = 0;
		ret = 0;
		type = 0;

		blocknr = cg->cntBlocks;
		cg->cntBlocks = cg->cntBlocks + 1;
		
		//We do lazy evaluation here and search for the first factor
		//which gets false
		while( idx < cnt )
		{
				//Evaluate factor
				syntax_FreeSyntaxTree(type);
				type = codegen_EmitLogFactor(cg, syntax_GetChild(tree, 2*idx), result);
				type = codegen_CastToInt(cg, subtree->tok, result, type );

				//Move result to register
				codegen_EmitAvoidConstant(cg, result);
				codegen_EmitAvoidIndirect(cg, result, type);
				
				//Test result
				codegen_emit(cg, "\ttestl\t");
				codegen_emit(cg, result);
				codegen_emit(cg, ", ");
				codegen_emit(cg, result);
				codegen_emit(cg, "\n");

				sprintf(tmp, "\tjz\t%s_logtermfalse_%%d\n", cg->currFuncName.content);
				sprintf(result, tmp, blocknr);
				codegen_emit(cg, result);				

				idx = idx+1;
		}


		//End-up sequence for log-expr
		codegen_emit(cg, "\tmovl\t$1, %eax\n");
		sprintf(tmp, "\tjmp\t%s_logtermtrue_%%d\n", cg->currFuncName.content);
		sprintf(result, tmp, blocknr);
		codegen_emit(cg, result);

		sprintf(tmp, "%s_logtermfalse_%%d:\n", cg->currFuncName.content);
		sprintf(result, tmp, blocknr);
		codegen_emit(cg, result);

		codegen_emit(cg, "\tmovl\t$0, %eax\n");

		sprintf(tmp, "%s_logtermtrue_%%d:\n", cg->currFuncName.content);
		sprintf(result, tmp, blocknr);
		codegen_emit(cg, result);


		strcpy(result, "%eax");
		return type;
}



syntaxTreeNode* codegen_EmitLogExpr( codegen* cg, syntaxTreeNode* tree, char* result)
{
		int idx;
		int cnt;
		int ret;
		int blocknr;
		syntaxTreeNode* type;
		syntaxTreeNode* subtree;
		char tmp [CODEGEN_MAXLINE_SIZE];


		//If have just this one term, return it
		if( syntax_CountChilds(tree) == 1)
			return codegen_EmitLogTerm(cg, syntax_GetChild(tree, 0), result);


		subtree = syntax_GetChild(tree,1);

		//Count how many children we have
		cnt = (syntax_CountChilds(tree)+1)/2;
		idx = 0;
		ret = 0;
		type = 0;

		blocknr = cg->cntBlocks;
		cg->cntBlocks = cg->cntBlocks + 1;
		
		//We do lazy evaluation here and search for the first term
		//which gets true
		while( idx < cnt )
		{
				//Evaluate term
				syntax_FreeSyntaxTree(type);
				type = codegen_EmitLogTerm(cg, syntax_GetChild(tree, 2*idx), result);
				type = codegen_CastToInt(cg, subtree->tok, result, type );

				//Move result to register
				codegen_EmitAvoidConstant(cg, result);
				codegen_EmitAvoidIndirect(cg, result, type);
				
				//Test result
				codegen_emit(cg, "\ttestl\t");
				codegen_emit(cg, result);
				codegen_emit(cg, ", ");
				codegen_emit(cg, result);
				codegen_emit(cg, "\n");

				sprintf(tmp, "\tjnz\t%s_logexprtrue_%%d\n", cg->currFuncName.content);
				sprintf(result, tmp, blocknr);
				codegen_emit(cg, result);				

				idx = idx+1;
		}


		//End-up sequence for log-expr
		codegen_emit(cg, "\tmovl\t$0, %eax\n");

		sprintf(tmp, "\tjmp\t%s_logexprfalse_%%d\n", cg->currFuncName.content);
		sprintf(result, tmp, blocknr);
		codegen_emit(cg, result);

		sprintf(tmp, "%s_logexprtrue_%%d:\n", cg->currFuncName.content);
		sprintf(result, tmp, blocknr);
		codegen_emit(cg, result);

		codegen_emit(cg, "\tmovl\t$1, %eax\n");

		sprintf(tmp, "%s_logexprfalse_%%d:\n", cg->currFuncName.content);
		sprintf(result, tmp, blocknr);
		codegen_emit(cg, result);


		strcpy(result, "%eax");
		return type;
}


/**
 * Emit code to get adress of variable to eax
 */
syntaxTreeNode* codegen_EmitVariableAdress( codegen* cg, token varname)
{
		symbolTable* symtab;
		symbolTableNode* varNode;
		char result[CODEGEN_MAXLINE_SIZE];


		//Get symtable node of variable
		symtab = cg->parse->symTable;
		varNode = symbol_FindVariable(symtab, varname);

		//Not found!
		if( varNode == 0)
			return 0;

		//We deal with a global variable...
		if( varNode->type == SYMBOL_TYPE_GLOBALVAR )
		{
				codegen_emit(cg, "\tmovl\t$symtab, %eax\n");
				sprintf(result, "\taddl\t$%d, %%eax\n",
						symbol_GetGlobalOffset(symtab, varNode));
				codegen_emit(cg, result);
		}

		//We deal with non-global variable...
		else
		{
				codegen_emit(cg, "\tmovl\t%ebp, %eax\n");
				sprintf(result, "\taddl\t$%d, %%eax\n",
						symbol_GetNonGlobalOffset(symtab, varNode));
				codegen_emit(cg, result);
		}


		//Get datatype subtree
		return varNode->structure;
}



/**
 * Calculates the start address of the (nested) variable a->b.c->d and so on. Result contains
 * the string where the result lies. Initial & or * are ignored.
 */
syntaxTreeNode* codegen_EmitStartAddrOfNestedVar( codegen* cg, syntaxTreeNode* tree, char* result)
{
		int cntresol;
		int addrop;
		int idx;
		int offset;
		syntaxTreeNode* subtree;
		syntaxTreeNode* conttype;
		syntaxTreeNode* vartype;
		symbolTable* symtab;
		token membername;


		symtab = cg->parse->symTable;

		//Count tokens and resolutions
		cntresol = type_CountVarexprResolutions(tree);

		//Check if derefspec is present
		subtree = syntax_GetChild(tree,0);
		if( subtree->tok.type != TOK_IDENT )
			addrop = 1;
		else
			addrop = 0;


		//Emit addr of variable to %eax
		subtree = syntax_GetChild(tree,addrop);
		vartype = codegen_EmitVariableAdress(cg, subtree->tok);
		idx = 1;

		//Unknown variable
		if( vartype == 0)
		{
				codegen_reportError(cg, 
					"Unknown variable.",
					subtree->tok );
				return 0;
		}


		//Walk through all resolutions
		while( idx < cntresol )
		{
				// array but not last resolution
				if( type_IsAArrayVar(vartype) )
				{
					codegen_reportError(cg, "Cannot access array here.", subtree->tok);
					return 0;
				}


				//Goto data-type itself
				conttype = syntax_GetChild(syntax_GetChild(vartype, 0), 0);

				//Check if we use arrow...
				subtree = syntax_GetChild(tree, addrop + 2*idx - 1);
				if( subtree->tok.type == TOK_ARROW )
				{
						//Not a pointer!
						if( syntax_CountChilds(conttype) != 2 )
						{
								codegen_reportError(cg, "Deref with '->' implies a pointer.",
										subtree->tok);
								return 0;
						}

						//Dereference struct
						codegen_emit(cg, "\tmovl\t(%eax), %eax\n");
				}
				else
				{
						//A pointer!
						if( syntax_CountChilds(conttype) > 1 )
						{
								codegen_reportError(cg, "Deref with '.' implies non-pointer.",
										subtree->tok);
								return 0;
						}
				}


				//Container-variable is in varNode
				//The variable we want to resolve to is in syntax_GetChild(tree,idx)
				subtree = syntax_GetChild(tree, addrop + 2*idx);
				membername = subtree->tok;

				//Get containing variable 
				offset = type_GetMemberOffset(symtab, conttype, membername);

				//Error accessing member
				if( offset < 0 )
				{
					codegen_reportError(cg, "Error when accessing member.", subtree->tok);
					return 0;
				}

				
				//Add offset to eax
				sprintf(result, "\taddl\t$%d, %%eax\n", offset);
				codegen_emit(cg, result);


				//Get declaration of member
				vartype = type_GetMemberDeclaration(symtab, conttype, membername);

				//Goto next resolution
				idx = idx+1;
		}


		//Result addr is in eax
		strcpy(result, "%eax");

		return vartype;
}



/**
 * This method evaluates the address of the element which is described by the
 * <variable_expr> in tree. An '&' on the left side is reported as an error.
 * If the last struct-resulution leads to an array, an index-specifier must
 * be given. If it does not lead to an array, an index-specifier is not allowed.
 */
syntaxTreeNode* codegen_EmitVarExprAdress( codegen* cg, syntaxTreeNode* tree, char* result)
{
		int cnt;
		int cntresol;
		int idxspec;
		int addrop;
		int arrelmsize;
		int isarray;

		syntaxTreeNode* subtree;
		syntaxTreeNode* vardef;
		syntaxTreeNode* type;
		symbolTable* symtab;


		symtab = cg->parse->symTable;

		//Count tokens and resolutions
		cnt = syntax_CountChilds(tree);
		cntresol = type_CountVarexprResolutions(tree);

		//Check if idxspec is present
		subtree = syntax_GetChild(tree,cnt-1);
		if( subtree->tok.type == TOK_RECPAR_END )
			idxspec = 1;
		else
			idxspec = 0;

		//Check if derefspec is present
		subtree = syntax_GetChild(tree,0);
		if( subtree->tok.type != TOK_IDENT )
			addrop = 1;
		else
			addrop = 0;


		//Evaluate the index and push result on stack
		if( idxspec )
		{
				//Evaluate and cast index
				subtree = syntax_GetChild(tree,cnt-1);
				type = codegen_EmitLogExpr(cg, syntax_GetChild(tree,cnt-2), result);
				type = codegen_CastToInt(cg, subtree->tok, result, type);
				syntax_FreeSyntaxTree(type);

				//Save index on stack
				codegen_emit(cg, "\tpushl\t");
				codegen_emit(cg, result);
				codegen_emit(cg, "\n");
		}


		//Emit the start address of the nested variable
		vardef = codegen_EmitStartAddrOfNestedVar( cg, tree, result);

		//Nothing there
		if( vardef == 0)
			return 0;

		//Check if we deal with array
		if( type_IsAArrayVar(vardef) )
			isarray = 1;
		else
			isarray = 0;


		//If result not in eax --> move it to
		if( strcmp(result, "%eax") != 0)
		{
				codegen_emit(cg, "\tmovl\t");
				codegen_emit(cg, result);
				codegen_emit(cg, ", %eax\n");
		}


		//There has been a index-spec and the index is on the stack
		if( idxspec)
		{
				//Get size of element
				arrelmsize = type_GetArrayElmSize(symtab, vardef);

				//Problem!
				if( arrelmsize < 0 )
				{
						subtree = syntax_GetChild(tree, cnt-1);
						codegen_reportError(cg, "Can't get array-element of expression.", subtree->tok);
						return 0;
				}

				//If pointer (non-array) de-reference before! Pointer contains
				//address of array (first element)
				if( !isarray )
						codegen_emit(cg, "\tmovl\t(%eax), %eax\n");

				//Get index of index-spec to %esi
				codegen_emit(cg, "\tpopl\t%esi\n");

				//If array element size is not 1 --> multiply index with size
				if( arrelmsize != 1)
				{
					sprintf(result, "\timull\t$%d, %%esi\n", arrelmsize);
					codegen_emit(cg, result);
				}

				//Add offset of index to addr of variable
				codegen_emit(cg, "\taddl\t%esi, %eax\n");

				//Create type of elements and clear is-array-flag
				type = type_CreateArrayElmType(vardef);
				isarray = 0;
		}
		else
		{
				//Just create type, finished
				type = type_CreateType(vardef);
		}


		//From now on we have
		//  - in type the newly created type
		//  - in %eax the address of the element we wanted
		//  - in isarray an flag if we deal with an array
		

		//Now check the address-operator...
		subtree = syntax_GetChild(tree,0);
		//Here is the result saved...
		strcpy(result, "%eax");


		//Get-address operator in front
		if( subtree->tok.type == TOK_AND )
		{
				//Can't get address of var-expr where an address op is in front.
				codegen_reportError(cg, "Can't get address of variable-expr with address operator.\n", subtree->tok);
				syntax_FreeSyntaxTree(type);
				return 0;
		}

		//No addr-operator in front
		else if( subtree->tok.type == TOK_IDENT )
		{
				//We deal with an array
				if( isarray )
				{
						//Can't get address of array
						codegen_reportError(cg, "Can't get address of array.\n", subtree->tok);
						syntax_FreeSyntaxTree(type);
						return 0;
				}

				//Finished, address is already in %eax
		}

		//De-reference operator in front
		else //if( subtree->tok.type == TOK_STAR)
		{
				//No pointer!?
				if( ! type_IsAPointerType(type) || isarray )
				{
						codegen_reportError(cg, "Can only de-reference a pointer!\n", subtree->tok);
						syntax_FreeSyntaxTree(type);
						return 0;
				}


				//Get the address IN the pointer to eax (which will be de-referenced in a few lines)
				codegen_emit(cg, "\tmovl\t(%eax), %eax\n");

				//Remove the pointer
				subtree = type_RemoveStarFromType(type);
				syntax_FreeSyntaxTree(type);
				type = subtree;			
		}


		return type;
}



syntaxTreeNode* codegen_EmitFastVariableExpr( codegen* cg, syntaxTreeNode* tree, char* result)
{
		// We handle the following cases:
		//
		// a
		//		--> Single variable, global, local or parameter
		//
		// arrays are a problem, because we would have to set %esi before

		int cnt;
		int cntresol;
		int idxspec;
		int addrop;

		symbolTableNode* varNode;
		syntaxTreeNode* subtree;
		syntaxTreeNode* vardef;
		syntaxTreeNode* type;
		symbolTable* symtab;
		

		
		symtab = cg->parse->symTable;

		//Count tokens and resolutions
		cnt = syntax_CountChilds(tree);
		cntresol = type_CountVarexprResolutions(tree);

		//Check if idxspec is present
		subtree = syntax_GetChild(tree,cnt-1);
		if( subtree->tok.type == TOK_RECPAR_END )
			idxspec = 1;
		else
			idxspec = 0;

		//Check if derefspec is present
		subtree = syntax_GetChild(tree,0);
		if( subtree->tok.type != TOK_IDENT )
			addrop = 1;
		else
			addrop = 0;

		
		//Get type of (first variable of nested expr of)  tree
		subtree = syntax_GetChild(tree, addrop);
		varNode = symbol_FindVariable(symtab, subtree->tok );

		//Unknown variable
		if( varNode == 0 )
				return 0;


		vardef = varNode->structure;
		type = type_CreateType(varNode->structure);




		//Expressions like 'a'. 
		if( addrop==0 && idxspec==0 && cntresol==1 && !type_IsAArrayVar(vardef) &&
			!type_IsAStructType(type) )
		{
				//Local or global
				if( varNode->type == SYMBOL_TYPE_PARVAR || varNode->type == SYMBOL_TYPE_LOCALVAR )
						sprintf(result, "%d(%%ebp)", symbol_GetNonGlobalOffset(symtab, varNode));
				else
						sprintf(result, "symtab+%d", symbol_GetGlobalOffset(symtab, varNode));

				return type;
		}



		syntax_FreeSyntaxTree(type);
		return 0;
}


syntaxTreeNode* codegen_EmitVariableExpr( codegen* cg, syntaxTreeNode* tree, char* result)
{
		/*
		 * We use the following semantics. Lets say we have a tree which represents the
		 * following variable expression: addr-mod a->b.c->d index-spec. So addr-mod
		 * might be & or * and index-spec is something like [4].
		 *
		 * 1. Move the startaddr of a->b.c->d into eax.
		 * 2. If idx-sepc is present:
		 * 		add to the startaddr the corresponding value.
		 *
		 *      if d is an array: remove array-flag
		 *      if d is a pointer: 
		 *      otherwise: error
		 *
		 * 3. Check addr-mod
		 * 		if &: check for non-array!
		 * 		if nothing: 
		 * 			if struct-inst: return addr
		 * 			if array:		change to pointer type
		 * 			otherwise:		de-reference
		 * 		if *:
		 * 			check if pointer!
		 */

		int cnt;
		int cntresol;
		int idxspec;
		int addrop;
		int arrelmsize;
		int isarray;

		syntaxTreeNode* subtree;
		syntaxTreeNode* vardef;
		syntaxTreeNode* type;
		symbolTable* symtab;



		//Enabled optimization
		if( cg->enOptFastassign )
		{
				//Emit fast variable expression for fast assignment
				subtree = codegen_EmitFastVariableExpr(cg, tree, result);

				//Fine. If failed, continue below
				if( subtree != 0)
					return subtree;
		}



		symtab = cg->parse->symTable;

		//Count tokens and resolutions
		cnt = syntax_CountChilds(tree);
		cntresol = type_CountVarexprResolutions(tree);

		//Check if idxspec is present
		subtree = syntax_GetChild(tree,cnt-1);
		if( subtree->tok.type == TOK_RECPAR_END )
			idxspec = 1;
		else
			idxspec = 0;

		//Check if derefspec is present
		subtree = syntax_GetChild(tree,0);
		if( subtree->tok.type != TOK_IDENT )
			addrop = 1;
		else
			addrop = 0;


		//Evaluate the index and push result on stack
		if( idxspec )
		{
				//Evaluate and cast index
				subtree = syntax_GetChild(tree,cnt-1);
				type = codegen_EmitLogExpr(cg, syntax_GetChild(tree,cnt-2), result);
				type = codegen_CastToInt(cg, subtree->tok, result, type);
				syntax_FreeSyntaxTree(type);

				//Save index on stack
				codegen_emit(cg, "\tpushl\t");
				codegen_emit(cg, result);
				codegen_emit(cg, "\n");
		}


		//Emit the start address of the nested variable
		vardef = codegen_EmitStartAddrOfNestedVar( cg, tree, result);

		//Nothing there
		if( vardef == 0)
			return 0;

		//Check if we deal with array
		if( type_IsAArrayVar(vardef) )
			isarray = 1;
		else
			isarray = 0;


		//If result not in eax --> move it to
		if( strcmp(result, "%eax") != 0)
		{
				codegen_emit(cg, "\tmovl\t");
				codegen_emit(cg, result);
				codegen_emit(cg, ", %eax\n");
		}


		//There has been a index-spec and the index is on the stack
		if( idxspec)
		{
				//Get size of element
				arrelmsize = type_GetArrayElmSize(symtab, vardef);

				//Problem!
				if( arrelmsize < 0 )
				{
						subtree = syntax_GetChild(tree, cnt-1);
						codegen_reportError(cg, "Can't get array-element of expression.", subtree->tok);
						return 0;
				}

				//If pointer (non-array) de-reference before! Pointer contains
				//address of array (first element)
				if( !isarray )
						codegen_emit(cg, "\tmovl\t(%eax), %eax\n");


				//Get index of index-spec to %esi
				codegen_emit(cg, "\tpopl\t%esi\n");

				//If array element size is not 1 --> multiply index with size
				if( arrelmsize != 1)
				{
					sprintf(result, "\timull\t$%d, %%esi\n", arrelmsize);
					codegen_emit(cg, result);
				}

				//Add offset of index to addr of variable
				codegen_emit(cg, "\taddl\t%esi, %eax\n");

				//Create type of elements and clear is-array-flag
				type = type_CreateArrayElmType(vardef);
				isarray = 0;
		}
		else
		{
				//Just create type, finished
				type = type_CreateType(vardef);
		}


		//From now on we have
		//  - in type the newly created type
		//  - in %eax the address of the element we wanted
		//  - in isarray an flag if we deal with an array
		

		//Now check the address-operator...
		subtree = syntax_GetChild(tree,0);
		//Here is the result saved...
		strcpy(result, "%eax");


		//Get-address operator in front
		if( subtree->tok.type == TOK_AND )
		{
				//Oh, array, fuck.
				if( isarray )
				{
					codegen_reportError(cg, "Can't get address of an array, only from elements.\n", subtree->tok);
					return 0;
				}

				//Just add star to type
				subtree = type_AddStarToType(type);
				syntax_FreeSyntaxTree(type);
				type = subtree;
		}

		//No addr-operator in front
		else if( subtree->tok.type == TOK_IDENT )
		{
				//We deal with an array
				if( isarray )
				{
						//So we add a star to the existing type and by this
						//we converted the array 'type arr[x]' to a pointer 'type* arr'
						subtree = type_AddStarToType(type);
						syntax_FreeSyntaxTree(type);
						type = subtree;
				}
				//We deal with a struct
				else if( type_IsAStructType(type) )
				{
						//Do nothing -- structs are handled via their address
				}
				//In all other cases: pointers, int, chars we have to dereference to
				//get the value of...
				else if( type_IsLongSized( type ) )
				{
						codegen_emit(cg, "\tmovl\t(%eax), %eax\n");
				}
				else if( type_IsByteSized( type ) )
				{
						codegen_emit(cg, "\tmovb\t(%eax), %al\n");
						strcpy(result, "%al");
				}
				else
				{
						//Unhandled case!
						codegen_reportError(cg, "Internal Error: Unhandled case in codegen_EmitVariableExpr!\n", 
							subtree->tok);
						return 0;
				}
		}

		//De-reference operator in front
		else //if( subtree->tok.type == TOK_STAR)
		{
				//No pointer!?
				if( ! type_IsAPointerType(type) || isarray )
				{
						codegen_reportError(cg, "Can only de-reference a pointer!\n", subtree->tok);
						return 0;
				}


				//Get the address IN the pointer to eax (which will be de-referenced in a few lines)
				codegen_emit(cg, "\tmovl\t(%eax), %eax\n");

				//Remove the pointer --> get new type...
				subtree = type_RemoveStarFromType(type);
				syntax_FreeSyntaxTree(type);
				type = subtree;


				//We deal with a struct
				if( type_IsAStructType(type) )
				{
						//Do nothing -- structs are handled via their address
				}
				//In all other cases: pointers, int, chars we have to dereference to
				//get the value of...
				else if( type_IsLongSized( type ) )
				{
						codegen_emit(cg, "\tmovl\t(%eax), %eax\n");
				}
				else if( type_IsByteSized( type ) )
				{
						codegen_emit(cg, "\tmovb\t(%eax), %al\n");
						strcpy(result, "%al");
				}
				else
				{
						//Unhandled case!
						codegen_reportError(cg, "Internal Error: Unhandled case in codegen_EmitVariableExpr!\n", 
							subtree->tok);
						return 0;
				}
		}

		return type;
}


/**Here result is the empty string if void is return type*/
syntaxTreeNode* codegen_EmitFuncCall( codegen* cg, syntaxTreeNode* tree, char* result )
{
		symbolTable* symtab;
		symbolTableNode* node;
		syntaxTreeNode* funcname;	
		syntaxTreeNode* dummytype;	
		syntaxTreeNode* rettype;	
		syntaxTreeNode* argtype;	
		syntaxTreeNode* type;	
		syntaxTreeNode* subtree;	
		int argsizesum;
		int offset;
		int idx;
		int cnt;
		char tmpres[CODEGEN_MAXLINE_SIZE];
		char tmpres2[CODEGEN_MAXLINE_SIZE];
		char tmp [CODEGEN_MAXLINE_SIZE];



		//Some initial declarations
		symtab = cg->parse->symTable;
		funcname = syntax_GetChild(tree,0);
		node = symbol_FindFunction(symtab, funcname->tok);

		//Aha! Function not declared
		if( node == 0)
		{
				codegen_reportError(cg, "Calling unknown function.", funcname->tok);
				strcpy(result, "%eax");
				return 0;
		}

		//Get size of arguments and adapt stack
		argsizesum = symbol_Sizeof_FunctionArgs(symtab, node->structure);
		sprintf(result, "\tsubl\t$%d, %%esp\n", argsizesum);
		codegen_emit(cg, result);

		offset = 0;
		idx = 0;
		cnt = symbol_CountFunctionArgs(symtab, node->structure);


		//syntax: typed-ident ( arg1 , arg 2 , ... , argn )
		if( (syntax_CountChilds(tree) -2)/2 != cnt)
		{
				codegen_reportError(cg, "Invalid argument number!", funcname->tok);
				strcpy(result, "%eax");
				return 0;
		}


		while( idx < cnt)
		{
				argtype = symbol_GetFunctionArg(symtab, node->structure, idx);
				argtype = syntax_GetChild( syntax_GetChild( argtype, 0), 0);

				//Evaluate value
				type = codegen_EmitLogExpr(cg, syntax_GetChild(tree, 2*idx+2), result);
				codegen_EmitAvoidIndirect( cg, result, type);

				//Check if casting is ok
				subtree = syntax_GetChild(tree, 2*idx+1);
				codegen_CheckCasting(cg, argtype, type, subtree->tok);

				
				//Argument ist .long typed
				if( type_IsLongSized( argtype ) )
				{
						//Convert to integer
						type = codegen_CastToInt(cg, subtree->tok, result, type);

						sprintf(tmp, "\tmovl\t%%s, %d(%%%%esp)\n", offset);
						sprintf(tmpres, tmp, result);
						codegen_emit(cg, tmpres);
				}
				//Argument ist .byte typed
				else if( type_IsByteSized( argtype ) )
				{
						//Convert to integer
						type = codegen_CastToChar(cg, subtree->tok, result, type);

						sprintf(tmp, "\tmovb\t%%s, %d(%%%%esp)\n", offset);
						sprintf(tmpres, tmp, result);
						codegen_emit(cg, tmpres);
				}
				//Aha, a struct
				else if( type_IsAStructType(argtype) )
				{
					//Find free register
					if( strcmp(result, "%eax")==0)
						strcpy(tmpres, "%ebx");
					else
						strcpy(tmpres, "%eax");

					//Calculate place where to place struct-instance on stack-space
					codegen_emit(cg, "\tmovl\t%esp, ");
					codegen_emit(cg, tmpres);
					codegen_emit(cg, "\n");
					
					//Add offset to stack pointer
					sprintf(tmp, "\taddl\t$%d, %%s\n", offset);
					sprintf(tmpres2, tmp, tmpres);
					codegen_emit(cg, tmpres2);

					//Copy junk of memory, namely the struct-instance
					codegen_EmitCopyJunk(cg, tmpres, result, symbol_Sizeof_DataType(symtab, argtype));
				}
				else
				{
					//Unhandled case!
					codegen_reportError(cg, "Internal Error: Unhandled case in function call.\n",
							funcname->tok);
				}

				syntax_FreeSyntaxTree(type);
				offset = offset + symbol_Sizeof_DataType(symtab, argtype);
				idx = idx+1;
		}

		

		codegen_emit(cg, "\tcall\t");
		codegen_emit(cg, funcname->tok.content);
		codegen_emit(cg, "\n");

		//Restore stack pointer
		sprintf(result, "\taddl\t$%d, %%esp\n", argsizesum);
		codegen_emit(cg, result);


		//The result was in %eax
		strcpy(result, "%eax");
		rettype = symbol_GetReturnType(symtab, node->structure);


		//Cast to char...
		if( type_IsByteSized(rettype) )
		{
				//Cast result to char
				dummytype = codegen_CreateIntType();
				dummytype = codegen_CastToChar(cg, funcname->tok, result, dummytype);
				syntax_FreeSyntaxTree(dummytype);
		}


		//Create copy of return type
		return type_CreateType(node->structure);
}







