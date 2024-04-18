create_clock -period 10 -name clk [get_ports clk]; # omitted waveform option defaults clock duty cycle to 50/50
create_clock -period 10 -name clk_in_virt
create_clock -period 10 -name clk_out_virt
create_generated_clock -name clk_div_2 -source clk -divide_by 2 [get_pins myFF_Q]
create_generated_clock -name clk_mult_2 -source clk -multiply_by 2 [get_pins myFF_Q]

set_clock_uncertainty -setup 0.01 [get_clocks clk]
set_clock_uncertainty -hold 0.002 [get_clocks clk]

set_input_delay -clock clk_in_virt -max 0.02 [get_ports my_input_ports]
set_input_delay -clock clk_in_virt -min 0.01 [get_ports my_input_ports]

set_output_delay -clock clk_out_virt -max 0.03 [get_ports my_output_ports]
set_output_delay -clock clk_out_virt -min 0.02 [get_ports my_output_ports]

set_false_path -from regA -to regB
