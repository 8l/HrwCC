/** This file is for testing purpose only -- it should be kept synchronized with test_parser() */

#include "input.h"


int firstglobal;
char* secondglobal;
secondstruct thirdglobal;

firststruct global4 [10];
char global5[6];


int function1( int arg1, char arg2, char* arg3)
{
		return 0;
}


void function1( int arg1, char arg2, char* arg2)
{
		return 0;
}


void function1( int arg1, char arg2, char* arg3)
{
		int local1;
		int* local2;
		firststruct local3;
}

int main( int argc, char** argv)
{
		int idx;
		int argc;
		char aa
		

		idx = 0;

		while( idx < argc )
		{
				printf("Pnt to el %d: %p\n", idx, argv[idx]);
		}
}


