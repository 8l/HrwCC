#include "../include/hrwcccomp.h"
#include "linker.h"
#include "asmopt.h"

int main(int argc, char **argv)
{
	int infile_fd;
	int outfile_fd;
	linker instance;

	if ( linker_create(&instance) < 0 )
	{
		puts("Could not initialize linker\n");
		exit(1);
	}

	infile_fd  = open("testfiles/test.n", O_RDONLY, 0);
	outfile_fd = open("testfiles/test.s", O_CREAT | O_TRUNC | O_WRONLY, 6*8*8 + 4*8 + 4);
	
	if ( infile_fd<0 || outfile_fd<0 )
	{
		linker_destroy(&instance);
		puts("Could not open file\n");
		exit(1);
	}

	if ( asmopt_execute(infile_fd, outfile_fd) < 0 )
	{
		linker_destroy(&instance);
		puts("Could not optimize file\n");
		exit(1);
	}

	if ( linker_appendFile(&instance, "testfiles/test.s", 1) < 0 )
	{
		linker_destroy(&instance);
		puts("Could not append file\n");
		exit(1);
	}

	if ( linker_appendFile(&instance, "testfiles/output.s", 1) < 0 )
	{
		linker_destroy(&instance);
		puts("Could not append file\n");
		exit(1);
	}

	if ( linker_produce(&instance, "output.exe") < 0 )
	{
		linker_destroy(&instance);
		puts("Could not produce exec file\n");
		exit(1);
	}
	
	linker_destroy(&instance);

	return 0;
}
