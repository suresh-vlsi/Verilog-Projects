`timescale 1ns/1ps

module demux1to2_tb;

reg D;
reg S;

wire Y0;
wire Y1;

demux1to2 uut(
    .D(D),
    .S(S),
    .Y0(Y0),
    .Y1(Y1)
);

initial begin

    $dumpfile("demux1to2.vcd");
    $dumpvars(0, demux1to2_tb);

    $display("D S | Y0 Y1");
    $display("------------");

    D=0; S=0; #10;
    $display("%b %b |  %b  %b", D,S,Y0,Y1);

    D=0; S=1; #10;
    $display("%b %b |  %b  %b", D,S,Y0,Y1);

    D=1; S=0; #10;
    $display("%b %b |  %b  %b", D,S,Y0,Y1);

    D=1; S=1; #10;
    $display("%b %b |  %b  %b", D,S,Y0,Y1);

    $finish;

end

endmodule