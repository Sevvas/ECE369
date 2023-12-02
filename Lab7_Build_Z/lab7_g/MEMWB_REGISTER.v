`timescale 1ns / 1ps

module MEMWB_REGISTER(  input           Clk,
                        input           Zero,
                        input           Reg_Write_Mux,
                        input           Reg_Write,
                        input [1:0]     Mem_To_Reg,
                        input [4:0]     Reg_Dst,
                        input [31:0]    Program_Count,
                        input [31:0]    ALU_Result,
                        input [31:0]    Data_Mem_Res,
                        output reg          Zero_Out,
                        output reg          Reg_Write_Mux_Out,
                        output reg          Reg_Write_Out,
                        output reg [1:0]    Mem_To_Reg_Out,
                        output reg [4:0]    Reg_Dst_Out,
                        output reg [31:0]   Program_Count_Out,
                        output reg [31:0]   ALU_Result_Out,
                        output reg [31:0]   Data_Mem_Res_Out,
                        input [31:0] v0_1,
                        input [31:0] v1_1,
                        output reg [31:0] v0_2,
                        output reg [31:0] v1_2
                        );

    always @(posedge Clk)begin
        Zero_Out            <= Zero;
        Reg_Write_Mux_Out   <= Reg_Write_Mux;
        Reg_Write_Out       <= Reg_Write;
        Mem_To_Reg_Out      <= Mem_To_Reg;
        Reg_Dst_Out         <= Reg_Dst;
        Program_Count_Out   <= Program_Count;
        ALU_Result_Out      <= ALU_Result;
        Data_Mem_Res_Out    <= Data_Mem_Res;
         v0_2                   <= v0_1;
         v1_2                   <= v1_1;

    end
endmodule
