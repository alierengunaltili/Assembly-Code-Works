
	.text
	
	
	#initialization
	add $t0 , $zero , $zero
	add $t1 , $zero , $zero
	
Start:
	#printing text for proper interface
	li $v0 , 4
	la $a0 , inputText
	syscall
	
	#take the input and put it into the v0
	li $v0 ,5
	syscall
	
	move $a0 , $v0 #a0 = typed integer now
	move $t0 , $a0 #t0 = a0 whic means t0 also pointed the original value
	jal reverse
	move $t1 , $v0 #append the return value into t1
	
	
	#printing text for proper interface
	li $v0 , 4
	la $a0 , original
	syscall
	
	#printing the original value
	li $v0 , 1
	add $a0 , $zero , $t0
	syscall
	
	#skipping to the next line
	li $v0 , 4
	la $a0 , nextLine
	syscall
	
	#printing text for proper interface
	li $v0 , 4
	la $a0 , binaryText
	syscall
	
	#print integer
	li $v0 , 35
	add $a0 , $t0 , $zero
	syscall
	
	#skipping to the next line
	li $v0 , 4
	la $a0 , nextLine
	syscall
	
	#printing text for proper interface
	li $v0 ,4 
	la $a0 , hexaText
	syscall
	
	#print the original value in hexadecimal form
	li $v0 , 34
	add $a0 , $zero , $t0
	syscall
	
	#go to next line
	li $v0 , 4
	la $a0 , nextLine
	syscall
	
	#printing text for proper interface
	li $v0 , 4
	la $a0 , reverseBinaryText
	syscall
	#printed the reversed integer in binary form
	li $v0 , 35
	add $a0, $t1 , $zero
	syscall
	#skipping to the next line
	li $v0 ,4 
	la $a0 ,nextLine
	syscall
	#printing text for proper interface
	li $v0 , 4
	la $a0 , reverseHexaText
	syscall
	#printed the reversed integer in hexadecimal form
	li $v0 ,34
	add $a0 , $t1 , $zero
	syscall
Exit:
	#exitting
	li $v0 ,10
	syscall
	



reverse:
	#stack creation
	addi $sp , $sp , -28
	sw $s6 , 24($sp)
	sw $s5 , 20($sp)
	sw $s4 , 16($sp)
	sw $s3 , 12($sp)
	sw $s2 , 8($sp) 
	sw $s1 , 4($sp)
	sw $s0 , 0($sp)

	move $s0 , $a0 # put the integer into s0
	move $s3 , $s0  #put the integer into s3
	add $s4 , $zero , $zero # t4 = 0
	add $s5 , $zero , 31 # shifted left. decrement one by one.
	add $s6 ,$zero , 32 #boundary
	#travel the loop since all bits have been shifted which means. We have to loop it 31 times.
loop:
	move $s0 , $s3 # s0 is original value again
	srlv $s0 ,$s0 , $s4 # take the lsb of s0 one by one
	and $s0 , $s0 , 1 #other than lsb in s0 , turn other bits into 0 to perform proper addition.
	move $s1 , $s0 # s1 = s0 which means s1 only contain s0's lsb in its lsb. 
	sllv $s1 , $s1 , $s5 #shifting left to reverse it and this shift operation controlled with s5 value.
	add $s2 , $s2 , $s1 # after we done with s1, other than the resulted bit and place other places are full of 0. So we can addition in loop to reverse it.
	add $s4 , $s4 , 1 # add 1 since we have to shift right one more to reach another place.
	sub $s5 , $s5 , 1 #sub 1 in order to put a right place of the bits in reversed form
	blt $s4 , $s6 , loop #loop again
	
	move $v0 , $s2 # v0 = reversed binary form of original input
	#stack restoration
	lw $s0 , 24($sp)
	lw $s1 , 20($sp)
	lw $s2 , 16($sp)
	lw $s3 , 12($sp)
	lw $s4 , 8($sp)
	lw $s5 , 4($sp)
	lw $s6 , 0($sp)
	addi $sp ,$sp , 24
	jr $ra
	
	
	.data
original: .asciiz "Typed input in decimal form: " 
binaryText: .asciiz "Binary form of the input: "
reverseBinaryText: .asciiz "Reversed form of the input in binary: " 
hexaText: .asciiz "Hexadecimal form of original input: "
reverseHexaText: .asciiz "Reversed form of input by hexadecimal is: " 
inputText: .asciiz "type a number: " 
nextLine: .asciiz "\n"