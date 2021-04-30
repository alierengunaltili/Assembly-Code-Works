

	.text
	
	add $t0 , $zero , $zero #a0
	add $t1 , $zero , $zero #a1
	add $t2 , $zero , $zero #a2
	add $t3 , $zero , $zero #tmp
	add $t4 , $zero , $zero
	
	li $v0 , 4
	la $a0 , a0
	syscall
	
	li $v0 , 5
	syscall 
	
	move $t0 , $v0 
	
	li $v0 , 4
	la $a0 , a1
	syscall
	
	li $v0 , 5
	syscall
	
	move $t1 , $v0
	
	li $v0 , 4
	la $a0 , a2
	syscall
	
	li $v0 ,5
	syscall 
	
	move $t2 , $v0	
	
	move $a0 , $t0
	move $a1 , $t1
	move $a2 , $t2
	jal bitCounter
	move $t4 , $v1
	move $t3 , $v0 
	
	li $v0 , 1
	add $a0 , $t4 , $zero
	syscall
	
	
	
		
Exit:
	li $v0 , 10
	syscall
	

bitCounter:
	#stack creation for s registers
	addi $sp , $sp , -32
	sw $s7 , 28($sp)
	sw $s6 , 24($sp)
	sw $s5 , 20($sp)
	sw $s4 , 16($sp)
	sw $s3 , 12($sp)
	sw $s2 , 8($sp)
	sw $s1 , 4($sp)
	sw $s0 , 0($sp)
	
	add $s5 , $zero , $zero # count the occurences
	move $s0 , $a0 #a0 = s0
	move $s1 , $a1 # search place
	move $s2 , $a2 #length of searching part
	move $s4 , $s1 #search place
	add $s3 , $zero , $zero #increment s2 every time to shift right properly
	add $s6 , $zero , 32
	sub $s6 , $s6 , $s2
	
	sllv $s0 , $s0 , $s6
	srlv $s0 , $s0 , $s6 #finding what we are going to searc in s1 
	move $v0 , $s0
	
	add $t7 ,$zero , 32
	add $t6 , $zero , 0
	add $s6 , $zero , 32
	sub $s6 , $s6 , $s2
	move $s3 , $s6
	add $s7 , $s7 , 4
loop:

	move $s4 , $s1
	sllv $s4 , $s4 , $s6
	srlv $s4 , $s4 , $s3
	sub $s6 , $s6 , $s2 
	beq $s4 , $s0 , count
back:
	add $t6 , $t6 , $s2
	blt $t6 , $t7 , loop
	j done
count:
	add $s5 , $s5 , 1
	j back
done:
	move $v1 , $s5
	#restoring s registers after their job is done
	lw $s0 , 28($sp)
	lw $s1 , 24($sp)
	lw $s2 , 20($sp)
	lw $s3 , 16($sp)
	lw $s4 , 12($sp)
	lw $s5 , 8($sp)
	lw $s6 , 4($sp)
	lw $s7 , 0($sp)
	addi $sp , $sp , 32
	jr $ra
	
	
	
	
	.data
space: .asciiz " "
nextLine: .asciiz "\n"
a0: .asciiz "a0 value : " 
a1: .asciiz "a1 value : " 
a2: .asciiz "a2 value : " 
