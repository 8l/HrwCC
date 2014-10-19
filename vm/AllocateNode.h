#ifndef ALLOCATENODE_H
#define ALLOCATENODE_H

#include <iostream>

using namespace std;

class AllocateNode
{
	private:
		int offset;
		int size;

	public:
		AllocateNode();
		~AllocateNode();
		int getSize();
		void setSize(int);
		int getOffset();
		void setOffset(int);
};

#endif
