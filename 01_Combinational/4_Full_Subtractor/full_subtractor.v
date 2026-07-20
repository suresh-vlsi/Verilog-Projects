module full_subtractor(
    input A,
    input B,
    input Bin,
    output Difference,
    output Bout
);

assign Difference = A ^ B ^ Bin;

assign Bout = (~A & B) | (~(A ^ B) & Bin);

endmodule