//This file belongs to ../test-symbolTable.cpp:test_Sizeof -- please keep it synchronized

int a;
char b;
heho* p;

struct mystruct
{
		int a;
		mystruct* p;
		char b[100]; 

		//You may uncomment to detect circle dependencies
		//mystruct xx;
		int c;
};

struct mystruct2
{
		char a;
		mystruct b;
		int c;
};


mystruct c;
mystruct2 c1;
mystruct c2[3];
char c3[11];
unknowntype c4;


void test(int p1, char** p2, mystruct p3)
{
		int a[4];
		mystruct b[2];
		void c;
		char a;
		int* p1;
		unkowntype d;

		test( "hello" );
}
