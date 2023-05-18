# UVic CSC 230, Fall 2020
# Assignment #1, part B

# Student name: Mengyang Zhang
# Student number: V00938109


# Compute the reverse of the input bit sequence that must be stored
# in register $8, and the reverse must be in register $15.


.text
start:
	lw $8, testcase3   # STUDENTS MAY MODIFY THE TESTCASE GIVEN IN THIS LINE
	
# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

	add $9,$9,$8
	li $10, 1
	li $12, 0
	
loop:
	sll $15, $15, 1 #shift left by logical by 1 place
	and $11, $9, $10 #get the first bit 
	or $15, $15, $11 #or the value
	srl $9, $9, 1 #shift right $9
	add $12, $12,1
	blt $12,32,loop

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE

exit:
	add $2, $0, 10
	syscall
	
	

.data

testcase1:
	.word	0x00200020    # reverse is 0x04000400

testcase2:
	.word 	0x00300020    # reverse is 0x04000c00
	
testcase3:
	.word	0x1234fedc     # reverse is 0x3b7f2c48
