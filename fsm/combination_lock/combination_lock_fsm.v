module combination_lock_fsm
(
    input clk, rst,
    input zero,
    input one,
    output reg unlock
);

    /*
        Combination to unlock is "01011"
        States:
        IDLE: reset/starting state
        S0: "0"
        S1: "01"
        S2: "010"
        S3: "0101"
        S4: "01011"

    */
    parameter IDLE = 3'b000;
    parameter S0 = 3'b001;
    parameter S1 = 3'b010;
    parameter S2 = 3'b011;
    parameter S3 = 3'b100;
    parameter S4 = 3'b101;

    reg [2:0] current_state;
    reg [2:0] next_state;

    // Current State Register
    always @(posedge clk)
    begin
        if(rst)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next State Logic
    always @(current_state, zero, one)
    begin
        case(current_state)
            IDLE: begin
                if(zero) next_state <= S0;
                else next_state <= IDLE;
            end
            S0: begin
                if(one) next_state <= S1;
                else if (zero) next_state <= S0;
            end
            S1: begin
                if(zero) next_state <= S2;
                else if(one) next_state <= IDLE;
            end
            S2: begin
                if(one) next_state <= S3;
                else if(zero) next_state <= S0;
            end
            S3: begin
                if(one) next_state <= S0;
                else if(zero) next_state <= S2;
            end
            S4: begin
                if(one) next_state <= IDLE;
                else if (zero) next_state <= S0;
            end
            default: next_state <= IDLE;
        endcase
    end

    // Output Logic
    always @(current_state)
    begin
        case(current_state)
            IDLE: unlock <= 0;
            S0: unlock <= 0;
            S1: unlock <= 0;
            S2: unlock <= 0;
            S3: unlock <= 0;
            S4: unlock <= 1;
            default: unlock <= 0;
        endcase
    end

endmodule
