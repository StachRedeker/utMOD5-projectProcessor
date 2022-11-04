restart -f -nowave
add wave *
force clk 0,1 10ns -r 20ns
force reset '0'
run 20 ns
force reset '1'
run 10 ns

force Current_C "0010"
force Current_A "0010"
force BusC "00000000000011010000011111000000"
run 20 ns
run 20 ns
run 20 ns