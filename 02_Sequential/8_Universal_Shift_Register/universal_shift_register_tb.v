`timescale 1ns/1ps

module universal_shift_register_tb;

reg CLK;
reg RST;
reg S1;
reg S0;
reg SI_LEFT;
reg SI_RIGHT;
reg [3:0] D;

wire [3:0] Q;

universal_shift_register uut(
    .CLK(CLK),
    .RST(RST),
    .S1(S1),
    .S0(S0),
    .SI_LEFT(SI_LEFT),
    .SI_RIGHT(SI_RIGHT),
    .D(D),
    .Q(Q)
);

// Clock generation
initial begin
    CLK = 0;
    forever #5 CLK = ~CLK;
end

initial begin

    $dumpfile("universal_shift_register.vcd");
    $dumpvars(0, universal_shift_register_tb);

    $display("Time\tRST S1 S0 | D    | Q");
    $monitor("%0t\t%b   %b  %b | %b | %b",
             $time,RST,S1,S0,D,Q);

    // Reset
    RST = 1;
    S1 = 0;
    S0 = 0;
    D = 4'b0000;
    SI_LEFT = 0;
    SI_RIGHT = 0;
    #12;

    RST = 0;

    // Parallel Load
    S1 = 1;
    S0 = 1;
    D = 4'b1010;
    #10;

    // Hold
    S1 = 0;
    S0 = 0;
    #10;

    // Shift Right
    S1 = 0;
    S0 = 1;
    SI_RIGHT = 1;
    #20;

    // Shift Left
    S1 = 1;
    S0 = 0;
    SI_LEFT = 0;
    #20;

    $finish;

end

endmodule