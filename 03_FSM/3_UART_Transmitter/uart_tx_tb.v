`timescale 1ns/1ps

module uart_tx_tb;

reg CLK;
reg RST;

reg TX_START;
reg [7:0] DATA_IN;

wire TX;
wire BUSY;

uart_tx uut(

.CLK(CLK),
.RST(RST),

.TX_START(TX_START),
.DATA_IN(DATA_IN),

.TX(TX),
.BUSY(BUSY)

);

initial
begin

CLK=0;

forever #5 CLK=~CLK;

end

initial
begin

$dumpfile("uart_tx.vcd");
$dumpvars(0,uart_tx_tb);

RST=1;
TX_START=0;
DATA_IN=8'hA5;

#20;

RST=0;

#10;

TX_START=1;

#10;

TX_START=0;

#200;

$finish;

end

endmodule