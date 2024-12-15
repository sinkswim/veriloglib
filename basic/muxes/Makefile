# Makefile

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# Enable FST tracing (use GTKWave for viewing waveforms)
WAVES ?= 1

VERILOG_SOURCES += $(PWD)/mux21.v
# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = mux21

# MODULE is the basename of the Python test file
MODULE = test_mux21

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim

# Visualize the simulation results using gtkwave and using a savefile with pre-loaded signals if present (.gtkw)
wave:
	gtkwave --save ${TOPLEVEL}.gtkw sim_build/${TOPLEVEL}.fst &

#Clean-up
cleanup:
	make clean
	rm -f -r __pycache__ results.xml
