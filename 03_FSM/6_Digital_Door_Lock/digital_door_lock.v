`timescale 1ns/1ps

module digital_door_lock
#(
    parameter PASSWORD = 4'b1010
)
(
    input clk,
    input rst,

    input enter,
    input [3:0] password,

    output reg unlock,
    output reg alarm
);

localparam IDLE    = 2'b00;
localparam CHECK   = 2'b01;
localparam UNLOCK  = 2'b10;
localparam LOCKED  = 2'b11;

reg [1:0] state;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        state   <= IDLE;
        unlock  <= 0;
        alarm   <= 0;
    end
    else
    begin

        case(state)

        //------------------------------------
        // Wait for Password Entry
        //------------------------------------
        IDLE:
        begin
            unlock <= 0;
            alarm  <= 0;

            if(enter)
                state <= CHECK;
        end

        //------------------------------------
        // Verify Password
        //------------------------------------
        CHECK:
        begin
            if(password == PASSWORD)
                state <= UNLOCK;
            else
                state <= LOCKED;
        end

        //------------------------------------
        // Correct Password
        //------------------------------------
        UNLOCK:
        begin
            unlock <= 1;
            alarm  <= 0;

            if(!enter)
                state <= IDLE;
        end

        //------------------------------------
        // Wrong Password
        //------------------------------------
        LOCKED:
        begin
            unlock <= 0;
            alarm  <= 1;

            if(!enter)
                state <= IDLE;
        end

        default:
            state <= IDLE;

        endcase

    end
end

endmodule