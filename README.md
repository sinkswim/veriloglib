# veriloglib
My own Verilog components library. Anything from a flip flop to an ALU.

## Running

New designs will be tested with cocotb, as can be observed in `basic/muxes/` which is the first design adopting this scheme.

For tests using cocotb, simply:

`make` to compile and run tests

`make wave` to view waveforms in GTKWave

`make cleanup` to clean-up build and accessory files

You will get something like the following image:
![Alt text](docs/img/cocotbgtkw.png?raw=true "Cocotb testing and GTKWave viewing")


Where still outdated, vestiges of the old testing procedures are still present (traditional Verilog testbench plus `run.sh` bash script to compile with Icarus Verilog and open waveform in GTKWave). For those, simply execute `run.sh` in your terminal.
