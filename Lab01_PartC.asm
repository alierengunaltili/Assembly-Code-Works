

	.text
	
	add $t0, $zero , $zero
	add $t1 , $zero , $zero
	add $t2 , $zero , $zero #i for while loop
	add $t3, $zero , $zero # arrzsize 
	add $t4 , $zero , $zero #sum
	add $t5, $zero , $zero #max value 
	add $t6 , $zero , $zero #min value
	add $t7 , $zero , $zero #avarage value
	
	
	
	lw $t3 , arrsize 
	sub $t3 , $t3 , 1
	la $t0 , array 
	lw $t5 , ($t0)	
	lw $t6 , ($t0)
	
While: 
	lw $t1 , ($t0)
	add $a0, $t0, $zero
	li $v0 , 34
	syscall 
	
	add $t4, $t4 , $t1
	
	li $a0, 32 # line 43-44-45 for printing space character 
    	li $v0, 11  
    	syscall
	
 	blt $t1 , $t6 , Min
 	j L2
Min:
 	la $t6 , ($t1)
L2:
	bgt $t1 , $t5 , Max
	j L1 
Max:    
	la $t5 , ($t1)
	
L1:  	
	#printing the value attached memory address
	li $v0 , 1 
	add $a0 , $t1 , $zero
	syscall
	
	addi $t0 , $t0 , 4
	
	#skipping to the next line for convenient output illustration
	li $v0, 4 
	la $a0 , newLine
	syscall 
	
	addi $t2, $t2 , 1
	ble $t2, $t3 , While
	
	la $a0 , sum
	li $v0 , 4
	syscall 
	
	add $a0 , $t4 , $zero
	li $v0 1
	syscall
	
	#skipping to the next line for convenient output illustration
	li $v0, 4 
	la $a0 , newLine
	syscall 
	
	la $a0 , max #printing "max value" string
	li $v0 , 4
	syscall 
	
	add $a0 ,$t5 , $zero #PRÝNTÝNG max value
	li $v0 , 1
	syscall 
	
	#skipping to the next line for convenient output illustration
	li $v0, 4 
	la $a0 , newLine
	syscall 
	
	la $a0 , min #printing "min value" string
	li $v0 , 4
	syscall 
	
	add $a0 , $t6 , $zero #printing min value
	li $v0 , 1
	syscall
	
	#skipping to the next line for convenient output illustration
	li $v0, 4 
	la $a0 , newLine
	syscall 
	
	add $t3 , $t3 , 1
	div $t4 , $t3 
	mflo $t7 
	
	la $a0 , avarage
	li $v0 ,4 
	syscall
	
	add $a0 , $t7 , $zero
	li $v0 , 1
	syscall
	

	j Exit
	
	
Exit:	
	li $v0 , 10
	syscall
	
	
	
	
	
	
	
	.data
array: .word 3,3,-3,7,5,6, 14
arrsize: .word 7
newLine: .asciiz "\n" 
sum: .asciiz "sum is : "
avarage: .asciiz "avarage is : "
max: .asciiz "max value is : "
min: .asciiz "min value is : "
