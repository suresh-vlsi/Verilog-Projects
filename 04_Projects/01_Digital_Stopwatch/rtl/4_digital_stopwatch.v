module digital_stopwatch #
(
    parameter CLK_FREQ = 50_000_000
)
(
    input  wire clk,
    input  wire rst,

    input  wire start,
    input  wire stop,

    output wire running,

    output wire [5:0] seconds,
    output wire [5:0] minutes
);

//==============================================================
// Internal Signals
//==============================================================

wire tick_1hz;
wire enable;
wire sec_overflow;

//==============================================================
// Clock Divider
// Generates one tick every second
//==============================================================

clock_divider #(
    .CLK_FREQ(CLK_FREQ)
)
u_clock_divider
(
    .clk      (clk),
    .rst      (rst),
    .tick_1hz (tick_1hz)
);

//==============================================================
// Control FSM
//==============================================================

control_fsm u_control_fsm
(
    .clk    (clk),
    .rst    (rst),
    .start  (start),
    .stop   (stop),
    .enable (enable)
);

//==============================================================
// Running Status
//==============================================================

assign running = enable;

//==============================================================
// Seconds Counter
// Counts every 1-Hz tick
//==============================================================

bcd_counter #(
    .MAX_COUNT(59)
)
u_seconds_counter
(
    .clk      (clk),
    .rst      (rst),
    .enable   (enable),
    .tick     (tick_1hz),

    .count    (seconds),
    .overflow (sec_overflow)
);

//==============================================================
// Minutes Counter
// Increments whenever seconds roll over
//==============================================================

bcd_counter #(
    .MAX_COUNT(59)
)
u_minutes_counter
(
    .clk      (clk),
    .rst      (rst),
    .enable   (enable),
    .tick     (sec_overflow),

    .count    (minutes),
    .overflow ()
);

endmodule