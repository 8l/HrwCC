#ifndef UTILS_H
#define UTILS_H

	#include "linker.h"
	
	struct Token
	{
		char value[MAX_IDENT_LENGTH];   //name of the marker
		DEFINE_LINK(TokensList, Token); //link to the next element
	};

	//list of tokens for the tokenizer
	DEFINE_LIST(TokensList, Token);
	PROTOTYPES_LIST(TokensList, Token);

	/**
	 * tokenizes the given string
	 * returns < 0 on error
	 */
	int tokenizeString(TokensList *list, char *str);
	
	/**
	 * get size of tokens list
	 */
	int getTokensListSize(TokensList *list);
	
	/**
	 * free tokens list
	 */
	void freeTokensList(TokensList *list);

	/**
	 * print the tokens list
	 */
	void printTokensList(TokensList *list);

	/**
	 * read till newline symbol from the given file handle
	 * or <0 if an error occured...
	 */
	int readLine(linker *instance, int fh, Line *line);
	
	/**
	 * write a line of characters (newline symbol will be appended automagically)
	 * to the given output_file(handle)
	 */
	int appendOutput(linker *instance, char *line);
	
	/**
	 * copies the number of addr into the buffer
	 * and returns the buffer
	 */
	char *convertAddr(char *buffer, int addr);
	
	/**
	 * free the elements in the given list
	 */
	void freeMarkersList(MarkersList *list);
	void freeLinesList(LinesList *list);
	void freeFilesList(FilesList *list);
	
	/**
	 * get filename according to file_id in the filesList
	 */
	char *getFilename(linker *instance, int file_id);
	
	/**
	 * add the given file_name to the files list and
	 * returns the newly created File object
	 * or NULL in case of memory could not be allocated
	 */
	File *addFileToList(linker *instance, char *file_name);
	
	/**
	 * returns the File object to the given file_id
	 */
	File *getFileOfList(linker *instance, int file_id);

	/**
	 * dispose the whitespace at the lines current position
	 * line->pos will be set appropriate after calling this function
	 */
	void lnk_disposeWhitespace(Line *line);
	
	/**
	 * scans the line for any comment symbols
	 * if a symbol is found, the rest of the line will be
	 * dispose
	 */
	void disposeComments(Line *line);
	
	/**
	 * creates a COPY of the line and appends it to the list
	 * (so a line will be allocated and stored in the list)
	 * in case of error <0 will be returned...
	 */
	int addLine(LinesList *list, Line *line);
	
	/**
	 * comments the given line (adds a COMMENT_SYMBOL on position 0)
	 * and appends "append" to the lines buffer (if given)
	 */
	int commentLine(linker *instance, Line *line, char *append);

	/**
	 * tries to collect the next identifier starting at the
	 * given lines pos (line->pos) - it disposes possible whitespace
	 * line->pos will only be moved if a valid identifier is found
	 * identifier is expected to be MAX_IDENT_LENGTH in size
	 * return value:
	 *       < 0 inidicates an error (identifier overflow)
	 *       0 no identifier found on position (other chars than alpha|_ at first position)
	 *       1 identifier found (identifier will be filled with the identifier)
	 */
	int getNextIdentifierInLine(linker *instance, Line *line, char *identifier);

	/**
	 * compares a substring of s with the passed pattern
	 * comparison starts at start_pos
	 */
	int substrcmp(char *s1, int start_pos, char *s2);

#endif
