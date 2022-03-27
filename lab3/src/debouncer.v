module debouncer #(
    parameter SIGNAL_WIDTH       = 1,
    parameter SAMPLE_GENERATOR_CNT_MAX   = 62500,
    parameter PULSE_CNT_MAX      = 200,
    
    parameter SAMPLE_GENERATOR_CNT_WIDTH = $clog2(SAMPLE_GENERATOR_CNT_MAX + 1),
    parameter SAT_CNT_WIDTH      = $clog2(PULSE_CNT_MAX + 1)
) (
    input clk,
    input [SIGNAL_WIDTH-1:0] glitchy_signal,
    output [SIGNAL_WIDTH-1:0] debounced_signal
);
    // One sample_generator counter is required to be a pulse generator.
    reg [SAMPLE_GENERATOR_CNT_WIDTH-1:0] sample_generator_counter = 0;
    wire sample_pulse_generated;
    assign sample_pulse_generated = (sample_generator_counter == SAMPLE_GENERATOR_CNT_MAX)? 1'b1 : 1'b0;
    
    always @(posedge clk) begin
        if (sample_generator_counter == SAMPLE_GENERATOR_CNT_MAX) begin
            sample_generator_counter <= 1;
        end
        else begin
            sample_generator_counter <= sample_generator_counter + 1;
        end
    end

    // One saturating counter is needed for each bit of glitchy_signal
    // You need to think of the conditions for reseting, clock enable, etc. those registers
    wire [SIGNAL_WIDTH-1:0] sat_cnt_rst;
    wire [SIGNAL_WIDTH-1:0] sat_cnt_enable;
    // used to store saturating counter value to judge whether this is a real pressed button, not short spurious pulse.
    reg [SAT_CNT_WIDTH-1:0] saturating_counter [SIGNAL_WIDTH-1:0];
    genvar i;
    for (i = 0; i < SIGNAL_WIDTH; i = i+1) begin
        assign sat_cnt_rst[i] = ~glitchy_signal[i];
        assign sat_cnt_enable[i] = sample_pulse_generated & glitchy_signal[i];
        assign debounced_signal[i] = (saturating_counter[i] == PULSE_CNT_MAX)? 1'b1 : 1'b0;
        always @(posedge clk) begin
            if (sat_cnt_rst[i] == 1'b1)
                saturating_counter[i] <= 1'b0;
            else if (sat_cnt_enable[i] == 1'b1) begin
                // keep this counter value to keep debounced signal be a "1", until the glitchy signal reset the saturating counter.
                if (saturating_counter[i] == PULSE_CNT_MAX)
                    saturating_counter[i] <= saturating_counter[i];
                else
                    saturating_counter[i] <= saturating_counter[i] + 1;
            end
        end
    end
endmodule
