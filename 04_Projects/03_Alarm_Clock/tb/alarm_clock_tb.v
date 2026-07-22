`timescale 1ns/1ps

// Testbench : alarm_clock_tb

module alarm_clock_tb;

// Parameters

parameter CLK_FREQ = 10;

// Testbench Signals

reg clk;
reg rst;

reg set_alarm;
reg alarm_enable;

reg [4:0] alarm_hour_in;
reg [5:0] alarm_min_in;

wire [4:0] hours;
wire [5:0] minutes;
wire [5:0] seconds;

wire [4:0] alarm_hour;
wire [5:0] alarm_min;

wire alarm;

// DUT

alarm_clock
#(
    .CLK_FREQ(CLK_FREQ)
)
dut
(
    .clk(clk),
    .rst(rst),

    .set_alarm(set_alarm),
    .alarm_enable(alarm_enable),

    .alarm_hour_in(alarm_hour_in),
    .alarm_min_in(alarm_min_in),

    .hours(hours),
    .minutes(minutes),
    .seconds(seconds),

    .alarm_hour(alarm_hour),
    .alarm_min(alarm_min),

    .alarm(alarm)
);

// Clock Generation

always #5 clk = ~clk;

// Waveform Dump

initial
begin
    $dumpfile("alarm_clock.vcd");
    $dumpvars(0, alarm_clock_tb);
end;

// Console Monitor

initial
begin
    $display("---------------------------------------------------------");
    $display("              ALARM CLOCK SIMULATION");
    $display("---------------------------------------------------------");
    $display(" Time(ns)   Clock      Alarm Set   Alarm");
    $display("---------------------------------------------------------");

    $monitor("%8t     %02d:%02d:%02d    %02d:%02d      %b",
             $time,
             hours,
             minutes,
             seconds,
             alarm_hour,
             alarm_min,
             alarm);
end;

// Test Sequence

initial
begin


    clk = 0;
    rst = 1;

    set_alarm = 0;
    alarm_enable = 0;

    alarm_hour_in = 0;
    alarm_min_in = 0;

    // Apply Reset

    #20;
    rst = 0;

    // Program Alarm = 00:01

    @(posedge clk);

    alarm_hour_in = 5'd0;
    alarm_min_in  = 6'd1;

    set_alarm = 1;

    @(posedge clk);

    set_alarm = 0;

    // Enable Alarm

    alarm_enable = 1;

    // Run Simulation

    // Simulate 70 seconds.
    // Alarm should trigger at 00:01:00

    repeat(700)
        @(posedge clk);

    // Disable Alarm

    alarm_enable = 0;

    repeat(20)
        @(posedge clk);

    // Finish
    
    $display("---------------------------------------------------------");
    $display(" Simulation Completed Successfully");
    $display("---------------------------------------------------------");

    $finish;

end;

endmodule