`timescale 1ns/1ns

`define CLK_PERIOD 8
`define CYCLES_PER_SECOND_FOR_TEST 30

module counter_tb();
    reg clk = 0;
    always #(`CLK_PERIOD/2) clk <= ~clk;

    wire [3:0] leds;
    reg [3:0] buttons = 0;
    reg ce = 1;

    counter #(
        .CYCLES_PER_SECOND(`CYCLES_PER_SECOND_FOR_TEST)
    ) DUT(
        .clk(clk),
        .ce(ce),
        .buttons(buttons),
        .leds(leds)
    );

    initial begin
        `ifdef IVERILOG
            $dumpfile("counter_tb.fst");
            $dumpvars(0, counter_tb);
        `endif
        `ifndef IVERILOG
            $vcdpluson;
        `endif

        #(`CLK_PERIOD);
        buttons[0] = 1; 
        #(`CLK_PERIOD);
        buttons[0] = 0;
        #(1);
        if (leds != 4'b1) $error ("buttons[0] function error!");

        #(`CLK_PERIOD);
        buttons[1] = 1; 
        #(`CLK_PERIOD);
        buttons[1] = 0;
        if (leds != 4'b0) $error ("buttons[1] function error!");

        buttons[2] = 1;
        #(`CLK_PERIOD);
        buttons[2] = 0;
        repeat (`CYCLES_PER_SECOND_FOR_TEST * 5 + 2) @(posedge clk);
        if (leds != 4'd5) $error ("buttons[2] function error!");

        buttons[2] = 1;
        #(`CLK_PERIOD + 1);
        buttons[2] = 0;
        repeat (`CYCLES_PER_SECOND_FOR_TEST * 5 + 2) @(posedge clk);
        if (leds != 4'd5) $error ("buttons[2] function error!");

        `ifndef IVERILOG
            $vcdplusoff;
        `endif
        $finish();
    end

endmodule