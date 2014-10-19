#ifndef HRWCC_COMMON_H
#define HRWCC_COMMON_H

	/**
	 * this file is supposed to hold general settings
	 * for the hrwcc compiler
	 */
	#define MAX_FILENAME_LENGTH 256 //max length of a file (MAX_INCLUDEFILE_LENGTH+path...)
	#define MAX_IDENT_LENGTH 128    //max length of an identifier

	#define isWhitespace(c) (isblank(c)==1 || c=='\n')

#endif
