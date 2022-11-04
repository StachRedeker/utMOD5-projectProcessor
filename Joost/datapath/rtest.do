restart -f -nowave
add wave *
force clk 0,1 10ns -r 20ns
force reset '0'
run 10 ns
force reset '1'
force registerfile_type(1) "10000000000000000000000000000000"
run 10 ns

force  "0001"
force Current_A "0010"
run 20 ns
run 20 ns
run 20 ns
run 20 ns