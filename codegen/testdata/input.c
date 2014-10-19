/** This file is for testing purpose only -- it should be kept synchronized with test_parser() */

struct firststruct
{
		int a[3];
		char b;
		int c;
		firststruct* d;
		int* e;
};


struct secondstruct
{
		secondstruct* next;
		firststruct first;
};


void printf(char* str, int a, int b, int c);


void test(firststruct f)
{
		printf("Val: %d, %d, %d\n", f.c, 0, 0);
}


void main( int argc, char** argv)
{
		firststruct f1;
		firststruct f2;


		f1.c = 10;

		test(f1);

		return;
}



