`timescale 1ns / 1ps

module testbench();
    reg a, b, rst;
    wire out;
    
    test t1(
        .in1(a),
        .in2(b),
        .out(out)
    );
    
    initial begin
        rst = 1'b1;
        a = 1'b0;
        b = 1'b0;
        #(2);
        
        a = 1'b1;
        b = 1'b0;
        #(2);
        
        a = 1'b0;  
        b = 1'b1; 
        #(2);
        a = 1'b1;
        b = 1'b1;
        #(2);
        
        a = 1'b0;   
        #(2);
        
        rst = 1'b0;
        #(1);
        rst = 1'b1;

        a = 1'b1;
        #(2);
        
        a = 1'b0;   
        #(2);
    end

endmodule
