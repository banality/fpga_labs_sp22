// any-bit ripple adder
// `include "adder.vh"

module structural_adder (
    input [ADDER_BIT_WIDTH-1:0] a,
    input [ADDER_BIT_WIDTH-1:0] b,
    output [ADDER_BIT_WIDTH:0] sum
);
    parameter ADDER_BIT_WIDTH = 32;

    wire [ADDER_BIT_WIDTH:0] carry_out;

    genvar i; 
    generate
        for (i = 0; i < ADDER_BIT_WIDTH; i = i+1) begin:generate_full_adders
            full_adder generated_FA(
                .a(a[i]),
                .b(b[i]),
                .carry_in(carry_out[i]),
                .sum(sum[i]),
                .carry_out(carry_out[i+1])
            );
        end
    endgenerate

    // You are describing hardware, not procedural software, so you can put your hardware-describing code anywhere. But maybe it's friendly for code reading to put this line of code above.
    // first adder uses carry_in with "0"
    assign carry_out[0] = 1'b0;

    assign sum[ADDER_BIT_WIDTH] = carry_out[ADDER_BIT_WIDTH];
endmodule
