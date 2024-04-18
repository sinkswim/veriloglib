Templates for running simulations:

- mymodule_tb.do: TCL macro to be executed in ModelSim. Creates lib, compiles verilog modules, starts simulation and waveform viewer, adds waveforms, runs simulation.

- run.sh: Bash command to test verilog modules in a minimal environment based on Icarus Verilog and GTKWave. Compiles verilog testbench, runs simulation, displays simulation waveforms in GTKWave.
