vlib work
vlog mysubmodulea.v
vlog mysubmoduleb.v
vlog mymodule.v mymodule_tb.v
vsim -t ns work.mymodule_tb
view wave
add wave -height 20 -divider "Input Signals"
add wave -radix binary /clk
add wave -radix binary /rst_n
add wave -radix unsigned /someinputdataa
add wave -radix unsigned /someinputdatab
add wave -height 20 -divider "Output Signals"
add wave -radix unsigned /someoutputdata
run 5 us