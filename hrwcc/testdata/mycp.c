#include "../../include/hrwcccomp.h"


#define BUFSIZE 10



int main(int argc, char** argv)
{
		int infd;
		int outfd;
		int read;
		char* buf;


		//Testing malloc and free
		buf = malloc( sizeof(char) * BUFSIZE);

		//False amount of parameters
		if( argc != 3)
		{
				puts("Please invoke by:");
				printf("   %s  infile outfile", argv[0]);
				exit(-1);
		}

		
		infd = open(argv[1], O_RDONLY, 0);
		outfd = open(argv[2], O_CREAT | O_WRONLY, 6*8*8 + 4*8 + 4);



		while( 1 )
		{
			//Read some bytes
			read = read( infd, buf, sizeof(char) * BUFSIZE);

			//No more data, (maybe?) EOF
			if( read == 0 )
				break;


			//Write some bytes
			write( outfd, buf, read);
		}


		close(infd);
		close(outfd);

		free(buf);
}



