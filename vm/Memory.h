#ifndef MEMORY_H
#define MEMORY_H

#include <vector>

#include "AllocateNode.h"
#include "VMConfig.h"
#include "GenericException.h"
#include "InstructionsFetcher.h"
//#include "ExecParser.h"

typedef char byte;

/**
 * this is a full blown memory allocating class
 * that allows dynamic memory allocation and deallocation
 */
class Memory
{
	public:
		byte *memory[VM_VIRTUAL_MEM_SIZE];
		bool args_pushed;
		vector<AllocateNode> allocate_nodes;

	protected:
		/*
		 * make sure the given address is within our memory boundaries
		 */
		void assertBoundaries(int addr, int block);

		/*
		 * make sure the given block is allocated
		 */
		void assertBlock(int addr, int block);

		/*
		 * returns the block to the given address
		 */
		int getBlock(int addr);

		/*
		 * returns the slot to the given address
		 */
		int getSlot(int addr);

		/*
		 * inserts a node with a given size into a list of nodes
		 */
		int insertAllocateNode(AllocateNode new_node);

		/*
		 * allocates new blocks if we cross boundries
		 */
		void allocateBlocks();

	public:
		Memory();
		~Memory();

		/**
		 * set the program arguments that will be put
		 * into the argument block
		 */
		void setProgramArguments(int argc, char **argv);

		/**
		 * allocate 'size' bytes of memory
		 * returns a pointer to the allocated memory
		 * or -1 in case of error
		 */
		int allocate(int size);
		
		/**
		 * frees the given pointer to the allocated memory
		 */
		void free(int mem);


		/**
		 * Get the size of block at mem
		 */
		int getSizeOfMalloc(int mem);

		/*
		 * store a byte at this address
		 */
		void setb(int addr, char val);

		/*
		 * get a byte from this address
		 */
		char getb(int addr);

		/*
		 * store a long (sizeof(int)) at this address
		 */
		void setl(int addr, int val);

		/*
		 * get a long (sizeof(int)) beginning from address
		 */
		int getl(int addr);

		void print(int start, int end);
};

#endif
