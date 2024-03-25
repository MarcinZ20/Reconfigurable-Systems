`timescale 1ns / 1ps

module testbench;

parameter DATA_WIDTH = 8; 
parameter FILENAME_IN = "input_data.bin"; 
parameter FILENAME_OUT = "output_data.bin"; 
parameter TIMEOUT = 1000;

reg clk = 0; 
reg rst = 1; 
reg send = 0; 
reg [DATA_WIDTH-1:0] data_in; 
reg [DATA_WIDTH-1:0] data_out; 
wire txd; 

// Instancja testowanego modułu
state_machine uut (
    .clk(clk),
    .rst(rst),
    .send(send),
    .data(data_in),
    .txd(txd)
);

// Czytanie danych z pliku wejściowego
initial begin
    $readmemb(FILENAME_IN, data_in);
end

// Generowanie sygnału send
initial begin
    #10; 
    send = 1;
    #10; 
    send = 0; 
    #10; 
    $finish;
end


always #5 clk = ~clk;

always @(posedge clk) begin
    if (send) begin
        data_out <= data_in;
    end
end


initial begin
    #10;
    $writememb(FILENAME_OUT, data_out);
end

endmodule
