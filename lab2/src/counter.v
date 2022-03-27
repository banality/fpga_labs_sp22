module second_counter (input clk,
                       input ce,
                       output [3:0] LEDS);
    
    reg [3:0] led_cnt_value = 0;
    assign LEDS             = led_cnt_value;
    
    // TODO: Instantiate a reg net to count the number of cycles
    // required to reach one second. Note that our clock period is 8ns.
    /**
     * Think about how many bits are needed for your reg.
     * Solution: The system clock is 125MHz, so we need count 125*10^6 clock cycles for one second, which needs 27 bits to store the clock number. (remember the typical value: 10 bits means 1K = 1024). Notice that 1MHz is 10^6, not 1024^2, so the 27 bits is redundant. You can use calculator.
     *
     * In fact, you can use $clog2(i+1) function to compute the width.
     */
    reg [26:0] second_cnt_reg = 27'b0;
    
    always @(posedge clk) begin
        // TODO: update the reg if clock is enabled (ce is 1).
        if (ce == 1'b1) begin
            // Once the requisite number of cycles is reached, increment the count.
            if (second_cnt_reg == 7'd125 * 4'd10 ** 3'd6) begin
                second_cnt_reg <= 27'b1;
                // led_cnt_value can wrap around when it overflow.
                led_cnt_value <= led_cnt_value + 1;
            end 
            else
                second_cnt_reg <= second_cnt_reg + 1;
        end
            
    end
endmodule
