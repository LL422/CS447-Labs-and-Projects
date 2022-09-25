.data
	x: .word 0
	y: .word 0
.text

.global main
main:
	# loading immediates into registers
	li t0, 1
	li t1, 2
	li t2, 3
	
	# moving values between the registers
	move a0, t0
	move v0, t1
	move t2, zero
	
	# print 123
	li a0, 123
	li v0, 1
	syscall
	
	# print a line
	li a0, '\n'
	li v0, 11
	syscall
	
	# print 456
	li a0, 456
	li v0, 1
	syscall
	
	# print a line
	li a0, '\n'
	li v0, 11
	syscall
	
	# ask for an input
	li v0, 5
	syscall
	
	# setting the variables
	sw v0, x # x = v0
	
	# ask for an input
	li v0, 5
	syscall
	
	# setting the variables
	sw v0, y # x = v0
	
	# load values to regiesters
	lw t3, x
	lw t4, y
	
	
	# print the sum of x and y
	li a0, 0
	add a0, t3, t4 #a0 = t3 + t4
	li v0, 1
	syscall
	
	# exit the program
	li v0, 10
	syscall
