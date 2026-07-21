module bcd_counter #
(
    parameter MAX_COUNT = 59
)
(
    input  wire clk,         // System clock
    input  wire rst,         // Asynchronous active-high reset
    input  wire enable,      // Counter enable
    input  wire tick,        // Clock enable pulse

    output reg [5:0] count,  // Counter output
    output reg overflow      // One-cycle rollover pulse
);

//==============================================================
// Counter Logic
//==============================================================

always @(posedge clk or posedge rst)
begin
    if (rst)
    begin
        count    <= 6'd0;
        overflow <= 1'b0;
    end
    else
    begin
        // Default: overflow is low
        overflow <= 1'b0;

        // Increment only when enabled and tick is asserted
        if (enable && tick)
        begin
            if (count == MAX_COUNT)
            begin
                count    <= 6'd0;
                overflow <= 1'b1;
            end
            else
            begin
                count    <= count + 6'd1;
            end
        end
    end
end

endmodule