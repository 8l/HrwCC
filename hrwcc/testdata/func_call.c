#include "../../include/hrwcccomp.h"

int fac( int n )
{

	if (n>1)
      		return n*fac(n-1);
	
	return 1;
}

int main( int argc, char** argv)
{
	char *s1;
	char buffer [50];
	char buffer2 [50];
	int n;
	int a;

	s1 = "short";

	printf("fac: %d\n", fac(25));

	printf("this is a %s text\n", s1);

	a = 3;
	n = sprintf (buffer, "%d is a magic number\n", a);
	printf ("[%s]\n",buffer);

	memcpy (buffer2, buffer, 50);
	printf ("[%s]\n",buffer2);

		
	return 1;
}
