#include "../include/hrwcccomp.h"

#include "preproc.h"
#include "stageutils.h"

int commstage_getNext(preproc *instance, Character *next);
int directivestage_getNext(preproc *instance, Character *next);
int substage_getNext(preproc *instance, Character *next);

void preproc_reportError(preproc *instance, char *errstr, CharacterLine *line, int type)
{
	Character chr;
	char *filename;
	int line_pos;



	//Print the error messages
	if ( type == PREPROC_WARNING )
		printf("PREPROC_WARNING: %s ", errstr);
	else
		printf("PREPROC_ERROR: %s ", errstr);
	
	filename = NULL;
	
	if ( line != NULL )
	{
		chr = line->buffer[0];
		filename = preproc_getFilename(instance, chr.fileId);
		if( filename )
		{
			printf("[%s:", filename);
			printf("%d:", chr.line);
			printf("%d] {", chr.column);
		}
		else
		{
			printf("[ERR filename:%d:", chr.line);
			printf("%d] {", chr.column);
		}

		line_pos = 0;
		chr      = line->buffer[line_pos];
		while ( line_pos<line->length && chr.value!='\0' )
		{
			chr = line->buffer[line_pos];
			printf("%c", chr.value);
			line_pos = line_pos+1;
		}

	}
	
	puts("}");
}

void preproc_reportError_s(preproc *instance, char *errstr_format, char *arg1, int type)
{
	//Print the error messages
	if ( type == PREPROC_WARNING )
		printf("PREPROC_WARNING%s ", ":");
	else
		printf("PREPROC_ERROR%s ", ":");

	if ( arg1 != NULL )
	{
		printf(errstr_format, arg1);
		puts("");
	}
	else
	{
		puts(errstr_format);
	}
}

//NOTE: this function has to be SYNCHRONIZED with error.h
int isPreprocError(int code)
{
    //between -10000 and -10499
    if ( code>-10000 && code<-10499 )
        return 1;

    return 0;
}

//NOTE: this function has to be SYNCHRONIZED with error.h
int isPreprocWarning(int code)
{
    //between -10500 and -10999
    if ( code>-10500 && code<-10999 )
        return 1;

    return 0;
}

void initLine(CharacterLine *line)
{
	memset(line, 0, sizeof(CharacterLine));
	//This does not work, because Character is not a char
    //memset(line->buffer, 0, PREPROC_MAX_LINE_LENGTH);
	
    line->length      = 0;
    line->pos         = 0;
    line->posInString = 0;
    line->posEscaped  = 0;
    line->skip        = 0;
}

void updateLineProperties(CharacterLine *line)
{
	Character chr;

    if ( line->pos > line->length )
            return;

	chr = line->buffer[line->pos];
    //see if we are within a string
    if ( line->posEscaped == 0 )
    {
        if ( chr.value == '"' )
        {
            if ( line->posInString == 1 )
                line->posInString = 0;
            else
                line->posInString = 1;
        }
    }

    //check if we get escaped!
    line->posEscaped = 0;	
    if ( chr.value == '\\' )
        line->posEscaped = 1;
}

void disposeWhitespace(CharacterLine *line)
{
	Character chr;
	
	chr = line->buffer[line->pos];
    while ( isWhitespace(chr.value) == 1 )
    {
        line->pos = line->pos+1;
        chr       = line->buffer[line->pos];

        if ( chr.value == '\0' )
        	break;
    }
}

void disposeRestOfLine(CharacterLine *line)
{
    line->pos = line->length-1;
}

int prevstage_getNext(preproc *instance, int curr_stage, Character *next)
{
    curr_stage = curr_stage-1;

    if ( curr_stage == FILESTACKSTAGE )
        return fstack_getNext(instance, next);
    
    if ( curr_stage == COMMSTAGE )
        return commstage_getNext(instance, next);

    if ( curr_stage == SUBSTAGE )
        return substage_getNext(instance, next);

    if ( curr_stage == DIRECTIVESTAGE )
        return directivestage_getNext(instance, next);

    puts("prevstage_getNextChar failed");
    exit(1);
}

int getNextLine(preproc *instance, int curr_stage, CharacterLine *line)
{
    int result;
    int idx;
    Character chr;
    
    //reset structure
    initLine(line);

    idx = 0;
    while ( idx < PREPROC_MAX_LINE_LENGTH-1 )
    {
        result = prevstage_getNext(instance, curr_stage, &line->buffer[idx]);
        if ( result != 0 )
            return result;

        //increment the length counter
        line->length = line->length+1;

        //if we reached the line end - we are done
        chr = line->buffer[idx];
        if ( chr.value == '\n' )
           break;

        idx = idx+1;
    }
    
    //if we did not stop because of a newline symbol
    //we return an error
    if ( idx == PREPROC_MAX_LINE_LENGTH-1 )
    {
    	preproc_reportError(instance, "Sourceline too long", line, PREPROC_ERROR);
        return ERR_PREPROC_MEM;
    }

    return 0;
}

int disposeMultilineSatement(preproc *instance, int curr_stage, CharacterLine *line)
{
	int result;
	Character curr_chr;
	Character prev_chr;

	curr_chr = line->buffer[line->length];
	prev_chr = line->buffer[line->length-1];
	while ( prev_chr.value=='\\' && curr_chr.value=='\n' )
	{
		result = getNextLine(instance, curr_stage, line);
		if ( result != 0 )
			return result;

		curr_chr = line->buffer[line->length];
		prev_chr = line->buffer[line->length-1];
	}
	
	return 0;
}

void printCharacters(Character *s)
{
    int idx;
    Character c1;
    
    idx = 0;
    c1  = s[idx];
    while ( c1.value != '\0' )
    {
        printf("%c", c1.value);
        idx = idx+1;
        c1  = s[idx];
    }
}

int CharacterStrCmp(Character *buffer, int start, int length, char *cmp)
{
    int idx;
    Character chr;
    
    idx = 0;
    chr = buffer[start+idx];
    while ( chr.value!='\0' && idx<length )
    {
        if ( chr.value != cmp[idx] )
            return 1;

        idx = idx+1;
        chr = buffer[start+idx];
    }
    
    return 0;
}

int CharacterSubCmp(Character *s1, int start, int length, Character *s2)
{
    int idx;
    Character c1;
    Character c2;
    
    idx = 0;
    c1  = s1[start+idx];
    c2  = s2[idx];
    while ( c1.value!='\0' && idx<length )
    {
        if ( c1.value != c2.value )
            return 1;

        idx = idx+1;
	    c1  = s1[start+idx];
	    c2  = s2[idx];
    }
    
    return 0;
}
 
int CharacterCmp(Character *s1, Character *s2)
{
    int idx;
    Character c1;
    Character c2;

    idx = 0;
    c1  = s1[idx];
    c2  = s2[idx];
    while ( c1.value==c2.value && c1.value!='\0' )
    {
        idx = idx+1;
	    c1  = s1[idx];
	    c2  = s2[idx];
    }

    return (c1.value-c2.value);
}

int CharacterLen(Character *s)
{
    int length;
    Character chr;
    
    length = 0;
    chr    = s[length];
    while ( chr.value != '\0' )
    {
        length = length+1;
        chr    = s[length];
    }
    
    return length;
}

int CharacterCpy(Character *dest, Character *src)
{
    int idx;
    Character c1;
    
    idx = 0;
    c1  = src[idx];
    while ( c1.value != '\0' )
    {
        dest[idx] = src[idx];
        idx = idx+1;
        c1  = src[idx];
    }
    
    //copy terminating character too!
    dest[idx] = src[idx];

    return 0;
}

int CharacterCat(Character *dest, Character *src)
{
    int dest_idx;
    int src_idx;
    Character c1;

    //search the first empty character in dest
    dest_idx = 0;
    c1       = dest[dest_idx];
    while ( c1.value != '\0' )
    {
        dest_idx = dest_idx+1;
	    c1       = dest[dest_idx];
    }

    src_idx = 0;
    c1      = src[src_idx];
    while ( c1.value!='\0' )
    {
        dest[dest_idx] = src[src_idx];
        dest_idx       = dest_idx+1;
        src_idx        = src_idx+1;	
	    c1             = src[src_idx];
    }

    //copy terminating character too!
    dest[dest_idx] = src[src_idx];

    return 0;
}

int isMacroDefined(preproc *instance, Character *name)
{
    DefineElementNode *node;

    node = Get_Front_Of_DefinesList(&instance->definesList);

    while ( node != NULL )
    {
        if ( CharacterCmp(name, node->name) == 0 )
            return 1;

        node = Get_Next_In_DefinesList(node);
    }

    return 0;
}

int getNextIdentifier(Character *buffer, int buffer_length, CharacterLine *line)
{
    int idx;
    Character chr;
    
    idx = 0;
    chr = line->buffer[line->pos];
    while ( idx < buffer_length )
    {
        if ( idx == 0 )
        {
            //on position 0 we expect alpha or _
            if ( isalpha(chr.value)==0 && chr.value!='_' )
                return 1;
        }
        else
        {
            //we only allow alphanum and _
            //otherwise we are done
            if ( isalnum(chr.value)==0 && chr.value!='_' )
                break;
        }

        buffer[idx] = line->buffer[line->pos];
        line->pos   = line->pos+1;
        idx         = idx+1;
        chr         = line->buffer[line->pos];
    }

    return 0;
}

/**
 * copies all characters till a comma is read
 * it takes care of string-escaping and 
 */
int getNextParamValue(Character *buffer, int buffer_length, CharacterLine *line) 
{
	int idx;
	int in_string;
	int brackets_count;
	Character curr_chr;
	Character prev_chr;

	idx            = 0;
	in_string      = 0;
	brackets_count = 0;
	curr_chr       = line->buffer[line->pos];
	prev_chr       = line->buffer[line->pos-1];
	while ( idx < buffer_length )
	{
		if ( in_string==0 && brackets_count==0 )
		{
			if ( curr_chr.value == ')' )
				break;

			if ( curr_chr.value == ',' )
				break;
		}
		
		if ( curr_chr.value == '"' )
		{
			if ( prev_chr.value != '\\' )
			{
				if ( in_string == 1 )
					in_string = 0;
				else
					in_string = 1;
			}
		}

		//accounting of brackets
		if ( curr_chr.value == '(' )
			brackets_count = brackets_count+1;

		if ( curr_chr.value == ')' )
			brackets_count = brackets_count-1;
		
		buffer[idx] = line->buffer[line->pos];
		line->pos   = line->pos+1;
		idx         = idx+1;
		curr_chr    = line->buffer[line->pos];
		prev_chr    = line->buffer[line->pos-1];
	}

	return 0;
}

int parseParametersList(preproc *instance, ParametersList *parameters, CharacterLine *line, int idents_only)
{
    int is_start;
    int result;
    ParameterElement *param;
    Character chr;
    
    //clear the parameters list
    Clear_ParametersList(parameters);

    //get rid of whitespace which can be between some value or left paranthesis
    disposeWhitespace(line);

    //make sure we even got a paranthesis
    chr = line->buffer[line->pos];
    if ( chr.value != '(' )
    {
        //we have nothing to do...
        return 0;
    }

    //skip paranthesis
    line->pos = line->pos+1;

    //according to wikipedia a left paranthesis is not allowed in other cases...
    //LIKE: #define FOO (double)(someint)
    is_start = 1;
    while ( line->pos < line->length )
    {
        disposeWhitespace(line);

        //make sure we are not at the end of the statements
        chr = line->buffer[line->pos];
        if ( chr.value == ')' )
            break;
        
        //if we got some whitespace - get rid of it
        disposeWhitespace(line);
        
        //if we got a comma or we haven't even started yet we have to create a new parameter...
        chr = line->buffer[line->pos];
        if ( is_start==1 || chr.value==',' )
        {
            if ( chr.value == ',' )
                line->pos = line->pos+1;

            is_start = 0;
#ifndef __HRWCC__
            param = (ParameterElement *)malloc(sizeof(ParameterElement));
#else
            param = malloc(sizeof(ParameterElement));
#endif
            if ( param == NULL )
            {
		    	preproc_reportError(instance, "Could not allocate new memory", line, PREPROC_ERROR);
                return ERR_PREPROC_MEM;
            }

			memset(param, 0, sizeof(ParameterElement));

            //if we got some whitespace - get rid of it
            disposeWhitespace(line);
        }

        memset(param->name, 0, sizeof(Character)*PREPROC_MAX_PARAM_NAME_LENGTH);
		result = 0;
        if ( idents_only == 1 )
        	result = getNextIdentifier(param->name, PREPROC_MAX_PARAM_NAME_LENGTH, line);
        else
        	//we have to collect all characters till we find a comma
        	//take care of string-escaping and expressions (where a comma could exist)
        	result = getNextParamValue(param->name, PREPROC_MAX_PARAM_NAME_LENGTH, line);

        if ( result != 0 )
        {
	    	preproc_reportError(instance, "Found invalid formated macro statement (check parameters)", line, PREPROC_WARNING);
            return WARN_PREPROC_INVALID_MACRONAME;
        }

        //and append the paramter to the list
        Add_To_Front_Of_ParametersList(parameters, param);
    }

    //if the last character was no right paranthesis there is something wrong
    chr = line->buffer[line->pos];
    if ( chr.value != ')' )
    {
    	preproc_reportError(instance, "Found invalid macro statement...", line, PREPROC_WARNING);
        return WARN_PREPROC_INVALID_MACRONAME;
    }
    else
    {
        //skip right paranthesis
        line->pos = line->pos+1;
    }

    return 0;
}
