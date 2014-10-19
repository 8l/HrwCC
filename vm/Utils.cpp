#include "Utils.h"

string Utils::intToString(int x)
{
	stringstream s;
	s << x;
	
	return s.str();
}

int Utils::stringToInt(string str)
{
	stringstream s(str);
	
	int result;
	s >> result;

	return result;
}

