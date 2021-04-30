
	.text
	add $t0 , $zero , $zero
	add $t1, $zero , $zero
	
	la $a0, inputText
	li $v0 , 4
	syscall
	
	li $v0, 5
	syscall
	
	move $a0 , $v0
	jal createLinkedList
	move $t0 , $v0
	move $a0 , $t0
	jal printList
	move $a0 , $t0
	add $a1 , $zero, $zero
	jal recursiveCopy
	move $t1 , $v0
	
	li $v0 , 4
	la $a0 , newLine
	syscall
	
	li $v0 , 4
	la $a0 , copyText
	syscall
	
	move $a0 , $t1
	jal printList
	
	
exit:
	li $v0 , 10
	syscall
	
					
createLinkedList:
	addi	$sp, $sp, -24
	sw	$s0, 20($sp)
	sw	$s1, 16($sp)
	sw	$s2, 12($sp)
	sw	$s3, 8($sp)
	sw	$s4, 4($sp)
	sw	$ra, 0($sp) 	# Save $ra just in case we may want to call a subprogram
	
	move $s0 , $a0 #size of the linked list
	li $s1 , 1
	
	li $v0 , 9
	li $a0 , 8 #allocate 8 bit 
	syscall
	
	move $s3 , $v0
	move $s2 ,$v0
	add $s4 , $zero , $s1
	sw $s4 , 4($s2)
	
addNode:
	beq $s1 , $s0 , endFunc
	addi $s1 , $s1 , 1
	
	li $a0 ,8
	li $v0 ,9	
	syscall
	sw $v0 , 0($s2)
	move $s2 , $v0
	add $s4 , $zero , $s1
	sw $s4, 4($s2)
	j addNode

endFunc:	
	sw $zero, 0($s2)
	move $v0 , $s3 #put the beginning of the list to v0
	# Restore the register values
	lw	$ra, 0($sp)
	lw	$s4, 4($sp)
	lw	$s3, 8($sp)
	lw	$s2, 12($sp)
	lw	$s1, 16($sp)
	lw	$s0, 20($sp)
	addi	$sp, $sp, 24
	jr $ra
		
printList:
	addi	$sp, $sp, -24
	sw	$s0, 20($sp)
	sw	$s1, 16($sp)
	sw	$s2, 12($sp)
	sw	$s3, 8($sp)
	sw	$s4, 4($sp)
	sw	$s5, 0($sp) 	# Save $ra just in case we may want to call a subprogram
	add $s5 , $zero , $zero
	add $s4, $zero , 6
	move $s0 ,$a0 #beginning of the list
	move $s3 , $a0
	lw $s1 ,4($s0)
	
printLoop:
	# Save $s registers used
	addi	$sp, $sp, -20
	sw	$s0, 16($sp)
	sw	$s1, 12($sp)
	sw	$s2, 8($sp)
	sw	$s3, 4($sp)
	sw	$ra, 0($sp) 	# Save $ra just in case we may want to call a subprogram

# $a0: points to the linked list.
# $s0: Address of current
# s1: Address of next
# $2: Data of current
# $s3: Node counter: 1, 2, ...
	move $s0, $a0	# $s0: points to the current node.
	li   $s3, 0
printNextNode:
	beq	$s0, $zero, printedAll
				# $s0: Address of current node
	lw	$s1, 0($s0)	# $s1: Address of  next node
	lw	$s2, 4($s0)	# $s2: Data of current node
	addi	$s3, $s3, 1
# $s0: address of current node: print in hex.
# $s1: address of next node: print in hex.
# $s2: data field value of current node: print in decimal.
	la	$a0, line
	li	$v0, 4
	syscall		# Print line seperator
	
	la	$a0, nodeNumberLabel
	li	$v0, 4
	syscall
	
	move	$a0, $s3	# $s3: Node number (position) of current node
	li	$v0, 1
	syscall
	
	la	$a0, addressOfCurrentNodeLabel
	li	$v0, 4
	syscall
	
	move	$a0, $s0	# $s0: Address of current node
	li	$v0, 34
	syscall

	la	$a0, addressOfNextNodeLabel
	li	$v0, 4
	syscall
	move	$a0, $s1	# $s0: Address of next node
	li	$v0, 34
	syscall	
	
	la	$a0, dataValueOfCurrentNode
	li	$v0, 4
	syscall
		
	move	$a0, $s2	# $s2: Data of current node
	li	$v0, 1		
	syscall	

# Now consider next node.
	move	$s0, $s1	# Consider next node.
	j	printNextNode
printedAll:
# Restore the register values
	lw	$ra, 0($sp)
	lw	$s3, 4($sp)
	lw	$s2, 8($sp)
	lw	$s1, 12($sp)
	lw	$s0, 16($sp)
	addi	$sp, $sp, 20
	jr	$ra

recursiveCopy:
	bne $a1, $zero, skipOneStep
	addi	$sp, $sp, -32
	sw	$s0, 28($sp)
	sw	$s1, 24($sp)
	sw	$s2, 20($sp)
	sw	$s3, 16($sp)
	sw	$s4, 12($sp)
	sw	$s5, 8($sp) 
	sw 	$s6, 4($sp)
	sw 	$s7, 0($sp)
	move $s7 , $ra
	add $a1 , $zero , 1
	move $s0, $a0
	lw $s1 , 0($s0)
	move $s0 , $s1
	move $s5, $a0 #also points the head of the list 
	
	li $v0 , 9
	li $a0 ,8
	syscall
	move $s1 , $v0
	move $s6, $v0
skipOneStep:
	bne $s0 , $zero , recursion
	#lw $s3 , 4($s5)
	#sw $s3 , 4($s1)
	jr $ra
	
recursion:
	addi $sp , $sp, -4
	sw $ra , 0($sp)
	lw $s3, 0($s0)
	move $s0 , $s3
	jal recursiveCopy

	lw $s2, 4($s5)
	sw $s2, 4($s1)
	lw $s3, 0($s5)
	move $s5 , $s3
	lw $ra , 0($sp)
	addi $sp , $sp , 4 
	li $v0 , 9
	li $a0 , 8
	syscall
	move $s3, $v0
	sw $s3, 0($s1)
	move $s1 , $s3 
	beq $s5 , $zero , done2
	
	
done2:
	lw $s2, 4($s5)
	sw $s2, 4($s1)
	move $v0 , $s6
	beq $ra , $s7 , exitting
	jr $ra 
exitting:
	lw	$s5, 0($sp)
	lw	$s4, 4($sp)
	lw	$s3, 8($sp)
	lw	$s2, 12($sp)
	lw	$s1, 16($sp)
	lw	$s0, 20($sp)
	addi	$sp, $sp, 24
	jr $ra
	# Restore the register values
	
	.data
line:	
	.asciiz "\n --------------------------------------"

nodeNumberLabel:
	.asciiz	"\n Node No.: "
	
addressOfCurrentNodeLabel:
	.asciiz	"\n Address of Current Node: "
	
addressOfNextNodeLabel:
	.asciiz	"\n Address of Next Node: "
	
dataValueOfCurrentNode:
	.asciiz	"\n Data Value of Current Node: "

inputText: .asciiz "type the size of the linked list: "
space: .asciiz " " 
newLine: .asciiz "\n"
copyText: .asciiz "Copyed linked list :  " 

	
