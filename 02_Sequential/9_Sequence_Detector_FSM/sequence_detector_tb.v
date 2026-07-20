`timescale 1ns/1ps

module sequence_detector_tb;

reg CLK;
reg RST;
reg X;

wire Z;

sequence_detector uut(
    .CLK(CLK),
    .RST(RST),
    .X(X),
    .Z(Z)
);

// Clock generation
initial begin
    CLK = 0;
    forever #5 CLK = ~CLK;
end

// Test sequence: 1011011
initial begin

    $dumpfile("sequence_detector.vcd");
    $dumpvars(0, sequence_detector_tb);

    $display("Time\tRST X | Z");
    $monitor("%0t\t%b   %b | %b",
             $time,RST,X,Z);

    RST = 1;
    X = 0;
    #12;

    RST = 0;

    X = 1; #10;
    X = 0; #10;
    X = 1; #10;
    X = 1; #10;
    X = 0; #10;
    X = 1; #10;
    X = 1; #10;

    $finish;

end

endmodule