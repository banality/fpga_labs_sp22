module synchronizer #(parameter SIGNAL_WIDTH = 1) (
    input [SIGNAL_WIDTH-1:0] async_signal,
    input clk,
    output reg [SIGNAL_WIDTH-1:0] sync_signal
);
    // TODO: Create your 2 flip-flop synchronizer here
    // This module takes in a vector of SIGNAL_WIDTH-bit asynchronous
    // (from different clock domain or not clocked, such as button press) signals
    // and should output a vector of SIGNAL_WIDTH-bit synchronous signals
    // that are synchronized to the input clk
    reg [SIGNAL_WIDTH-1:0] q1;
    always @(posedge clk) begin
        q1 <= async_signal;
        sync_signal <= q1;
    end
endmodule
