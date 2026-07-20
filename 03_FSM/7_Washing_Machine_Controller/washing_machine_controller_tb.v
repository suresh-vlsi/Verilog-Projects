`timescale 1ns/1ps

module washing_machine_controller_tb;

reg clk;
reg rst;
reg start;

wire fill_water;
wire wash;
wire rinse;
wire spin;
wire done;

//--------------------------------
// DUT
//--------------------------------

washing_machine_controller DUT
(
    .clk(clk),
    .rst(rst),
    .start(start),

    .fill_water(fill_water),
    .wash(wash),
    .rinse(rinse),
    .spin(spin),
    .done(done)
);

//--------------------------------
// Clock Generation
//--------------------------------

initial
    clk = 0;

always #5 clk = ~clk;

//--------------------------------
// Test Sequence
//--------------------------------

initial
begin

    rst = 1;
    start = 0;

    #20;
    rst = 0;

    #20;
    start = 1;

    #10;
    start = 0;

    #250;

    $finish;

end

//--------------------------------
// Monitor
//--------------------------------

initial
begin

$display("Time Fill Wash Rinse Spin Done");

$monitor("%4t   %b    %b     %b     %b    %b",
          $time,
          fill_water,
          wash,
          rinse,
          spin,
          done);

end

//--------------------------------
// Waveform
//--------------------------------

initial
begin
    $dumpfile("washing_machine_controller.vcd");
    $dumpvars(0,washing_machine_controller_tb);
end

endmodule