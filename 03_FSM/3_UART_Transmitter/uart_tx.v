`timescale 1ns/1ps

module uart_tx
#(
    parameter CLK_FREQ  = 50000000,
    parameter BAUD_RATE = 9600
)
(
    input clk,
    input rst,

    input tx_start,
    input [7:0] tx_data,

    output reg tx,
    output reg tx_busy
);

localparam CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;

//----------------------------------------------------
// State Encoding
//----------------------------------------------------
localparam IDLE  = 2'd0;
localparam START = 2'd1;
localparam DATA  = 2'd2;
localparam STOP  = 2'd3;

reg [1:0] state;

reg [12:0] clk_count;
reg [2:0] bit_index;
reg [7:0] data_reg;

//----------------------------------------------------
// UART FSM
//----------------------------------------------------
always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        state      <= IDLE;
        tx         <= 1'b1;
        tx_busy    <= 1'b0;
        clk_count  <= 0;
        bit_index  <= 0;
        data_reg   <= 0;
    end

    else
    begin

        case(state)

        //------------------------------------------
        // IDLE
        //------------------------------------------
        IDLE:
        begin
            tx <= 1'b1;
            clk_count <= 0;
            bit_index <= 0;
            tx_busy <= 0;

            if(tx_start)
            begin
                data_reg <= tx_data;
                tx_busy <= 1;
                state <= START;
            end
        end

        //------------------------------------------
        // START BIT
        //------------------------------------------
        START:
        begin
            tx <= 1'b0;

            if(clk_count < CLKS_PER_BIT-1)
                clk_count <= clk_count + 1;
            else
            begin
                clk_count <= 0;
                state <= DATA;
            end
        end

        //------------------------------------------
        // DATA BITS
        //------------------------------------------
        DATA:
        begin
            tx <= data_reg[bit_index];

            if(clk_count < CLKS_PER_BIT-1)
                clk_count <= clk_count + 1;
            else
            begin
                clk_count <= 0;

                if(bit_index < 7)
                    bit_index <= bit_index + 1;
                else
                begin
                    bit_index <= 0;
                    state <= STOP;
                end
            end
        end

        //------------------------------------------
        // STOP BIT
        //------------------------------------------
        STOP:
        begin
            tx <= 1'b1;

            if(clk_count < CLKS_PER_BIT-1)
                clk_count <= clk_count + 1;
            else
            begin
                clk_count <= 0;
                tx_busy <= 0;
                state <= IDLE;
            end
        end

        default:
            state <= IDLE;

        endcase

    end
end

endmodule