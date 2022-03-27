// Digital signal to PWM-simulated anolog signal.
// ! Don't change the value of CYCLES_PER_WINDOW parameter.
module dac #(
    parameter CYCLES_PER_WINDOW = 1024,
    parameter CODE_WIDTH = $clog2(CYCLES_PER_WINDOW)
)(
    input clk,
    input [CODE_WIDTH-1:0] code,
    output next_sample,
    output pwm
);
    assign next_sample = (counter == CYCLES_PER_WINDOW-1)? 1:0;
    reg [CODE_WIDTH-1:0] counter = 0;
    reg pwm;

    // an example of using always@ for combinational logic.
    // This pulse width computation is a little bit odd.
    always @(*) begin
        if (code == 0)
            pwm = 0;
        else
            pwm = (counter <= code)? 1:0;
    end

    /**
     * counter
     *
     * 10-bit counter used to achieve auto wrapping for 1024
    **/
    always @(posedge clk) begin
        counter <= counter + 1;
    end
endmodule
