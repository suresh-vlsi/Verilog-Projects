`timescale 1ns/1ps

module uart_rx_tb;

reg CLK;
reg RST;
reg RX;

wire [7:0] DATA_OUT;
wire DATA_VALID;

uart_rx uut(
    .CLK(CLK),
    .RST(RST),
    .RX(RX),
    .DATA_OUT(DATA_OUT),
    .DATA_VALID(DATA_VALID)
);

// Clock generation
initial begin
    CLK = 0;
    forever #5 CLK = ~CLK;
end

task send_byte;
    input [7:0] data;
    integer i;
    begin
        // Idle
        RX = 1'b1;
        #10;

        // Start bit
        RX = 1'b0;
        #10;

        // Data bits (LSB first)
        for (i = 0; i < 8; i = i + 1) begin
            RX = data[i];
            #10;
        end

        // Stop bit
        RX = 1'b1;
        #10;
    end
endtask

initial begin

    $dumpfile("uart_rx.vcd");
    $dumpvars(0, uart_rx_tb);

    RST = 1;
    RX = 1;

    #20;
    RST = 0;

    send_byte(8'hA5);

    #40;

    send_byte(8'h3C);

    #40;

    $finish;
end

initial begin
    $monitor("Time=%0t RX=%b DATA_OUT=%h DATA_VALID=%b",
              $time, RX, DATA_OUT, DATA_VALID);
end

endmodule