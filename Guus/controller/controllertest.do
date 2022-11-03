restart -f -nowave
add wave *
force reset 0, 1 10 ns
force MemString 16#0000FF80 100 ns, 16#0008C600 200 ns, 16#000FFFFF 300 ns
force NewInstruction 0 0ns, 1 100 ns, 0 150 ns, 1 200 ns, 0 250 ns, 1 300ns
force clk 0 , 1 10 ns -repeat 20 ns 
run 400 ns 