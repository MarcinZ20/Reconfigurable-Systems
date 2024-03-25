`timescale 1ns / 1ps

module tb_long_and #(
    parameter LENGTH=8
) ();

reg clk=1'b0;
reg [LENGTH-1:0]cnt=8'b0;

wire a,b;

long_and #(LENGTH) DUT (
    .x(cnt),
    .y(a)
);

initial // licznikiem generuje sygnały wejściowe
begin
    while(1)
    begin
        #1; clk=1'b0;
        #1; clk=1'b1;
    end
end

always @(posedge clk) // zboczem narastającym zwiększamy licznik
    begin
        cnt<=cnt+1;
    end  
 
assign a=cnt[1];
assign b=cnt[0];

endmodule
