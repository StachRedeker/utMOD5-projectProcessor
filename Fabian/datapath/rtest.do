restart -f -nowave
add wave *
force clk 0,1 10ns -r 20ns
force reset '0'
run 5 ns

force reset '1'
force BusC "00000000000011010000011111000000"
force Current_C "0010"
force Current_A "0010"
run 200 ns