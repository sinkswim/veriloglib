module mult2i1o
#(parameter integer WIDTH = 8)
(
	input clk, clr_n,
	input [WIDTH-1:0] a, b,
	output reg [(WIDTH*2)-1:0] result
);

reg [WIDTH-1:0] atemp, btemp;

always @ (posedge clk, negedge clr_n)
begin
	if (!clr_n) begin
		atemp <= 0;
		btemp <= 0;
		result <= 0;
	end
	else begin
		atemp <= a;
		btemp <= b;
		result <= atemp * btemp;
	end
end

endmodule
