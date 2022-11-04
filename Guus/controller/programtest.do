restart -f -nowave
add wave *
force reset 0, 1 10 ns
force PSR 1000 0 ns
force clk 0 , 1 10 ns -repeat 20 ns 

#NEW MEMSTRING
force MemString 16#000D8000
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#000A24FF
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#00086240
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#00053E48
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#000B2008
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns