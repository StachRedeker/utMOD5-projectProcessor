restart -f -nowave
add wave *
force reset 0, 1 10 ns
force PSR 1000 0 ns
force DEBUG 0
force ACK_data 1
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

#NEW MEMSTRING
force MemString 16#00054040
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#00044020
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#000A0801
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#000A1801
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#000A1C01
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#00043E28
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#000A97FF
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#00053E28
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#00032C00
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#000840C0
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#000A48C0
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#000A44C0
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#00084040
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#000A4840
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#00084080
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#000A4C80
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#00001400
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#0009D000
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#00013A00
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#0008D180
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#00023400
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#000849C0
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#000B0801
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#000A5C80
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#000C2000
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#000FFFFF
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#00000000
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns

#NEW MEMSTRING
force MemString 16#00000000
force NewInstruction 0, 1 20ns, 0 40ns
run 80ns