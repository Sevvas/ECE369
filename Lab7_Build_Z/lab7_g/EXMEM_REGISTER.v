`timescale 1ns / 1ps

module EXMEM_REGISTER(  input           Clk,
                        input           flush,
                        input           Zero,
                        input           PC_Source, 
                        input           Reg_Write_Mux,
                        input           Reg_Write,
                        input           Branch, 
                        input           Mem_Write,
                        input           Mem_Read,
                        input [1:0]     Store_Control,
                        input [1:0]     Load_Control,
                        input [1:0]     Mem_To_Reg,
                        input [4:0]     Reg_Dst,
                        input [31:0]    Program_Count,
                        input [31:0]    Jump_Address,
                        input [31:0]    Branch_Address,
                        input [31:0]    ALU_MuxA,
                        input [31:0]    Forward_MuxB,
                        input [31:0]    ALU_Result,
                        output reg          Zero_Out,
                        output reg          Reg_Write_Out, 
                        output reg          Branch_Out,
                        output reg          Mem_Write_Out,
                        output reg          Mem_Read_Out,
                        output reg          PC_Source_Out,
                        output reg          Reg_Write_Mux_Out,
                        output reg [1:0]    Store_Control_Out,
                        output reg [1:0]    Load_Control_Out,
                        output reg [1:0]    Mem_To_Reg_Out,
                        output reg [4:0]    Reg_Dst_Out,
                        output reg [31:0]   PC_Out,
                        output reg [31:0]   Jump_Address_Out,
                        output reg [31:0]   Branch_Address_Out,
                        output reg [31:0]   ALU_MuxA_Out,
                        output reg [31:0]   Forward_MuxB_Out,
                        output reg [31:0]   ALU_Result_Out,
                        input [31:0] v0_1,
                        input [31:0] v1_1,
                        output reg [31:0] v0_2,
                        output reg [31:0] v1_2                        
                        );
    
    always @(posedge Clk)begin
        Zero_Out            <= Zero;
        Reg_Write_Out       <= Reg_Write;
        Branch_Out          <= Branch;
        Mem_Write_Out       <= Mem_Write;
        Mem_Read_Out        <= Mem_Read;
        PC_Source_Out       <= PC_Source;
        Reg_Write_Mux_Out   <= Reg_Write_Mux;
        Store_Control_Out   <= Store_Control;
        Load_Control_Out    <= Load_Control;
        Mem_To_Reg_Out      <= Mem_To_Reg;
        Reg_Dst_Out         <= Reg_Dst;
        PC_Out              <= Program_Count;
        Jump_Address_Out    <= Jump_Address;
        Branch_Address_Out  <= Branch_Address;
        ALU_MuxA_Out        <= ALU_MuxA;
        Forward_MuxB_Out    <= Forward_MuxB;
        ALU_Result_Out      <= ALU_Result;
        v0_2                   <= v0_1;
        v1_2                   <= v1_1;
        
        if(flush == 1'b1)begin
            Zero_Out            <= 0;
            Reg_Write_Out       <= 0;
            Branch_Out          <= 0;
            Mem_Write_Out       <= 0;
            Mem_Read_Out        <= 0;
            PC_Source_Out       <= 0;
            Reg_Write_Mux_Out   <= 0;
            Store_Control_Out   <= 0;
            Load_Control_Out    <= 0;
            Mem_To_Reg_Out      <= 0;
            Reg_Dst_Out         <= 0;
            PC_Out              <= 0;
            Jump_Address_Out    <= 0;
            Branch_Address_Out  <= 0;
            ALU_MuxA_Out        <= 0;
            Forward_MuxB_Out    <= 0;
            ALU_Result_Out      <= 0;
        
        end
    end
endmodule
