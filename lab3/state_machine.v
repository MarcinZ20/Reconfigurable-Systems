`timescale 1ns / 1ps

module UART(
    input clk,      // zegar
    input rst,      // reset
    input send,     // flaga, ze dane wyslane
    input [7:0] data, // 8-bitowy sygnał wejściowy
    output reg txd   // 1 bitowe wyjście
);

parameter STATE_IDLE = 2'b00;
parameter STATE_SEND_START_BIT = 2'b01;
parameter STATE_SEND_DATA = 2'b10;
parameter STATE_SEND_STOP_BIT = 2'b11;

// Deklaracja rejestru stanu
reg [1:0] state_reg, next_state;

// Deklaracja rejestru danych
reg [7:0] data_reg;

// Inicjalizacja
initial begin
    state_reg <= STATE_IDLE;
    data_reg <= 8'b0;
end

// Kolejność stanów
always @(posedge clk or posedge rst) begin
    if (rst) begin
        state_reg <= STATE_IDLE;
    end else begin
        state_reg <= next_state;
    end
end

always @(*) begin
    case(state_reg)
        STATE_IDLE: begin
            if (send && !send_prev) begin // Zbocze narastające na fladze send
                next_state = STATE_SEND_START_BIT;
                data_reg = data;
            end else begin
                next_state = STATE_IDLE;
            end
        end
        
        STATE_SEND_START_BIT: begin
            next_state = STATE_SEND_DATA;
            txd = 1'b1; // Wartość bitu startu
        end
        
        STATE_SEND_DATA: begin
            if (data_reg == 8'b0) begin
                next_state = STATE_SEND_STOP_BIT;
            end else begin
                next_state = STATE_SEND_DATA;
                txd = data_reg[0];
                data_reg = {data_reg[6:0], 1'b0}; // Przesuń dane o jeden bit w prawo
            end
        end
        
        STATE_SEND_STOP_BIT: begin
            next_state = STATE_IDLE;
            txd = 1'b0; // Wartość bitu stopu
        end
    endcase
end

// Przechowuje sobie poprzednią wartość send
reg send_prev;
always @(posedge clk or posedge rst) begin
    if (rst) begin
        send_prev <= 1'b0;
    end else begin
        send_prev <= send;
    end
end

endmodule