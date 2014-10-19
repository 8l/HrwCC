//This file belongs to ../test-symbolTable.cpp:test_Functions -- please keep it synchronized


struct mystruct
{
		int a;
		mystruct* p;
		char b[100]; 
};


//Wrong datatypes
void test(unknowntype _p1, char** _p2, mystruct _p3);

void test(int _p1, char** _p2, mystruct _p3);

//Twice same parameter name
void test(int p1, char** p1, mystruct p3)
{
		int d[4];
		mystruct e[2];
		void f;
}

//This should be passed ok
void test(int p1, char** p2, mystruct p3)
{
		int d[4];
		mystruct e[2];
		void f;
}

//Redefinition
void test(int p1, char** p2, mystruct p3)
{
		int d[4];
		mystruct e[2];
		void f;
}


//Should NOT pass
void test( int p1, char** p2 );
//Should NOT pass
void test( char p1, char** p2, mystruct p3);
//Should NOT pass
int test(int _p1, char** _p2, mystruct _p3);

//Redeclaration, don't care
void test(int _p1, char** _p2, mystruct _p3);
