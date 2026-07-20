`timescale 1ns/1ps

module synchronous_counter_tb;

reg CLK;
reg RST;

wire [3:0] Q;

synchronous_counter uut(
    .CLK(CLK),
    .RST(RST),
    .Q(Q)
);

// Clock generation (10 ns period)
initial begin
    CLK = 0;
    forever #5 CLK = ~CLK;
end

// Stimulus
initial begin

    $dumpfile("synchronous_counter.vcd");
    $dumpvars(0, synchronous_counter_tb);

    $display("Time\tRST CLK | Count");
    $monitor("%0t\t%b   %b   | %b (%0d)",
             $time, RST, CLK, Q, Q);

    // Apply reset
    RST = 1;
    #12;

    // Release reset
    RST = 0;

    // Run for 16 clock cycles
    #160;

    $finish;

end

endmodule