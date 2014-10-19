/**
 * All error/warning codes for the hrwcc compiler
 */
#ifndef ERROR_H
#define ERROR_H


	#define ERR_SCANNER_INVALIDCHAR             -1
	#define ERR_SCANNER_STATENOTHANDLED         -2
	#define ERR_SCANNER_DFANOTATSTART           -3
	#define ERR_SCANNER_MAXTOKEN                -4
	
	//ERRORS the preprocessor might return
	#define ERR_PREPROC_NOOP                    -10000 //nothing in process (if you call a preproc function without having a file in process or similar)
	#define ERR_PREPROC_FILESTACK_EXCEEDED      -10001 //too many include files... filestack exceeded
	#define ERR_PREPROC_MEM                     -10002 //out of memory
	
	//WARNINGS for the preprocessor (just internal usage)
	#define WARN_PREPROC_FOPEN                  -10500 //fopen() failed for various reasons
	#define WARN_PREPROC_FILENAME_TOO_LONG      -10501 //(include) filename too long
	#define WARN_PREPROC_MACRO_TOO_LONG         -10502 //some detected macro is too long!!
	#define WARN_PREPROC_MACRO_ALREADY_DEFINED  -10503 //macro already defined...
	#define WARN_PREPROC_INVALID_DIRECTIVE      -10504 //invalid/unsupported directive
	#define WARN_PREPROC_INCLUDE_INVALID        -10505 //invalid include statement
	#define WARN_PREPROC_INVALID_MACRONAME      -10506 //invalid macroname (no alpha at pos 0 i.e...)
	
	//ERRORS the linker might return
	#define ERR_LINKER_NOOP                     -20000 //no linker_create called before adding files...
	#define ERR_LINKER_OUTPUT_FOPEN             -20001 //output file could not be created
	#define ERR_LINKER_FOPEN                    -20002 //some file that should be linked could not be read...
	#define ERR_LINKER_MEM                      -20003 //out of memory
	#define ERR_LINKER_ENTRY_POINT_MISSING      -20004 //entry point (_main) is missing

#endif
