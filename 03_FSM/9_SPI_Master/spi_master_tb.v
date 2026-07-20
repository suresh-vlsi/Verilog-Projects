`timescale 1ns/1ps

module spi_master_tb;

reg clk;
reg rst;
reg start;
reg [7:0] tx_data;

wire sclk;
wire mosi;
wire cs;
wire busy;
wire done;

spi_master DUT
(
    .clk(clk),
    .rst(rst),
    .start(start),
    .tx_data(tx_data),
    .sclk(sclk),
    .mosi(mosi),
    .cs(cs),
    .busy(busy),
    .done(done)
);

//--------------------------------
// Clock
//--------------------------------

initial
    clk = 0;

always #5 clk = ~clk;

//--------------------------------
// Test
//--------------------------------

initial
begin

    rst = 1;
    start = 0;
    tx_data = 8'd0;

    #20;
    rst = 0;

    #20;

    tx_data = 8'hA5;
    start = 1;

    #10;
    start = 0;

    wait(done);

    #50;

    tx_data = 8'h3C;
    start = 1;

    #10;
    start = 0;

    wait(done);

    #100;

    $finish;

end

//--------------------------------
// Monitor
//--------------------------------

initial
begin
    $display("Time CS SCLK MOSI Busy Done");

    $monitor("%4t  %b   %b    %b    %b    %b",
             $time,
             cs,
             sclk,
             mosi,
             busy,
             done);
end

//--------------------------------
// Waveform
//--------------------------------

initial
begin
    $dumpfile("spi_master.vcd");
    $dumpvars(0,spi_master_tb);
end

endmodule