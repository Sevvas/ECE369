`timescale 1ns / 1ps

module Mux32Bit3to1(    input [31:0] A, 
                        input [31:0] B, 
                        input [31:0] C, 
                        output reg [31:0] out, 
                        input [1:0] control
                        );
    
    always @* begin
        out <= A;
        if(control == 2'b00)begin
            out <= A;
        end
        if(control == 2'b01)begin
            out <= B;
        end
        if(control == 2'b10)begin
            out <= C;
        end
    end
endmodule