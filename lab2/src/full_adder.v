module full_adder (
    input a,
    input b,
    input carry_in,
    output sum,
    output carry_out
);
    //sum = a'b'c + a'bc' + abc + ab'c'
    wire tmp_sum_and1;
    wire tmp_sum_and2;
    wire tmp_sum_and3;
    wire tmp_sum_and4;

    and (tmp_sum_and1, ~a, ~b, carry_in);
    and (tmp_sum_and2, ~a, b, ~carry_in);
    and (tmp_sum_and3, a, b, carry_in);
    and (tmp_sum_and4, a, ~b, ~carry_in);
    or (sum, tmp_sum_and1, tmp_sum_and2, tmp_sum_and3, tmp_sum_and4);

    // carry_out = ab + bc + ac
    wire tmp_cout_and1, tmp_cout_and2, tmp_cout_and3;

    and(tmp_cout_and1, a, b);
    and(tmp_cout_and2, a, carry_in);
    and(tmp_cout_and3, carry_in, b);
    or(carry_out, tmp_cout_and1, tmp_cout_and2, tmp_cout_and3);

endmodule
