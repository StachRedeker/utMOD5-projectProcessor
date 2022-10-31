! fig. 4-25, "Computer Architecture and Organization"
! by Murdocca & Heuring, ISBN-13 978-0-471-73388-1
! main
	.begin
	.org 0
	addcc %r0, 128, %r14 ! init stack pointer (%r14) to address 128
	ld [op1], %r1
	ld [op2], %r2
	addcc %r14, -4, %r14
	st %r1, %r14
	addcc %r14, -4, %r14
	st %r2, %r14
	call add_3
	ld %r14, %r3
	addcc %r14, 4, %r14
	st %r3, [op3]
	halt


! Called routine
! Arguments are on stack
! %sp[0] <- %sp[0] + %sp[4]
add_3:	ld %r14, %r8
	addcc %r14, 4, %r14
	ld %r14, %r9
	addcc %r8, %r9, %r10
	st %r10, %r14
	jmpl %r15+4, %r0

! data
op1:	53
op2:	10
op3:	0
	.end
