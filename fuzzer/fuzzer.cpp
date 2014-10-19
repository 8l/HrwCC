
#ifndef __HRWCC__
	#include <stdlib.h>
	#include <stdio.h>
	#include <unistd.h>
	#include <time.h>
#else
	int atoi(char* number);
	void printf(char* text);
	int rand();
	void srand(int seed);
	int time(int* newtime);
	int read( int fd, void* buf, int size);
	int write( int fd, void* buf, int size);
#endif


/** maximum relative occurence */
#define MAXRELOCCURENCE 100000




/**
 * Print usage of program.
 */
void printUsage()
{
		printf("Fuzzer is a tool which pipes characters from stdin to stdout\n");
		printf("and substitutes some characters with a specific probabiltiy.\n");
		printf("\n");
		printf("Usage:\n");
		printf("    fuzzer [<prop>]\n");
		printf("\n");
		printf("In the mean <prop> many characters out of 100.000 ones are\n");
		printf("substituted. Default value: 1000\n");
}


/**
 * Run the fuzz-testing tool.
 */
int main( int argc, char** argv )
{
		int relamount;
		char input;
		int readch;
		int rnd;


		//Default value
		if( argc == 1 )
			relamount = 1000;

		//Parse relative propability
		else if( argc == 2 )
		{
				relamount = atoi(argv[1]);
		}

		//To much arguments
		else
		{
				printUsage();
				return -1;
		}


		//Feed with seed
		srand(time(0));


		//Read input, until finished
		while( 1 )
		{
				//Read one character
				readch = read(0, &input, 1);

				//Finished
				if( readch == 0)
					break;


				// Create random number between [0,RAND_MAX]
				rnd = rand();
				// Normalize rnd to [0, MAXRELOCCURENCE]
				rnd = rnd % (MAXRELOCCURENCE+1);


				// We want a probabiltiy of relAmount/MAXRELOCCURENCE 
				// of substitution.
				if( rnd <= relamount )
				{
						//Calc new input;
						input = rand() % 128;
				}


				//Write the read character
				write(1, &input, 1);
		}

		return 0;
}


