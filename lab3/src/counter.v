module counter #(
    parameter CYCLES_PER_SECOND = 125_000_000,
    parameter STATIC_MODE = 0,
    parameter AUTO_INCREMENT_MODE = 1,

    // counter bit width for counting a second.
    parameter SECOND_CNT_WIDTH = $clog2(CYCLES_PER_SECOND + 1)
)(
    input clk,
    input ce,
    input [3:0] buttons,
    output [3:0] leds
);
    reg [3:0] counter = 0;

    reg counter_mode = STATIC_MODE;
    wire one_second_flag;
    reg [SECOND_CNT_WIDTH-1:0] second_counter = 0;

    assign one_second_flag = (second_counter == CYCLES_PER_SECOND)? 1:0;
    assign leds = counter;
    
    /**
     * second_counter
     *
    **/
    always @(posedge clk) begin
        if (counter_mode == AUTO_INCREMENT_MODE) begin
            if (second_counter == CYCLES_PER_SECOND)
                second_counter <= 1;
            else
                second_counter <= second_counter + 1;
        end  
        else
            second_counter <= 0;
    end

    /**
     * counter
     *
    **/
    always @(posedge clk) begin
        if (ce == 1'b1) begin
            // The nested if-else control the buttons priority (if some buttons are concurrently pressed)
            if (buttons[0] | one_second_flag)
                counter <= counter + 4'd1;
            else if (buttons[1])
                counter <= counter - 4'd1;
            else if (buttons[3])
                counter <= 4'd0;
            else
                counter <= counter;
        end  
    end

    // counter_mode FF
    always @(posedge clk) begin
        if (buttons[2])
            counter_mode <= ~counter_mode;
        else
            counter_mode <= counter_mode;
    end


endmodule

