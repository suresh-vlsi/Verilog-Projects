`timescale 1ns/1ps

module spi_master
(
    input clk,
    input rst,

    input start,
    input [7:0] tx_data,

    output reg sclk,
    output reg mosi,
    output reg cs,

    output reg busy,
    output reg done
);

localparam IDLE  = 2'd0;
localparam LOAD  = 2'd1;
localparam SHIFT = 2'd2;
localparam DONE  = 2'd3;

reg [1:0] state;
reg [7:0] shift_reg;
reg [2:0] bit_cnt;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        state <= IDLE;
        shift_reg <= 8'd0;
        bit_cnt <= 3'd0;
        sclk <= 1'b0;
        mosi <= 1'b0;
        cs <= 1'b1;
        busy <= 1'b0;
        done <= 1'b0;
    end
    else
    begin
        done <= 1'b0;

        case(state)

            //---------------------------------
            // IDLE
            //---------------------------------
            IDLE:
            begin
                cs <= 1'b1;
                busy <= 1'b0;
                sclk <= 1'b0;

                if(start)
                    state <= LOAD;
            end

            //---------------------------------
            // LOAD
            //---------------------------------
            LOAD:
            begin
                shift_reg <= tx_data;
                bit_cnt <= 3'd7;
                cs <= 1'b0;
                busy <= 1'b1;
                state <= SHIFT;
            end

            //---------------------------------
            // SHIFT
            //---------------------------------
            SHIFT:
            begin
                sclk <= ~sclk;

                if(sclk == 1'b0)
                begin
                    mosi <= shift_reg[7];
                    shift_reg <= {shift_reg[6:0],1'b0};

                    if(bit_cnt == 0)
                        state <= DONE;
                    else
                        bit_cnt <= bit_cnt - 1'b1;
                end
            end

            //---------------------------------
            // DONE
            //---------------------------------
            DONE:
            begin
                cs <= 1'b1;
                busy <= 1'b0;
                done <= 1'b1;
                sclk <= 1'b0;
                state <= IDLE;
            end

            default:
                state <= IDLE;

        endcase
    end
end

endmodule