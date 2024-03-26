`timescale 10ns / 10ns
`include "decoder.sv"

module decoder_tb;

    parameter WIDTH = 2;

    // Inputs
    reg [WIDTH-1:0] x;
    
    // Outputs
    wire [(2**WIDTH)-1:0] y;
    
    // Instantiate the module
    decoder #(.WIDTH(WIDTH)) dut (.x(x), .y(y));
    
    // Initialize x
    initial begin
        $dumpfile("decoder_tb.vcd" );
        $dumpvars(0, decoder_tb);
        x = 2'b00;
        #10;
        x = 2'b01;
        #10;
        x = 2'b10;
        #10;
        x = 2'b11;
        #10;
        $finish;
    end
    
    // Display y
    always @(y)
        $display("x = %b ----> y = %b", x, y);
    
endmodule
