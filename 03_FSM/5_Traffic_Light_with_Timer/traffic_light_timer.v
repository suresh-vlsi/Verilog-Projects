`timescale 1ns/1ps

module traffic_light_timer
(
    input clk,
    input rst,

    output reg red,
    output reg yellow,
    output reg green
);

localparam GREEN  = 2'd0;
localparam YELLOW = 2'd1;
localparam RED    = 2'd2;

reg [1:0] state;
reg [3:0] timer;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        state <= GREEN;
        timer <= 0;
    end
    else
    begin
        case(state)

        //---------------------------------
        GREEN:
        begin
            if(timer == 9)
            begin
                timer <= 0;
                state <= YELLOW;
            end
            else
                timer <= timer + 1;
        end

        //---------------------------------
        YELLOW:
        begin
            if(timer == 2)
            begin
                timer <= 0;
                state <= RED;
            end
            else
                timer <= timer + 1;
        end

        //---------------------------------
        RED:
        begin
            if(timer == 9)
            begin
                timer <= 0;
                state <= GREEN;
            end
            else
                timer <= timer + 1;
        end

        default:
        begin
            state <= GREEN;
            timer <= 0;
        end

        endcase
    end
end

//----------------------------------------
// Output Logic
//----------------------------------------

always @(*)
begin

    red = 0;
    yellow = 0;
    green = 0;

    case(state)

        GREEN:
            green = 1;

        YELLOW:
            yellow = 1;

        RED:
            red = 1;

    endcase

end

endmodule