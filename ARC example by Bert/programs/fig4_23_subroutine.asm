! fig. 4-23, "Computer Architecture and Organization"
! by Murdocca & Heuring, ISBN-13 978-0-471-73388-1
! main
	.begin
	.org 0
	ld [x], %r1
	ld [y], %r2
	call add_1
	st %r3, [z]
	halt


! Called routine
add_1:	addcc %r1, %r2, %r3
	jmpl %r15+4, %r0
! data
	.org 40
x:	53
y:	10
z:	0
	.end
