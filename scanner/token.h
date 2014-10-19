/**
 * Define token structure and all token types
 */


#ifndef TOKEN_H
#define TOKEN_H


//The maximum size of a token, i.e. identifier for variable
#define TOKEN_MAX_SIZE 128


//All token-types detected by the scanner
//THIS DEFINITIONS HAVE TO BE SYNCHRONIZED WITH scanner.c
#define TOK_EOF				0		// \0
#define TOK_CURPAR_BEGIN	1		// { (curved parenthesis)
#define TOK_CURPAR_END		2		// }
#define TOK_RECPAR_BEGIN	3		// [ (rectengular parenthesis)
#define TOK_RECPAR_END		4		// ] 
#define TOK_RNDPAR_BEGIN	5		// ( (round parenthesis)
#define TOK_RNDPAR_END		6		// )
#define TOK_KOMMA			7		// ,
#define TOK_SEMIKOLON		8		// ;
#define TOK_POINT			9		// .
#define TOK_ARROW			10		// ->
#define TOK_EQUAL			11		// =
#define TOK_IF				12		// if
#define TOK_ELSE			13		// else
#define TOK_WHILE			14		// while
#define TOK_RETURN			15		// return
#define TOK_PLUS			16		// +
#define TOK_MINUS			17		// -
#define TOK_STAR			18		// *
#define TOK_DIV				19		// /
#define TOK_PERCENT			20		// %
#define TOK_AND				21		// &
#define TOK_PIPE			22		// |
#define TOK_HAT				23		// ^
#define TOK_DBLAND			24		// &&
#define TOK_DBLPIPE			25		// ||
#define TOK_DBLEQUAL		26		// ==
#define TOK_NOTEQUAL		27		// !=
#define TOK_LESS			28		// <
#define TOK_LESSEQUAL		29		// <=
#define TOK_MORE			30		// >
#define TOK_MOREEQUAL		31		// >=
#define TOK_SNAKE			32		// ~
#define TOK_CALLSIGN		33		// !
#define TOK_STRUCT			34		// struct
#define TOK_CONST			35		// const
#define TOK_INT				36		// int
#define TOK_CHAR			37		// char
#define TOK_VOID			38		// void
#define TOK_SIZEOF			39		// sizeof
#define TOK_TYPEDEF			40		// typedef
#define TOK_BREAK  			41		// break  
#define TOK_CONTINUE		42		// continue
#define TOK_IDENT			43		// an identifier like var
#define TOK_NUMBER			44		// a number like 4322
#define TOK_STRING			45		// a string like "hello"
#define TOK_SINGLECHAR		46		// a single char like 'a'



struct token
{
		/** Type of token */
		int type;

		/** Some position information */
		int pos_col;
		int pos_line;
		int pos_fileid;

		/** The input which has been read to detect token */
		char content[TOKEN_MAX_SIZE];
};



#endif

