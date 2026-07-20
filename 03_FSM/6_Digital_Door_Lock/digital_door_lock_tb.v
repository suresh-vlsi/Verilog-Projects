`timescale 1ns/1ps

module digital_door_lock_tb;

reg clk;
reg rst;

reg enter;
reg [3:0] password;

wire unlock;
wire alarm;

//------------------------------------
 // DUT
//------------------------------------

digital_door_lock
#(
    .PASSWORD(4'b1010)
)
DUT
(
    .clk(clk),
    .rst(rst),
    .enter(enter),
    .password(password),
    .unlock(unlock),
    .alarm(alarm)
);

//------------------------------------
// Clock Generation
//------------------------------------

initial
    clk = 0;

always #5 clk = ~clk;

//------------------------------------
// Test Sequence
//------------------------------------

initial
begin

    rst = 1;
    enter = 0;
    password = 0;

    #20;
    rst = 0;

    //--------------------------------
    // Correct Password
    //--------------------------------

    #20;
    password = 4'b1010;
    enter = 1;

    #20;
    enter = 0;

    //--------------------------------
    // Wrong Password
    //--------------------------------

    #40;

    password = 4'b1111;
    enter = 1;

    #20;
    enter = 0;

    //--------------------------------
    // Another Correct Password
    //--------------------------------

    #40;

    password = 4'b1010;
    enter = 1;

    #20;
    enter = 0;

    #100;

    $finish;

end

//------------------------------------
// Monitor
//------------------------------------

initial
begin
    $display("Time Enter Password Unlock Alarm");

    $monitor("%4t    %b      %b      %b      %b",
             $time,
             enter,
             password,
             unlock,
             alarm);
end

//------------------------------------
// Waveform
//------------------------------------

initial
begin
    $dumpfile("digital_door_lock.vcd");
    $dumpvars(0,digital_door_lock_tb);
end

endmodule