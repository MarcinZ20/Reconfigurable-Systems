`timescale 1ns / 1ps

module long_and #(
    parameter LENGTH=8
) (
    input [LENGTH-1:0]x,
    output y
);

wire [LENGTH-1:0] chain;
assign chain[0] = 1'b1; // Inaczej niż OR (bez 1 na wyjściu zawsze byłoby 0)

genvar v;

generate
    for(v=0; v<LENGTH-1; v=v+1)
    begin
        assign chain[v+1] = x[v] & chain[v];
    end
endgenerate

assign y = chain[LENGTH];

endmodule
