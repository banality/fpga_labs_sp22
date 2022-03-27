// This module instantiates the synchronizer -> debouncer -> edge detector signal chain for button inputs
module button_parser #(
    parameter SIGNAL_WIDTH = 1,
    parameter SAMPLE_GENERATOR_CNT_MAX = 62500,
    parameter PULSE_CNT_MAX = 200
) (
    input clk,
    input [SIGNAL_WIDTH-1:0] in,
    output [SIGNAL_WIDTH-1:0] out
);
    wire [SIGNAL_WIDTH-1:0] synchronized_signals;
    wire [SIGNAL_WIDTH-1:0] debounced_signals;

    synchronizer # (
        .SIGNAL_WIDTH(SIGNAL_WIDTH)
    ) button_synchronizer (
        .clk(clk),
        .async_signal(in),
        .sync_signal(synchronized_signals)
    );

    debouncer # (
        .SIGNAL_WIDTH(SIGNAL_WIDTH),
        .SAMPLE_GENERATOR_CNT_MAX(SAMPLE_GENERATOR_CNT_MAX),
        .PULSE_CNT_MAX(PULSE_CNT_MAX)
    ) button_debouncer (
        .clk(clk),
        .glitchy_signal(synchronized_signals),
        .debounced_signal(debounced_signals)
    );

    edge_detector # (
        .SIGNAL_WIDTH(SIGNAL_WIDTH)
    ) button_edge_detector (
        .clk(clk),
        .signal_in(debounced_signals),
        .edge_detect_pulse(out)
    );
endmodule
