`timescale 1ns / 1ps

module JUMP_ADDRESS(    input [25:0] Address,
                        input [31:0] ProgramCount,
                        output reg [31:0] out
                        );
                
    always @* begin
        out <= {ProgramCount[31:28], Address, 2'b0};
    end
endmodule
