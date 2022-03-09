`include "adder.vh"

module adder_tester (
    output [`ADDER_BIT_WIDTH-1:0] adder_operand1,
    output [`ADDER_BIT_WIDTH-1:0] adder_operand2,
    input [`ADDER_BIT_WIDTH:0] structural_sum,
    input [`ADDER_BIT_WIDTH:0] behavioral_sum,
    input clk,
    output test_fail
);
    reg error = 0;
    assign test_fail = error;

    reg [`ADDER_BIT_WIDTH*2 - 1:0] operands = 0;
    assign adder_operand1 = operands[`ADDER_BIT_WIDTH-1:0];
    assign adder_operand2 = operands[`ADDER_BIT_WIDTH*2 - 1:`ADDER_BIT_WIDTH];

    // Iterate the operands continuously until all combinations are tried
    always @ (posedge clk) begin
        operands <= operands + 1'd1;
    end

    // If we encounter a case where the adders don't match, or we have already
    // encountered one such case, flip the error register high and hold it there.
    always @ (posedge clk) begin
        if (structural_sum != behavioral_sum) begin
            error <= 1'b1;
        end
        else begin
            error <= error;
        end
    end
endmodule
