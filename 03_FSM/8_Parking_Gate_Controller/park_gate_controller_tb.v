`timescale 1ns/1ps

module park_gate_controller_tb;

reg clk;
reg rst;

reg vehicle_detect;
reg vehicle_passed;

wire gate_open;
wire gate_close;

//---------------------------------------
// DUT
//---------------------------------------

park_gate_controller DUT
(
    .clk(clk),
    .rst(rst),

    .vehicle_detect(vehicle_detect),
    .vehicle_passed(vehicle_passed),

    .gate_open(gate_open),
    .gate_close(gate_close)
);

//---------------------------------------
// Clock Generation
//---------------------------------------

initial
    clk = 0;

always #5 clk = ~clk;

//---------------------------------------
// Test Sequence
//---------------------------------------

initial
begin

    rst = 1;
    vehicle_detect = 0;
    vehicle_passed = 0;

    #20;
    rst = 0;

    // Vehicle arrives
    #20;
    vehicle_detect = 1;

    #10;
    vehicle_detect = 0;

    // Vehicle passes
    #60;
    vehicle_passed = 1;

    #10;
    vehicle_passed = 0;

    // Second vehicle
    #80;

    vehicle_detect = 1;

    #10;
    vehicle_detect = 0;

    #60;

    vehicle_passed = 1;

    #10;
    vehicle_passed = 0;

    #100;

    $finish;

end

//---------------------------------------
// Monitor
//---------------------------------------

initial
begin

$display("Time Detect Passed Open Close");

$monitor("%4t    %b      %b      %b     %b",
         $time,
         vehicle_detect,
         vehicle_passed,
         gate_open,
         gate_close);

end

//---------------------------------------
// Waveform
//---------------------------------------

initial
begin
    $dumpfile("park_gate_controller.vcd");
    $dumpvars(0,park_gate_controller_tb);
end

endmodule