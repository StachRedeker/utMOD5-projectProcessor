restart -f -nowave
add wave *
force reset 0, 1 10 ns
force MemString 16#0003FF80 100 ns, 16#004AA90 200ns, 16#0008C600 300 ns, 16#000FFFFF 400 ns , 16#00000F00 500 ns, 16#0007B870 600 ns
force clk 0 , 1 10 ns -repeat 20 ns 
run 800 ns 