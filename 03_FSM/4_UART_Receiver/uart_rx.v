`timescale 1ns/1ps

module uart_rx
#(
    parameter CLK_FREQ  = 50000000,
    parameter BAUD_RATE = 9600
)
(
    input clk,
    input rst,

    input rx,

    output reg [7:0] rx_data,
    output reg rx_done
);

localparam CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;

//-----------------------------------------------------
// State Encoding
//-----------------------------------------------------
localparam IDLE  = 2'd0;
localparam START = 2'd1;
localparam DATA  = 2'd2;
localparam STOP  = 2'd3;

reg [1:0] state;
reg [12:0] clk_count;
reg [2:0] bit_index;

//-----------------------------------------------------
// UART Receiver FSM
//-----------------------------------------------------
always @(posedge clk or posedge rst)
begin
    if (rst)
    begin
        state     <= IDLE;
        clk_count <= 0;
        bit_index <= 0;
        rx_data   <= 8'd0;
        rx_done   <= 1'b0;
    end
    else
    begin
        rx_done <= 1'b0;

        case(state)

        //-------------------------------------------------
        // IDLE
        //-------------------------------------------------
        IDLE:
        begin
            clk_count <= 0;
            bit_index <= 0;

            if(rx == 1'b0)
                state <= START;
        end

        //-------------------------------------------------
        // START BIT
        //-------------------------------------------------
        START:
        begin
            if(clk_count == (CLKS_PER_BIT/2))
            begin
                if(rx == 1'b0)
                begin
                    clk_count <= 0;
                    state <= DATA;
                end
                else
                begin
                    state <= IDLE;
                end
            end
            else
                clk_count <= clk_count + 1;
        end

        //-------------------------------------------------
        // DATA BITS
        //-------------------------------------------------
        DATA:
        begin
            if(clk_count < CLKS_PER_BIT-1)
            begin
                clk_count <= clk_count + 1;
            end
            else
            begin
                clk_count <= 0;
                rx_data[bit_index] <= rx;

                if(bit_index < 7)
                    bit_index <= bit_index + 1;
                else
                begin
                    bit_index <= 0;
                    state <= STOP;
                end
            end
        end

        //-------------------------------------------------
        // STOP BIT
        //-------------------------------------------------
        STOP:
        begin
            if(clk_count < CLKS_PER_BIT-1)
                clk_count <= clk_count + 1;
            else
            begin
                clk_count <= 0;

                if(rx == 1'b1)
                    rx_done <= 1'b1;

                state <= IDLE;
            end
        end

        default:
            state <= IDLE;

        endcase
    end
end

endmodule