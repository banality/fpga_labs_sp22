`timescale 1ns / 1ps
module test( output out, input in1, input in2 );

    reg q = 0;
    wire d;
    
    assign d = in1 & d;
    assign out = d;
//    always@ (negedge clk or negedge rst)
//        begin
//            if (rst == 1'b0)
//                q <= 0;
//            else
//                q <= d; 
//        end
//    assign d = ~q;
//    assign div2_clk = q;

endmodule
