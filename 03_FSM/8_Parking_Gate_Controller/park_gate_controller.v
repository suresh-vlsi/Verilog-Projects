`timescale 1ns/1ps

module park_gate_controller
(
    input clk,
    input rst,

    input vehicle_detect,
    input vehicle_passed,

    output reg gate_open,
    output reg gate_close
);

    //-----------------------------------------
    // State Encoding
    //-----------------------------------------

    localparam IDLE      = 2'd0;
    localparam OPEN_GATE = 2'd1;
    localparam WAIT_PASS = 2'd2;
    localparam CLOSE_GATE= 2'd3;

    reg [1:0] state;
    reg [2:0] timer;

    //-----------------------------------------
    // Sequential FSM
    //-----------------------------------------

    always @(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            state <= IDLE;
            timer <= 0;
        end
        else
        begin

            case(state)

                //---------------------------------
                // IDLE
                //---------------------------------

                IDLE:
                begin
                    timer <= 0;

                    if(vehicle_detect)
                        state <= OPEN_GATE;
                end

                //---------------------------------
                // OPEN GATE
                //---------------------------------

                OPEN_GATE:
                begin
                    if(timer == 2)
                    begin
                        timer <= 0;
                        state <= WAIT_PASS;
                    end
                    else
                        timer <= timer + 1;
                end

                //---------------------------------
                // WAIT FOR VEHICLE
                //---------------------------------

                WAIT_PASS:
                begin
                    if(vehicle_passed)
                        state <= CLOSE_GATE;
                end

                //---------------------------------
                // CLOSE GATE
                //---------------------------------

                CLOSE_GATE:
                begin
                    if(timer == 2)
                    begin
                        timer <= 0;
                        state <= IDLE;
                    end
                    else
                        timer <= timer + 1;
                end

                //---------------------------------
                // DEFAULT
                //---------------------------------

                default:
                begin
                    state <= IDLE;
                    timer <= 0;
                end

            endcase

        end
    end

    //-----------------------------------------
    // Output Logic
    //-----------------------------------------

    always @(*)
    begin

        gate_open  = 0;
        gate_close = 0;

        case(state)

            OPEN_GATE:
                gate_open = 1;

            CLOSE_GATE:
                gate_close = 1;

            default:
            begin
                gate_open = 0;
                gate_close = 0;
            end

        endcase

    end

endmodule