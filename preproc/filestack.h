#ifndef FILESTACK_H
#define FILESTACK_H

	#include "stageutils.h"

    /**
     * instantiate the filestack of the passed preproc instance
     */
    int fstack_init(preproc *instance);

    /**
     * destroy the filestack of the passed preproc instance
     */
    int fstack_destroy(preproc *instance);

    /**
     * add a new file to the filestack
     * if is_system_include is 1 the file to include will be searched
     * in the system include path... /usr/include etc.
     * returns 0 if successful
     * returns <0 if
     *    - file is already on stack
     *    - file could not be opened
     */
    int fstack_pushFile(preproc *instance, char *filename, int is_system_include);
    
    /**
     * get next character of the stream
     * returns  0 if successful
     *         <0 in case of error
     */
    int fstack_getNext(preproc *instance, Character *next);

    /**
     * sets *filename to the location of the filename corresponding to id
     * returns  0 if successful
     * returns <0 if an error occured
     */
    char *fstack_getFilename(preproc *instance, int id);

#endif
