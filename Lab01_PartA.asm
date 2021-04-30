#LAB01-PART01 Symmetric or Asymmetric Array 
	.text
	# check the array whether it is symmetric or not 
	add $t0 , $zero , $zero #initializing t0 = 0
	add $t1, $zero , $zero  # initialization
	add $t2 , $zero , 2  # put the two value in t2. To find out how many times we have to compare elements 
	add $t3 , $zero , $zero #initialization
	add $t4 , $zero , $zero #initialization 
	add $t5 , $zero , $zero #initialization
	add $t6, $zero , $zero #initialization
	add $t7, $zero , $zero # append the last index of array
	add $t8, $zero , $zero # first index of the array  
	add $t9 , $zero , $zero # while loop i 
	
	addi $t5, $zero , 4 #as every integer is four byte appendt 4 to t5
	la $t0, array #load the array in t0. now t0 is pointing the base address of this array.
	lw $t1 , arrsize # APPEND T1 to our array size from data
	#sub $t1 , $t1 , -1 # sub 1 to reach the exact index of last element  
	
	add $t9 , $t9 , 1 #for the while loop boundary adding one.
	#printing the elemenets process
while:
	#lw $t7 , ($t6) #t7 pointing the last element
	lw $t8 , ($t0) #t8 pointing the first element
	add $a0, $t8, $zero #put the value pointed by t8 into a0 to print.
	#sub $t6 , $t6 , 4 #add 4 to pass next index 
	add $t0 , $t0 , 4 #add 4 to pass next index
	li $v0 , 1
	syscall
	
	li $a0, 32 # line 43-44-45 for printing space character 
    	li $v0, 11  
    	syscall
    	
	add $t9, $t9 , 1 # i = i + 1
	ble $t9 , $t1, while #checking the while condition if we are out of index exitting the while loop
	#printing the elements of array process ending.
	#after this line comparison to find whether it is symmetric or asymmetric starts.
	add $t0 , $zero , $zero #initialization
	add $t6, $zero , $zero #initialization
	add $t9 , $zero , $zero #initialization
	la $t0 ,array #put the array into t0. t0 pointing the first element of array.
	mult $t1, $t5 # (size * 4 ) - 4 gives the last memory address value of an array
	mflo $t6 #put the multiplication result into t6
	sub $t6 , $t6, 4 # needed number to be added the base index to reach the last element
	add $t6 , $t0 , $t6 #t6 currently points the last element of the array.
	div $t1 , $t2 # divide the size to two to found out whether the size is odd or even 
	mfhi $t3 #get the remainder if it is 1 it is odd.
	mflo  $t4 # put the quatient of the division
	#t4 value is crucial since it acts as boundary of our loop 
	#if we have an array such as (1,3,5,3,1) and if we want find the symmetry we have to compare two elements and our range is two basically.
	#if we have an array such as (1,3,5,5,3,1) and if we want find the symmetry we have to compare three elements and our range is three.
	# as it is clear we find it by dividing our arrSize / 2 and putting the result (quatient) into t4 register.
Loop1:
	lw $t7 , ($t6) #t7 pointing the last element
	lw $t8 , ($t0) #t6 pointing the first element
	bne  $t7 , $t8 , L2 # comparison part. in one inequality means asymmetric array. if they are equal pass to other cases.
	sub $t6, $t6 , 4 #come one step closer to middle from last
	add $t0 , $t0 , 4 #move one index closer to middle from starting point
	add $t9 , $t9 ,1 # i = i + 1
	ble $t9 , $t4 , Loop1 # if we compare the whole elements exit the loop and as we haven't jump to L2 case. That means array is symmetric.
	j L1 #go to L1 which means symmetric conditions are provided
L1:
	la $a0 , str1 #print str1
	li $v0 , 4   
	syscall
	j Exit #go to exit
L2: 
	la $a0 , str2 #print str2
	li $v0, 4
	syscall
Exit:
	li $v0 , 10 #exitting 
	syscall 
	
	.data
array: .word  10,30,40,30,1
arrsize: .word 5
str1: .asciiz "Symmetric Array" 
str2: .asciiz "Asymmetric Array"
