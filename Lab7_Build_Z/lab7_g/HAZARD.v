`timescale 1ns / 1ps

module HAZARD(  input IDEX_Mem_Read,
                input IDEX_Reg_Write_Mux, 
                input [4:0] Instruction_25_21, 
                input [4:0] Instruction_20_16, 
                input [4:0] IDEX_Rt, 
                input [4:0] IDEX_Rd,
                output reg Controller_Ctrl, 
                output reg IFID_Write, 
                output reg PC_Write 
                );
    
    always @* begin
        Controller_Ctrl <= 1'b0; 
        IFID_Write <= 1'b0; 
        PC_Write <= 1'b0; 
       
        if(IDEX_Mem_Read == 1'b1)begin
            if((IDEX_Rt == Instruction_25_21) || (IDEX_Rt == Instruction_20_16))begin
                Controller_Ctrl <= 1'b1; 
                IFID_Write <= 1'b1; 
                PC_Write <= 1'b1;
            end 
        end
        
        if(IDEX_Reg_Write_Mux == 1'b1)begin
            if((IDEX_Rd == Instruction_25_21) || (IDEX_Rd == Instruction_20_16))begin
                Controller_Ctrl <= 1'b1; 
                IFID_Write <= 1'b1; 
                PC_Write <= 1'b1;
            end  
        end
    end
endmodule