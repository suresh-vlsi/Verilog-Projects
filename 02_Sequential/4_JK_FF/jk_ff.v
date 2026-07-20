module jk_ff(
    input J,
    input K,
    input CLK,
    output reg Q,
    output Q_bar
);

always @(posedge CLK)
begin
    case ({J, K})
        2'b00: Q <= Q;      // Hold
        2'b01: Q <= 1'b0;   // Reset
        2'b10: Q <= 1'b1;   // Set
        2'b11: Q <= ~Q;     // Toggle
    endcase
end

assign Q_bar = ~Q;

endmodule