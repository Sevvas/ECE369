`timescale 1ns / 1ps

module INSTRUCTION_MEMORY(  input [31:0] Address, 
                            output reg [31:0] Instruction
                            ); 
    
    reg [31:0] memory [0:1023];
    integer Index;
    
    initial begin
        $readmemh("instruction_memory.mem", memory);
    end
    
    always @* begin
        Instruction <= memory[Address[12:2]];
    end
    
endmodule
