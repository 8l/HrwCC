
#include "typearith.h"

#include "../include/hrwcccomp.h"




/** Create type of array element of variable. */
syntaxTreeNode* type_CreateArrayElmType( syntaxTreeNode* varDef)
{
		if( type_IsAPointerVar(varDef) )
			return type_RemoveStarFromType( syntax_GetChild(syntax_GetChild(varDef,0),0));

		if( type_IsAArrayVar(varDef) )
			return type_CreateType( varDef);

		return 0;
}


/** Determine the size of an array element by the definition of the variable */
int type_GetArrayElmSize( symbolTable* symtab, syntaxTreeNode* varDef)
{
		syntaxTreeNode* newtype;
		int size;


		//Create type of array element
		newtype = type_CreateArrayElmType (varDef);

		// Error occured
		if( newtype == 0)
			return -1;

		//Determine new size and remove type
		size = symbol_Sizeof_DataType( symtab, newtype);
		syntax_FreeSyntaxTree(newtype);
		
		return size;
}


/** Check if variable is a pointer */
int type_IsAPointerVar( syntaxTreeNode* varDef )
{
		//Array is not a pointer
		if( type_IsAArrayVar(varDef) )
			return 0;

		//Get just the data-type
		varDef = syntax_GetChild( syntax_GetChild(varDef, 0), 0);

		//At least a star
		if( syntax_CountChilds(varDef) > 1 )
			return 1;

		return 0;
}

/** Check if variable is a array */
int type_IsAArrayVar( syntaxTreeNode* varDef )
{
		// <typed_ident> [ <number ] ;
		if( syntax_CountChilds(varDef) == 5 )
			return 1;

		return 0;
}

/** Check if variable is a struct-instance */
int type_IsAStructVar( syntaxTreeNode* varDef )
{
		syntaxTreeNode* subtree;

		//Arrays are not structs
		if( type_IsAArrayVar(varDef) )
			return 0;


		//No definition
		if( varDef == 0)
			return 0;


		//Get just the data-type
		varDef = syntax_GetChild( syntax_GetChild(varDef, 0), 0);

		//Pointer or non-struct typed
		if( syntax_CountChilds(varDef) > 1)
			return 0;

		//Aha, struct name at front
		subtree = syntax_GetChild(varDef,0);
		if( subtree->tok.type == TOK_IDENT)
			return 1;
		

		return 0;
}



int type_IsAPointerType( syntaxTreeNode* type)
{
		if( type == 0)
			return 0;

		if( syntax_CountChilds(type) > 1)
			return 1;

		return 0;
}

int type_IsAIntType( syntaxTreeNode* type)
{
		syntaxTreeNode* subtree;

		if( type_IsAPointerType(type) )
			return 0;

		subtree = syntax_GetChild(type,0);
		if( subtree->tok.type == TOK_INT)
			return 1;

		return 0;
}

int type_IsACharType( syntaxTreeNode* type)
{
		syntaxTreeNode* subtree;

		if( type_IsAPointerType(type) )
			return 0;

		subtree = syntax_GetChild(type,0);
		if( subtree->tok.type == TOK_CHAR)
			return 1;

		return 0;
}

int type_IsAStructType( syntaxTreeNode* type)
{
		syntaxTreeNode* subtree;


		//No type
		if( type == 0)
			return 0;

		if( type_IsAPointerType(type) )
			return 0;

		subtree = syntax_GetChild(type,0);
		if( subtree->tok.type == TOK_IDENT)
			return 1;

		return 0;
}


int type_IsLongSized( syntaxTreeNode* type)
{
		if( type == 0 ||
			type_IsAPointerType(type) ||
			type_IsAIntType(type) )
			return 1;

		return 0;
}


int type_IsByteSized( syntaxTreeNode* type)
{
		if( type == 0 ||
			type_IsACharType(type) )
			return 1;

		return 0;
}


syntaxTreeNode* type_RemoveStarFromType( syntaxTreeNode* type)
{
		syntaxTreeNode* newtype;
		int idx;
		int cnt;

		//Cannot remove a star!
		if( ! type_IsAPointerType(type) )
			return 0;

		//Create container for new-type and cut of last star...
		newtype = syntax_CreateTreeNode();
		idx = 0;
		cnt = syntax_CountChilds(type) - 1;

		//Add the tokens...
		while( idx < cnt)
		{
				syntax_AddChildTree(newtype, syntax_CopyTree(syntax_GetChild(type,idx)));
				idx = idx+1;
		}

		//This is the new type
		return newtype;

}

syntaxTreeNode* type_AddStarToType( syntaxTreeNode* type)
{
		syntaxTreeNode* newtype;
		int idx;
		int cnt;
		token star;

		//Create container for new-type and cut of last star...
		newtype = syntax_CreateTreeNode();
		idx = 0;
		cnt = syntax_CountChilds(type);

		//Add the tokens...
		while( idx < cnt)
		{
				syntax_AddChildTree(newtype, syntax_CopyTree(syntax_GetChild(type,idx)));
				idx = idx+1;
		}

		//Create additional star
		strcpy(star.content, "*");
		star.type = TOK_STAR;
		syntax_AddChildNode(newtype, star);

		//This is the new type
		return newtype;

}


/** Get the data-type of a variable */
syntaxTreeNode* type_CreateType( syntaxTreeNode* varDef )
{
		syntaxTreeNode* newtype;
		int idx;
		int cnt;


		//Get just the data-type
		varDef = syntax_GetChild( syntax_GetChild(varDef, 0), 0);

		
		//Create container for new-type
		newtype = syntax_CreateTreeNode();
		idx = 0;
		cnt = syntax_CountChilds(varDef) ;

		//Add the tokens...
		while( idx < cnt)
		{
				syntax_AddChildTree(newtype, syntax_CopyTree(syntax_GetChild(varDef,idx)));
				idx = idx+1;
		}

		//This is the new type
		return newtype;
}


/** Calculates the offset of a member in a containing type */
int type_GetMemberOffset( symbolTable* symtab, syntaxTreeNode* contType, token member )
{
		symbolTableNode* structNode;


		//Get to struct-ident directly
		contType = syntax_GetChild(contType, 0);
		//And search for struct
		structNode = symbol_FindStruct(symtab, contType->tok);

		//No such struct!
		if( structNode == 0)
			return -1;

		//Calc offset in struct
		return symbol_GetOffsetInStruct(symtab, structNode, member);
}


/** Get the member declaration in containing type */
syntaxTreeNode* type_GetMemberDeclaration( symbolTable* symtab, syntaxTreeNode* contType, token member)
{
		symbolTableNode* structNode;

		//Get to struct-ident directly
		contType = syntax_GetChild(contType, 0);
		//And search for struct
		structNode = symbol_FindStruct(symtab, contType->tok);

		//No such struct!
		if( structNode == 0)
			return 0;

		//Calc offset in struct
		return symbol_GetMemberDeclInStruct(symtab, structNode, member);
}


/** Count the resolutions in variable expression */
int type_CountVarexprResolutions( syntaxTreeNode* tree)
{
		int cntresol;
		syntaxTreeNode* subtree;

		//Count children
		cntresol = syntax_CountChilds(tree);


		//Remove index specifier
		subtree = syntax_GetChild(tree,cntresol-1);

		if( subtree->tok.type == TOK_RECPAR_END)
			cntresol = cntresol - 3;


		//Remove deref or addr operator
		subtree = syntax_GetChild(tree,0);

		if( subtree->tok.type == TOK_STAR ||
			subtree->tok.type == TOK_AND )
			cntresol = cntresol - 1;

		return (cntresol+1)/2;
}


/** Convert singlechar like "'\n'" to 0xd or so */
int type_ConvertSinglechar(char* sngchar)
{
		char first;
		char second;

		first = sngchar[1];

		//Esc-sequence
		if( first == '\\' )
		{
				second = sngchar[2];

				if( second == 'n' )
					return 10;

				if( second == 'r' )
					return 13;

				if( second == 't' )
					return 9;

				if( second == '\\' )
					return 92;

				if( second == 'b' )
					return 8;

				if( second == '\'' )
					return 39;

				if( second == '\"' )
					return 34;

				if( second == '0' )
					return 0;

				//Unknown esc-sequence --> give back second one
				return second;
		}

		//So just return first
		return first;
}



