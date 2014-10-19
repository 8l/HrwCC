
//Define prototype, need not implement this! - libc stuff
void printf(char* text, int a, int b, int c);
void puts(char* text);


int euklidggt( int var1, int var2 )
{
		int div;
		int mod;


		//Swap both
		//Make that var1>=var2
		if( var1 < var2 && var2 > var1 )
		{
				div = var1;
				var1 = var2;
				var2 = div;
		}


		// ||0 is nothing
		while( var2 > 1  || 0 )
		{
			div = var1 / var2;
			mod = var1 % var2;

			var1 = var2;
			var2 = mod;
		}

		//6%2 and 2/4 is 0
		return var1*1 + (6%2) + 2/4;
}


void test( char ch )
{
		char text[4];

		text[0] = ch;
		text[1] = '\n';
		text[2] = '\0';

		puts("hello\n");

		puts(text);
		puts("hello\n");
}


struct mystruct
{
	int m[3];
};

struct mystruct2
{
		mystruct a;
		mystruct2* b;
};

mystruct2 g2;
mystruct2 g3;
mystruct* g4;


int main(int argc, char** argv)
{
		char second;
		//Pointer to char second
		char* ps;
		int loc;

		//Save addr of second
		ps = &second;

		//  g2 is the common variable
		//  g3 and g4 point to members of g2
		g4 = &g2.a;
		g3.b = &g2;

		if( g4 == &g3.b->a )
			puts("Pointer test ok.");			


		//ASCII 'a'
		loc = 97;
		test(loc);


		//Save first element of int-array
		g3.b->a.m[0] = 25;

		//Set second
		second = 11;
		//And overwrite
		*ps = 30;


		//Cool, hm? - We call libc-printf here!
		//Btw, here casting must be done from char to int
		printf("GCD of %d and %d is %d.\n", g4->m[0], *ps, euklidggt(g2.a.m[0],*ps));


		//Return ggt
		return euklidggt( g3.b->a.m[0], second);
}



