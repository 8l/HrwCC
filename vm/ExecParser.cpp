#include "ExecParser.h"

ExecParser::ExecParser(ifstream &_input, Memory *_memory) : input(_input), memory(_memory)
{
    //empty constructor for now
}

ExecParser::~ExecParser()
{
}

void ExecParser::parse() throw(GenericException)
{
	string line;
	int line_no = 0;

	bool is_text_section = false;
	bool is_data_section = false;
	bool is_data_shifted = false;

	while( getline(this->input, line) )
	{
		//update line counter before we do anything
		line_no++;
		
		//parse the current line into
		//appropriate tokens
		Tokens tokens;
		//set meta information for this tokens (code line)
		tokens.line_no = line_no;
		//finally: parse the line we read into tokens
		parseTokens(line, tokens);

		//skip empty line		
		if ( tokens.size() == 0 )
			continue;

		//see if have to handle a new section:
		//pattern: .section .<somename>
		if ( tokens.size()==4 && tokens[0]=="." && tokens[1]=="section" && tokens[2]=="." )
		{
			is_text_section = false;
			is_data_section = false;

			if ( tokens[3] == "data" )
			{
				//set appropriate section flag
				//and skip line
				is_data_section = true;
			}
			else if ( tokens[3] == "text" )
			{
				//set appropriate section flag
				//and skip line
				is_text_section = true;
			}
			else
			{
				throw GenericException("Invalid section [" + tokens[3] + "]", line_no);
			}

			continue;
		}

		//now: handle line for appropriate section
		//of throw an error
		if ( is_text_section )
		{
			//just add the collected tokens to the
			//instruction decoder that parses the instruction-tokens
			//and adds the instruction to its internal buffer
			InstructionsFetcher::getInstance()->addInstructionTokens(tokens);
		}
		else if ( is_data_section )
		{
			if( ! is_data_shifted )
			{
				//Before allocate instr-mem to let data start where data starts in file
				memory->allocate(InstructionsFetcher::getInstance()->getInstructionsSize()-1);

				is_data_shifted = true;
			}

			//we have to add the data we get to the memory
			getDataSize(tokens);
		}
		else
		{
			//no section - no idea what to do...
			throw GenericException("unrecognized statement [" + line + "]", line_no);
		}
	}
}

int ExecParser::getDataSize(Tokens &tokens)
{
	//a valid .data statement always has 3 tokens!
	if ( tokens.size()!=3 || tokens[0] != "." )
			throw GenericException("Invalid data definition", tokens.line_no);

	int addr;
	int base = 0;
	int size = 0;
	vector<string> rept_buffer;


	if ( tokens[1] == "string" )
	{
		//NOTE: we have to replace occurences of escaped characters through
		//their equivalent hex representation
		replaceEscapeChrs(tokens[2]);
		size = tokens[2].length()+1;//because of /0!

		addr = max(memory->allocate(size), base);

		for ( int idx = 0; idx < size; idx++ )
		{
			memory->setb(addr + idx, tokens[2].c_str()[idx]);
		}
	}
	else if ( tokens[1] == "byte" )
	{
		replaceEscapeChrs(tokens[2]);
		size = sizeof(char);

		addr = max(memory->allocate(size), base);
		memory->setb(addr, tokens[2].c_str()[0]);
	}
	else if ( tokens[1] == "long" )
	{
		size = sizeof(int);

		addr = max(memory->allocate(size), base);
		memory->setl(addr, Utils::stringToInt(tokens[2]));
	}
	// TODO handle rept
	else if ( tokens[1] == "rept" )
	{
		size          = Utils::stringToInt(tokens[2]);
		int rept_size = 0;
		string line;

		// just make sure there is place
		base = memory->allocate(size);
		memory->free(base);

		// store the whole rept in a string buffer to handle multiple setl, setb,...
		while( getline(this->input, line) )
		{
			tokens.clear();
			tokens.line_no += 1;
			parseTokens(line, tokens);
			if ( tokens.size()>=2 && tokens[0]=="." && tokens[1]=="endr" )
				break;
			rept_buffer.push_back(line);
		}

		//we have to get rid of all lines till we find .endr!
		while ( rept_size / size != 1 )
		{
			for (unsigned int i = 0; i < rept_buffer.size(); i++)
			{
				tokens.clear();            //clear tokens buffer
				parseTokens(rept_buffer[i], tokens); //parse current line
	
				//other than .endr - we have to add this to the rept_size!
				//so we have to recursively resolve this!
				rept_size += getDataSize(tokens);
			}
		}
		base = 0;
		//multiplicate rept size with data size
		//size *= rept_size;
	}
	else
		//we don't know this data type...
		throw GenericException("Invalid data type [" + tokens[2] + "]", tokens.line_no);
	
	return size;
}

void ExecParser::replaceEscapeChrs(string &str)
{
	if ( str.length() == 0 )
		return;

	for ( unsigned int idx=0; idx<str.length()-1; idx++ )
	{
		char first  = str[idx];
		char second = str[idx+1];
		
		//if we didn't get an escape char
		//we don't have anything to do on this position
		if ( first != '\\' )
			continue;

		char replace_chr = -1;
		if( second == 'n' )
			replace_chr = 10;
		if( second == 'r' )
			replace_chr = 13;
		if( second == 't' )
			replace_chr = 9;
		if( second == '\\' )
			replace_chr = 92;
		if( second == 'b' )
			replace_chr = 8;
		if( second == '\'' )
			replace_chr = 39;
		if( second == '\"' )
			replace_chr = 34;
		if( second == '0' )
			replace_chr = 0;
		
		//we have something to replace?
		if ( replace_chr == -1 )
			continue;
		
		//yes, we do:
		str[idx] = replace_chr;
		str.erase(idx+1, 1);
	}
}

void ExecParser::parseTokens(string line, Tokens &tokens)
{
	int line_length = line.length();
	int pos         = 0;
	while ( pos < line_length )
	{
		//commented strings are disposed right here
		if ( line[pos] == '#' )
			break;

		//whitespaces are also disposed
		if ( isblank(line[pos]) )
		{
			while ( isblank(line[pos]) )
				pos++;

			continue;
		}

		//if we got the start of a string or a char definition we collect till ending quote
		if ( line[pos]=='"' || line[pos]=='\'' )
		{
			tokens.push_back("");

			char end_symbol = line[pos];
			char prev_chr   = '\0';
			
			//we don't need the starting quote
			pos++;

			while ( pos<line_length && (line[pos]!=end_symbol || prev_chr=='\\') )
			{
				tokens.at(tokens.size()-1) += line[pos];
				prev_chr                    = line[pos];
				pos++;
			}

			//also append the ending quote!
			//we don't need this hm???
			//tokens.at(tokens.size()-1) += line[pos];
			pos++;

			continue;
		}

		//did we probably get the beginning of an identifier?
		if ( isalpha(line[pos]) || line[pos]=='_' )
		{
			tokens.push_back("");

			do
			{
				tokens.at(tokens.size()-1) += line[pos];
				pos++;
			}
			while ( isalnum(line[pos]) || line[pos]=='_' );
			continue;
		}
		
		//did we get a number?
		//also negative numbers will be collected as one token
		if ( line[pos]=='-' || isdigit(line[pos]) )
		{
			tokens.push_back("");

			do
			{
				tokens.at(tokens.size()-1) += line[pos];
				pos++;
			}
			while ( isdigit(line[pos]) );
			continue;
		}

		tokens.push_back("");
		tokens.at(tokens.size()-1) += line[pos];
		pos++;
	}
}
