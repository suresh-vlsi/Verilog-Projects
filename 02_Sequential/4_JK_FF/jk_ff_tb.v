`timescale 1ns/1ps

module jk_ff_tb;

reg J;
reg K;
reg CLK;

wire Q;
wire Q_bar;

jk_ff uut(
    .J(J),
    .K(K),
    .CLK(CLK),
    .Q(Q),
    .Q_bar(Q_bar)
);

// Clock generation (10 ns period)
initial begin
    CLK = 0;
    forever #5 CLK = ~CLK;
end

// Stimulus
initial begin

    $dumpfile("jk_ff.vcd");
    $dumpvars(0, jk_ff_tb);

    $display("Time\tCLK J K | Q Q_bar");
    $monitor("%0t\t%b   %b %b | %b   %b", $time, CLK, J, K, Q, Q_bar);

    // Hold
    J = 0; K = 0; #12;

    // Set
    J = 1; K = 0; #10;

    // Reset
    J = 0; K = 1; #10;

    // Toggle
    J = 1; K = 1; #20;

    // Hold
    J = 0; K = 0; #10;

    $finish;

end

endmodule