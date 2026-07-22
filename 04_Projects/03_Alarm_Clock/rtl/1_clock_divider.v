module clock_divider #
(
    parameter CLK_FREQ = 50_000_000
)
(
    input  wire clk,
    input  wire rst,

    output reg tick_1hz
);

localparam COUNT_MAX = CLK_FREQ - 1;

reg [$clog2(CLK_FREQ)-1:0] counter;

always @(posedge clk or posedge rst)
begin
    if (rst)
    begin
        counter   <= 0;
        tick_1hz  <= 1'b0;
    end
    else
    begin
        if (counter == COUNT_MAX)
        begin
            counter  <= 0;
            tick_1hz <= 1'b1;
        end
        else
        begin
            counter  <= counter + 1'b1;
            tick_1hz <= 1'b0;
        end
    end
end

endmodule