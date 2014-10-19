/**
 * The symbol tables maintains all symbols (variables, function declarations, structure defintions, etc.).
 */


#ifndef SYMBOLTABLE_H
#define SYMBOLTABLE_H


#include "../util/list.h"
#include "../scanner/token.h"
#include "../parser/syntaxTreeNode.h"
#include "../parser/parser.h"




//These are the constants of valid types of a symbol
#define SYMBOL_TYPE_FUNCTIONDECL	1
#define SYMBOL_TYPE_FUNCTIONDEF		2
#define SYMBOL_TYPE_STRUCTDECL		3
#define SYMBOL_TYPE_LOCALVAR		4
#define SYMBOL_TYPE_GLOBALVAR		5
#define SYMBOL_TYPE_PARVAR			6
#define SYMBOL_TYPE_STRING			7



/**
 * This is a single entry in the symbol table
 */
struct symbolTableNode
{
		//Ident of symbol (function name, struct identifier, ...)
		token name;

		//Type of symbol (its value is one of the SYMBOL_TYPE_XXX)
		int type;

		//The structure (struct content, variable type, ...)
		syntaxTreeNode* structure;


		DEFINE_LINK( symbolTableNode_List, symbolTableNode );
};


DEFINE_LIST( symbolTableNode_List, symbolTableNode);
PROTOTYPES_LIST( symbolTableNode_List, symbolTableNode);



struct symbolTable
{
		/** Parser which produces the symbols */
		parser* parse;

		/** Count the errors which have been detected. */
		int cnterrors;

		/** List of symbols saved */
		symbolTableNode_List list;
};




/** Create a symbol-table */
void symbol_CreateSymbolTable(parser* parser, symbolTable* table);
/** Print symbol table */
void symbol_printTable( symbolTable* table);
/** Delete symbol table */
void symbol_destroy( symbolTable* table);


/** Count the number of entries in symtable */
int symbol_CountEntries(symbolTable* table);
/** Get the idx-th entry*/
symbolTableNode* symbol_GetEntry(symbolTable* table, int idx);
		

/** Find global variable by name */
symbolTableNode* symbol_FindGlobalVariable( symbolTable* table, token name);
/** Find local variable or parameter by name */
symbolTableNode* symbol_FindNonGlobalVariable( symbolTable* table, token name);
/** Find a variable by its name. First local, than global. */
symbolTableNode* symbol_FindVariable (symbolTable* table, token name );
/** Find a function signature. First definition, than declaration */
symbolTableNode* symbol_FindFunction (symbolTable* table, token name );
/** Find a struct definition by its name */
symbolTableNode* symbol_FindStruct (symbolTable* table, token name );
/** Find a string by its content */
symbolTableNode* symbol_FindString (symbolTable* table, token string);

/** Define a global variable */
int symbol_DefineGlobalVariable (symbolTable* table, syntaxTreeNode* structure);
/** Define a local variable */
int symbol_DefineLocalVariable (symbolTable* table, syntaxTreeNode* structure);
/** Defina a parameter --> this implies local, what else. */
//int symbol_DefineParVariable (symbolTable* table, syntaxTreeNode* structure);
/** Define a structure */
int symbol_DefineStruct (symbolTable* table, syntaxTreeNode* structure);
/** Declare a function */
int symbol_DeclareFunction (symbolTable* table, syntaxTreeNode* structure);
/** Define a function and add all parameters */
int symbol_DefineFunction (symbolTable* table, syntaxTreeNode* structure);
/** Define a string (if not already defined) */
int symbol_DefineString (symbolTable* table, syntaxTreeNode* structure);



/**Remove all non-global variables (because we leave the function?)*/
void symbol_ClearNonGlobalVariables (symbolTable* table);

/** Count amount of function declarations (or definitions, if not declared) */
int symbol_CountFunctions( symbolTable* table);
/** Get function definition/declaration with specific idx */
symbolTableNode* symbol_GetFunction( symbolTable* table, int idx);


/** Calculate the size of variable which is declared by var_decl syntax-sub-tree */
int symbol_Sizeof_Vardecl (symbolTable* table, syntaxTreeNode* var_decl);
/** Calculate the size of data_type syntax-sub-tree (amount of bytes) */
int symbol_Sizeof_DataType (symbolTable* table, syntaxTreeNode* data_type);
/** Get size of struct by its syntax tree */
int symbol_Sizeof_Structdef (symbolTable* table, syntaxTreeNode* structnode);
/** Calc size of string */
int symbol_Sizeof_String (symbolTable* table, syntaxTreeNode* string);
/** Get size of symbol in symbol table (0 for functions...) */
int symbol_Sizeof_Symbol( symbolTable* table, symbolTableNode* symbol );
/** Size of all function arguments together */
int symbol_Sizeof_FunctionArgs( symbolTable *table, syntaxTreeNode* structure);

/** Count the number of arguments for the function given by its name-token */
int symbol_CountFunctionArgs( symbolTable* table, syntaxTreeNode* func_decl);
/** Get the idx-th argument of function given by name-token */
syntaxTreeNode* symbol_GetFunctionArg( symbolTable* table, syntaxTreeNode* func_decl, int idx);
/** Get the return type of function given by name-token */
syntaxTreeNode* symbol_GetReturnType( symbolTable* table, syntaxTreeNode* func_decl);
/** Test if return type of function with specific name is void */
int symbol_IsReturnTypeVoid( symbolTable* table, syntaxTreeNode* structure );

/** Get offset of struct-entry in struct */
int symbol_GetOffsetInStruct( symbolTable* table, symbolTableNode* structNode, token entry);
/** Get member declaration in struct definition. */
syntaxTreeNode* symbol_GetMemberDeclInStruct( symbolTable* table, symbolTableNode* structNode, token entry);
/** Count the entries of struct */
int symbol_CountStructEntries( symbolTable* table, syntaxTreeNode* structure );
/** Get a specific entry in struct */
syntaxTreeNode* symbol_GetStructEntry( symbolTable* table, syntaxTreeNode* structure, int idx);

/** Get sum of sizeofs of all parameter of function */
int symbol_GetParameterBlockSize( symbolTable* table );
/** Get sum of sizeofs of all local variables of function */
int symbol_GetLocalVarBlockSize( symbolTable* table );
/** Get sum of sizeofs of all global variables and strings */
int symbol_GetGlobalsBlockSize( symbolTable* table );
/** Get offset of parameter from stack-base-pointer.*/
//int symbol_GetParameterOffset( symbolTable* table, symbolTableNode* parameter );
/** Get offset of local variable from stack-base-pointer. (We do not return negative value.) */
//int symbol_GetLocalVarOffset( symbolTable* table, symbolTableNode* variable );
/** Get offset of global variable or string from symbol-table-marker.*/
int symbol_GetGlobalOffset( symbolTable* table, symbolTableNode* global );
/** Get offset of non-global variable (offset on base pointer, ebp) */
int symbol_GetNonGlobalOffset( symbolTable* table, symbolTableNode* nonglobal );






#endif// SYMBOLTABLE_H



