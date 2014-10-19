#include "../include/hrwcccomp.h"
#include "../include/error.h"

#include "preproc.h"

int main()
{
	int result;
	Character next;
	char *filename;
	preproc preprocinst;

	preproc_create(&preprocinst, "../symbolTable/test-symbolTable.cpp");
	
    preproc_addDefine(&preprocinst, "__HRWCC__");


	result =  preproc_getNext(&preprocinst, &next);

	while ( result  != PREPROC_EOF )
	{
		if ( result != 0 )
		{
			filename = preproc_getFilename(&preprocinst, next.fileId);
			
			printf("\n       EXIT-STATUS: [%d]", result);
			printf(" in [%d]", next.fileId);
			printf("[%s]", filename);
			printf(" on line [%d]", next.line);
			printf(" column [%d]\n", next.column);

			exit(0);
		}

		printf("%c", next.value);

		result = preproc_getNext(&preprocinst, &next);
	}
	
	preproc_destroy(&preprocinst);

	return 0;
}
