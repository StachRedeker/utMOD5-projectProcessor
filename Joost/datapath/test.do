restart -f -nowave
do wave.do
force clk 0,1 10ns -r 20ns
force reset '0'
run 1 ns
force reset '1'
run 9 ns

# load hex:1234abcd and store in register 1
force dataIn "00010010001101001010101111001101"
force simm10 "0000000000"
force rr '0'
force CMux '1' 
force AMux '0'
force rd "0001"
force rs "0000"
force ALU "111"
run 100 ns

# load hex:00000004 from memory and store in register 2
force dataIn "00000000000000000000000000000100"
force simm10 "0000000000"
force rr '0'
force CMux '1'
force AMux '0'
force rd "0010"
force rs "0000"
force ALU "111"
run 120 ns

# shift register 1 register 2 amount of times
force dataIn "00000000000000000000000000000000"
force simm10 "0000000000"
force rr '1'
force CMux '0'
force AMux '0'
force rd "0001"
force rs "0010"
force ALU "011"
run 120 ns

# read register 2 and write it to memory
force dataIn "00000000000000000000000000000010"
force simm10 "0000000000"
force rr '0'
force CMux '0'
force AMux '1'
force rd "0000"
force rs "0010"
force ALU "111"
run 120 ns

# add register 2 to register 1 result should be hex:01234AC0
force dataIn "00000000000000000000000000000000"
force simm10 "0000000000"
force rr '1'
force CMux '0'
force AMux '0'
force rd "0001"
force rs "0010"
force ALU "110"
run 120 ns

# subtract from register 1 hex:40 result should be hex:01234A80
force dataIn "00000000000000000000000000000000"
force simm10 "1111000000"
force rr '0'
force CMux '0'
force AMux '0'
force rd "0001"
force rs "0000"
force ALU "110"
run 120 ns

# store in -50 in register 4 hex:FFFFFFCE 
force dataIn "11111111111111111111111111001110"
force simm10 "0000000000"
force rr '0'
force CMux '1'
force AMux '0'
force rd "0100"
force rs "0000"
force ALU "111"
run 120 ns

# store in 100 in register 5 hex:00000064 
force dataIn "00000000000000000000000001100100"
force simm10 "0000000000"
force rr '0'
force CMux '1'
force AMux '0'
force rd "0101"
force rs "0000"
force ALU "111"
run 120 ns

# add register 4 to register 5 result should be dec:50 or hex:00000032 
force dataIn "00000000000000000000000000000000"
force simm10 "0000000000"
force rr '1'
force CMux '0'
force AMux '0'
force rd "0101"
force rs "0100"
force ALU "110"
run 120 ns

# load instruction from memory into instruction register 
force dataIn "00000000000011011000000000000000"
force simm10 "0000000000"
force rr '0'
force CMux '1'
force AMux '0'
force rd "1111"
force rs "0000"
force ALU "111"
run 120 ns

run 60 ns