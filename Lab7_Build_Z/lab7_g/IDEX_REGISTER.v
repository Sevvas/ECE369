`timescale 1ns / 1ps

module IDEX_REGISTER(   input Clk,
                        input flush,
                        input Reg_Write,
                        input ALU_MuxA,
                        input ALU_MuxB,
                        input Branch,
                        input Mem_Write, 
                        input Mem_Read,
                        input PC_Source,
                        input Reg_Write_Mux,
                        input [1:0] Reg_Dst,
                        input [1:0] Mem_To_Reg,
                        input [1:0] Store_Control,
                        input [1:0] Load_Control,
                        input [4:0] ALU_Op,
                        input [4:0] Instruction_20_16,
                        input [4:0] Instruction_15_11,
                        input [4:0] shamt,
                        input [25:0] Instruction_25_0,
                        input [31:0] PC_Add, 
                        input [31:0] Read_Data_1,
                        input [31:0] Read_Data_2,
                        input [31:0] Sign_Extension,
                        output reg Reg_Write_Out,
                        output reg ALU_MuxA_Out,
                        output reg ALU_MuxB_Out,
                        output reg Branch_Out, 
                        output reg Mem_Write_Out,
                        output reg Mem_Read_Out,
                        output reg PC_Source_Out,
                        output reg Reg_Write_Mux_Out,
                        output reg [1:0] Reg_Dst_Out, 
                        output reg [1:0] Mem_To_Reg_Out,
                        output reg [1:0] Store_Control_Out,
                        output reg [1:0] Load_Control_Out,
                        output reg [4:0] ALU_Op_Out,
                        output reg [4:0] Instruction_20_16_Out,
                        output reg [4:0] Instruction_15_11_Out,
                        output reg [4:0] shamt_Out,
                        output reg [25:0] Instruction_25_0_Out, 
                        output reg [31:0] PC_Add_Out,
                        output reg [31:0] Read_Data_1_Out,
                        output reg [31:0] Read_Data_2_Out,
                        output reg [31:0] Sign_Extension_Out,
                        input [31:0] v0_1,
                        input [31:0] v1_1,
                        output reg [31:0] v0_2,
                        output reg [31:0] v1_2
                        );


always @(posedge Clk)begin

    Reg_Write_Out           <= Reg_Write;
    ALU_MuxA_Out            <= ALU_MuxA;
    ALU_MuxB_Out            <= ALU_MuxB;
    Branch_Out              <= Branch;
    Mem_Write_Out           <= Mem_Write;
    Mem_Read_Out            <= Mem_Read;
    PC_Source_Out           <= PC_Source;
    //Reg_Write_Mux_Out       <= Reg_Write_Mux;
    Reg_Dst_Out             <= Reg_Dst;
    Mem_To_Reg_Out          <= Mem_To_Reg;
    Store_Control_Out       <= Store_Control;
    Load_Control_Out        <= Load_Control;
    ALU_Op_Out              <= ALU_Op;
    Instruction_20_16_Out   <= Instruction_20_16;
    Instruction_15_11_Out   <= Instruction_15_11;
    shamt_Out               <= shamt;
    Instruction_25_0_Out    <= Instruction_25_0;
    PC_Add_Out              <= PC_Add;
    Read_Data_1_Out         <= Read_Data_1;
    Read_Data_2_Out         <= Read_Data_2;
    Sign_Extension_Out      <= Sign_Extension;
     v0_2                   <= v0_1;
     v1_2                   <= v1_1;
    
    
    
    if(flush == 1'b1)begin
        Reg_Write_Out           <= 0;
        ALU_MuxA_Out            <= 0;
        ALU_MuxB_Out            <= 0;
        Branch_Out              <= 0;
        Mem_Write_Out           <= 0;
        Mem_Read_Out            <= 0;
        PC_Source_Out           <= 0;
        //Reg_Write_Mux_Out       <= 0;
        Reg_Dst_Out             <= 0;
        Mem_To_Reg_Out          <= 0;
        Store_Control_Out       <= 0;
        Load_Control_Out        <= 0;
        ALU_Op_Out              <= 0;
        Instruction_20_16_Out   <= 0;
        Instruction_15_11_Out   <= 0;
        shamt_Out               <= 0;
        Instruction_25_0_Out    <= 0;
        PC_Add_Out              <= 0;
        Read_Data_1_Out         <= 0;
        Read_Data_2_Out         <= 0;
        Sign_Extension_Out      <= 0;

    end 
end

endmodule