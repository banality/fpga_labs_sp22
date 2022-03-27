// we can combine this module with synchronizer to detect async signal.
module edge_detector #(
    parameter SIGNAL_WIDTH = 1
)(
    input clk,
    input [SIGNAL_WIDTH-1:0] signal_in,
    output reg [SIGNAL_WIDTH-1:0] edge_detect_pulse = 0
);
    // TODO: implement a multi-bit edge detector that detects a rising edge of 'signal_in[x]'
    // and outputs a one-cycle pulse 'edge_detect_pulse[x]' at the next clock edge, so a FF is needed to achieve the "one cycle" goal.
    // Feel free to use as many number of registers you like

    // store previous value.
    reg [SIGNAL_WIDTH-1:0] pre_signal_in;
    
    genvar j;
    for (j = 0; j < SIGNAL_WIDTH; j = j+1) begin
        always @(posedge clk) begin
            pre_signal_in[j] <= signal_in[j];

            // compare the current value with the previous value to know whether there is a rising edge or not, because digital circuit only has 0 and 1.
            // If there is a rising edge, the signal_in will be "<=" pre_signal_in at the next clock, so the edge_detect_pulse will only maintain one clock cycle.
            edge_detect_pulse[j] <= (signal_in[j] > pre_signal_in[j])? 1'b1 : 1'b0;
        end
    end
endmodule
