module fsm3cycles_high(clk, rst, x, y);
    input clk, rst;
    input x;
    output y;

    typedef enum {S0, S1, S2, S3} state_t;
    state_t current_state, next_state;
    reg y;

    always @(posedge clk)
        if(rst == 1'b1) begin
            current_state = S0;
        end else begin
            current_state = next_state;
        end

    // Combinatorial logic
    always @(current_state, x)
        case(current_state)
            S0: begin
                next_state = S1;
                y = 1'b0;
            end
            S1: begin
                if (x == 1'b0) begin
                    next_state = S0;
                end else begin
                    next_state = S2;
                end
                y = 1'b1;
            end
            S2: begin
                next_state = S3;
                y = 1'b1;
            end
            S3: begin
                next_state = S0;
                y = 1'b1;
            end
            default: begin
                next_state = S0;
                y = 1'b0;
            end
        endcase
endmodule;
