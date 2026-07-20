module d_latch(
    input D,
    input EN,
    output reg Q,
    output Q_bar
);

always @(*) begin
    if (EN)
        Q = D;
end

assign Q_bar = ~Q;

endmodule