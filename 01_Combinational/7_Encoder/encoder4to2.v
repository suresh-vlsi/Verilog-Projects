module encoder4to2(
    input D0,
    input D1,
    input D2,
    input D3,

    output Y1,
    output Y0
);

assign Y1 = D2 | D3;
assign Y0 = D1 | D3;

endmodule