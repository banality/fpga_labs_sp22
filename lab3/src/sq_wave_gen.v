module sq_wave_gen (
    input clk,
    input next_sample,
    output [9:0] code
);
    reg [7:0] code_change_counter = 0;
    reg alternate_code_flag = 0;
    wire code_change_flag;

    // alternate the value of code between 462 and 562.
    assign code = (alternate_code_flag)?562:462;
    assign code_change_flag = (next_sample & code_change_counter == 8'd139)? 1:0;
    /**
     * Function: Convert the frequency of clk from 125MHz to 880Hz to generate the  square wave of 440Hz.
     * 
     * 
    **/
    always @(posedge clk) begin
        if (next_sample)
            if (code_change_counter == 8'd139)
                code_change_counter <= 1;
            else
                code_change_counter <= code_change_counter + 1;
        else
            code_change_counter <= code_change_counter;
    end

    // Inverse the code alternating flag that only needs one bit.
    always @(posedge clk) begin
        if (code_change_flag)
            alternate_code_flag <= ~alternate_code_flag;
        else
            alternate_code_flag <= alternate_code_flag;
    end
endmodule
