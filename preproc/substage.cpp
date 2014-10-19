#include "../include/hrwcccomp.h"
#include "../include/error.h"

#include "preproc.h"
#include "stageutils.h"
#include "directiveutils.h"

int substage_init(preproc *instance)
{
	initLine(&instance->substage);
	instance->replacement         = NULL;
	instance->replacementPos      = 0;
	instance->paramReplacement    = NULL;
	instance->paramReplacementPos = 0;

	return 0;
}

int substage_destroy(preproc *instance)
{
	return 0;
}

/**
 * checks if the 'pos' in the buffer is a possible begin of a define pattern
 * returns 0 if not and 1 if it is a valid start pattern
 * the start position in the buffer is passed in offset
 */
int isBufferPosMacroBegin(Character *buffer, int buffer_length, int pos, int *offset)
{
	Character chr;
	//either first two chars are ## XOR first char is NOT {alphanum|"_")
	//or position == 0

	if ( pos==0 || pos==buffer_length )
	{
		return 1;
	}

	chr = buffer[pos-1];
	if ( CharacterStrCmp(buffer, pos, 2, "##") == 0 )
	{
		*offset = pos+2;
		return 1;
	}
	//look at the leading character
	else if ( isalnum(chr.value)==0 && chr.value!='_' )
	{
		*offset = pos;
		return 1;
	}

	return 0;
}

/**
 * checks if the 'pos' in the buffer is a possible pattern for a constant
 * returns 0 if not and 1 if it is a valid start pattern
 * the end position in the buffer is passed in offset
 */
int isBufferPosMacroEnd(Character *buffer, int buffer_length, int pos, int *offset)
{
	Character chr;
	//either the two chars after start are ##
	//XOR last char is NOT {alphanum|"_")

	//make sure we don't run over the buffer
	if ( pos > buffer_length )
		return 0;

	if ( pos == buffer_length )
	{
		*offset = pos;
		return 1;
	}

	chr = buffer[pos];
	if ( CharacterStrCmp(buffer, pos, 2, "##") == 0 )
	{
		*offset = pos+2;
		return 1;
	}
	else if ( isalnum(chr.value)==0 && chr.value!='_' )
	{
		*offset = pos;
		return 1;
	}

	return 0;
}

/**
 * sets the replacement chracter if we are currently replacing something
 * it sets \0 to the characters value otherwise 
 */
void setReplacementCharacter(preproc *instance, Character *next)
{
	int param_length;
	int start_pos;
	int offset;
	ParameterElement *param;
	DefineElementNode *replacement;
	Character *value;

	//preset our return value
	next->value = '\0';

	//do we even have a replacement?
	if ( instance->replacement == NULL )
		return;

	//just to not have to write the long statement all the time!
	replacement = instance->replacement;
	value       = replacement->value;

	//if we are not currently replacing a parameter
	if ( instance->paramReplacement == NULL )
	{
		//look if we find a new parameter to replace!
		param = Get_Front_Of_ParametersList(&replacement->parameters);
	
		while ( param != NULL )
		{
			param_length = CharacterLen(param->name);
			start_pos  = 0;
			offset    = 0;
	
			if ( 
					isBufferPosMacroBegin(value, replacement->valueLength, instance->replacementPos, &start_pos)==1 &&
					isBufferPosMacroEnd(value, replacement->valueLength, start_pos+param_length, &offset)==1
				)
			{
				if ( CharacterSubCmp(value, start_pos, param_length, param->name) == 0 )
				{
					//skip the replacement pattern
					instance->replacementPos      = offset;

					//and set the parameter we should replace
					instance->paramReplacement    = param->replacement;
					instance->paramReplacementPos = 0;
					
					break;
				}
			}
	
			param = Get_Next_In_ParametersList(param);
		}
	}

	//if we are currently replacing a parameter
	if ( instance->paramReplacement != NULL )
	{
		//see if we reached the end
		if ( instance->paramReplacementPos == CharacterLen(instance->paramReplacement) )
		{
			instance->paramReplacement    = NULL;
			instance->paramReplacementPos = 0;
		}
		//if not - just copy the next Character from the buffer
		else
		{
			*next = instance->paramReplacement[instance->paramReplacementPos];
			instance->paramReplacementPos = instance->paramReplacementPos+1;

			return;
		}
	}

	//no parameter matches :D
	//just return a replacement character
	if ( instance->replacementPos == replacement->valueLength )
	{			//we are done with this replacement
		instance->replacement         = NULL;
		instance->replacementPos      = 0;
		instance->paramReplacement    = NULL;
		instance->paramReplacementPos = 0;
	}
	else
	{
		*next = value[instance->replacementPos];
		instance->replacementPos = instance->replacementPos+1;
	}
}

int substage_getNext(preproc *instance, Character *next)
{
	int result;
	int start_pos;
	int offset;
	int macro_length;
	DefineElementNode *node;
	ParameterElement *orig_param;
	ParameterElement *cpy_param;
	ParametersList replace_param;
	CharacterLine *line;
	Character chr;

	//load a possible replace character
	setReplacementCharacter(instance, next);

	while ( next->value == '\0' )
	{
		line = &instance->substage;

		//do we have to fetch a new line?
		if ( line->pos >= line->length )
		{
			result = getNextLine(instance, SUBSTAGE, &instance->substage);
			if ( result != 0 ) //error OR eof
				return result;
		}

		updateLineProperties(line);

		if ( line->skip==0 && line->posInString==0 )
		{

			node = Get_Front_Of_DefinesList(&instance->definesList);

			while ( node != NULL )
			{
				macro_length = CharacterLen(node->name);
				start_pos    = 0;
				offset      = 0;

				//see if the "environment" matches to do a replacement :D
				//this means: we have to look for the leading and trailing characters
				//because we cannot do replacement FOO in a string like FOOB
				//because FOOB could be a define itself... and so on
				if ( 
					isBufferPosMacroBegin(line->buffer, line->length, line->pos, &start_pos)==1 &&
					isBufferPosMacroEnd(line->buffer, line->length, start_pos+macro_length, &offset)==1 )
				{
					if ( CharacterSubCmp(line->buffer, start_pos, macro_length, node->name) == 0 )
					{
						//skip to AFTER the constant
						line->pos = offset;

						//just to make sure our offset does not exceed the line
						if ( line->pos > line->length )
							continue;

						//we obviously found something to replace...
						//see if it is a macro or "just" a define
						//we decide this by looking at the next character and our parameters list
						//since disposeWhitespace actually moves the line->pos
						//we have to rape offset here and use it as temporary storage
						//for line->pos which will be reset if we do not expect get any parameters!
						offset = line->pos;
						disposeWhitespace(line);

						chr = line->buffer[line->pos];
						if ( Is_ParametersList_Empty(&node->parameters) || chr.value!='(' )
						{
							//we do NOT expect a macro so put the offset back to position
							line->pos = offset;
						}
						else
						{
							//we got a macro definition!
							//read in the parameters and store them
							memset(&replace_param, 0, sizeof(ParametersList));
							result = parseParametersList(instance, &replace_param, line, 0);
							if ( result != 0 )
							{
								//what shall we do??
								preproc_reportError(instance, "Missformed macro (::parameters list::) call found", line, PREPROC_ERROR);
								exit(1);
							}

							//copy the parameter we got as replacement characters to the original parameters
							//we also compare if the parameters count matches
							orig_param = Get_Front_Of_ParametersList(&node->parameters);
							cpy_param  = Get_Front_Of_ParametersList(&replace_param);
							while ( orig_param!=NULL && cpy_param!=NULL )
							{
								memset(orig_param->replacement, 0, sizeof(Character)*PREPROC_MAX_PARAM_NAME_LENGTH);
								CharacterCpy(orig_param->replacement, cpy_param->name);

								orig_param = Get_Next_In_ParametersList(orig_param);
								cpy_param  = Get_Next_In_ParametersList(cpy_param);
							}

							//if not both lists are NULL the parameters count is wrong!
							if ( orig_param!=NULL || cpy_param!=NULL )
							{
								preproc_reportError(instance, "Missformed macro (::parameters count::) call found", line, PREPROC_ERROR);
								exit(1);
							}
							//everything went fine :D
						}
						
						//we are ready to replace
						//line->pos is already pointing to the position where to start AFTER the replacement!
						if ( node->valueLength > 0 )
						{
							instance->replacement = node;
							setReplacementCharacter(instance, next);
						}
					}
				}

				node = Get_Next_In_DefinesList(node);
			}
		}

		//if we still didn't get a value (i.e. through a first replaecement)
		if ( next->value=='\0' && line->pos<=line->length )
		{
			*next = line->buffer[line->pos];
			line->pos = line->pos+1;
		}
	}

	return 0;
}
