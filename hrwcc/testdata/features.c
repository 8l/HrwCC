/**
 * This file will present all features of the compiler
 */

/** Prototype to call libc function */
void printf(char* text, int value);
void puts(char* text);
	

#define TESTIT(str, expr, res)			printf(str, expr); 	\
						printf("\t\t-->", 0);		\
						if( (expr) == res )  	\
							ok();			\
						else				\
							failed()



struct firststruct
{
		int a[2];
		char b;
		secondstruct* c;
};

struct secondstruct
{
		char a[5];
		int b;
		firststruct* c;
		secondstruct* next;
};


/**
 * To test:
 * 		void function cannot be called to get value of
 * 		return val only for return-typed functions
 */


int failed()
{
		puts("FAILED!");
		return 0;
}

int ok()
{
		puts("OK");
		return 0;
}


void testBytedata()
{
		char b;
		char c;


		puts("");
		puts("Test byte data:");


		b = -4;
		puts("b = -4");

		c = b-124;
		puts("c = b-124");
		TESTIT("c : %d", c, -128);

		c = b-125;
		puts("c = b-125");
		TESTIT("c : %d", c, 127);

		c = b+6;
		puts("c = b+6");
		TESTIT("c : %d", c, 2);
}


void testExpressions()
{
		int val;

		puts("");
		puts("Test expressions:");

		//Test logical 'and' and 'or' + lazy evaluation
		TESTIT("1 && 0 && failed() : %d", 1 && 0 && failed() , 0 );
		TESTIT("1 && 1 : %d", 1 && 1, 1  );
		TESTIT("0 || 0 : %d", 0 || 0, 0 );
		TESTIT("1 || 1 || failed() : %d", 1 || 1 || failed(), 1 );
		TESTIT("! 1 : %d", ! 1, 0);
		TESTIT("! 0 : %d", ! 0, 1);
		TESTIT("0 == 0 : %d", 0 == 0, 1 );
		TESTIT("0 == 1 : %d", 0 == 1, 0 );
		TESTIT("0 != 0 : %d", 0 != 0, 0 );
		TESTIT("0 != 1 : %d", 0 != 1, 1 );
		TESTIT("0 <= 1 : %d", 0 <= 1, 1 );
		TESTIT("1 <= 0 : %d", 1 <= 0, 0 );
		TESTIT("0 >= 1 : %d", 0 >= 1, 0 );
		TESTIT("1 >= 0 : %d", 1 >= 0, 1 );
		TESTIT("0 < 1 : %d", 0 < 1, 1 );
		TESTIT("1 < 0 : %d", 1 < 0, 0 );
		TESTIT("0 > 1 : %d", 0 > 1, 0 );
		TESTIT("1 > 0 : %d", 1 > 0, 1 );
		TESTIT("1 + 3 : %d", 1 + 3, 4);
		TESTIT("1 - 3 : %d", 1 - 3, -2);
		TESTIT("6 & 4 : %d", 6 & 4, 4);
		TESTIT("6 ^ 4 : %d", 6 ^ 4, 2);
		TESTIT("6 * 4 : %d", 6 * 4, 24);
		TESTIT("6 / 4 : %d", 6 / 4, 1);
		TESTIT("6 % 4 : %d", 6 % 4, 2);
		TESTIT("~7 : %d", ~7, -8);
		TESTIT("-7 : %d", -7, -7);
		TESTIT("-1 + (2+4)*6 + 2 : %d", -1+ (2+4)*6 + 2, 37);
		TESTIT(" 1 || 0 && failed() : %d", 1 || 0 && failed(), 1);
		TESTIT(" 0 && failed() || 1 : %d", 0 && failed() || 1, 1 );
}


void testStatements()
{
		int idx;
		int cnt;

		puts("");
		puts("Test statements:");

		if( 1 )
			ok();
		else
			failed();

		if( 0 )
		{
			failed();
		}
		else
		{
			ok();
		}

		cnt = 3;
		idx = 0;
		while(idx < cnt)
		{
				idx = idx+1;
		}

		if( idx == cnt )
			ok();
		else
			failed();


		cnt = 3;
		idx = 0;

		while( 1 )
		{
				if( idx == cnt)
					break;
				
				idx = idx+1;
		}

		if( idx == cnt)
			ok();
		else
			failed();

		cnt = 3;
		idx = 0;

		while( 1 )
		{
				idx = idx+1;

				if( idx < cnt)
					continue;

				break;				
		}

		if( idx == cnt)
			ok();
		else
			failed();


		if( 1 )
			return;

		failed();
}

//A global variable
secondstruct s1;
int i1;


void testVariables()
{
		char c1;
		int* pi1;
		int iarr1[10];
		firststruct f1;
		firststruct f2;
		secondstruct s2;


		puts("");
		puts("Test variable expression:");

		TESTIT("sizeof(int) : %d", sizeof(int), 4);
		TESTIT("sizeof(char) : %d", sizeof(char), 1);
		TESTIT("sizeof(void*) : %d", sizeof(void*), 4);

		//You may want to look at source code here
		//We really handle bytes here
		c1 = 'a';
		i1 = c1;
		c1 = i1;
		//puts(c1);

		//Casting around, should not matter
		TESTIT("c1 : %d", c1, 'a');
		
		i1 = 5;
		c1 = 2;
		pi1 = &i1;

		TESTIT("*pi1 == i1: %d", *pi1 == i1, 1);
		TESTIT("pi1 == &i1: %d", pi1 == &i1, 1);

		//Casting from char to int, access to int-pointer
		*pi1 = c1;
		TESTIT("*pi1 == c1: %d", *pi1 == c1, 1);

		//Pointer points to array, set element via pointer
		//and test in array
		pi1 = iarr1;
		pi1[2] = 6;
		TESTIT("iarr1[2] == 6: %d", iarr1[2] == 6, 1);

		//type extension of pointer arrithmetic.
		//Get address of array element
		TESTIT("&iarr1[2] == pi1+2: %d", &iarr1[2] == pi1+2, 1);
		TESTIT("&pi1[2] == pi1+2: %d", &pi1[2] == pi1+2, 1);


		//Link some pointers
		s2.next = &s1;
		s1.c = &f1;
		pi1 = f1.a;

		//Test nested variables 
		TESTIT("s2.next->c == &f1: %d", s2.next->c == &f1, 1);

		//Cast a value to int
		pi1[1] = 'a';
		TESTIT("s2.next->c->a[1] == 'a': %d", s2.next->c->a[1] == 'a', 1);


		//copy full struct!
		f2 = f1;
		TESTIT("f2.a[1] == 'a': %d", f2.a[1] == 'a', 1);

}


int testFunc1(int a, int* b, firststruct f1, firststruct* f2)
{
		a = 1;
		*b = 2;
		f1.b = 3;
		f2->b = 4;

		return 5;
}

int testFunc2(int* arr)
{
		arr[2] = 7;
}


void testFunctions()
{
		int a;
		int b;
		firststruct f1;
		firststruct f2;
		int ret;
		int arr[6];

		puts("");
		puts("Test function calls:");


		a = 0;
		b = 0;
		f1.b = 0;
		f2.b = 0;

		//By the way: We pass here full structures!
		ret = testFunc1(a, &b, f1, &f2);

		TESTIT("ret: %d", ret, 5);
		TESTIT("a: %d", a, 0);
		TESTIT("b: %d", b, 2);
		TESTIT("f1.b: %d", f1.b, 0);
		TESTIT("f2.b: %d", f2.b, 4);

		//A array is handled like a pointer, like char** argv in main
		testFunc2(arr);
		TESTIT("arr[2]: %d", arr[2], 7);
}



/** This is the unique entry point */
int main( int argc, char** argv)
{
		puts("\\ Features /");

		testStatements();
		testExpressions();
		testVariables();
		testFunctions();
		testBytedata();

		puts("");
		//This is the exit code to the operating system / VM
		return 1;
}






