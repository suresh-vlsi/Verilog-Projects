module sr_latch(
    input S,
    input R,
    output reg Q,
    output Q_bar
);

always @(*) begin
    if (S && !R)
        Q = 1'b1;
    else if (!S && R)
        Q = 1'b0;
    // When S=R=0, Q retains its previous value (latch behavior)
    // S=R=1 is intentionally left unhandled (invalid state)
end

assign Q_bar = ~Q;

endmodule