module digital_clock #
(
    parameter CLK_FREQ = 50_000_000
)
(
    input  wire clk,
    input  wire rst,

    output wire [4:0] hours,
    output wire [5:0] minutes,
    output wire [5:0] seconds
);

// Internal Signals

wire tick_1hz;

wire sec_overflow;
wire min_overflow;

// Clock Divider
// Generates one pulse every second

clock_divider #(
    .CLK_FREQ(CLK_FREQ)
)
u_clock_divider
(
    .clk      (clk),
    .rst      (rst),
    .tick_1hz (tick_1hz)
);

// Seconds Counter (00-59)

bcd_counter #(
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

// Minutes Counter (00-59)

bcd_counter #(
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

// Hours Counter (00-23)

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

endmodule