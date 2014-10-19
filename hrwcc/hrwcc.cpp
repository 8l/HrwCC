

#include "../include/hrwcccomp.h"


//The components of HrwCC
#include "../preproc/preproc.h"
#include "../scanner/scanner.h"
#include "../parser/parser.h"
#include "../symbolTable/symbolTable.h"
#include "../codegen/codegen.h"
#include "../linker/linker.h"
#include "../linker/asmopt.h"

#define HRWCC_MAXMACROS		20
#define HRWCC_MAXINFILES	20

#define HRWCC_FILETYPE_C	1
#define HRWCC_FILETYPE_ASM	2





//Some prototypes
void hrwcc_setToAsm (char* filename);
void hrwcc_setToNonoptAsm (char* filename);
void hrwcc_setToNonpreprocC (char* filename);
int hrwcc_getFiletype( char* filename );



/**
 * Optimize the specific file at assembler level
 */
int hrwcc_asmOptimize(char* infile)
{
	int ret;
	int infile_fd;
	int outfile_fd;
	char outfile[MAX_FILENAME_LENGTH];

	//Determine output-filename
	strcpy(outfile, infile);
	hrwcc_setToAsm(outfile);

	//try to open input and output file
	infile_fd = open(infile, O_RDONLY, 0);
	if ( infile_fd < 0 )
	{
		puts("Can not open asmopt inputfile");
		return -1;
	}

	outfile_fd = open(outfile, O_CREAT | O_TRUNC | O_WRONLY, 6*8*8 + 4*8 + 4);
	if ( outfile_fd < 0 )
	{
		close(infile_fd);
		puts("Can not create asmopt outputfile");
		return -1;
	}

	//call the pattern optimizer
	ret = asmopt_execute(infile_fd, outfile_fd);

	//don't forget to close the opened files!
	close(infile_fd);
	close(outfile_fd);

	return ret;
}


/**
 * Compile the following file
 */
int hrwcc_compile(char* infile, char* outfile, int enDebug, int printTree, 
				char** argv, int* macroargs, int macrocnt,
				int enOptFastassign)
{
		int fd;
		int idx;
		char* macro;

		//Create instances of compiler
		preproc pp;
		scanner scan;
		parser parse;
		symbolTable symtab;
		codegen cg;
		syntaxTreeNode* syntree;


		printf("Compile %s ...\n", infile);

		//Create code generator
		fd = open(outfile, O_CREAT | O_TRUNC | O_WRONLY, 6*8*8 + 4*8 + 4);


		//Invalid output file
		if( fd < 0 )
		{
				puts("Can not create outputfile");
				return -1;
		}


		//Create preprocessor
		if( preproc_create(&pp, infile) != 0 )
			return -1;

		//Add user defined macro
		idx=0;
		while(idx < macrocnt)
		{
			macro = argv[macroargs[idx]];
			preproc_addDefine( &pp, &macro[2]);
			idx = idx+1;
		}

		//Add the hrwcc default define
		preproc_addDefine( &pp, "__HRWCC__");
		//Initialize scanner
		scanner_init( &scan, &pp);
		//Initialize parser
		parser_init( &parse, &scan);

		//Create symbol table
		symbol_CreateSymbolTable( &parse, &symtab);
		parser_setSymbolTable( &parse, &symtab);

		//Create code generator
		codegen_CreateCodeGen(&cg, fd, &parse);
		parser_setCodegen(&parse, &cg);

		//Set debug flag
		cg.emitdebug = enDebug;
		cg.enOptFastassign = enOptFastassign;

		//Compile it
		syntree = syntax_CreateTreeNode();
		parser_buildSyntaxTree(&parse, syntree);

		//Print syntax tree??
		if( printTree )
			syntax_printTree(syntree);


		puts("Finished with");
		printf("\t%d parser errors\n", parse.cnterrors);
		printf("\t%d symbol table errors\n", symtab.cnterrors);
		printf("\t%d codegen errors\n", cg.cnterrors);
		printf("\t%d codegen warnings\n", cg.cntwarnings);
		puts("");



		//Clean up all and close file
		close(fd);
		preproc_destroy(&pp);
		symbol_destroy(&symtab);
		syntax_FreeSyntaxTree(syntree);

		//There have been errors
		if( parse.cnterrors + symtab.cnterrors + 
			cg.cnterrors + cg.cntwarnings > 0 )
			return -1;

		return 0;
}


/**
 * Compile the following file
 */
int hrwcc_preprocess(char* infile, char** argv, int* macroargs, int macrocnt)
{
		//The output file
		char outfile[MAX_FILENAME_LENGTH];
		int fd;
		int idx;
		char* macro;
		Character input;

		//Create instances of compiler
		preproc pp;


		printf("Preprocess %s ...\n", infile);

		//Determine output file name
		strcpy(outfile, infile);
		hrwcc_setToNonpreprocC(outfile);

		printf("Outfile: %s\n", outfile);

		//Create code generator
		fd = open(outfile, O_CREAT | O_TRUNC | O_WRONLY, 6*8*8 + 4*8 + 4);


		//Invalid output file
		if( fd < 0 )
		{
				puts("Can not create outputfile");
				return -1;
		}


		//Create preprocessor
		if( preproc_create(&pp, infile) != 0 )
			return -1;

		//Add user defined macro
		idx=0;
		while(idx < macrocnt)
		{
			macro = argv[macroargs[idx]];
			preproc_addDefine( &pp, &macro[2]);
			idx = idx+1;
		}

		//Add the hrwcc default define
		preproc_addDefine( &pp, "__HRWCC__");


		//Get first character
		preproc_getNext(&pp, &input);

		while( input.value != '\0' )
		{
				//Write it down
				write(fd, &input.value, 1);
				//Get next character
				preproc_getNext(&pp, &input);
		}



		//Destroy preprocessor
		preproc_destroy(&pp);		

		return 0;
}


/**
 * Link the remaining files
 */
int hrwcc_linkit(char* outfile, char** argv, int* infileargs, int infilecnt, int enDebug)
{
		linker link;
		int idx;
		char* infile;


		if( linker_create(&link) < 0 )
		{
				printf("Cann not create output-file %s\n", outfile);
				return -1;
		}


		//Append input file
		idx = -1;
		while( idx < infilecnt )
		{
				idx = idx+1;
				infile = argv[infileargs[idx]];

				if( hrwcc_getFiletype(infile) != HRWCC_FILETYPE_ASM )
						continue;


				printf("Add to linker: %s\n", infile);

				//Append file to linker
				if( linker_appendFile(&link, infile, enDebug) < 0 )
				{
						linker_destroy(&link);
						puts("Could not append file.");
						return -1;
				}
		}


		//Link it!
		if( linker_produce(&link, outfile) < 0 )
		{
				linker_destroy(&link);
				return -1;
		}


		linker_destroy(&link);

		return 0;
}



/**
 * Print usage of hrwcc tool
 */
void printUsage( int argc, char** argv )
{
		puts("HrwCC -- a self-compiling C compiler!");
		puts("");
		puts("");
		puts("Usage:");
		printf("\t%s [-g] [-c | -E] [-T] [-o outfile] [-Dmacro] [-O] [-fXXX] infiles...\n", argv[0]);
		puts("");
		puts("-g");
		puts("\tInsert debug messages.");
		puts("-c\n");
		puts("\tStop after compilation, do not link.\n");
		puts("-E");
		puts("\tStop after preprocessing.\n");
		puts("-T");
		puts("\tPrint syntax tree.\n");
		puts("-o outfile");
		puts("\tOutput file.\n");
		puts("-Dmacro");
		puts("\tDefine macro for preprocessor.\n");
		puts("-O");
		puts("\tEnable optimization.");
		puts("-ffastassign");
		puts("\tOptimize: Fast variable assignment");
		puts("-fasmpat");
		puts("\tOptimize: Assembler patterns");
		puts("");
		puts("");
		puts("Input files are detected by their file ending. Therefore a");
		puts("*.cpp file is preprocessed, compiled and linked. A *.s file");
		puts("is just linked.");
}



/** Get file type out of filename */
int hrwcc_getFiletype( char* filename )
{
		int pntpos;
		char ending[MAX_FILENAME_LENGTH];


		pntpos = strlen(filename)-1;

		//Find the (right-most) point in the filename
		while(pntpos >= 0)
		{
				if( filename[pntpos] == '.' )
					break;

				pntpos = pntpos-1;
		}


		//Copy the file-ending
		strcpy(ending, &filename[pntpos+1]);


		if( strcmp(ending, "c") == 0)
			return HRWCC_FILETYPE_C;

		if( strcmp(ending, "cpp") == 0)
			return HRWCC_FILETYPE_C;

		if( strcmp(ending, "s") == 0)
			return HRWCC_FILETYPE_ASM;


		//Unknown
		return -1;
}


/** Set filename to assembler type */
void hrwcc_setToAsm (char* filename)
{
		int pntpos;
		int len;

		len = strlen(filename);
		pntpos = len-1;

		//Find the (right-most) point in the filename
		while(pntpos >= 0)
		{
				if( filename[pntpos] == '.' )
					break;

				pntpos = pntpos-1;
		}


		//There is free space for 's'
		if( pntpos < len-1 )
		{
				filename[pntpos+1] = 's';
				filename[pntpos+2] = '\0';
		}
}

/** Set filename to non-optimized assembler type */
void hrwcc_setToNonoptAsm (char* filename)
{
		int pntpos;
		int len;

		len = strlen(filename);
		pntpos = len-1;

		//Find the (right-most) point in the filename
		while(pntpos >= 0)
		{
				if( filename[pntpos] == '.' )
					break;

				pntpos = pntpos-1;
		}


		//There is free space for 'n'
		if( pntpos < len-1 )
		{
				filename[pntpos+1] = 'n';
				filename[pntpos+2] = '\0';
		}
}


/** Set filename to C code which should not be preprocessed */
void hrwcc_setToNonpreprocC (char* filename)
{
		int pntpos;
		int len;

		len = strlen(filename);
		pntpos = len-1;

		//Find the (right-most) point in the filename
		while(pntpos >= 0)
		{
				if( filename[pntpos] == '.' )
					break;

				pntpos = pntpos-1;
		}

		
		//There is free space for 'ii'
		if( pntpos < len-2 )
		{
				filename[pntpos+1] = 'i';
				filename[pntpos+2] = 'i';
				filename[pntpos+3] = '\0';
		}

		//There is free space for 'i'
		else if( pntpos < len-1 )
		{
				filename[pntpos+1] = 'i';
				filename[pntpos+2] = '\0';
		}
}



/** The HrwCC entry pointer -- here the story begins (in development: ended ;-) ) */
int main(int argc, char** argv)
{
		int idx;
		char* currarg;
		char* infile;
		int type;
		int error;

		//Parameters
		int printTree;
		int enDebug;
		int disLinker;
		int disComp;
		char outfile[MAX_FILENAME_LENGTH];

		//Some (optimizing) flags
		int enOptAsmpat;
		int enOptFastassign;

		//Contains the indices of argv elements which contains macros
		int macroargs[HRWCC_MAXMACROS];
		int macrocnt;
		//Contains the indices of argv elements which contains inputfiles
		int infileargs[HRWCC_MAXINFILES];
		int infilecnt;
		
		//tmp filename
		char tmpfilename[MAX_FILENAME_LENGTH];


		//No argument, end
		if( argc == 1 )
		{
			printUsage(argc, argv);
			return -1;
		}


		//Set default values
		printTree = 0;
		enDebug = 0;
		disLinker = 0;
		disComp = 0;
		strcpy(outfile, "outfile");

		enOptAsmpat = 0;
		enOptFastassign = 0;

		macrocnt = 0;
		infilecnt = 0;
		error = 0;
		memset(infileargs, 0, sizeof(int)*HRWCC_MAXINFILES);
		memset(macroargs, 0, sizeof(int)*HRWCC_MAXMACROS);

	

		//Parse options
		idx = 0;
		while( idx < argc-1 )
		{
				//goto next index
				idx = idx+1;
				//Get current argument
				currarg = argv[idx];

				//Found option
				if ( currarg[0] == '-' )
				{
						if( strcmp(currarg, "-g") == 0 )
							enDebug = 1;

						else if( strcmp(currarg, "-E") == 0)
							disComp = 1;

						else if( strcmp(currarg, "-c") == 0 )
							disLinker = 1;

						else if( strcmp(currarg, "-T") == 0 )
							printTree = 1;

						else if( strcmp(currarg, "-D") == 0 )
						{
								if( macrocnt == HRWCC_MAXMACROS )
								{
										puts("Error: Maximum number of macro defines reached!");
										return -1;
								}

								//Save index with macro definition
								macroargs[macrocnt] = idx;
								macrocnt = macrocnt + 1;
						}

						else if( strcmp(currarg, "-O") == 0)
						{
								enOptAsmpat = 1;
								enOptFastassign = 1;
						}

						else if( strcmp(currarg, "-ffastassign")==0 )
						{
								enOptFastassign = 1;
						}
						else if( strcmp(currarg, "-fasmpat")==0 )
						{
								enOptAsmpat = 1;
						}

						else if( strcmp(currarg, "-o") == 0 )
						{
								//Next has 
								idx = idx + 1;
								
								//Out of bounds!
								if( idx == argc )
								{
										puts("Error: No output file given!");
										return -1;
								}

								//Copy output file
								strncpy(outfile, argv[idx], MAX_FILENAME_LENGTH);
						}

						else
						{
								printf("Error: Invalid argument: %s\n\n", argv[idx]);

								printUsage(argc, argv);
								return -1;
						}

					//Read it
					continue;
				}


				//
				// No option -- inputfile
				//

				//Check for limits
				if( infilecnt == HRWCC_MAXINFILES )
				{
						puts("Error: Maximum number of input files reached!");
						return -1;
				}

				//Save argument index...
				infileargs[infilecnt]  = idx;
				infilecnt = infilecnt + 1;
		}



		//Run through all input files and handle them...
		idx = 0;
		while( idx < infilecnt )
		{
				//Get furrent infile
				infile = argv[infileargs[idx]];
				//Get current filetype
				type = hrwcc_getFiletype(infile);


				//If c-source code, compile it
				//After that
				if( type == HRWCC_FILETYPE_C )
				{
					//If compiling was not disabled
					if( ! disComp )
					{
						//Set tmpfilename-name
						strcpy(tmpfilename, infile);

						//If optimizing, compiler has non-optimized output
						if( enOptAsmpat )
							hrwcc_setToNonoptAsm(tmpfilename);
						//If not optimizing, compilers output is as it is
						else
							hrwcc_setToAsm(tmpfilename);

						//Compile it, and check for errors
						if( hrwcc_compile(infile, tmpfilename, 
								enDebug, printTree, argv, macroargs, macrocnt,
								enOptFastassign) < 0 )
							error = 1;


						//When we do optimizing at asm-level
						if( enOptAsmpat )
							hrwcc_asmOptimize(tmpfilename);

						//Set filename to assembler
						hrwcc_setToAsm(infile);
					}
					//Otherwise, just preprocess it
					else
					{
						//Just preprocess it
						if( hrwcc_preprocess(infile, argv, macroargs, macrocnt) < 0 )
							error = 1;

						//We set filename to *.i -- gcc does not preprocess it any more
						hrwcc_setToNonpreprocC(infile);
					}
				}

				idx = idx+1;
		}

		//And if linker and compiler are enabled -- link the output
		if( !disComp && !disLinker )
		{
				if( hrwcc_linkit(outfile, argv, infileargs, infilecnt, enDebug) < 0)
					error = 1;
		}	

		
		//Error occured!
		if( error )
		{
				puts("Error occured while compiling!\n");
				return -2;
		}

		puts("0 errors at all.\n");

		return 0;
}


