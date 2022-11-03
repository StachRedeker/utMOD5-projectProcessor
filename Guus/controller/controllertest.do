restart -f -nowave
add wave *
force reset 0, 1 10 ns
force MemString 16#0000FF80 100 ns, 16#0008C600 200 ns, 16#0008C600 300 ns
force clk 0 , 1 10 ns -repeat 20 ns 
run 800 ns 