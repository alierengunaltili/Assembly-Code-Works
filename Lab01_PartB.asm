	.text 
	#simple operation
	
	add $t0 , $zero , $zero #initialization
	add $t1 , $zero , $zero #initialization
	add $t2, $zero , $zero #initialization
	add $t3 , $zero , $zero #initialization


	li $v0 ,4 #print the txt1 
	la $a0 , txt1
	syscall
	#printing one space to more easy to see
	li $a0, 32 # line 43-44-45 for printing space character 
    	li $v0, 11  
    	syscall 
    	
    	#taking the input
	li $v0 , 5
	syscall 
	
	move $t0 , $v0 #taking the input and putting into the t0 register
	
	
	#printing the input value 
	add $a0 , $t0 , $zero 
	li $v0 , 1
	syscall 
	
	#go to next line
	li $v0 ,4 
	la $a0 , nextLine
	syscall 
	
	li $v0 ,4 #printing txt2 for B value
	la $a0 , txt2
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
	
	li $v0 ,4 
	la $a0 , txt3 #printing txt3 for C value
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
	
	li $v0 ,4 
	la $a0 , txt4 #printing the txt4 for D value
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
	
	li $v0 ,4 
	la $a0 , result # printing result text 
	syscall
	
	#OPERATION BEGIN
	#t0 = a , t1 = b , t2 =c , t3 = d 
	#operation is a * (b -c ) % d
	sub $t1 , $t1, $t2 #subtraction t1 = t1 - t2
	mult $t0 , $t1 #t1 * t0 
	mflo $t1 #put the result of multiplication into t1 
	div $t1 , $t3 # doing the (a* (b-c)) / d division
	mfhi $t1 #update the t1 register's value by putting the remainder of division
 	add $a0 , $t1 , $zero #put the result into a0 to print 
	li $v0 , 1
	syscall 
	
	li $v0 , 10 #extting 
	syscall
	
	
	.data
nextLine: .asciiz "\n"
txt1: .asciiz "Enter a value for A"
txt2: .asciiz "Enter a value for B"
txt3: .asciiz "Enter a value for C"
txt4: .asciiz "Enter a value for D"
result: .asciiz "Result of the operation is: " 
