#include "../include/hrwcccomp.h"
#include "../include/error.h"

#include "preproc.h"
#include "stageutils.h"
#include "directiveutils.h"

//stage functions that only should be called in this file
int commstage_init(preproc *instance);
int commstage_destroy(preproc *instance);
int directivestage_init(preproc *instance);
int directivestage_destroy(preproc *instance);
int substage_init(preproc *instance);
int substage_destroy(preproc *instance);

int preproc_create(preproc *instance, char *filename)
{
    //init all preprocessing stages:
    fstack_init(instance);              //filestack

    commstage_init(instance);           //comment-stage
    substage_init(instance);            //substitution-stage
    directivestage_init(instance);      //directive-stage

    //push the filename onto the stack for that reading starts with this file
    return fstack_pushFile(instance, filename, 0);
}

void preproc_destroy(preproc *instance)
{
    //destroy all preprocessing stages:
    directivestage_destroy(instance);    //directive-stage
    substage_destroy(instance);          //substitution-stage
    commstage_destroy(instance);         //comment-stage

    fstack_destroy(instance);            //filestack
}

int preproc_getNext(preproc *instance, Character *next)
{
    //get char from previous stage
    return prevstage_getNext(instance, FINALSTAGE, next);
}

char *preproc_getFilename(preproc *instance, int id)
{
    return fstack_getFilename(instance, id);
}

int preproc_addDefine(preproc *instance, char *name)
{
	return directivestage_addDefine(instance, name);
}
