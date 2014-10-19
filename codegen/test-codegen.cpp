
#include "../include/hrwcccomp.h"

#include "codegen.h"

#include "../symbolTable/symbolTable.h"
#include "../parser/syntaxTreeNode.h"
#include "../parser/parser.h"
#include "../scanner/token.h"
#include "../scanner/scanner.h"




int main(int argc, char** argv)
{
		preproc testpreproc;
		scanner testscanner;
		parser testparser;
		symbolTable testsymtable;
		codegen testcg;
		char inputfile[255];

		syntaxTreeNode* tree;

		int fd;


		//Default input file
		if( argc==1 )
			strcpy(inputfile, "testdata/main.c");
		else
			strcpy(inputfile, argv[1]);



		printf("Compiling %s:\n", inputfile);

		puts("Create preproc...");
		if( preproc_create( &testpreproc, inputfile) )
			return -1;

		preproc_addDefine(&testpreproc, "__HRWCC__");

		puts("Init scanner...");
		scanner_init( &testscanner, &testpreproc );

		puts("Init parser...");
		parser_init( &testparser, &testscanner );

		puts("Create symbol table...\n");
		symbol_CreateSymbolTable( &testparser, &testsymtable );
		parser_setSymbolTable( &testparser, &testsymtable );

		puts("Create code generator...\n");

		fd = open("./output.s", O_CREAT | O_TRUNC | O_WRONLY, 6*8*8+6*8+4 );
		codegen_CreateCodeGen( &testcg, fd, &testparser);
		parser_setCodegen( &testparser, &testcg);
		testcg.emitdebug = 1;
		testcg.enOptFastassign = 1;



		tree = syntax_CreateTreeNode();
		parser_buildSyntaxTree( &testparser, tree );



		printf("\nDetected %d parser errors.\n", testparser.cnterrors);
		printf("Detected %d symbol errors.\n", testsymtable.cnterrors);
		printf("Detected %d codegen errors.\n", testcg.cnterrors);
		printf("Detected %d codegen warnings.\n", testcg.cntwarnings);

		//syntax_printTree( tree );


		syntax_FreeSyntaxTree( tree );
		symbol_destroy( &testsymtable );
		preproc_destroy( &testpreproc );
		close(fd);


		return 0;
}
















