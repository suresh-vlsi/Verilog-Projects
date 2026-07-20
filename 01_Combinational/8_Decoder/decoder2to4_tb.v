`timescale 1ns/1ps

module decoder2to4_tb;

reg A1;
reg A0;

wire Y0;
wire Y1;
wire Y2;
wire Y3;

decoder2to4 uut(
    .A1(A1),
    .A0(A0),
    .Y0(Y0),
    .Y1(Y1),
    .Y2(Y2),
    .Y3(Y3)
);

initial begin

    $dumpfile("decoder2to4.vcd");
    $dumpvars(0, decoder2to4_tb);

    $display("A1 A0 | Y0 Y1 Y2 Y3");
    $display("-------------------");

    A1=0; A0=0; #10;
    $display("%b  %b |  %b  %b  %b  %b", A1,A0,Y0,Y1,Y2,Y3);

    A1=0; A0=1; #10;
    $display("%b  %b |  %b  %b  %b  %b", A1,A0,Y0,Y1,Y2,Y3);

    A1=1; A0=0; #10;
    $display("%b  %b |  %b  %b  %b  %b", A1,A0,Y0,Y1,Y2,Y3);

    A1=1; A0=1; #10;
    $display("%b  %b |  %b  %b  %b  %b", A1,A0,Y0,Y1,Y2,Y3);

    $finish;

end

endmodule