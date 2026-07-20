`timescale 1ns/1ps

module uart_rx_tb;

parameter CLK_FREQ  = 50000000;
parameter BAUD_RATE = 9600;
parameter CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;

reg clk;
reg rst;
reg rx;

wire [7:0] rx_data;
wire rx_done;

//-----------------------------------------------------
// DUT
//-----------------------------------------------------
uart_rx
#(
    .CLK_FREQ(CLK_FREQ),
    .BAUD_RATE(BAUD_RATE)
)
DUT
(
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .rx_data(rx_data),
    .rx_done(rx_done)
);

//-----------------------------------------------------
// Clock
//-----------------------------------------------------
initial
    clk = 0;

always #10 clk = ~clk;

//-----------------------------------------------------
// UART Byte Generator
//-----------------------------------------------------
task send_byte;

input [7:0] data;
integer i;

begin

    // Start bit
    rx = 0;
    repeat(CLKS_PER_BIT) @(posedge clk);

    // Data bits (LSB first)
    for(i=0;i<8;i=i+1)
    begin
        rx = data[i];
        repeat(CLKS_PER_BIT) @(posedge clk);
    end

    // Stop bit
    rx = 1;
    repeat(CLKS_PER_BIT) @(posedge clk);

end

endtask

//-----------------------------------------------------
// Test Sequence
//-----------------------------------------------------
initial
begin

    rst = 1;
    rx = 1;

    #100;
    rst = 0;

    $display("--------------------------");
    $display("UART Receiver Simulation");
    $display("--------------------------");

    send_byte(8'h55);
    #50000;

    send_byte(8'hA3);
    #50000;

    send_byte(8'h0F);
    #50000;

    send_byte(8'hF0);
    #50000;

    send_byte(8'hAA);
    #50000;

    $display("--------------------------");
    $display("Simulation Finished");
    $display("--------------------------");

    $finish;

end

//-----------------------------------------------------
// Monitor
//-----------------------------------------------------
always @(posedge clk)
begin
    if(rx_done)
        $display("Time=%0t  Received Data = %h", $time, rx_data);
end

//-----------------------------------------------------
// Waveform
//-----------------------------------------------------
initial
begin
    $dumpfile("uart_rx.vcd");
    $dumpvars(0,uart_rx_tb);
end

endmodule