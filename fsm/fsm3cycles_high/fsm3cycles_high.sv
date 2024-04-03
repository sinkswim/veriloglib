module fsm3cycles_high(clk, rst, x, y);
    input clk, rst;
    input x;
    output reg y;

    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;
    reg [1:0] current_state, next_state;

    always @(posedge clk)
        if(rst == 1'b1) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end

    // State combinatorial logic
    always @(current_state, x)
        case(current_state)
            S0: next_state <= S1;
            S1: begin
                if (x == 1'b0) begin
                    next_state <= S0;
                end else begin
                    next_state <= S2;
                end
            end
            S2: next_state <= S3;
            S3: next_state <= S0;
            default: next_state <= S0;
        endcase

    // Output logic (Moore FSM)
    always @(current_state)
        case(current_state)
            S0: y <= 1'b0;
            S1: y <= 1'b1;
            S2: y <= 1'b1;
            S3: y <= 1'b1;
            default: y <= 1'b0;
        endcase

endmodule
