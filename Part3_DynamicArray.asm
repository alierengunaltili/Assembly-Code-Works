

	.text
	add $t3 , $zero , $zero
	add $t2 , $zero , $zero #temp value to store array
	add $t0 , $zero , $zero
	add $t1 , $zero , $zero
	add $t4 , $zero , $zero #max value
	add $t5 , $zero , $zero #min value
	add $t6 , $zero , $zero #symmetry checker
	addi $t1 , $zero  , 4
	
	li $v0 , 4
	la $a0 , inputText
	syscall
	
	li $v0 ,5 # take the input
	syscall
	
	move $a0 , $v0  #take the input put it into the a0 
	move $a1, $a0 # a1 = arrSize
	beq $a1 , 0 , initialize
	j jump1
initialize:
	add $t6 , $zero , 1
	add $t5 , $zero , $zero
	add $t4 , $zero , $zero
	
	li $v0 , 4
	la $a0 , nextLine
	syscall
	
	li $v0 , 4
	la $a0 , maxText
	syscall 
	
	li $v0 , 1
	add $a0 , $t4 , $zero
	syscall

	li $v0, 4
	la $a0 , nextLine
	syscall
	
	li $v0 ,4
	la $a0 , minText
	syscall
	
	li $v0 ,1 
	add $a0 , $t5 , $zero
	syscall
	
	li $v0 , 4
	la $a0 , nextLine
	syscall
	
	li $v0 , 4
	la $a0 , symmetryText
	syscall
	
	li $v0 , 1
	add $a0 , $t6 , $zero
	syscall
	
	j Exit
jump1:
	mult $a0 , $t1
	mflo $a0
	add $a0 , $a0 , $zero  #a0 is currently bits required for array allocation.
	jal allocateArray
	add $t3 , $v0 , $zero
	move $a1 , $v1 #a1 is currently arrSize
	move $a0 , $v0 # a0 is currently array
	move $t2 , $v0
	jal maxmin
	move $t4 , $v0 # t4 = max
	move $t5 , $v1 # t5 = min

	li $v0 , 4
	la $a0 , nextLine
	syscall
	
	li $v0 , 4
	la $a0 , maxText
	syscall 
	
	li $v0 , 1
	add $a0 , $t4 , $zero
	syscall

	li $v0, 4
	la $a0 , nextLine
	syscall
	
	li $v0 ,4
	la $a0 , minText
	syscall
	
	li $v0 ,1 
	add $a0 , $t5 , $zero
	syscall
	
	move $a0 , $t2
	jal findSymmetry
	move $t6 , $v0 
	
	li $v0 , 4
	la $a0 , nextLine
	syscall
	
	li $v0 , 4
	la $a0 , symmetryText
	syscall
	
	li $v0 , 1
	add $a0 , $t6 , $zero
	syscall
	
	
Exit:
	li $v0 , 10
	syscall
	
maxmin:
	#stack creation for s registers
	addi $sp , $sp , -24
	sw $s5 , 20($sp)
	sw $s4 , 16($sp)
	sw $s3 , 12($sp) #min temp
	sw $s2 , 8($sp) #max temp
	sw $s1 , 4($sp)
	sw $s0 , 0($sp)
	
	move $s0 , $a0  # putting the array to s0 
	move $s1 , $a1  # s1 = arrSize
	
	add $s5 , $zero , $zero # initialization
	add $s4 , $zero , 1 #loop counter i 
	lw $s5 , ($s0) # s5 = array 
	add $s2 , $s5 , $zero
	add $s3 , $s5 , $zero
	
whileLoop:
	lw $s5 , ($s0) # s5 pointing the first index of array 
	add $s0 , $s0 , 4 #visiting the next index
	blt $s5 , $s3 , min # if currently visited value is smaller than min, make the min currently pointed value
back:
	bgt $s5 , $s2 , max # if currently visited value is bigger than max , make the max currently pointed value
back1:	
	add $s4 , $s4 , 1  # i = i +1 
	ble $s4 , $s1 , whileLoop
	j exit
min:
	add $s3 , $s5 , $zero # s3 = new min value
	j back
max:
	add $s2 , $s5 , $zero # s2 = new max value
	j back1

exit:
	move $v0 , $s2 #v0 = max value
	move $v1 , $s3 # v1 = min value
	#restore the s registers
	lw $s0 , 20($sp)
	lw $s1 , 16($sp)
	lw $s2 , 12($sp)
	lw $s3 , 8($sp)
	lw $s4 , 4($sp)
	lw $s5 , 0($sp)
	addi $sp , $sp , 24
	jr $ra	
	
	
allocateArray:
	#stack creation
	addi $sp , $sp , -28
	sw $ra , 24($sp)
	sw $s5 , 20($sp)
	sw $s4 , 16($sp)
	sw $s3 , 12($sp)
	sw $s2 , 8($sp) 
	sw $s1 , 4($sp)
	sw $s0 , 0($sp)
	

	move $s0 , $a0 # put the size * 4 into s0. which is needed byte for dynamic array allocation
	move $s1 , $a1 # s1 = arrSize
	add $s3 , $zero , $zero # i for loop
	add $a0 , $s0 , $zero
	li $v0 ,9 #dynamically created array. v0 pointing the first index's address
	syscall
	move $s4 , $v0 #s4 also pointing the array right now
	move $s5 , $v0 

loop:
	li $v0 ,5 
	syscall
	
	move $s5 , $v0
	sw $s5 , ($s4)
	add $s4 , $s4 , 4
	
	add $s3 , $s3 , 1
	blt $s3 , $s1 , loop
	
	sub $s4 , $s4 , $s0
	#lw $s6 , ($s4)
	#li $v0 , 1
	#add $a0 , $s6 , $zero
	#syscall
	move $v0 , $s4 # putting the array. currently pointing the first element
	move $a2 , $ra #putting the return address to a2 register to save and not destroy because of the print function call.
	move $v1 , $s1
	#stack restoration
	lw $s0 , 24($sp)
	lw $s1 , 20($sp)
	lw $s2 , 16($sp)
	lw $s3 , 12($sp)
	lw $s4 , 8($sp)
	lw $s5 , 4($sp)
	lw $ra , 0($sp)
	addi $sp ,$sp , 28
	jal printer
	move $v0 , $v0
	move $ra , $a2
	jr $ra
	
printer:
	#stack creation
	addi $sp , $sp , -28
	sw $s6 , 24($sp)
	sw $s5 , 20($sp)
	sw $s4 , 16($sp)
	sw $s3 , 12($sp)
	sw $s2 , 8($sp) 
	sw $s1 , 4($sp)
	sw $s0 , 0($sp)
	
	move $s4 , $v0 
	add $s3 , $zero , $zero # for loop counter
	move $s1 , $v0
	move $s0 , $v0
	move $s2 , $v1 # s2 = arrSize
	
printLoop:
	
	lw $s1 , ($s0)
	add $s0 , $s0 ,4 
	
	li $v0  ,1 
	add $a0 , $s1 , $zero
	syscall
	
	li $v0 ,4
	la $a0 , space
	syscall
	
	add $s3 , $s3 , 1
	blt $s3 , $s2 , printLoop
	
	
	move $v0 , $s4 # v0 = address of the array pointing beginning
	move $v1 , $s2 # v1 = arrSize
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
	
	
findSymmetry:
	#stack creation for s registers
	addi $sp , $sp , -28
	sw $s6 , 24($sp)
	sw $s5 , 20($sp)
	sw $s4 , 16($sp)
	sw $s3 , 12($sp)
	sw $s2 , 8($sp)
	sw $s1 , 4($sp)
	sw $s0 , 0($sp)
	
	add $s1 , $a1 , $zero #s1 = arrsize
	move $s4 , $a0 # s4 = array first index address
	move $s0 , $a0  # s0 = array first index address
	add $s2 , $zero , 4 # a2 = 4 since every word in the array is 4 byte.
	mult $s2 , $s1 
	mflo $s2 
	sub $s2 , $s2 , 4 #value need to be added to reach the last element. s2 = 4. (4 * arrSize) - 4 = gives the value to be added 
	#to first index to reach the last index
	
	add $s4 , $s4 , $s2 # s4 currently pointing the last element 
	add $s3 , $zero , $zero #loop i 
	div $s1 , $s1 , 2 #dividing with 2 since we compare elements of array each other so size / 2 gives the exact boundary of our loop.
	mflo $s1 #boundary to how many times we done the process 
	
while:
	lw $s5 , ($s0) #first index value moving throught to middle
	lw $s6 , ($s4) #last index value coming closer to middle
	bne $s6 , $s5 , asymmetry #check the condition if two value comparing currently are not equal that means array is asymmetric.
	add $s0 , $s0 , 4 # going to next index
	sub $s4 , $s4 , 4 #coming prev index from last 
	add $s3 , $s3 , 1 # i = i + 1
	blt $s3 , $s1 , while
symmetry:
	add $v0 , $zero , 1 # 1 = symmetric array , load 1 to return parameter v0
	j done
asymmetry:
	add $v0 , $zero , 0 #load 0 to returned register v0 to show asymmetry 
done:
	#restoring s registers after their job is done
	lw $s0 , 24($sp)
	lw $s1 , 20($sp)
	lw $s2 , 16($sp)
	lw $s3 , 12($sp)
	lw $s4 , 8($sp)
	lw $s5 , 4($sp)
	lw $s6 , 0($sp)
	addi $sp , $sp , 28
	jr $ra
	
	
	
	.data
symmetryText: .asciiz "0 Means Asymmetric, 1 Means Symmetric = " 
maxText: .asciiz "Max value is: " 
minText: .asciiz "Min value is: " 
inputText: .asciiz "Type the array's size: " 
space: .asciiz " " 
nextLine: .asciiz "\n"
