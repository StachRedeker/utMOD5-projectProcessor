restart -f -nowave
add wave *
force clk 0,1 10ns -r 20ns
force reset '0'
run 10 ns
force reset '1'
run 10 ns

force Current_A "0001" 
force Current_C "0010" 
force reg_file(2) "10000000100000001000000010000000"
force reg_file(1) "11111111111111111111111111111111" 
run 80 ns
