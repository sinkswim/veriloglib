`timescale 10ns / 10ns
`include "decoder3to8.sv"

module decoder3to8_tb;

    // Inputs
    reg [2:0] x;
    
    // Outputs
    wire [7:0] y;
    
    // Instantiate the module
    decoder3to8 dut (
        .x(x),
        .y(y)
    );
    
    // Initialize x
    initial begin
        $dumpfile("decoder3to8_tb.vcd" );
        $dumpvars(0, decoder3to8_tb);
        x = 3'b000;
        #10;
        x = 3'b001;
        #10;
        x = 3'b010;
        #10;
        x = 3'b011;
        #10;
        x = 3'b100;
        #10;
        x = 3'b101;
        #10;
        x = 3'b110;
        #10;
        x = 3'b111;
        #10;
        $finish;
    end
    
    // Display y
    always @(y)
        $display("x = %b ----> y = %b", x, y);
    
endmodule
