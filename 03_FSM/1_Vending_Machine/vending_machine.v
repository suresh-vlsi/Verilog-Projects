module vending_machine(
    input CLK,
    input RST,
    input coin_5,
    input coin_10,
    output reg dispense
);

reg [1:0] state, next_state;

parameter S0  = 2'b00,
          S5  = 2'b01,
          S10 = 2'b10,
          S15 = 2'b11;

// State Register
always @(posedge CLK or posedge RST)
begin
    if(RST)
        state <= S0;
    else
        state <= next_state;
end

// Next-State Logic
always @(*)
begin
    case(state)

        S0:
            if(coin_5)
                next_state = S5;
            else if(coin_10)
                next_state = S10;
            else
                next_state = S0;

        S5:
            if(coin_5)
                next_state = S10;
            else if(coin_10)
                next_state = S15;
            else
                next_state = S5;

        S10:
            if(coin_5)
                next_state = S15;
            else if(coin_10)
                next_state = S15;
            else
                next_state = S10;

        S15:
            next_state = S0;

        default:
            next_state = S0;

    endcase
end

// Output Logic (Moore FSM)
always @(*)
begin
    dispense = (state == S15);
end

endmodule