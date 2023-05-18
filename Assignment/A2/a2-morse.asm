.text


main:	



# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

	## Test code that calls procedure for part A
	jal 	save_our_souls
	addi 	$a0, $zero, 0x40
	jal  	morse_flash

	addi 	$a0, $zero, 0x35
	jal 	morse_flash

	addi 	$a0, $zero, 0x30
	jal 	morse_flash
			
	## morse_flash test for part B
	addi 	$a0, $zero, 0x10
	
	# flash_message test for part C
	la 	$a0, test_buffer
	jal 	flash_message
	
	# letter_to_code test for part D
	# the letter 'P' is properly encoded as 0x46.
	addi 	$a0, $zero, 'P'
	jal 	letter_to_code
	
	# letter_to_code test for part D
	# the letter 'A' is properly encoded as 0x21
	addi 	$a0, $zero, 'A'
	jal 	letter_to_code
	
	# letter_to_code test for part D
	# the space' is properly encoded as 0xff
	addi 	$a0, $zero, ' '
	jal 	letter_to_code
	
	# encode_message test for part E
	# The outcome of the procedure is here
	# immediately used by flash_message
	la 	$a0, message01
	la 	$a1, buffer01
	jal 	encode_message
	la 	$a0, buffer01
	jal 	flash_message
	
	# Proper exit from the program.
	addi 	$v0, $zero, 10
	syscall

	
	
###########
# A
save_our_souls:
	addi	$sp, $sp, -4	
	sw	$ra, 0($sp)	
	jal 	seven_segment_on
	jal 	delay_short
	jal 	seven_segment_off
	jal 	delay_long
	jal 	seven_segment_on
	jal 	delay_short
	jal 	seven_segment_off
	jal 	delay_long
	jal 	seven_segment_on
	jal 	delay_short
	jal 	seven_segment_off
	jal 	delay_long
	jal 	seven_segment_on
	jal 	delay_long
	jal 	seven_segment_off
	jal 	delay_long
	jal 	seven_segment_on
	jal 	delay_long
	jal 	seven_segment_off
	jal 	delay_long
	jal 	seven_segment_on
	jal 	delay_long
	jal 	seven_segment_off
	jal 	delay_long
	jal 	seven_segment_on
	jal 	delay_short
	jal 	seven_segment_off
	jal 	delay_long
	jal 	seven_segment_on
	jal 	delay_short
	jal 	seven_segment_off
	jal 	delay_long
	jal 	seven_segment_on
	jal 	delay_short
	jal 	seven_segment_off
	jal 	delay_long

	lw 	$ra, 0($sp)
	addi 	$sp, $sp, 4
	jr 	$ra


# B
morse_flash:
	addiu	$sp, $sp, -16
	sw	$s7, 0($sp)
	sw	$a0, 4($sp)
	sw	$s6, 8($sp)
	sw	$ra, 12($sp)

	li	$s5, 8
	li	$t7, 4
	li	$s7, 0
	li	$s6, 0
	
	beq 	$a0, 0xff, measure
	andi	$s7, $a1, 0xf
	srl	$a0, $a0, 4
	andi	$s7, $a3, 0xf
	subu 	$t7, $t7, $s6
	srlv 	$s7, $s7, $t7
	
loop:
	beqz	$s6, end
	and	$t0, $s7, $s5
	srl	$s5, $s5, 1
	addiu	$s6, $s6, -1

	beq	$t0, $0, d
	bne	$t0, $0, D
	j	loop

end:

	lw	$ra, 12($sp)
	lw	$s6, 8($sp)
	lw	$a0, 4($sp)
	lw	$s7, 0($sp)
	addiu	$sp, $sp, 16
	jr	$ra
	
measure:
	jal	delay_long	
	jal	delay_long
	jal	delay_long	
	
D:
	jal	seven_segment_on
	jal	delay_long
	jal	seven_segment_off
	jal 	delay_long
	j 	loop
	
d:
	jal 	seven_segment_on
	jal	delay_short
	jal	seven_segment_off
	jal	delay_long
	j	loop

	


###########
# C
flash_message:
	addiu	$sp, $sp, -8	
	sw	$ra, 0($sp)	
	sw	$s7, 4($sp)	
	add	$s7, $a0, $0
	
L:
	lbu	$t0, 0($s7)
	beq	$t0, $0, exit 
	add	$a0, $t0, $0
	jal	morse_flash
	addiu	$s7, $s7, 1
	j	L
	
exit:
	lw	$s7, 4($sp)
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 8
	jr	$ra
	
	
###########
# D
letter_to_code:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)

	la	$t5, codes
LOOP:
	lbu	$t0, 0($t5)
	beq	$t0, $0, LOOP_exit
	bne	$t0, $a0, END
	addiu	$t6, $0, 0
	addiu	$t7, $0, 0
	addiu	$t5, $t5, 1
	
LOOP2:
	lbu	$t0, 0($t5)
	beq	$t0, $0, LOOP2_exit
	sll	$t6, $t6, 1
	beq	$t0, '.', ADD
	addiu	$t6, $t6, 1
	
LOOP_exit:
	addiu	$v0, $0, 0xff
	j	QUIT

LOOP2_exit:
	sll 	$t7, $t7, 4
	j	FIND
	
QUIT:
	lw 	$ra, 0($sp)
	addiu 	$sp, $sp, 4
	jr 	$ra	
	
ADD:
	addiu	$t5, $t5, 1
	addiu	$t7, $t7, 1
	j	LOOP2
		
FIND:
	or  	$v0, $t7, $t6
	
END:
	addiu	$t5, $t5, 8
	j	LOOP




###########
# E

encode_message:
	addiu	$sp, $sp, -12
	sw 	$s6, 8($sp)
	sw	$s7, 4($sp)
	sw 	$ra, 0($sp)

	add 	$s6, $a1, $0
	add 	$s7, $a0, $0
	
encode:
	lbu	$t0, 0($s7)
	beq	$t0, $0, code_exit
	add 	$a0, $t0, $0
	jal 	letter_to_code
	sb	$v0, 0($s6)
	addiu 	$s7, $s7, 1 
	addiu 	$s6, $s6, 1
	j 	encode
	
code_exit:
	sb	$0, 0($s6)	
	lw 	$s6, 8($sp)
	lw 	$s7, 4($sp)
	lw 	$ra, 0($sp)
	addiu	$sp, $sp, 12
	jr 	$ra

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE

#############################################
# DO NOT MODIFY ANY OF THE CODE / LINES BELOW

###########
# PROCEDURE
seven_segment_on:
	la $t1, 0xffff0010     # location of bits for right digit
	addi $t2, $zero, 0xff  # All bits in byte are set, turning on all segments
	sb $t2, 0($t1)         # "Make it so!"
	jr $31


###########
# PROCEDURE
seven_segment_off:
	la $t1, 0xffff0010	# location of bits for right digit
	sb $zero, 0($t1)	# All bits in byte are unset, turning off all segments
	jr $31			# "Make it so!"
	

###########
# PROCEDURE
delay_long:
	add $sp, $sp, -4	# Reserve 
	sw $a0, 0($sp)
	addi $a0, $zero, 600
	addi $v0, $zero, 32
	syscall
	lw $a0, 0($sp)
	add $sp, $sp, 4
	jr $31

	
###########
# PROCEDURE			
delay_short:
	add $sp, $sp, -4
	sw $a0, 0($sp)
	addi $a0, $zero, 200
	addi $v0, $zero, 32
	syscall
	lw $a0, 0($sp)
	add $sp, $sp, 4
	jr $31




#############
# DATA MEMORY
.data
codes:
	.byte 'A', '.', '-', 0, 0, 0, 0, 0
	.byte 'B', '-', '.', '.', '.', 0, 0, 0
	.byte 'C', '-', '.', '-', '.', 0, 0, 0
	.byte 'D', '-', '.', '.', 0, 0, 0, 0
	.byte 'E', '.', 0, 0, 0, 0, 0, 0
	.byte 'F', '.', '.', '-', '.', 0, 0, 0
	.byte 'G', '-', '-', '.', 0, 0, 0, 0
	.byte 'H', '.', '.', '.', '.', 0, 0, 0
	.byte 'I', '.', '.', 0, 0, 0, 0, 0
	.byte 'J', '.', '-', '-', '-', 0, 0, 0
	.byte 'K', '-', '.', '-', 0, 0, 0, 0
	.byte 'L', '.', '-', '.', '.', 0, 0, 0
	.byte 'M', '-', '-', 0, 0, 0, 0, 0
	.byte 'N', '-', '.', 0, 0, 0, 0, 0
	.byte 'O', '-', '-', '-', 0, 0, 0, 0
	.byte 'P', '.', '-', '-', '.', 0, 0, 0
	.byte 'Q', '-', '-', '.', '-', 0, 0, 0
	.byte 'R', '.', '-', '.', 0, 0, 0, 0
	.byte 'S', '.', '.', '.', 0, 0, 0, 0
	.byte 'T', '-', 0, 0, 0, 0, 0, 0
	.byte 'U', '.', '.', '-', 0, 0, 0, 0
	.byte 'V', '.', '.', '.', '-', 0, 0, 0
	.byte 'W', '.', '-', '-', 0, 0, 0, 0
	.byte 'X', '-', '.', '.', '-', 0, 0, 0
	.byte 'Y', '-', '.', '-', '-', 0, 0, 0
	.byte 'Z', '-', '-', '.', '.', 0, 0, 0
	
message01:	.asciiz "A A A"
message02:	.asciiz "SOS"
message03:	.asciiz "WATERLOO"
message04:	.asciiz "DANCING QUEEN"
message05:	.asciiz "CHIQUITITA"
message06:	.asciiz "THE WINNER TAKES IT ALL"
message07:	.asciiz "MAMMA MIA"
message08:	.asciiz "TAKE A CHANCE ON ME"
message09:	.asciiz "KNOWING ME KNOWING YOU"
message10:	.asciiz "FERNANDO"

buffer01:	.space 128
buffer02:	.space 128
test_buffer:	.byte 0x30 0x37 0x30 0x00    # This is SOS
