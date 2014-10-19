
.section	.text

.globl	Clear_syntaxTreeNode_List
.type	Clear_syntaxTreeNode_List,@function
Clear_syntaxTreeNode_List	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)
Clear_syntaxTreeNode_List_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Is_Member_Of_syntaxTreeNode_List
.type	Is_Member_Of_syntaxTreeNode_List,@function
Is_Member_Of_syntaxTreeNode_List	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$4,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	movl	%eax,-4(%ebp)

Is_Member_Of_syntaxTreeNode_List_while_0	:	
	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	Is_Member_Of_syntaxTreeNode_List_reltrue_1
	movl	$0,%eax
Is_Member_Of_syntaxTreeNode_List_reltrue_1	:	
	testl	%eax,%eax
	jz	Is_Member_Of_syntaxTreeNode_List_endwhile_0

	movl	-4(%ebp),%ebx
	cmpl	12(%ebp),%ebx
	movl	$1,%eax
	je	Is_Member_Of_syntaxTreeNode_List_reltrue_3
	movl	$0,%eax
Is_Member_Of_syntaxTreeNode_List_reltrue_3	:	
	testl	%eax,%eax
	jnz	Is_Member_Of_syntaxTreeNode_List_ifbl_2
	jmp	Is_Member_Of_syntaxTreeNode_List_elsebl_2
Is_Member_Of_syntaxTreeNode_List_ifbl_2	:	

	movl	$1,%eax
	jmp	Is_Member_Of_syntaxTreeNode_List_ret
Is_Member_Of_syntaxTreeNode_List_elsebl_2	:	
Is_Member_Of_syntaxTreeNode_List_endif_2	:	

	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	movl	(%eax),%eax
	movl	%eax,-4(%ebp)
	jmp	Is_Member_Of_syntaxTreeNode_List_while_0
Is_Member_Of_syntaxTreeNode_List_endwhile_0	:	

	movl	$0,%eax
	jmp	Is_Member_Of_syntaxTreeNode_List_ret
Is_Member_Of_syntaxTreeNode_List_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Get_Front_Of_syntaxTreeNode_List
.type	Get_Front_Of_syntaxTreeNode_List,@function
Get_Front_Of_syntaxTreeNode_List	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	jmp	Get_Front_Of_syntaxTreeNode_List_ret
Get_Front_Of_syntaxTreeNode_List_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Get_Back_Of_syntaxTreeNode_List
.type	Get_Back_Of_syntaxTreeNode_List,@function
Get_Back_Of_syntaxTreeNode_List	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	(%eax),%eax
	jmp	Get_Back_Of_syntaxTreeNode_List_ret
Get_Back_Of_syntaxTreeNode_List_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Get_Next_In_syntaxTreeNode_List
.type	Get_Next_In_syntaxTreeNode_List,@function
Get_Next_In_syntaxTreeNode_List	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	movl	(%eax),%eax
	jmp	Get_Next_In_syntaxTreeNode_List_ret
Get_Next_In_syntaxTreeNode_List_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Set_Next_In_syntaxTreeNode_List
.type	Set_Next_In_syntaxTreeNode_List,@function
Set_Next_In_syntaxTreeNode_List	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	pushl	%eax
	movl	12(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)
Set_Next_In_syntaxTreeNode_List_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Get_Prev_In_syntaxTreeNode_List
.type	Get_Prev_In_syntaxTreeNode_List,@function
Get_Prev_In_syntaxTreeNode_List	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	(%eax),%eax
	jmp	Get_Prev_In_syntaxTreeNode_List_ret
Get_Prev_In_syntaxTreeNode_List_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Set_Prev_In_syntaxTreeNode_List
.type	Set_Prev_In_syntaxTreeNode_List,@function
Set_Prev_In_syntaxTreeNode_List	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	pushl	%eax
	movl	12(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)
Set_Prev_In_syntaxTreeNode_List_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Add_To_Front_Of_syntaxTreeNode_List
.type	Add_To_Front_Of_syntaxTreeNode_List,@function
Add_To_Front_Of_syntaxTreeNode_List	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	Add_To_Front_Of_syntaxTreeNode_List_reltrue_5
	movl	$0,%eax
Add_To_Front_Of_syntaxTreeNode_List_reltrue_5	:	
	testl	%eax,%eax
	jnz	Add_To_Front_Of_syntaxTreeNode_List_ifbl_4
	jmp	Add_To_Front_Of_syntaxTreeNode_List_elsebl_4
Add_To_Front_Of_syntaxTreeNode_List_ifbl_4	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	pushl	%eax
	movl	12(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	pushl	%eax
	movl	12(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)
	jmp	Add_To_Front_Of_syntaxTreeNode_List_endif_4
Add_To_Front_Of_syntaxTreeNode_List_elsebl_4	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	pushl	%eax
	movl	12(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	pushl	%eax
	movl	12(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)
Add_To_Front_Of_syntaxTreeNode_List_endif_4	:	
Add_To_Front_Of_syntaxTreeNode_List_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Add_To_Back_Of_syntaxTreeNode_List
.type	Add_To_Back_Of_syntaxTreeNode_List,@function
Add_To_Back_Of_syntaxTreeNode_List	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	Add_To_Back_Of_syntaxTreeNode_List_reltrue_7
	movl	$0,%eax
Add_To_Back_Of_syntaxTreeNode_List_reltrue_7	:	
	testl	%eax,%eax
	jnz	Add_To_Back_Of_syntaxTreeNode_List_ifbl_6
	jmp	Add_To_Back_Of_syntaxTreeNode_List_elsebl_6
Add_To_Back_Of_syntaxTreeNode_List_ifbl_6	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	pushl	%eax
	movl	12(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	pushl	%eax
	movl	12(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)
	jmp	Add_To_Back_Of_syntaxTreeNode_List_endif_6
Add_To_Back_Of_syntaxTreeNode_List_elsebl_6	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	pushl	%eax
	movl	12(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	pushl	%eax
	movl	12(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)
Add_To_Back_Of_syntaxTreeNode_List_endif_6	:	
Add_To_Back_Of_syntaxTreeNode_List_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Add_To_syntaxTreeNode_List_After
.type	Add_To_syntaxTreeNode_List_After,@function
Add_To_syntaxTreeNode_List_After	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	pushl	%eax
	movl	12(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)
Add_To_syntaxTreeNode_List_After_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Append_syntaxTreeNode_List
.type	Append_syntaxTreeNode_List,@function
Append_syntaxTreeNode_List	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	Append_syntaxTreeNode_List_reltrue_9
	movl	$0,%eax
Append_syntaxTreeNode_List_reltrue_9	:	
	testl	%eax,%eax
	jnz	Append_syntaxTreeNode_List_ifbl_8
	jmp	Append_syntaxTreeNode_List_elsebl_8
Append_syntaxTreeNode_List_ifbl_8	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	Append_syntaxTreeNode_List_reltrue_11
	movl	$0,%eax
Append_syntaxTreeNode_List_reltrue_11	:	
	testl	%eax,%eax
	jnz	Append_syntaxTreeNode_List_ifbl_10
	jmp	Append_syntaxTreeNode_List_elsebl_10
Append_syntaxTreeNode_List_ifbl_10	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)
	jmp	Append_syntaxTreeNode_List_endif_10
Append_syntaxTreeNode_List_elsebl_10	:	

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)
Append_syntaxTreeNode_List_endif_10	:	
	jmp	Append_syntaxTreeNode_List_endif_8
Append_syntaxTreeNode_List_elsebl_8	:	
Append_syntaxTreeNode_List_endif_8	:	
Append_syntaxTreeNode_List_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Remove_From_Front_Of_syntaxTreeNode_List
.type	Remove_From_Front_Of_syntaxTreeNode_List,@function
Remove_From_Front_Of_syntaxTreeNode_List	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$4,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	movl	%eax,-4(%ebp)

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	Remove_From_Front_Of_syntaxTreeNode_List_reltrue_13
	movl	$0,%eax
Remove_From_Front_Of_syntaxTreeNode_List_reltrue_13	:	
	testl	%eax,%eax
	jnz	Remove_From_Front_Of_syntaxTreeNode_List_ifbl_12
	jmp	Remove_From_Front_Of_syntaxTreeNode_List_elsebl_12
Remove_From_Front_Of_syntaxTreeNode_List_ifbl_12	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)
	jmp	Remove_From_Front_Of_syntaxTreeNode_List_endif_12
Remove_From_Front_Of_syntaxTreeNode_List_elsebl_12	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)
Remove_From_Front_Of_syntaxTreeNode_List_endif_12	:	

	movl	-4(%ebp),%eax
	jmp	Remove_From_Front_Of_syntaxTreeNode_List_ret
Remove_From_Front_Of_syntaxTreeNode_List_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Remove_From_syntaxTreeNode_List
.type	Remove_From_syntaxTreeNode_List,@function
Remove_From_syntaxTreeNode_List	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	Remove_From_syntaxTreeNode_List_reltrue_15
	movl	$0,%eax
Remove_From_syntaxTreeNode_List_reltrue_15	:	
	testl	%eax,%eax
	jnz	Remove_From_syntaxTreeNode_List_ifbl_14
	jmp	Remove_From_syntaxTreeNode_List_elsebl_14
Remove_From_syntaxTreeNode_List_ifbl_14	:	

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)
	jmp	Remove_From_syntaxTreeNode_List_endif_14
Remove_From_syntaxTreeNode_List_elsebl_14	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)
Remove_From_syntaxTreeNode_List_endif_14	:	

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	Remove_From_syntaxTreeNode_List_reltrue_17
	movl	$0,%eax
Remove_From_syntaxTreeNode_List_reltrue_17	:	
	testl	%eax,%eax
	jnz	Remove_From_syntaxTreeNode_List_ifbl_16
	jmp	Remove_From_syntaxTreeNode_List_elsebl_16
Remove_From_syntaxTreeNode_List_ifbl_16	:	

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)
	jmp	Remove_From_syntaxTreeNode_List_endif_16
Remove_From_syntaxTreeNode_List_elsebl_16	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)
Remove_From_syntaxTreeNode_List_endif_16	:	
Remove_From_syntaxTreeNode_List_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Is_syntaxTreeNode_List_Empty
.type	Is_syntaxTreeNode_List_Empty,@function
Is_syntaxTreeNode_List_Empty	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	Is_syntaxTreeNode_List_Empty_reltrue_18
	movl	$0,%eax
Is_syntaxTreeNode_List_Empty_reltrue_18	:	
	jmp	Is_syntaxTreeNode_List_Empty_ret
Is_syntaxTreeNode_List_Empty_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	syntax_CreateTreeNode
.type	syntax_CreateTreeNode,@function
syntax_CreateTreeNode	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$4,%esp

	subl	$4,%esp
	movl	$152,0(%esp)
	call	malloc
	addl	$4,%esp
	movl	%eax,-4(%ebp)

	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	syntax_CreateTreeNode_reltrue_20
	movl	$0,%eax
syntax_CreateTreeNode_reltrue_20	:	
	testl	%eax,%eax
	jnz	syntax_CreateTreeNode_ifbl_19
	jmp	syntax_CreateTreeNode_elsebl_19
syntax_CreateTreeNode_ifbl_19	:	

	subl	$8,%esp
	movl	$symtab+0,0(%esp)
	movl	-4(%ebp),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$4,%esp
	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,0(%esp)
	call	exit
	addl	$4,%esp
	jmp	syntax_CreateTreeNode_endif_19
syntax_CreateTreeNode_elsebl_19	:	
syntax_CreateTreeNode_endif_19	:	

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	%eax,0(%esp)
	call	Clear_syntaxTreeNode_List
	addl	$4,%esp

	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	addl	$0,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	addl	$16,%eax
	movl	%eax,0(%esp)
	movl	$symtab+49,4(%esp)
	call	strcpy
	addl	$8,%esp

	movl	-4(%ebp),%eax
	jmp	syntax_CreateTreeNode_ret
syntax_CreateTreeNode_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	syntax_AddChildNode
.type	syntax_AddChildNode,@function
syntax_AddChildNode	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$4,%esp

	subl	$0,%esp
	call	syntax_CreateTreeNode
	addl	$0,%esp
	movl	%eax,-4(%ebp)

	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	popl	%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx

	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-4(%ebp),%eax
	movl	%eax,4(%esp)
	call	syntax_AddChildTree
	addl	$8,%esp
syntax_AddChildNode_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	syntax_AddChildTree
.type	syntax_AddChildTree,@function
syntax_AddChildTree	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$4,%esp

	subl	$4,%esp
	movl	$12,0(%esp)
	call	malloc
	addl	$4,%esp
	movl	%eax,-4(%ebp)

	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	syntax_AddChildTree_reltrue_22
	movl	$0,%eax
syntax_AddChildTree_reltrue_22	:	
	testl	%eax,%eax
	jnz	syntax_AddChildTree_ifbl_21
	jmp	syntax_AddChildTree_elsebl_21
syntax_AddChildTree_ifbl_21	:	

	subl	$8,%esp
	movl	$symtab+50,0(%esp)
	movl	-4(%ebp),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$4,%esp
	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,0(%esp)
	call	exit
	addl	$4,%esp
	jmp	syntax_AddChildTree_endif_21
syntax_AddChildTree_elsebl_21	:	
syntax_AddChildTree_endif_21	:	

	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	pushl	%eax
	movl	12(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	%eax,0(%esp)
	movl	-4(%ebp),%eax
	movl	%eax,4(%esp)
	call	Add_To_Back_Of_syntaxTreeNode_List
	addl	$8,%esp
syntax_AddChildTree_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	syntax_CountChilds
.type	syntax_CountChilds,@function
syntax_CountChilds	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$8,%esp

	movl	8(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	syntax_CountChilds_reltrue_24
	movl	$0,%eax
syntax_CountChilds_reltrue_24	:	
	testl	%eax,%eax
	jnz	syntax_CountChilds_ifbl_23
	jmp	syntax_CountChilds_elsebl_23
syntax_CountChilds_ifbl_23	:	

	movl	$0,%eax
	jmp	syntax_CountChilds_ret
syntax_CountChilds_elsebl_23	:	
syntax_CountChilds_endif_23	:	

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	%eax,0(%esp)
	call	Get_Front_Of_syntaxTreeNode_List
	addl	$4,%esp
	movl	%eax,-8(%ebp)

	movl	$0,-4(%ebp)

syntax_CountChilds_while_25	:	
	movl	-8(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	syntax_CountChilds_reltrue_26
	movl	$0,%eax
syntax_CountChilds_reltrue_26	:	
	testl	%eax,%eax
	jz	syntax_CountChilds_endwhile_25

	subl	$4,%esp
	movl	-8(%ebp),%eax
	movl	%eax,0(%esp)
	call	Get_Next_In_syntaxTreeNode_List
	addl	$4,%esp
	movl	%eax,-8(%ebp)

	movl	-4(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)
	jmp	syntax_CountChilds_while_25
syntax_CountChilds_endwhile_25	:	

	movl	-4(%ebp),%eax
	jmp	syntax_CountChilds_ret
syntax_CountChilds_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	syntax_GetChild
.type	syntax_GetChild,@function
syntax_GetChild	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$8,%esp

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	%eax,0(%esp)
	call	Get_Front_Of_syntaxTreeNode_List
	addl	$4,%esp
	movl	%eax,-8(%ebp)

	movl	$0,-4(%ebp)

syntax_GetChild_while_27	:	
	movl	-4(%ebp),%ebx
	cmpl	12(%ebp),%ebx
	movl	$1,%eax
	jl	syntax_GetChild_reltrue_28
	movl	$0,%eax
syntax_GetChild_reltrue_28	:	
	testl	%eax,%eax
	jz	syntax_GetChild_endwhile_27

	subl	$4,%esp
	movl	-8(%ebp),%eax
	movl	%eax,0(%esp)
	call	Get_Next_In_syntaxTreeNode_List
	addl	$4,%esp
	movl	%eax,-8(%ebp)

	movl	-4(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)
	jmp	syntax_GetChild_while_27
syntax_GetChild_endwhile_27	:	

	movl	%ebp,%eax
	addl	$-8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	jmp	syntax_GetChild_ret
syntax_GetChild_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	syntax_EqualTrees
.type	syntax_EqualTrees,@function
syntax_EqualTrees	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$20,%esp

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	syntax_CountChilds
	addl	$4,%esp
	movl	%eax,-8(%ebp)

	subl	$4,%esp
	movl	12(%ebp),%eax
	movl	%eax,0(%esp)
	call	syntax_CountChilds
	addl	$4,%esp
	movl	%eax,-12(%ebp)

	movl	-8(%ebp),%ebx
	cmpl	-12(%ebp),%ebx
	movl	$1,%eax
	jne	syntax_EqualTrees_reltrue_30
	movl	$0,%eax
syntax_EqualTrees_reltrue_30	:	
	testl	%eax,%eax
	jnz	syntax_EqualTrees_ifbl_29
	jmp	syntax_EqualTrees_elsebl_29
syntax_EqualTrees_ifbl_29	:	

	movl	$0,%eax
	jmp	syntax_EqualTrees_ret
syntax_EqualTrees_elsebl_29	:	
syntax_EqualTrees_endif_29	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	addl	$0,%eax
	movl	(%eax),%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	addl	$0,%eax
	movl	(%eax),%eax
	popl	%ebx
	cmpl	%eax,%ebx
	movl	$1,%eax
	jne	syntax_EqualTrees_reltrue_32
	movl	$0,%eax
syntax_EqualTrees_reltrue_32	:	
	testl	%eax,%eax
	jnz	syntax_EqualTrees_ifbl_31
	jmp	syntax_EqualTrees_elsebl_31
syntax_EqualTrees_ifbl_31	:	

	movl	$0,%eax
	jmp	syntax_EqualTrees_ret
syntax_EqualTrees_elsebl_31	:	
syntax_EqualTrees_endif_31	:	

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	addl	$16,%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	addl	$16,%eax
	movl	%eax,4(%esp)
	call	strcmp
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	syntax_EqualTrees_reltrue_34
	movl	$0,%eax
syntax_EqualTrees_reltrue_34	:	
	testl	%eax,%eax
	jnz	syntax_EqualTrees_ifbl_33
	jmp	syntax_EqualTrees_elsebl_33
syntax_EqualTrees_ifbl_33	:	

	movl	$0,%eax
	jmp	syntax_EqualTrees_ret
syntax_EqualTrees_elsebl_33	:	
syntax_EqualTrees_endif_33	:	

	movl	$0,-4(%ebp)

syntax_EqualTrees_while_35	:	
	movl	-4(%ebp),%ebx
	cmpl	-8(%ebp),%ebx
	movl	$1,%eax
	jl	syntax_EqualTrees_reltrue_36
	movl	$0,%eax
syntax_EqualTrees_reltrue_36	:	
	testl	%eax,%eax
	jz	syntax_EqualTrees_endwhile_35

	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-4(%ebp),%eax
	movl	%eax,4(%esp)
	call	syntax_GetChild
	addl	$8,%esp
	movl	%eax,-16(%ebp)

	subl	$8,%esp
	movl	12(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-4(%ebp),%eax
	movl	%eax,4(%esp)
	call	syntax_GetChild
	addl	$8,%esp
	movl	%eax,-20(%ebp)

	subl	$8,%esp
	movl	-16(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-20(%ebp),%eax
	movl	%eax,4(%esp)
	call	syntax_EqualTrees
	addl	$8,%esp
	testl	%eax,%eax
	movl	$1,%eax
	jz	syntax_EqualTrees_logfactfalse_38
	movl	$0,%eax
syntax_EqualTrees_logfactfalse_38	:	
	testl	%eax,%eax
	jnz	syntax_EqualTrees_ifbl_37
	jmp	syntax_EqualTrees_elsebl_37
syntax_EqualTrees_ifbl_37	:	

	movl	$0,%eax
	jmp	syntax_EqualTrees_ret
syntax_EqualTrees_elsebl_37	:	
syntax_EqualTrees_endif_37	:	

	movl	-4(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)
	jmp	syntax_EqualTrees_while_35
syntax_EqualTrees_endwhile_35	:	

	movl	$1,%eax
	jmp	syntax_EqualTrees_ret
syntax_EqualTrees_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	syntax_FreeSyntaxTree
.type	syntax_FreeSyntaxTree,@function
syntax_FreeSyntaxTree	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$16,%esp

	movl	8(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	syntax_FreeSyntaxTree_reltrue_40
	movl	$0,%eax
syntax_FreeSyntaxTree_reltrue_40	:	
	testl	%eax,%eax
	jnz	syntax_FreeSyntaxTree_ifbl_39
	jmp	syntax_FreeSyntaxTree_elsebl_39
syntax_FreeSyntaxTree_ifbl_39	:	

	jmp	syntax_FreeSyntaxTree_ret
syntax_FreeSyntaxTree_elsebl_39	:	
syntax_FreeSyntaxTree_endif_39	:	

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	syntax_CountChilds
	addl	$4,%esp
	movl	%eax,-4(%ebp)

	movl	$0,-8(%ebp)

syntax_FreeSyntaxTree_while_41	:	
	movl	-8(%ebp),%ebx
	cmpl	-4(%ebp),%ebx
	movl	$1,%eax
	jl	syntax_FreeSyntaxTree_reltrue_42
	movl	$0,%eax
syntax_FreeSyntaxTree_reltrue_42	:	
	testl	%eax,%eax
	jz	syntax_FreeSyntaxTree_endwhile_41

	subl	$4,%esp
	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-8(%ebp),%eax
	movl	%eax,4(%esp)
	call	syntax_GetChild
	addl	$8,%esp
	movl	%eax,0(%esp)
	call	syntax_FreeSyntaxTree
	addl	$4,%esp

	movl	-8(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-8(%ebp)
	jmp	syntax_FreeSyntaxTree_while_41
syntax_FreeSyntaxTree_endwhile_41	:	

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	%eax,0(%esp)
	call	Get_Front_Of_syntaxTreeNode_List
	addl	$4,%esp
	movl	%eax,-12(%ebp)

syntax_FreeSyntaxTree_while_43	:	
	movl	-12(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	syntax_FreeSyntaxTree_reltrue_44
	movl	$0,%eax
syntax_FreeSyntaxTree_reltrue_44	:	
	testl	%eax,%eax
	jz	syntax_FreeSyntaxTree_endwhile_43

	subl	$4,%esp
	movl	-12(%ebp),%eax
	movl	%eax,0(%esp)
	call	Get_Next_In_syntaxTreeNode_List
	addl	$4,%esp
	movl	%eax,-16(%ebp)

	subl	$4,%esp
	movl	-12(%ebp),%eax
	movl	%eax,0(%esp)
	call	free
	addl	$4,%esp

	movl	-16(%ebp),%eax
	movl	%eax,-12(%ebp)
	jmp	syntax_FreeSyntaxTree_while_43
syntax_FreeSyntaxTree_endwhile_43	:	

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	%eax,0(%esp)
	call	Clear_syntaxTreeNode_List
	addl	$4,%esp

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	free
	addl	$4,%esp
syntax_FreeSyntaxTree_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	syntax_printTreePre
.type	syntax_printTreePre,@function
syntax_printTreePre	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$212,%esp

	movl	8(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	syntax_printTreePre_reltrue_46
	movl	$0,%eax
syntax_printTreePre_reltrue_46	:	
	testl	%eax,%eax
	jnz	syntax_printTreePre_ifbl_45
	jmp	syntax_printTreePre_elsebl_45
syntax_printTreePre_ifbl_45	:	

	subl	$4,%esp
	movl	$symtab+108,0(%esp)
	call	puts
	addl	$4,%esp

	jmp	syntax_printTreePre_ret
syntax_printTreePre_elsebl_45	:	
syntax_printTreePre_endif_45	:	

	subl	$4,%esp
	movl	12(%ebp),%eax
	movl	%eax,0(%esp)
	call	strlen
	addl	$4,%esp
	movl	%eax,-204(%ebp)

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-200,%eax
	movl	%eax,0(%esp)
	movl	12(%ebp),%eax
	movl	%eax,4(%esp)
	movl	$200,8(%esp)
	call	memcpy
	addl	$12,%esp

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	syntax_CountChilds
	addl	$4,%esp
	movl	%eax,-208(%ebp)

	movl	-208(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	syntax_printTreePre_reltrue_48
	movl	$0,%eax
syntax_printTreePre_reltrue_48	:	
	testl	%eax,%eax
	jnz	syntax_printTreePre_ifbl_47
	jmp	syntax_printTreePre_elsebl_47
syntax_printTreePre_ifbl_47	:	

	subl	$8,%esp
	movl	$symtab+113,0(%esp)
	movl	12(%ebp),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$8,%esp
	movl	$symtab+116,0(%esp)
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	addl	$0,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$8,%esp
	movl	$symtab+124,0(%esp)
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	addl	$16,%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp
	jmp	syntax_printTreePre_endif_47
syntax_printTreePre_elsebl_47	:	

	subl	$8,%esp
	movl	$symtab+130,0(%esp)
	movl	12(%ebp),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	movl	-204(%ebp),%esi
	movb	$32,-200(%ebp,%esi,1)

	movl	-204(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,%esi
	movb	$124,-200(%ebp,%esi,1)

	movl	$0,-212(%ebp)

syntax_printTreePre_while_49	:	
	movl	-212(%ebp),%ebx
	cmpl	-208(%ebp),%ebx
	movl	$1,%eax
	jl	syntax_printTreePre_reltrue_50
	movl	$0,%eax
syntax_printTreePre_reltrue_50	:	
	testl	%eax,%eax
	jz	syntax_printTreePre_endwhile_49

	subl	$8,%esp
	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-212(%ebp),%eax
	movl	%eax,4(%esp)
	call	syntax_GetChild
	addl	$8,%esp
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-200,%eax
	movl	%eax,4(%esp)
	call	syntax_printTreePre
	addl	$8,%esp

	movl	-212(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-212(%ebp)
	jmp	syntax_printTreePre_while_49
syntax_printTreePre_endwhile_49	:	
syntax_printTreePre_endif_47	:	
syntax_printTreePre_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	syntax_printTree
.type	syntax_printTree,@function
syntax_printTree	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$200,%esp

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-200,%eax
	movl	%eax,0(%esp)
	movl	$0,4(%esp)
	movl	$200,8(%esp)
	call	memset
	addl	$12,%esp

	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-200,%eax
	movl	%eax,4(%esp)
	call	syntax_printTreePre
	addl	$8,%esp
syntax_printTree_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	syntax_CopyTree
.type	syntax_CopyTree,@function
syntax_CopyTree	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$12,%esp

	movl	8(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	syntax_CopyTree_reltrue_52
	movl	$0,%eax
syntax_CopyTree_reltrue_52	:	
	testl	%eax,%eax
	jnz	syntax_CopyTree_ifbl_51
	jmp	syntax_CopyTree_elsebl_51
syntax_CopyTree_ifbl_51	:	

	movl	$0,%eax
	jmp	syntax_CopyTree_ret
syntax_CopyTree_elsebl_51	:	
syntax_CopyTree_endif_51	:	

	subl	$0,%esp
	call	syntax_CreateTreeNode
	addl	$0,%esp
	movl	%eax,-4(%ebp)

	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$8,%eax
	popl	%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx
	movl	(%eax),%ecx
	movl	%ecx,(%ebx)
	addl	$4,%eax
	addl	$4,%ebx

	movl	$0,-8(%ebp)

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	syntax_CountChilds
	addl	$4,%esp
	movl	%eax,-12(%ebp)

syntax_CopyTree_while_53	:	
	movl	-8(%ebp),%ebx
	cmpl	-12(%ebp),%ebx
	movl	$1,%eax
	jl	syntax_CopyTree_reltrue_54
	movl	$0,%eax
syntax_CopyTree_reltrue_54	:	
	testl	%eax,%eax
	jz	syntax_CopyTree_endwhile_53

	subl	$8,%esp
	movl	-4(%ebp),%eax
	movl	%eax,0(%esp)
	subl	$4,%esp
	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-8(%ebp),%eax
	movl	%eax,4(%esp)
	call	syntax_GetChild
	addl	$8,%esp
	movl	%eax,0(%esp)
	call	syntax_CopyTree
	addl	$4,%esp
	movl	%eax,4(%esp)
	call	syntax_AddChildTree
	addl	$8,%esp

	movl	-8(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-8(%ebp)
	jmp	syntax_CopyTree_while_53
syntax_CopyTree_endwhile_53	:	

	movl	-4(%ebp),%eax
	jmp	syntax_CopyTree_ret
syntax_CopyTree_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.section	.data
symtab	:	
.string	"Not enough memory to create syntaxTreeNode (%p)\n"
.string	""
.string	"Not enough memory to create syntaxTreeNode_ListNode (%p)\n"
.string	"NULL"
.string	"%s"
.string	"- == %d"
.string	": %s\n"
.string	"%s-+\n"
