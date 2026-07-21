module control_fsm
(
    input  wire clk,
    input  wire rst,

    input  wire start,
    input  wire stop,

    output reg  enable
);

localparam IDLE    = 2'b00;
localparam RUNNING = 2'b01;
localparam PAUSED  = 2'b10;

reg [1:0] state;
reg [1:0] next_state;


//====================================================
// State Register
//====================================================

always @(posedge clk or posedge rst)
begin
    if (rst)
        state <= IDLE;
    else
        state <= next_state;
end


//====================================================
// Next-State Logic
//====================================================

always @(*)
begin
    next_state = state;

    case (state)

        IDLE:
        begin
            if (start)
                next_state = RUNNING;
        end

        RUNNING:
        begin
            if (stop)
                next_state = PAUSED;
        end

        PAUSED:
        begin
            if (start)
                next_state = RUNNING;
        end

        default:
            next_state = IDLE;

    endcase
end


//====================================================
// Output Logic (Moore FSM)
//====================================================

always @(*)
begin
    case (state)

        IDLE:
            enable = 1'b0;

        RUNNING:
            enable = 1'b1;

        PAUSED:
            enable = 1'b0;

        default:
            enable = 1'b0;

    endcase
end

endmodule