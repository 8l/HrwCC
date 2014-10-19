#include "../include/hrwcccomp.h"
#include "../include/error.h"

#include "utils.h"

IMPLEMENT_LIST(TokensList, Token)

int tokensAppendChr(char *tok_buffer, char new_chr)
{
	int idx;
	
	idx = strlen(tok_buffer);

	//we don't append	
	if ( idx == MAX_IDENT_LENGTH )
		return -1;

	tok_buffer[idx] = new_chr;
	return 0;
}


int getTokensListSize(TokensList *list)
{
	Token *curr;
	int size;
	
	size = 0;
	curr = Get_Front_Of_TokensList(list);
	while ( curr != NULL )
	{
		size = size+1;
		curr = Get_Next_In_TokensList(curr);
	}

	return size;
}

int lnk_tokensPushBack(TokensList *list, char *tok_buffer)
{
	Token *new_token;
	
#ifndef __HRWCC__
	new_token = (Token*)malloc(sizeof(Token));
#else
	new_token = malloc(sizeof(Token));
#endif

	if ( new_token == NULL )
		return -1;
	
	memset(new_token->value, 0, MAX_IDENT_LENGTH);
	strcpy(new_token->value, tok_buffer);
	Add_To_Back_Of_TokensList(list, new_token);

	return 0;
}

int lnk_getKeywordToken(TokensList *list, char *str, char *tok_buffer, int keyword_length)
{
	memcpy(tok_buffer, str, keyword_length);

	//append a new token
	if ( lnk_tokensPushBack(list, tok_buffer) < 0 )
		return -1;

	return 0;
}

int tokenizeString(TokensList *list, char *str)
{
	int str_length;
	int pos;
	char end_symbol;
	char prev_chr;
	char tok_buffer[MAX_IDENT_LENGTH];
	char *curr_pos;
	
	str_length = strlen(str);
	pos = 0;

	while ( pos < str_length )
	{
		memset(tok_buffer, 0, MAX_IDENT_LENGTH);

		//commented strings are disposed right here
		if ( str[pos] == '#' )
			break;

		//whitespaces are also disposed
		if ( isblank(str[pos]) )
		{
			while ( isblank(str[pos]) )
				pos = pos+1;

			continue;
		}
		
		//handle special keywords:
		//.globl .type .section .text .data
		curr_pos = &str[pos];
		if ( strncmp(curr_pos, ".globl", 6) == 0 )
		{
			lnk_getKeywordToken(list, curr_pos, tok_buffer, 6);
			pos = pos+6;

			continue;
		}

		if ( strncmp(curr_pos, ".type", 5) == 0 )
		{
			lnk_getKeywordToken(list, curr_pos, tok_buffer, 5);
			pos = pos+5;

			continue;
		}

		if ( strncmp(curr_pos, ".section", 8) == 0 )
		{
			lnk_getKeywordToken(list, curr_pos, tok_buffer, 8);
			pos = pos+8;

			continue;
		}

		if ( strncmp(curr_pos, ".text", 5) == 0 )
		{
			lnk_getKeywordToken(list, curr_pos, tok_buffer, 5);
			pos = pos+5;

			continue;
		}

		if ( strncmp(curr_pos, ".data", 5) == 0 )
		{
			lnk_getKeywordToken(list, curr_pos, tok_buffer, 5);
			pos = pos+5;

			continue;
		}

		if ( strncmp(curr_pos, ".string", 7) == 0 )
		{
			lnk_getKeywordToken(list, curr_pos, tok_buffer, 7);
			pos = pos+7;

			continue;
		}

		if ( strncmp(curr_pos, ".byte", 5) == 0 )
		{
			lnk_getKeywordToken(list, curr_pos, tok_buffer, 5);
			pos = pos+5;

			continue;
		}

		if ( strncmp(curr_pos, ".long", 5) == 0 )
		{
			lnk_getKeywordToken(list, curr_pos, tok_buffer, 5);
			pos = pos+5;

			continue;
		}

		if ( strncmp(curr_pos, ".rept", 5) == 0 )
		{
			lnk_getKeywordToken(list, curr_pos, tok_buffer, 5);
			pos = pos+5;

			continue;
		}

		if ( strncmp(curr_pos, ".endr", 5) == 0 )
		{
			lnk_getKeywordToken(list, curr_pos, tok_buffer, 5);
			pos = pos+5;

			continue;
		}

		//if we got the start of a string or a char definition we collect till ending quote
		if ( str[pos]=='"' || str[pos]=='\'' )
		{
			end_symbol = str[pos];
			prev_chr   = '\0';

			while ( 1 )
			{
				if ( tokensAppendChr(tok_buffer, str[pos]) < 0 )
					return -1;

				prev_chr = str[pos];
				pos      = pos+1;

				//NOTE: we also have to take care of escape characters ;( [again...]
				if ( !((str[pos]!=end_symbol || prev_chr=='\\') && pos<str_length) )
				{
					if ( tokensAppendChr(tok_buffer, str[pos]) < 0 )
						return -1;

					break;
				}
			}

			//append a new token
			if ( lnk_tokensPushBack(list, tok_buffer) < 0 )
				return -1;

			//also append the ending quote!
			pos = pos+1;

			continue;
		}

		//did we probably get the beginning of an identifier?
		if ( isalpha(str[pos]) || str[pos]=='_' )
		{
			while ( 1 )
			{
				if ( tokensAppendChr(tok_buffer, str[pos]) < 0 )
					return -1;

				pos = pos+1;

				if ( isalnum(str[pos])==0 && str[pos]!='_' )
					break;
			}

			//append a new token
			if ( lnk_tokensPushBack(list, tok_buffer) < 0 )
				return -1;

			continue;
		}
		
		//did we get a number?
		//also negative numbers will be collected as one token
		if ( str[pos]=='-' || isdigit(str[pos]) )
		{
			while ( 1 )
			{
				if ( tokensAppendChr(tok_buffer, str[pos]) < 0 )
					return -1;

				pos = pos+1;

				if ( isdigit(str[pos]) == 0 )
					break;
			}

			//append a new token
			if ( lnk_tokensPushBack(list, tok_buffer) < 0 )
				return -1;

			continue;
		}

		//every other char gets its own slot
		if ( tokensAppendChr(tok_buffer, str[pos]) < 0 )
			return -1;

		if ( lnk_tokensPushBack(list, tok_buffer) < 0 )
			return -1;

		pos = pos+1;
	}

	return 0;
}

void freeTokensList(TokensList *list)
{
	Token *curr;
	Token *next;
	
	curr = Get_Front_Of_TokensList(list);
	while ( curr != NULL )
	{
		next = Get_Next_In_TokensList(curr);
		free(curr);
		curr = next;
	}
}

void printTokensList(TokensList *list)
{
	Token *curr;

	curr = Get_Front_Of_TokensList(list);
	while ( curr != NULL )
	{
		printf("%s\n", curr->value);
		curr = Get_Next_In_TokensList(curr);
	}
}

int readLine(linker *instance, int fh, Line *line)
{
	int idx;

	//reset the passed buffer
	memset(line->buffer, 0, MAX_LINE_LENGTH);

	line->pos    = 0;
	line->length = 0;
	idx          = 0;
	while ( idx < MAX_LINE_LENGTH )
	{
		//read a char into the next buffer slot
		if ( read(fh, &line->buffer[idx], sizeof(char)) <= 0 )
			return -1;

		//check for newline symbol (this will be not added...)
		if ( line->buffer[idx] == '\n' )
		{
			line->buffer[idx] = '\0';
			break;
		}

		idx = idx+1;
	}

	//check for overflow
	if ( idx == MAX_LINE_LENGTH )
	{
		//NOTE: we have to add +1 to the line number here because
		//the line we are currently reading is +1 to the "last" line
		printf("LINKER_ERROR: source line too long [%s:", getFilename(instance, line->file_id));
		printf("%d] - aborting\n", line->line_no+1);
		return -1;
	}

	line->length = idx;
	return 0;
}

int appendOutput(linker *instance, char *line)
{
	int result;

	if ( instance->output_fh < 0 )
		return -1;

	result = write(instance->output_fh, line, strlen(line));
	if ( result < 0 )
	{
		//make fh invalid!
		instance->output_fh = -1;

		puts("LINKER_ERROR: Could not write to output file. The produced file is void!");
		return result;
	}

	//TODO: error handling
	return 0;
}

char *convertAddr(char *buffer, int addr)
{
	sprintf(buffer, "%d", addr);
	return buffer;
}

void freeMarkersList(MarkersList *list)
{
	Marker *curr;
	Marker *next;
	
	curr = Get_Front_Of_MarkersList(list);
	while ( curr != NULL )
	{
		next = Get_Next_In_MarkersList(curr);
		free(curr);
		curr = next;
	}
}

void freeLinesList(LinesList *list)
{
	Line *curr;
	Line *next;
	
	curr = Get_Front_Of_LinesList(list);
	while ( curr != NULL )
	{
		next = Get_Next_In_LinesList(curr);
		free(curr);
		curr = next;
	}
}

void freeFilesList(FilesList *list)
{
	File *curr;
	File *next;
	
	curr = Get_Front_Of_FilesList(list);
	while ( curr != NULL )
	{
		next = Get_Next_In_FilesList(curr);

		//also free the markers that were stored
		//to this file!
		freeMarkersList(&curr->markers);

		free(curr);
		curr = next;
	}
}

File *addFileToList(linker *instance, char *file_name)
{
	int last_file_id;
	File *last_file;
	File *new_file;

	//allocate a new element for the list
#ifndef __HRWCC__
	new_file = (File*)malloc(sizeof(File));
#else
	new_file = malloc(sizeof(File));
#endif

	if ( new_file == NULL )
		return NULL;
	
	//copy the filename into the new element
	memset(new_file->name, 0, MAX_FILENAME_LENGTH);
	strcpy(new_file->name, file_name);
	
	//find out the last file_id
	last_file_id = -1;
	last_file = Get_Back_Of_FilesList(&instance->files);
	if ( last_file != NULL )
		last_file_id = last_file->id;
	
	//increment file id
	new_file->id = last_file_id+1;
	
	//and add to list
	Add_To_Back_Of_FilesList(&instance->files, new_file);

	return new_file;
}

File *getFileOfList(linker *instance, int file_id)
{
	File *curr;
	
	curr = Get_Front_Of_FilesList(&instance->files);
	while ( curr != NULL )
	{
		if ( curr->id == file_id )
			return curr;

		curr = Get_Next_In_FilesList(curr);
	}
	
	return NULL;
}

char *getFilename(linker *instance, int file_id)
{
	File *curr;
	
	curr = Get_Front_Of_FilesList(&instance->files);
	while ( curr != NULL )
	{
		if ( curr->id == file_id )
			return curr->name;

		curr = Get_Next_In_FilesList(curr);
	}
	
	return NULL;
}
	
void lnk_disposeWhitespace(Line *line)
{
	while ( isblank(line->buffer[line->pos]) == 1 )
		line->pos = line->pos+1;
}

void disposeComments(Line *line)
{
	int start_pos;
	
	start_pos = 0;
	while ( start_pos < line->length )
	{
		if ( line->buffer[start_pos] == COMMENT_SYMBOL )
			line->buffer[start_pos] = '\0';

		start_pos = start_pos+1;
	}
}

int addLine(LinesList *list, Line *line)
{
	Line *new_line;

#ifndef __HRWCC__
	new_line = (Line*)malloc(sizeof(Line));
#else
	new_line = malloc(sizeof(Line));
#endif
	if ( new_line == NULL )
		return ERR_LINKER_MEM;
	
	memcpy(new_line, line, sizeof(Line));

	//set position to zero...
	new_line->pos = 0;
	Add_To_Back_Of_LinesList(list, new_line);
	return 0;
}

int commentLine(linker *instance, Line *line, char *append)
{
	int idx;
	int append_length;

	//let's see if the line buffer is long enough:
	if ( append )
	{
		append_length = strlen(append);
		if ( append_length+line->length+1 >= MAX_LINE_LENGTH )
		{
			//so we don't care and cut away the first two chars...
			line->buffer[0] = COMMENT_SYMBOL;
			line->buffer[1] = ' ';
	
			printf("LINKER_WARNING: cannot comment line [%s", getFilename(instance, line->file_id));
			printf("%d]- will missform it", line->line_no);
			return ERR_LINKER_MEM;
		}
	}

	//move every character 2 positions to the right (so we have place for # and a space symbol)
	idx = MAX_LINE_LENGTH-1;
	while ( idx >= 2 )
	{
		line->buffer[idx] = line->buffer[idx-2];
		idx = idx-1;
	}

	line->buffer[0] = COMMENT_SYMBOL;
	line->buffer[1] = ' ';
	
	if ( append )
		strcat(line->buffer, append);

	return 0;
}

int getNextIdentifierInLine(linker *instance, Line *line, char *identifier)
{
	int ident_idx;
	int curr_pos;

	memset(identifier, 0, MAX_IDENT_LENGTH);

	//remember current line->pos to restore it later
	//if we don't find an ident
	curr_pos = line->pos;

	lnk_disposeWhitespace(line);
	if ( line->buffer[line->pos]=='_' || isalpha(line->buffer[line->pos]) )
	{
		ident_idx = 0;
		while ( line->pos<line->length && ident_idx<MAX_IDENT_LENGTH )
		{
			//on the other positions we expect alnums or _
			if ( isalnum(line->buffer[line->pos])==0 && line->buffer[line->pos]!='_' )
				break;

			identifier[ident_idx] = line->buffer[line->pos];
			ident_idx = ident_idx+1;
			line->pos = line->pos+1;
		}
		
		//check overflow!
		if ( ident_idx == MAX_IDENT_LENGTH )
		{
			printf("LINKER_ERROR: identifier too long [%s", getFilename(instance, line->file_id));
			printf("%d] - aborting\n", line->line_no+1);
			return ERR_LINKER_MEM;
		}

		return 1;
	}

	//restore linepos
	line->pos = curr_pos;
	return 0;
}

int substrcmp(char *s1, int start_pos, char *s2)
{
	int idx;
	int s2_length;

	idx       = 0;
	s2_length = strlen(s2);
	while ( s1[idx+start_pos]!='\0' && idx<s2_length )
	{
		if ( s1[idx+start_pos] != s2[idx] )
			return 1;

		idx = idx+1;
	}

	if ( idx == s2_length )
		return 0;

	return 1;
}
