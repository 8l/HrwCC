#ifndef HRWCCCOMP_H
#define HRWCCCOMP_H

	#ifndef __HRWCC__
		/* use the libc functions... */
	
		#include <stdio.h>
		#include <stdlib.h>
		#include <string.h>

		#include <ctype.h>
		#include <fcntl.h>
		#include <unistd.h>
		#include <assert.h>
	
	#else

		/* we have to prototype ourselves */
		#define NULL 0

		#define O_CREAT		64
		#define O_TRUNC		512
		#define O_RDONLY	0
		#define O_WRONLY	1

		/*
		 * ATTENTION: This is not allowed, since these are
		 * from type FILE* originally...
		#define stdin		0
		#define stdout		1
		#define stderr		2
		*/

		void puts(char* text);
		void printf(char* text, int arg1);
		//fprintf wants a file
		//void fprintf(FILE* file, char* text, int arg1);
		int sprintf(char *str, char *format, int arg1);

		int open(char* filename, int flag, int mode);
		int read(int fd, void* buf, int size);
		int write(int fd, void* buf, int size);
		void close(int fd);

		void memset(void* text, int val, int size);
		void memcpy(void* dest, void* src, int size);
	    void *malloc(int size);
	    void *realloc(void *ptr, int size);
	    void free(void *ptr);

		void exit(int status);
		#define assert(x) if( !(x) ) puts("ASSERT!");

		int isalnum(int c);
		int isalpha(int c);
		int isdigit(int c);
		int isblank(int c);
		char tolower(int c);
		char toupper(int c);

		int atoi(char* text);
	
		void strcpy(char *dest, char *src);
		void strncpy(char *dest, char *src, int maxsize);
		void strcat(char *str1, char *str2);
		void strncat(char *str1, char *str2, int size);
		int strcmp(char *str1, char *str2);
		int strncmp(char *str1, char *str2, int len);
		int strlen(char *str);
	
	#endif

#endif
