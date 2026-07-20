`timescale 1ns/1ps

module t_ff_tb;

reg T;
reg CLK;
reg RST;

wire Q;
wire Q_bar;

t_ff uut(
    .T(T),
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

    $dumpfile("t_ff.vcd");
    $dumpvars(0, t_ff_tb);

    $display("Time\tRST CLK T | Q");
    $monitor("%0t\t%b   %b   %b | %b",
             $time,RST,CLK,T,Q);

    RST = 1;
    T = 0;
    #12;

    RST = 0;

    T = 1; #30;
    T = 0; #20;
    T = 1; #20;

    $finish;

end

endmodule