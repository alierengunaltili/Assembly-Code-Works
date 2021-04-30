

	.text
	add $t0 , $zero , $zero #initialization
	add $t1 , $zero , $zero #initialization
	#printing text
	li $v0 , 4
	la $a0 , divisionText
	syscall
	#taking input
	li $v0 , 5
	syscall
	move $t0 , $v0 #t0 = dividend number
	#printing text
	li $v0 , 4
	la $a0 , dividerText
	syscall
	#take the input
	li $v0 , 5
	syscall
	move $t1 , $v0 #input = t5, t5 = divider for division right now
	
	move $a0 , $t0 # a0 = divident
	move $a1 , $t1 #a1 = divider
	jal division #call func
	move $t0 , $v0 #quatient
	move $t1 , $v1 #remainder
	#printing text for convenient output
	li $v0 , 4
	la $a0 , quatientText
	syscall
	#printing result
	add $a0 , $t0 , $zero #a0 = quatient of the division
	li $v0 , 1
	syscall
	#print one space
	la $a0 , space
	li $v0 , 4
	syscall
	#printing text for convenient output
	li $v0 , 4
	la $a0 , remainderText
	syscall
	#printing result
	add $a0 , $t1 , $zero #a0 = remainder of the division
	li $v0 , 1 
	syscall
	
Exit:
	#exitting the program 
	li $v0 , 10
	syscall

division:
	bge $a0 , $a1 , recursion #as we conduct division by subtracting divider from divident till the divident becomes smaller than divider 
	# this bge do that.
	li $v0 , 0 #v0 = 0
	jr $ra 
recursion:
	addi $sp , $sp , -4 #create one space in stack
	sw $ra , 0($sp) #put the current return address to that space 
	sub $a0 , $a0 , $a1 # divident = divident - divider
	jal division 
	
	lw $ra , 0($sp) 
	addi $sp , $sp , 4 # take the return address one by one. these return addresses we put it into the stack
			   # decide how many times we make this action.
	move $v1 , $a0  #v1 = reaminder right now
	add $v0 , $v0 , 1 # how many times we looping these lines = quatient of the operation
	jr $ra
	
	.data
newLine: .asciiz "\n" 
space: .asciiz " " 
divisionText: .asciiz "type number for dividend: "
dividerText: .asciiz "type number for divider: " 
quatientText: .asciiz "quatient: " 
remainderText: .asciiz "remainder: " 