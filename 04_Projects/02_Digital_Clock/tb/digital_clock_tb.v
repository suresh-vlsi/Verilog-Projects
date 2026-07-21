`timescale 1ns/1ps

// Testbench : digital_clock_tb

module digital_clock_tb;

// Parameters

parameter CLK_FREQ = 10;

// Testbench Signals

reg clk;
reg rst;

wire [4:0] hours;
wire [5:0] minutes;
wire [5:0] seconds;

// DUT

digital_clock #(
    .CLK_FREQ(CLK_FREQ)
)
dut
(
    .clk     (clk),
    .rst     (rst),

    .hours   (hours),
    .minutes (minutes),
    .seconds (seconds)
);

// Clock Generation
// 10ns Period

always #5 clk = ~clk;

// Waveform Dump

initial
begin
    $dumpfile("digital_clock.vcd");
    $dumpvars(0, digital_clock_tb);
end;

// Console Monitor

initial
begin
    $display("--------------------------------------------");
    $display("        DIGITAL CLOCK SIMULATION");
    $display("--------------------------------------------");
    $display(" Time(ns)   Hours  Minutes  Seconds");
    $display("--------------------------------------------");

    $monitor("%8t      %02d      %02d      %02d",
             $time,
             hours,
             minutes,
             seconds);
end

// Test Sequence

initial
begin

    // Initialize
    
    clk = 0;
    rst = 1;

    // Apply Reset
    
    #20;
    rst = 0;

    // Run the clock
    
    // 70 simulated seconds
    repeat(700)
        @(posedge clk);

    // End Simulation

    $display("--------------------------------------------");
    $display(" Simulation Completed Successfully");
    $display("--------------------------------------------");

    $finish;

end

endmodule