#include "../include/hrwcccomp.h"
#include "../include/error.h"

#include "preproc.h"
#include "filestack.h"

//implement the list functions
IMPLEMENT_LIST(FilenamesList, FilenameNode)

//this function will have to be extended
//to read in the system settings (getenv())
void getSystemIncludePaths(char *result)
{
    strcpy(result, "../include");
}

int fstack_init(preproc *instance)
{
    //set the currentFileIdxer to -1
    //so it should always be possible to read with "currentFileIdx" from the stack
    instance->currentFileIdx = -1;
    
    //don't forget to initialite the filenames list :D
    Clear_FilenamesList(&instance->filenames);

    return 0;
}

int fstack_destroy(preproc *instance)
{
    FilenameNode *curr_node;
    FilenameNode *next_node;
    FileStackItem curr_item;

    //free the filename curr_nodes
    if ( !Is_FilenamesList_Empty(&instance->filenames) )
    {
        curr_node = Get_Front_Of_FilenamesList(&instance->filenames);

        //free every curr_node element
        while ( curr_node != NULL )
        {
            next_node = Get_Next_In_FilenamesList(curr_node);

            //free the curr_node (allocated too)
            free(curr_node);
            
            curr_node = next_node;
        }
    }

    //clear the list
    Clear_FilenamesList(&instance->filenames);

    //close open files
    while ( instance->currentFileIdx >= 0 )
    {
    	curr_item = instance->filestack[instance->currentFileIdx];
        if ( curr_item.fh != -1 )
        {
            close(curr_item.fh);
            memset(&curr_item, 0, sizeof(FileStackItem));
        }

        instance->currentFileIdx = instance->currentFileIdx-1;
    }
    
    //set currentFileIdxer to the start value
    instance->currentFileIdx = -1;

    return 0;
}

/**
 * adds the passed filename
 * to the instances filenamesList
 */
int addNewFilenameNode(preproc *instance, char *filename)
{
    FilenameNode *new_node;
    FilenameNode *curr_node;
    FileStackItem *curr_item;

    //allocate memory for our new curr_node
#ifndef __HRWCC__
    new_node = (FilenameNode*)malloc(sizeof(FilenameNode));
#else
    new_node = malloc(sizeof(FilenameNode));
#endif
    if ( new_node == NULL )
    {
    	preproc_reportError_s(instance, "Could not allocate new memory", NULL, PREPROC_ERROR);
        return ERR_PREPROC_MEM;
    }

	//Reset memory
	memset(new_node, 0, sizeof(FilenameNode));

    //add the filename to the filenames list
    new_node->id = -1;

    //find id of the last element in list
    curr_node = Get_Front_Of_FilenamesList(&instance->filenames);
    while ( curr_node != NULL )
    {
        new_node->id  = curr_node->id;
        curr_node = Get_Next_In_FilenamesList(curr_node);
    }
    
    //just increment the index and we got our new level
    new_node->id = new_node->id+1;

    //assign the id to the current level of the filestack!
    curr_item         = &instance->filestack[instance->currentFileIdx];
    curr_item->fileId = new_node->id;

    //finally: copy over the filename
    memset(new_node->name, 0, sizeof(char)*MAX_FILENAME_LENGTH);
    strncpy(new_node->name, filename, MAX_FILENAME_LENGTH);	

    //and add curr_node to end of list
    Add_To_Back_Of_FilenamesList(&instance->filenames, new_node);

    return 0;
}

/**
 * checks if the passed filename
 * is already on the stack
 * returns 1 if the filename is found on the stack 0 otherwise
 */
int isFileAlreadyOnStack(preproc *instance, char *filename)
{
    int idx;
    char *curr_filename;
    FileStackItem curr_item;

    idx = 0;
    while ( idx <= instance->currentFileIdx )
    {
    	curr_item     = instance->filestack[idx];
        curr_filename = fstack_getFilename(instance, curr_item.fileId);
        if ( strcmp(curr_filename, filename) == 0 )
        {
            //printf("not including [%s] - already on stack\n");
            return 1;
        }
        
        idx = idx+1;
    }

    return 0;
}

/**
 * trys to find "filename" in the defined system paths
 * and passes the full valid path (including the filename)
 * in "path" (which is expected to be MAX_FILENAME_LENGTH in size)
 * returns 0 if successful and !=0 otherwise
 */
int getAbsoluteIncludePath(preproc *instance, char *filename, char *path)
{
    int idx;
    int path_idx;
    int paths_length;
    int fh;
    int include_found;
    char include_paths[MAX_FILENAME_LENGTH];


    memset(include_paths, 0, MAX_FILENAME_LENGTH);
    memset(path, 0, MAX_FILENAME_LENGTH);

    //search in system paths
    //we get a : separated list
    getSystemIncludePaths(include_paths);

    idx           = 0;
    path_idx      = 0;
    include_found = 0;
    paths_length      = strlen(include_paths);
    while ( path_idx < paths_length )
    {
        //find a colon which acts as a path seperator
        if ( include_paths[path_idx] != ':' )
        {
            path[idx] = include_paths[path_idx];
            path_idx  = path_idx+1;
            idx       = idx+1;
            continue;
        }

        //skip the colon in the list
        path_idx = path_idx+1;

        //the list could start with a colon
        //so make sure we really got an include path in our path
        if ( idx > 1 )
        {
            //append a slash
            path[idx] = '/';
            idx       = idx+1;

            //boundary checking...
            if ( idx+strlen(filename) >= MAX_FILENAME_LENGTH )
            {
            	preproc_reportError_s(instance, "Found filename [%s] exceeds MAX_FILENAME_LENGTH", filename, PREPROC_WARNING);
                return WARN_PREPROC_FILENAME_TOO_LONG;
            }

            //append filename
            strcat(path, filename);

            //we accept the file if it exists
            fh = open(path, O_RDONLY, 0);
            if ( fh != -1 )
            {
                //it exists - so close the filehandle
                close(fh);
                include_found = 1;
                break;
            }

            //the file did not exist so clear the buffer
            //and start over from the next path
            memset(path, 0, MAX_FILENAME_LENGTH);
            idx = 0;
        }
    }

    //what is if we didn't find a valid file?	
    if ( include_found == 0 )
    {
       	preproc_reportError_s(instance, "Could not find system-include for [%s]", filename, PREPROC_WARNING);
        return WARN_PREPROC_FOPEN;
    }

    return 0;
}

int fstack_pushFile(preproc *instance, char *filename, int is_system_include)
{
    int fh;
    int result;
    int path_length;

    char file[MAX_FILENAME_LENGTH];
    char *tmp_filename;
    FileStackItem *curr_item;

    memset(file, 0, MAX_FILENAME_LENGTH);

    //get the correct path!
    //this is either an absolute path to some "system include" directory
    //or maybe the path of the parent file on the stack
    if ( is_system_include == 1 )
    {
        result = getAbsoluteIncludePath(instance, filename, file);
        if ( result != 0 )
			return result;
    }
    else
    {
        //search in the parents include file (if exists) directory
		//and put the path of it before the actual filename

        //if we are not the toplevel file - so we have to get the path of parent (means idx-1)
        if ( instance->currentFileIdx != -1 )
        {
            //copy everything till the last slash to the filename buffer
            //and then append the filename

            //find position of last slash:
            curr_item    = &instance->filestack[instance->currentFileIdx];
            tmp_filename = fstack_getFilename(instance, curr_item->fileId);
            path_length  = strlen(tmp_filename)-1;
            while ( path_length>=0 && tmp_filename[path_length]!='/')
				path_length = path_length-1;

            //we also need the slash:
            path_length = path_length+1;

            strncpy(file, tmp_filename, path_length);

            if ( path_length+strlen(filename) >= MAX_FILENAME_LENGTH )
            {
            	preproc_reportError_s(instance, "Found filename [%s] exceeds MAX_FILENAME_LENGTH", filename, PREPROC_WARNING);
                return WARN_PREPROC_FILENAME_TOO_LONG;
            }

            //now append the filename:
            strcat(file, filename);
        }
        else
        {
            if ( strlen(filename) >= MAX_FILENAME_LENGTH )
            {
            	preproc_reportError_s(instance, "Found filename [%s] exceeds MAX_FILENAME_LENGTH", filename, PREPROC_WARNING);
                return WARN_PREPROC_FILENAME_TOO_LONG;
            }

            memcpy(file, filename, MAX_FILENAME_LENGTH);
        }
    }

//printf("including: [%s]\n", file);
    //we have to make sure the file is not already on the stack (circular includes...)
    if ( isFileAlreadyOnStack(instance, filename) == 1 )
            return 0; //we silently ignore this (does not necessarily indicate an error)

    //make sure we don't exhaust the stack with this push
    if ( instance->currentFileIdx+1 == PREPROC_MAX_INCLUDE_FILES )
    {
        preproc_reportError_s(instance, "Filestack exceeded", NULL, PREPROC_ERROR);
        return ERR_PREPROC_FILESTACK_EXCEEDED;
    }

    fh = open(file, O_RDONLY, 0);
    if ( fh == -1 )
    {
    	preproc_reportError_s(instance, "Could not include [%s]", file, PREPROC_WARNING);
        return WARN_PREPROC_FOPEN;
    }

    //use the next level in the file stack
    instance->currentFileIdx = instance->currentFileIdx+1;

    //initialize the new stack level
    curr_item         = &instance->filestack[instance->currentFileIdx];
    curr_item->fh     = fh;
    curr_item->line   = 1;
    curr_item->column = 0;
    memset(&curr_item->prev, 0, sizeof(Character));

    return addNewFilenameNode(instance, file);
}

int fstack_getNext(preproc *instance, Character *next)
{
    int result;
    FileStackItem *curr_stack_item;

    curr_stack_item = &instance->filestack[instance->currentFileIdx];

    //read next character from the top fh
    if ( instance->currentFileIdx>=0 && curr_stack_item->fh==-1 )
            return ERR_PREPROC_NOOP;

    //just reset because we check later
    next->value = '\0';
    result      = 0;
    while ( next->value=='\0' && instance->currentFileIdx>=0 )
    {
        result = read(curr_stack_item->fh, &next->value, sizeof(char));

        //if we read something we are happy and break
        if ( result > 0 )
            break;

        //if nothing was read we expect to be at the end of the current file
        //close the open file handle
        close(curr_stack_item->fh);
        curr_stack_item->fh = -1;

        //if the file did not end with a newline print a warning and append a newline here!
        //otherwise there could be some mixups till the preprocessor reads everything linewise
        if ( curr_stack_item->prev.value != '\n' )
        {
            next->value = '\n';
            result = 1;
            preproc_reportError_s(instance, "No newline at end of file [%s]", fstack_getFilename(instance, curr_stack_item->fileId), PREPROC_WARNING);
        }

        //set the stack entry to zero
        memset(curr_stack_item, 0, sizeof(FileStackItem));

        //decrement the currentFileIdx for the file will be read later
        instance->currentFileIdx = instance->currentFileIdx-1;

		//This if has been added by shuber.
		//Please check if there are similar situations in code...
		if( instance->currentFileIdx < 0 )
			break;

        //don't forget to update curr_stack_item - the "position" updater depends on it
        curr_stack_item = &instance->filestack[instance->currentFileIdx];
    }

    //if we did not get a result and no more items on the stack left
    if ( result==0 && instance->currentFileIdx==-1 )
        return PREPROC_EOF;

    //update column and line (if we got a newline symbol)
    curr_stack_item->column = curr_stack_item->column+1;
    if ( next->value == '\n' )
    {
        //newline. increase line counter and reset column
        curr_stack_item->line   = curr_stack_item->line+1;
        curr_stack_item->column = 0;
    }

    //set those values in our result Character
    next->fileId = curr_stack_item->fileId;
    next->line   = curr_stack_item->line;
    next->column = curr_stack_item->column;

    //we need the "previous" character to see if we got
    //a newline at the end of every file
    memcpy(&curr_stack_item->prev, next, sizeof(Character));

    return 0;
}

char *fstack_getFilename(preproc *instance, int id)
{
    FilenameNode *node;

    //just loop through the filenames list
    //and see if we get a match
    node = Get_Front_Of_FilenamesList(&instance->filenames);
    while ( node != NULL )
    {
        if ( node->id == id )
            return node->name;

        node = Get_Next_In_FilenamesList(node);
    }

    return NULL;
}
