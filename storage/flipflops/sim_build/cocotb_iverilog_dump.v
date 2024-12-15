module cocotb_iverilog_dump();
initial begin
    $dumpfile("sim_build/dff_arst.fst");
    $dumpvars(0, dff_arst);
end
endmodule
