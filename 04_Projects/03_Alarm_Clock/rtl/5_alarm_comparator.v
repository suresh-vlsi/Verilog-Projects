module alarm_comparator
(
    input  wire       alarm_enable,

    input  wire [4:0] current_hour,
    input  wire [5:0] current_min,
    input  wire [5:0] current_sec,

    input  wire [4:0] alarm_hour,
    input  wire [5:0] alarm_min,

    output wire       alarm
);

// Comparator Logic

assign alarm =
       alarm_enable &&
       (current_hour == alarm_hour) &&
       (current_min  == alarm_min ) &&
       (current_sec  == 6'd0);

endmodule