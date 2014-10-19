#include "../include/hrwcccomp.h"
#include "../include/error.h"

#include "preproc.h"
#include "stageutils.h"

int commstage_init(preproc *instance)
{
	initLine(&instance->commstage);

	return 0;
}

int commstage_destroy(preproc *instance)
{
	return 0;
}

int commstage_getNext(preproc *instance, Character *next)
{
	int  result;
	Character c1;
	Character c2;
	CharacterLine *line;

	next->value = '\0';
	while ( next->value == '\0' )
	{	
		line = &instance->commstage;

		//we have to fetch a new line if we are currently at the end of the current
		if ( line->pos == line->length )
		{
			result = getNextLine(instance, COMMSTAGE, &instance->commstage);
			if ( result != 0 ) //error OR eof
				return result;
		}

		//update properties like escaped and in string etc
		updateLineProperties(&instance->commstage);

		if ( line->posInString == 0 )
		{
			//look at the pos+1 characters and see if we found one of our patterns
			c1 = line->buffer[line->pos];
			c2 = line->buffer[line->pos+1];
			
			//we check if c1 and c2 form a comment pattern we are looking for
			//either "//" or "/*"
			if ( c1.value=='/' && c2.value=='/' )
			{
				//we got a "//" so just
				//get rid of rest of line (\n will be returned...):
				line->pos = line->length-1;
			}
			else if ( c1.value=='/' && c2.value=='*' )
			{
				//we have to loop through the lines until we find */
				line->pos = line->pos+1;

				while ( line->pos < line->length )
				{
					//get the current and the next char
					//to see if we got an ending "*/" sequence
					c1 = line->buffer[line->pos];
					c2 = line->buffer[line->pos+1];

					if ( c1.value=='*' && c2.value=='/' )
					{
						//skip c1 and c2
						line->pos = line->pos+2;
						break;
					}

					//move one character further
					line->pos = line->pos+1;

					//if we did not find the ending "*/" till the end
					//of the current line we have to fetch a new one
					if ( line->pos == line->length )
					{
						result = getNextLine(instance, COMMSTAGE, &instance->commstage);
						if ( result != 0 ) //error OR eof
							return result;
					}
				}
			}
		}

		*next = line->buffer[line->pos];
		line->pos = line->pos+1;
	}

	return 0;
}
