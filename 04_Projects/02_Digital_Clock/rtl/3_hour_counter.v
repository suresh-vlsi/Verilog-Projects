
module hour_counter
(
    input  wire clk,         // System Clock
    input  wire rst,         // Asynchronous Active-High Reset
    input  wire enable,      // Counter Enable
    input  wire tick,        // Increment Pulse

    output reg [4:0] count,  // Hours (00-23)
    output reg overflow      // One-Cycle Overflow Pulse
);

// Counter Logic

always @(posedge clk or posedge rst)
begin
    if (rst)
    begin
        count    <= 5'd0;
        overflow <= 1'b0;
    end
    else
    begin
        // Default output
        overflow <= 1'b0;

        // Increment only when enabled and tick is asserted
        if (enable && tick)
        begin
            if (count == 5'd23)
            begin
                count    <= 5'd0;
                overflow <= 1'b1;
            end
            else
            begin
                count <= count + 5'd1;
            end
        end
    end
end

endmodule