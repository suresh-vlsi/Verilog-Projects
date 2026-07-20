`timescale 1ns/1ps

module elevator_controller_tb;

reg CLK;
reg RST;
reg [2:0] REQ;

wire [1:0] FLOOR;
wire DOOR_OPEN;

elevator_controller uut(
    .CLK(CLK),
    .RST(RST),
    .REQ(REQ),
    .FLOOR(FLOOR),
    .DOOR_OPEN(DOOR_OPEN)
);

// Clock generation
initial begin
    CLK = 0;
    forever #5 CLK = ~CLK;
end

initial begin

    $dumpfile("elevator_controller.vcd");
    $dumpvars(0, elevator_controller_tb);

    $display("Time\tREQ\tFloor\tDoor");
    $monitor("%0t\t%b\t%0d\t%b",
             $time,
             REQ,
             FLOOR,
             DOOR_OPEN);

    RST = 1;
    REQ = 3'b000;
    #12;

    RST = 0;

    // Request Floor 2
    REQ = 3'b100;
    #10;
    REQ = 3'b000;

    #30;

    // Request Floor 1
    REQ = 3'b010;
    #10;
    REQ = 3'b000;

    #30;

    // Request Floor 0
    REQ = 3'b001;
    #10;
    REQ = 3'b000;

    #40;

    $finish;

end

endmodule