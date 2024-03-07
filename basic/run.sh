#!/bin/bash

# This command is used to compile a verilog testbench and display its simulation run in gtkwave

# Check if the filename is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <verilog_filename>"
    exit 1
fi

# Extract the filename from the argument
verilog_file="$1"

# Compile the Verilog code using iverilog
iverilog "$verilog_file"

# Run the compiled simulation using vvp
vvp a.out

# Visualize the simulation results using gtkwave
gtkwave "${verilog_file%.v}.vcd"

# Clean up
rm a.out
rm *.vcd
