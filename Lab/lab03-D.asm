.text 
	# $8 : initial value for which we look for trailing zeros
	# $9 : the counter to keeps track of # of trailing zeros (result)calculate the 0
	# $10 :  the result of the AND with the mask
	# 'fatal flaw' the intial value we look for can not be 0, otherwise the loop never end.
	# for fix this problem we can add a condiction at beginning.
	# such that if beq $8 = 0, then $9 = 1 system end. 
	
	ori $8, $0, 0x0   	# same as "addi $8, $0, 0xc800"

	ori $9, $0, 0		# counter
loop:
	andi $10, $8, 1
	bne $10, $0, exit
	addi $9, $9, 1
	srl $8, $8, 1
	b loop 
	
exit:
	nop			# answer is in $9
	
