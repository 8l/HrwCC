#include "../../include/hrwcccomp.h"

int main( int argc, char** argv)
{

	char c;
	int i;

	char str1[50];

	c = 'a';
	i = 97;

	puts("Wrapping functions...");

	if ( isalnum(c) )
		printf ( "[%c] is a alphanumeric character\n", c );

	if ( isalpha(c) )
		printf ( "[%c] is a alphabetic character\n", c );

	c = '3';

	if ( isdigit(c) )
		printf ( "[%c] is a digit\n", c );

	c = ' ';

	if ( isblank(c) )
		printf ( "[%c] is a blank\n", c );

	c = toupper(i);
	printf ( "[%c] is big\n", c );

	c = tolower(i);
	printf ( "[%c] is small\n", c );	

	c = 'a';
	i = atoi("45");

	printf ( "atoi(45): [%d] \n", i );

	puts("");

	strcpy(str1, "strcpy  successfull!");
	puts(str1);

	strncpy (str1, "------", 6);
	puts(str1);

	strcpy (str1, "concatenated ");
	strcat (str1, "string!");
	puts(str1);

	strncat(str1, " 1234", 4);
	puts(str1);

	if (strcmp("ab", "ac")<0 )
	{
		puts("ab < ac");
	}

	if (strncmp("ab", "ac", 2)<0 )
	{
		puts("ab < ac");
	}

	printf("abc is %d chars long\n", strlen("abc"));

	puts("");
	strcpy (str1,  "almost every programmer should know memset!");
	memset (str1,'-',6);
	puts (str1);

	strcpy (str1, " ");
	memcpy (str1, "memcpy successfull",19);
	puts (str1);

	malloc(10);
	i = malloc(20);
	printf("malloc returns %d\n", i);

	malloc(30);
	free(i);
	puts("free");

	i = malloc(20);
	printf("malloc should return same value: %d\n", i);

	i = realloc(i, 30);
	printf("realloc should return value 50 greater: %d\n", i);
	
}

