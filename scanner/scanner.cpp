/*
 * This file implements the whole scanner.
 */


#include "../include/hrwcccomp.h"

#include "scanner.h"
#include "token.h"
#include "../include/error.h"



//The start state has value 0
#define STATE_START 0
//The only end state is at 2000
#define STATE_DETECTED 2000

//All non-end-states have values 0<x<1000
#define STATE_I                   1
#define STATE_IN                  3
#define STATE_S                   5
#define STATE_ST                  6
#define STATE_STR                 7
#define STATE_STRU                8
#define STATE_STRUC               9
#define STATE_E                   11
#define STATE_EL                  12
#define STATE_ELS                 13
#define STATE_W                   15
#define STATE_WH                  16
#define STATE_WHI                 17
#define STATE_WHIL                18
#define STATE_R                   20
#define STATE_RE                  21
#define STATE_RET                 22
#define STATE_RETU                23
#define STATE_RETUR               24
#define STATE_C                   26
#define STATE_CO                  27
#define STATE_CON                 28
#define STATE_CONS                29
#define STATE_CH                  31
#define STATE_CHA                 32
#define STATE_V                   34
#define STATE_VO                  35
#define STATE_VOI                 36
#define STATE_HALFSTRING          37
#define STATE_HALFSINGLECHAR      38
#define STATE_SI                  39
#define STATE_SIZ                 40
#define STATE_SIZE                41
#define STATE_SIZEO               42
#define STATE_T                   43
#define STATE_TY                  44
#define STATE_TYP                 45
#define STATE_TYPE                46
#define STATE_TYPED               47
#define STATE_TYPEDE              48
#define STATE_B                   49
#define STATE_BR                  50
#define STATE_BRE                 51
#define STATE_BREA                52
#define STATE_CONT                53
#define STATE_CONTI               54
#define STATE_CONTIN              55
#define STATE_CONTINU             56
#define STATE_ESCHALFSTR          57
#define STATE_ESCHALFSGLCHAR      58


//All pre-end-states have numbers >= 1000. Every token is represented by an endstate
//In other words: the token number + 1000 is the state number
//THIS DEFINITIONS HAVE TO BE SYNCHRONIZED WITH token.h
#define STATE_EOF                 1000              // \0
#define STATE_CURPAR_BEGIN        1001              // { (curved parenthesis)
#define STATE_CURPAR_END          1002              // }
#define STATE_RECPAR_BEGIN        1003              // [ (rectengular parenthesis)
#define STATE_RECPAR_END          1004              // ]
#define STATE_RNDPAR_BEGIN        1005              // ( (round parenthesis)
#define STATE_RNDPAR_END          1006              // )
#define STATE_KOMMA               1007              // ,
#define STATE_SEMIKOLON           1008              // ;
#define STATE_POINT               1009              // .
#define STATE_ARROW               1010              // ->
#define STATE_EQUAL               1011              // =
#define STATE_IF                  1012              // if
#define STATE_ELSE                1013              // else
#define STATE_WHILE               1014              // while
#define STATE_RETURN              1015              // return
#define STATE_PLUS                1016              // +
#define STATE_MINUS               1017              // -
#define STATE_STAR                1018              // *
#define STATE_DIV                 1019              // /
#define STATE_PERCENT             1020              // %
#define STATE_AND                 1021              // &
#define STATE_PIPE                1022              // |
#define STATE_HAT                 1023              // ^
#define STATE_DBLAND              1024              // &&
#define STATE_DBLPIPE             1025              // ||
#define STATE_DBLEQUAL            1026              // ==
#define STATE_NOTEQUAL            1027              // !=
#define STATE_LESS                1028              // <
#define STATE_LESSEQUAL           1029              // <=
#define STATE_MORE                1030              // >
#define STATE_MOREEQUAL           1031              // >=
#define STATE_SNAKE               1032              // ~
#define STATE_CALLSIGN            1033              // !
#define STATE_STRUCT              1034              // struct
#define STATE_CONST               1035              // const
#define STATE_INT                 1036              // int
#define STATE_CHAR                1037              // char
#define STATE_VOID                1038              // void
#define STATE_SIZEOF              1039              // sizeof
#define STATE_TYPEDEF             1040              // typedef
#define STATE_BREAK               1041              // break
#define STATE_CONTINUE            1042              // continue
#define STATE_IDENT               1043              // an identifier like var
#define STATE_NUMBER              1044              // a number like 4322
#define STATE_STRING              1045              // a string like "hello"
#define STATE_SINGLECHAR          1046              // a single char like 'a'




/**
 * Check if the
 * */
int isIdentChar(char c)
{
		return isalnum(c) || c=='_';
}

/**Get token code of state*/
int getTokenCode(int state)
{
		//Maybe use something like STATE_I <= state <= STATE_CONTINU
		if( state < 1000 )
			state = STATE_IDENT;


		return state - 1000;
}


/**
 * This function represents the transition function of the scanner as
 * a finite deterministic automata.
 * Let A be the alphabeth (A=ASCII) and S be the states, then this
 * function is a function from the type SxA -> S.
 *
 * The DFA works in the following way: One can only say that a specific
 * token has been detected, when a further input has been read: For example
 * if you read "int" and there comes a 'a' than "inta" is an ident, not
 * the int-token. Therefore there are several 100x states which are directly
 * before the end state. For example, if '{' is read from the start-state the DFA
 * goes to the {-state. No matter which input is know read, the DFA goes to
 * the end-state. But if the DFA is alread in the if-state and a alphanum-input
 * or a _-input is read, then the DFA goes to the ident-token. In all other
 * cases the DFA goes to the end-token.
 *
 * By this the calling function has to remember the input and the old-state
 * when the end-state is reached. This input has to be applied for the next
 * detection. And the old-state is the detected token.
 *
 * returns:
 * 		-1 ... If invalid input has been detected
 * 		-2 ... If statii is not handled
 */
int scanner_transFunc(int state, char input)
{
		if( state == STATE_START )
		{
				if( input == '\0' )
						return STATE_EOF;
				if( input == '{' )
						return STATE_CURPAR_BEGIN;
				if( input == '}' )
						return STATE_CURPAR_END;
				if( input == '[' )
						return STATE_RECPAR_BEGIN;
				if( input == ']' )
						return STATE_RECPAR_END;
				if( input == '(' )
						return STATE_RNDPAR_BEGIN;
				if( input == ')' )
						return STATE_RNDPAR_END;
				if( input == ',' )
						return STATE_KOMMA;
				if( input == ';' )
						return STATE_SEMIKOLON;
				if( input == '.' )
						return STATE_POINT;
				if( input == '+' )
						return STATE_PLUS;
				if( input == '-' )
						return STATE_MINUS;
				if( input == '*' )
						return STATE_STAR;
				if( input == '/' )
						return STATE_DIV;
				if( input == '%' )
						return STATE_PERCENT;
				if( input == '&' )
						return STATE_AND;
				if( input == '|' )
						return STATE_PIPE;
					if( input == '^' )
						return STATE_HAT;
				if( input == '!' )
						return STATE_CALLSIGN;
				if( input == '=' )
						return STATE_EQUAL;
				if( input == '<' )
						return STATE_LESS;
				if( input == '>' )
						return STATE_MORE;
				if( input == '~' )
						return STATE_SNAKE;

				if( input == 'i' )
						return STATE_I;
				if( input == 's' )
						return STATE_S;
				if( input == 'e' )
						return STATE_E;
				if( input == 'w' )
						return STATE_W;
				if( input == 'r' )
						return STATE_R;
				if( input == 'c' )
						return STATE_C;
				if( input == 'v' )
						return STATE_V;
				if( input == 't' )
						return STATE_T;
				if( input == 'b' )
						return STATE_B;



				if( isdigit(input ) )
						return STATE_NUMBER;

				if( isalpha(input) || input=='_' )
						return STATE_IDENT;

				if( input == '\"' )
						return STATE_HALFSTRING;

				if( input == '\'' )
						return STATE_HALFSINGLECHAR;

				if( isWhitespace(input) )
						return STATE_START;


				printf("SCANNER_WARNING: Invalid input character %c", input);
				printf(" (0x%hhx) at (ignored).\n", input);

				return STATE_START;
		}

		else if( state == STATE_MINUS )
		{
		 	if( input == '>' )
						return STATE_ARROW;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_AND )
		{
				if( input == '&' )
						return STATE_DBLAND;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_PIPE )
		{
				if( input == '|' )
						return STATE_DBLPIPE;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_CALLSIGN )
		{
				if( input == '=' )
						return STATE_NOTEQUAL;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_EQUAL )
		{
				if( input == '=' )
						return STATE_DBLEQUAL;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_LESS )
		{
				if( input == '=' )
						return STATE_LESSEQUAL;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_MORE )
		{
				if( input == '=' )
						return STATE_MOREEQUAL;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_I )
		{
				if( input == 'f' )
						return STATE_IF;
				if( input == 'n' )
						return STATE_IN;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_IN )
		{
				if( input == 't' )
						return STATE_INT;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_INT )
		{
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_IF )
		{
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_S )
		{
				if( input == 't' )
						return STATE_ST;
				if( input == 'i' )
						return STATE_SI;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_ST )
		{
				if( input == 'r' )
						return STATE_STR;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_STR )
		{
				if( input == 'u' )
						return STATE_STRU;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_STRU )
		{
				if( input == 'c' )
						return STATE_STRUC;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_STRUC )
		{
				if( input == 't' )
						return STATE_STRUCT;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_STRUCT )
		{
				if( isIdentChar(input)  )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_SI )
		{
				if( input == 'z' )
						return STATE_SIZ;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_SIZ )
		{
				if( input == 'e' )
						return STATE_SIZE;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_SIZE )
		{
				if( input == 'o' )
						return STATE_SIZEO;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_SIZEO )
		{
				if( input == 'f' )
						return STATE_SIZEOF;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_SIZEOF )
		{
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_E )
		{
				if( input == 'l' )
						return STATE_EL;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}
		
		else if( state == STATE_EL )
		{
				if( input == 's' )
						return STATE_ELS;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_ELS )
		{
				if( input == 'e' )
						return STATE_ELSE;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_ELSE )
		{
				if( isIdentChar(input)  )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_W )
		{
				if( input == 'h' )
						return STATE_WH;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_WH )
		{
				if( input == 'i' )
						return STATE_WHI;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_WHI )
		{
				if( input == 'l' )
						return STATE_WHIL;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_WHIL )
		{
				if( input == 'e' )
						return STATE_WHILE;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_WHILE )
		{
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_R )
		{
				if( input == 'e' )
						return STATE_RE;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_RE )
		{
				if( input == 't' )
						return STATE_RET;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_RET )
		{
				if( input == 'u' )
						return STATE_RETU;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_RETU )
		{
				if( input == 'r' )
						return STATE_RETUR;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_RETUR )
		{
				if( input == 'n' )
						return STATE_RETURN;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_RETURN )
		{
				if( isIdentChar(input)  )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_C )
		{
				if( input == 'o' )
						return STATE_CO;
				if( input == 'h' )
						return STATE_CH;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_CO )
		{
				if( input == 'n' )
						return STATE_CON;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_CON )
		{
				if( input == 's' )
						return STATE_CONS;
				if( input == 't' )
						return STATE_CONT;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_CONS )
		{
				if( input == 't' )
						return STATE_CONST;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_CONST )
		{
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_CONT )
		{
				if( input == 'i' )
						return STATE_CONTI;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_CONTI )
		{
				if( input == 'n' )
						return STATE_CONTIN;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_CONTIN )
		{
				if( input == 'u' )
						return STATE_CONTINU;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_CONTINU )
		{
				if( input == 'e' )
						return STATE_CONTINUE;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_CONTINUE )
		{

				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_CH )
		{
				if( input == 'a' )
						return STATE_CHA;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_CHA )
		{
				if( input == 'r' )
						return STATE_CHAR;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_CHAR )
		{
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_V )
		{
				if( input == 'o')
						return STATE_VO;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_VO )
		{
				if( input == 'i' )
						return STATE_VOI;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_VOI )
		{
				if( input == 'd' )
						return STATE_VOID;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_VOID )
		{
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_T )
		{
				if( input == 'y')
						return STATE_TY;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_TY )
		{
				if( input == 'p')
						return STATE_TYP;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_TYP )
		{
				if( input == 'e')
						return STATE_TYPE;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_TYPE )
		{
				if( input == 'd')
						return STATE_TYPED;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_TYPED )
		{
				if( input == 'e')
						return STATE_TYPEDE;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_TYPEDE )
		{
				if( input == 'f')
						return STATE_TYPEDEF;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_TYPEDEF )
		{
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_B )
		{
				if( input == 'r')
						return STATE_BR;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_BR )
		{
				if( input == 'e')
						return STATE_BRE;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_BRE )
		{
				if( input == 'a')
						return STATE_BREA;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_BREA )
		{
				if( input == 'k')
						return STATE_BREAK;
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_BREAK )
		{
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		//These statii can not be combined with another
		//character to form an alternative token
		else if( state == STATE_EOF ||
				state == STATE_CURPAR_BEGIN ||
				state == STATE_CURPAR_END ||
				state == STATE_RECPAR_BEGIN ||
				state == STATE_RECPAR_END ||
				state == STATE_RNDPAR_BEGIN ||
				state == STATE_RNDPAR_END ||
				state == STATE_KOMMA ||
				state == STATE_SEMIKOLON ||
				state == STATE_POINT ||
				state == STATE_ARROW ||
				state == STATE_PLUS ||
				state == STATE_STAR ||
				state == STATE_DIV ||
				state == STATE_PERCENT ||
				state == STATE_HAT ||
				state == STATE_DBLAND ||
				state == STATE_DBLPIPE ||
				state == STATE_DBLEQUAL ||
				state == STATE_NOTEQUAL ||
				state == STATE_LESSEQUAL ||
				state == STATE_MOREEQUAL ||
				state == STATE_SNAKE ||
				state == STATE_STRING ||
				state == STATE_SINGLECHAR
				)
		{
				return STATE_DETECTED;
		}

		else if( state == STATE_IDENT )
		{				
				if( isIdentChar(input) )
						return STATE_IDENT;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_NUMBER )
		{
				if( isdigit(input) )
						return STATE_NUMBER;
				else
						return STATE_DETECTED;
		}

		else if( state == STATE_HALFSTRING )
		{
				if( input == '\"' )
						return STATE_STRING;
				else if( input == '\\' )
						return STATE_ESCHALFSTR;
				else
						return STATE_HALFSTRING;
		}

		else if( state == STATE_HALFSINGLECHAR)
		{
				if( input == '\'' )
						return STATE_SINGLECHAR;
				else if( input == '\\' )
						return STATE_ESCHALFSGLCHAR;
				else
						return STATE_HALFSINGLECHAR;
		}

		else if( state == STATE_ESCHALFSTR )
		{
				return STATE_HALFSTRING;
		}

		else if( state == STATE_ESCHALFSGLCHAR )
		{
				return STATE_HALFSINGLECHAR;
		}


		printf("SCANNER_ERROR: Scanner state not handled by transition function! (%d)\n", state);
		return ERR_SCANNER_STATENOTHANDLED;
}



/**
 * The scanner wants to read a new character
 */
void scanner_readChar(scanner* scan)
{
		//Get next character from preproc
		preproc_getNext(scan->pp, &scan->nextinput);
}


/**Initialize the scanner*/
int scanner_init(scanner* scan, preproc* pp)
{
		//Clear scanner
		memset( scan, 0, sizeof(scanner));

		//Initialize scanner
		scan->pp = pp;
		scan->state = STATE_START;
		scanner_readChar(scan);

		return 0;
}


/**
 * Get a new token from scanner, the scanner must have already
 * a character in the nextinput member.
 * if token-type is negative -- its a error code*/
int scanner_getToken(scanner* scan, token* tok)
{
		int idx;
		int newstate;

		idx = 0;


		//DFA is not initialized
		if( scan->state != STATE_START )
		{
				printf("SCANNER_ERROR: Scanner was not intialized. (%d)\n", scan->state);
				tok->type = ERR_SCANNER_DFANOTATSTART;
				return -1;
		}


		//Reset positions
		tok->pos_line = -1;
		tok->pos_col = -1;
		tok->pos_fileid = -1;


		//As long as we didn't detected a token, let the
		//DFA process...
		while( 1 )
		{
				//We reached max size!
				if( idx >= TOKEN_MAX_SIZE-1 )
				{
					printf("SCANNER_ERROR: Scanner reached max. token size. (%d)\n", TOKEN_MAX_SIZE);
					break;
				}
	

				//Go to new state
				newstate = scanner_transFunc(scan->state, scan->nextinput.value);


				//Save next character
				if( newstate != STATE_START && newstate != STATE_DETECTED )
				{
					tok->content[idx] = scan->nextinput.value;		
					idx = idx + 1;

					//For the first character, save the position and
					if(idx == 1)
					{
						tok->pos_line = scan->nextinput.line;
						tok->pos_col = scan->nextinput.column;
						tok->pos_fileid = scan->nextinput.fileId;
					}
				}


				//Detected a token!
				if( newstate == STATE_DETECTED )
				{
						//Save the state which is coding the token type
						tok->type = getTokenCode(scan->state);						
						//We do not goto next character here, because this
						//character has to be used next run again.
						break;
				}
				//Error occured
				if( newstate < 0)
				{
						//Save error code as token type
						tok->type = newstate;
						//Read next character to skip error
						scanner_readChar(scan);
						break;
				}

				//Set new state
				scan->state = newstate;
				//Read next character to detect
				scanner_readChar(scan);
		}

		//Set scanner to start state
		scan->state = STATE_START;
		//Terminate string
		tok->content[idx] = '\0';

		return 0;
}







