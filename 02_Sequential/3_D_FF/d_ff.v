module d_ff(
    input D,
    input CLK,
    output reg Q,
    output Q_bar
);

always @(posedge CLK)
begin
    Q <= D;
end

assign Q_bar = ~Q;

endmodule