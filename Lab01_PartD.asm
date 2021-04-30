
	.text
	
	add $t0 , $zero , $zero #a value
	add $t1 , $zero, $zero #b value
	add $t2, $zero , $zero #c value
	add $t3 , $zero , $zero #d value
	add $t4 , $zero , $zero #temp to be used in operation
	add $t5 , $zero , $zero #temp to be used in operation
	add $t6, $zero , $zero #temp to be used in operation 
	
	
	#taking the input A process 
	li $v0 , 4
	la $a0 , txt0
	syscall
	
	#takigin the integer input
	li $v0 , 5
	syscall
	
	move $t0, $v0 #take the input and put it into t0 register 
	
	#taking the input B process
	li $v0 ,4 
	la $a0 , txt1
	syscall
	#printing one space to more easy to see
	li $a0, 32 # line 43-44-45 for printing space character 
    	li $v0, 11  
    	syscall 
    	
    	#taking the input
	li $v0 , 5
	syscall 
	
	move $t1 , $v0 #taking the input and putting into the t1 register
	
	#printing the input value 
	add $a0 , $t1 , $zero 
	li $v0 , 1
	syscall 
	
	
	#go to next line
	li $v0 ,4 
	la $a0 , nextLine
	syscall 
	#end of the taking B input
	
	#taking the input C process
	li $v0 ,4 
	la $a0 , txt2
	syscall
	#printing one space to more easy to see
	li $a0, 32 # line 43-44-45 for printing space character 
    	li $v0, 11  
    	syscall 
    	
    	#taking the input
	li $v0 , 5
	syscall 
	
	move $t2 , $v0 #taking the input and putting into the t2 register
	
	#printing the input value 
	add $a0 , $t2 , $zero 
	li $v0 , 1
	syscall 

	#go to next line
	li $v0 ,4 
	la $a0 , nextLine
	syscall 
	

	#taking the input D process 
	li $v0 ,4 
	la $a0 , txt3
	syscall
	#printing one space to more easy to see
	li $a0, 32 # line 43-44-45 for printing space character 
    	li $v0, 11  
    	syscall 
    	
    	#taking the input
	li $v0 , 5
	syscall 
	
	move $t3 , $v0 #taking the input and putting into the t3 register
	
	#printing the input value 
	add $a0 , $t3 , $zero 
	li $v0 , 1
	syscall 
	
	
	#go to next line
	li $v0 ,4 
	la $a0 , nextLine
	syscall 
	
	
	#result process
	mult $t2 , $t3  #t1 *t2 C*D
	mflo $t4 #b * c putting into the t4 t4 = b *c 
	
	sub $t4 , $t4 , $t0 # c* d - a
	
	div $t0, $t1 
	mflo $t5 # a/b put it into t5 register quatient
	
	div $t4 , $t1
	mfhi $t4
	
	add $t6, $t5 , $t4
	#add $t5 , $t5, $t4 # a/b + c*d - a 
	#div $t5, $t1 # modulo b
	#mfhi $t6
	#div $t3 , $t1 # D / B
	#mflo $t5 # put the quatient to t5 , t5 = D / B 
	
	#add $t3 , $t4 , $t5 # x = (B*C) + (D/B)
	#sub $t3 , $t3 , $t2 # t3 = x - C
	
	#div $t3 , $t1 # divide the result of paranthesis to B 
	#mfhi $t6 # put the remainder into t0 register which represent the A value.
	
	#printing the operation in text
	li $v0 , 4
	la $a0 , operation 
	syscall
	
	#go to next line
	li $v0 ,4 
	la $a0 , nextLine
	syscall 
	
	#printing the result text 
	li $v0 ,4 
	la $a0 , result
	syscall
	
	
	#printing the result 
	add $a0 , $zero , $t6
	li $v0 , 1
	syscall 
	
	.data
txt0: .asciiz "Enter value for A "
txt1: .asciiz "Enter value for B"
txt2: .asciiz "Enter value for C"
txt3: .asciiz "Enter value for D"
nextLine: .asciiz "\n"
result: .asciiz "Result of the given operation: "
operation: .asciiz "( (A / B) + (C * D - A) ) % B "
