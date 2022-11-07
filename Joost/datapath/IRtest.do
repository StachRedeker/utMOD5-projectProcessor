restart -f -nowave
do wave.do
force clk 0,1 10ns -r 20ns
force reset '0'
run 1 ns
force reset '1'
run 9 ns

# load instruction hex:00012345 from memory and store in IR (%r15)
force memory_data_out "00000000000000010010001101000101"
force simm10 "0000000000"
force rr '0'
force CMux '1'
force AMux '0'
force rd "1111"
force rs "0000"
force ALU "111"
run 120 ns

# perform instruction
# load hex:1234abcd and store in register 1
force memory_data_out "00010010001101001010101111001101"
force simm10 "0000000000"
force rr '0'
force CMux '1' 
force AMux '0'
force rd "0001"
force rs "0000"
force ALU "111"
run 140 ns


 


