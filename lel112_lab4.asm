# YOUR FULL NAME HERE
# Le Lin
# YOUR USERNAME HERE
# 4488939
.include "lab4_include.asm"

.eqv NUM_DOTS 3

.data
	dotX: .word 10, 30, 50
	dotY: .word 20, 30, 40
	curDot: .word 0
.text
.globl main
main:
	# when done at the beginning of the program, clears the display
	# because the display RAM is all 0s (black) right now.
	jal display_update_and_clear

	_loop:
		# code goes here!
		jal check_input
		jal wrap_dot_position
		jal draw_dots
		jal display_update_and_clear
		jal sleep
	j _loop

	li v0, 10
	syscall

#-----------------------------------------

# new functions go here!

draw_dots:
push ra
	li s0, 0
	_loop:
		# dotX[i]
		mul s1, s0, 4
		lw a0, dotX(s1)
		
		# dotY[i]
		mul s2, s0, 4
		lw a1, dotY(s2)
		
		# if s0 == curDot
		# change dot color to orange
		# else change to white
		lw s3, curDot
		bne s0, s3, _else
		
		# change color to orange
		li a2, COLOR_ORANGE
		
		j _endif #exit
		_else:
			li a2, COLOR_WHITE
		
		_endif:
			
		
		
		jal display_set_pixel
		
		add s0, s0, 1
		blt s0, NUM_DOTS, _loop
	
pop ra
jr ra
		
#-----------------------------------------------------

check_input:
push ra
	jal input_get_keys_held
	# if((v0 & KEY_Z) != 0) curDot = 0
     	and t0, v0, KEY_Z
     	beq t0, 0, _endif_z
        li t0, 0
        sw t0, curDot
    	_endif_z:


	# if((v0 & KEY_X) != 0) curDot = 1
	and t0, v0, KEY_X
     	beq t0, 0, _endif_x
        li t0, 1
        sw t0, curDot
    	_endif_x:

	# if((v0 & KEY_C) != 0) curDot = 2
	and t0, v0, KEY_C
     	beq t0, 0, _endif_c
        li t0, 2
        sw t0, curDot
    	_endif_c:

	# don't change it!
	lw t9, curDot
	mul t9, t9, 4

	# moving right when pressing right arrow key
	and t0, v0, KEY_R
	beq t0, 0, _endif_r
	lw t2, dotX(t9)
	add t2, t2, 1
	sw t2, dotX(t9)
	_endif_r:
	
	# moving left when pressing left arrow key
	and t0, v0, KEY_L
	beq t0, 0, _endif_l
	lw t2, dotX(t9)
	sub t2, t2, 1
	sw t2, dotX(t9)
	_endif_l:
	
	# moving down when pressing down arrow key
	and t0, v0, KEY_D
	beq t0, 0, _endif_d
	lw t2, dotY(t9)
	add t2, t2, 1
	sw t2, dotY(t9)
	_endif_d:
	
	# moving up when pressing up arrow key
	and t0, v0, KEY_U
	beq t0, 0, _endif_u
	lw t2, dotY(t9)
	sub t2, t2, 1
	sw t2, dotY(t9)
	_endif_u:

pop ra
jr ra

# ----------------------------------------------------

wrap_dot_position:
push ra
	
	# t2 = dotX(curDot)
	lw t2, dotX(t9)
	# t3 = dotY(cutDot)
	lw t3, dotY(t9)
	# t2 = t2 & 63
	and t2, t2, 63
	# t3 = t3 & 63
	and t3, t3, 63
	# dotX(curDot) = dotX(curDot) & 63
	sw t2, dotX(t9)
	# dotY(curDot) = dotY(curDot) & 63
	sw t3, dotY(t9)
	
	
pop ra
jr ra



