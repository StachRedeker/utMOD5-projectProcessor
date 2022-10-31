! Example figure 4-22, "Computer Architecture and Organization"
! by Murdocca & Heuring, ISBN-13 978-0-471-73388-1
	.begin
	.org 0			! start program at 0
a_st	.equ 72		! address of array a
	ld [length], %r1	! %r1 <- length of array
	ld [address], %r2	! %r2 <- address of a
	andcc %r3, %r0, %r3	! %r3 <- 0
loop:	andcc %r1, %r1, %r0	! Test # remaining elements
	be done
	addcc %r1, -4, %r1	! decrement array length
	addcc %r1, %r2, %r4	! address of next element
	ld %r4, %r5		! %r5 <- memory[%r4]
	addcc %r3, %r5, %r3	! sum new element into r3
	ba loop
done:	halt

length: 20
address:a_st
	.org a_st
a:	25
	-10
	33
	-5
	7

.end
