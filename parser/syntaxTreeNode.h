/**
 * This file implements the syntax tree node and list of nodes.
 */


#ifndef SYNTAXTREENODE_H
#define SYNTAXTREENODE_H


#include "../util/list.h"
#include "../scanner/token.h"

#ifndef __HRWCC__
struct syntaxTreeNode;
#endif




/**
 * A node of the linked list which is contained in a syntax-tree-node
 */
struct syntaxTreeNode_ListNode
{
		/** The syntax tree node which is carried by this list */
		syntaxTreeNode* child;

		/**The corresponding links for the linked list implementation*/
		DEFINE_LINK( syntaxTreeNode_List, syntaxTreeNode_ListNode);				
};


/**This macro defines the list of syntaxTreeNode_ListNode items*/
DEFINE_LIST( syntaxTreeNode_List, syntaxTreeNode_ListNode);			
PROTOTYPES_LIST( syntaxTreeNode_List, syntaxTreeNode_ListNode );


/**
 * This a node in the syntax tree
 */
struct syntaxTreeNode
{
		/**Linked list of children*/
		syntaxTreeNode_List children;

		/**In the case of a terminal node, this is the corresponding token*/
		token tok;
};




/**Create a syntax-tree-node*/
syntaxTreeNode* syntax_CreateTreeNode();
/**Add a child node to the parent node*/
void syntax_AddChildNode( syntaxTreeNode* parent, token childToken);
/**Add a child tree to the syntax tree*/
void syntax_AddChildTree( syntaxTreeNode* parent, syntaxTreeNode* child);
/**Get the number of childs of this node*/
int syntax_CountChilds( syntaxTreeNode* parent); 
/**Get child of node with specific index */
syntaxTreeNode* syntax_GetChild( syntaxTreeNode* parent, int idx);

/** Check if the syntax trees are equal in structure and tokens at leafs */
int syntax_EqualTrees( syntaxTreeNode* tree1, syntaxTreeNode* tree2);

/** Free a whole syntaxTree and its childs */
void syntax_FreeSyntaxTree( syntaxTreeNode* root );

/** Print a syntaxTree to console */
void syntax_printTree( syntaxTreeNode* root );

/** Copy whole tree */
syntaxTreeNode* syntax_CopyTree(syntaxTreeNode* root);



#endif
