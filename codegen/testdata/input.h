
//You may want to delete the semicolon -- has to parse further on...
struct firststruct
{
		int* a[5];
		char b[5];
		firststruct** c;
		//unknown aa;
};

struct secondstruct
{
		secondstruct* next;
		firststruct c;
		firststruct d[4];
};




