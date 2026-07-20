`timescale 1ns/1ps

module ripple_counter_tb;

reg CLK;
reg RST;

wire [3:0] Q;

ripple_counter uut(
    .CLK(CLK),
    .RST(RST),
    .Q(Q)
);

// Clock generation
initial begin
    CLK = 0;
    forever #5 CLK = ~CLK;
end

initial begin

    $dumpfile("ripple_counter.vcd");
    $dumpvars(0, ripple_counter_tb);

    $display("Time\tRST CLK | Count");
    $monitor("%0t\t%b   %b   | %b (%0d)",
             $time, RST, CLK, Q, Q);

    RST = 1;
    #12;

    RST = 0;

    #160;

    $finish;

end

endmodule