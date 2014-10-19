#ifndef STAGEUTILS_H
#define STAGEUTILS_H

	#include "../include/error.h"
    #include "filestack.h"

    /**
     * each stage has an unique id
     * by using this id it can read a char from the previous stage
     */
    #define FILESTACKSTAGE 0
	#define COMMSTAGE 1
	#define DIRECTIVESTAGE 2
    #define SUBSTAGE 3
    #define FINALSTAGE 4

	#define PREPROC_WARNING 1
	#define PREPROC_ERROR 2
	void preproc_reportError(preproc *instance, char *errstr, CharacterLine *line, int type);
	void preproc_reportError_s(preproc *instance, char *errstr_format, char *arg1, int type);

    /**
     * returns 1 if the given code is an error code
     * it returns 0 otherwise
     */
    int isPreprocError(int code);

    /**
     * returns 1 if the given code is a warning code
     * it returns 0 otherwise
     */
    int isPreprocWarning(int code);

    /**
     * initializes and resets a given line structure
     */
    void initLine(CharacterLine *line);
    
    /**
     * updates line properties like begin escaped and within a string etc
     * appropriate to the current line->pos
     */
    void updateLineProperties(CharacterLine *line);
    
    /**
     * dispose whitespace starting from line->pos
     */
    void disposeWhitespace(CharacterLine *line);
    
    /**
     * disposes the rest of the line
     * (moves position pointer to newline character)
     */
    void disposeRestOfLine(CharacterLine *line);

    /**
     * generic function that reads form the previous stage
     * filestack is no stage...
     */
    int prevstage_getNext(preproc *instance, int curr_stage, Character *next);

    /**
     * get next line from the previous stage
     * it returns  0 if everything went ok
     *            <0 if an error occured
     */
    int getNextLine(preproc *instance, int curr_stage, CharacterLine *line);

	/**
	 * checks if the current line is a multiline statement (ended with \\n)
	 * if it is so it this function disposes all following
	 * multilines
	 * the first non-multiline is passed back in line
     * it returns  0 if everything went ok
     *            <0 if an error occured
	 */
	int disposeMultilineSatement(preproc *instance, int curr_stage, CharacterLine *line);
    
    /**
     * prints the characters in the given buffer to the stdout
     * stops at the terminating character \0
     */
    void printCharacters(Character *s);
    
    /**
     * compares the given string with 'length' characters starting from start
     * in the buffer
     */
    int CharacterStrCmp(Character *buffer, int start, int length, char *cmp);
     
    /**
     * compares the first 'length' chars of s1 starting at 'start' with s2
     */
    int CharacterSubCmp(Character *s1, int start, int length, Character *s2);

    /**
     * like strcmp just for Character buffers
     */
    int CharacterCmp(Character *s1, Character *s2);
    
    /**
     * like strlen just for Character buffers
     */
    int CharacterLen(Character *s);
    
    /**
     * like strcpy just for Character buffers
     */
    int CharacterCpy(Character *dest, Character *src);
    
    /**
     * like strcat just for Character buffers
     */
    int CharacterCat(Character *dest, Character *src);

    /**
     * tests if a given macro "name" is already in the global macro list
     */	
    int isMacroDefined(preproc *instance, Character *name);

    /**
     * get next identifier from the line starting to gather at line->pos
     * returns 0 if everything went ok
     * and !=0 if some wrong characters were found (i.e. at the beginning)...
     */
     int getNextIdentifier(Character *buffer, int buffer_length, CharacterLine *line);
    
    /**
     * parses a parameterlist like: (param1, param2, param3)
     * does appropriate error handling
     * if idents_only is set getNextIdentifier is used to get the parameters
     * otherwise all characters between commas are gathered
     * returns 0 if successful, !=0 if some error/warning occured
     */
    int parseParametersList(preproc *instance, ParametersList *parameters, CharacterLine *line, int idents_only);
    
#endif
