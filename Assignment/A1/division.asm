# UVic CSC 230, Fall 2020
# Assignment #1, part C

# Student name: Mengyang Zhanf
# Student number: V00938109


# Compute M / N, where M must be in $8, N must be in $9,
# and M / N must be in $15.
# N will never be 0


.text
start:
	lw $8, testcase3_M
	lw $9, testcase3_N

# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
	
loop:
	beq $9, 0, end #if the value in $9 is 0, loop end
	blt $8, $9, end #if the value in $8 is smaller than $9, loop end
	sub $8, $8, $9 #$8-$9 store in $8
	addi $15, $15, 1 #$15 add 1
	bne $8, $9, loop
	
end:
	nop
	
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE

exit:
	add $2, $0, 10
	syscall
		

.data

# testcase1: 370 / 120 = 3
#
testcase1_M:
	.word	370
testcase1_N:
	.word 	120
	
# testcase2: 24156 / 77 = 313
#
testcase2_M:
	.word	24156
testcase2_N:
	.word 	77
	
# testcase3: 33 / 120 = 0
#
testcase3_M:
	.word	33
testcase3_N:
	.word 	120
