module and_gate(
    input a,
    input b,
    output c
);

assign c = a & b;

endmodule

module or_gate(
    input a, 
    input b, 
    output c
);

assign c = a | b;

endmodule

module not_gate(
    input a,
    output c
);

assign c = ~a;

endmodule

module decoder (
    input [1:0]a,
    output [3:0]b,
);

// table
//
// | a0 | a1 | b0 | b1 | b2 | b3 | 
// |----|----|----|----|----|----|
// | 0  | 0  | 1  | 0  | 0  | 0  |
// | 0  | 1  | 0  | 1  | 0  | 0  |
// | 1  | 0  | 0  | 0  | 1  | 0  |
// | 1  | 1  | 0  | 0  | 0  | 1  |

assign b[0] = ((a==2'b00) ? 1'b1 : 1'b0);
assign b[1] = ((a==2'b01) ? 1'b1 : 1'b0);
assign b[2] = ((a==2'b10) ? 1'b1 : 1'b0);
assign b[3] = ((a==2'b11) ? 1'b1 : 1'b0);


endmodule

module koder(
    input [3:0]a,
    output[1:0]b,
);

// table
// | a0 | a1 | a2 | a3 | b0 | b1 |
// |----|----|----|----|----|----|
// | 1  | 0  | 0  | 0  | 0  | 0  |
// | 0  | 1  | 0  | 0  | 0  | 1  |
// | 0  | 0  | 1  | 0  | 1  | 0  |
// | 0  | 0  | 0  | 1  | 1  | 1  |

assign b = (a[0]) ? 2'b00 : (a[1]) ? 2'b01 : (a[2]) ? 2'b10 : 2'b11;

endmodule

module demux(
    input x, 
    input [1:0]a,
    output [3:0]b
);

// table
// | x | a0 | a1 | b0 | b1 | b2 | b3 |
// |---|----|----|----|----|----|----|
// | 0 | 0  | 0  | 0  | 0  | 0  | 0  |
// | 0 | 0  | 1  | 0  | 0  | 0  | 0  |
// | 0 | 1  | 0  | 0  | 0  | 0  | 0  |
// | 0 | 1  | 1  | 0  | 0  | 0  | 0  |
// | 1 | 0  | 0  | 1  | 0  | 0  | 0  |
// | 1 | 0  | 1  | 0  | 1  | 0  | 0  |
// | 1 | 1  | 0  | 0  | 0  | 1  | 0  |
// | 1 | 1  | 1  | 0  | 0  | 0  | 1  |

// Dla kazdego wejscia przypisanie tego co w x jesli a jest takie jak w tabeli, w przeciwnym wypadku 0
assign b[0] = (a==2'b00) ? x : 1'b0;
assign b[1] = (a==2'b01) ? x : 1'b0;
assign b[2] = (a==2'b10) ? x : 1'b0;
assign b[3] = (a==2'b11) ? x : 1'b0;

endmodule 

module mux(
    input [3:0]a,
    input [1:0]b,
    output x
);

// table
// | a0 | a1 | a2 | a3 | b0 | b1 | x |
// |----|----|----|----|----|----|---|
// | 0  | 0  | 0  | 0  | 0  | 0  | 0 |
// | 0  | 0  | 0  | 0  | 0  | 1  | 0 |
// | 0  | 0  | 0  | 0  | 1  | 0  | 0 |
// | 0  | 0  | 0  | 0  | 1  | 1  | 0 |
// | 0  | 0  | 0  | 0  | 0  | 0  | 0 |
// | 0  | 0  | 0  | 0  | 0  | 1  | 1 |
// | 0  | 0  | 0  | 0  | 1  | 0  | 0 |
// | 0  | 0  | 0  | 0  | 1  | 1  | 1 |

// Dla kazdego wejscia przypisanie tego co w a jesli b jest takie jak w tabeli, w przeciwnym wypadku 0
assign y = x[a];

endmodule

module register(
    input clk,
    input ce,
    input d,
    output q
);

reg val = 1'b0;

always @(posedge clk)
begin
  if(ce) val<=d;
  else val<=val;
end

q = val;

endmodule

module counter(
    input clk,
    input ce,
    input rst,
    output [3:0]q
);

reg [3:0]val = 4'b0000;

always @(posedge clk) 
begin
    if(rst) val<=4’b0000; 
    else
        if(ce) val<=val+1;
        else val<=val; 
end

assign y=val;

endmodule