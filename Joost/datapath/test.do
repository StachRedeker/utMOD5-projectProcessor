restart -f -nowave
do wave.do
force clk 0,1 10ns -r 20ns
force reset '0'
run 10 ns
force reset '1'

# store hex:1234abcd in register 1
force dataIn "00010010001101001010101111001101"
force CMux '1' 
force AMux '0'
force rd "0001"
force rs "0000"
run 20 ns

# store hex:11111111 in register 2
force dataIn "00000000000000000000000000000001"
force CMux '1'
force AMux '0'
force rd "0010"
force rs "0000"
run 20 ns

# shift register 1 register 2 amount of times
force dataIn "00000000000000000000000000000000"
force CMux '0'
force AMux '0'
force rd "0001"
force rs "0010"
force ALU "110"
run 80 ns