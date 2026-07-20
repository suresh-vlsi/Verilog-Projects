module uart_tx(

    input CLK,
    input RST,

    input TX_START,
    input [7:0] DATA_IN,

    output reg TX,
    output reg BUSY

);

parameter IDLE      = 2'b00;
parameter START_BIT = 2'b01;
parameter DATA_BITS = 2'b10;
parameter STOP_BIT  = 2'b11;

reg [1:0] state,next_state;

reg [7:0] shift_reg;
reg [2:0] bit_count;
//state register
always @(posedge CLK or posedge RST)
begin
    if(RST)
        state <= IDLE;
    else
        state <= next_state;
end
//next state logic
always @(*)
begin

case(state)

IDLE:
    if(TX_START)
        next_state = START_BIT;
    else
        next_state = IDLE;

START_BIT:
    next_state = DATA_BITS;

DATA_BITS:
    if(bit_count == 3'd7)
        next_state = STOP_BIT;
    else
        next_state = DATA_BITS;

STOP_BIT:
    next_state = IDLE;

default:
    next_state = IDLE;

endcase

end
//output and datapath logic
always @(posedge CLK or posedge RST)
begin

if(RST)
begin

TX <= 1'b1;
BUSY <= 1'b0;
shift_reg <= 8'd0;
bit_count <= 3'd0;

end

else begin

case(state)

IDLE:
begin
TX <= 1'b1;
BUSY <= 1'b0;

if(TX_START)
begin
shift_reg <= DATA_IN;
bit_count <= 3'd0;
end

end

START_BIT:
begin
TX <= 1'b0;
BUSY <= 1'b1;
end

DATA_BITS:
begin

TX <= shift_reg[0];

shift_reg <= shift_reg >> 1;

bit_count <= bit_count + 1;

end

STOP_BIT:
begin

TX <= 1'b1;

BUSY <= 1'b0;

end

endcase

end

end
endmodule