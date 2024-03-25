`timescale 1ns / 1ps

module delay #(
    parameter N = 4
) (
    input clk,
    input ce,
    input [N-1:0]idata,
    output [N-1:0]odata
);

reg [N-1:0] val = N-1'b0;

always @(posedge clk)
begin
    if (ce) val = idata;
    else val = val;
end

assign odata = val;

endmodule

module delay_line #(
    parameter N=4,
    parameter DELAY=0
) (
    input clk,
    input ce, 
    input [N-1:0]idata,
    output [N-1:0]odata
);

if (DELAY == 0)
    begin
        assign odata = idata;
    end
else
    begin
        // Dla delay większego od 1 tablica do przechowania danych
        wire [N-1:0]tdata [0:DELAY];
        
        genvar i;
        
        for (i=0; i<DELAY; i=i+1)
            begin
                // Generuję moduły typu delay jako delay _inst
                delay #(N) delay_inst (
                    .clk(clk),
                    .ce(ce),
                    .idata(i == 0 ? idata : tdata[i]),
                    .odata(tdata[i+1])
                );
            end
       
        assign odata = tdata[DELAY];
    end    
endmodule
