`timescale 1ns / 1ps

module Mux32Bit4to1(    input [31:0] A, 
                        input [31:0] B, 
                        input [31:0] C, 
                        input [31:0] D, 
                        output reg [31:0] out, 
                        input control1, 
                        input control2
                        );
    
    always @*begin
        out <= A;
        if(control1 == 1'b0 && control2 == 1'b0)begin
            out <= A;
        end
        if(control1 == 1'b0 && control2 == 1'b1)begin
            out <= B;
        end
        if(control1 == 1'b1 && control2 == 1'b0)begin
            out <= C;
        end
        if(control1 == 1'b1 && control2 == 1'b1)begin
            out <= D;
        end 
    end

endmodule
