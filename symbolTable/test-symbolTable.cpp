
#include "../include/hrwcccomp.h"

#include "symbolTable.h"

#include "../parser/syntaxTreeNode.h"
#include "../parser/parser.h"
#include "../scanner/token.h"
#include "../scanner/scanner.h"
#include "../include/error.h"




void test_Sizeof()
{
		preproc testpreproc;
		scanner testscanner;
		parser testparser;
		symbolTable testsymtable;
		syntaxTreeNode* tree;
		syntaxTreeNode* body;
		syntaxTreeNode* tmp;
		token tok;
		symbolTableNode* node;


		puts("\n\nTest sizeof.c\n");

		puts("Create preproc...");
		if( preproc_create( &testpreproc, "testdata/sizeof.c") )
			return;

		puts("Init scanner...");
		scanner_init( &testscanner, &testpreproc );

		puts("Init parser...");
		parser_init( &testparser, &testscanner );

		puts("Create symbol table...\n");
		symbol_CreateSymbolTable( &testparser, &testsymtable );


		tree = syntax_CreateTreeNode();
		parser_buildSyntaxTree( &testparser, tree );

		if( testparser.cnterrors > 0 )
		{
			printf("Detected %d errors.\n", testparser.cnterrors);
			return;
		}


		//syntax_printTree( tree );


		tmp = syntax_GetChild( tree, 0);
		symbol_DefineGlobalVariable( &testsymtable, tmp);

		tmp = syntax_GetChild( tree, 1);
		symbol_DefineGlobalVariable( &testsymtable, tmp);

		tmp = syntax_GetChild( tree, 2);
		symbol_DefineGlobalVariable( &testsymtable, tmp);
	
		tmp = syntax_GetChild( tree, 3);
		symbol_DefineStruct( &testsymtable, tmp);

		tmp = syntax_GetChild( tree, 4);
		symbol_DefineStruct( &testsymtable, tmp);

		tmp = syntax_GetChild( tree, 5);
		symbol_DefineGlobalVariable( &testsymtable, tmp);
		
		tmp = syntax_GetChild( tree, 6);
		symbol_DefineGlobalVariable( &testsymtable, tmp);

		tmp = syntax_GetChild( tree, 7);
		symbol_DefineGlobalVariable( &testsymtable, tmp);

		tmp = syntax_GetChild( tree, 8);
		symbol_DefineGlobalVariable( &testsymtable, tmp);
		
		tmp = syntax_GetChild( tree, 9);
		symbol_DefineGlobalVariable( &testsymtable, tmp);


		tmp = syntax_GetChild( tree, 10);
		symbol_DefineFunction( &testsymtable, tmp);

		body = syntax_GetChild( tmp, 2);

		tmp = syntax_GetChild( body, 1);
		symbol_DefineLocalVariable( &testsymtable, tmp);

		tmp = syntax_GetChild( body, 2);
		symbol_DefineLocalVariable( &testsymtable, tmp);

		tmp = syntax_GetChild( body, 3);
		symbol_DefineLocalVariable( &testsymtable, tmp);

		tmp = syntax_GetChild( body, 4);
		symbol_DefineLocalVariable( &testsymtable, tmp);

		tmp = syntax_GetChild( body, 5);
		symbol_DefineLocalVariable( &testsymtable, tmp);

		tmp = syntax_GetChild( body, 6);
		symbol_DefineLocalVariable( &testsymtable, tmp);



		tmp = syntax_GetChild( body, 7);
		tmp = syntax_GetChild( tmp, 0 );
		tmp = syntax_GetChild( tmp, 0 );
		tmp = syntax_GetChild( tmp, 2 );
		tmp = syntax_GetChild( tmp, 0 );
		tmp = syntax_GetChild( tmp, 0 );
		tmp = syntax_GetChild( tmp, 0 );
		tmp = syntax_GetChild( tmp, 0 );
		tmp = syntax_GetChild( tmp, 0 );
		tmp = syntax_GetChild( tmp, 0 );
		tmp = syntax_GetChild( tmp, 0 );
		tmp = syntax_GetChild( tmp, 0 );
		symbol_DefineString( &testsymtable, tmp );
		printf("Sizeof %s", tmp->tok.content );
		printf(": %d\n", symbol_Sizeof_String(&testsymtable, tmp) );



		tok.type = TOK_IDENT;
		strcpy( tok.content, "a");
		node = symbol_FindVariable( &testsymtable, tok);
		printf("\nType of variable \"a\": %d\n", node->type );


		strcpy( tok.content, "mystruct");
		node = symbol_FindStruct( &testsymtable, tok);
		strcpy( tok.content, "c");
		printf("Offset of 'c' in 'mystruct': %d\n", 
					symbol_GetOffsetInStruct(&testsymtable, node, tok));
	
		strcpy( tok.content, "b");
		node = symbol_FindGlobalVariable( &testsymtable, tok);
		printf("Offset of 'b' in globals: %d\n", 
					symbol_GetGlobalOffset(&testsymtable, node));	
		
		strcpy( tok.content, "b");
		node = symbol_FindNonGlobalVariable( &testsymtable, tok);
		printf("Offset of 'b' in non-globals: %d\n", 
					symbol_GetNonGlobalOffset(&testsymtable, node));	

		strcpy( tok.content, "p2");
		node = symbol_FindNonGlobalVariable( &testsymtable, tok);
		printf("Offset of 'p2' in non-globals: %d\n", 
					symbol_GetNonGlobalOffset(&testsymtable, node));	

		strcpy( tok.content, "\"hello\"");
		node = symbol_FindString( &testsymtable, tok );
		printf("Offset of '\"hello\"' in globals: %d\n", 
					symbol_GetGlobalOffset(&testsymtable, node));	



		//Print symbol table
		puts("\nSymbol table:");
		symbol_printTable( &testsymtable );

		puts("\nClear non-globals");
		symbol_ClearNonGlobalVariables( &testsymtable );

		puts("\nSymbol table:");
		symbol_printTable( &testsymtable );


		strcpy( tok.content, "a");
		node = symbol_FindVariable( &testsymtable, tok);
		printf("\nType of variable \"a\": %d\n", node->type );


		printf("\nEnded with %d symtable erros.\n", testsymtable.cnterrors);



		syntax_FreeSyntaxTree( tree );
		preproc_destroy( &testpreproc );
}





void test_Functions()
{
		preproc testpreproc;
		scanner testscanner;
		parser testparser;
		symbolTable testsymtable;
		syntaxTreeNode* tree;
		syntaxTreeNode* tmp;


		puts("\n\nTest functions.c\n");

		puts("Create preproc...");
		if( preproc_create( &testpreproc, "testdata/functions.c") )
			return;

		puts("Init scanner...");
		scanner_init( &testscanner, &testpreproc );

		puts("Init parser...");
		parser_init( &testparser, &testscanner );

		puts("Create symbol table...\n");
		symbol_CreateSymbolTable( &testparser, &testsymtable );


		tree = syntax_CreateTreeNode();
		parser_buildSyntaxTree( &testparser, tree );

		if( testparser.cnterrors > 0 )
		{
			printf("Detected %d parser errors.\n", testparser.cnterrors);
			return;
		}


		//syntax_printTree( tree );



		puts("define struct...");
		tmp = syntax_GetChild( tree, 0);
		symbol_DefineStruct( &testsymtable, tmp);

		puts("declare function...");
		tmp = syntax_GetChild( tree, 1);
		symbol_DeclareFunction( &testsymtable, tmp);

		puts("declare function...");
		tmp = syntax_GetChild( tree, 2);
		symbol_DeclareFunction( &testsymtable, tmp);

		puts("define function...");
		tmp = syntax_GetChild( tree, 3);
		symbol_DefineFunction( &testsymtable, tmp);

		puts("Return type:");
		syntax_printTree( symbol_GetReturnType(&testsymtable, tmp) );

		printf("Arguments 1/%d:\n", symbol_CountFunctionArgs(&testsymtable,tmp) );
		syntax_printTree( symbol_GetFunctionArg(&testsymtable, tmp, 0) );

		printf("Arguments 2/%d:\n", symbol_CountFunctionArgs(&testsymtable,tmp) );
		syntax_printTree( symbol_GetFunctionArg(&testsymtable, tmp, 1) );

		printf("Arguments 3/%d:\n", symbol_CountFunctionArgs(&testsymtable,tmp) );
		syntax_printTree( symbol_GetFunctionArg(&testsymtable, tmp, 2) );


		puts("define function...");
		tmp = syntax_GetChild( tree, 4);
		symbol_DefineFunction( &testsymtable, tmp);

		puts("define function...");
		tmp = syntax_GetChild( tree, 5);
		symbol_DefineFunction( &testsymtable, tmp);

		puts("declare function...");
		tmp = syntax_GetChild( tree, 6);
		symbol_DeclareFunction( &testsymtable, tmp);

		puts("declare function...");
		tmp = syntax_GetChild( tree, 7);
		symbol_DeclareFunction( &testsymtable, tmp);

		puts("declare function...");
		tmp = syntax_GetChild( tree, 8);
		symbol_DeclareFunction( &testsymtable, tmp);

		puts("declare function...");
		tmp = syntax_GetChild( tree, 9);
		symbol_DeclareFunction( &testsymtable, tmp);



		puts("\nSymbol table:");
		symbol_printTable( &testsymtable);

		printf("\nEnded with %d symtable errors.\n", testsymtable.cnterrors);

		



		syntax_FreeSyntaxTree( tree );
		preproc_destroy( &testpreproc );
}



void test_parser()
{
		preproc testpreproc;
		scanner testscanner;
		parser testparser;
		symbolTable testsymtable;
		syntaxTreeNode* tree;
		symbolTableNode* node;
		int idx;
		int count;


		puts("\n\nTest input.c with parser\n");

		puts("Create preproc...");
		if( preproc_create( &testpreproc, "testdata/input.c") )
		//if( preproc_create( &testpreproc, "symbolTable.test.c") )
			return;

		preproc_addDefine(&testpreproc, "__HRWCC__");

		puts("Init scanner...");
		scanner_init( &testscanner, &testpreproc );

		puts("Init parser...");
		parser_init( &testparser, &testscanner );

		puts("Create symbol table...");
		symbol_CreateSymbolTable( &testparser, &testsymtable );
		parser_setSymbolTable( &testparser, &testsymtable );



		tree = syntax_CreateTreeNode();
		parser_buildSyntaxTree( &testparser, tree );


		puts("\nAfter parsing...");
		symbol_printTable( &testsymtable );



		//Print all functions we got
		count = symbol_CountFunctions( &testsymtable );
		idx = 0;

		while( idx < count )
		{
				node = symbol_GetFunction( &testsymtable, idx);
				printf("Function %d", idx);
				printf(": %s\n", node->name.content);

				idx = idx+1;
		}



		printf("\nDetected %d parser errors.\n", testparser.cnterrors);
		printf("Detected %d symbol errors.\n", testsymtable.cnterrors);

		//syntax_printTree( tree );


		syntax_FreeSyntaxTree( tree );
		symbol_destroy( &testsymtable);
		preproc_destroy( &testpreproc );
}




int main()
{
		//test_Sizeof();
		//test_Functions();
		test_parser();


		return 0;
}















