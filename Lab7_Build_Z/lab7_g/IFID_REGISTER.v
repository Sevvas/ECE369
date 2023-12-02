`timescale 1ns / 1ps

module IFID_REGISTER(    input Clk,
                        input Control,
                        input flush,
                        
                        input [31:0] PC_Add_In, 
                        input [31:0] Instruction_In,
                         
                        output reg [31:0] PC_Add_Out, 
                        output reg [31:0] Instruction_Out
                        );

    always @(posedge Clk)begin
        if(Control !== 1'b1)begin 
            PC_Add_Out <= PC_Add_In;
            Instruction_Out <= Instruction_In;

        end
        if(flush == 1'b1)begin
            PC_Add_Out <= 32'b0;
            Instruction_Out <= 32'b0;

        end
     end
endmodule
