module jk_ff(
    input J,
    input K,
    input CLK,
    input RST,
    output reg Q,
    output Q_bar
);

always @(posedge CLK or posedge RST)
begin
    if (RST)
        Q <= 1'b0;
    else begin
        case ({J,K})
            2'b00: Q <= Q;
            2'b01: Q <= 1'b0;
            2'b10: Q <= 1'b1;
            2'b11: Q <= ~Q;
        endcase
    end
end

assign Q_bar = ~Q;

endmodule