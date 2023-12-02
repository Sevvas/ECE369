`timescale 1ns / 1ps

module PROGRAM_COUNTER( input Clk,
                        input Reset,
                        input control,
                        input [31:0] Address, 
                        output reg [31:0] Result 
                        );

    always@(posedge Clk) begin
        if(Reset == 1)begin 
            Result = 32'h00000000;
        end
        else begin
            if(control !== 1'b1)begin 
                Result = Address; 
            end
        end
    end

endmodule
