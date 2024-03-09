`timescale 10ps / 10ps
`include "fsm3cycles_high.sv"

module fsm3cycles_high_tb;
    reg clk, rst;
    reg x;
    wire y;

    fsm3cycles_high uut (.clk(clk), .rst(rst), .x(x), .y(y));

    initial begin
        clk = 0;
        forever #2 clk = ~clk;
    end

    initial begin
        rst = 1;
        #10
        rst = 0;
    end

    initial begin
        $dumpfile("fsm3cycles_high_tb.vcd" );
        $dumpvars(0, fsm3cycles_high_tb);
        x = 0;
        #10;
        x = 1;
        #30;
        $display("Test complete");
        $finish;
    end
endmodule;
