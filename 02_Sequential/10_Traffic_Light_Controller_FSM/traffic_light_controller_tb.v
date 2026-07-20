`timescale 1ns/1ps

module traffic_light_controller_tb;

reg CLK;
reg RST;

wire NS_R;
wire NS_Y;
wire NS_G;

wire EW_R;
wire EW_Y;
wire EW_G;

traffic_light_controller uut(
    .CLK(CLK),
    .RST(RST),
    .NS_R(NS_R),
    .NS_Y(NS_Y),
    .NS_G(NS_G),
    .EW_R(EW_R),
    .EW_Y(EW_Y),
    .EW_G(EW_G)
);

// Clock generation
initial begin
    CLK = 0;
    forever #5 CLK = ~CLK;
end

initial begin

    $dumpfile("traffic_light_controller.vcd");
    $dumpvars(0, traffic_light_controller_tb);

    $display("Time\tState\tNS(RYG)\tEW(RYG)");
    $monitor("%0t\t%b\t%b%b%b\t%b%b%b",
             $time,
             uut.state,
             NS_R, NS_Y, NS_G,
             EW_R, EW_Y, EW_G);

    RST = 1;
    #12;

    RST = 0;

    // Observe several cycles
    #80;

    $finish;

end

endmodule