module t_ff(
    input T,
    input CLK,
    input RST,
    output reg Q,
    output Q_bar
);

always @(posedge CLK or posedge RST)
begin
    if (RST)
        Q <= 1'b0;
    else if (T)
        Q <= ~Q;
    else
        Q <= Q;
end

assign Q_bar = ~Q;

endmodule