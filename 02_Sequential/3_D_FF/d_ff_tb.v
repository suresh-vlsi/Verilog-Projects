`timescale 1ns/1ps

module d_ff_tb;

reg D;
reg CLK;
reg RST;

wire Q;
wire Q_bar;

d_ff uut(
    .D(D),
    .CLK(CLK),
    .RST(RST),
    .Q(Q),
    .Q_bar(Q_bar)
);

// Clock generation
initial begin
    CLK = 0;
    forever #5 CLK = ~CLK;
end

initial begin

    $dumpfile("d_ff.vcd");
    $dumpvars(0, d_ff_tb);

    $display("Time\tRST CLK D | Q Q_bar");
    $monitor("%0t\t%b   %b   %b | %b   %b",
              $time,RST,CLK,D,Q,Q_bar);

    RST = 1;
    D = 0;
    #12;

    RST = 0;

    D = 1; #10;
    D = 0; #10;
    D = 1; #10;
    D = 0; #10;

    $finish;

end

endmodule