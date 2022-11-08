restart -f -nowave
do wave.do
force clk 0,1 10ns -r 20ns
force reset 0
force next_instruction_key 1
force load_address_key 1
force sw "0100001111"
run 100ns
force reset 1
run 100000ns