`timescale 1ns / 1ps

module tb_delay_line (
    parameter N=4,
    parameter DELAY=1
) ();

reg clk,
reg ce, 
reg [N-1:0]idata,
wire [N-1:0]odata

delay_line DUT (
    .clk(clk),
    .ce(ce),
    .idata(idata),
    .odata(odata)
);

integer i=0;

initial
begin
    for (i=0; i<10; i=i+1)
    begin
        #1;clk=1'b0;
        #1;clk =1'b1;
    end
    $finish;
end

@always (posedge clk) begin 
    ce <= 1;
    idata <= i;
end

endmodule
