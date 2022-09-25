# YOUR NAME HERE
# YOUR USERNAME HERE

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

.data
	display: .word 0
	operation: .word 0
.text

.globl main
main:
	 print_str "Hello! Welcome!\n"
	 	# while(true) {
	 _loop:
	 	
	 	lw a0, display # a0 = display
	 	li v0, 1 # print display
	 	syscall
	 		
	 		
	 	# print the operation option	
	 	print_str "\nOperation (=,+,-,*,/,c,q): "
	 	
	 	#ask for a single char input
	 	li v0, 12
	 	syscall
	 	
	 	sw v0, operation # operation = v0
	 	
	 	#print a line
	 	print_str "\n"
	 	
	 	# switch(operation) {
		lw  t0, operation
		beq t0, 'q', _quit
		beq t0, 'c', _clear
		beq t0, '=', _equal
		beq t0, '+', _add
		beq t0, '*', _multiple
		beq t0, '/', _divide
		beq t0, '-', _minus
		
		j   _default

		# indentation is not *required* in asm, but it can be helpful.

		# case 'q':
		_quit:
			# exit the program
			li v0, 10
			syscall
			
			print_str "quit\n"
			j _break

		# case 'c'
		_clear:
			# display = 0
			sw zero, display 
			
			print_str "clear\n"
			j _break
			
			
		_equal:
			print_str "Value: "
			
			#ask for a value
			li v0, 5
	 		syscall
			
			#display = input value
			sw v0, display
			
			j _break
			
		_add:
			# t0 = display
			lw t0, display
			print_str "Value: "
			
			#ask for a value
			li v0, 5
	 		syscall
	 		
	 		#t0 = display + input value
	 		add t0, t0, v0
	 		
	 		# display = t0
	 		sw t0, display
	 		
	 		
			j _break
		
		_minus:
			lw t3, display
			print_str "Value: "
			
			# ask for a value
			li v0, 5
			syscall
			
			#t3 = display - input value
			sub t3, t3, v0
			
			# display = t3
			sw t3, display
		
		
			j _break
		
		_divide:
		
			# t1 = display
			lw t1, display
			print_str "Value: "
			
			#ask for a value
			li v0, 5
	 		syscall
	 		
	 		# if input != 0, to else
	 		bne v0, 0, _else
	 		
	 		# if input == 0, print error msg
	 		print_str "Attempting to divide by 0!\n"
	 		j _endif
	 		
	 		_else:
	 		
	 			# t1 = t1/v0
	 			div t1, t1, v0
	 			# display = t1
	 			sw t1, display
	 		
				j _break
		
			_endif:
				j _break
			
			
		
		_multiple:
			# t2 = display
			lw t2, display
			print_str "Value: "
			
			#ask for a value
			li v0, 5
	 		syscall
			
			# t2 = t2 * v0
			mul t2, t2, v0
			
			sw t2, display
			
			j _break
		# default:
		_default:
			print_str "Huh?\n"
			# no j _break needed cause it's the next line.
	
	_break:
		# }

		# this "j _loop" is already here! you just add the code above before it.
		
	 	#}
	 	j _loop
