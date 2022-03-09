`include "adder.vh"

module behavioral_adder (
    input [`ADDER_BIT_WIDTH-1:0] a,
    input [`ADDER_BIT_WIDTH-1:0] b,
    output [`ADDER_BIT_WIDTH:0] sum
);
    
    assign sum = a + b;
endmodule
