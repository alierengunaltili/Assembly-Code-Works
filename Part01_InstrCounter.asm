#as we need the find the total number of lw and add instruction, we need a way to find them among all other instruction.
#and that way is finding add instruction with its unique function value which is 32 in decimal.
#for lw instruction we have to find it from its opcode which is 35 in decimal.
	.text
	
start:
	add $t0 , $zero , $zero #initialization
	add $t1 , $zero , $zero #initialization
	add $t2 , $zero , $zero #initialization
	add $t3 , $zero , $zero #initialization
	la $t2 , start # address where the search begin
	move $a0 , $t2 # a0 = address
	add $t4 , $zero , $zero #initialization
	add $t7 , $zero , 32
	#add $t6, $zero , $zero
	add $t4 , $zero , $zero
	#add $t5 ,$zero , $zero
	#add $t5 , $zero , $zero
	la $t6 , array
	lw $t5 , ($t6)	
	lw $t5 , ($t6)
	lw $t5 , ($t6)
	#lw $t5 , ($t6)

	la $t3 , exit #last address till the search goes
	move $a1, $t3 # a1 = last address
	la $t5 , counterAdd #put the starting address of func into t5 register 
	jal counterAdd #calling the func
	move $t0 , $v1  # v1 = total number of lw instruction
	move $t2 , $v0 #output v0 = gives the total value of add instruction in main (between start - exit)
	la $a1 , endOfTheFunc #a1 = address of the end of the function
	move $a0 , $t5 #address of the beginning of the function
	jal counterAdd #now called it again to search instructions inside the function
	add $t0 , $v1, $t0 # total = lw in main  + lw in func
	add $t2 , $v0 , $t2 # added the previous to reach result
exit:	
	#printing text for add
	li $v0 , 4
	la $a0 , textAdd
	syscall 
	
	#printing result of add instr
	li $v0 , 1
	move $a0 , $t2
	syscall
	
	#printing text
	li $v0 , 4
	la $a0 , textLW
	syscall
	
	#printing result for lw instr
	li $v0 ,1 
	move $a0 , $t0
	syscall

finish:
	#exitting
	li $v0 , 10
	syscall

counterAdd:
	#stack creation
	addi $sp , $sp , -32
	sw $s7 , 28($sp)
	sw $s6 , 24($sp)
	sw $s5 , 20($sp)
	sw $s4 ,16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0 , 0($sp)
	
	add $s7 , $zero , $zero
	add $s6 , $zero , 35 # recognition label for lw instruction since it's opcode equals to 35 in decimal.
	move $s0 , $a0 #s0 = beginning address of the search
	move $s1 , $a1 #s1 = ending address of the search
	add $s2 , $zero , 32 #add recognizer label since add instruction function is 32 in binary
	add $s3 , $zero , $zero #initialization
	add $s4 , $zero , $zero #initialization
	add $s5 , $zero , $zero  # founded add counter
loop:
	lw $s3, 0($s0) #s3 = shows the instruction holded by s0 address right now
	move $s4, $s3  # s4 = instruction
	srl $s4 , $s4 , 26  # extract the opcode only from instruction
	beq $s4 , $s6 ,lwFound #compare the opcode if it is equal to 35 if it is add 1 
	j continue
lwFound:
	addi $s7 , $s7 , 1 # i = i + 1 if lw found
	j skip 
continue:
	sll $s3 , $s3 ,26 #extract the function only to make precise comparison for add instruction.
	srl $s3 , $s3 , 26
	beq $s3 , $s2 , addFound #check the function value is 32 or not if it is add 1.
	j skip
addFound:
	addi $s5 , $s5 , 1 
skip:
	addi $s0 , $s0 , 4 # s0 = next address
	blt $s0 , $s1 , loop 
	
	add $s0 , $s0 , $zero
	move $v1 , $s7
	move $v0 , $s5 # number of times we found add or lw = v0 
	#stack restoration
	lw $s0 , 28($sp)
	lw $s1 , 24($sp)
	lw $s2 , 20($sp)
	lw $s3 , 16($sp)
	lw $s4 , 12($sp)
	lw $s5 , 8($sp)
	lw $s6 , 4($sp)
	lw $s7 , 0($sp)
	addi $sp ,$sp , 28
endOfTheFunc:
	#la $v1 , endOfTheFunc
	jr $ra	
	
	.data
space: .asciiz " " 
newLine: .asciiz "\n"
array: .word 10,20,30
textAdd: .asciiz "Total number of add instruction have been found is : "
textLW: .asciiz "  Total number of LW instruction have been found is :  "
