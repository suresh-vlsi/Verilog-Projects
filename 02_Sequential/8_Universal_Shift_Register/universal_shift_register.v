module universal_shift_register(
    input CLK,
    input RST,
    input S1,
    input S0,
    input SI_LEFT,
    input SI_RIGHT,
    input [3:0] D,
    output reg [3:0] Q
);

always @(posedge CLK or posedge RST)
begin
    if (RST)
        Q <= 4'b0000;
    else begin
        case ({S1,S0})

            2'b00:
                Q <= Q;                              // Hold

            2'b01:
                Q <= {SI_RIGHT, Q[3:1]};             // Shift Right

            2'b10:
                Q <= {Q[2:0], SI_LEFT};              // Shift Left

            2'b11:
                Q <= D;                              // Parallel Load

        endcase
    end
end

endmodule