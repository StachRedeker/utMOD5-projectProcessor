.begin
.org 0

ld [H], %r4               ! loads whether or not we want half of the result
add %r0, %r0, %r1
add %r0, 1, %r2
add %r0, 1, %r6 		! permanent 1

start: ld [C], %r5        ! load the wanted value (*10)
addcc %r5, -1, %r5
st %r5, [C]
bneg ending

add %r1, %r2, %r3         ! start of the Fibonacci calculation
add %r0, %r2, %r1
add %r0, %r3, %r2         ! %r2 will contain the result
ba start

ending: andcc %r4, %r6, %r6       ! check if we want half of the result
be halving
orcc %r4, %r0, %r0             ! check if we want the full result
be display

halving: srl %r2, 1, %r2   ! divide the result by 2 using a shift right
ba display


display: halt             ! display the result

C: 3                     ! how many times we should run the function
H: 0                      ! should we halve?

.end
