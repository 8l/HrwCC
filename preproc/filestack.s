
.section	.text

.globl	Clear_FilenamesList
.type	Clear_FilenamesList,@function
Clear_FilenamesList	:	
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
Clear_FilenamesList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Is_Member_Of_FilenamesList
.type	Is_Member_Of_FilenamesList,@function
Is_Member_Of_FilenamesList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$4,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	movl	%eax,-4(%ebp)

Is_Member_Of_FilenamesList_while_0	:	
	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	Is_Member_Of_FilenamesList_reltrue_1
	movl	$0,%eax
Is_Member_Of_FilenamesList_reltrue_1	:	
	testl	%eax,%eax
	jz	Is_Member_Of_FilenamesList_endwhile_0

	movl	-4(%ebp),%ebx
	cmpl	12(%ebp),%ebx
	movl	$1,%eax
	je	Is_Member_Of_FilenamesList_reltrue_3
	movl	$0,%eax
Is_Member_Of_FilenamesList_reltrue_3	:	
	testl	%eax,%eax
	jnz	Is_Member_Of_FilenamesList_ifbl_2
	jmp	Is_Member_Of_FilenamesList_elsebl_2
Is_Member_Of_FilenamesList_ifbl_2	:	

	movl	$1,%eax
	jmp	Is_Member_Of_FilenamesList_ret
Is_Member_Of_FilenamesList_elsebl_2	:	
Is_Member_Of_FilenamesList_endif_2	:	

	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$264,%eax
	movl	(%eax),%eax
	movl	%eax,-4(%ebp)
	jmp	Is_Member_Of_FilenamesList_while_0
Is_Member_Of_FilenamesList_endwhile_0	:	

	movl	$0,%eax
	jmp	Is_Member_Of_FilenamesList_ret
Is_Member_Of_FilenamesList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Get_Front_Of_FilenamesList
.type	Get_Front_Of_FilenamesList,@function
Get_Front_Of_FilenamesList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	jmp	Get_Front_Of_FilenamesList_ret
Get_Front_Of_FilenamesList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Get_Back_Of_FilenamesList
.type	Get_Back_Of_FilenamesList,@function
Get_Back_Of_FilenamesList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	(%eax),%eax
	jmp	Get_Back_Of_FilenamesList_ret
Get_Back_Of_FilenamesList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Get_Next_In_FilenamesList
.type	Get_Next_In_FilenamesList,@function
Get_Next_In_FilenamesList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$264,%eax
	movl	(%eax),%eax
	jmp	Get_Next_In_FilenamesList_ret
Get_Next_In_FilenamesList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Set_Next_In_FilenamesList
.type	Set_Next_In_FilenamesList,@function
Set_Next_In_FilenamesList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$264,%eax
	pushl	%eax
	movl	12(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)
Set_Next_In_FilenamesList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Get_Prev_In_FilenamesList
.type	Get_Prev_In_FilenamesList,@function
Get_Prev_In_FilenamesList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$260,%eax
	movl	(%eax),%eax
	jmp	Get_Prev_In_FilenamesList_ret
Get_Prev_In_FilenamesList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Set_Prev_In_FilenamesList
.type	Set_Prev_In_FilenamesList,@function
Set_Prev_In_FilenamesList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$260,%eax
	pushl	%eax
	movl	12(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)
Set_Prev_In_FilenamesList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Add_To_Front_Of_FilenamesList
.type	Add_To_Front_Of_FilenamesList,@function
Add_To_Front_Of_FilenamesList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$260,%eax
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
	je	Add_To_Front_Of_FilenamesList_reltrue_5
	movl	$0,%eax
Add_To_Front_Of_FilenamesList_reltrue_5	:	
	testl	%eax,%eax
	jnz	Add_To_Front_Of_FilenamesList_ifbl_4
	jmp	Add_To_Front_Of_FilenamesList_elsebl_4
Add_To_Front_Of_FilenamesList_ifbl_4	:	

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
	addl	$264,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)
	jmp	Add_To_Front_Of_FilenamesList_endif_4
Add_To_Front_Of_FilenamesList_elsebl_4	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	addl	$260,%eax
	pushl	%eax
	movl	12(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$264,%eax
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
Add_To_Front_Of_FilenamesList_endif_4	:	
Add_To_Front_Of_FilenamesList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Add_To_Back_Of_FilenamesList
.type	Add_To_Back_Of_FilenamesList,@function
Add_To_Back_Of_FilenamesList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$264,%eax
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
	je	Add_To_Back_Of_FilenamesList_reltrue_7
	movl	$0,%eax
Add_To_Back_Of_FilenamesList_reltrue_7	:	
	testl	%eax,%eax
	jnz	Add_To_Back_Of_FilenamesList_ifbl_6
	jmp	Add_To_Back_Of_FilenamesList_elsebl_6
Add_To_Back_Of_FilenamesList_ifbl_6	:	

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
	addl	$260,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)
	jmp	Add_To_Back_Of_FilenamesList_endif_6
Add_To_Back_Of_FilenamesList_elsebl_6	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	(%eax),%eax
	addl	$264,%eax
	pushl	%eax
	movl	12(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$260,%eax
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
Add_To_Back_Of_FilenamesList_endif_6	:	
Add_To_Back_Of_FilenamesList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Add_To_FilenamesList_After
.type	Add_To_FilenamesList_After,@function
Add_To_FilenamesList_After	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$264,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$264,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$264,%eax
	pushl	%eax
	movl	12(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)
Add_To_FilenamesList_After_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Append_FilenamesList
.type	Append_FilenamesList,@function
Append_FilenamesList	:	
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
	jne	Append_FilenamesList_reltrue_9
	movl	$0,%eax
Append_FilenamesList_reltrue_9	:	
	testl	%eax,%eax
	jnz	Append_FilenamesList_ifbl_8
	jmp	Append_FilenamesList_elsebl_8
Append_FilenamesList_ifbl_8	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	Append_FilenamesList_reltrue_11
	movl	$0,%eax
Append_FilenamesList_reltrue_11	:	
	testl	%eax,%eax
	jnz	Append_FilenamesList_ifbl_10
	jmp	Append_FilenamesList_elsebl_10
Append_FilenamesList_ifbl_10	:	

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
	jmp	Append_FilenamesList_endif_10
Append_FilenamesList_elsebl_10	:	

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	addl	$260,%eax
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
	addl	$264,%eax
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
Append_FilenamesList_endif_10	:	
	jmp	Append_FilenamesList_endif_8
Append_FilenamesList_elsebl_8	:	
Append_FilenamesList_endif_8	:	
Append_FilenamesList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Remove_From_Front_Of_FilenamesList
.type	Remove_From_Front_Of_FilenamesList,@function
Remove_From_Front_Of_FilenamesList	:	
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
	addl	$264,%eax
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
	je	Remove_From_Front_Of_FilenamesList_reltrue_13
	movl	$0,%eax
Remove_From_Front_Of_FilenamesList_reltrue_13	:	
	testl	%eax,%eax
	jnz	Remove_From_Front_Of_FilenamesList_ifbl_12
	jmp	Remove_From_Front_Of_FilenamesList_elsebl_12
Remove_From_Front_Of_FilenamesList_ifbl_12	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)
	jmp	Remove_From_Front_Of_FilenamesList_endif_12
Remove_From_Front_Of_FilenamesList_elsebl_12	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	addl	$260,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)
Remove_From_Front_Of_FilenamesList_endif_12	:	

	movl	-4(%ebp),%eax
	jmp	Remove_From_Front_Of_FilenamesList_ret
Remove_From_Front_Of_FilenamesList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Remove_From_FilenamesList
.type	Remove_From_FilenamesList,@function
Remove_From_FilenamesList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$260,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	Remove_From_FilenamesList_reltrue_15
	movl	$0,%eax
Remove_From_FilenamesList_reltrue_15	:	
	testl	%eax,%eax
	jnz	Remove_From_FilenamesList_ifbl_14
	jmp	Remove_From_FilenamesList_elsebl_14
Remove_From_FilenamesList_ifbl_14	:	

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$260,%eax
	movl	(%eax),%eax
	addl	$264,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$264,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)
	jmp	Remove_From_FilenamesList_endif_14
Remove_From_FilenamesList_elsebl_14	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$264,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)
Remove_From_FilenamesList_endif_14	:	

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$264,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	Remove_From_FilenamesList_reltrue_17
	movl	$0,%eax
Remove_From_FilenamesList_reltrue_17	:	
	testl	%eax,%eax
	jnz	Remove_From_FilenamesList_ifbl_16
	jmp	Remove_From_FilenamesList_elsebl_16
Remove_From_FilenamesList_ifbl_16	:	

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$264,%eax
	movl	(%eax),%eax
	addl	$260,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$260,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)
	jmp	Remove_From_FilenamesList_endif_16
Remove_From_FilenamesList_elsebl_16	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$260,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)
Remove_From_FilenamesList_endif_16	:	
Remove_From_FilenamesList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Is_FilenamesList_Empty
.type	Is_FilenamesList_Empty,@function
Is_FilenamesList_Empty	:	
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
	je	Is_FilenamesList_Empty_reltrue_18
	movl	$0,%eax
Is_FilenamesList_Empty_reltrue_18	:	
	jmp	Is_FilenamesList_Empty_ret
Is_FilenamesList_Empty_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	getSystemIncludePaths
.type	getSystemIncludePaths,@function
getSystemIncludePaths	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+0,4(%esp)
	call	strcpy
	addl	$8,%esp
getSystemIncludePaths_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	fstack_init
.type	fstack_init,@function
fstack_init	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$588,%eax
	pushl	%eax
	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	movl	%eax,(%ebx)

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$580,%eax
	movl	%eax,0(%esp)
	call	Clear_FilenamesList
	addl	$4,%esp

	movl	$0,%eax
	jmp	fstack_init_ret
fstack_init_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	fstack_destroy
.type	fstack_destroy,@function
fstack_destroy	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$37,%esp

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$580,%eax
	movl	%eax,0(%esp)
	call	Is_FilenamesList_Empty
	addl	$4,%esp
	testl	%eax,%eax
	movl	$1,%eax
	jz	fstack_destroy_logfactfalse_20
	movl	$0,%eax
fstack_destroy_logfactfalse_20	:	
	testl	%eax,%eax
	jnz	fstack_destroy_ifbl_19
	jmp	fstack_destroy_elsebl_19
fstack_destroy_ifbl_19	:	

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$580,%eax
	movl	%eax,0(%esp)
	call	Get_Front_Of_FilenamesList
	addl	$4,%esp
	movl	%eax,-4(%ebp)

fstack_destroy_while_21	:	
	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	fstack_destroy_reltrue_22
	movl	$0,%eax
fstack_destroy_reltrue_22	:	
	testl	%eax,%eax
	jz	fstack_destroy_endwhile_21

	subl	$4,%esp
	movl	-4(%ebp),%eax
	movl	%eax,0(%esp)
	call	Get_Next_In_FilenamesList
	addl	$4,%esp
	movl	%eax,-8(%ebp)

	subl	$4,%esp
	movl	-4(%ebp),%eax
	movl	%eax,0(%esp)
	call	free
	addl	$4,%esp

	movl	-8(%ebp),%eax
	movl	%eax,-4(%ebp)
	jmp	fstack_destroy_while_21
fstack_destroy_endwhile_21	:	
	jmp	fstack_destroy_endif_19
fstack_destroy_elsebl_19	:	
fstack_destroy_endif_19	:	

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$580,%eax
	movl	%eax,0(%esp)
	call	Clear_FilenamesList
	addl	$4,%esp

fstack_destroy_while_23	:	
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$588,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jge	fstack_destroy_reltrue_24
	movl	$0,%eax
fstack_destroy_reltrue_24	:	
	testl	%eax,%eax
	jz	fstack_destroy_endwhile_23

	movl	%ebp,%eax
	addl	$-37,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$588,%eax
	movl	(%eax),%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	imull	$29,%esi
	addl	%esi,%eax
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
	movb	(%eax),%cl
	movb	%cl,(%ebx)
	addl	$1,%eax
	addl	$1,%ebx

	movl	%ebp,%eax
	addl	$-37,%eax
	addl	$0,%eax
	movl	(%eax),%eax
	pushl	%eax
	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	cmpl	%eax,%ebx
	movl	$1,%eax
	jne	fstack_destroy_reltrue_26
	movl	$0,%eax
fstack_destroy_reltrue_26	:	
	testl	%eax,%eax
	jnz	fstack_destroy_ifbl_25
	jmp	fstack_destroy_elsebl_25
fstack_destroy_ifbl_25	:	

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-37,%eax
	addl	$0,%eax
	movl	(%eax),%eax
	movl	%eax,0(%esp)
	call	close
	addl	$4,%esp

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-37,%eax
	movl	%eax,0(%esp)
	movl	$0,4(%esp)
	movl	$29,8(%esp)
	call	memset
	addl	$12,%esp
	jmp	fstack_destroy_endif_25
fstack_destroy_elsebl_25	:	
fstack_destroy_endif_25	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$588,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$588,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	movl	%eax,(%ebx)
	jmp	fstack_destroy_while_23
fstack_destroy_endwhile_23	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$588,%eax
	pushl	%eax
	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	$0,%eax
	jmp	fstack_destroy_ret
fstack_destroy_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	addNewFilenameNode
.type	addNewFilenameNode,@function
addNewFilenameNode	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$12,%esp

	subl	$4,%esp
	movl	$268,0(%esp)
	call	malloc
	addl	$4,%esp
	movl	%eax,-4(%ebp)

	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	addNewFilenameNode_reltrue_28
	movl	$0,%eax
addNewFilenameNode_reltrue_28	:	
	testl	%eax,%eax
	jnz	addNewFilenameNode_ifbl_27
	jmp	addNewFilenameNode_elsebl_27
addNewFilenameNode_ifbl_27	:	

	subl	$16,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+11,4(%esp)
	movl	$0,8(%esp)
	movl	$2,12(%esp)
	call	preproc_reportError_s
	addl	$16,%esp

	movl	$0,%ebx
	subl	$10002,%ebx
	movl	%ebx,%eax
	jmp	addNewFilenameNode_ret
addNewFilenameNode_elsebl_27	:	
addNewFilenameNode_endif_27	:	

	subl	$12,%esp
	movl	-4(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$0,4(%esp)
	movl	$268,8(%esp)
	call	memset
	addl	$12,%esp

	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	pushl	%eax
	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	movl	%eax,(%ebx)

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$580,%eax
	movl	%eax,0(%esp)
	call	Get_Front_Of_FilenamesList
	addl	$4,%esp
	movl	%eax,-8(%ebp)

addNewFilenameNode_while_29	:	
	movl	-8(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	addNewFilenameNode_reltrue_30
	movl	$0,%eax
addNewFilenameNode_reltrue_30	:	
	testl	%eax,%eax
	jz	addNewFilenameNode_endwhile_29

	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$-8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	subl	$4,%esp
	movl	-8(%ebp),%eax
	movl	%eax,0(%esp)
	call	Get_Next_In_FilenamesList
	addl	$4,%esp
	movl	%eax,-8(%ebp)
	jmp	addNewFilenameNode_while_29
addNewFilenameNode_endwhile_29	:	

	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$588,%eax
	movl	(%eax),%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	imull	$29,%esi
	addl	%esi,%eax
	movl	%eax,-12(%ebp)

	movl	%ebp,%eax
	addl	$-12,%eax
	movl	(%eax),%eax
	addl	$17,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	%eax,0(%esp)
	movl	$0,4(%esp)
	movl	$1,%ebx
	imull	$256,%ebx
	movl	%ebx,%eax
	movl	%eax,8(%esp)
	call	memset
	addl	$12,%esp

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	%eax,0(%esp)
	movl	12(%ebp),%eax
	movl	%eax,4(%esp)
	movl	$256,8(%esp)
	call	strncpy
	addl	$12,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$580,%eax
	movl	%eax,0(%esp)
	movl	-4(%ebp),%eax
	movl	%eax,4(%esp)
	call	Add_To_Back_Of_FilenamesList
	addl	$8,%esp

	movl	$0,%eax
	jmp	addNewFilenameNode_ret
addNewFilenameNode_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	isFileAlreadyOnStack
.type	isFileAlreadyOnStack,@function
isFileAlreadyOnStack	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$37,%esp

	movl	$0,-4(%ebp)

isFileAlreadyOnStack_while_31	:	
	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$588,%eax
	movl	(%eax),%eax
	popl	%ebx
	cmpl	%eax,%ebx
	movl	$1,%eax
	jle	isFileAlreadyOnStack_reltrue_32
	movl	$0,%eax
isFileAlreadyOnStack_reltrue_32	:	
	testl	%eax,%eax
	jz	isFileAlreadyOnStack_endwhile_31

	movl	%ebp,%eax
	addl	$-37,%eax
	pushl	%eax
	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	imull	$29,%esi
	addl	%esi,%eax
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
	movb	(%eax),%cl
	movb	%cl,(%ebx)
	addl	$1,%eax
	addl	$1,%ebx

	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-37,%eax
	addl	$17,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	fstack_getFilename
	addl	$8,%esp
	movl	%eax,-8(%ebp)

	subl	$8,%esp
	movl	-8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	12(%ebp),%eax
	movl	%eax,4(%esp)
	call	strcmp
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	isFileAlreadyOnStack_reltrue_34
	movl	$0,%eax
isFileAlreadyOnStack_reltrue_34	:	
	testl	%eax,%eax
	jnz	isFileAlreadyOnStack_ifbl_33
	jmp	isFileAlreadyOnStack_elsebl_33
isFileAlreadyOnStack_ifbl_33	:	

	movl	$1,%eax
	jmp	isFileAlreadyOnStack_ret
isFileAlreadyOnStack_elsebl_33	:	
isFileAlreadyOnStack_endif_33	:	

	movl	-4(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)
	jmp	isFileAlreadyOnStack_while_31
isFileAlreadyOnStack_endwhile_31	:	

	movl	$0,%eax
	jmp	isFileAlreadyOnStack_ret
isFileAlreadyOnStack_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	getAbsoluteIncludePath
.type	getAbsoluteIncludePath,@function
getAbsoluteIncludePath	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$276,%esp

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-276,%eax
	movl	%eax,0(%esp)
	movl	$0,4(%esp)
	movl	$256,8(%esp)
	call	memset
	addl	$12,%esp

	subl	$12,%esp
	movl	16(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$0,4(%esp)
	movl	$256,8(%esp)
	call	memset
	addl	$12,%esp

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-276,%eax
	movl	%eax,0(%esp)
	call	getSystemIncludePaths
	addl	$4,%esp

	movl	$0,-4(%ebp)

	movl	$0,-8(%ebp)

	movl	$0,-20(%ebp)

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-276,%eax
	movl	%eax,0(%esp)
	call	strlen
	addl	$4,%esp
	movl	%eax,-12(%ebp)

getAbsoluteIncludePath_while_35	:	
	movl	-8(%ebp),%ebx
	cmpl	-12(%ebp),%ebx
	movl	$1,%eax
	jl	getAbsoluteIncludePath_reltrue_36
	movl	$0,%eax
getAbsoluteIncludePath_reltrue_36	:	
	testl	%eax,%eax
	jz	getAbsoluteIncludePath_endwhile_35

	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$-276,%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,%ebx
	cmpl	$58,%ebx
	movl	$1,%eax
	jne	getAbsoluteIncludePath_reltrue_38
	movl	$0,%eax
getAbsoluteIncludePath_reltrue_38	:	
	testl	%eax,%eax
	jnz	getAbsoluteIncludePath_ifbl_37
	jmp	getAbsoluteIncludePath_elsebl_37
getAbsoluteIncludePath_ifbl_37	:	

	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$16,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	pushl	%eax
	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$-276,%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	popl	%ebx
	movb	%al,(%ebx)

	movl	-8(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-8(%ebp)

	movl	-4(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)
	jmp	getAbsoluteIncludePath_while_35
getAbsoluteIncludePath_elsebl_37	:	
getAbsoluteIncludePath_endif_37	:	

	movl	-8(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-8(%ebp)

	movl	-4(%ebp),%ebx
	cmpl	$1,%ebx
	movl	$1,%eax
	jg	getAbsoluteIncludePath_reltrue_40
	movl	$0,%eax
getAbsoluteIncludePath_reltrue_40	:	
	testl	%eax,%eax
	jnz	getAbsoluteIncludePath_ifbl_39
	jmp	getAbsoluteIncludePath_elsebl_39
getAbsoluteIncludePath_ifbl_39	:	

	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$16,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movl	%eax,%ebx
	movb	$47,(%ebx)

	movl	-4(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)

	pushl	-4(%ebp)
	subl	$4,%esp
	movl	12(%ebp),%eax
	movl	%eax,0(%esp)
	call	strlen
	addl	$4,%esp
	popl	%ebx
	addl	%eax,%ebx
	movl	%ebx,%eax
	movl	%eax,%ebx
	cmpl	$256,%ebx
	movl	$1,%eax
	jge	getAbsoluteIncludePath_reltrue_42
	movl	$0,%eax
getAbsoluteIncludePath_reltrue_42	:	
	testl	%eax,%eax
	jnz	getAbsoluteIncludePath_ifbl_41
	jmp	getAbsoluteIncludePath_elsebl_41
getAbsoluteIncludePath_ifbl_41	:	

	subl	$16,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+41,4(%esp)
	movl	12(%ebp),%eax
	movl	%eax,8(%esp)
	movl	$1,12(%esp)
	call	preproc_reportError_s
	addl	$16,%esp

	movl	$0,%ebx
	subl	$10501,%ebx
	movl	%ebx,%eax
	jmp	getAbsoluteIncludePath_ret
getAbsoluteIncludePath_elsebl_41	:	
getAbsoluteIncludePath_endif_41	:	

	subl	$8,%esp
	movl	16(%ebp),%eax
	movl	%eax,0(%esp)
	movl	12(%ebp),%eax
	movl	%eax,4(%esp)
	call	strcat
	addl	$8,%esp

	subl	$12,%esp
	movl	16(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$0,4(%esp)
	movl	$0,8(%esp)
	call	open
	addl	$12,%esp
	movl	%eax,-16(%ebp)

	pushl	-16(%ebp)
	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	cmpl	%eax,%ebx
	movl	$1,%eax
	jne	getAbsoluteIncludePath_reltrue_44
	movl	$0,%eax
getAbsoluteIncludePath_reltrue_44	:	
	testl	%eax,%eax
	jnz	getAbsoluteIncludePath_ifbl_43
	jmp	getAbsoluteIncludePath_elsebl_43
getAbsoluteIncludePath_ifbl_43	:	

	subl	$4,%esp
	movl	-16(%ebp),%eax
	movl	%eax,0(%esp)
	call	close
	addl	$4,%esp

	movl	$1,-20(%ebp)
	jmp	getAbsoluteIncludePath_endwhile_35
getAbsoluteIncludePath_elsebl_43	:	
getAbsoluteIncludePath_endif_43	:	

	subl	$12,%esp
	movl	16(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$0,4(%esp)
	movl	$256,8(%esp)
	call	memset
	addl	$12,%esp

	movl	$0,-4(%ebp)
	jmp	getAbsoluteIncludePath_endif_39
getAbsoluteIncludePath_elsebl_39	:	
getAbsoluteIncludePath_endif_39	:	
	jmp	getAbsoluteIncludePath_while_35
getAbsoluteIncludePath_endwhile_35	:	

	movl	-20(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	getAbsoluteIncludePath_reltrue_46
	movl	$0,%eax
getAbsoluteIncludePath_reltrue_46	:	
	testl	%eax,%eax
	jnz	getAbsoluteIncludePath_ifbl_45
	jmp	getAbsoluteIncludePath_elsebl_45
getAbsoluteIncludePath_ifbl_45	:	

	subl	$16,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+89,4(%esp)
	movl	12(%ebp),%eax
	movl	%eax,8(%esp)
	movl	$1,12(%esp)
	call	preproc_reportError_s
	addl	$16,%esp

	movl	$0,%ebx
	subl	$10500,%ebx
	movl	%ebx,%eax
	jmp	getAbsoluteIncludePath_ret
getAbsoluteIncludePath_elsebl_45	:	
getAbsoluteIncludePath_endif_45	:	

	movl	$0,%eax
	jmp	getAbsoluteIncludePath_ret
getAbsoluteIncludePath_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	fstack_pushFile
.type	fstack_pushFile,@function
fstack_pushFile	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$276,%esp

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-268,%eax
	movl	%eax,0(%esp)
	movl	$0,4(%esp)
	movl	$256,8(%esp)
	call	memset
	addl	$12,%esp

	movl	16(%ebp),%ebx
	cmpl	$1,%ebx
	movl	$1,%eax
	je	fstack_pushFile_reltrue_48
	movl	$0,%eax
fstack_pushFile_reltrue_48	:	
	testl	%eax,%eax
	jnz	fstack_pushFile_ifbl_47
	jmp	fstack_pushFile_elsebl_47
fstack_pushFile_ifbl_47	:	

	subl	$12,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	12(%ebp),%eax
	movl	%eax,4(%esp)
	movl	%ebp,%eax
	addl	$-268,%eax
	movl	%eax,8(%esp)
	call	getAbsoluteIncludePath
	addl	$12,%esp
	movl	%eax,-8(%ebp)

	movl	-8(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	fstack_pushFile_reltrue_50
	movl	$0,%eax
fstack_pushFile_reltrue_50	:	
	testl	%eax,%eax
	jnz	fstack_pushFile_ifbl_49
	jmp	fstack_pushFile_elsebl_49
fstack_pushFile_ifbl_49	:	

	movl	-8(%ebp),%eax
	jmp	fstack_pushFile_ret
fstack_pushFile_elsebl_49	:	
fstack_pushFile_endif_49	:	
	jmp	fstack_pushFile_endif_47
fstack_pushFile_elsebl_47	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$588,%eax
	movl	(%eax),%eax
	pushl	%eax
	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	cmpl	%eax,%ebx
	movl	$1,%eax
	jne	fstack_pushFile_reltrue_52
	movl	$0,%eax
fstack_pushFile_reltrue_52	:	
	testl	%eax,%eax
	jnz	fstack_pushFile_ifbl_51
	jmp	fstack_pushFile_elsebl_51
fstack_pushFile_ifbl_51	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$588,%eax
	movl	(%eax),%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	imull	$29,%esi
	addl	%esi,%eax
	movl	%eax,-276(%ebp)

	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-276,%eax
	movl	(%eax),%eax
	addl	$17,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	fstack_getFilename
	addl	$8,%esp
	movl	%eax,-272(%ebp)

	subl	$4,%esp
	movl	-272(%ebp),%eax
	movl	%eax,0(%esp)
	call	strlen
	addl	$4,%esp
	movl	%eax,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-12(%ebp)

fstack_pushFile_while_53	:	
	movl	-12(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jge	fstack_pushFile_reltrue_55
	movl	$0,%eax
fstack_pushFile_reltrue_55	:	
	testl	%eax,%eax
	jz	fstack_pushFile_logtermfalse_54
	pushl	-12(%ebp)
	movl	%ebp,%eax
	addl	$-272,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,%ebx
	cmpl	$47,%ebx
	movl	$1,%eax
	jne	fstack_pushFile_reltrue_56
	movl	$0,%eax
fstack_pushFile_reltrue_56	:	
	testl	%eax,%eax
	jz	fstack_pushFile_logtermfalse_54
	movl	$1,%eax
	jmp	fstack_pushFile_logtermtrue_54
fstack_pushFile_logtermfalse_54	:	
	movl	$0,%eax
fstack_pushFile_logtermtrue_54	:	
	testl	%eax,%eax
	jz	fstack_pushFile_endwhile_53

	movl	-12(%ebp),%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-12(%ebp)
	jmp	fstack_pushFile_while_53
fstack_pushFile_endwhile_53	:	

	movl	-12(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-12(%ebp)

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-268,%eax
	movl	%eax,0(%esp)
	movl	-272(%ebp),%eax
	movl	%eax,4(%esp)
	movl	-12(%ebp),%eax
	movl	%eax,8(%esp)
	call	strncpy
	addl	$12,%esp

	pushl	-12(%ebp)
	subl	$4,%esp
	movl	12(%ebp),%eax
	movl	%eax,0(%esp)
	call	strlen
	addl	$4,%esp
	popl	%ebx
	addl	%eax,%ebx
	movl	%ebx,%eax
	movl	%eax,%ebx
	cmpl	$256,%ebx
	movl	$1,%eax
	jge	fstack_pushFile_reltrue_58
	movl	$0,%eax
fstack_pushFile_reltrue_58	:	
	testl	%eax,%eax
	jnz	fstack_pushFile_ifbl_57
	jmp	fstack_pushFile_elsebl_57
fstack_pushFile_ifbl_57	:	

	subl	$16,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+41,4(%esp)
	movl	12(%ebp),%eax
	movl	%eax,8(%esp)
	movl	$1,12(%esp)
	call	preproc_reportError_s
	addl	$16,%esp

	movl	$0,%ebx
	subl	$10501,%ebx
	movl	%ebx,%eax
	jmp	fstack_pushFile_ret
fstack_pushFile_elsebl_57	:	
fstack_pushFile_endif_57	:	

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-268,%eax
	movl	%eax,0(%esp)
	movl	12(%ebp),%eax
	movl	%eax,4(%esp)
	call	strcat
	addl	$8,%esp
	jmp	fstack_pushFile_endif_51
fstack_pushFile_elsebl_51	:	

	subl	$4,%esp
	movl	12(%ebp),%eax
	movl	%eax,0(%esp)
	call	strlen
	addl	$4,%esp
	movl	%eax,%ebx
	cmpl	$256,%ebx
	movl	$1,%eax
	jge	fstack_pushFile_reltrue_60
	movl	$0,%eax
fstack_pushFile_reltrue_60	:	
	testl	%eax,%eax
	jnz	fstack_pushFile_ifbl_59
	jmp	fstack_pushFile_elsebl_59
fstack_pushFile_ifbl_59	:	

	subl	$16,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+41,4(%esp)
	movl	12(%ebp),%eax
	movl	%eax,8(%esp)
	movl	$1,12(%esp)
	call	preproc_reportError_s
	addl	$16,%esp

	movl	$0,%ebx
	subl	$10501,%ebx
	movl	%ebx,%eax
	jmp	fstack_pushFile_ret
fstack_pushFile_elsebl_59	:	
fstack_pushFile_endif_59	:	

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-268,%eax
	movl	%eax,0(%esp)
	movl	12(%ebp),%eax
	movl	%eax,4(%esp)
	movl	$256,8(%esp)
	call	memcpy
	addl	$12,%esp
fstack_pushFile_endif_51	:	
fstack_pushFile_endif_47	:	

	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	12(%ebp),%eax
	movl	%eax,4(%esp)
	call	isFileAlreadyOnStack
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$1,%ebx
	movl	$1,%eax
	je	fstack_pushFile_reltrue_62
	movl	$0,%eax
fstack_pushFile_reltrue_62	:	
	testl	%eax,%eax
	jnz	fstack_pushFile_ifbl_61
	jmp	fstack_pushFile_elsebl_61
fstack_pushFile_ifbl_61	:	

	movl	$0,%eax
	jmp	fstack_pushFile_ret
fstack_pushFile_elsebl_61	:	
fstack_pushFile_endif_61	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$588,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,%ebx
	cmpl	$20,%ebx
	movl	$1,%eax
	je	fstack_pushFile_reltrue_64
	movl	$0,%eax
fstack_pushFile_reltrue_64	:	
	testl	%eax,%eax
	jnz	fstack_pushFile_ifbl_63
	jmp	fstack_pushFile_elsebl_63
fstack_pushFile_ifbl_63	:	

	subl	$16,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+128,4(%esp)
	movl	$0,8(%esp)
	movl	$2,12(%esp)
	call	preproc_reportError_s
	addl	$16,%esp

	movl	$0,%ebx
	subl	$10001,%ebx
	movl	%ebx,%eax
	jmp	fstack_pushFile_ret
fstack_pushFile_elsebl_63	:	
fstack_pushFile_endif_63	:	

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-268,%eax
	movl	%eax,0(%esp)
	movl	$0,4(%esp)
	movl	$0,8(%esp)
	call	open
	addl	$12,%esp
	movl	%eax,-4(%ebp)

	pushl	-4(%ebp)
	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	cmpl	%eax,%ebx
	movl	$1,%eax
	je	fstack_pushFile_reltrue_66
	movl	$0,%eax
fstack_pushFile_reltrue_66	:	
	testl	%eax,%eax
	jnz	fstack_pushFile_ifbl_65
	jmp	fstack_pushFile_elsebl_65
fstack_pushFile_ifbl_65	:	

	subl	$16,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+147,4(%esp)
	movl	%ebp,%eax
	addl	$-268,%eax
	movl	%eax,8(%esp)
	movl	$1,12(%esp)
	call	preproc_reportError_s
	addl	$16,%esp

	movl	$0,%ebx
	subl	$10500,%ebx
	movl	%ebx,%eax
	jmp	fstack_pushFile_ret
fstack_pushFile_elsebl_65	:	
fstack_pushFile_endif_65	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$588,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$588,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$588,%eax
	movl	(%eax),%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	imull	$29,%esi
	addl	%esi,%eax
	movl	%eax,-276(%ebp)

	movl	%ebp,%eax
	addl	$-276,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	pushl	%eax
	movl	-4(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$-276,%eax
	movl	(%eax),%eax
	addl	$21,%eax
	movl	%eax,%ebx
	movl	$1,(%ebx)

	movl	%ebp,%eax
	addl	$-276,%eax
	movl	(%eax),%eax
	addl	$25,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-276,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	%eax,0(%esp)
	movl	$0,4(%esp)
	movl	$13,8(%esp)
	call	memset
	addl	$12,%esp

	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-268,%eax
	movl	%eax,4(%esp)
	call	addNewFilenameNode
	addl	$8,%esp
	jmp	fstack_pushFile_ret
fstack_pushFile_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	fstack_getNext
.type	fstack_getNext,@function
fstack_getNext	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$8,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$588,%eax
	movl	(%eax),%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	imull	$29,%esi
	addl	%esi,%eax
	movl	%eax,-8(%ebp)

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$588,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jge	fstack_getNext_reltrue_69
	movl	$0,%eax
fstack_getNext_reltrue_69	:	
	testl	%eax,%eax
	jz	fstack_getNext_logtermfalse_68
	movl	%ebp,%eax
	addl	$-8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	pushl	%eax
	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	cmpl	%eax,%ebx
	movl	$1,%eax
	je	fstack_getNext_reltrue_70
	movl	$0,%eax
fstack_getNext_reltrue_70	:	
	testl	%eax,%eax
	jz	fstack_getNext_logtermfalse_68
	movl	$1,%eax
	jmp	fstack_getNext_logtermtrue_68
fstack_getNext_logtermfalse_68	:	
	movl	$0,%eax
fstack_getNext_logtermtrue_68	:	
	testl	%eax,%eax
	jnz	fstack_getNext_ifbl_67
	jmp	fstack_getNext_elsebl_67
fstack_getNext_ifbl_67	:	

	movl	$0,%ebx
	subl	$10000,%ebx
	movl	%ebx,%eax
	jmp	fstack_getNext_ret
fstack_getNext_elsebl_67	:	
fstack_getNext_endif_67	:	

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	%eax,%ebx
	movb	$0,(%ebx)

	movl	$0,-4(%ebp)

fstack_getNext_while_71	:	
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	fstack_getNext_reltrue_73
	movl	$0,%eax
fstack_getNext_reltrue_73	:	
	testl	%eax,%eax
	jz	fstack_getNext_logtermfalse_72
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$588,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jge	fstack_getNext_reltrue_74
	movl	$0,%eax
fstack_getNext_reltrue_74	:	
	testl	%eax,%eax
	jz	fstack_getNext_logtermfalse_72
	movl	$1,%eax
	jmp	fstack_getNext_logtermtrue_72
fstack_getNext_logtermfalse_72	:	
	movl	$0,%eax
fstack_getNext_logtermtrue_72	:	
	testl	%eax,%eax
	jz	fstack_getNext_endwhile_71

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	%eax,4(%esp)
	movl	$1,8(%esp)
	call	read
	addl	$12,%esp
	movl	%eax,-4(%ebp)

	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jg	fstack_getNext_reltrue_76
	movl	$0,%eax
fstack_getNext_reltrue_76	:	
	testl	%eax,%eax
	jnz	fstack_getNext_ifbl_75
	jmp	fstack_getNext_elsebl_75
fstack_getNext_ifbl_75	:	
	jmp	fstack_getNext_endwhile_71
fstack_getNext_elsebl_75	:	
fstack_getNext_endif_75	:	

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	movl	%eax,0(%esp)
	call	close
	addl	$4,%esp

	movl	%ebp,%eax
	addl	$-8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	pushl	%eax
	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$-8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	addl	$0,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,%ebx
	cmpl	$10,%ebx
	movl	$1,%eax
	jne	fstack_getNext_reltrue_78
	movl	$0,%eax
fstack_getNext_reltrue_78	:	
	testl	%eax,%eax
	jnz	fstack_getNext_ifbl_77
	jmp	fstack_getNext_elsebl_77
fstack_getNext_ifbl_77	:	

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	%eax,%ebx
	movb	$10,(%ebx)

	movl	$1,-4(%ebp)

	subl	$16,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+170,4(%esp)
	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-8,%eax
	movl	(%eax),%eax
	addl	$17,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	fstack_getFilename
	addl	$8,%esp
	movl	%eax,8(%esp)
	movl	$1,12(%esp)
	call	preproc_reportError_s
	addl	$16,%esp
	jmp	fstack_getNext_endif_77
fstack_getNext_elsebl_77	:	
fstack_getNext_endif_77	:	

	subl	$12,%esp
	movl	-8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$0,4(%esp)
	movl	$29,8(%esp)
	call	memset
	addl	$12,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$588,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$588,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$588,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	fstack_getNext_reltrue_80
	movl	$0,%eax
fstack_getNext_reltrue_80	:	
	testl	%eax,%eax
	jnz	fstack_getNext_ifbl_79
	jmp	fstack_getNext_elsebl_79
fstack_getNext_ifbl_79	:	
	jmp	fstack_getNext_endwhile_71
fstack_getNext_elsebl_79	:	
fstack_getNext_endif_79	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$588,%eax
	movl	(%eax),%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	imull	$29,%esi
	addl	%esi,%eax
	movl	%eax,-8(%ebp)
	jmp	fstack_getNext_while_71
fstack_getNext_endwhile_71	:	

	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	fstack_getNext_reltrue_83
	movl	$0,%eax
fstack_getNext_reltrue_83	:	
	testl	%eax,%eax
	jz	fstack_getNext_logtermfalse_82
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$588,%eax
	movl	(%eax),%eax
	pushl	%eax
	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	cmpl	%eax,%ebx
	movl	$1,%eax
	je	fstack_getNext_reltrue_84
	movl	$0,%eax
fstack_getNext_reltrue_84	:	
	testl	%eax,%eax
	jz	fstack_getNext_logtermfalse_82
	movl	$1,%eax
	jmp	fstack_getNext_logtermtrue_82
fstack_getNext_logtermfalse_82	:	
	movl	$0,%eax
fstack_getNext_logtermtrue_82	:	
	testl	%eax,%eax
	jnz	fstack_getNext_ifbl_81
	jmp	fstack_getNext_elsebl_81
fstack_getNext_ifbl_81	:	

	movl	$1,%eax
	jmp	fstack_getNext_ret
fstack_getNext_elsebl_81	:	
fstack_getNext_endif_81	:	

	movl	%ebp,%eax
	addl	$-8,%eax
	movl	(%eax),%eax
	addl	$25,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$-8,%eax
	movl	(%eax),%eax
	addl	$25,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,%ebx
	cmpl	$10,%ebx
	movl	$1,%eax
	je	fstack_getNext_reltrue_86
	movl	$0,%eax
fstack_getNext_reltrue_86	:	
	testl	%eax,%eax
	jnz	fstack_getNext_ifbl_85
	jmp	fstack_getNext_elsebl_85
fstack_getNext_ifbl_85	:	

	movl	%ebp,%eax
	addl	$-8,%eax
	movl	(%eax),%eax
	addl	$21,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$-8,%eax
	movl	(%eax),%eax
	addl	$21,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$-8,%eax
	movl	(%eax),%eax
	addl	$25,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)
	jmp	fstack_getNext_endif_85
fstack_getNext_elsebl_85	:	
fstack_getNext_endif_85	:	

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$1,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$-8,%eax
	movl	(%eax),%eax
	addl	$17,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$5,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$-8,%eax
	movl	(%eax),%eax
	addl	$21,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$9,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$-8,%eax
	movl	(%eax),%eax
	addl	$25,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	%eax,0(%esp)
	movl	12(%ebp),%eax
	movl	%eax,4(%esp)
	movl	$13,8(%esp)
	call	memcpy
	addl	$12,%esp

	movl	$0,%eax
	jmp	fstack_getNext_ret
fstack_getNext_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	fstack_getFilename
.type	fstack_getFilename,@function
fstack_getFilename	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$4,%esp

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$580,%eax
	movl	%eax,0(%esp)
	call	Get_Front_Of_FilenamesList
	addl	$4,%esp
	movl	%eax,-4(%ebp)

fstack_getFilename_while_87	:	
	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	fstack_getFilename_reltrue_88
	movl	$0,%eax
fstack_getFilename_reltrue_88	:	
	testl	%eax,%eax
	jz	fstack_getFilename_endwhile_87

	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	12(%ebp),%ebx
	movl	$1,%eax
	je	fstack_getFilename_reltrue_90
	movl	$0,%eax
fstack_getFilename_reltrue_90	:	
	testl	%eax,%eax
	jnz	fstack_getFilename_ifbl_89
	jmp	fstack_getFilename_elsebl_89
fstack_getFilename_ifbl_89	:	

	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	jmp	fstack_getFilename_ret
fstack_getFilename_elsebl_89	:	
fstack_getFilename_endif_89	:	

	subl	$4,%esp
	movl	-4(%ebp),%eax
	movl	%eax,0(%esp)
	call	Get_Next_In_FilenamesList
	addl	$4,%esp
	movl	%eax,-4(%ebp)
	jmp	fstack_getFilename_while_87
fstack_getFilename_endwhile_87	:	

	movl	$0,%eax
	jmp	fstack_getFilename_ret
fstack_getFilename_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.section	.data
symtab	:	
.string	"../include"
.string	"Could not allocate new memory"
.string	"Found filename [%s] exceeds MAX_FILENAME_LENGTH"
.string	"Could not find system-include for [%s]"
.string	"Filestack exceeded"
.string	"Could not include [%s]"
.string	"No newline at end of file [%s]"
