/**
 * Define a scanner and its public functions to access the scanner.
 */


#ifndef SCANNER_H
#define SCANNER_H

#include "token.h"
#include "../preproc/preproc.h"


struct scanner
{
		//The next character to process
		Character nextinput;

		//The state of the DFA
		int state;

		//The preprocessor which is used.
		preproc* pp;
};


/**Initialize the scanner with a preprocessor*/
int scanner_init(scanner* scan, preproc* pp);

/**Get a new token from scanner*/
int scanner_getToken(scanner* scan, token* tok);



#endif
