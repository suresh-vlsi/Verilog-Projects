module uart_rx(
    input CLK,
    input RST,
    input RX,

    output reg [7:0] DATA_OUT,
    output reg DATA_VALID
);

localparam IDLE      = 3'd0,
           START_BIT = 3'd1,
           DATA_BITS = 3'd2,
           STOP_BIT  = 3'd3,
           COMPLETE  = 3'd4;

reg [2:0] state, next_state;
reg [7:0] shift_reg;
reg [2:0] bit_count;

//==============================================================
// State Register
//==============================================================
always @(posedge CLK or posedge RST) begin
    if (RST)
        state <= IDLE;
    else
        state <= next_state;
end

//==============================================================
// Next-State Logic
//==============================================================
always @(*) begin
    case (state)
        IDLE:
            if (RX == 1'b0)
                next_state = START_BIT;
            else
                next_state = IDLE;

        START_BIT:
            next_state = DATA_BITS;

        DATA_BITS:
            if (bit_count == 3'd7)
                next_state = STOP_BIT;
            else
                next_state = DATA_BITS;

        STOP_BIT:
            next_state = COMPLETE;

        COMPLETE:
            next_state = IDLE;

        default:
            next_state = IDLE;
    endcase
end

//==============================================================
// Datapath
//==============================================================
always @(posedge CLK or posedge RST) begin
    if (RST) begin
        shift_reg <= 8'd0;
        bit_count <= 3'd0;
        DATA_OUT  <= 8'd0;
    end
    else begin
        case (state)

            IDLE:
                bit_count <= 3'd0;

            DATA_BITS: begin
                shift_reg[bit_count] <= RX;
                bit_count <= bit_count + 1'b1;
            end

            STOP_BIT:
                DATA_OUT <= shift_reg;

        endcase
    end
end

//==============================================================
// Output Logic
//==============================================================
always @(*) begin
    DATA_VALID = (state == COMPLETE);
end

endmodule