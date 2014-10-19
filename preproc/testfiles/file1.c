#ifndef PREPROC_H
#define PREPROC_H

	#define PREPROC_EOF 1 //end-of-file

	#define MAX_INCLUDE_FILES 20       //number of includefiles on our stack
	#define MAX_INCLUDEFILE_LENGTH 64  //max length of a file in an include statement
	#define MAX_FILENAME_LENGTH 256    //max length of a file (MAX_INCLUDEFILE_LENGTH+path...)
	#define MAX_MACRO_NAME_LENGTH 64   //max length of a macro name
	#define MAX_LINE_LENGTH 512        //max length of a line
	#define MAX_PARAM_NAME_LENGTH 64   //max length of a parameter name in a macro
	#define BRANCH_STACK_SIZE 20       //max stack size for branches...

	#include "../testfiles/testheader.h"
	
        //datatype that is used in the preprocessor and also
	//returned in the API by it
	struct Character
	{
		char value; //'real' value of this Character
		int fileId; //fileId where this character originates
		int line;   //line where the character is located
		int column; //column where the character is located
	};

	//element in the filestack:
	struct FileStackItem
	{
		int fh;          //filehandle
		Character prev;  //previous character
		int fileId;      //id of the file that corresponds to the filename list
		int line;        //line of the file we are currently handling
		int column;      //column of the file we are currently handling
	};

	//we use a list to store all filenames
	DEFINE_LIST(FilenamesList, FilenameNode);
	PROTOTYPES_LIST(FilenamesList, FilenameNode);
	
	//element in our filename list
	struct FilenameNode
	{
		int id;
		char name[MAX_FILENAME_LENGTH];
		
		DEFINE_LINK(FilenamesList, FilenameNode);
	};
	
	//every parameter for a define/macro
	DEFINE_LIST(ParametersList, ParameterElement);
	PROTOTYPES_LIST(ParametersList, ParameterElement);

	struct ParameterElement
	{
		Character name[MAX_PARAM_NAME_LENGTH];        //original pattern we will find in the replacement
		Character replacement[MAX_PARAM_NAME_LENGTH]; //replacement name for the pattern (used in the macro call)
		DEFINE_LINK(ParametersList, ParameterElement);
	};

	//we use a list to store all defines
	DEFINE_LIST(DefinesList, DefineElementNode);
	PROTOTYPES_LIST(DefinesList, DefineElementNode);

	//define statement
	struct DefineElementNode
	{
		Character name[MAX_MACRO_NAME_LENGTH];
		Character *value;
		int valueLength;
		
		ParametersList parameters;
		DEFINE_LINK(DefinesList, DefineElementNode);
	};


	//whole line with characters
	struct CharacterLine
	{
		Character buffer[MAX_LINE_LENGTH]; 
		int length;      //how many characters in that line?
		int pos;         //position in the line we are dealing with
		int posInString; //current position in a string
		int posEscaped;  //current position escaped
		int skip;        //used by stages to indicate that it should not be handled internally
	};

	/**
	 * preproc instance which is passed to every preprocessing stage
	 */
	struct preproc
	{
		FileStackItem filestack[MAX_INCLUDE_FILES];  //stack which stores all opened files (through include)
		FilenamesList filenames;        // list with all filenames we are iterating through
		int currentFileIdx;             // stackpos where the next char can be read from

		CharacterLine commstage;        // buffer for the commstage
		CharacterLine directivestage;   // buffer for the directivestage
		DefinesList definesList;        // list of all defines
		int branchStack[BRANCH_STACK_SIZE]; //our "stack" for branches
		int branchStackIdx;             // current idx for the stack
		CharacterLine substage;         // buffer for the substitution stage
		DefineElementNode *replacement; // current replacement that is handled (if any)
		int replacementPos;             // position in the replacement we are at
		Character *paramReplacement;    // parameter we are handling (if any)
		int paramReplacementPos;        // position in the replacement parameter we are at
	};

	/* ================================ */
	/* public functions for preproc API */

	/**
	 * creates a new preprocessor instance and starts parsing
	 * the passed file.
	 * returns  0 if successful
	 *         <0 in case of error
	 */
	int preproc_create(preproc *instance, char *filename);

	/**
	 * destroys a preprocessor instance
	 * closes open files, deallocates allocated memory etc...
	 */
	void preproc_destroy(preproc *instance);

	/**
	 * passes the next character of the stream (with preprocessing already done)
	 * returns  0 if successful
	 *         <0 in case of error (NOTE: in case of error "nextChar" may contain an invalid value!)
	 */
	int preproc_getNext(preproc *instance, Character *next);

	/**
	 * returns the filename of the file that matches id in our filelist
	 * if id is an invalid value (not found in filelist) a negative value is returned
	 * and filename will not be set!
	 * returns NULL if an error occured
	 */
	char *preproc_getFilename(preproc *instance, int id);

#endif
