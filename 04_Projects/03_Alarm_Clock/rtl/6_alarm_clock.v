module alarm_clock
#(
    parameter CLK_FREQ = 50_000_000
)
(
    input  wire        clk,
    input  wire        rst,

    // Alarm Programming
    input  wire        set_alarm,
    input  wire        alarm_enable,
    input  wire [4:0]  alarm_hour_in,
    input  wire [5:0]  alarm_min_in,

    // Current Time
    output wire [4:0]  hours,
    output wire [5:0]  minutes,
    output wire [5:0]  seconds,

    // Stored Alarm Time (optional for observation)
    output wire [4:0]  alarm_hour,
    output wire [5:0]  alarm_min,

    // Alarm Output
    output wire        alarm
);

// Internal Signals

wire tick_1hz;

wire sec_overflow;
wire min_overflow;

// Clock Divider

clock_divider
#(
    .CLK_FREQ(CLK_FREQ)
)
u_clock_divider
(
    .clk      (clk),
    .rst      (rst),
    .tick_1hz (tick_1hz)
);

// Seconds Counter

bcd_counter
#(
    .MAX_COUNT(59)
)
u_seconds_counter
(
    .clk      (clk),
    .rst      (rst),
    .enable   (1'b1),
    .tick     (tick_1hz),

    .count    (seconds),
    .overflow (sec_overflow)
);

// Minutes Counter

bcd_counter
#(
    .MAX_COUNT(59)
)
u_minutes_counter
(
    .clk      (clk),
    .rst      (rst),
    .enable   (1'b1),
    .tick     (sec_overflow),

    .count    (minutes),
    .overflow (min_overflow)
);

// Hours Counter

hour_counter
u_hour_counter
(
    .clk      (clk),
    .rst      (rst),
    .enable   (1'b1),
    .tick     (min_overflow),

    .count    (hours),
    .overflow ()
);

// Alarm Register

alarm_register
u_alarm_register
(
    .clk           (clk),
    .rst           (rst),

    .set_alarm     (set_alarm),

    .alarm_hour_in (alarm_hour_in),
    .alarm_min_in  (alarm_min_in),

    .alarm_hour    (alarm_hour),
    .alarm_min     (alarm_min)
);

// Alarm Comparator

alarm_comparator
u_alarm_comparator
(
    .alarm_enable (alarm_enable),

    .current_hour (hours),
    .current_min  (minutes),
    .current_sec  (seconds),

    .alarm_hour   (alarm_hour),
    .alarm_min    (alarm_min),

    .alarm        (alarm)
);

endmodule