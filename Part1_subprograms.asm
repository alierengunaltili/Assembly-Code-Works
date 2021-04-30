

PartA - array with subprograms

	.text
	add $t0 , $zero , $zero
	add $t1 , $zero , $zero	 #max value 
	add $t2 , $zero , $zero #min value
	add $t3 , $zero , $zero
	add $t4 , $zero , $zero
	
	la $a0 , array # putting the array into the a0
	lw $a1 , arrSize  #a1 = arrSize
	move $a2 , $a0  #temporary register to hold array since when we call syscall and load something into the a0. Then try to
	#use a0 as an array program crash since we lost the previous value which is array's address. 
	
	jal printer
	
	li $v0 , 4 
	la $a0 , nextLine
	syscall
	#a0 = array
	move $a0 , $a2
	jal findSymmetry
	add $t0 , $v0 , $zero #put the return value into t0 register
	#printing the text for interface
	li $v0 , 4
	la $a0 , symmetryText
	syscall
	#isSymmetric() or not printing
	li $v0 , 1
	add $a0 , $t0 , $zero
	syscall
	move $a0 , $a2 # get the array and put it into the a0 again.
	jal maxmin # call the max min finder function
	move $t1 , $v0 #t1 = max value of the array
	move $t2 , $v1 #t2 = min value of the array
	#going to the next line
	li $v0 , 4
	la $a0 , nextLine
	syscall
	#printing max text
	li $v0 ,4
	la $a0 , maxText
	syscall 
	#printing max value
	li $v0 , 1
	add $a0 , $t1 , $zero
	syscall
	#printing space 
	li $v0 , 4
	la $a0 , space
	syscall 
	#printing min text
	li $v0 , 4
	la $a0 , minText
	syscall 
	#printing min value
	li $v0 , 1 
	add $a0 , $t2 , $zero 
	syscall
	
Exit:
	#exitting
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
	
printer: 
	#stack creation for s registers
	addi $sp , $sp , -16
	sw $s3 , 12($sp)
	sw $s2 , 8($sp)
	sw $s1 , 4($sp)
	sw $s0 , 0($sp)
	
	add $s0 , $a0 , $zero #s0 pointing the array's first element
	move $s1 , $a1 #a1 = arrsize
	add $s2 , $zero , $zero #counter i for loop
printLoop:
	lw $s3 , ($s0) # s3 currently pointing the starting index
	add $s0 , $s0 , 4 #s0 = s0 + 4 pointing the next element on array
	
	move $a0 , $s3 # print the content of s3 
	li $v0 , 1 
	syscall
	
	#printing space character for  convenient interface
	la $a0 , space 
	li $v0 , 4
	syscall 
	
	add $s2 , $s2 , 1 # i = i +1 
	blt $s2 , $s1 , printLoop 
	
	la $a0 , array
	#restore the s registers 
	lw $s0 , 12($sp)
	lw $s1 , 8($sp)
	lw $s2 , 4($sp)
	lw $s3 , 0($sp)
	addi $sp , $sp , 16
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
arrSize: .word 4
array: .word 20 , 30 , 30 , 20
maxText: .asciiz "Max value: "
minText: .asciiz "Min value: " 
symmetryText: .asciiz "0 means asymmetric, 1 is symmetric = " 
nextLine: .asciiz "\n"
space: .asciiz " "