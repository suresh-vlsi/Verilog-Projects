`timescale 1ns/1ps

module uart_tx_tb;

parameter CLK_FREQ  = 50000000;
parameter BAUD_RATE = 9600;

reg clk;
reg rst;
reg tx_start;
reg [7:0] tx_data;

wire tx;
wire tx_busy;

//----------------------------------------------------
// DUT
//----------------------------------------------------
uart_tx
#(
    .CLK_FREQ(CLK_FREQ),
    .BAUD_RATE(BAUD_RATE)
)
DUT
(
    .clk(clk),
    .rst(rst),
    .tx_start(tx_start),
    .tx_data(tx_data),
    .tx(tx),
    .tx_busy(tx_busy)
);

//----------------------------------------------------
// Clock Generation (50 MHz)
//----------------------------------------------------
initial
    clk = 0;

always #10 clk = ~clk;

//----------------------------------------------------
// Task to transmit one byte
//----------------------------------------------------
task send_byte;

input [7:0] data;

begin

    @(posedge clk);
    tx_data  <= data;
    tx_start <= 1;

    @(posedge clk);
    tx_start <= 0;

    wait(tx_busy == 1);
    wait(tx_busy == 0);

end

endtask

//----------------------------------------------------
// Test Sequence
//----------------------------------------------------
initial
begin

    rst = 1;
    tx_start = 0;
    tx_data = 0;

    #100;
    rst = 0;

    $display("----------------------------");
    $display("UART TX Simulation Started");
    $display("----------------------------");

    send_byte(8'h55);
    send_byte(8'hA3);
    send_byte(8'h0F);
    send_byte(8'hF0);
    send_byte(8'hAA);

    #100000;

    $display("----------------------------");
    $display("Simulation Finished");
    $display("----------------------------");

    $finish;

end

//----------------------------------------------------
// Monitor
//----------------------------------------------------
initial
begin
    $monitor("Time=%0t tx=%b busy=%b data=%h",
             $time,
             tx,
             tx_busy,
             tx_data);
end

//----------------------------------------------------
// Waveform
//----------------------------------------------------
initial
begin
    $dumpfile("uart_tx.vcd");
    $dumpvars(0,uart_tx_tb);
end

endmodule