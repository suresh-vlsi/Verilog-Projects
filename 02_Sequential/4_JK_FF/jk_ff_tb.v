`timescale 1ns/1ps

module jk_ff_tb;

reg J;
reg K;
reg CLK;
reg RST;

wire Q;
wire Q_bar;

jk_ff uut(
    .J(J),
    .K(K),
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

    $dumpfile("jk_ff.vcd");
    $dumpvars(0, jk_ff_tb);

    $display("Time\tRST CLK J K | Q");
    $monitor("%0t\t%b   %b   %b %b | %b",
             $time,RST,CLK,J,K,Q);

    RST=1;
    J=0;
    K=0;
    #12;

    RST=0;

    J=1; K=0; #10;   // Set
    J=0; K=1; #10;   // Reset
    J=1; K=1; #20;   // Toggle
    J=0; K=0; #10;   // Hold

    $finish;

end

endmodule