#include <iostream>

#include "Memory.h"
#include "VMConfig.h"
#include "Utils.h"
#include "ExecParser.h"

Memory::Memory()
{
	args_pushed = false;

	//initialize every slot in memory with zero
	for ( int idx=0; idx<VM_VIRTUAL_MEM_SIZE; idx++ )
		memory[idx] = 0;

	//we allocate nothing but the stack for now:
	//   the stack is located in the last VM_VIRTUAL_MEM_STACK_SIZE blocks
	for ( int idx=VM_VIRTUAL_MEM_SIZE-1; idx >= VM_VIRTUAL_MEM_SIZE-VM_VIRTUAL_MEM_STACK_SIZE; idx-- )
	{
		//cout << idx << endl;
		memory[idx] = new byte[VM_VIRTUAL_MEM_BLOCK_SIZE];
		if ( !memory[idx] )
			throw GenericException("Could not allocate memory for stack!");
	}
}

Memory::~Memory()
{
	//delete every used slot in memory
	for ( int idx=0; idx<VM_VIRTUAL_MEM_SIZE; idx++ )
	{
		if ( memory[idx] )
			delete memory[idx];
	}
}

void Memory::assertBoundaries(int addr, int block)
{
	if ( block >= VM_VIRTUAL_MEM_SIZE || block<0 )
		throw GenericException("Address [" + Utils::intToString(addr) + "] not in our memory");
}

void Memory::assertBlock(int addr, int block)
{
	if ( !memory[block] )
	{
		throw GenericException("Block [" + Utils::intToString(block) + "] for address [" + Utils::intToString(addr) + "] not in our memory");
	}
}

int Memory::getBlock(int addr)
{
	return addr / VM_VIRTUAL_MEM_BLOCK_SIZE;
}

int Memory::getSlot(int addr)
{
	return addr % VM_VIRTUAL_MEM_BLOCK_SIZE;
}

void Memory::setProgramArguments(int argc, char **argv)
{
	int base_addr = VM_STACK_INIT_ADDR;
	int size      = 0;
	int offset    = 0;
	string curr   = "";

	// push CLI arguments to the top of the stack
	if ( args_pushed )
	{
		cout << "Arguments already added before! Ignoring this call" << endl;
		return;
	}

	// push argc
	setl(base_addr, argc);

	

	for ( int i = 0; i < argc; i++ )
	{
		// push pointer to the current argument on the stack
		setl(base_addr + (i+1)*4, base_addr + (argc+i+1)*4);
	}

	for ( int i = 0; i < argc; i++ )
	{
		setl(base_addr + (argc+i+1)*4, base_addr + (2*argc+i+1)*4 + offset);
		curr = (string)(argv[i]);

		ExecParser::replaceEscapeChrs(curr);

		size = curr.length()+1;
		// now calculate the offset for the rest of the arguments
		for ( int j = 0; j < size; j++ )
		{
			setb(base_addr + (2*argc+i+1)*4 + offset + j, curr.c_str()[j]);
		}
		offset += size;
	}
	args_pushed = true;
}

int Memory::allocate(int size)
{
	// create a node to be inserted into the list of allocated space
	AllocateNode new_node;
	new_node.setSize(size);
	return insertAllocateNode(new_node);
}

void Memory::free(int mem)
{
	vector<AllocateNode>::iterator it = allocate_nodes.begin();
	unsigned int idx = 0;

	while ( idx < allocate_nodes.size() )
	{
		// found the right node
		if ( allocate_nodes[idx].getOffset() == mem )
		{
			//delete node from list
			allocate_nodes.erase(it);
		}
		it ++;
		idx ++;
	}
}


/**
 * Get size of the block which lies at mem
 */
int Memory::getSizeOfMalloc(int mem)
{
	vector<AllocateNode>::iterator it = allocate_nodes.begin();
	unsigned int idx = 0;

	while ( idx < allocate_nodes.size() )
	{
		// found the right node
		if ( allocate_nodes[idx].getOffset() == mem )
		{
			return allocate_nodes[idx].getSize();
		}
		it ++;
		idx ++;
	}

	return -1;
}

int Memory::insertAllocateNode(AllocateNode new_node)
{
	vector<AllocateNode>::iterator it = allocate_nodes.begin();

	// no blocks allocated yet
	if ( allocate_nodes.size() == 0 )
	{
		// make sure there is enough space left
		if ( new_node.getSize() <= VM_MALLOC_SIZE )
		{
			// set offset = 0 at the beginning
			new_node.setOffset(0);
			allocate_nodes.push_back(new_node);
			//cout << "allocated " << new_node.getSize() << endl;

			allocateBlocks();
			return new_node.getOffset();
		}
		else
			return 0;
	}
	// scecial case: only one block allocated
	else if ( allocate_nodes.size() == 1 )
	{
		if ( new_node.getSize() <= (VM_MALLOC_SIZE - allocate_nodes[0].getSize()) )
		{
			new_node.setOffset(allocate_nodes[0].getSize());
			allocate_nodes.push_back(new_node);
			//cout << "allocated " << new_node.getSize() << endl;

			allocateBlocks();
			return new_node.getOffset();
		}
		else
			return 0;
	}
	// at least two blocks are already allocated
	else
	{
		// two pointers to loop through the list -> try to find gaps
		unsigned int idx  = 0;

		// maybe there is a gap at the start of the list
		if ( allocate_nodes[idx].getOffset() >= new_node.getSize() )
		{
			new_node.setOffset(0);
			allocate_nodes.insert(it, new_node);
			//cout << "allocated " << new_node.getSize() << endl;
			return new_node.getOffset();
		}

		// find gaps
		while ( allocate_nodes.size() != idx + 1 )
		{
			// found a gap which is big enough
			if ( new_node.getSize() <= (allocate_nodes[idx + 1].getOffset() - (allocate_nodes[idx].getOffset() + allocate_nodes[idx].getSize())) )
			{
				// insert in between
				new_node.setOffset(allocate_nodes[idx].getOffset() + allocate_nodes[idx].getSize());
				allocate_nodes.insert(it + 1, new_node);
				//cout << "allocated " << new_node.getSize() << endl;
				allocateBlocks();
				return new_node.getOffset();
			}
			idx ++;
			it ++;
		}

		// we found no gap -> so try to insert node at the end of the list
		if ( new_node.getSize() <= (VM_MALLOC_SIZE - (allocate_nodes[idx].getOffset() + allocate_nodes[idx].getSize())) )
		{
			new_node.setOffset(allocate_nodes[idx].getOffset() + allocate_nodes[idx].getSize());
			allocate_nodes.push_back(new_node);
			//cout << "allocated " << new_node.getSize() << endl;
			allocateBlocks();
			return new_node.getOffset();
		}
		else
			return 0;
	}
}

void Memory::allocateBlocks()
{
	// do we have to allocate a new block?
	for ( int idx = 0; idx <= ((allocate_nodes[allocate_nodes.size()-1].getOffset() + allocate_nodes[allocate_nodes.size()-1].getSize()) / VM_VIRTUAL_MEM_BLOCK_SIZE); idx++ )
	{
		if ( !memory[idx] )
		{
			memory[idx] = new byte[VM_VIRTUAL_MEM_BLOCK_SIZE];
		}
	}
}

void Memory::setb(int addr, char val)
{	
	//addr -= InstructionsFetcher::getInstance()->getInstructionsSize();
	int block = getBlock(addr);
	int slot  = getSlot(addr);


	//make sure the address is in our virtual memory
	assertBoundaries(addr, block);

	if (!memory[block])
	{	
		throw GenericException("Accessing invalid block " + Utils::intToString(block) );
		//addr -= InstructionsFetcher::getInstance()->getInstructionsSize();
		//block = getBlock(addr);
		//slot  = getSlot(addr);
	}
	assertBlock(addr, block);

	memory[block][slot] = val;
}

char Memory::getb(int addr)
{
	//addr -=  InstructionsFetcher::getInstance()->getInstructionsSize();
	int block = getBlock(addr);
	int slot  = getSlot(addr);

	//make sure the address is in our virtual memory
	assertBoundaries(addr, block);

	if (!memory[block])
	{
		throw GenericException("Accessing invalid block " + Utils::intToString(block) );
		//addr -= InstructionsFetcher::getInstance()->getInstructionsSize();
		//block = getBlock(addr);
		//slot  = getSlot(addr);
	}
	assertBlock(addr, block);

	return memory[block][slot];
}

void Memory::setl(int addr, int val)
{
	//block is allocated - now let's split the value into byte pieces
	for ( unsigned idx=0; idx < sizeof(int); idx++ )
	{
		//store the 'idx' VM_BYTE_SIZE bits of the value
		setb(addr, (val & (0xff000000 >> ((idx)*VM_BYTE_SIZE))) >> (sizeof(int)-idx-1)*VM_BYTE_SIZE);

		addr++; //increment address and to resolve new slot/block indexes
	}
}

int Memory::getl(int addr)
{
	int result = 0;
	for ( unsigned idx=0; idx < sizeof(int); idx++ )
	{
		//read from the memory and shift to the idx position in the complete integer
		// do & 0x000000ff otherwise we get strange negative values
		result += ((getb(addr) & 0x000000ff) << ((sizeof(int)-idx-1)*VM_BYTE_SIZE));

		addr++; //increment address and to resolve new slot/block indexes
	}

	return result;
}

void Memory::print(int start, int end)
{
	for ( ; start < end; start++ )
	{
		cout << start << ": " << getb(start) << endl;

	}
}
