/*
 * Generic list data type
 * Copyright (c) 2001,2004 David H. Hovemeyer <daveho@cs.umd.edu>
 * $Revision: 1.16 $
 * 
 * This is free software.  You are permitted to use,
 * redistribute, and modify it as specified in the file "COPYING".
 */

#ifndef LIST_H
#define LIST_H

/*
 * Define a list type.
 */
#define DEFINE_LIST(listTypeName, nodeTypeName)		\
struct listTypeName {					\
    struct nodeTypeName *head, *tail;			\
}

/*
 * Define members of a  to be used as link fields for
 * membership in given list type.
 */
#define DEFINE_LINK(listTypeName, nodeTypeName) \
     nodeTypeName * prev##listTypeName, * next##listTypeName


#define PROTOTYPES_LIST(LType, NType) \
void Clear_##LType(LType *listPtr); \
int Is_Member_Of_##LType(LType *listPtr, NType *nodePtr); \
 NType * Get_Front_Of_##LType(LType *listPtr); \
 NType * Get_Back_Of_##LType(LType *listPtr); \
 NType * Get_Next_In_##LType(NType *nodePtr); \
void Set_Next_In_##LType(NType *nodePtr, NType *value); \
 NType * Get_Prev_In_##LType( NType *nodePtr); \
void Set_Prev_In_##LType( NType *nodePtr,  NType *value); \
void Add_To_Front_Of_##LType( LType *listPtr,  NType *nodePtr); \
void Add_To_Back_Of_##LType( LType *listPtr,  NType *nodePtr); \
void Add_To_##LType##_After( NType *nodePtr,  NType *nodePtrToAppend); \
void Append_##LType( LType *listToModify,  LType *listToAppend); \
 NType * Remove_From_Front_Of_##LType( LType *listPtr); \
void Remove_From_##LType( LType *listPtr,  NType *nodePtr); \
int Is_##LType##_Empty( LType *listPtr) 


/*
 * Define inline list manipulation and access functions.
 */
#define IMPLEMENT_LIST(LType, NType)								\
void Clear_##LType( LType *listPtr) {					\
    listPtr->head = listPtr->tail = 0;								\
}												\
int Is_Member_Of_##LType( LType *listPtr,  NType *nodePtr) {	\
     NType *cur = listPtr->head;								\
    while (cur != 0) {										\
	if (cur == nodePtr)									\
	    return 1;									\
	cur = cur->next##LType;									\
    }												\
    return 0;										\
}												\
 NType * Get_Front_Of_##LType( LType *listPtr) {			\
    return listPtr->head;									\
}												\
 NType * Get_Back_Of_##LType( LType *listPtr) {			\
    return listPtr->tail;									\
}												\
 NType * Get_Next_In_##LType( NType *nodePtr) {			\
    return nodePtr->next##LType;								\
}												\
void Set_Next_In_##LType( NType *nodePtr,  NType *value) {	\
    nodePtr->next##LType = value;								\
}												\
 NType * Get_Prev_In_##LType( NType *nodePtr) {			\
    return nodePtr->prev##LType;								\
}												\
void Set_Prev_In_##LType( NType *nodePtr,  NType *value) {	\
    nodePtr->prev##LType = value;								\
}												\
void Add_To_Front_Of_##LType( LType *listPtr,  NType *nodePtr) {	\
    assert(!Is_Member_Of_##LType(listPtr, nodePtr));						\
    nodePtr->prev##LType = 0;									\
    if (listPtr->head == 0) {									\
	listPtr->head = listPtr->tail = nodePtr;						\
	nodePtr->next##LType = 0;								\
    } else {											\
	listPtr->head->prev##LType = nodePtr;							\
	nodePtr->next##LType = listPtr->head;							\
	listPtr->head = nodePtr;								\
    }												\
}												\
void Add_To_Back_Of_##LType( LType *listPtr,  NType *nodePtr) {	\
    assert(!Is_Member_Of_##LType(listPtr, nodePtr));						\
    nodePtr->next##LType = 0;									\
    if (listPtr->tail == 0) {									\
	listPtr->head = listPtr->tail = nodePtr;						\
	nodePtr->prev##LType = 0;								\
    }												\
    else {											\
	listPtr->tail->next##LType = nodePtr;							\
	nodePtr->prev##LType = listPtr->tail;							\
	listPtr->tail = nodePtr;								\
    }												\
}												\
void Add_To_##LType##_After( NType *nodePtr,  NType *nodePtrToAppend) {\
    nodePtrToAppend->next##LType = nodePtr->next##LType;            \
    nodePtr->next##LType = nodePtrToAppend;                         \
}                                                \
void Append_##LType( LType *listToModify,  LType *listToAppend) {	\
    if (listToAppend->head != 0) {								\
	if (listToModify->head == 0) {								\
	    listToModify->head = listToAppend->head;						\
	    listToModify->tail = listToAppend->tail;						\
	} else {										\
	    assert(listToAppend->head != 0);							\
	    assert(listToModify->tail != 0);							\
	    listToAppend->head->prev##LType = listToModify->tail;				\
	    listToModify->tail->next##LType = listToAppend->head;				\
	    listToModify->tail = listToAppend->tail;						\
	}											\
    }												\
    listToAppend->head = listToAppend->tail = 0;						\
}												\
 NType * Remove_From_Front_Of_##LType( LType *listPtr) {		\
     NType *nodePtr;									\
    nodePtr = listPtr->head;									\
    assert(nodePtr != 0);									\
    listPtr->head = listPtr->head->next##LType;							\
    if (listPtr->head == 0)									\
	listPtr->tail = 0;									\
    else											\
	listPtr->head->prev##LType = 0;								\
    return nodePtr;										\
}												\
void Remove_From_##LType( LType *listPtr,  NType *nodePtr) {	\
    assert(Is_Member_Of_##LType(listPtr, nodePtr));						\
    if (nodePtr->prev##LType != 0)								\
	nodePtr->prev##LType->next##LType = nodePtr->next##LType;				\
    else											\
	listPtr->head = nodePtr->next##LType;							\
    if (nodePtr->next##LType != 0)								\
	nodePtr->next##LType->prev##LType = nodePtr->prev##LType;				\
    else											\
	listPtr->tail = nodePtr->prev##LType;							\
}												\
int Is_##LType##_Empty( LType *listPtr) {				\
    return listPtr->head == 0;									\
}

#endif  /* LIST_H */
