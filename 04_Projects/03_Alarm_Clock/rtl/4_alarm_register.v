module alarm_register
(
    input  wire       clk,          // System Clock
    input  wire       rst,          // Asynchronous Active-High Reset

    input  wire       set_alarm,    // Load Alarm Time

    input  wire [4:0] alarm_hour_in,
    input  wire [5:0] alarm_min_in,

    output reg  [4:0] alarm_hour,
    output reg  [5:0] alarm_min
);

// Alarm Register Logic

always @(posedge clk or posedge rst)
begin
    if (rst)
    begin
        alarm_hour <= 5'd0;
        alarm_min  <= 6'd0;
    end
    else if (set_alarm)
    begin
        alarm_hour <= alarm_hour_in;
        alarm_min  <= alarm_min_in;
    end
end

endmodule