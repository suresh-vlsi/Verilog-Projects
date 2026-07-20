`timescale 1ns/1ps

module traffic_light_timer_tb;

reg clk;
reg rst;

wire red;
wire yellow;
wire green;

traffic_light_timer DUT
(
    .clk(clk),
    .rst(rst),
    .red(red),
    .yellow(yellow),
    .green(green)
);

//-------------------------------------
// Clock Generation
//-------------------------------------

initial
    clk = 0;

always #5 clk = ~clk;

//-------------------------------------
// Test
//-------------------------------------

initial
begin

    rst = 1;

    #20;

    rst = 0;

    // Run long enough to observe several cycles
    #500;

    $finish;

end

//-------------------------------------
// Monitor
//-------------------------------------

initial
begin
    $display(" Time   Red Yellow Green");
    $monitor("%4t     %b      %b      %b",
             $time,
             red,
             yellow,
             green);
end

//-------------------------------------
// Waveform
//-------------------------------------

initial
begin
    $dumpfile("traffic_light_timer.vcd");
    $dumpvars(0,traffic_light_timer_tb);
end

endmodule