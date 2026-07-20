`timescale 1ns/1ps

module d_latch_tb;

reg D;
reg EN;

wire Q;
wire Q_bar;

d_latch uut(
    .D(D),
    .EN(EN),
    .Q(Q),
    .Q_bar(Q_bar)
);

initial begin

    $dumpfile("d_latch.vcd");
    $dumpvars(0, d_latch_tb);

    $display("Time\tEN D | Q Q_bar");
    $monitor("%0t\t%b  %b | %b   %b", $time, EN, D, Q, Q_bar);

    // Hold state (Q starts as X)
    EN = 0; D = 0; #10;

    // Transparent: Q follows D
    EN = 1; D = 0; #10;
    D = 1; #10;
    D = 0; #10;

    // Hold last value
    EN = 0; D = 1; #10;
    D = 0; #10;

    // Transparent again
    EN = 1; D = 1; #10;

    $finish;

end

endmodule