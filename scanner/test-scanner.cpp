
#include "../include/hrwcccomp.h"

#include "token.h"
#include "scanner.h"
#include "../preproc/preproc.h"
#include "../include/error.h"



int main()
{
		preproc pp;
		scanner testscanner;
		token tok;

		preproc_create(&pp, "input.c");
		scanner_init(&testscanner, &pp);

		tok.type = 1;

		while( tok.type > TOK_EOF )
		{
				scanner_getToken(&testscanner, &tok);
				printf("%2d", tok.type);
				printf(": %20s", tok.content);
				printf("  \t@ %2d", tok.pos_fileid);
				printf(", %3d", tok.pos_line);
				printf(", %2d\n", tok.pos_col);

				if( tok.type < 0)
						puts("Error occured.");
		}

		preproc_destroy(&pp);

		return 0;
}















