`timescale 1ns / 1ps

module testbench;

// Parametry
parameter DATA_WIDTH = 8; // Szerokość danych wejściowych
parameter FILENAME_IN = "input_data.bin"; // Nazwa pliku wejściowego
parameter FILENAME_OUT = "output_data.bin"; // Nazwa pliku wyjściowego
parameter TIMEOUT = 1000; // Maksymalna liczba cykli zegara

// Sygnały
reg clk = 0; // Zegar
reg rst = 1; // Reset (aktywny wysoki)
reg send = 0; // Flaga send
reg [DATA_WIDTH-1:0] data_in; // Dane wejściowe
reg [DATA_WIDTH-1:0] data_out; // Dane wyjściowe
wire txd; // Wyjście txd

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
    #10; // Opóźnienie początkowe
    send = 1; // Wysłanie pierwszego zestawu danych
    #10; // Opóźnienie między zestawami danych
    send = 0; // Wyłączenie sygnału send
    #10; // Opóźnienie końcowe
    $finish; // Zakończenie symulacji
end

// Generowanie zegara
always #5 clk = ~clk;

// Monitorowanie danych wyjściowych
always @(posedge clk) begin
    if (send) begin
        data_out <= data_in;
    end
end

// Zapis danych wyjściowych do pliku
initial begin
    #10; // Opóźnienie na upewnienie się, że dane zostały zapisane
    $writememb(FILENAME_OUT, data_out);
end

endmodule
