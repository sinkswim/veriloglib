// 	clock_generator: given an input number this module
// 	will generate a clock with different frequency in output
module clock_generator
#(
	parameter period = 50,
	parameter COUNTER_WIDTH = 8
)
(
	input clk_i, rst_n,						// Map to on-board clock and reset
	input [COUNTER_WIDTH-1:0] prescaler,	// Map this to on-board DIP switch
	output reg clk_o						// Map to on-board GPIO
);

reg [COUNTER_WIDTH-1:0] counter;

initial 
	begin
		counter <= 0;
		clk_o <= 0;
	end

always @(posedge clk_i or negedge rst_n)
	begin:
		if(!rst_n)
			counter <= 1;
			clk_o <= 0;
			counter <= 0;
		else
			counter <= counter + 1;
	end
// example
// prescaler <- 0'b11
// counter <- prescaler <- 0'b11
// clk_i <- 100 MHz
// desired clk_o <- 25 MHz ... divide clk_i by 4
// ...
// Given a clock @ x MHz
// An 8 pin dip switch can give us 2^8 (256) combinations
// x / 2^8 is the slowest clock we can generate
// x / 2^0 is the fastest clock we can generate (clk_o == clk_i)
// Add 7 Segment LED control based on output frequency?

//  _
// | |
//  -
// | |
//  -

// Specs:
// rst_n
// clk - input clock up to 50 MHz
// ui_in[7:0] General purpose inputs
// uo_out[7:0] General purpose outputs (IOMaximum output frequency	33 MHz ! ... so generate frequencies <= 33 MHz)
// uio[7:0]	General purpose I/O (bidir)


assign clk_o = (counter == prescaler or counter == (prescaler / 2)) ? 1 : 0;

endmodule
