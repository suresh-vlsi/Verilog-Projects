`timescale 1ns/1ps

module vending_machine_tb;

reg CLK;
reg RST;
reg coin_5;
reg coin_10;

wire dispense;

vending_machine uut(
    .CLK(CLK),
    .RST(RST),
    .coin_5(coin_5),
    .coin_10(coin_10),
    .dispense(dispense)
);

// Clock generation
initial begin
    CLK = 0;
    forever #5 CLK = ~CLK;
end

initial begin

    $dumpfile("vending_machine.vcd");
    $dumpvars(0, vending_machine_tb);

    $display("Time\tState\t₹5 ₹10\tDispense");
    $monitor("%0t\t%b\t%b  %b\t%b",
             $time,
             uut.state,
             coin_5,
             coin_10,
             dispense);

    RST = 1;
    coin_5 = 0;
    coin_10 = 0;
    #12;

    RST = 0;

    // ₹5 + ₹10 = ₹15
    coin_5 = 1; #10;
    coin_5 = 0; #10;

    coin_10 = 1; #10;
    coin_10 = 0; #20;

    // ₹10 + ₹5 = ₹15
    coin_10 = 1; #10;
    coin_10 = 0; #10;

    coin_5 = 1; #10;
    coin_5 = 0; #20;

    $finish;

end

endmodule