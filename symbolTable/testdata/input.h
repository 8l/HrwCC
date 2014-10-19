
//You may want to delete the semicolon -- has to parse further on...
struct firststruct
{
		int a;
		char b
		firststruct** c;
		//unknown aa;
}

struct secondstruct
{
		secondstruct* next;
		firststruct c[3];
};


void function1( int arg1, char arg2, char* arg3);
void function1( int arg1, char* arg2, char* arg3);


