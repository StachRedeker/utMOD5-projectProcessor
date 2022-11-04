restart -f -nowave
add wave *
force reset 0, 1 10 ns
force PSR 0000 0 ns
force MemString 16#0003FF80 60 ns, 16#0000FF80 140 ns, 16#0004AA90 220 ns, 16#0008C600 300 ns, 16#000FFFFF 380 ns, 16#00000F00 460 ns, 16#0007B870 540 ns
force NewInstruction 0 0 ns, 1 60 ns, 0 80 ns, 1 140 ns, 0 160 ns, 1 220 ns, 0 240 ns, 1 300 ns, 0 320 ns, 1 380 ns, 0 400 ns, 1 460 ns, 0 480 ns, 1 540 ns, 0 560 ns
force clk 0 , 1 10 ns -repeat 20 ns 
run 800 ns 