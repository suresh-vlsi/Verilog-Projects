`timescale 1ns/1ps

module washing_machine_controller
(
    input clk,
    input rst,
    input start,

    output reg fill_water,
    output reg wash,
    output reg rinse,
    output reg spin,
    output reg done
);

    //----------------------------------------
    // State Encoding
    //----------------------------------------
    localparam IDLE  = 3'd0;
    localparam FILL  = 3'd1;
    localparam WASH  = 3'd2;
    localparam RINSE = 3'd3;
    localparam SPIN  = 3'd4;
    localparam DONE  = 3'd5;

    reg [2:0] state;
    reg [3:0] timer;

    //----------------------------------------
    // Sequential FSM
    //----------------------------------------
    always @(posedge clk or posedge rst)
    begin
        if (rst)
        begin
            state <= IDLE;
            timer <= 4'd0;
        end
        else
        begin
            case (state)

                //----------------------------------------
                // IDLE
                //----------------------------------------
                IDLE:
                begin
                    timer <= 4'd0;

                    if (start)
                        state <= FILL;
                end

                //----------------------------------------
                // FILL (3 cycles)
                //----------------------------------------
                FILL:
                begin
                    if (timer == 2)
                    begin
                        timer <= 4'd0;
                        state <= WASH;
                    end
                    else
                        timer <= timer + 1'b1;
                end

                //----------------------------------------
                // WASH (5 cycles)
                //----------------------------------------
                WASH:
                begin
                    if (timer == 4)
                    begin
                        timer <= 4'd0;
                        state <= RINSE;
                    end
                    else
                        timer <= timer + 1'b1;
                end

                //----------------------------------------
                // RINSE (3 cycles)
                //----------------------------------------
                RINSE:
                begin
                    if (timer == 2)
                    begin
                        timer <= 4'd0;
                        state <= SPIN;
                    end
                    else
                        timer <= timer + 1'b1;
                end

                //----------------------------------------
                // SPIN (4 cycles)
                //----------------------------------------
                SPIN:
                begin
                    if (timer == 3)
                    begin
                        timer <= 4'd0;
                        state <= DONE;
                    end
                    else
                        timer <= timer + 1'b1;
                end

                //----------------------------------------
                // DONE
                //----------------------------------------
                DONE:
                begin
                    state <= IDLE;
                end

                //----------------------------------------
                // Default
                //----------------------------------------
                default:
                begin
                    state <= IDLE;
                    timer <= 4'd0;
                end

            endcase
        end
    end

    //----------------------------------------
    // Output Logic (Moore FSM)
    //----------------------------------------
    always @(*)
    begin
        fill_water = 1'b0;
        wash       = 1'b0;
        rinse      = 1'b0;
        spin       = 1'b0;
        done       = 1'b0;

        case (state)

            FILL:
                fill_water = 1'b1;

            WASH:
                wash = 1'b1;

            RINSE:
                rinse = 1'b1;

            SPIN:
                spin = 1'b1;

            DONE:
                done = 1'b1;

            default:
            begin
                fill_water = 1'b0;
                wash       = 1'b0;
                rinse      = 1'b0;
                spin       = 1'b0;
                done       = 1'b0;
            end

        endcase
    end

endmodule