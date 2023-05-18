# UVic CSC 230, Fall 2020
# Assignment #1, part A

# Student name: Mengyang Zhang
# Student number: V00938109

 
# Compute odd parity of word that must be in register $8
# Value of odd parity (0 or 1) must be in register $15


.text

start:
	lw $8, testcase1  # STUDENTS MAY MODIFY THE TESTCASE GIVEN IN THIS LINE
	
# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

	addi $9, $0, 32 #$9 <-$0+sign-extend[32] get 32 in $8
	addi $11, $0, 2 #$11 <-$0+sign-extend[2] get 2 in $11
	
	add $13, $13, 1
	
loop:
	div $9, $9, $11 # 16, 8, 4, 2, 1
	sllv $10, $8, $9 # shift $8 left logically with the value in $9 place store in $10 (for int i=1; i<32;1++)
	xor $8, $10, $8 #change to binary
	
	beq $9, $13, end
	
	j loop

end:
	srl $8,$8, 31
	add $15,$0, $8

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE


exit:
	add $2, $0, 10
	syscall
		

.data

testcase1:
	.word	0x00200020    # odd parity is 1

testcase2:
	.word 	0x00300020    # odd parity is 0
	
testcase3:
	.word  0x1234fedc     # odd parity is 0

