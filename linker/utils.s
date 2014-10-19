
.section	.text

.globl	Clear_TokensList
.type	Clear_TokensList,@function
Clear_TokensList	:	
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
Clear_TokensList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Is_Member_Of_TokensList
.type	Is_Member_Of_TokensList,@function
Is_Member_Of_TokensList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$4,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	movl	%eax,-4(%ebp)

Is_Member_Of_TokensList_while_0	:	
	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	Is_Member_Of_TokensList_reltrue_1
	movl	$0,%eax
Is_Member_Of_TokensList_reltrue_1	:	
	testl	%eax,%eax
	jz	Is_Member_Of_TokensList_endwhile_0

	movl	-4(%ebp),%ebx
	cmpl	12(%ebp),%ebx
	movl	$1,%eax
	je	Is_Member_Of_TokensList_reltrue_3
	movl	$0,%eax
Is_Member_Of_TokensList_reltrue_3	:	
	testl	%eax,%eax
	jnz	Is_Member_Of_TokensList_ifbl_2
	jmp	Is_Member_Of_TokensList_elsebl_2
Is_Member_Of_TokensList_ifbl_2	:	

	movl	$1,%eax
	jmp	Is_Member_Of_TokensList_ret
Is_Member_Of_TokensList_elsebl_2	:	
Is_Member_Of_TokensList_endif_2	:	

	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$132,%eax
	movl	(%eax),%eax
	movl	%eax,-4(%ebp)
	jmp	Is_Member_Of_TokensList_while_0
Is_Member_Of_TokensList_endwhile_0	:	

	movl	$0,%eax
	jmp	Is_Member_Of_TokensList_ret
Is_Member_Of_TokensList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Get_Front_Of_TokensList
.type	Get_Front_Of_TokensList,@function
Get_Front_Of_TokensList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	jmp	Get_Front_Of_TokensList_ret
Get_Front_Of_TokensList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Get_Back_Of_TokensList
.type	Get_Back_Of_TokensList,@function
Get_Back_Of_TokensList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	(%eax),%eax
	jmp	Get_Back_Of_TokensList_ret
Get_Back_Of_TokensList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Get_Next_In_TokensList
.type	Get_Next_In_TokensList,@function
Get_Next_In_TokensList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$132,%eax
	movl	(%eax),%eax
	jmp	Get_Next_In_TokensList_ret
Get_Next_In_TokensList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Set_Next_In_TokensList
.type	Set_Next_In_TokensList,@function
Set_Next_In_TokensList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$132,%eax
	pushl	%eax
	movl	12(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)
Set_Next_In_TokensList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Get_Prev_In_TokensList
.type	Get_Prev_In_TokensList,@function
Get_Prev_In_TokensList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$128,%eax
	movl	(%eax),%eax
	jmp	Get_Prev_In_TokensList_ret
Get_Prev_In_TokensList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Set_Prev_In_TokensList
.type	Set_Prev_In_TokensList,@function
Set_Prev_In_TokensList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$128,%eax
	pushl	%eax
	movl	12(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)
Set_Prev_In_TokensList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Add_To_Front_Of_TokensList
.type	Add_To_Front_Of_TokensList,@function
Add_To_Front_Of_TokensList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$128,%eax
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
	je	Add_To_Front_Of_TokensList_reltrue_5
	movl	$0,%eax
Add_To_Front_Of_TokensList_reltrue_5	:	
	testl	%eax,%eax
	jnz	Add_To_Front_Of_TokensList_ifbl_4
	jmp	Add_To_Front_Of_TokensList_elsebl_4
Add_To_Front_Of_TokensList_ifbl_4	:	

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
	addl	$132,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)
	jmp	Add_To_Front_Of_TokensList_endif_4
Add_To_Front_Of_TokensList_elsebl_4	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	addl	$128,%eax
	pushl	%eax
	movl	12(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$132,%eax
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
Add_To_Front_Of_TokensList_endif_4	:	
Add_To_Front_Of_TokensList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Add_To_Back_Of_TokensList
.type	Add_To_Back_Of_TokensList,@function
Add_To_Back_Of_TokensList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$132,%eax
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
	je	Add_To_Back_Of_TokensList_reltrue_7
	movl	$0,%eax
Add_To_Back_Of_TokensList_reltrue_7	:	
	testl	%eax,%eax
	jnz	Add_To_Back_Of_TokensList_ifbl_6
	jmp	Add_To_Back_Of_TokensList_elsebl_6
Add_To_Back_Of_TokensList_ifbl_6	:	

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
	addl	$128,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)
	jmp	Add_To_Back_Of_TokensList_endif_6
Add_To_Back_Of_TokensList_elsebl_6	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	(%eax),%eax
	addl	$132,%eax
	pushl	%eax
	movl	12(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$128,%eax
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
Add_To_Back_Of_TokensList_endif_6	:	
Add_To_Back_Of_TokensList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Add_To_TokensList_After
.type	Add_To_TokensList_After,@function
Add_To_TokensList_After	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$132,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$132,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$132,%eax
	pushl	%eax
	movl	12(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)
Add_To_TokensList_After_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Append_TokensList
.type	Append_TokensList,@function
Append_TokensList	:	
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
	jne	Append_TokensList_reltrue_9
	movl	$0,%eax
Append_TokensList_reltrue_9	:	
	testl	%eax,%eax
	jnz	Append_TokensList_ifbl_8
	jmp	Append_TokensList_elsebl_8
Append_TokensList_ifbl_8	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	Append_TokensList_reltrue_11
	movl	$0,%eax
Append_TokensList_reltrue_11	:	
	testl	%eax,%eax
	jnz	Append_TokensList_ifbl_10
	jmp	Append_TokensList_elsebl_10
Append_TokensList_ifbl_10	:	

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
	jmp	Append_TokensList_endif_10
Append_TokensList_elsebl_10	:	

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	addl	$128,%eax
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
	addl	$132,%eax
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
Append_TokensList_endif_10	:	
	jmp	Append_TokensList_endif_8
Append_TokensList_elsebl_8	:	
Append_TokensList_endif_8	:	
Append_TokensList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Remove_From_Front_Of_TokensList
.type	Remove_From_Front_Of_TokensList,@function
Remove_From_Front_Of_TokensList	:	
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
	addl	$132,%eax
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
	je	Remove_From_Front_Of_TokensList_reltrue_13
	movl	$0,%eax
Remove_From_Front_Of_TokensList_reltrue_13	:	
	testl	%eax,%eax
	jnz	Remove_From_Front_Of_TokensList_ifbl_12
	jmp	Remove_From_Front_Of_TokensList_elsebl_12
Remove_From_Front_Of_TokensList_ifbl_12	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)
	jmp	Remove_From_Front_Of_TokensList_endif_12
Remove_From_Front_Of_TokensList_elsebl_12	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	addl	$128,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)
Remove_From_Front_Of_TokensList_endif_12	:	

	movl	-4(%ebp),%eax
	jmp	Remove_From_Front_Of_TokensList_ret
Remove_From_Front_Of_TokensList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Remove_From_TokensList
.type	Remove_From_TokensList,@function
Remove_From_TokensList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$128,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	Remove_From_TokensList_reltrue_15
	movl	$0,%eax
Remove_From_TokensList_reltrue_15	:	
	testl	%eax,%eax
	jnz	Remove_From_TokensList_ifbl_14
	jmp	Remove_From_TokensList_elsebl_14
Remove_From_TokensList_ifbl_14	:	

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$128,%eax
	movl	(%eax),%eax
	addl	$132,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$132,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)
	jmp	Remove_From_TokensList_endif_14
Remove_From_TokensList_elsebl_14	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$132,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)
Remove_From_TokensList_endif_14	:	

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$132,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	Remove_From_TokensList_reltrue_17
	movl	$0,%eax
Remove_From_TokensList_reltrue_17	:	
	testl	%eax,%eax
	jnz	Remove_From_TokensList_ifbl_16
	jmp	Remove_From_TokensList_elsebl_16
Remove_From_TokensList_ifbl_16	:	

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$132,%eax
	movl	(%eax),%eax
	addl	$128,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$128,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)
	jmp	Remove_From_TokensList_endif_16
Remove_From_TokensList_elsebl_16	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$128,%eax
	movl	(%eax),%eax
	popl	%ebx
	movl	%eax,(%ebx)
Remove_From_TokensList_endif_16	:	
Remove_From_TokensList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	Is_TokensList_Empty
.type	Is_TokensList_Empty,@function
Is_TokensList_Empty	:	
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
	je	Is_TokensList_Empty_reltrue_18
	movl	$0,%eax
Is_TokensList_Empty_reltrue_18	:	
	jmp	Is_TokensList_Empty_ret
Is_TokensList_Empty_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	tokensAppendChr
.type	tokensAppendChr,@function
tokensAppendChr	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$4,%esp

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	strlen
	addl	$4,%esp
	movl	%eax,-4(%ebp)

	movl	-4(%ebp),%ebx
	cmpl	$128,%ebx
	movl	$1,%eax
	je	tokensAppendChr_reltrue_20
	movl	$0,%eax
tokensAppendChr_reltrue_20	:	
	testl	%eax,%eax
	jnz	tokensAppendChr_ifbl_19
	jmp	tokensAppendChr_elsebl_19
tokensAppendChr_ifbl_19	:	

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	tokensAppendChr_ret
tokensAppendChr_elsebl_19	:	
tokensAppendChr_endif_19	:	

	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	pushl	%eax
	movb	12(%ebp),%ah
	popl	%ebx
	movb	%ah,(%ebx)

	movl	$0,%eax
	jmp	tokensAppendChr_ret
tokensAppendChr_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	getTokensListSize
.type	getTokensListSize,@function
getTokensListSize	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$8,%esp

	movl	$0,-8(%ebp)

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	Get_Front_Of_TokensList
	addl	$4,%esp
	movl	%eax,-4(%ebp)

getTokensListSize_while_21	:	
	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	getTokensListSize_reltrue_22
	movl	$0,%eax
getTokensListSize_reltrue_22	:	
	testl	%eax,%eax
	jz	getTokensListSize_endwhile_21

	movl	-8(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-8(%ebp)

	subl	$4,%esp
	movl	-4(%ebp),%eax
	movl	%eax,0(%esp)
	call	Get_Next_In_TokensList
	addl	$4,%esp
	movl	%eax,-4(%ebp)
	jmp	getTokensListSize_while_21
getTokensListSize_endwhile_21	:	

	movl	-8(%ebp),%eax
	jmp	getTokensListSize_ret
getTokensListSize_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	lnk_tokensPushBack
.type	lnk_tokensPushBack,@function
lnk_tokensPushBack	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$4,%esp

	subl	$4,%esp
	movl	$136,0(%esp)
	call	malloc
	addl	$4,%esp
	movl	%eax,-4(%ebp)

	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	lnk_tokensPushBack_reltrue_24
	movl	$0,%eax
lnk_tokensPushBack_reltrue_24	:	
	testl	%eax,%eax
	jnz	lnk_tokensPushBack_ifbl_23
	jmp	lnk_tokensPushBack_elsebl_23
lnk_tokensPushBack_ifbl_23	:	

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	lnk_tokensPushBack_ret
lnk_tokensPushBack_elsebl_23	:	
lnk_tokensPushBack_endif_23	:	

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	%eax,0(%esp)
	movl	$0,4(%esp)
	movl	$128,8(%esp)
	call	memset
	addl	$12,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	%eax,0(%esp)
	movl	12(%ebp),%eax
	movl	%eax,4(%esp)
	call	strcpy
	addl	$8,%esp

	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-4(%ebp),%eax
	movl	%eax,4(%esp)
	call	Add_To_Back_Of_TokensList
	addl	$8,%esp

	movl	$0,%eax
	jmp	lnk_tokensPushBack_ret
lnk_tokensPushBack_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	lnk_getKeywordToken
.type	lnk_getKeywordToken,@function
lnk_getKeywordToken	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	subl	$12,%esp
	movl	16(%ebp),%eax
	movl	%eax,0(%esp)
	movl	12(%ebp),%eax
	movl	%eax,4(%esp)
	movl	20(%ebp),%eax
	movl	%eax,8(%esp)
	call	memcpy
	addl	$12,%esp

	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	16(%ebp),%eax
	movl	%eax,4(%esp)
	call	lnk_tokensPushBack
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	lnk_getKeywordToken_reltrue_26
	movl	$0,%eax
lnk_getKeywordToken_reltrue_26	:	
	testl	%eax,%eax
	jnz	lnk_getKeywordToken_ifbl_25
	jmp	lnk_getKeywordToken_elsebl_25
lnk_getKeywordToken_ifbl_25	:	

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	lnk_getKeywordToken_ret
lnk_getKeywordToken_elsebl_25	:	
lnk_getKeywordToken_endif_25	:	

	movl	$0,%eax
	jmp	lnk_getKeywordToken_ret
lnk_getKeywordToken_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	tokenizeString
.type	tokenizeString,@function
tokenizeString	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$142,%esp

	subl	$4,%esp
	movl	12(%ebp),%eax
	movl	%eax,0(%esp)
	call	strlen
	addl	$4,%esp
	movl	%eax,-4(%ebp)

	movl	$0,-8(%ebp)

tokenizeString_while_27	:	
	movl	-8(%ebp),%ebx
	cmpl	-4(%ebp),%ebx
	movl	$1,%eax
	jl	tokenizeString_reltrue_28
	movl	$0,%eax
tokenizeString_reltrue_28	:	
	testl	%eax,%eax
	jz	tokenizeString_endwhile_27

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-138,%eax
	movl	%eax,0(%esp)
	movl	$0,4(%esp)
	movl	$128,8(%esp)
	call	memset
	addl	$12,%esp

	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,%ebx
	cmpl	$35,%ebx
	movl	$1,%eax
	je	tokenizeString_reltrue_30
	movl	$0,%eax
tokenizeString_reltrue_30	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_29
	jmp	tokenizeString_elsebl_29
tokenizeString_ifbl_29	:	
	jmp	tokenizeString_endwhile_27
tokenizeString_elsebl_29	:	
tokenizeString_endif_29	:	

	subl	$4,%esp
	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,0(%esp)
	call	isblank
	addl	$4,%esp
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_31
	jmp	tokenizeString_elsebl_31
tokenizeString_ifbl_31	:	

tokenizeString_while_32	:	
	subl	$4,%esp
	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,0(%esp)
	call	isblank
	addl	$4,%esp
	testl	%eax,%eax
	jz	tokenizeString_endwhile_32

	movl	-8(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-8(%ebp)
	jmp	tokenizeString_while_32
tokenizeString_endwhile_32	:	
	jmp	tokenizeString_while_27
tokenizeString_elsebl_31	:	
tokenizeString_endif_31	:	

	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movl	%eax,-142(%ebp)

	subl	$12,%esp
	movl	-142(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+0,4(%esp)
	movl	$6,8(%esp)
	call	strncmp
	addl	$12,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	tokenizeString_reltrue_34
	movl	$0,%eax
tokenizeString_reltrue_34	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_33
	jmp	tokenizeString_elsebl_33
tokenizeString_ifbl_33	:	

	subl	$16,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-142(%ebp),%eax
	movl	%eax,4(%esp)
	movl	%ebp,%eax
	addl	$-138,%eax
	movl	%eax,8(%esp)
	movl	$6,12(%esp)
	call	lnk_getKeywordToken
	addl	$16,%esp

	movl	-8(%ebp),%ebx
	addl	$6,%ebx
	movl	%ebx,%eax
	movl	%eax,-8(%ebp)
	jmp	tokenizeString_while_27
tokenizeString_elsebl_33	:	
tokenizeString_endif_33	:	

	subl	$12,%esp
	movl	-142(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+7,4(%esp)
	movl	$5,8(%esp)
	call	strncmp
	addl	$12,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	tokenizeString_reltrue_36
	movl	$0,%eax
tokenizeString_reltrue_36	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_35
	jmp	tokenizeString_elsebl_35
tokenizeString_ifbl_35	:	

	subl	$16,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-142(%ebp),%eax
	movl	%eax,4(%esp)
	movl	%ebp,%eax
	addl	$-138,%eax
	movl	%eax,8(%esp)
	movl	$5,12(%esp)
	call	lnk_getKeywordToken
	addl	$16,%esp

	movl	-8(%ebp),%ebx
	addl	$5,%ebx
	movl	%ebx,%eax
	movl	%eax,-8(%ebp)
	jmp	tokenizeString_while_27
tokenizeString_elsebl_35	:	
tokenizeString_endif_35	:	

	subl	$12,%esp
	movl	-142(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+13,4(%esp)
	movl	$8,8(%esp)
	call	strncmp
	addl	$12,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	tokenizeString_reltrue_38
	movl	$0,%eax
tokenizeString_reltrue_38	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_37
	jmp	tokenizeString_elsebl_37
tokenizeString_ifbl_37	:	

	subl	$16,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-142(%ebp),%eax
	movl	%eax,4(%esp)
	movl	%ebp,%eax
	addl	$-138,%eax
	movl	%eax,8(%esp)
	movl	$8,12(%esp)
	call	lnk_getKeywordToken
	addl	$16,%esp

	movl	-8(%ebp),%ebx
	addl	$8,%ebx
	movl	%ebx,%eax
	movl	%eax,-8(%ebp)
	jmp	tokenizeString_while_27
tokenizeString_elsebl_37	:	
tokenizeString_endif_37	:	

	subl	$12,%esp
	movl	-142(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+22,4(%esp)
	movl	$5,8(%esp)
	call	strncmp
	addl	$12,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	tokenizeString_reltrue_40
	movl	$0,%eax
tokenizeString_reltrue_40	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_39
	jmp	tokenizeString_elsebl_39
tokenizeString_ifbl_39	:	

	subl	$16,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-142(%ebp),%eax
	movl	%eax,4(%esp)
	movl	%ebp,%eax
	addl	$-138,%eax
	movl	%eax,8(%esp)
	movl	$5,12(%esp)
	call	lnk_getKeywordToken
	addl	$16,%esp

	movl	-8(%ebp),%ebx
	addl	$5,%ebx
	movl	%ebx,%eax
	movl	%eax,-8(%ebp)
	jmp	tokenizeString_while_27
tokenizeString_elsebl_39	:	
tokenizeString_endif_39	:	

	subl	$12,%esp
	movl	-142(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+28,4(%esp)
	movl	$5,8(%esp)
	call	strncmp
	addl	$12,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	tokenizeString_reltrue_42
	movl	$0,%eax
tokenizeString_reltrue_42	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_41
	jmp	tokenizeString_elsebl_41
tokenizeString_ifbl_41	:	

	subl	$16,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-142(%ebp),%eax
	movl	%eax,4(%esp)
	movl	%ebp,%eax
	addl	$-138,%eax
	movl	%eax,8(%esp)
	movl	$5,12(%esp)
	call	lnk_getKeywordToken
	addl	$16,%esp

	movl	-8(%ebp),%ebx
	addl	$5,%ebx
	movl	%ebx,%eax
	movl	%eax,-8(%ebp)
	jmp	tokenizeString_while_27
tokenizeString_elsebl_41	:	
tokenizeString_endif_41	:	

	subl	$12,%esp
	movl	-142(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+34,4(%esp)
	movl	$7,8(%esp)
	call	strncmp
	addl	$12,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	tokenizeString_reltrue_44
	movl	$0,%eax
tokenizeString_reltrue_44	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_43
	jmp	tokenizeString_elsebl_43
tokenizeString_ifbl_43	:	

	subl	$16,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-142(%ebp),%eax
	movl	%eax,4(%esp)
	movl	%ebp,%eax
	addl	$-138,%eax
	movl	%eax,8(%esp)
	movl	$7,12(%esp)
	call	lnk_getKeywordToken
	addl	$16,%esp

	movl	-8(%ebp),%ebx
	addl	$7,%ebx
	movl	%ebx,%eax
	movl	%eax,-8(%ebp)
	jmp	tokenizeString_while_27
tokenizeString_elsebl_43	:	
tokenizeString_endif_43	:	

	subl	$12,%esp
	movl	-142(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+42,4(%esp)
	movl	$5,8(%esp)
	call	strncmp
	addl	$12,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	tokenizeString_reltrue_46
	movl	$0,%eax
tokenizeString_reltrue_46	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_45
	jmp	tokenizeString_elsebl_45
tokenizeString_ifbl_45	:	

	subl	$16,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-142(%ebp),%eax
	movl	%eax,4(%esp)
	movl	%ebp,%eax
	addl	$-138,%eax
	movl	%eax,8(%esp)
	movl	$5,12(%esp)
	call	lnk_getKeywordToken
	addl	$16,%esp

	movl	-8(%ebp),%ebx
	addl	$5,%ebx
	movl	%ebx,%eax
	movl	%eax,-8(%ebp)
	jmp	tokenizeString_while_27
tokenizeString_elsebl_45	:	
tokenizeString_endif_45	:	

	subl	$12,%esp
	movl	-142(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+48,4(%esp)
	movl	$5,8(%esp)
	call	strncmp
	addl	$12,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	tokenizeString_reltrue_48
	movl	$0,%eax
tokenizeString_reltrue_48	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_47
	jmp	tokenizeString_elsebl_47
tokenizeString_ifbl_47	:	

	subl	$16,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-142(%ebp),%eax
	movl	%eax,4(%esp)
	movl	%ebp,%eax
	addl	$-138,%eax
	movl	%eax,8(%esp)
	movl	$5,12(%esp)
	call	lnk_getKeywordToken
	addl	$16,%esp

	movl	-8(%ebp),%ebx
	addl	$5,%ebx
	movl	%ebx,%eax
	movl	%eax,-8(%ebp)
	jmp	tokenizeString_while_27
tokenizeString_elsebl_47	:	
tokenizeString_endif_47	:	

	subl	$12,%esp
	movl	-142(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+54,4(%esp)
	movl	$5,8(%esp)
	call	strncmp
	addl	$12,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	tokenizeString_reltrue_50
	movl	$0,%eax
tokenizeString_reltrue_50	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_49
	jmp	tokenizeString_elsebl_49
tokenizeString_ifbl_49	:	

	subl	$16,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-142(%ebp),%eax
	movl	%eax,4(%esp)
	movl	%ebp,%eax
	addl	$-138,%eax
	movl	%eax,8(%esp)
	movl	$5,12(%esp)
	call	lnk_getKeywordToken
	addl	$16,%esp

	movl	-8(%ebp),%ebx
	addl	$5,%ebx
	movl	%ebx,%eax
	movl	%eax,-8(%ebp)
	jmp	tokenizeString_while_27
tokenizeString_elsebl_49	:	
tokenizeString_endif_49	:	

	subl	$12,%esp
	movl	-142(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+60,4(%esp)
	movl	$5,8(%esp)
	call	strncmp
	addl	$12,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	tokenizeString_reltrue_52
	movl	$0,%eax
tokenizeString_reltrue_52	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_51
	jmp	tokenizeString_elsebl_51
tokenizeString_ifbl_51	:	

	subl	$16,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-142(%ebp),%eax
	movl	%eax,4(%esp)
	movl	%ebp,%eax
	addl	$-138,%eax
	movl	%eax,8(%esp)
	movl	$5,12(%esp)
	call	lnk_getKeywordToken
	addl	$16,%esp

	movl	-8(%ebp),%ebx
	addl	$5,%ebx
	movl	%ebx,%eax
	movl	%eax,-8(%ebp)
	jmp	tokenizeString_while_27
tokenizeString_elsebl_51	:	
tokenizeString_endif_51	:	

	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,%ebx
	cmpl	$34,%ebx
	movl	$1,%eax
	je	tokenizeString_reltrue_55
	movl	$0,%eax
tokenizeString_reltrue_55	:	
	testl	%eax,%eax
	jnz	tokenizeString_logexprtrue_54
	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,%ebx
	cmpl	$39,%ebx
	movl	$1,%eax
	je	tokenizeString_reltrue_56
	movl	$0,%eax
tokenizeString_reltrue_56	:	
	testl	%eax,%eax
	jnz	tokenizeString_logexprtrue_54
	movl	$0,%eax
	jmp	tokenizeString_logexprfalse_54
tokenizeString_logexprtrue_54	:	
	movl	$1,%eax
tokenizeString_logexprfalse_54	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_53
	jmp	tokenizeString_elsebl_53
tokenizeString_ifbl_53	:	

	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movb	%al,-9(%ebp)

	movb	$0,-10(%ebp)

tokenizeString_while_57	:	
	movl	$1,%eax
	testl	%eax,%eax
	jz	tokenizeString_endwhile_57

	subl	$5,%esp
	movl	%ebp,%eax
	addl	$-138,%eax
	movl	%eax,0(%esp)
	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movb	%al,4(%esp)
	call	tokensAppendChr
	addl	$5,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	tokenizeString_reltrue_59
	movl	$0,%eax
tokenizeString_reltrue_59	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_58
	jmp	tokenizeString_elsebl_58
tokenizeString_ifbl_58	:	

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	tokenizeString_ret
tokenizeString_elsebl_58	:	
tokenizeString_endif_58	:	

	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movb	%al,-10(%ebp)

	movl	-8(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-8(%ebp)

	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	pushl	%eax
	movsbl	-9(%ebp),%eax
	popl	%ebx
	cmpl	%eax,%ebx
	movl	$1,%eax
	jne	tokenizeString_reltrue_64
	movl	$0,%eax
tokenizeString_reltrue_64	:	
	testl	%eax,%eax
	jnz	tokenizeString_logexprtrue_63
	movsbl	-10(%ebp),%eax
	movl	%eax,%ebx
	cmpl	$92,%ebx
	movl	$1,%eax
	je	tokenizeString_reltrue_65
	movl	$0,%eax
tokenizeString_reltrue_65	:	
	testl	%eax,%eax
	jnz	tokenizeString_logexprtrue_63
	movl	$0,%eax
	jmp	tokenizeString_logexprfalse_63
tokenizeString_logexprtrue_63	:	
	movl	$1,%eax
tokenizeString_logexprfalse_63	:	
	testl	%eax,%eax
	jz	tokenizeString_logtermfalse_62
	movl	-8(%ebp),%ebx
	cmpl	-4(%ebp),%ebx
	movl	$1,%eax
	jl	tokenizeString_reltrue_66
	movl	$0,%eax
tokenizeString_reltrue_66	:	
	testl	%eax,%eax
	jz	tokenizeString_logtermfalse_62
	movl	$1,%eax
	jmp	tokenizeString_logtermtrue_62
tokenizeString_logtermfalse_62	:	
	movl	$0,%eax
tokenizeString_logtermtrue_62	:	
	testl	%eax,%eax
	movl	$1,%eax
	jz	tokenizeString_logfactfalse_61
	movl	$0,%eax
tokenizeString_logfactfalse_61	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_60
	jmp	tokenizeString_elsebl_60
tokenizeString_ifbl_60	:	

	subl	$5,%esp
	movl	%ebp,%eax
	addl	$-138,%eax
	movl	%eax,0(%esp)
	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movb	%al,4(%esp)
	call	tokensAppendChr
	addl	$5,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	tokenizeString_reltrue_68
	movl	$0,%eax
tokenizeString_reltrue_68	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_67
	jmp	tokenizeString_elsebl_67
tokenizeString_ifbl_67	:	

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	tokenizeString_ret
tokenizeString_elsebl_67	:	
tokenizeString_endif_67	:	
	jmp	tokenizeString_endwhile_57
tokenizeString_elsebl_60	:	
tokenizeString_endif_60	:	
	jmp	tokenizeString_while_57
tokenizeString_endwhile_57	:	

	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-138,%eax
	movl	%eax,4(%esp)
	call	lnk_tokensPushBack
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	tokenizeString_reltrue_70
	movl	$0,%eax
tokenizeString_reltrue_70	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_69
	jmp	tokenizeString_elsebl_69
tokenizeString_ifbl_69	:	

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	tokenizeString_ret
tokenizeString_elsebl_69	:	
tokenizeString_endif_69	:	

	movl	-8(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-8(%ebp)
	jmp	tokenizeString_while_27
tokenizeString_elsebl_53	:	
tokenizeString_endif_53	:	

	subl	$4,%esp
	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,0(%esp)
	call	isalpha
	addl	$4,%esp
	testl	%eax,%eax
	jnz	tokenizeString_logexprtrue_72
	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,%ebx
	cmpl	$95,%ebx
	movl	$1,%eax
	je	tokenizeString_reltrue_73
	movl	$0,%eax
tokenizeString_reltrue_73	:	
	testl	%eax,%eax
	jnz	tokenizeString_logexprtrue_72
	movl	$0,%eax
	jmp	tokenizeString_logexprfalse_72
tokenizeString_logexprtrue_72	:	
	movl	$1,%eax
tokenizeString_logexprfalse_72	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_71
	jmp	tokenizeString_elsebl_71
tokenizeString_ifbl_71	:	

tokenizeString_while_74	:	
	movl	$1,%eax
	testl	%eax,%eax
	jz	tokenizeString_endwhile_74

	subl	$5,%esp
	movl	%ebp,%eax
	addl	$-138,%eax
	movl	%eax,0(%esp)
	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movb	%al,4(%esp)
	call	tokensAppendChr
	addl	$5,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	tokenizeString_reltrue_76
	movl	$0,%eax
tokenizeString_reltrue_76	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_75
	jmp	tokenizeString_elsebl_75
tokenizeString_ifbl_75	:	

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	tokenizeString_ret
tokenizeString_elsebl_75	:	
tokenizeString_endif_75	:	

	movl	-8(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-8(%ebp)

	subl	$4,%esp
	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,0(%esp)
	call	isalnum
	addl	$4,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	tokenizeString_reltrue_79
	movl	$0,%eax
tokenizeString_reltrue_79	:	
	testl	%eax,%eax
	jz	tokenizeString_logtermfalse_78
	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,%ebx
	cmpl	$95,%ebx
	movl	$1,%eax
	jne	tokenizeString_reltrue_80
	movl	$0,%eax
tokenizeString_reltrue_80	:	
	testl	%eax,%eax
	jz	tokenizeString_logtermfalse_78
	movl	$1,%eax
	jmp	tokenizeString_logtermtrue_78
tokenizeString_logtermfalse_78	:	
	movl	$0,%eax
tokenizeString_logtermtrue_78	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_77
	jmp	tokenizeString_elsebl_77
tokenizeString_ifbl_77	:	
	jmp	tokenizeString_endwhile_74
tokenizeString_elsebl_77	:	
tokenizeString_endif_77	:	
	jmp	tokenizeString_while_74
tokenizeString_endwhile_74	:	

	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-138,%eax
	movl	%eax,4(%esp)
	call	lnk_tokensPushBack
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	tokenizeString_reltrue_82
	movl	$0,%eax
tokenizeString_reltrue_82	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_81
	jmp	tokenizeString_elsebl_81
tokenizeString_ifbl_81	:	

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	tokenizeString_ret
tokenizeString_elsebl_81	:	
tokenizeString_endif_81	:	
	jmp	tokenizeString_while_27
tokenizeString_elsebl_71	:	
tokenizeString_endif_71	:	

	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,%ebx
	cmpl	$45,%ebx
	movl	$1,%eax
	je	tokenizeString_reltrue_85
	movl	$0,%eax
tokenizeString_reltrue_85	:	
	testl	%eax,%eax
	jnz	tokenizeString_logexprtrue_84
	subl	$4,%esp
	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,0(%esp)
	call	isdigit
	addl	$4,%esp
	testl	%eax,%eax
	jnz	tokenizeString_logexprtrue_84
	movl	$0,%eax
	jmp	tokenizeString_logexprfalse_84
tokenizeString_logexprtrue_84	:	
	movl	$1,%eax
tokenizeString_logexprfalse_84	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_83
	jmp	tokenizeString_elsebl_83
tokenizeString_ifbl_83	:	

tokenizeString_while_86	:	
	movl	$1,%eax
	testl	%eax,%eax
	jz	tokenizeString_endwhile_86

	subl	$5,%esp
	movl	%ebp,%eax
	addl	$-138,%eax
	movl	%eax,0(%esp)
	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movb	%al,4(%esp)
	call	tokensAppendChr
	addl	$5,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	tokenizeString_reltrue_88
	movl	$0,%eax
tokenizeString_reltrue_88	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_87
	jmp	tokenizeString_elsebl_87
tokenizeString_ifbl_87	:	

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	tokenizeString_ret
tokenizeString_elsebl_87	:	
tokenizeString_endif_87	:	

	movl	-8(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-8(%ebp)

	subl	$4,%esp
	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,0(%esp)
	call	isdigit
	addl	$4,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	tokenizeString_reltrue_90
	movl	$0,%eax
tokenizeString_reltrue_90	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_89
	jmp	tokenizeString_elsebl_89
tokenizeString_ifbl_89	:	
	jmp	tokenizeString_endwhile_86
tokenizeString_elsebl_89	:	
tokenizeString_endif_89	:	
	jmp	tokenizeString_while_86
tokenizeString_endwhile_86	:	

	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-138,%eax
	movl	%eax,4(%esp)
	call	lnk_tokensPushBack
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	tokenizeString_reltrue_92
	movl	$0,%eax
tokenizeString_reltrue_92	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_91
	jmp	tokenizeString_elsebl_91
tokenizeString_ifbl_91	:	

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	tokenizeString_ret
tokenizeString_elsebl_91	:	
tokenizeString_endif_91	:	
	jmp	tokenizeString_while_27
tokenizeString_elsebl_83	:	
tokenizeString_endif_83	:	

	subl	$5,%esp
	movl	%ebp,%eax
	addl	$-138,%eax
	movl	%eax,0(%esp)
	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movb	%al,4(%esp)
	call	tokensAppendChr
	addl	$5,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	tokenizeString_reltrue_94
	movl	$0,%eax
tokenizeString_reltrue_94	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_93
	jmp	tokenizeString_elsebl_93
tokenizeString_ifbl_93	:	

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	tokenizeString_ret
tokenizeString_elsebl_93	:	
tokenizeString_endif_93	:	

	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$-138,%eax
	movl	%eax,4(%esp)
	call	lnk_tokensPushBack
	addl	$8,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	tokenizeString_reltrue_96
	movl	$0,%eax
tokenizeString_reltrue_96	:	
	testl	%eax,%eax
	jnz	tokenizeString_ifbl_95
	jmp	tokenizeString_elsebl_95
tokenizeString_ifbl_95	:	

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	tokenizeString_ret
tokenizeString_elsebl_95	:	
tokenizeString_endif_95	:	

	movl	-8(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-8(%ebp)
	jmp	tokenizeString_while_27
tokenizeString_endwhile_27	:	

	movl	$0,%eax
	jmp	tokenizeString_ret
tokenizeString_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	freeTokensList
.type	freeTokensList,@function
freeTokensList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$8,%esp

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	Get_Front_Of_TokensList
	addl	$4,%esp
	movl	%eax,-4(%ebp)

freeTokensList_while_97	:	
	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	freeTokensList_reltrue_98
	movl	$0,%eax
freeTokensList_reltrue_98	:	
	testl	%eax,%eax
	jz	freeTokensList_endwhile_97

	subl	$4,%esp
	movl	-4(%ebp),%eax
	movl	%eax,0(%esp)
	call	Get_Next_In_TokensList
	addl	$4,%esp
	movl	%eax,-8(%ebp)

	subl	$4,%esp
	movl	-4(%ebp),%eax
	movl	%eax,0(%esp)
	call	free
	addl	$4,%esp

	movl	-8(%ebp),%eax
	movl	%eax,-4(%ebp)
	jmp	freeTokensList_while_97
freeTokensList_endwhile_97	:	
freeTokensList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	printTokensList
.type	printTokensList,@function
printTokensList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$4,%esp

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	Get_Front_Of_TokensList
	addl	$4,%esp
	movl	%eax,-4(%ebp)

printTokensList_while_99	:	
	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	printTokensList_reltrue_100
	movl	$0,%eax
printTokensList_reltrue_100	:	
	testl	%eax,%eax
	jz	printTokensList_endwhile_99

	subl	$8,%esp
	movl	$symtab+66,0(%esp)
	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$4,%esp
	movl	-4(%ebp),%eax
	movl	%eax,0(%esp)
	call	Get_Next_In_TokensList
	addl	$4,%esp
	movl	%eax,-4(%ebp)
	jmp	printTokensList_while_99
printTokensList_endwhile_99	:	
printTokensList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	readLine
.type	readLine,@function
readLine	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$4,%esp

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$16,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	%eax,0(%esp)
	movl	$0,4(%esp)
	movl	$512,8(%esp)
	call	memset
	addl	$12,%esp

	movl	%ebp,%eax
	addl	$16,%eax
	movl	(%eax),%eax
	addl	$516,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)

	movl	%ebp,%eax
	addl	$16,%eax
	movl	(%eax),%eax
	addl	$512,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)

	movl	$0,-4(%ebp)

readLine_while_101	:	
	movl	-4(%ebp),%ebx
	cmpl	$512,%ebx
	movl	$1,%eax
	jl	readLine_reltrue_102
	movl	$0,%eax
readLine_reltrue_102	:	
	testl	%eax,%eax
	jz	readLine_endwhile_101

	subl	$12,%esp
	movl	12(%ebp),%eax
	movl	%eax,0(%esp)
	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$16,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	addl	%esi,%eax
	movl	%eax,4(%esp)
	movl	$1,8(%esp)
	call	read
	addl	$12,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jle	readLine_reltrue_104
	movl	$0,%eax
readLine_reltrue_104	:	
	testl	%eax,%eax
	jnz	readLine_ifbl_103
	jmp	readLine_elsebl_103
readLine_ifbl_103	:	

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	readLine_ret
readLine_elsebl_103	:	
readLine_endif_103	:	

	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$16,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,%ebx
	cmpl	$10,%ebx
	movl	$1,%eax
	je	readLine_reltrue_106
	movl	$0,%eax
readLine_reltrue_106	:	
	testl	%eax,%eax
	jnz	readLine_ifbl_105
	jmp	readLine_elsebl_105
readLine_ifbl_105	:	

	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$16,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	addl	%esi,%eax
	movl	%eax,%ebx
	movb	$0,(%ebx)
	jmp	readLine_endwhile_101
readLine_elsebl_105	:	
readLine_endif_105	:	

	movl	-4(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)
	jmp	readLine_while_101
readLine_endwhile_101	:	

	movl	-4(%ebp),%ebx
	cmpl	$512,%ebx
	movl	$1,%eax
	je	readLine_reltrue_108
	movl	$0,%eax
readLine_reltrue_108	:	
	testl	%eax,%eax
	jnz	readLine_ifbl_107
	jmp	readLine_elsebl_107
readLine_ifbl_107	:	

	subl	$8,%esp
	movl	$symtab+70,0(%esp)
	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$16,%eax
	movl	(%eax),%eax
	addl	$536,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	getFilename
	addl	$8,%esp
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$8,%esp
	movl	$symtab+110,0(%esp)
	movl	%ebp,%eax
	addl	$16,%eax
	movl	(%eax),%eax
	addl	$540,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	readLine_ret
readLine_elsebl_107	:	
readLine_endif_107	:	

	movl	%ebp,%eax
	addl	$16,%eax
	movl	(%eax),%eax
	addl	$512,%eax
	pushl	%eax
	movl	-4(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	$0,%eax
	jmp	readLine_ret
readLine_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	appendOutput
.type	appendOutput,@function
appendOutput	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$4,%esp

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	appendOutput_reltrue_110
	movl	$0,%eax
appendOutput_reltrue_110	:	
	testl	%eax,%eax
	jnz	appendOutput_ifbl_109
	jmp	appendOutput_elsebl_109
appendOutput_ifbl_109	:	

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	jmp	appendOutput_ret
appendOutput_elsebl_109	:	
appendOutput_endif_109	:	

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	(%eax),%eax
	movl	%eax,0(%esp)
	movl	12(%ebp),%eax
	movl	%eax,4(%esp)
	subl	$4,%esp
	movl	12(%ebp),%eax
	movl	%eax,0(%esp)
	call	strlen
	addl	$4,%esp
	movl	%eax,8(%esp)
	call	write
	addl	$12,%esp
	movl	%eax,-4(%ebp)

	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jl	appendOutput_reltrue_112
	movl	$0,%eax
appendOutput_reltrue_112	:	
	testl	%eax,%eax
	jnz	appendOutput_ifbl_111
	jmp	appendOutput_elsebl_111
appendOutput_ifbl_111	:	

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	pushl	%eax
	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	movl	%eax,(%ebx)

	subl	$4,%esp
	movl	$symtab+126,0(%esp)
	call	puts
	addl	$4,%esp

	movl	-4(%ebp),%eax
	jmp	appendOutput_ret
appendOutput_elsebl_111	:	
appendOutput_endif_111	:	

	movl	$0,%eax
	jmp	appendOutput_ret
appendOutput_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	convertAddr
.type	convertAddr,@function
convertAddr	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

	subl	$12,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$symtab+199,4(%esp)
	movl	12(%ebp),%eax
	movl	%eax,8(%esp)
	call	sprintf
	addl	$12,%esp

	movl	8(%ebp),%eax
	jmp	convertAddr_ret
convertAddr_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	freeMarkersList
.type	freeMarkersList,@function
freeMarkersList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$8,%esp

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	Get_Front_Of_MarkersList
	addl	$4,%esp
	movl	%eax,-4(%ebp)

freeMarkersList_while_113	:	
	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	freeMarkersList_reltrue_114
	movl	$0,%eax
freeMarkersList_reltrue_114	:	
	testl	%eax,%eax
	jz	freeMarkersList_endwhile_113

	subl	$4,%esp
	movl	-4(%ebp),%eax
	movl	%eax,0(%esp)
	call	Get_Next_In_MarkersList
	addl	$4,%esp
	movl	%eax,-8(%ebp)

	subl	$4,%esp
	movl	-4(%ebp),%eax
	movl	%eax,0(%esp)
	call	free
	addl	$4,%esp

	movl	-8(%ebp),%eax
	movl	%eax,-4(%ebp)
	jmp	freeMarkersList_while_113
freeMarkersList_endwhile_113	:	
freeMarkersList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	freeLinesList
.type	freeLinesList,@function
freeLinesList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$8,%esp

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	Get_Front_Of_LinesList
	addl	$4,%esp
	movl	%eax,-4(%ebp)

freeLinesList_while_115	:	
	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	freeLinesList_reltrue_116
	movl	$0,%eax
freeLinesList_reltrue_116	:	
	testl	%eax,%eax
	jz	freeLinesList_endwhile_115

	subl	$4,%esp
	movl	-4(%ebp),%eax
	movl	%eax,0(%esp)
	call	Get_Next_In_LinesList
	addl	$4,%esp
	movl	%eax,-8(%ebp)

	subl	$4,%esp
	movl	-4(%ebp),%eax
	movl	%eax,0(%esp)
	call	free
	addl	$4,%esp

	movl	-8(%ebp),%eax
	movl	%eax,-4(%ebp)
	jmp	freeLinesList_while_115
freeLinesList_endwhile_115	:	
freeLinesList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	freeFilesList
.type	freeFilesList,@function
freeFilesList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$8,%esp

	subl	$4,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	call	Get_Front_Of_FilesList
	addl	$4,%esp
	movl	%eax,-4(%ebp)

freeFilesList_while_117	:	
	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	freeFilesList_reltrue_118
	movl	$0,%eax
freeFilesList_reltrue_118	:	
	testl	%eax,%eax
	jz	freeFilesList_endwhile_117

	subl	$4,%esp
	movl	-4(%ebp),%eax
	movl	%eax,0(%esp)
	call	Get_Next_In_FilesList
	addl	$4,%esp
	movl	%eax,-8(%ebp)

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$264,%eax
	movl	%eax,0(%esp)
	call	freeMarkersList
	addl	$4,%esp

	subl	$4,%esp
	movl	-4(%ebp),%eax
	movl	%eax,0(%esp)
	call	free
	addl	$4,%esp

	movl	-8(%ebp),%eax
	movl	%eax,-4(%ebp)
	jmp	freeFilesList_while_117
freeFilesList_endwhile_117	:	
freeFilesList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	addFileToList
.type	addFileToList,@function
addFileToList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$12,%esp

	subl	$4,%esp
	movl	$280,0(%esp)
	call	malloc
	addl	$4,%esp
	movl	%eax,-12(%ebp)

	movl	-12(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	addFileToList_reltrue_120
	movl	$0,%eax
addFileToList_reltrue_120	:	
	testl	%eax,%eax
	jnz	addFileToList_ifbl_119
	jmp	addFileToList_elsebl_119
addFileToList_ifbl_119	:	

	movl	$0,%eax
	jmp	addFileToList_ret
addFileToList_elsebl_119	:	
addFileToList_endif_119	:	

	subl	$12,%esp
	movl	%ebp,%eax
	addl	$-12,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	%eax,0(%esp)
	movl	$0,4(%esp)
	movl	$256,8(%esp)
	call	memset
	addl	$12,%esp

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$-12,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	movl	%eax,0(%esp)
	movl	12(%ebp),%eax
	movl	%eax,4(%esp)
	call	strcpy
	addl	$8,%esp

	movl	$0,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$24,%eax
	movl	%eax,0(%esp)
	call	Get_Back_Of_FilesList
	addl	$4,%esp
	movl	%eax,-8(%ebp)

	movl	-8(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	addFileToList_reltrue_122
	movl	$0,%eax
addFileToList_reltrue_122	:	
	testl	%eax,%eax
	jnz	addFileToList_ifbl_121
	jmp	addFileToList_elsebl_121
addFileToList_ifbl_121	:	

	movl	%ebp,%eax
	addl	$-8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	movl	%eax,-4(%ebp)
	jmp	addFileToList_endif_121
addFileToList_elsebl_121	:	
addFileToList_endif_121	:	

	movl	%ebp,%eax
	addl	$-12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	pushl	%eax
	movl	-4(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	movl	%eax,(%ebx)

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$24,%eax
	movl	%eax,0(%esp)
	movl	-12(%ebp),%eax
	movl	%eax,4(%esp)
	call	Add_To_Back_Of_FilesList
	addl	$8,%esp

	movl	-12(%ebp),%eax
	jmp	addFileToList_ret
addFileToList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	getFileOfList
.type	getFileOfList,@function
getFileOfList	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$4,%esp

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$24,%eax
	movl	%eax,0(%esp)
	call	Get_Front_Of_FilesList
	addl	$4,%esp
	movl	%eax,-4(%ebp)

getFileOfList_while_123	:	
	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	getFileOfList_reltrue_124
	movl	$0,%eax
getFileOfList_reltrue_124	:	
	testl	%eax,%eax
	jz	getFileOfList_endwhile_123

	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	12(%ebp),%ebx
	movl	$1,%eax
	je	getFileOfList_reltrue_126
	movl	$0,%eax
getFileOfList_reltrue_126	:	
	testl	%eax,%eax
	jnz	getFileOfList_ifbl_125
	jmp	getFileOfList_elsebl_125
getFileOfList_ifbl_125	:	

	movl	-4(%ebp),%eax
	jmp	getFileOfList_ret
getFileOfList_elsebl_125	:	
getFileOfList_endif_125	:	

	subl	$4,%esp
	movl	-4(%ebp),%eax
	movl	%eax,0(%esp)
	call	Get_Next_In_FilesList
	addl	$4,%esp
	movl	%eax,-4(%ebp)
	jmp	getFileOfList_while_123
getFileOfList_endwhile_123	:	

	movl	$0,%eax
	jmp	getFileOfList_ret
getFileOfList_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	getFilename
.type	getFilename,@function
getFilename	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$4,%esp

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$24,%eax
	movl	%eax,0(%esp)
	call	Get_Front_Of_FilesList
	addl	$4,%esp
	movl	%eax,-4(%ebp)

getFilename_while_127	:	
	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	getFilename_reltrue_128
	movl	$0,%eax
getFilename_reltrue_128	:	
	testl	%eax,%eax
	jz	getFilename_endwhile_127

	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	cmpl	12(%ebp),%ebx
	movl	$1,%eax
	je	getFilename_reltrue_130
	movl	$0,%eax
getFilename_reltrue_130	:	
	testl	%eax,%eax
	jnz	getFilename_ifbl_129
	jmp	getFilename_elsebl_129
getFilename_ifbl_129	:	

	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$4,%eax
	jmp	getFilename_ret
getFilename_elsebl_129	:	
getFilename_endif_129	:	

	subl	$4,%esp
	movl	-4(%ebp),%eax
	movl	%eax,0(%esp)
	call	Get_Next_In_FilesList
	addl	$4,%esp
	movl	%eax,-4(%ebp)
	jmp	getFilename_while_127
getFilename_endwhile_127	:	

	movl	$0,%eax
	jmp	getFilename_ret
getFilename_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	lnk_disposeWhitespace
.type	lnk_disposeWhitespace,@function
lnk_disposeWhitespace	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$0,%esp

lnk_disposeWhitespace_while_131	:	
	subl	$4,%esp
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$516,%eax
	movl	(%eax),%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,0(%esp)
	call	isblank
	addl	$4,%esp
	movl	%eax,%ebx
	cmpl	$1,%ebx
	movl	$1,%eax
	je	lnk_disposeWhitespace_reltrue_132
	movl	$0,%eax
lnk_disposeWhitespace_reltrue_132	:	
	testl	%eax,%eax
	jz	lnk_disposeWhitespace_endwhile_131

	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$516,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$516,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	movl	%eax,(%ebx)
	jmp	lnk_disposeWhitespace_while_131
lnk_disposeWhitespace_endwhile_131	:	
lnk_disposeWhitespace_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	disposeComments
.type	disposeComments,@function
disposeComments	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$4,%esp

	movl	$0,-4(%ebp)

disposeComments_while_133	:	
	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$512,%eax
	movl	(%eax),%eax
	popl	%ebx
	cmpl	%eax,%ebx
	movl	$1,%eax
	jl	disposeComments_reltrue_134
	movl	$0,%eax
disposeComments_reltrue_134	:	
	testl	%eax,%eax
	jz	disposeComments_endwhile_133

	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,%ebx
	cmpl	$35,%ebx
	movl	$1,%eax
	je	disposeComments_reltrue_136
	movl	$0,%eax
disposeComments_reltrue_136	:	
	testl	%eax,%eax
	jnz	disposeComments_ifbl_135
	jmp	disposeComments_elsebl_135
disposeComments_ifbl_135	:	

	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	addl	%esi,%eax
	movl	%eax,%ebx
	movb	$0,(%ebx)
	jmp	disposeComments_endif_135
disposeComments_elsebl_135	:	
disposeComments_endif_135	:	

	movl	-4(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)
	jmp	disposeComments_while_133
disposeComments_endwhile_133	:	
disposeComments_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	addLine
.type	addLine,@function
addLine	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$4,%esp

	subl	$4,%esp
	movl	$552,0(%esp)
	call	malloc
	addl	$4,%esp
	movl	%eax,-4(%ebp)

	movl	-4(%ebp),%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	addLine_reltrue_138
	movl	$0,%eax
addLine_reltrue_138	:	
	testl	%eax,%eax
	jnz	addLine_ifbl_137
	jmp	addLine_elsebl_137
addLine_ifbl_137	:	

	movl	$0,%ebx
	subl	$20003,%ebx
	movl	%ebx,%eax
	jmp	addLine_ret
addLine_elsebl_137	:	
addLine_endif_137	:	

	subl	$12,%esp
	movl	-4(%ebp),%eax
	movl	%eax,0(%esp)
	movl	12(%ebp),%eax
	movl	%eax,4(%esp)
	movl	$552,8(%esp)
	call	memcpy
	addl	$12,%esp

	movl	%ebp,%eax
	addl	$-4,%eax
	movl	(%eax),%eax
	addl	$516,%eax
	movl	%eax,%ebx
	movl	$0,(%ebx)

	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-4(%ebp),%eax
	movl	%eax,4(%esp)
	call	Add_To_Back_Of_LinesList
	addl	$8,%esp

	movl	$0,%eax
	jmp	addLine_ret
addLine_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	commentLine
.type	commentLine,@function
commentLine	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$8,%esp

	movl	16(%ebp),%eax
	testl	%eax,%eax
	jnz	commentLine_ifbl_139
	jmp	commentLine_elsebl_139
commentLine_ifbl_139	:	

	subl	$4,%esp
	movl	16(%ebp),%eax
	movl	%eax,0(%esp)
	call	strlen
	addl	$4,%esp
	movl	%eax,-8(%ebp)

	pushl	-8(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$512,%eax
	movl	(%eax),%eax
	popl	%ebx
	addl	%eax,%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,%ebx
	cmpl	$512,%ebx
	movl	$1,%eax
	jge	commentLine_reltrue_141
	movl	$0,%eax
commentLine_reltrue_141	:	
	testl	%eax,%eax
	jnz	commentLine_ifbl_140
	jmp	commentLine_elsebl_140
commentLine_ifbl_140	:	

	pushl	$0
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	addl	%esi,%eax
	movl	%eax,%ebx
	movb	$35,(%ebx)

	pushl	$1
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	addl	%esi,%eax
	movl	%eax,%ebx
	movb	$32,(%ebx)

	subl	$8,%esp
	movl	$symtab+202,0(%esp)
	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$536,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	getFilename
	addl	$8,%esp
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$8,%esp
	movl	$symtab+242,0(%esp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$540,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	movl	$0,%ebx
	subl	$20003,%ebx
	movl	%ebx,%eax
	jmp	commentLine_ret
commentLine_elsebl_140	:	
commentLine_endif_140	:	
	jmp	commentLine_endif_139
commentLine_elsebl_139	:	
commentLine_endif_139	:	

	movl	$512,%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)

commentLine_while_142	:	
	movl	-4(%ebp),%ebx
	cmpl	$2,%ebx
	movl	$1,%eax
	jge	commentLine_reltrue_143
	movl	$0,%eax
commentLine_reltrue_143	:	
	testl	%eax,%eax
	jz	commentLine_endwhile_142

	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	addl	%esi,%eax
	pushl	%eax
	movl	-4(%ebp),%ebx
	subl	$2,%ebx
	movl	%ebx,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	popl	%ebx
	movb	%al,(%ebx)

	movl	-4(%ebp),%ebx
	subl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)
	jmp	commentLine_while_142
commentLine_endwhile_142	:	

	pushl	$0
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	addl	%esi,%eax
	movl	%eax,%ebx
	movb	$35,(%ebx)

	pushl	$1
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	addl	%esi,%eax
	movl	%eax,%ebx
	movb	$32,(%ebx)

	movl	16(%ebp),%eax
	testl	%eax,%eax
	jnz	commentLine_ifbl_144
	jmp	commentLine_elsebl_144
commentLine_ifbl_144	:	

	subl	$8,%esp
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	movl	%eax,0(%esp)
	movl	16(%ebp),%eax
	movl	%eax,4(%esp)
	call	strcat
	addl	$8,%esp
	jmp	commentLine_endif_144
commentLine_elsebl_144	:	
commentLine_endif_144	:	

	movl	$0,%eax
	jmp	commentLine_ret
commentLine_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	getNextIdentifierInLine
.type	getNextIdentifierInLine,@function
getNextIdentifierInLine	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$8,%esp

	subl	$12,%esp
	movl	16(%ebp),%eax
	movl	%eax,0(%esp)
	movl	$0,4(%esp)
	movl	$128,8(%esp)
	call	memset
	addl	$12,%esp

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$516,%eax
	movl	(%eax),%eax
	movl	%eax,-8(%ebp)

	subl	$4,%esp
	movl	12(%ebp),%eax
	movl	%eax,0(%esp)
	call	lnk_disposeWhitespace
	addl	$4,%esp

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$516,%eax
	movl	(%eax),%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,%ebx
	cmpl	$95,%ebx
	movl	$1,%eax
	je	getNextIdentifierInLine_reltrue_147
	movl	$0,%eax
getNextIdentifierInLine_reltrue_147	:	
	testl	%eax,%eax
	jnz	getNextIdentifierInLine_logexprtrue_146
	subl	$4,%esp
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$516,%eax
	movl	(%eax),%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,0(%esp)
	call	isalpha
	addl	$4,%esp
	testl	%eax,%eax
	jnz	getNextIdentifierInLine_logexprtrue_146
	movl	$0,%eax
	jmp	getNextIdentifierInLine_logexprfalse_146
getNextIdentifierInLine_logexprtrue_146	:	
	movl	$1,%eax
getNextIdentifierInLine_logexprfalse_146	:	
	testl	%eax,%eax
	jnz	getNextIdentifierInLine_ifbl_145
	jmp	getNextIdentifierInLine_elsebl_145
getNextIdentifierInLine_ifbl_145	:	

	movl	$0,-4(%ebp)

getNextIdentifierInLine_while_148	:	
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$516,%eax
	movl	(%eax),%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$512,%eax
	movl	(%eax),%eax
	popl	%ebx
	cmpl	%eax,%ebx
	movl	$1,%eax
	jl	getNextIdentifierInLine_reltrue_150
	movl	$0,%eax
getNextIdentifierInLine_reltrue_150	:	
	testl	%eax,%eax
	jz	getNextIdentifierInLine_logtermfalse_149
	movl	-4(%ebp),%ebx
	cmpl	$128,%ebx
	movl	$1,%eax
	jl	getNextIdentifierInLine_reltrue_151
	movl	$0,%eax
getNextIdentifierInLine_reltrue_151	:	
	testl	%eax,%eax
	jz	getNextIdentifierInLine_logtermfalse_149
	movl	$1,%eax
	jmp	getNextIdentifierInLine_logtermtrue_149
getNextIdentifierInLine_logtermfalse_149	:	
	movl	$0,%eax
getNextIdentifierInLine_logtermtrue_149	:	
	testl	%eax,%eax
	jz	getNextIdentifierInLine_endwhile_148

	subl	$4,%esp
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$516,%eax
	movl	(%eax),%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,0(%esp)
	call	isalnum
	addl	$4,%esp
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	je	getNextIdentifierInLine_reltrue_154
	movl	$0,%eax
getNextIdentifierInLine_reltrue_154	:	
	testl	%eax,%eax
	jz	getNextIdentifierInLine_logtermfalse_153
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$516,%eax
	movl	(%eax),%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,%ebx
	cmpl	$95,%ebx
	movl	$1,%eax
	jne	getNextIdentifierInLine_reltrue_155
	movl	$0,%eax
getNextIdentifierInLine_reltrue_155	:	
	testl	%eax,%eax
	jz	getNextIdentifierInLine_logtermfalse_153
	movl	$1,%eax
	jmp	getNextIdentifierInLine_logtermtrue_153
getNextIdentifierInLine_logtermfalse_153	:	
	movl	$0,%eax
getNextIdentifierInLine_logtermtrue_153	:	
	testl	%eax,%eax
	jnz	getNextIdentifierInLine_ifbl_152
	jmp	getNextIdentifierInLine_elsebl_152
getNextIdentifierInLine_ifbl_152	:	
	jmp	getNextIdentifierInLine_endwhile_148
getNextIdentifierInLine_elsebl_152	:	
getNextIdentifierInLine_endif_152	:	

	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$16,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$516,%eax
	movl	(%eax),%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$0,%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	popl	%ebx
	movb	%al,(%ebx)

	movl	-4(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$516,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$516,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	popl	%ebx
	movl	%eax,(%ebx)
	jmp	getNextIdentifierInLine_while_148
getNextIdentifierInLine_endwhile_148	:	

	movl	-4(%ebp),%ebx
	cmpl	$128,%ebx
	movl	$1,%eax
	je	getNextIdentifierInLine_reltrue_157
	movl	$0,%eax
getNextIdentifierInLine_reltrue_157	:	
	testl	%eax,%eax
	jnz	getNextIdentifierInLine_ifbl_156
	jmp	getNextIdentifierInLine_elsebl_156
getNextIdentifierInLine_ifbl_156	:	

	subl	$8,%esp
	movl	$symtab+264,0(%esp)
	subl	$8,%esp
	movl	8(%ebp),%eax
	movl	%eax,0(%esp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$536,%eax
	movl	(%eax),%eax
	movl	%eax,4(%esp)
	call	getFilename
	addl	$8,%esp
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	subl	$8,%esp
	movl	$symtab+110,0(%esp)
	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$540,%eax
	movl	(%eax),%eax
	movl	%eax,%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,4(%esp)
	call	printf
	addl	$8,%esp

	movl	$0,%ebx
	subl	$20003,%ebx
	movl	%ebx,%eax
	jmp	getNextIdentifierInLine_ret
getNextIdentifierInLine_elsebl_156	:	
getNextIdentifierInLine_endif_156	:	

	movl	$1,%eax
	jmp	getNextIdentifierInLine_ret
getNextIdentifierInLine_elsebl_145	:	
getNextIdentifierInLine_endif_145	:	

	movl	%ebp,%eax
	addl	$12,%eax
	movl	(%eax),%eax
	addl	$516,%eax
	pushl	%eax
	movl	-8(%ebp),%eax
	popl	%ebx
	movl	%eax,(%ebx)

	movl	$0,%eax
	jmp	getNextIdentifierInLine_ret
getNextIdentifierInLine_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.globl	substrcmp
.type	substrcmp,@function
substrcmp	:	
	pushl	%ebp
	movl	%esp,%ebp
	subl	$8,%esp

	movl	$0,-4(%ebp)

	subl	$4,%esp
	movl	16(%ebp),%eax
	movl	%eax,0(%esp)
	call	strlen
	addl	$4,%esp
	movl	%eax,-8(%ebp)

substrcmp_while_158	:	
	movl	-4(%ebp),%ebx
	addl	12(%ebp),%ebx
	movl	%ebx,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	movl	%eax,%ebx
	cmpl	$0,%ebx
	movl	$1,%eax
	jne	substrcmp_reltrue_160
	movl	$0,%eax
substrcmp_reltrue_160	:	
	testl	%eax,%eax
	jz	substrcmp_logtermfalse_159
	movl	-4(%ebp),%ebx
	cmpl	-8(%ebp),%ebx
	movl	$1,%eax
	jl	substrcmp_reltrue_161
	movl	$0,%eax
substrcmp_reltrue_161	:	
	testl	%eax,%eax
	jz	substrcmp_logtermfalse_159
	movl	$1,%eax
	jmp	substrcmp_logtermtrue_159
substrcmp_logtermfalse_159	:	
	movl	$0,%eax
substrcmp_logtermtrue_159	:	
	testl	%eax,%eax
	jz	substrcmp_endwhile_158

	movl	-4(%ebp),%ebx
	addl	12(%ebp),%ebx
	movl	%ebx,%eax
	pushl	%eax
	movl	%ebp,%eax
	addl	$8,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	pushl	%eax
	pushl	-4(%ebp)
	movl	%ebp,%eax
	addl	$16,%eax
	movl	(%eax),%eax
	popl	%esi
	addl	%esi,%eax
	movb	(%eax),%al
	movsbl	%al,%eax
	popl	%ebx
	cmpl	%eax,%ebx
	movl	$1,%eax
	jne	substrcmp_reltrue_163
	movl	$0,%eax
substrcmp_reltrue_163	:	
	testl	%eax,%eax
	jnz	substrcmp_ifbl_162
	jmp	substrcmp_elsebl_162
substrcmp_ifbl_162	:	

	movl	$1,%eax
	jmp	substrcmp_ret
substrcmp_elsebl_162	:	
substrcmp_endif_162	:	

	movl	-4(%ebp),%ebx
	addl	$1,%ebx
	movl	%ebx,%eax
	movl	%eax,-4(%ebp)
	jmp	substrcmp_while_158
substrcmp_endwhile_158	:	

	movl	-4(%ebp),%ebx
	cmpl	-8(%ebp),%ebx
	movl	$1,%eax
	je	substrcmp_reltrue_165
	movl	$0,%eax
substrcmp_reltrue_165	:	
	testl	%eax,%eax
	jnz	substrcmp_ifbl_164
	jmp	substrcmp_elsebl_164
substrcmp_ifbl_164	:	

	movl	$0,%eax
	jmp	substrcmp_ret
substrcmp_elsebl_164	:	
substrcmp_endif_164	:	

	movl	$1,%eax
	jmp	substrcmp_ret
substrcmp_ret	:	
	movl	%ebp,%esp
	popl	%ebp
	ret	

.section	.data
symtab	:	
.string	".globl"
.string	".type"
.string	".section"
.string	".text"
.string	".data"
.string	".string"
.string	".byte"
.string	".long"
.string	".rept"
.string	".endr"
.string	"%s\n"
.string	"LINKER_ERROR: source line too long [%s:"
.string	"%d] - aborting\n"
.string	"LINKER_ERROR: Could not write to output file. The produced file is void!"
.string	"%d"
.string	"LINKER_WARNING: cannot comment line [%s"
.string	"%d]- will missform it"
.string	"LINKER_ERROR: identifier too long [%s"
