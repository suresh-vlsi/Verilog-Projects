module elevator_controller(
    input CLK,
    input RST,
    input [2:0] REQ,

    output reg [1:0] FLOOR,
    output reg DOOR_OPEN
);

reg [1:0] state, next_state;
reg [1:0] target_floor;

parameter IDLE = 2'b00,
          MOVE = 2'b01,
          OPEN = 2'b10;

// State Register
always @(posedge CLK or posedge RST)
begin
    if(RST)
        state <= IDLE;
    else
        state <= next_state;
end

// Target Floor Register
always @(posedge CLK or posedge RST)
begin
    if(RST)
        target_floor <= 2'd0;
    else if(state == IDLE) begin
        if(REQ[0])
            target_floor <= 2'd0;
        else if(REQ[1])
            target_floor <= 2'd1;
        else if(REQ[2])
            target_floor <= 2'd2;
    end
end

// Next-State Logic
always @(*)
begin
    case(state)

        IDLE:
            if(REQ != 3'b000)
                next_state = MOVE;
            else
                next_state = IDLE;

        MOVE:
            next_state = OPEN;

        OPEN:
            next_state = IDLE;

        default:
            next_state = IDLE;

    endcase
end

// Output Logic
always @(posedge CLK or posedge RST)
begin
    if(RST) begin
        FLOOR <= 2'd0;
        DOOR_OPEN <= 1'b0;
    end
    else begin

        case(state)

            IDLE:
                DOOR_OPEN <= 1'b0;

            MOVE: begin
                FLOOR <= target_floor;
                DOOR_OPEN <= 1'b0;
            end

            OPEN:
                DOOR_OPEN <= 1'b1;

        endcase

    end
end

endmodule