#include "AllocateNode.h"

AllocateNode::AllocateNode()
{}

AllocateNode::~AllocateNode()
{}

void AllocateNode::setOffset(int offset)
{
	this->offset = offset;
}

int AllocateNode::getOffset()
{
	return offset;
}

void AllocateNode::setSize(int size)
{
	this->size = size;
}

int AllocateNode::getSize()
{
	return size;
}
