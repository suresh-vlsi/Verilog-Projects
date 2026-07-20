`timescale 1ns/1ps

module sr_latch_tb;

reg S;
reg R;

wire Q;
wire Q_bar;

sr_latch uut(
    .S(S),
    .R(R),
    .Q(Q),
    .Q_bar(Q_bar)
);

initial begin

    $dumpfile("sr_latch.vcd");
    $dumpvars(0, sr_latch_tb);

    $display("Time\tS R | Q Q_bar");
    $monitor("%0t\t%b %b | %b   %b", $time, S, R, Q, Q_bar);

    // Initial hold (Q = X)
    S=0; R=0; #10;

    // Set
    S=1; R=0; #10;

    // Hold
    S=0; R=0; #10;

    // Reset
    S=0; R=1; #10;

    // Hold
    S=0; R=0; #10;

    // Invalid condition
    S=1; R=1; #10;

    // Return to Hold
    S=0; R=0; #10;

    $finish;

end

endmodule