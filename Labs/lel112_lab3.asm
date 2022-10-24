# YOUR NAME HERE
# Le Lin
# YOUR USERNAME HERE
# lel112

# preserves a0, v0
.macro print_str %str
	.data
	print_str_message: .asciiz %str
	.text
	push a0
	push v0
	la a0, print_str_message
	li v0, 4
	syscall
	pop v0
	pop a0
.end_macro

# -------------------------------------------
.eqv ARR_LENGTH 5
.data
	arr: .word 100, 200, 300, 400, 500
	message: .asciiz "testing!"
.text
# -------------------------------------------
.globl main
main:
	#call input_arr function
	jal input_arr
	
	#call print_arr Function
	jal print_arr
	
	#call print_char function
	jal print_chars
	# exit()
	li v0, 10
	syscall
# -------------------------------------------

# ---------------------------------------------------
input_arr:
push ra
	# all the code will go here
	li t0, 0
	_loop:
		# ask for a input from user
		print_str "enter value: "
		li v0, 5
		syscall
		
		# arr[i] = v0 
		mul t1, t0, 4
		sw v0, arr(t1)
		
		
		# for loop
		add t0, t0, 1
		blt t0, ARR_LENGTH, _loop

pop ra
jr ra

# ---------------------------------------------------
print_arr:
push ra
	# all the code will go here
	li t0, 0
	_loop:
		print_str "arr["
		
		#a0 = t0
		move a0, t0
		
		#print a0 -- the index
		li v0, 1
		syscall
		
		print_str "] = "
		
		# print arr[i]
		mul t1, t0, 4
		lw a0, arr(t1)
		li v0, 1
		syscall
	
		print_str "\n"
		
		# for t0=0; t0<arc_length; t0++
		add t0, t0, 1
		blt t0, ARR_LENGTH, _loop

pop ra
jr ra
# ---------------------------------------------------


print_chars:
push ra
	li t0, 0
	_loop:
		# load byte to a0
		lb a0, message(t0)
		
		# if byte = '0', exit the loop
		beq a0, 0, _exit
		
		# print out the char
		li v0, 11
		syscall
		
		# print a new line
		print_str "\n"
		
		# increment the index t0 by 1
		add t0, t0, 1
		
		# if byte != '0', continue the loop
		lb t2, message(t0)
		bne t2, 0, _loop
		
_exit:	
pop ra
jr ra
