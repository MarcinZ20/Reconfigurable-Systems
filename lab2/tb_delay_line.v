`timescale 1ns / 1ps



module tb_delay_line;

reg clk,
reg ce, 
reg [N-1:0]idata,
wire [N-1:0]odata

top uut (
    .clk(clk),
    .ce(ce),
    .idata(idata),
    .odata(odata)
);

integer i = 0;

initial
begin
    for (i=0; i<10; i=i+1)
end
endmodule
