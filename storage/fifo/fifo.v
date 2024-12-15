// `define DEBUG

module fifo
#( parameter WIDTH = 4, parameter DEPTH = 8)
(
    input clk,
    input rst_n,
    input wr_en,
    input rd_en,
    input [WIDTH-1:0] data_in,
    output full,
    output empty,
    output reg [WIDTH-1:0] data_out
);

    localparam PTR_WIDTH = $clog2(DEPTH);

    // Memory declaration
    reg [WIDTH-1:0] fifo_mem [DEPTH-1:0];
    reg [PTR_WIDTH-1:0] rd_ptr;
    reg [PTR_WIDTH-1:0] wr_ptr;
    
    // Temporary register for read data
    reg [WIDTH-1:0] rd_data;

    assign empty = (rd_ptr == wr_ptr);
    assign full = (rd_ptr == (wr_ptr+1));

    // Write process
    always @(posedge clk or negedge rst_n)
        if (!rst_n) begin
            wr_ptr <= 0;
        end else if(wr_en && !full) begin
            // Explicit write
            fifo_mem[wr_ptr] <= data_in;
            $display("Writing %h to location %d", data_in, wr_ptr);
            wr_ptr <= wr_ptr + 1;
        end

    // Read process - split into two always blocks
    always @(posedge clk or negedge rst_n)
        if (!rst_n) begin
            rd_ptr <= 0;
            data_out <= 0;
        end else if(rd_en && !empty) begin
            // Explicit read
            data_out <= fifo_mem[rd_ptr];
            $display("Reading from location %d, value is %h", rd_ptr, fifo_mem[rd_ptr]);
            rd_ptr <= rd_ptr + 1;
        end

    // Reset fifo content
    always @(negedge rst_n)
        for(integer i = 0; i < DEPTH; i = i + 1)
            fifo_mem[i] <= 0;

`ifdef DEBUG
    // Debug - monitor memory location 0
    always @(posedge clk)
        for(integer i = 0; i < DEPTH; i = i + 1)
        begin
            $display("Memory[i] = %h", fifo_mem[i]);
        end
`endif

endmodule