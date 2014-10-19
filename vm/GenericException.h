#ifndef GENERIC_EXCEPTION_H
#define GENERIC_EXCEPTION_H

#include <exception>

#include "Utils.h"

using namespace std;

class GenericException : public exception
{
	private:
		string _what;

	public:
	//TODO: append line_no to what!
		GenericException(string what, int line_no) : _what(what + " [on line " + Utils::intToString(line_no) + "]") {};
		GenericException(string what) : _what(what) {};
		~GenericException() throw () {};
		virtual const char* what() const throw() { return _what.c_str(); }
};

#endif
