#include "../include/hrwcccomp.h"
#include "../include/error.h"

#include "preproc.h"
#include "stageutils.h"
#include "directiveutils.h"

//implement the list functions
IMPLEMENT_LIST(DefinesList, DefineElementNode)
IMPLEMENT_LIST(ParametersList, ParameterElement)

int directivestage_init(preproc *instance)
{
    initLine(&instance->directivestage);

    memset(instance->branchStack, 0, sizeof(int)*PREPROC_BRANCH_STACK_SIZE);
    instance->branchStackIdx = 0;

    Clear_DefinesList(&instance->definesList);

    return 0;
}

int directivestage_destroy(preproc *instance)
{
    DefineElementNode *curr_node;
    DefineElementNode *next_node;
    ParameterElement *curr_param;
    ParameterElement *next_param;

    //we have to do a lot of cleanup here!
    //first of all clean the define/macros and their value
    curr_node = Get_Front_Of_DefinesList(&instance->definesList);

    //free every node element
    while ( curr_node != NULL )
    {
//printf("Cleaning Define: [%d] ", curr_node->valueLength);
//printCharacters(curr_node->name);
//printf("\n======\n");
//printCharacters(curr_node->value);
//printf("\n======\n");
        if ( curr_node->value != NULL )
            free(curr_node->value);

        //next thing is to clear the parameters if there are any
        curr_param = Get_Front_Of_ParametersList(&curr_node->parameters);
        while ( curr_param != NULL )
        {
            next_param = Get_Next_In_ParametersList(curr_param);

            free(curr_param);
            
            curr_param = next_param;
        }

        Clear_ParametersList(&curr_node->parameters);

        next_node = Get_Next_In_DefinesList(curr_node);

        free(curr_node);
        
        curr_node = next_node;
    }

    //clear the list
    Clear_DefinesList(&instance->definesList);

    return 0;
}

/**
 * this function is only for the API to manually add defines.
 * NOTE: it is not used internally since we only deal with Character objects!
 */
int directivestage_addDefine(preproc *instance, char *name)
{
	int idx;
	int name_length;
	DefineElementNode *new_node;
	Character *chr;

	//we got a valid macroname: store it
#ifndef __HRWCC__
	new_node = (DefineElementNode *)malloc(sizeof(DefineElementNode));
#else
	new_node = malloc(sizeof(DefineElementNode));
#endif
	if ( new_node == NULL )
	{
		preproc_reportError(instance, "Could not allocate new memory", NULL, PREPROC_ERROR);
		return ERR_PREPROC_MEM;
	}
	
	//reset all
	memset(new_node, 0, sizeof(DefineElementNode));

	idx         = 0;
	name_length = strlen(name);
	while ( idx <= name_length ) //also copy the terminating char!
	{
		//we just set the value!
		//all other properties will be resetted
		chr         = &new_node->name[idx];
		chr->value  = name[idx];
		chr->fileId = -1;
		chr->line   = -1;
		chr->column = -1;
		idx = idx+1;
	}

	//make sure macroname is not already defined!
	//NOTE: since the substage is BEFORE this stage
	//      all occurings of an already defined macro name will have been replaced ;(
	if ( isMacroDefined(instance, new_node->name) == 1 )
	{
		free(new_node);

		preproc_reportError(instance, "Manually added macro - name already defined!", NULL, PREPROC_WARNING);
		return WARN_PREPROC_MACRO_ALREADY_DEFINED;
	}

	new_node->value = NULL;

	Add_To_Front_Of_DefinesList(&instance->definesList, new_node);
	return 0;
}

int isDirectiveLine(CharacterLine *line)
{
	int idx;
	Character chr;

	//we cannot use "disposeWhitespace" here because it actually moves the line->pos
	//so lets skip whitespace ourselves
	idx = 0;
	while ( idx < line->length )
	{
		chr = line->buffer[idx];
		//find first non blank character:
		if ( isWhitespace(chr.value) == 0 )
			break;

		idx = idx+1;
	}
	
	//if the first char is sharp - we maybe got something
	chr = line->buffer[idx];
	if ( chr.value == '#' )
	{
		//now we actually can change linepos
		line->pos = idx+1;
		return 1;
	}

	return 0;
}

/**
 * compares the passed directive with the characters
 * starting at position line->pos in the line buffer
 */
int cmpDirectiveLine(CharacterLine *line, char *directive)
{
	Character chr;

    //first check if the pattern even matches
    if ( CharacterStrCmp(line->buffer, line->pos, strlen(directive), directive) == 0 )
    {
        //if now the following character (after the pattern) is some kind of whitespace we won
        chr = line->buffer[line->pos+strlen(directive)];
        if ( isWhitespace(chr.value) == 1 )
        {
            line->pos = line->pos+strlen(directive)+1;
            return 1;
        }
    }

    return 0;
}

int isIncludeDirective(CharacterLine *line)
{
    return cmpDirectiveLine(line, "include");
}

int isDefineDirective(CharacterLine *line)
{
    return cmpDirectiveLine(line, "define");
}

int isIfdefDirective(CharacterLine *line)
{
    return cmpDirectiveLine(line, "ifdef");
}

int isIfndefDirective(CharacterLine *line)
{
    return cmpDirectiveLine(line, "ifndef");
}

int isElseDirective(CharacterLine *line)
{
    return cmpDirectiveLine(line, "else");
}

int isEndifDirective(CharacterLine *line)
{
    return cmpDirectiveLine(line, "endif");
}

/**
 * expects to have line->pos at the last char after the actual
 * include statement: #include^
 */
int getIncludeProcessed(preproc *instance, CharacterLine *line)
{
    int idx;
    int is_system_include;
    char encapsulation_pattern;
    char filename[PREPROC_MAX_INCLUDEFILE_LENGTH];
    Character chr;
    
    //1) get rid of whitespace (between directive and filename)
    disposeWhitespace(line);

    //2) read from < or " till " or >
    is_system_include     = 0;
    encapsulation_pattern = '"';
    chr                   = line->buffer[line->pos];
    if ( chr.value == '<' )
    {
		is_system_include     = 1;
		encapsulation_pattern = '>';
    }
    else if ( chr.value != '"' )
    {
		preproc_reportError(instance, "Found invalid include directive", line, PREPROC_WARNING);
		return WARN_PREPROC_INCLUDE_INVALID;
    }

    //3) find the according encapsulation_pattern characters and store all characters in between in our filename buffer
    //just read in till we find "encapsulation_pattern" or \n 
    memset(filename, 0, PREPROC_MAX_INCLUDEFILE_LENGTH);

    idx   = 0;
    line->pos = line->pos+1;
    while ( line->pos+idx < line->length )
    {
		//we loop till we find the appropriate ending character or newline!
		chr = line->buffer[line->pos+idx];
		if ( chr.value == encapsulation_pattern )
			break;

		filename[idx] = chr.value;
		idx           = idx+1;

		//we have to make sure to not run over boundaries! (NOTE: ending \0!!)
		if ( idx == PREPROC_MAX_INCLUDEFILE_LENGTH )
		{
			preproc_reportError(instance, "Found filename exceeds MAX_FILENAME_LENGTH", line, PREPROC_WARNING);
			return WARN_PREPROC_FILENAME_TOO_LONG;
		}
    }

    //if the statement was not finished with an appropriate closing character
    //create a warning and ignore the statement!
    if ( chr.value != encapsulation_pattern )
    {
    	preproc_reportError(instance, "Found invalid include directive", line, PREPROC_WARNING);
		return WARN_PREPROC_INCLUDE_INVALID;
    }
    
    //now let's include the file :D
    return fstack_pushFile(instance, filename, is_system_include);
}

/**
 * starts at line->pos to gather all characters and store them with dynamic size
 * into the passed nodes value.
 * this function also takes care of escaped-multiline statements
 * returns 0 if successful and not 0 otherwise
 */
int getMacroValue(preproc *instance, DefineElementNode *node, CharacterLine *line)
{
	int result;
	int value_pos;
	int value_sum;
	int escaped_newline;

	#define VALUE_BUFFER_SIZE 32
	Character valueBuffer[VALUE_BUFFER_SIZE];
	Character prev_chr;
	Character curr_chr;
	Character next_chr;
	Character tmp_chr;

	//the value can be spanned over multiple lines by putting an escape before newline
	//allocate 1 Character - this enables us to call realloc later
#ifndef __HRWCC__
	node->value = (Character *)malloc(sizeof(Character));
#else
	node->value = malloc(sizeof(Character));
#endif
	if ( node->value == NULL )
	{
		free(node);
		preproc_reportError(instance, "Could not allocate new memory", line, PREPROC_ERROR);
		return ERR_PREPROC_MEM;
	}
	
	memset(node->value, 0, sizeof(Character));
	memset(valueBuffer, 0, sizeof(Character)*VALUE_BUFFER_SIZE);
	
	value_pos = 0;
	value_sum = 0;
	while ( line->pos < line->length )
	{
		//if we found a newline (that is not escaped)
		//we are done
		prev_chr = line->buffer[line->pos-1];
		curr_chr = line->buffer[line->pos];
		next_chr = line->buffer[line->pos+1];
		if ( prev_chr.value!='\\' && curr_chr.value=='\n' )
		{
			break;
		}
		
		//if we got an escaped linebreak - we don't store the escape!
		escaped_newline = 0;
		if ( curr_chr.value=='\\' && next_chr.value=='\n' )
		{
			escaped_newline = 1;
			line->pos = line->pos+1;
		}
		
		valueBuffer[value_pos] = line->buffer[line->pos];
		line->pos = line->pos + 1;
		value_pos  = value_pos  + 1;
		
		//just set a terminating character... otherwise we run into problems for sure
		tmp_chr       = valueBuffer[value_pos];
		tmp_chr.value = '\0';
		
		//we have to make sure to reallocate new memory if buffer is full
		if ( value_pos == VALUE_BUFFER_SIZE-1 )
		{
			//reallocate enough memory to store
			//the buffer into our DefineElement
			value_sum = value_sum+value_pos;
#ifndef __HRWCC__
			node->value = (Character *)realloc(node->value, sizeof(Character)*(value_sum+1));
#else
			node->value = realloc(node->value, sizeof(Character)*(value_sum+1));
#endif
			if ( node->value == NULL )
			{
				free(node);
				
				preproc_reportError(instance, "Could not allocate new memory", line, PREPROC_ERROR);
				return ERR_PREPROC_MEM;
			}
			
			CharacterCat(node->value, valueBuffer);
			tmp_chr       = node->value[value_sum];
			tmp_chr.value = '\0';
			
			//reset our buffer and our index counter
			memset(valueBuffer, 0, sizeof(Character)*VALUE_BUFFER_SIZE);
			value_pos = 0;
		}
		
		//if we got a newline that is escaped we have to read in the next line and continue parsing
		if ( escaped_newline == 1 )
		{
			result = getNextLine(instance, DIRECTIVESTAGE, line);
			if ( result != 0 ) //error OR eof
				return result;
		}
	}
	
	//append the rest of the buffer to our value
	tmp_chr = valueBuffer[0];
	if ( tmp_chr.value != '\0' )
	{
		value_sum = value_sum+value_pos;
#ifndef __HRWCC__
		node->value = (Character *)realloc(node->value, sizeof(Character)*(value_sum+1));
#else
		node->value = realloc(node->value, sizeof(Character)*(value_sum+1));
#endif
		if ( node->value == NULL )
		{
			free(node);
			
			preproc_reportError(instance, "Could not allocate new memory", line, PREPROC_ERROR);
			return ERR_PREPROC_MEM;
		}
		
		CharacterCat(node->value, valueBuffer);
		tmp_chr       = node->value[value_sum];
		tmp_chr.value = '\0';
	}
	
	node->valueLength = value_sum;

	return 0;
}

int getDefineProcessed(preproc *instance, CharacterLine *line)
{
	int result;
	Character name_buffer[PREPROC_MAX_MACRO_NAME_LENGTH];
	DefineElementNode *new_node;
	Character chr;

	//1) get rid of whitespace (between directive and macro name)
	disposeWhitespace(line);

	//2) read everything in till PREPROC_MAX_MACRO_NAME_LENGTH is exceeded or no alphanum|_ is found
	memset(name_buffer, 0, sizeof(Character)*PREPROC_MAX_MACRO_NAME_LENGTH);
	if ( getNextIdentifier(name_buffer, PREPROC_MAX_MACRO_NAME_LENGTH, line) != 0 )
	{
		preproc_reportError(instance, "Found invalid macro name beginning", line, PREPROC_WARNING);
		return WARN_PREPROC_INVALID_MACRONAME;
	}

	//make sure macroname is not already defined!
	//NOTE: since the substage is BEFORE this stage
	//      all occurings of an already defined macro name will have been replaced ;(
	if ( isMacroDefined(instance, name_buffer) == 1 )
	{
		preproc_reportError(instance, "Macro already defined", line, PREPROC_WARNING);

		//we have to look if we got a multiline define
		//and we have to get rid of them ALL!
		result = disposeMultilineSatement(instance, DIRECTIVESTAGE, line);
		if ( result != 0 )
			return result;

		return WARN_PREPROC_MACRO_ALREADY_DEFINED;
	}

	//we got a valid macroname: store it
#ifndef __HRWCC__
	new_node = (DefineElementNode *)malloc(sizeof(DefineElementNode));
#else
	new_node = malloc(sizeof(DefineElementNode));
#endif
	if ( new_node == NULL )
	{
		preproc_reportError(instance, "Could not allocate new memory", line, PREPROC_ERROR);
		return ERR_PREPROC_MEM;
	}

	//Reset memory
	memset(new_node, 0, sizeof(DefineElementNode));
	new_node->valueLength = 0;

	//copy over the constant name
	CharacterCpy(new_node->name, name_buffer);

	//3)  get rid of whitespace (between macro name and value)
	//we either got whitespace or left paranthesis!
	chr = line->buffer[line->pos];
	if ( chr.value!='(' && isWhitespace(chr.value)==0 )
	{
		preproc_reportError(instance, "Found invalid define statement", line, PREPROC_WARNING);
		return WARN_PREPROC_INVALID_MACRONAME;
	}

	//4) parse possible parameterized defines (I call it macro from here on!)
	result = parseParametersList(instance, &new_node->parameters, line, 1);
	if ( result != 0 ) 
	{
		free(new_node);
		return result;
	}

	//5) read in the value
	result = getMacroValue(instance, new_node, line);
	if ( result != 0 )
	{
		free(new_node);
		return result;
	}

	//add the list of defines
	Add_To_Front_Of_DefinesList(&instance->definesList, new_node);

	return 0;
}

#define BRANCH_IFDEF  1
#define BRANCH_IFNDEF 2
#define BRANCH_ELSE   3
#define BRANCH_ENDIF  4

/**
 * pushes the passed state onto the top of the stack
 * line is only used for debugging purposes
 */
void pushBranchStack(preproc *instance, int state, CharacterLine *line)
{
//printf("push %d:%d\n", instance->branchStackIdx, state);

	instance->branchStack[instance->branchStackIdx] = state;
	instance->branchStackIdx = instance->branchStackIdx+1;
}

/**
 * pops the current level
 * from the branchStack and checks if the state on the stack
 * matches to the popping state
 * line is only used for debugging purposes
 */
void popBranchStack(preproc *instance, int state, CharacterLine *line)
{
	int curr_level;

	curr_level = instance->branchStackIdx-1;
	if ( state == BRANCH_ELSE )
	{
		if ( 
			instance->branchStack[curr_level]!=BRANCH_IFDEF &&
			instance->branchStack[curr_level]!=BRANCH_IFNDEF
		   )
		{
			preproc_reportError(instance, "Detected wrong directive-branch-nesting (ELSE)", line, PREPROC_WARNING);
			//try to "fix" the error by doing nothing... is this a good choice?
			return;
		}
	}

	if ( state == BRANCH_ENDIF )
	{
		if ( 
			instance->branchStack[curr_level]!=BRANCH_IFDEF &&
			instance->branchStack[curr_level]!=BRANCH_IFNDEF &&
			instance->branchStack[curr_level]!=BRANCH_ELSE
			)
		{
			preproc_reportError(instance, "Detected wrong directive-branch-nesting (ENDIF)", line, PREPROC_WARNING);
			//try to "fix" the error by doing nothing... is this a good choice?
			return;
		}
	}

	if ( curr_level < 0 )
	{
		//try to correct the error ;(
		instance->branchStackIdx = 0;
		preproc_reportError(instance, "Detected wrong directive-branch-nesting", line, PREPROC_WARNING);
		return;
	}

//printf("pop %d:%d\n", curr_level, state);

	instance->branchStack[curr_level] = -1;
	instance->branchStackIdx = curr_level;
}

/**
 * very nifty function that dispose all lines
 * until the branch nesting equals the branch nesting when entering
 * this function enables quick skipping of lines that don't have to be shown
 * because the condition for showing them did not match
 */
int disposeUntilBranchEnds(preproc *instance, CharacterLine *line)
{
	int result;
	int entry_level;

	//current level!
	entry_level = instance->branchStackIdx-1;

	while ( 1 )
	{
		result = getNextLine(instance, DIRECTIVESTAGE, line);
		if ( result != 0 ) //error OR eof
			return result;

		if ( isDirectiveLine(line) == 1 )
		{
			if ( isIfdefDirective(line) == 1 )
			{
				pushBranchStack(instance, BRANCH_IFDEF, line);
			}
			else if ( isIfndefDirective(line) == 1 )
			{
				pushBranchStack(instance, BRANCH_IFNDEF, line);
			}
			else if ( isElseDirective(line) == 1 )
			{
				popBranchStack(instance,  BRANCH_ELSE, line);
				pushBranchStack(instance,  BRANCH_ELSE, line);
			}
			else if ( isEndifDirective(line) == 1 )
			{
				popBranchStack(instance, BRANCH_ENDIF, line);
			}

			if ( instance->branchStack[instance->branchStackIdx-1]==BRANCH_ELSE && entry_level==instance->branchStackIdx-1 )
				break;

			if ( entry_level == instance->branchStackIdx )
				break;
		}
	}

	//set position to zero so that the "normal" process can take place
	line->pos = 0;

	return 0;
}

int directivestage_getNext(preproc *instance, Character *next)
{
	int result;
	CharacterLine *line;
	Character ident_buffer[PREPROC_MAX_MACRO_NAME_LENGTH];

	//read in some chars and see if we got a directive we can handle
	//if we got a directive we can handle - call the specific handler!
	//otherwise get rid of the rest of the line and return an error
	//saying that we can't handle this directive

	next->value = '\0';

	while ( next->value == '\0' )
	{
		//do we have to fetch a new line?
		line = &instance->directivestage;
		if ( line->pos == line->length )
		{
			result = getNextLine(instance, DIRECTIVESTAGE, &instance->directivestage);
			if ( result != 0 ) //error OR eof
			{
				if ( instance->branchStackIdx != 0 )
					preproc_reportError(instance, "Detected wrong directive-branch-nesting (missing some [else|endif] statement?)", line, PREPROC_WARNING);

				return result;
			}
		}

		//update properties like escaped and in string etc
		updateLineProperties(&instance->commstage);

		//if we are on position 0 have a look if we got some
		//directive characters in this line
		//NOTE: we use idx here because we cannt change pos until we know for sure
		//      that we got a directive
		if ( line->pos==0 && line->posInString==0 )
		{
			if ( isDirectiveLine(line) == 1 )
			{
				//INCLUDE
				if ( isIncludeDirective(line) == 1 )
				{
					result = getIncludeProcessed(instance, line);
					if ( isPreprocError(result) == 1 )
						return result;

					//no matter if we got a valid result - just dispose the rest of the line
					disposeRestOfLine(line);
				}
				//DEFINE
				else if ( isDefineDirective(line) == 1 )
				{
					result = getDefineProcessed(instance, &instance->directivestage);
					if ( isPreprocError(result) == 1 )
						return result;

					//no matter if we got a valid result - just dispose the rest of the line
					disposeRestOfLine(line);
				}
				//IFDEF
				else if ( isIfdefDirective(line) == 1 )
				{
					memset(ident_buffer, 0, sizeof(Character)*PREPROC_MAX_MACRO_NAME_LENGTH);
					if ( getNextIdentifier(ident_buffer, PREPROC_MAX_MACRO_NAME_LENGTH, line) != 0 )
					{
						disposeRestOfLine(line);

						preproc_reportError(instance, "Found invalid/incomplete ifdef directive", line, PREPROC_WARNING);
					}
					else
					{
						pushBranchStack(instance, BRANCH_IFDEF, line);
						if ( isMacroDefined(instance, ident_buffer) == 0 )
						{
							//we skip till we find a line with elseif|else|endif
							disposeUntilBranchEnds(instance, line);
						}

						disposeRestOfLine(line);
					}
				}
				//IFNDEF
				else if ( isIfndefDirective(line) == 1 )
				{
					memset(ident_buffer, 0, sizeof(Character)*PREPROC_MAX_MACRO_NAME_LENGTH);
					if ( getNextIdentifier(ident_buffer, PREPROC_MAX_MACRO_NAME_LENGTH, line) != 0 )
					{
						disposeRestOfLine(line);
						preproc_reportError(instance, "Found invalid/incomplete ifndef directive", line, PREPROC_WARNING);
					}
					else
					{
						pushBranchStack(instance, BRANCH_IFNDEF, line);
						if ( isMacroDefined(instance, ident_buffer) == 1 )
						{
							//we skip till we find a line with elseif|else|endif
							disposeUntilBranchEnds(instance, line);
						}
						
						disposeRestOfLine(line);
					}
				}
				//ELSE
				else if ( isElseDirective(line) == 1 )
				{
					popBranchStack(instance,  BRANCH_ELSE, line);
					pushBranchStack(instance, BRANCH_ELSE, line);

					disposeUntilBranchEnds(instance, line);
					disposeRestOfLine(line);
				}
				//ENDIF
				else if ( isEndifDirective(line) == 1 )
				{
					popBranchStack(instance, BRANCH_ENDIF, line);
					disposeRestOfLine(line);
				}
				//<SOMETHING_UNKNOWN>
				else
				{
					preproc_reportError(instance, "Found invalid/incomplete preprocessor directive", line, PREPROC_WARNING);
					disposeRestOfLine(line);
				}
			}
		}

		*next = line->buffer[line->pos];
		line->pos = line->pos+1;
	}

	return 0;
}
