/**
 * Implements the syntax tree node and list
 */


#include "syntaxTreeNode.h"

#include "../include/hrwcccomp.h"



/**This macro implements the functions of the list of syntaxTreeNode_ListNode items*/
IMPLEMENT_LIST( syntaxTreeNode_List, syntaxTreeNode_ListNode)

/**Create a syntax-tree-node*/
syntaxTreeNode* syntax_CreateTreeNode()
{
		//Create a tree node pointer
		syntaxTreeNode* treeNode;

		//Get mem for the treenode
#ifndef __HRWCC__
		treeNode = (syntaxTreeNode*) malloc( sizeof(syntaxTreeNode) );
#else
		treeNode = malloc( sizeof(syntaxTreeNode));
#endif

		//No mem available!
		if( treeNode == 0)
		{
			printf("Not enough memory to create syntaxTreeNode (%p)\n", treeNode );
			exit(-1);
		}

		//Initialize list
		Clear_syntaxTreeNode_List( &treeNode->children );
		treeNode->tok.type = 0;
		strcpy( treeNode->tok.content, "");

		//Return the initialized node
		return treeNode;
}

/**Add a child node to the parent node*/
void syntax_AddChildNode( syntaxTreeNode* parent, token childToken)
{
		syntaxTreeNode* treeNode;

		//Create tree node and list-node
		treeNode = syntax_CreateTreeNode();
		treeNode->tok = childToken;

		//Add this token/node to the children list
		syntax_AddChildTree( parent, treeNode);
}

/**Add a child tree to the syntax tree*/
void syntax_AddChildTree( syntaxTreeNode* parent, syntaxTreeNode* child)
{
		syntaxTreeNode_ListNode* listNode;

		//Create list-node
#ifndef __HRWCC__
		listNode = (syntaxTreeNode_ListNode*) malloc( sizeof(syntaxTreeNode_ListNode) );
#else
		listNode = malloc( sizeof(syntaxTreeNode_ListNode) );
#endif

		if( listNode == 0)
		{
			printf("Not enough memory to create syntaxTreeNode_ListNode (%p)\n", listNode );
			exit(-1);
		}

		//Save the treenode in the list node
		listNode->child = child;

		//Add this token/node to the children list
		Add_To_Back_Of_syntaxTreeNode_List( &parent->children, listNode);
}

/**Get the number of childs of this node*/
int syntax_CountChilds( syntaxTreeNode* parent)
{
		int cnt;
		syntaxTreeNode_ListNode* node;

		//No children
		if( parent == 0 ) 
			return 0;

		//Get the first element of children list...
		node = Get_Front_Of_syntaxTreeNode_List(&parent->children);
		cnt = 0;

		//...and run through the children
		while( node != 0)
		{
				//Goto next node
				node = Get_Next_In_syntaxTreeNode_List( node);
				cnt = cnt+1;
		}

		return cnt;
}


/**Get child of node with specific index */
syntaxTreeNode* syntax_GetChild( syntaxTreeNode* parent, int idx)
{		
		int cnt;
		syntaxTreeNode_ListNode* node;

		//Get the first element of children list...
		node = Get_Front_Of_syntaxTreeNode_List(&parent->children);
		cnt = 0;

		//...and run through the children
		while( cnt < idx )
		{
				//Goto next node
				node = Get_Next_In_syntaxTreeNode_List( node);
				cnt = cnt+1;
		}

		return node->child;
}


/** Check if the syntax trees are equal in structure and tokens at leafs */
int syntax_EqualTrees( syntaxTreeNode* tree1, syntaxTreeNode* tree2)
{
		int idx;
		int cntchilds1;
		int cntchilds2;
		syntaxTreeNode* child1;
		syntaxTreeNode* child2;

		//Count children of both trees
		cntchilds1 = syntax_CountChilds(tree1);
		cntchilds2 = syntax_CountChilds(tree2);


		//Check for equal children count
		if( cntchilds1 != cntchilds2)
			return 0;

		//Check for equal tokens
		if( tree1->tok.type != tree2->tok.type )
			return 0;

		//Check for equal tokens
		if( strcmp( tree1->tok.content, tree2->tok.content ) != 0)
			return 0;



		idx = 0;

		//Check recursively for childrens...
		while( idx < cntchilds1 )
		{
				child1 = syntax_GetChild(tree1, idx);
				child2 = syntax_GetChild(tree2, idx);

				//Test children
				if( !syntax_EqualTrees(child1, child2) )
					return 0;

				idx = idx+1;
		}


		return 1;
}


/** Free a whole syntaxTree and its childs */
void syntax_FreeSyntaxTree( syntaxTreeNode* root )
{
		int cntChilds;
		int idx;
		syntaxTreeNode_ListNode* node;
		syntaxTreeNode_ListNode* next;

		//Nothing to do
		if( root == 0 )
			return;

		cntChilds = syntax_CountChilds( root );
		idx = 0;

		//Free all childs
		while( idx < cntChilds )
		{
			syntax_FreeSyntaxTree( syntax_GetChild(root, idx) );
			idx = idx+1;
		}


		//Clear nodes itself
		node = Get_Front_Of_syntaxTreeNode_List( &root->children );

		while( node != 0 )
		{
				next = Get_Next_In_syntaxTreeNode_List( node );
				free(node);
				node = next;
		}

		//Clear child list
		Clear_syntaxTreeNode_List(&root->children);
		//Free node itself
		free( root );
}


/** Print a syntaxTree to console */
void syntax_printTreePre( syntaxTreeNode* root, char* prefix )
{	
		char npref[200];
		int oldprefixlen;
		int cntchilds;
		int idx;
	
		
		if( root == 0)
		{
			puts("NULL");
			return;
		}

	
		oldprefixlen = strlen(prefix);
		memcpy(npref, prefix, 200);

		cntchilds = syntax_CountChilds(root);

		
		if( cntchilds == 0 )
		{
				printf("%s", prefix);
				printf("- == %d", root->tok.type);
				printf(": %s\n", root->tok.content);
		}
		else
		{				
				printf("%s-+\n", prefix);
				npref[oldprefixlen] = ' ';
				npref[oldprefixlen+1] = '|';

				idx = 0;
				while( idx < cntchilds )
				{
						syntax_printTreePre( syntax_GetChild(root, idx), npref);
						idx = idx + 1;
				}

		}

}


/** Print a syntaxTree to console */
void syntax_printTree( syntaxTreeNode* root )
{
		char prefix[200];
		memset(prefix, 0, 200);

		
		syntax_printTreePre( root, prefix);
}


/** Copy whole tree */
syntaxTreeNode* syntax_CopyTree(syntaxTreeNode* root)
{
		syntaxTreeNode* cpy;
		int idx;
		int cnt;

		if( root == 0 )
			return 0;

		//Create new node
		cpy = syntax_CreateTreeNode();
		//And copy token
		cpy->tok = root->tok;


		idx = 0;
		cnt = syntax_CountChilds(root);

		//Copy all childs
		while( idx < cnt )
		{
				syntax_AddChildTree(cpy, syntax_CopyTree(syntax_GetChild(root,idx)));
				idx = idx+1;
		}


		return cpy;
}


