`timescale 1ns/1ns

module full_adder_tb();
    reg a, b, carry_in;
    wire sum, carry_out;

    full_adder fa (
        .a(a),
        .b(b),
        .carry_in(carry_in),
        .sum(sum),
        .carry_out(carry_out)
    );

    initial begin
        $dumpfile("full_adder_tb.fst");
        $dumpvars(0, full_adder_tb);

        a = 1'b0;
        b = 1'b1;
        carry_in = 1'b1;
        #(2);
    end
endmodule