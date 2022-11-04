readIO %r8					! let's start with getting user data
add %r9, 255, %r9			! store 011111111 in %r9
and %r8, %r9, %r9			! extract the wanted C value
st %r9, [C]					! store the wanted C value in memory
srl %r8, 8, %r8				! shift the read IO 8 places to extract the halving bit
st %r8, [H]					! and store the halving value
ld [H], %r4               	! loads whether or not we want half of the result
add %r2, 1, %r2
add %r6, 1, %r6 			! a 1 need for later
add %r7, 1, %r7				! a 1 need for later
start: ld [C], %r5			! keeps track of the iterations
addcc %r5, -1, %r5
st %r5, [C]
bneg ending
and %r0, %r3, %r3			! clear reg3
add %r2, %r3, %r3			! adds %r1 to %r2 and stores in %r3
add %r1, %r3, %r3			! ^^^^
and %r0, %r1, %r1			! clear reg1
add %r2, %r1, %r1			! stores %r2 in %r1
and %r0, %r2, %r2			! clear reg2
add %r3, %r2, %r2       	! %r2 will contain the result
ba start
ending: orcc %r4, %r0, %r0	! check if we want the full result
be display
andcc %r4, %r6, %r6	 		! check if we want half of the result
bne halving     
halving: and %r2, %r7, %r7  ! check if the last bit is a 1 (then the number is odd)
srl %r2, 1, %r2				! divide the result by 2 using a shift right
add %r7, %r2, %r2			! and add the 1 back if it was odd
display: display %r2
halt             			! display the result
C: 0                    	! how many times we should run the function
H: 0                     	! H = 0, not halve; H = 1, halve 
