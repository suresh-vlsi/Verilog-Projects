`timescale 1ns/1ps

module d_ff_tb;

reg D;
reg CLK;

wire Q;
wire Q_bar;

d_ff uut(
    .D(D),
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

    $dumpfile("d_ff.vcd");
    $dumpvars(0, d_ff_tb);

    $display("Time\tCLK D | Q Q_bar");
    $monitor("%0t\t%b   %b | %b   %b", $time, CLK, D, Q, Q_bar);

    D = 0; #12;
    D = 1; #10;
    D = 0; #10;
    D = 1; #10;
    D = 0; #10;

    $finish;

end

endmodule