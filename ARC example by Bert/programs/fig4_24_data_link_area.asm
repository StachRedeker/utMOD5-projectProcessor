! fig. 4-24, , "Computer Architecture and Organization"
! by Murdocca & Heuring, ISBN-13 978-0-471-73388-1
! main
	.begin
	.org 0
	ld [op1], %r1
	ld [op2], %r2
	sethi x, %r5
	srl %r5, 10, %r5
! store data in data link area
	st %r1, [x]
	st %r2, [x+4]
	
	call add_2
	ld [x+8], %r3
	st %r3, [op3]
	halt


! Called routine
! x[2] <- x[0] + x[1]
add_2:	ld %r5, %r8
	ld %r5+4, %r9
	addcc %r8, %r9, %r10
	st %r10, %r5+8
	jmpl %r15+4, %r0

	.org 60 ! check that you do not write in the program code!!
!data link area
x:	.dwb 3

! data
op1:	53
op2:	10
op3:	0

	.end

