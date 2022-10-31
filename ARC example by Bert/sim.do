vlib work
vdel -all
vlib work
do compile_all.do
vsim -voptargs=+acc work.processor_with_memory(structure)
do wave.do