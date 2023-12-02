`timescale 1ns / 1ps

module Mux32Bit2to1(    input [31:0] A, 
                        input [31:0] B, 
                        output reg [31:0] out, 
                        input control);
    
    always @*begin
        if(control == 1'b1)begin
            out <= B;
        end
        
        else begin
            out <= A;
        end
    end
endmodule
