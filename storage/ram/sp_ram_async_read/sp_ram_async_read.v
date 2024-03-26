module sp_ram_sync_read
#(
    parameter WIDTH = 8,
    parameter DEPTH = 2**3
)
(
    input clk, rst_n,
    input wr,
    input [$clog2(DEPTH)-1:0] addr,
    input [WIDTH-1:0] din,
    output reg [WIDTH-1:0] dout,
);

reg [WIDTH-1:0] mem [DEPTH];

initial
    $readmemh("ram.dat", mem);

always @(posedge clk or negedge rst_n)
    begin: ram_memory
        if(!rst_n)
            for (int i = 0; i < DEPTH; i++) 
            begin
                mem[i] <= 0;
            end
        else
            if(wr)
                mem[addr] <= din;
            dout <= mem[addr];
    end

// To implement an async read, although it will not be implemented with block RAM:
// assign dout = mem[addr];

endmodule