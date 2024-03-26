module decoder
#(parameter WIDTH = 3)
(
    input [WIDTH-1:0] x,
    output reg [(2**WIDTH)-1:0] y
);

    always @*
        y = 1 << x;

endmodule;
