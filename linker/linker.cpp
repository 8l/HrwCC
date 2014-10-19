#include "../include/hrwcccomp.h"
#include "../include/error.h"

#include "../preproc/preproc.h"
#include "../scanner/scanner.h"
#include "../parser/parser.h"

#include "linker.h"
#include "utils.h"

IMPLEMENT_LIST(MarkersList, Marker)
IMPLEMENT_LIST(LinesList, Line)
IMPLEMENT_LIST(FilesList, File)

int linker_create(linker *instance)
{
	int idx;
	int functions_count;

	Marker *marker;
	preproc preproc;
	scanner scanner;
	parser parser;
	symbolTable symtable;
	syntaxTreeNode* tree;
	symbolTableNode* node;

	//now initialize the structure
	instance->initiated         = 1;
	instance->output_fh         = -1;
	instance->text_addr         = TEXT_OFFSET;
	instance->data_addr         = 0;

	//don't forget to reset the lists
	Clear_MarkersList(&instance->globls);
	Clear_MarkersList(&instance->restricted);
	Clear_LinesList(&instance->text_section);
	Clear_LinesList(&instance->data_section);
	Clear_FilesList(&instance->files);

	//we need to get the list of restricted labels
	//therefore we compile hrwcccomp.h with hrwcc
	preproc_create(&preproc, "../include/hrwcccomp.h");
	preproc_addDefine(&preproc, "__HRWCC__");

	scanner_init(&scanner, &preproc);
	parser_init(&parser, &scanner);
	symbol_CreateSymbolTable(&parser, &symtable);
	parser_setSymbolTable(&parser, &symtable);

	tree = syntax_CreateTreeNode();
	parser_buildSyntaxTree(&parser, tree);

	functions_count = symbol_CountFunctions(&symtable);
	idx = 0;
	while( idx < functions_count )
	{
		node = symbol_GetFunction(&symtable, idx);

#ifndef __HRWCC__
		marker = (Marker*)malloc(sizeof(Marker));
#else
		marker = malloc(sizeof(Marker));
#endif
		if ( marker == NULL )
			return ERR_LINKER_MEM;

		memset(marker, 0, sizeof(Marker));
		strcpy(marker->name, node->name.content);

		Add_To_Front_Of_MarkersList(&instance->restricted, marker);

		idx = idx+1;
	}

	syntax_FreeSyntaxTree(tree);
	symbol_destroy(&symtable);
	preproc_destroy(&preproc);

    return 0;
}

int linker_destroy(linker *instance)
{
	if ( instance->initiated != 1 )
		return ERR_LINKER_NOOP;

	freeMarkersList(&instance->globls);

	freeMarkersList(&instance->restricted);
	freeLinesList(&instance->text_section);
	freeLinesList(&instance->data_section);

	freeFilesList(&instance->files);

	return 0;
}

Marker *findInMarkersList(MarkersList *list, char *marker_name)
{
	Marker *curr_marker;

	curr_marker = Get_Front_Of_MarkersList(list);
	while ( curr_marker != NULL )
	{
		if ( strcmp(marker_name, curr_marker->name) == 0 )
			return curr_marker;

		curr_marker = Get_Next_In_MarkersList(curr_marker);
	}

	return NULL;
}

/**
 * returns the address of a marker in a list
 * or -1 in case the marker was not found
 */
int getMarkerAddr(MarkersList *list, char *marker_name)
{
	Marker *marker;
	
	marker = findInMarkersList(list, marker_name);
	if ( marker != NULL )
		return marker->addr;

	return -1;
}

/**
 * checks if the given line contains a marker statement
 * possible whitespace will be removed
 * line->pos will not be changed
 * returns 1 if it does and 0 otherwise
 */
int isMarkerLine(linker *instance, Line *line)
{
	int result;
	int line_pos;
	char identifier[MAX_IDENT_LENGTH];

	line_pos = line->pos;
	result = getNextIdentifierInLine(instance, line, identifier);
	if ( result < 0 )
	{
		//result < 0 means: error (too long identifer)
		return result;
	}
	else if ( result == 0 )
	{
		//result = 1 means: nothing found (at this position)
		return 0;
	}
	else
	{
		lnk_disposeWhitespace(line);

		//we got an identifier!
		//now let's have a look at the last character!
		if ( line->buffer[line->pos] == ':' )
		{
			//restore line->pos!!
			line->pos = line_pos;
			return 1;
		}

		//no, this was no marker ;(
		//restore line->pos!!
		line->pos = line_pos;
		return 0;
	}

	return 0;
}

/**
 * parses a (possible) marker in the line buffer starting
 * at the lines current position
 * the new marker will be added to list with addr
 * 0 is returned if no marker was found
 * 1 is returned if a marker was added
 * a negative value indicates an error
 */
int addMarker(linker *instance, Line *line, MarkersList *list, int addr)
{
	int result;
	char identifier[MAX_IDENT_LENGTH];
	Marker *new_marker;
	Marker *curr_marker;

	result = getNextIdentifierInLine(instance, line, identifier);
	if ( result < 0 )
	{
		//result < 0 means: error (too long identifer)
		return result;
	}
	else if ( result == 0 )
	{
		//result = 1 means: nothing found (at this position)
		return 0;
	}
	else
	{
		//first: let's make sure the marker is not already in the list!
		curr_marker = Get_Front_Of_MarkersList(list);
		while ( curr_marker != NULL )
		{
			if ( strcmp(curr_marker->name, identifier) == 0 )
			{
				printf("LINKER_WARNING: marker [%s] already defined before - ignoring this one...\n", curr_marker->name);
				return 0;
			}
			curr_marker = Get_Next_In_MarkersList(curr_marker);
		}

#ifndef __HRWCC__
		new_marker = (Marker*)malloc(sizeof(Marker));
#else
		new_marker = malloc(sizeof(Marker));
#endif
		if ( new_marker == NULL )
			return ERR_LINKER_MEM;

		memset(new_marker->name, 0, MAX_IDENT_LENGTH);
		strcpy(new_marker->name, identifier);
		new_marker->addr = addr;

//printf(" got new marker: [%s:%d]\n", new_marker->name, new_marker->addr);

		//append to the markers list
		Add_To_Front_Of_MarkersList(list, new_marker);
	}

	return 0;
}

/**
 * just for debugging purposes...
 */
void printMarkersList(MarkersList *list)
{
	Marker *curr_marker;
	
	curr_marker = Get_Front_Of_MarkersList(list);
	while ( curr_marker != NULL )
	{
		printf("marker: [%s:", curr_marker->name);
		printf("%d]\n", curr_marker->addr);
		curr_marker = Get_Next_In_MarkersList(curr_marker);
	}
}

void printLinesList(LinesList *list)
{
	Line *curr;
	
	curr = Get_Front_Of_LinesList(list);
	while ( curr != NULL )
	{
		printf("{%s}:", curr->buffer);
		printf("%d:", curr->line_no);
		printf("%d\n", curr->addr);
		curr = Get_Next_In_LinesList(curr);
	}	
}

/**
 * synchronize the uninitialized globl statements from the current file
 * with the local_markers (from the current file) and try to assign each globl
 * a valid address. invalid globls will be removed from the globls list
 */
void syncGloblsWithMarkers(MarkersList *globls, MarkersList *local_markers)
{
	int delete_marker;

	Marker *globl_marker;
	Marker *cmp_marker;
	Marker *del_marker;
	
	globl_marker = Get_Front_Of_MarkersList(globls);
	while ( globl_marker != NULL )
	{
		//see if this globl got defined!
		cmp_marker = Get_Front_Of_MarkersList(local_markers);
		while ( cmp_marker != NULL )
		{
			if ( strcmp(cmp_marker->name, globl_marker->name) == 0 )
			{
				//make sure the globl wasn't defined already!
				if ( globl_marker->addr != -1 )
				{
					printf("LINKER_WARNING: .globl [%s] definition already found before - ignoring this one...\n", globl_marker->name);
				}
				else
				{
					//store the address and we are done with this marker!
					globl_marker->addr = cmp_marker->addr;
				}
				break;
			}

			cmp_marker = Get_Next_In_MarkersList(cmp_marker);
		}

		//if this marker was not defined
		//print a warning for now
		delete_marker = 0;
		if ( globl_marker->addr == -1 )
		{
			printf("LINKER_WARNING: .globl [%s] definition was not found - this label will not be available in other files!\n", globl_marker->name);
			//let's remove it from the globl list!
			delete_marker = 1;
		}

		del_marker   = globl_marker;
		globl_marker = Get_Next_In_MarkersList(globl_marker);
		
		if ( delete_marker == 1 )
			Remove_From_MarkersList(globls, del_marker);
	}
}

/**
 * expects line.pos to be at the start position of a possible
 * size identifier (i.e. .rept 10)
 * returns the size of the datatype or -1 in case of error
 */
int getSizeIdentifier(linker *instance, Line *line)
{
	int idx;
	char size_buffer[MAX_ADDR_LENGTH];	
	memset(size_buffer, 0, MAX_ADDR_LENGTH);
	
	idx = 0;
	while ( isdigit(line->buffer[line->pos]) && idx<MAX_ADDR_LENGTH )
	{
		size_buffer[idx] = line->buffer[line->pos];
		line->pos        = line->pos+1;
		idx              = idx+1;
	}

	return atoi(size_buffer);
}

/**
 * expects line.pos to be at the start position (quote) of a possible
 * .string definition
 * returns the size of the string or -1 in case of error
 */
int getStringSize(linker *instance, Line *line)
{
	int size;

	//read in the strings length
	if ( line->buffer[line->pos] != '"' )
	{
		printf("LINKER_ERROR: unrecognized .string type [%s:", getFilename(instance, line->file_id));
		printf("%d] - ignoring\n", line->line_no);
		return -1;
	}

	line->pos  = line->pos+1;
	size       = 1; //+ terminating character!
	while ( line->buffer[line->pos]!='"' && line->pos<line->length )
	{
		//we have to care about escape characters
		//because the data will be stored UNESCAPED in memory
		if ( line->buffer[line->pos] == '\\' )
			//skip current character
			line->pos = line->pos+1;

		size       = size+1;
		line->pos  = line->pos+1;
	}

	return size;
}

/**
 * splits the given file into 
 */
int parseSourceFile(linker *instance, File *file, int fh, MarkersList *list)
{
	int result;
	int is_text_section;
	int is_data_section;

	int data_size;

	//this is the line object we use while parsing this file
	//some properties are set during every loop
	//and others (like file_id) are set only once
	//when adding lines to a LinesList we always use copies
	//of this object
	Line line;

	//init line status
	line.file_id = file->id;
	line.line_no = 0;

	is_text_section = 0;
	is_data_section = 0;
	while ( readLine(instance, fh, &line) >= 0 )
	{
		//increment the line counter
		line.line_no = line.line_no+1;

		//just dispose whitespace from start of the line
		lnk_disposeWhitespace(&line);

		//we have to reset the line properties
		//before each loop
		line.is_debug_line  = 0;
		line.is_globl_line  = 0;
		line.is_marker_line = 0;

		//section recognition:
		if ( substrcmp(line.buffer, line.pos, ".section") == 0 )
		{
			//skip .section
			line.pos = line.pos+8;
			
			//get rid of whitespace
			lnk_disposeWhitespace(&line);
			
			is_text_section = 0;
			is_data_section = 0;
			if ( substrcmp(line.buffer, line.pos, ".text") == 0 )
				is_text_section = 1;

			else if ( substrcmp(line.buffer, line.pos, ".data") == 0 )
				is_data_section = 1;

			else //unrecognized section!
			{
				printf("LINKER_WARNING: invalid .section statement [%s:", getFilename(instance, line.file_id));
				printf("%d] - ignoring following lines till a valid section\n", line.line_no);
			}

			continue;
		}
		else if ( substrcmp(line.buffer, line.pos, ".globl") == 0 )
		{
			//globl statement is NO debug line...
			line.is_globl_line = 1;
		}
		else if ( is_data_section==0 && substrcmp(line.buffer, line.pos, ".")==0 )
		{
			//any other line starting with a . will be marked as debug line...
			//i.e. .type...
			line.is_debug_line = 1;
			commentLine(instance, &line, NULL);
		}

		//we keep empty-lines/comments if debugging symbols are on
		if ( line.length==0 || line.pos==line.length )
			line.is_debug_line = 1;

		 if ( line.buffer[line.pos] == COMMENT_SYMBOL )
			line.is_debug_line = 1;

		if ( file->add_debug_symbols != 1 )
		{
			if ( line.is_debug_line == 1 )
				continue;

			//get rid of comments!
			disposeComments(&line);
		}

		//set line properties we already found out
		line.is_marker_line = isMarkerLine(instance, &line);

		//.text section line - just add it
		if ( is_text_section == 1 )
		{
			//set the address for this line
			line.addr = instance->text_addr;

			//do we need to increment the addr counter?
			//it will only be incremented for command statements!
			//empty/commented lines, .globl and markers will be ignored
			if ( line.is_debug_line==0 && line.is_globl_line==0 && line.is_marker_line==0 )
				instance->text_addr = instance->text_addr+1;

			result = addLine(&instance->text_section, &line);
			if ( result != 0 )
				return ERR_LINKER_MEM;
		}
		else if ( is_data_section == 1 )
		{
			//set the current address to be the lines address
			line.addr =  instance->data_addr;

			//we have to analyze the datatype that may occur
			//everything other than starting with a "." will be added
			//without any calculations
			data_size = 0;
			if ( substrcmp(line.buffer, line.pos, ".") != 0 )
			{
			}
			else if ( substrcmp(line.buffer, line.pos, ".string") == 0 )
			{
				line.pos = line.pos+7;
				lnk_disposeWhitespace(&line);
				data_size = getStringSize(instance, &line);
			}
			else if ( substrcmp(line.buffer, line.pos, ".byte") == 0 )
			{
				data_size = sizeof(char);
			}
			else if ( substrcmp(line.buffer, line.pos, ".long") == 0 )
			{
				data_size = sizeof(int);
			}
			else if ( substrcmp(line.buffer, line.pos, ".rept") == 0 )
			{
				line.pos = line.pos+5;
				lnk_disposeWhitespace(&line);
				
				//get the size that is defined after .rept (.rept 10 - means 10 bytes for this record)
				data_size = getSizeIdentifier(instance, &line);

				//add .rept line to the .data section
				addLine(&instance->data_section, &line);

				//skip till .endr!
				while ( readLine(instance, fh, &line) >= 0 )
				{
					lnk_disposeWhitespace(&line);
					if ( substrcmp(line.buffer, line.pos, ".endr") == 0 )
						break;
					
					//add the line to the output .data section
					addLine(&instance->data_section, &line);
				}

				//the line with .endr will be added below
			}
			else
			{
				printf("LINKER_ERROR: unrecognized data type [%s:", getFilename(instance, line.file_id));
				printf("%d] - ignoring\n", line.line_no);
				return -1;
			}

			//if size_offset is negative
			//there was an error while parsing...
			if ( data_size < 0 )
				return data_size;

			//add the calculated data_size to the data_addr
			instance->data_addr = instance->data_addr+data_size;

			//add the current line to the data section
			addLine(&instance->data_section, &line);
			if ( result != 0 )
				return ERR_LINKER_MEM;
		}
	}

	return 0;
}

int linker_appendFile(linker *instance, char *file_name, int add_debugging_symbols)
{
	int fh;
	int result;
	File *new_file;

	MarkersList *local_markers;

	//check if linker_create was
	//called successfully before
	if ( instance->initiated != 1 )
		return ERR_LINKER_NOOP;

	//try to open the file
	fh = open(file_name, O_RDONLY, 0);
	if ( fh < 0 )
		return ERR_LINKER_FOPEN;

	//now add the file_name to the fileslist
	new_file = addFileToList(instance, file_name);
	if ( new_file == NULL )
		return ERR_LINKER_MEM;

	new_file->add_debug_symbols = add_debugging_symbols;

	//get the markersList reference of the newly added file
	local_markers = &new_file->markers;
	if ( local_markers == NULL )
		return ERR_LINKER_MEM;

	//parse the source file into text/data segments
	result = parseSourceFile(instance, new_file, fh, local_markers);
	if ( result < 0 )
		return result;

	//close the input file and we are done
	close(fh);

    return 0;
}

/**
 * resolves the marker lines of the given file
 * and adds them to the markers list with the appropriate addresses
 */
int resolveMarkers(linker *instance, File *file, LinesList *lines)
{
	int result;
	char addr_info[10]; //SYNC: MAX_ADDR_LENGTH+4!!!
	char addr_buffer[MAX_ADDR_LENGTH];

	int delete_line;

	Line *curr_line;
	Line *line_to_del;

	//find all code lines of this file
	curr_line = Get_Front_Of_LinesList(lines);
	while ( curr_line != NULL )
	{
		delete_line = 0;

		//we only care about lines that belong to this file and are marker/globl lines
		if ( curr_line->file_id==file->id && (curr_line->is_marker_line==1 || curr_line->is_globl_line==1) )
		{
			//dispose possible whitespace
			curr_line->pos = 0; //just to make sure move the position pointer to pos 0
			lnk_disposeWhitespace(curr_line);

			if ( curr_line->is_globl_line == 1 )
			{
				//globls line:
				//  we have to skipt he .globl statement
				curr_line->pos = curr_line->pos+6;
				lnk_disposeWhitespace(curr_line);

				//we add the marker with an invalid address
				//will be synced later
				result = addMarker(instance, curr_line, &instance->globls, -1);
				if ( result != 0 )
					return result;
			}
			else
			{
				//got normal marker:
				//parse the marker and add it to the markers list and store its address
				result = addMarker(instance, curr_line, &file->markers, curr_line->addr);
				if ( result != 0 )
					return result;
			}

			//if debugging symbols are not set for this file
			//remove this line
			if ( file->add_debug_symbols != 1 )
			{
				delete_line = 1;
			}
			else
			{	
				//mark this file as debug line and comment it out
				curr_line->is_debug_line = 1;
	
				//reset string buffers
				memset(addr_info, 0, MAX_ADDR_LENGTH+4);
				memset(addr_buffer, 0, MAX_ADDR_LENGTH);
	
				//now we don't need this line anymore - comment it!
				strcat(addr_info, " [@");
				strcat(addr_info, convertAddr(addr_buffer, curr_line->addr));
				strcat(addr_info, "]");
	
				commentLine(instance, curr_line, addr_info);
			}
		}

		//remove the line if necessary
		//otherwise just go to the next element
		line_to_del = curr_line;
		curr_line   = Get_Next_In_LinesList(curr_line);

		if ( delete_line == 1 )
			Remove_From_LinesList(lines, line_to_del);
	}

	return 0;
}

/**
 * invokes the resolving of ALL markers
 * in ALL files (.text and .data section)
 */
int resolveFileMarkers(linker *instance)
{
	int result;
	File *curr_file;
	
	curr_file = Get_Front_Of_FilesList(&instance->files);
	while ( curr_file != NULL )
	{
		//clear the markers list
		Clear_MarkersList(&curr_file->markers);

		//resolve markers from text section
		result = resolveMarkers(instance, curr_file, &instance->text_section);
		if ( result != 0 )
			return result;

		//resolve markers from data section
		result = resolveMarkers(instance, curr_file, &instance->data_section);
		if ( result != 0 )
			return result;

		//lets sync the .globls marker of the current file...
		syncGloblsWithMarkers(&instance->globls, &curr_file->markers);

		curr_file = Get_Next_In_FilesList(curr_file);
	}

	return 0;
}

/**
 * replaces the next marker (found in src_line at src_line->pos)
 * by parsing the identifier, resolving its address and appending the resolved address
 * to result_line
 * if an address can not be resolved (undefined marker usage) a error will be printed and
 * the result value will be negative
 */
int replaceNextMarker(linker *instance, Line *src_line, Line *result_line, MarkersList *markers_list)
{
	int result;
	int addr;
	int dollar_found;
	char addr_buffer[MAX_ADDR_LENGTH];
	char label_buffer[MAX_IDENT_LENGTH];
	Marker *marker;

	//see if we find a dollar sign on pos 0
	dollar_found = 0;
	if ( src_line->buffer[src_line->pos] == '$' )
	{
		result_line->buffer[result_line->pos] = src_line->buffer[src_line->pos]; //copy the dollar
		result_line->pos = result_line->pos+1; //go to next pos in result
		src_line->pos    = src_line->pos+1;    //skip dollar sign
		dollar_found     = 1;                  //mark dollar as found
	}

	//get the next identifier (which has to be replaced)
	result = getNextIdentifierInLine(instance, src_line, label_buffer);
	if ( result == 1 )
	{
		//we have to take care that we do NOT replace any restricted labels...
		marker = findInMarkersList(&instance->restricted, label_buffer);
		if ( marker != NULL )
		{
			strcat(result_line->buffer, label_buffer);
			//NOTE: don't forget to update the line pos
			result_line->pos = result_line->pos+strlen(label_buffer);
			return 0;
		}
		else
		{
			addr = getMarkerAddr(markers_list, label_buffer);
			if ( addr == -1 )
			{
				//let's see if the globls list has this marker
				addr = getMarkerAddr(&instance->globls, label_buffer);
				if ( addr == -1 )
				{
					//label was not found!
					printf("LINKER_ERROR: Could not resolve marker [%s] - no definition found... ", label_buffer);
					printf("[%s", getFilename(instance, src_line->file_id));
					printf(":%d]\n", src_line->line_no);
					return -1;
				}
			}
			
			
			//if we now got a dollar at the first position and find a + at the next one
			//we have to add the addr and the number after the +
			//EDIT shuber: We have to substitute even if there is no $-sign. example, pushing symtab+0 on stack.
			if ( src_line->buffer[src_line->pos] == '+' )
			{
				//skip the + char
				src_line->pos = src_line->pos+1;
				addr = addr+getSizeIdentifier(instance, src_line);
			}

			//found address - now append it to the buffer
			strcat(result_line->buffer, convertAddr(addr_buffer, addr));
			result_line->pos = strlen(result_line->buffer);
		}
	}
	else if ( dollar_found==1 && result==0 )
	{
		//we did not find an identifier but dollar is set
		//so this could be $10
		//so just copy everything to the result till a comma is found
		while ( src_line->buffer[src_line->pos]!=',' && src_line->pos<=src_line->length )
		{
			result_line->buffer[result_line->pos] = src_line->buffer[src_line->pos];
			result_line->pos = result_line->pos+1;
			src_line->pos    = src_line->pos+1;
		}
	}

	return 0;
}

int replaceMarkers(linker *instance, Line *result_line, Line *src_line, MarkersList *markers_list)
{
	int result;
	char opcode[MAX_IDENT_LENGTH];

	//so we just copy the data... no replacements are done
	memcpy(result_line, src_line, sizeof(Line));

	//skip empty and debug lines!
	if ( src_line->pos==src_line->length || src_line->is_debug_line==1 )
		return 0;

	//opcode {%register|label} {%register|label}
	//copy whitespace and opcode
	lnk_disposeWhitespace(src_line);
	result = getNextIdentifierInLine(instance, src_line, opcode);
	if ( result < 0 )
	{
		//result < 0 means: error (too long identifer)
		return result;
	}
	else if ( result == 0 )
	{
		printf("LINKER_ERROR: Line [%s] ", src_line->buffer);
		printf("is malformed! [%s:", getFilename(instance, src_line->file_id));
		printf("%d]\n", src_line->line_no);
		//result = 1 means: nothing found (at this position)
		return -1;
	}
	else
	{
		//dispose whitespace AFTER opcode
		lnk_disposeWhitespace(src_line);

		//copy first part of the line to the resulting line
		memset(result_line->buffer, 0, MAX_LINE_LENGTH);
		memcpy(result_line->buffer, src_line->buffer, src_line->pos);

		//update line->pos to be at the correct position
		result_line->pos = src_line->pos;

		//parse and replace the label
		result = replaceNextMarker(instance, src_line, result_line, markers_list);
		if ( result != 0 )
			return result;

		//append up to ','
		while (	src_line->buffer[src_line->pos]!=',' && src_line->pos <= src_line->length )
		{
			result_line->buffer[result_line->pos] = src_line->buffer[src_line->pos];
			result_line->pos = result_line->pos+1;
			src_line->pos    = src_line->pos+1;
		}


		//If we have finished and there is no 2nd operator
		if( src_line->pos == src_line->length )
			return 0;

		//Eat the ','
		else
		{
			result_line->buffer[result_line->pos] = src_line->buffer[src_line->pos];
			result_line->pos = result_line->pos+1;
			src_line->pos    = src_line->pos+1;
		}

		//parse and replace the label
		lnk_disposeWhitespace(src_line);
		result = replaceNextMarker(instance, src_line, result_line, markers_list);
		if ( result != 0 )
			return result;

		//append rest of line
		while ( src_line->pos <= src_line->length )
		{
			result_line->buffer[result_line->pos] = src_line->buffer[src_line->pos];
			result_line->pos = result_line->pos+1;
			src_line->pos    = src_line->pos+1;
		}
	}

	return 0;
}

/**
 * adds base_addr to every address of the given lines list
 */
void updateLinesAddresses(LinesList *lines, int base_addr)
{
	Line *curr_line;
	
	curr_line = Get_Front_Of_LinesList(lines);
	while ( curr_line != NULL )
	{
		curr_line->addr = curr_line->addr+base_addr;
		curr_line = Get_Next_In_LinesList(curr_line);
	}
}

void escapeBufferCharacters(char *buffer)
{
	int idx;
	int idy;
	int buffer_length;
	char next;
	
	idx = 0;
	buffer_length = strlen(buffer);
	while ( idx < buffer_length )
	{
		//current char an escape char?
		if ( buffer[idx] == '\\' )
		{
			//have a look at the following character
			//if it is one of our special characters
			//let it be - otherwise remove this escape!
			next = buffer[idx+1];

			//note: the chars come from typearith.cpp!
			if ( !(next=='n' || next=='r' || next=='t' || next=='\\' || next=='b' || next=='\'' || next=='\"' || next=='0') )
			{
				//move all chars one position to the left
				idy = idx;
				while ( idy < buffer_length )
				{
					buffer[idy]   = buffer[idy+1];
					buffer[idy+1] = '\0';
					idy = idy+1;
				}
			}
		}
		
		idx = idx+1;
	}
}

int linker_produce(linker *instance, char *output_filename)
{
	int fh;
	int entry_addr;
	int result;
	int last_file_id;

	Line *line;
	Line replaced_line;

	File *curr_file;

	char addr_buffer[MAX_ADDR_LENGTH];

	//is this linker initiated?
	if ( instance->initiated != 1 )
		return ERR_LINKER_NOOP;

	//we have to add the .text section size to every address in the .data section
	updateLinesAddresses(&instance->data_section, instance->text_addr);

	//now loop through the .text and .data lists of every file
	//find markers and .globls and calculate their addresses
	result = resolveFileMarkers(instance);
	if ( result != 0 )
		return result;

	//try to create output file
	fh = open(output_filename, O_CREAT | O_WRONLY | O_TRUNC, 0777);
	if ( fh < 0 )
		return ERR_LINKER_OUTPUT_FOPEN;

	instance->output_fh = fh;

	//some advertisement!
	appendOutput(instance, "# linked executable code generated by HRWCC\n\n");

	//now let's write the file!

	//make sure EXEC_ENTRY_POINT is found!
	entry_addr = getMarkerAddr(&instance->globls, EXEC_ENTRY_POINT);
	if ( entry_addr < 0 )
	{
		printf("LINKER_ERROR: reference to entry point (%s) missing!\n", EXEC_ENTRY_POINT);
		return ERR_LINKER_ENTRY_POINT_MISSING;
	}

	//create kick of code to EXEC_ENTRY_POINT
	//first thing: write text section
	appendOutput(instance, ".section .text\n\n");

	appendOutput(instance, "call ");
	appendOutput(instance, convertAddr(addr_buffer, entry_addr));
	appendOutput(instance, "\n");
	appendOutput(instance, "pushl %eax\n");
	appendOutput(instance, "call exit\n\n");

	last_file_id = -1; //set to an invalid value
	line         = Get_Front_Of_LinesList(&instance->text_section);
	while ( line != NULL )
	{
		//make sure we get the correct reference to the file
		//we are currently browsing through
		//we change the list at every new file we discover
		if ( last_file_id != line->file_id )
		{
			curr_file = getFileOfList(instance, line->file_id);
		}

		//replace possible markers in this line
		result = replaceMarkers(instance, &replaced_line, line, &curr_file->markers);
		if ( result != 0 )
			return result;

		appendOutput(instance, replaced_line.buffer);
		appendOutput(instance, "\n");

		//the current line is now the "old" line
		last_file_id = line->file_id;

		line = Get_Next_In_LinesList(line);
	}

	//next thing: write data section
	appendOutput(instance, "\n.section .data\n\n");

	line = Get_Front_Of_LinesList(&instance->data_section);
	while ( line != NULL )
	{
		//here we really have to escape characters!
		escapeBufferCharacters(line->buffer);
		appendOutput(instance, line->buffer);
		appendOutput(instance, "\n");

		line = Get_Next_In_LinesList(line);
	}

	return 0;
}
