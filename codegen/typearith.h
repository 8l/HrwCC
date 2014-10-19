/**
 * This is a list of helper functions to cope with types
 */


#ifndef TYPEARITH_H
#define TYPEARITH_H


#include "codegen.h"

#include "../parser/syntaxTreeNode.h"
#include "../symbolTable/symbolTable.h"


/** Get type of array element */
syntaxTreeNode* type_CreateArrayElmType( syntaxTreeNode* varDef);

/** Get the size of elements of arrays (declared by arrays or pointers) */
int type_GetArrayElmSize( symbolTable* symtab, syntaxTreeNode* varDef);

int type_IsAPointerVar( syntaxTreeNode* varDef );
int type_IsAArrayVar( syntaxTreeNode* varDef );
int type_IsAStructVar( syntaxTreeNode* varDef );

int type_IsAPointerType( syntaxTreeNode* type);
int type_IsAIntType( syntaxTreeNode* type);
int type_IsACharType( syntaxTreeNode* type);
int type_IsAStructType( syntaxTreeNode* type);

int type_IsLongSized( syntaxTreeNode* type);
int type_IsByteSized( syntaxTreeNode* type);

syntaxTreeNode* type_AddStarToType( syntaxTreeNode* type);
syntaxTreeNode* type_RemoveStarFromType( syntaxTreeNode* type);

syntaxTreeNode* type_CreateType( syntaxTreeNode* varDef );

/** Calculates the offset of a member in a containing variable */
int type_GetMemberOffset( symbolTable* symtab, syntaxTreeNode* contType, token member );
/** Get the member declaration in containing variable */
syntaxTreeNode* type_GetMemberDeclaration( symbolTable* symtab, syntaxTreeNode* contType, token member);

/** Count the resolutions in variable expression */
int type_CountVarexprResolutions( syntaxTreeNode* tree);

/** Convert singlechar like "\n" to 0xd or so */
int type_ConvertSinglechar(char* sngchar);

#endif

