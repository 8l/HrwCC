/**
 * Implements the symbol table
 */


#include "symbolTable.h"

#include "../include/hrwcccomp.h"


/**This macro implements the functions of the list of symbolTable*/
IMPLEMENT_LIST( symbolTableNode_List, symbolTableNode)




/** Report error of symbol table. */
void symbol_reportError( symbolTable* table, char* errstr, token name)
{
		char* filename;

		//Increment error counter
		table->cnterrors = table->cnterrors +1;

		//Get filename
		filename = preproc_getFilename( table->parse->scan->pp, name.pos_fileid);


		//Print the error messages
		printf("SYMTAB_ERROR: %d, ", table->parse->curr->pos_col);
		printf("%d, ", table->parse->curr->pos_line);
		
		if( filename )
			printf("%s:\n", filename);
		else
			printf("[ERR filename] (%p)\n", filename);

		printf("\tToken is '%s' ::   ", name.content);
		printf("%s\n", errstr);

}


/** Test if signature of these two functions are equal */
int symbol_EqualSignature( symbolTable* table, syntaxTreeNode* struct1, syntaxTreeNode* struct2)
{		
		int cntarg;
		int idx;
		syntaxTreeNode* arg1;
		syntaxTreeNode* arg2;



		//Test return value and name of function
		if( !syntax_EqualTrees( syntax_GetChild(struct1,0), syntax_GetChild(struct2,0) ) )
			return 0;


		//Count argument number
		cntarg = symbol_CountFunctionArgs(table, struct1);

		//Number of arguments unequal
		if( cntarg != symbol_CountFunctionArgs(table, struct2))
			return 0;

		
		idx = 0;
		//Compare all arguement-types
		while( idx < cntarg )
		{
				arg1 = symbol_GetFunctionArg(table, struct1, idx);
				arg2 = symbol_GetFunctionArg(table, struct2, idx);

				//Get data types
				arg1 = syntax_GetChild( arg1, 0);
				arg2 = syntax_GetChild( arg2, 0);

				//Not equal
				if( !syntax_EqualTrees( arg1, arg2) )
					return 0;


				//Cmp next argument
				idx = idx+1;
		}

		return 1;
}


/** Get the integer value of number token */
int symbol_ToInt( symbolTable* table, token tok)
{
		if( tok.type != TOK_NUMBER )
		{
				symbol_reportError( table, 
					"Internal error: Can't get integer value of non-number token.", tok);
				return -1;
		}

		return atoi(tok.content);
}


/** Add symbol in symbol table */
void symbol_AddSymbol( symbolTable* table, token name, int type, syntaxTreeNode* structure )
{
		symbolTableNode* node;

#ifndef __HRWCC__
		node = (symbolTableNode*) malloc( sizeof(symbolTableNode) );
#endif
#ifdef __HRWCC__
		node =  malloc( sizeof(symbolTableNode) );
#endif

		//Set members
		node->name = name;
		node->type = type;
		node->structure = structure;

		//Add the node as symbol
		Add_To_Back_Of_symbolTableNode_List( &table->list, node);
}






/**Create a symbol table*/
void symbol_CreateSymbolTable( parser* parser, symbolTable* table)
{
		//set members
		table->parse = parser;
		table->cnterrors = 0;

		Clear_symbolTableNode_List( &table->list );
}


/** Delete symbol table */
void symbol_destroy( symbolTable* table)
{
		symbolTableNode* node;
		symbolTableNode* next;

		node = Get_Front_Of_symbolTableNode_List(&table->list);

		while( node != 0 )
		{
				next = Get_Next_In_symbolTableNode_List( node );
				free( node );
				node = next;
		}

		Clear_symbolTableNode_List(&table->list);
}


/** Count the number of entries in symtable */
int symbol_CountEntries(symbolTable* table)
{
		int cnt;
		symbolTableNode* node;

		//Begin at start...
		node = Get_Front_Of_symbolTableNode_List(&table->list);
		cnt = 0;

		//...and count elements
		while( node != 0)
		{
				node = Get_Next_In_symbolTableNode_List( node);
				cnt = cnt+1;
		}

		return cnt;
}


/** Get the idx-th entry*/
symbolTableNode* symbol_GetEntry(symbolTable* table, int idx)
{
		int cnt;
		symbolTableNode* node;

		//Begin at start...
		node = Get_Front_Of_symbolTableNode_List(&table->list);
		cnt = 0;

		//...and count elements
		while( idx > cnt )
		{
				//Aha!, no element available
				if( node == 0)
					return 0;

				node = Get_Next_In_symbolTableNode_List( node);
				cnt = cnt+1;
		}

		return node;
}


/** Print symbol table */
void symbol_printTable( symbolTable* table)
{
		symbolTableNode* node;

		node = Get_Front_Of_symbolTableNode_List(&table->list);

		while( node != 0)
		{
				printf("  Type: %d", node->type);
				printf(",   Size: %3d", symbol_Sizeof_Symbol(table, node));
				printf(",   Name: %10s,   ", node->name.content);

				if( node->type == SYMBOL_TYPE_PARVAR || node->type == SYMBOL_TYPE_LOCALVAR )
						printf("Offset: %d\n", symbol_GetNonGlobalOffset(table, node));
				else if( node->type == SYMBOL_TYPE_GLOBALVAR || node->type == SYMBOL_TYPE_STRING )
						printf("Offset: %d\n", symbol_GetGlobalOffset(table, node));
				else
					puts("");

				//Goto next node
				node = Get_Next_In_symbolTableNode_List( node);
		}

		printf("  global-, param-, local-blocksize: %d", symbol_GetGlobalsBlockSize(table) );
		printf(", %d", symbol_GetParameterBlockSize(table));
		printf(", %d\n", symbol_GetLocalVarBlockSize(table) );
}



/** Find a symbol by name and type */
symbolTableNode* symbol_FindTypedSymbol (symbolTable* table, token name, int type )
{
		symbolTableNode* node;

		node = Get_Front_Of_symbolTableNode_List(&table->list);

		while( node != 0)
		{
				//Node with right name and type -- return it
				if( node->type == type &&
					strcmp( name.content, node->name.content)==0 )
					return node;

				//Goto next node
				node = Get_Next_In_symbolTableNode_List( node);
		}

		//Not found
		return 0;
}



/** Find global variable by name */
symbolTableNode* symbol_FindGlobalVariable( symbolTable* table, token name)
{
		return symbol_FindTypedSymbol( table, name, SYMBOL_TYPE_GLOBALVAR);
}

/** Find local variable or parameter by name */
symbolTableNode* symbol_FindNonGlobalVariable( symbolTable* table, token name)
{
		symbolTableNode* symbol;

		//Find a local variable
		symbol = symbol_FindTypedSymbol( table, name, SYMBOL_TYPE_LOCALVAR);

		//Otherwise try to find parameter
		if(symbol == 0)
			symbol = symbol_FindTypedSymbol( table, name, SYMBOL_TYPE_PARVAR);

		return symbol;
}

/** Find a variable by its name. First local, than global. */
symbolTableNode* symbol_FindVariable (symbolTable* table, token name )
{
		symbolTableNode* symbol;

		//Find a non-global variable
		symbol = symbol_FindNonGlobalVariable( table, name );

		//Otherwise try to find a global variable
		if(symbol == 0)
			symbol = symbol_FindGlobalVariable( table, name);

		return symbol;

}

/** Find a function signature by its name. First definition, than declaration */
symbolTableNode* symbol_FindFunction (symbolTable* table, token name )
{
		symbolTableNode* symbol;

		//Find a non-global variable
		symbol = symbol_FindTypedSymbol( table, name, SYMBOL_TYPE_FUNCTIONDEF );

		//Otherwise try to find a global variable
		if(symbol == 0)
			symbol = symbol_FindTypedSymbol( table, name, SYMBOL_TYPE_FUNCTIONDECL );

		return symbol;
}

/** Find a struct definition by its name */
symbolTableNode* symbol_FindStruct (symbolTable* table, token name )
{
		return symbol_FindTypedSymbol( table, name, SYMBOL_TYPE_STRUCTDECL);
}

/** Find a string by its content */
symbolTableNode* symbol_FindString (symbolTable* table, token string)
{
		return symbol_FindTypedSymbol( table, string, SYMBOL_TYPE_STRING);
}




/** Define a global variable */
int symbol_DefineGlobalVariable (symbolTable* table, syntaxTreeNode* structure)
{
		token name;
		syntaxTreeNode* nametok;


		nametok = syntax_GetChild(structure, 0);
		nametok = syntax_GetChild(nametok, 1);
		name = nametok->tok;

		//Highlander-semantic.
		if( symbol_FindVariable( table, name ) != 0)
		{
			symbol_reportError(table, "Redefinition of global variable not allowed.", name);
			return -1;
		}

		//Test for types
		if( symbol_Sizeof_Vardecl(table, structure) < 0)
			return -1;


		//Add the symbol to table
		symbol_AddSymbol( table, name, SYMBOL_TYPE_GLOBALVAR, structure );

		return 0;
}

/** Define a local variable */
int symbol_DefineLocalVariable (symbolTable* table, syntaxTreeNode* structure)
{
		symbolTableNode* prev;
		token name;
		syntaxTreeNode* nametok;


		nametok = syntax_GetChild(structure, 0);
		nametok = syntax_GetChild(nametok, 1);
		name = nametok->tok;
		
		//Get a pre-exising variable
		prev = symbol_FindVariable( table, name ); 

		//Highlander-semantic.
		if( prev != 0  &&  prev->type != SYMBOL_TYPE_GLOBALVAR )
		{
			symbol_reportError(table, "Redefinition of local variable not allowed.", name);
			return -1;
		}

		//Test for types
		if( symbol_Sizeof_Vardecl(table, structure) < 0)
			return -1;


		//Add the symbol to table
		symbol_AddSymbol( table, name, SYMBOL_TYPE_LOCALVAR, structure );

		return 0;

}

/** Defina a parameter --> this implies local, what else. */
int symbol_DefineParVariable (symbolTable* table, syntaxTreeNode* structure)
{
		symbolTableNode* prev;
		token name;
		syntaxTreeNode* nametok;

		//Get name of parameter
		nametok = syntax_GetChild(syntax_GetChild(structure,0), 1);
		name = nametok->tok;

		//Get a pre-exising variable
		prev = symbol_FindVariable( table, name ); 

		//Highlander-semantic.
		if( prev != 0  &&  prev->type != SYMBOL_TYPE_GLOBALVAR )
		{
			symbol_reportError(table, "Two parameters with equal names.", name);
			return -1;
		}

		//Test for types
		if( symbol_Sizeof_DataType(table, syntax_GetChild(syntax_GetChild(structure,0),0)) < 0)
			return -1;


		//Add the symbol to table
		symbol_AddSymbol( table, name, SYMBOL_TYPE_PARVAR, structure );

		return 0;

}

/** Define a structure */
int symbol_DefineStruct (symbolTable* table, syntaxTreeNode* structure)
{
		token name;
		syntaxTreeNode* nametok;
		int cntmembers;
		int idx;
		int curr;
		syntaxTreeNode* memb1;
		syntaxTreeNode* memb2;


		//Get name of parameter
		nametok = syntax_GetChild(structure, 1);
		name = nametok->tok;

		//Highlander-semantic.
		if( symbol_FindStruct( table, name ) != 0)
		{
			symbol_reportError(table, "Redefinition of struct not allowed.", name);
			return -1;
		}

		//Error occured
		if( symbol_Sizeof_Structdef( table, structure) < 0 )
			return -1;


		//Count the members
		cntmembers = symbol_CountStructEntries(table, structure);
		curr = 1;

		//Check for all members, if they are named uniquely
		while( curr<cntmembers )
		{
				//Get first members name
				memb1 = symbol_GetStructEntry(table, structure, curr);
				memb1 = syntax_GetChild(memb1, 0);
				memb1 = syntax_GetChild(memb1, 1);

				//Search in already-scanned
				idx=0;
				while( idx<curr )
				{						
					memb2 = symbol_GetStructEntry(table, structure, idx);
					memb2 = syntax_GetChild(memb2, 0);
					memb2 = syntax_GetChild(memb2, 1);

					//Oh, same name!
					if( strcmp(memb1->tok.content, memb2->tok.content) == 0)
							symbol_reportError(table, "Members name is not unique.\n", memb1->tok);

					idx = idx+1;
				}

				//Goto next entry
				curr = curr+1;
		}



		//Add the symbol to table
		symbol_AddSymbol( table, name, SYMBOL_TYPE_STRUCTDECL, structure );

		return 0;

}

/** Declare a function */
int symbol_DeclareFunction (symbolTable* table, syntaxTreeNode* structure)
{
		token name;
		syntaxTreeNode* nametok;
		syntaxTreeNode* arg;
		syntaxTreeNode* subtree;
		symbolTableNode* knownfunc;
		int idx;
		int cntargs;



		nametok = syntax_GetChild(structure, 0);
		nametok = syntax_GetChild(nametok, 1);
		name = nametok->tok;

		//Find pre-existing declaration
		knownfunc = symbol_FindFunction( table, name );

		
		//If there are already definitions or declarations
		//the must have the same signature.
		if( knownfunc != 0)
		{
			//This if signature is different
			if( ! symbol_EqualSignature(table, structure, knownfunc->structure) )
			{
				symbol_reportError(table, 
					"Function already known with different signature.", name);
				return -1;
			}

			//Tested for signature ok --> nothing to do
			return 0;
		}



		//Check for all arguments, if they are correct typed
		cntargs = symbol_CountFunctionArgs(table, structure);
		idx = 0;

		while( idx < cntargs )
		{
			arg =  symbol_GetFunctionArg(table, structure, idx);

			//Problem at data type
			if( symbol_Sizeof_Vardecl(table,arg) < 0)
			{
				subtree = syntax_GetChild(syntax_GetChild(arg,0),1);
				symbol_reportError(table, 
					"Function-argument has invalid size.", subtree->tok);

				return -1;
			}

			idx = idx+1;
		}


		//If not void, test it
		if( !symbol_IsReturnTypeVoid(table, structure) )
		{
			//Check for return type
			arg = symbol_GetReturnType(table, structure);
			if( symbol_Sizeof_DataType(table,arg) < 0 )
				return -1;

			//Check for return-type is struct-type
			if( syntax_CountChilds(arg) == 1 )
			{
					//OH, oh!
					arg = syntax_GetChild(arg, 0);
					if( arg->tok.type == TOK_IDENT )
					{
							symbol_reportError(table, "A struct as return-type is not supported!\n",
									arg->tok);
							return -1;
					}
			}
		}


		//Add the symbol to table
		symbol_AddSymbol( table, name, SYMBOL_TYPE_FUNCTIONDECL, structure );

		return 0;
}



/** Define a function and add all parameters */
int symbol_DefineFunction (symbolTable* table, syntaxTreeNode* structure)
{
		token name;
		syntaxTreeNode* nametok;
		syntaxTreeNode* arg;
		symbolTableNode* knownfunc;
		int idx;
		int cntargs;

		nametok = syntax_GetChild(structure, 0);
		nametok = syntax_GetChild(nametok, 1);
		name = nametok->tok;

		//Find pre-existing declaration
		knownfunc = symbol_FindFunction( table, name );


		//If there are already definitions or declarations
		// - definitions are not allowed
		// - declarations must have the same signature
		if( knownfunc != 0)
		{
			//Function was already defined!
			if( knownfunc->type == SYMBOL_TYPE_FUNCTIONDEF )
			{
				symbol_reportError(table, 
					"Redefinition of function is not allowed.", name);
				return -1;

			}

			//So it was a declaration

			//This if signature is different
			if( ! symbol_EqualSignature(table, structure, knownfunc->structure) )
			{
				symbol_reportError(table, 
					"Function already known with different signature.", name);
				return -1;
			}
		}


		//Add all parameters to symbol table
		cntargs = symbol_CountFunctionArgs(table, structure);
		idx = 0;

		while( idx < cntargs )
		{
			arg =  symbol_GetFunctionArg(table, structure, idx);

			//Problem at defining parameters
			if( symbol_DefineParVariable(table, arg) == -1 )
			{
					symbol_ClearNonGlobalVariables(table);
					return -1;
			}

			idx = idx+1;
		}

		
		
		//If not void, test it
		if( !symbol_IsReturnTypeVoid(table, structure) )
		{

			//Check for return type
			arg = symbol_GetReturnType(table, structure);
			if( symbol_Sizeof_DataType(table,arg) < 0 )
				return -1;

			//Check for return-type is struct-type
			if( syntax_CountChilds(arg) == 1 )
			{
					//OH, oh!
					arg = syntax_GetChild(arg, 0);
					if( arg->tok.type == TOK_IDENT )
					{
							symbol_reportError(table, "A struct as return-type is not supported!\n",
									arg->tok);
							return -1;
					}
			}
		}




		//Add the symbol to table
		symbol_AddSymbol( table, name, SYMBOL_TYPE_FUNCTIONDEF, structure );

		return 0;

}


/** Define a string (if not already defined) */
int symbol_DefineString( symbolTable* table, syntaxTreeNode* structure)
{
		//Check if we deal with a string
		if( symbol_Sizeof_String(table, structure) < 0 )
			return -1;

		//Highlander semantic
		if( symbol_FindString( table, structure->tok ) != 0 )
			return 0;

		//Add it
		symbol_AddSymbol(table, structure->tok, SYMBOL_TYPE_STRING, structure);

		return 0;
}



/** Removea all non-global variables */
void symbol_ClearNonGlobalVariables(symbolTable* table)
{
		symbolTableNode* node;
		symbolTableNode* rmnode;


		node = Get_Back_Of_symbolTableNode_List(&table->list);

		while( node != 0)
		{
				//Remember node to remove
				rmnode = node;

				//Goto next node
				node = Get_Prev_In_symbolTableNode_List( node);

				//rmnode is non-global variable --> remove it
				if( rmnode->type == SYMBOL_TYPE_LOCALVAR || 
					rmnode->type == SYMBOL_TYPE_PARVAR )
				{
					Remove_From_symbolTableNode_List(&table->list, rmnode);
					free(rmnode);
				}

		}
}


/** Calculate the size of variable which is declared by var_decl syntax-sub-tree */
int symbol_Sizeof_Vardecl( symbolTable* table, syntaxTreeNode* var_decl)
{
		syntaxTreeNode* datatype;
		syntaxTreeNode* arraysizetree;
		int arraysize;
		int childsize;

		//printf("Scanning var_decl: %p\n", var_decl);
		//syntax_printTree( var_decl);


		//Get data type
		datatype = syntax_GetChild( var_decl, 0);
		datatype = syntax_GetChild( datatype, 0);
		

		//Get size of base type
		childsize = symbol_Sizeof_DataType( table, datatype);

		//More than typed_ident and semicolon --> array specifier
		if( syntax_CountChilds( var_decl ) > 2 )
		{
				if( syntax_CountChilds( var_decl) != 5 )
				{
						symbol_reportError(table, 
							"Internal Error: var_decl should have 5 tokens", datatype->tok);
						return -1;
				}


				//Size of array
				arraysizetree = syntax_GetChild( var_decl, 2 );
				arraysize = symbol_ToInt(table, arraysizetree->tok);

				if( arraysize < 0 )
						return -1;

				//Multiply childsize with the array size
				childsize = childsize * arraysize;
		}

		return childsize;
}


/** Calculate the size of data_type syntax-sub-tree (amount of bytes) */
int symbol_Sizeof_DataType(symbolTable* table, syntaxTreeNode* data_type)
{
		int cntToken;
		token typeTok;

		symbolTableNode* structnode;
		syntaxTreeNode* subtree;


		//printf("Scanning data_type: %p\n", data_type);
		//syntax_printTree( data_type);
		
		cntToken = syntax_CountChilds(data_type);

		//Unluky format
		if( !data_type || cntToken == 0 )
			return -1;
		
		subtree = syntax_GetChild(data_type, 0);
		typeTok = subtree->tok;

		//If there are more than one tokens --> this must be stars
		//--> therefore we have a pointer and the size is known without knowing
		//    the type of which this is a pointer of.
		if( cntToken > 1 )
		{
				//Should be a star token
				subtree =  syntax_GetChild(data_type, 1);
				if( subtree->tok.type != TOK_STAR )
				{
						symbol_reportError(table, "Internal Error: symbol_Sizeof!", 
								subtree->tok);
						return -1;
				}
				
				//Should be a star token
				subtree =  syntax_GetChild(data_type, cntToken-1);
				if( subtree->tok.type != TOK_STAR )
				{
						symbol_reportError(table, "Internal Error: symbol_Sizeof!", 
								subtree->tok);
						return -1;
				}

				//Return size of pointer
				return sizeof(void*);
		}



		if( typeTok.type == TOK_INT )
		{
				return sizeof(int);
		}
		if( typeTok.type == TOK_CHAR )
		{
				return sizeof(char);
		}
		if( typeTok.type == TOK_VOID )
		{
				symbol_reportError(table, "'void' is not a valid type of a variable.", typeTok);
				return -1;
		}
		

		if( typeTok.type != TOK_IDENT)
		{
			symbol_reportError(table, "Internal Error: Invalid type token.", typeTok);
				return -1;
		}


		//Search for an existing struct in symbol table.
		structnode = symbol_FindStruct(table, typeTok);

		if( structnode == 0)
		{
				symbol_reportError(table, "Unknown struct.", typeTok);
				return -1;
		}


		//Return size of struct
		return symbol_Sizeof_Structdef( table,  structnode->structure );
}



/** Get size of struct by its syntax tree */
int symbol_Sizeof_Structdef(symbolTable* table, syntaxTreeNode* structnode)
{
		int structsize;
		int structentries;
		int childsize;
		int idx;

		syntaxTreeNode* vardecl;


		//Size of struct
		structsize = 0;
		//Subtract 'struct' ident '{' '}' ';'
		structentries = symbol_CountStructEntries( table, structnode);
		idx = 0;

		//Run through all entries and determine size
		while( idx < structentries )
		{
				//tmp is of type <var_decl>
				vardecl = symbol_GetStructEntry( table, structnode, idx);

				//The size of the child
				childsize = symbol_Sizeof_Vardecl( table, vardecl );

				//Error occured
				if( childsize <= 0 )
					return -1;
			
				//Add size to struct size
				structsize = structsize + childsize;
				idx = idx+1;
		}

		return structsize;
}



/** Count the number of arguments for the function given by its name-token */
int symbol_CountFunctionArgs( symbolTable* table, syntaxTreeNode* func_decl)
{
		syntaxTreeNode *arglist;

		//Get the argument list
		arglist = syntax_GetChild( func_decl, 1);
		// ( arg1 , arg2 , ... , argn )
		return (syntax_CountChilds(arglist)-1)/2;
}


/** Get the idx-th argument of function given by name-token */
syntaxTreeNode* symbol_GetFunctionArg( symbolTable* table, syntaxTreeNode* func_decl, int idx)
{
		syntaxTreeNode *arglist;

		//Out of bounds
		if( idx >= symbol_CountFunctionArgs(table, func_decl) )
			return 0;
		
		//Get the argument list
		arglist = syntax_GetChild( func_decl, 1);

		// ( arg1 , arg2 , ... , argn )
		return syntax_GetChild( arglist, 1 + 2*idx);
}


/** Get the return type of function given by name-token */
syntaxTreeNode* symbol_GetReturnType( symbolTable* table, syntaxTreeNode* func_decl)
{
		syntaxTreeNode *tmp;

		tmp = syntax_GetChild( func_decl, 0);
		return syntax_GetChild( tmp, 0);
}

/** Test if return type of function with specific name is void */
int symbol_IsReturnTypeVoid( symbolTable* table, syntaxTreeNode* structure )
{
		syntaxTreeNode* retType;

		//Get the return type of function
		retType = symbol_GetReturnType( table, structure);

		//Check if return type is just 'void'
		if( syntax_CountChilds(retType) == 1 )
		{
			retType = syntax_GetChild(retType, 0);

			if( retType->tok.type == TOK_VOID )
				return 1;
		}

		return 0;
}

/** Calc size of string (plus terminating '\0') */
int symbol_Sizeof_String (symbolTable* table, syntaxTreeNode* string)
{
		int len;
		int charcnt;
		int idx;

		//Check if we deal with a string
		if( string->tok.type != TOK_STRING )
		{
			symbol_reportError( table, 
					"Internal Error: Calc string-size of non-string token not allowed.\n", 
					string->tok);
			return -1;
		}

		//Size of "string"
		len =  strlen( string->tok.content);
		idx = 0;
		charcnt = 0;

		//Remove all '\' because '\n' counts for one byte!
		while( 1 )
		{			
				//Esc-sequence --> escape next character
				if( string->tok.content[idx] == '\\' )
					idx = idx+1;

				//End of string --> escape from loop *g
				if( string->tok.content[idx] == '\0' )
					break;

				//New char, increase nmb of characters
				idx = idx+1;
				charcnt = charcnt+1;
		}

		//Calc the size of string and add one for terminator
		//But remove two "
		return charcnt - 1;
}

/** Get size of symbol in symbol table (0 for functions...) */
int symbol_Sizeof_Symbol( symbolTable* table, symbolTableNode* symbol )
{
		//Variable declarations like symbols
		if( symbol->type == SYMBOL_TYPE_LOCALVAR ||
			symbol->type == SYMBOL_TYPE_GLOBALVAR )
		{
			return symbol_Sizeof_Vardecl( table, symbol->structure );
		}

		//Just Datatypes like symbols
		if( symbol->type == SYMBOL_TYPE_PARVAR )
		{
			return symbol_Sizeof_DataType( table, syntax_GetChild(syntax_GetChild(symbol->structure,0),0) );
		}

		//A struct
		if( symbol->type == SYMBOL_TYPE_STRUCTDECL )
			return symbol_Sizeof_Structdef( table, symbol->structure );

		//A string
		if( symbol->type == SYMBOL_TYPE_STRING )
			return symbol_Sizeof_String( table, symbol->structure );

		//Functions don't count
		if( symbol->type == SYMBOL_TYPE_FUNCTIONDECL ||
			symbol->type == SYMBOL_TYPE_FUNCTIONDEF )
			return 0;

		return -1;
}



/** Size of all function arguments together */
int symbol_Sizeof_FunctionArgs( symbolTable *table, syntaxTreeNode* structure)
{
		int cnt;
		int idx;
		int argsize;
		int size;
		syntaxTreeNode* arg;

		idx = 0;
		size = 0;
		cnt = symbol_CountFunctionArgs(table, structure);


		while( idx < cnt)
		{
			arg = symbol_GetFunctionArg(table, structure, idx);
			argsize = symbol_Sizeof_Vardecl(table, arg);

			//Error
			if( argsize < 0)
				return -1;


			//Add overall-size
			size = size+argsize;
			idx = idx+1;
		}


		return size;
}


/** Get sum of sizeofs of all parameter of function */
int symbol_GetParameterBlockSize( symbolTable* table )
{
		symbolTableNode* node;
		int sum;

		node = Get_Front_Of_symbolTableNode_List(&table->list);
		sum = 0;

		while( node != 0)
		{
				//Got a parameter, scan for size
				if( node->type == SYMBOL_TYPE_PARVAR )
					sum = sum + symbol_Sizeof_Symbol(table, node);

				//Goto next node
				node = Get_Next_In_symbolTableNode_List( node);
		}

		return sum;
}


/** Get sum of sizeofs of all local variables of function */
int symbol_GetLocalVarBlockSize( symbolTable* table )
{
		symbolTableNode* node;
		int sum;

		node = Get_Front_Of_symbolTableNode_List(&table->list);
		sum = 0;

		while( node != 0)
		{
				//Got a local variable, scan for size
				if( node->type == SYMBOL_TYPE_LOCALVAR )
					sum = sum + symbol_Sizeof_Symbol(table, node);

				//Goto next node
				node = Get_Next_In_symbolTableNode_List( node);
		}

		return sum;
}


/** Get sum of sizeofs of all global variables and strings */
int symbol_GetGlobalsBlockSize( symbolTable* table )
{
		symbolTableNode* node;
		int sum;

		node = Get_Front_Of_symbolTableNode_List(&table->list);
		sum = 0;

		while( node != 0)
		{
				//Got a global a variable of string
				if( node->type == SYMBOL_TYPE_GLOBALVAR ||
					node->type == SYMBOL_TYPE_STRING )
					sum = sum + symbol_Sizeof_Symbol(table, node);

				//Goto next node
				node = Get_Next_In_symbolTableNode_List( node);
		}

		return sum;
}


/** Get offset of parameter from stack-base-pointer. */
int symbol_GetParameterOffset( symbolTable* table, symbolTableNode* parameter )
{	
		symbolTableNode* node;
		int sum;

		node = Get_Front_Of_symbolTableNode_List(&table->list);
		sum = 0;

		while( node != 0)		
		{
				//Found, break further searching
				if( node == parameter )
					return sum;

				//Got a parameter, scan for size
				if( node->type == SYMBOL_TYPE_PARVAR )
					sum = sum + symbol_Sizeof_Symbol(table, node);

				//Goto next node
				node = Get_Next_In_symbolTableNode_List( node);
		}

		return -1;
}


/** Get offset of local variable from stack-base-pointer. (We do not return the negative value.) */
int symbol_GetLocalVarOffset( symbolTable* table, symbolTableNode* variable )
{
		symbolTableNode* node;
		int sum;

		node = Get_Front_Of_symbolTableNode_List(&table->list);
		sum = 0;

		while( node != 0)		
		{
				//Found, break further searching
				if( node == variable )
					return sum;

				//Got a local variable, scan for size
				if( node->type == SYMBOL_TYPE_LOCALVAR )
					sum = sum + symbol_Sizeof_Symbol(table, node);

				//Goto next node
				node = Get_Next_In_symbolTableNode_List( node);
		}

		return -1;
}


/** Get offset of global variable or string from symbol-table-marker. */
int symbol_GetGlobalOffset( symbolTable* table, symbolTableNode* global )
{
		symbolTableNode* node;
		int sum;

		node = Get_Front_Of_symbolTableNode_List(&table->list);
		sum = 0;

		while( node != 0)
		{
				//Found, break further searching
				if( node == global )
					return sum;

				//Got a global a variable of string
				if( node->type == SYMBOL_TYPE_GLOBALVAR ||
					node->type == SYMBOL_TYPE_STRING )
					sum = sum + symbol_Sizeof_Symbol(table, node);

				//Goto next node
				node = Get_Next_In_symbolTableNode_List( node);
		}

		return -1;
}


/** Get offset of non-global variable (offset on base pointer, ebp) */
int symbol_GetNonGlobalOffset( symbolTable* table, symbolTableNode* nonglobal )
{
		//By calling convention: (%ebp) is the old %ebp, 4(%ebp) is the return address
		//And 8(%ebp) is the 1-th parameter
		if( nonglobal->type == SYMBOL_TYPE_PARVAR ) 
			return symbol_GetParameterOffset(table, nonglobal) + 8;

		//The first local variable is -SIZE(%ebp) where SIZE is the size of the local variable
		if( nonglobal->type == SYMBOL_TYPE_LOCALVAR ) 
			return -symbol_GetLocalVarOffset(table, nonglobal) 
					- symbol_Sizeof_Vardecl(table, nonglobal->structure);


		symbol_reportError(table, "Internal error: Invalid type in GetNonGlobalOffset!\n",
			nonglobal->name);
		return 0;
}


/** Get offset of struct-entry in struct */
int symbol_GetOffsetInStruct( symbolTable* table, symbolTableNode* structNode, token entry)
{
		int structsize;
		int structentries;
		int childsize;
		int idx;

		syntaxTreeNode* vardecl;
		syntaxTreeNode* name;


		//Size of struct
		structsize = 0;
		structentries = symbol_CountStructEntries( table, structNode->structure );
		idx = 0;

		//Run through all entries and determine size
		while( idx < structentries )
		{
				//tmp is of type <var_decl>
				vardecl = symbol_GetStructEntry( table, structNode->structure, idx );
				name = syntax_GetChild( vardecl, 0 );
				name = syntax_GetChild( name, 1 );


				//Found it!
				if( strcmp( name->tok.content, entry.content) == 0)
					return structsize;

				//The size of the child
				childsize = symbol_Sizeof_Vardecl( table, vardecl );

				//Error occured
				if( childsize <= 0 )
					return -1;
			
				//Add size to struct size
				structsize = structsize + childsize;
				idx = idx+1;
		}

		return -1;
}


/** Get member declaration of struct-entry in struct */
syntaxTreeNode* symbol_GetMemberDeclInStruct( symbolTable* table, symbolTableNode* structNode, token entry)
{
		int structentries;
		int idx;

		syntaxTreeNode* vardecl;
		syntaxTreeNode* name;


		//Size of struct
		structentries = symbol_CountStructEntries( table, structNode->structure );
		idx = 0;

		//Run through all entries and determine size
		while( idx < structentries )
		{
				//tmp is of type <var_decl>
				vardecl = symbol_GetStructEntry( table, structNode->structure, idx );
				name = syntax_GetChild( vardecl, 0 );
				name = syntax_GetChild( name, 1 );

				//Found it!
				if( strcmp( name->tok.content, entry.content) == 0)
					return vardecl;


				idx = idx+1;
		}

		return 0;
}


/** Count the entries of struct */
int symbol_CountStructEntries( symbolTable* table, syntaxTreeNode* structure )
{
		syntaxTreeNode* structtree;

		//Tree which contains 'struct'
		structtree =  syntax_GetChild( structure, 0);

		//Check if first token is struct!
		if(structtree->tok.type  != TOK_STRUCT )
		{
			symbol_reportError( table, "Internal Error: count struct entries!\n", 
				structure->tok );
			return -1;
		}

		//Subtract 'struct' ident '{' '}' ';'
		return syntax_CountChilds( structure ) - 5;

}


/** Get a specific entry in struct */
syntaxTreeNode* symbol_GetStructEntry( symbolTable* table, syntaxTreeNode* structure, int idx)
{
		syntaxTreeNode* subtree;


		//Check if first token is struct!
		subtree =  syntax_GetChild( structure, 0);
		if( subtree->tok.type  != TOK_STRUCT )
		{
			symbol_reportError( table, "Internal Error: get struct entry!\n", 
				structure->tok );
			return 0;
		}

		//Subtract 'struct' ident '{'
		return syntax_GetChild( structure, idx+3 );
}


/** Count amount of function declarations (or definitions, if not declared) */
int symbol_CountFunctions( symbolTable* table)
{
		symbolTableNode* node;
		symbolTableNode* tmp;
		int count;

		node = Get_Front_Of_symbolTableNode_List(&table->list);
		count = 0;

		while( node != 0)
		{
				//Correct type? 
				if( node->type != SYMBOL_TYPE_FUNCTIONDEF &&
					node->type != SYMBOL_TYPE_FUNCTIONDECL )
				{
					node = Get_Next_In_symbolTableNode_List( node);
					continue;
				}


				//If it is a declaration and funtion is defined
				//--> just count defintion
				if( node->type == SYMBOL_TYPE_FUNCTIONDECL )
				{
						//Find the function and test if defintion exists
						tmp = symbol_FindFunction( table, node->name );

						//Do not count!
						if( tmp->type == SYMBOL_TYPE_FUNCTIONDEF )
						{
							node = Get_Next_In_symbolTableNode_List( node);
							continue;
						}
				}


				//Count it!
				count = count + 1;

				//Goto next node
				node = Get_Next_In_symbolTableNode_List( node);
		}

		//Not found
		return count;

}

/** Get function definition/declaration with specific idx */
symbolTableNode* symbol_GetFunction( symbolTable* table, int idx)
{
		symbolTableNode* node;
		symbolTableNode* tmp;
		int count;

		node = Get_Front_Of_symbolTableNode_List(&table->list);
		count = 0;

		while( node != 0)
		{
				//Correct type? 
				if( node->type != SYMBOL_TYPE_FUNCTIONDEF &&
					node->type != SYMBOL_TYPE_FUNCTIONDECL )
				{
					node = Get_Next_In_symbolTableNode_List( node);
					continue;
				}
				


				//If it is a declaration and funtion is defined
				//--> just count defintion
				if( node->type == SYMBOL_TYPE_FUNCTIONDECL )
				{
						//Find the function and test if defintion exists
						tmp = symbol_FindFunction( table, node->name );

						//Do not count!
						if( tmp->type == SYMBOL_TYPE_FUNCTIONDEF )
						{
							node = Get_Next_In_symbolTableNode_List( node);
							continue;
						}
				}


				//Return the node we found with index idx
				if( idx == count)
					return node;


				//Count it!
				count = count + 1;

				//Goto next node
				node = Get_Next_In_symbolTableNode_List( node);
		}

		//Not found
		return 0;
}




