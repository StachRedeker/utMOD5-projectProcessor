restart -f -nowave
add wave *
#force {reg_file[1]} "10000000000000000000000000000000"
#force {reg_file[2]} "01000000000000000000000000000000"
force clk 0,1 10ns -r 20ns
force reset '0'
run 5 ns
force reset '1'
run 5 ns

force Current_A "0010"
force Current_C "0011"
run 80 ns