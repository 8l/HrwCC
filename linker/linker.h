#ifndef LINKER_H
#define LINKER_H

	#include "../include/common.h"
	#include "../util/list.h"

	#define MAX_ADDR_LENGTH 8       //max length for addresses - used when converting int to string
	#define COMMENT_SYMBOL '#'
	#define EXEC_ENTRY_POINT "main"
	#define MAX_LINE_LENGTH 512     //max length of a line in the assembler source
	#define TEXT_OFFSET 3           //addr 0 is call "main"

	//a marker is either a globl or a "marker" (<label>:)
	struct Marker
	{
		char name[MAX_IDENT_LENGTH];       //name of the marker
		int addr;                          //address in the executable
		DEFINE_LINK(MarkersList, Marker);  //link to the next element
	};

	//list of markers
	DEFINE_LIST(MarkersList, Marker);
	PROTOTYPES_LIST(MarkersList, Marker);
	
	//list of all input files
	//so we can store debugging information to each line
	struct File
	{
		int id;                         //id of the file in the list
		char name[MAX_FILENAME_LENGTH]; //name of the file
		
		int add_debug_symbols;          //show debug symbols for this file?
		MarkersList markers;            //(local) markers of this file

		DEFINE_LINK(FilesList, File);
	};

	DEFINE_LIST(FilesList, File);
	PROTOTYPES_LIST(FilesList, File);

	//list of "lines" for the commands
	struct Line
	{
		//information about the line
		char buffer[MAX_LINE_LENGTH];
		int length;
		int pos;

		//some properties about the line
		int is_debug_line;
		int is_globl_line;
		int is_marker_line;

		//address in the resulting output file
		int addr;

		//debugging information
		int file_id;
		int line_no;

		DEFINE_LINK(LinesList, Line);
	};

	DEFINE_LIST(LinesList, Line);
	PROTOTYPES_LIST(LinesList, Line);

	//linker instance
	struct linker
	{
		int initiated;           //just a flag to make sure create() was called
		int output_fh;           //file handle for the output file

		MarkersList globls;      //name/addr pairs of globl statements
		MarkersList restricted;  //list of labels that MAY NOT be replaced!! (i.e. libc functions - treated by VM)

		FilesList files;         //files list (for debugging purposes)

		LinesList text_section;  //commands for the text section
		LinesList data_section;  //commands for the data section

		int text_addr;           //next address in text section
		int data_addr;           //next address in data section
	};

	/* ================================ */
	/* public functions for preproc API */

	/**
	 * create a linker instance
	 */
	int linker_create(linker *instance);

	/**
	 * destroy a previously created linker instance
	 * NOTE: when linker_create has been called you always have
	 *       to call linker_destroy - even if some error occured during
	 *       appendFile() or produce()!!
	 */
	int linker_destroy(linker *instance);

	/**
	 * append the given file to the linkers executable output_file
	 * if add_debugging_symbols is set to 1 all comments/labels etc. will remain
	 * in the produced output and some more will be appended...
	 * a negative return value indicates an error while
	 * linking this file
	 */
	int linker_appendFile(linker *instance, char *file_name, int add_debugging_symbols);
	
	/**
	 * flushes the collected data into a file "output_filename"
	 * the _main entry point will be inserted accordingly
	 * all markers will be resolved. if markers can not be resolved
	 * linker errors will be produced and the output file will be void
	 */
	int linker_produce(linker *instance, char *output_filename);

#endif
