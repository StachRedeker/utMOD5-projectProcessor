! iteratively perform %r2 <- %r1 + %r2 until %r1 is greater or equal zero
.begin
	.org 0
	addcc %r0, 300, %r1 
	sethi 0x3FFFFF, %r2
lbl:	addcc %r2, %r1, %r2
	bneg lbl
	halt
.end
