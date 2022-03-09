`timescale 1ns/1ns

`define SECOND 1000000000
`define MS 1000000

module counter_testbench();
    reg clock = 0;
    reg ce;
    wire [3:0] LEDS;

    counter ctr (
        .clk(clock),
        .ce(ce),
        .LEDS(LEDS)
    );

    // Notice that this code causes the `clock` signal to constantly
    // switch up and down every 4 time steps.
    always #(4) clock <= ~clock;

    initial begin
        `ifdef IVERILOG
            $dumpfile("counter_testbench.fst");
            $dumpvars(0, counter_testbench);
        `endif
        `ifndef IVERILOG
            $vcdpluson;
        `endif

        // TODO: Change input values and step forward in time to test
        // your counter and its clock enable/disable functionality.
        ce = 0;
        #(400);
        ce = 1;
        #(400);
        ce = 0;
        #(400);
        ce = 1;
        // The simulation time is too long for one second
        #(`SECOND);
        if(LEDS != 4'd1) 
            $display("ERROR: Expected sum to be 1, actual value: %d", sum);
        ce = 0;
        #(2*`MS);
        ce = 1;

        #(`SECOND);

        `ifndef IVERILOG
            $vcdplusoff;
        `endif
        $finish();
    end
endmodule

