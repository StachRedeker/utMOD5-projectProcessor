! simple test; add two numbers 4 and 8 and store the result at memory address 28
	.begin
	.org 0
x	.equ 28
	addcc %r0, 4, %r1
	addcc %r0, 8, %r2
	addcc %r1, %r2, %r4
	st %r4, [x]
	halt
	.end


