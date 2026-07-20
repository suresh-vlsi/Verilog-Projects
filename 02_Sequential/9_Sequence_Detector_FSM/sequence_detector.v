module sequence_detector(
    input CLK,
    input RST,
    input X,
    output reg Z
);

reg [2:0] state, next_state;

// State Encoding
parameter S0 = 3'b000,
          S1 = 3'b001,
          S2 = 3'b010,
          S3 = 3'b011,
          S4 = 3'b100;

// State Register
always @(posedge CLK or posedge RST)
begin
    if (RST)
        state <= S0;
    else
        state <= next_state;
end

// Next-State Logic
always @(*)
begin
    case(state)

        S0:
            if(X) next_state = S1;
            else  next_state = S0;

        S1:
            if(X) next_state = S1;
            else  next_state = S2;

        S2:
            if(X) next_state = S3;
            else  next_state = S0;

        S3:
            if(X) next_state = S4;
            else  next_state = S2;

        S4:
            if(X) next_state = S1;
            else  next_state = S2;

        default:
            next_state = S0;

    endcase
end

// Output Logic (Moore FSM)
always @(*)
begin
    if(state == S4)
        Z = 1'b1;
    else
        Z = 1'b0;
end

endmodule