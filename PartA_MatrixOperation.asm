
#part4 for lab06. Ali Eren Günaltýlý 21801897
.text
	add $t0 , $zero, $zero #size of the array 
	add $t1, $zero, $zero #beginning of the array
	add $t2, $zero, $zero
	add $t4, $zero, $zero #beginning of the array
	
	li $v0 , 4
	la $a0 , infoText
	syscall
	
beginning:

	li $v0, 4
	la $a0, newLine
	syscall
	
	li $v0 , 4
	la $a0 , menu1
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	li $v0, 4
	la $a0 , menu2
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	li $v0, 4
	la $a0, menu3
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	li $v0, 4
	la $a0 , menu4
	syscall

	li $v0, 4
	la $a0, newLine
	syscall	
	
	li $v0 , 4
	la $a0 , menu5 
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	li $v0 , 4
	la $a0 , menu6
	syscall
	
	li $v0, 4
	la $a0 , newLine
	syscall
	
	li $v0 , 5 
	syscall
	move $t6, $v0
	
	addi $t5, $zero, 1
	beq $t6, $t5, option1
	addi $t5, $t5, 1
	beq $t6, $t5, option2
	addi $t5, $t5, 1
	beq $t6, $t5, option3
	addi $t5, $t5, 1
	beq $t6, $t5, option4
	addi $t5, $t5, 1
	beq $t6, $t5, option5
	addi $t5, $t5, 1
	beq $t6, $t5 , option6
	j beginning
	
option1:
	la $a0 , inputText
	li $v0 , 4
	syscall
	
	la $a0 , newLine
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	addi $a0 , $zero, 1
	bge $v0, $a0, validSize
	j skip1
validSize:
	move $t0 , $v0 #t0 = size of the matrix 
	
	li $v0 , 4
	la $a0, warning
	syscall
	
	j beginning
skip1:
	li $v0 , 4
	la $a0, invalidSize
	syscall
	
	li $v0 , 4
	la $a0, newLine
	syscall
	
	j option1
	
option2:
	#t0 = size currently
	mul $a0, $t0 , 4 # space needed to be allocated 
	
	li $v0, 9
	syscall
	move $t1 , $v0 #t1 points the beginning of the array
	move $t4, $t1 
	
	add $t7, $zero, $zero
	addi $a0 , $zero, 1
	move $v0 , $t0
	mul $t0 , $t0, $t0
initialize:
	bge $t7, $t0 , doneInitialization
	sw $a0, ($t1)
	addi $t1, $t1, 4
	addi $a0 , $a0 , 1
	addi $t7, $t7, 1
	j initialize
	
doneInitialization:
	move $t1, $t4
	move $t0 , $v0
	j beginning
		
option3:
	
	li $v0 , 4
	la $a0 , rowText
	syscall
	
	li $v0 , 5
	syscall
	move $t2, $v0 #t2 row value to showed
		
	li $v0, 4
	la $a0, columnText
	syscall
	
	li $v0 , 5
	syscall
	move $t3 , $v0 #t3 column value to be showed
	
	li $v0, 4
	la $a0 , outputSpecific
	syscall 
	
	#row operation to reach a value
	addi $t2 , $t2 , -1
	mul $t2 , $t0 , $t2
	mul $t2, $t2, 4
	
	#column operation to reach a value
	addi $t3, $t3, -1
	mul $t3, $t3, 4
	
	add $t2, $t2, $t3
	add $t4, $t4 , $t2
	lw $a0 , ($t4)
	
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	move $t4, $t1
	
	j beginning
	
option4:
	move $a0 ,$t0
	move $a1, $t1
	jal arithmeticRow
	j beginning
option5:
	move $a0 , $t0
	move $a1, $t1
	jal arithmeticColumn
	j beginning

option6:
	move $a0, $t0
	move $a1, $t1
	jal printArray
	j beginning
exit:
	li $v0 , 10 
	syscall 


printArray:
#stack creation
	addi $sp , $sp , -28
	sw $s6 , 24($sp)
	sw $s5 , 20($sp)
	sw $s4 , 16($sp)
	sw $s3 , 12($sp)
	sw $s2 , 8($sp) 
	sw $s1 , 4($sp)
	sw $s0 , 0($sp)
	
	move $s0 , $a0 #s0 = size
	move $s5, $s0 #s5 = size
	mul $s0, $s0, $s0
	move $s1, $a1 #beginning of the array
	move $s2 ,$s1
	add $s3 , $zero, $zero
	
printLoop:
	bge $s3 , $s0 , exitLoop
	lw $a0 , ($s1)
	move $s6, $a0 #store the value to be printed in s6 too to not lose while printing newLine.
	addi $s1, $s1 , 4
	addi $s3 , $s3 , 1
	
	li $v0 , 1 
	syscall
	
	div $s4 , $a0, $s5
	mfhi $s4
	beq $s4, $zero, goNextLine
	j skip2
goNextLine:
	li $v0, 4
	la $a0, newLine
	syscall
	j printLoop
skip2:	
	la $a0 , space
	li $v0, 4 
	syscall
	
	j printLoop
	
exitLoop:
	
	#stack restoration
	lw $s0 , 24($sp)
	lw $s1 , 20($sp)
	lw $s2 , 16($sp)
	lw $s3 , 12($sp)
	lw $s4 , 8($sp)
	lw $s5 , 4($sp)
	lw $s6 , 0($sp)
	addi $sp ,$sp , 28
	jr $ra
	
arithmeticRow:
#stack creation
	addi $sp , $sp , -32
	sw $s7, 32($sp)
	sw $s6 , 24($sp)
	sw $s5 , 20($sp)
	sw $s4 , 16($sp)
	sw $s3 , 12($sp)
	sw $s2 , 8($sp) 
	sw $s1 , 4($sp)
	sw $s0 , 0($sp)
	
	move $s0, $a0 #s0 = dimension
	move $s6, $s0 #s6= dimension
	mul $s0, $s0, $s0 # size 3*3 4*4 for instance
	move $s1, $a1 #s1 = beginning of the array
	add $s2, $zero, $zero
	addi $s4, $zero, 1 #row counter
	addi $s5, $zero, 1 #column counter
	
while1:
	bgt $s5, $s6, label_1
	lw $s7 ,($s1)
	add $s2, $s2, $s7
	addi $s1, $s1, 4
	addi $s5, $s5, 1 
	j while1

label_1:	

	li $v0 ,4
	la $a0 , row
	syscall 
	
	li $v0, 1
	add $a0 , $zero, $s4
	syscall
	
	li $v0 , 4
	la $a0 , mean
	syscall
	
	li $v0, 4
	la $a0 , space
	syscall
	
	div $s2, $s2, $s6
	
	li $v0, 1
	add $a0, $zero, $s2
	syscall
	
	li $v0, 4
	la $a0 , newLine
	syscall
	
	addi $s4, $s4, 1
	addi $s5, $zero, 1
	bgt $s4, $s6, doneFunc
	add $s2, $zero, $zero
	j while1 

doneFunc:
	#stack restoration
	lw $s0 , 28($sp)
	lw $s1 , 24($sp)
	lw $s2 , 20($sp)
	lw $s3 , 16($sp)
	lw $s4 , 12($sp)
	lw $s5 , 8($sp)
	lw $s6 , 4($sp)
	lw $s7, 0($sp)
	addi $sp ,$sp , 32
	jr $ra

arithmeticColumn:
#stack creation
	addi $sp , $sp , -32
	sw $s7, 32($sp)
	sw $s6 , 24($sp)
	sw $s5 , 20($sp)
	sw $s4 , 16($sp)
	sw $s3 , 12($sp)
	sw $s2 , 8($sp) 
	sw $s1 , 4($sp)
	sw $s0 , 0($sp)
	
	move $s0 , $a0 # size of the array 
	move $s1 , $a1 #beginning of the array 
	addi $s2 ,$zero, 1
	mul $s3, $s0, 4
	addi $s4, $s0 , -1
	mul $s3, $s3, $s4 #s3 needed byte to be added to reach the last row
	add $s5, $s3, $s1 #last row of the matrix. s5 points the first element of the last row.

while2:
	bgt $s2, $s0, exitWhile2
	lw $s4, ($s1)
	lw $s6, ($s5)

	
	add $s4, $s4, $s6
	div $s4, $s4, 2
	
	addi $s1, $s1, 4
	addi $s5, $s5, 4
	
	li $v0 , 4
	la $a0, column
	syscall 
	
	li $v0, 1
	move $a0 , $s2
	syscall
	
	addi $s2, $s2, 1 
	
	li $v0 , 4
	la $a0 , mean
	syscall 
	
	li $v0, 1
	move $a0 , $s4
	syscall
	 
	li $v0, 4
	la $a0, space
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	
	j while2
		
exitWhile2:
	
	#stack restoration
	lw $s0 , 28($sp)
	lw $s1 , 24($sp)
	lw $s2 , 20($sp)
	lw $s3 , 16($sp)
	lw $s4 , 12($sp)
	lw $s5 , 8($sp)
	lw $s6 , 4($sp)
	lw $s7, 0($sp)
	addi $sp ,$sp , 32
	jr $ra
	
	
	.data
row: .asciiz "row number  "
mean: .asciiz ". mean is " 
infoText: .asciiz "After deciding the size by typing 1, for proper matrix allocation we have to type 2 for option 2" 
column: .asciiz "column number "
rowText: .asciiz " type row to showed: "
columnText: .asciiz " type column to showed: "
invalidSize: .asciiz "type positive size value "
warning: .asciiz " You have to choose option 2 after typing size to create a matrix" 
menu1: .asciiz "1 to decide the size of matrix" 
menu2: .asciiz "2 to allocate proper space in heap" 
menu3: .asciiz "3 to show specific item on matrix" 
menu4: .asciiz "4 to print the row by row with their mean" 
menu5: .asciiz "5 to print the column by column with their mean" 
menu6: .asciiz "6 to print all elements" 
inputText: .asciiz "Type the size of matrix: " 
newLine: .asciiz "\n"
space: .asciiz " "
size: .word 6
outputSpecific: .asciiz " specific value to be showed: " 
