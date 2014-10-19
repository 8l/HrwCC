#ifndef ASMOPT_H
#define ASMOPT_H
	/**
	 * Assembler Optimizer
	 *  the task of this module is to
	 *  analyze the HRWCC generated code and optmize
	 *  *some* assembler patterns/combinations that can occur
	 */

	/**
	 * execute the "assembler pattern optmization"
	 * returns != 0 in case an error occured - 0 otherwise
	 */
	int asmopt_execute(int infile_fd, int outfile_fd);

#endif
