

#include "../include/hrwcccomp.h"

#include "syntaxTreeNode.h"
#include "parser.h"

#include "../scanner/token.h"
#include "../scanner/scanner.h"
#include "../include/error.h"


void test_syntaxTree()
{
		token t1;
		token t2;
		token t3;
		token t4;
		syntaxTreeNode* subtree;
		syntaxTreeNode* subsubtree;
		syntaxTreeNode* root;
		token st1;
		token st2;


		puts("== Test the syntax-tree ==\n");
		puts("\nCreate root");

		root = syntax_CreateTreeNode();

		t1.type = 1;
		t2.type = 2;
		t3.type = 3;
		t4.type = 4;

		puts("\nAdd child-tokens 1, 2, 3, 4");
		syntax_AddChildNode(root, t1);
		syntax_AddChildNode(root, t2);
		syntax_AddChildNode(root, t3);
		syntax_AddChildNode(root, t4);

		printf("\nCnt of children: %d\n", syntax_CountChilds(root));
		subtree = syntax_GetChild(root, 0);
		printf("Child 1: %d\n", subtree->tok.type);
		subtree = syntax_GetChild(root, 1);
		printf("Child 2: %d\n", subtree->tok.type);
		subtree = syntax_GetChild(root, 2);
		printf("Child 3: %d\n", subtree->tok.type);
		subtree = syntax_GetChild(root, 3);
		printf("Child 4: %d\n", subtree->tok.type);

		
		puts("\nAdd a sub-tree");

		subtree = syntax_CreateTreeNode();
		syntax_AddChildTree(root, subtree);
		printf("Cnt children 5: %d\n", syntax_CountChilds(syntax_GetChild(root, 4)) );


		puts("\nAdd two child-tokens to sub-tree 51, 52");
		st1.type = 51;
		st2.type = 52;

		syntax_AddChildNode(subtree, st1);
		syntax_AddChildNode(subtree, st2);

		printf("\nCnt of children: %d\n", syntax_CountChilds(root));
		subtree = syntax_GetChild(root, 0);
		printf("Child 1: %d\n", subtree->tok.type);
		subtree = syntax_GetChild(root, 1);
		printf("Child 2: %d\n", subtree->tok.type);
		subtree = syntax_GetChild(root, 2);
		printf("Child 3: %d\n", subtree->tok.type);
		subtree = syntax_GetChild(root, 3);
		printf("Child 4: %d\n", subtree->tok.type);
		printf("Cnt children 5: %d\n", syntax_CountChilds(syntax_GetChild(root, 4)) );
		subtree = syntax_GetChild(root, 4);
		subsubtree = syntax_GetChild(subtree, 0);
		printf("Child 1: %d\n", subsubtree->tok.type );
		subsubtree = syntax_GetChild(subtree, 1);
		printf("Child 2: %d\n", subsubtree->tok.type );


		syntax_FreeSyntaxTree( root );
}


void test_Parser()
{				
		preproc testpreproc;
		scanner testscanner;
		parser testparser;
		syntaxTreeNode* tree;


		puts("\n\n== Test parser ==");


		puts("Create preproc...");
		preproc_create( &testpreproc, "input.c");

		puts("Init scanner...");
		scanner_init( &testscanner, &testpreproc );

		puts("Init parser...\n");
		parser_init( &testparser, &testscanner );

		tree = syntax_CreateTreeNode();
		parser_buildSyntaxTree( &testparser, tree);

		printf("Compiled with %d parser errors.\n", testparser.cnterrors);
		

		syntax_printTree( tree );
		
		syntax_FreeSyntaxTree( tree );
		preproc_destroy(&testpreproc);
}


int main()
{

		//test_syntaxTree();
		test_Parser();
	
		return 0;
}















