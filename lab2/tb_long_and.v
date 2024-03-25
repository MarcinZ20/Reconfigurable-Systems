`timescale 1ns / 1ps

module tb_long_and #(
    parameter LENGTH=8
) ();

reg clk=1'b0;
reg [1:0]cnt=2'b0;

wire a,b;

long_and #(LENGTH) UUT (
    .x(cnt),
    .y(a)
);

initial // parameters generation
begin
    while(1)
    begin
        #1; clk=1'b0;
        #1; clk=1'b1;
    end
end

always @(posedge clk)
    begin
        cnt<=cnt+1;
    end  
 
 assign a=cnt[1];
 assign b=cnt[0];

endmodule
