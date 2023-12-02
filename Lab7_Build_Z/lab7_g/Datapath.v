`timescale 1ns / 1ps
//Kai: 33
//Sebastian: 33
//Caleb: 33

module Datapath(Clk, Reset, out7, en_out);
    input Clk, Reset;
    output [6:0] out7; 
    output [7:0] en_out;
    //output Output;
    wire [31:0] Output;
    wire Clkout;
    
    wire [31:0] ProgramCounterC_Src_Mux_Out; 
    wire [31:0] ProgramCounter_Out; 
    wire [31:0] Instruction_Memory_Out; 
    wire [31:0] ProgramCounter_Adder_Out; 
    
    wire [31:0] IFID_ProgramCount; 
    wire [31:0] IFID_Instruction;
    
    wire [31:0] Read_Data_1; 
    wire [31:0] Read_Data_2;
    
    wire [31:0] Sign_Extension_Out; 
    wire [31:0] Reg_Write_Mux_Out;
     
    wire        Controller_Reg_Write; 
    wire        Controller_ALUMuxA_Src; 
    wire        Controller_ALUMuxB_Src; 
    wire        Controller_Branch; 
    wire        Controller_Mem_Write; 
    wire        Controller_Mem_Read; 
    wire        Controller_ProgramCounter_Src; 
    wire        Controller_Reg_Write_Mux_Src;
    wire [4:0]  Controller_ALU_Op;
    wire [1:0]  Controller_Store_Control; 
    wire [1:0]  Controller_Load_Control; 
    wire [1:0]  Controller_Mem_To_Reg; 
    wire [1:0]  Controller_Reg_Dst;
    wire [4:0]  MEMWB_Reg_Dst;

    wire [31:0] IDEX_ProgramCount; 
    wire [31:0] IDEX_Read_Data_1_out; 
    wire [31:0] IDEX_Read_Data_2_out; 
    wire [31:0] IDEX_Sign_Extension_Out;
    wire        IDEX_Reg_Write; 
    wire        IDEX_ALUMuxA_Control; 
    wire        IDEX_ALUMuxB_Control; 
    wire        IDEX_Branch_Control; 
    wire        IDEX_Mem_Write_Control; 
    wire        IDEX_Mem_Read_Control; 
    wire        IDEX_ProgramCounter_Src; 
    wire        IDEX_Reg_Write_Mux_Control; 
    wire [4:0]  IDEX_ALU_Op_Code; 
    wire [4:0]  IDEX_Rt_Reg; 
    wire [4:0]  IDEX_Rd_Reg; 
    wire [4:0]  IDEX_Shamt;
    wire [1:0]  IDEX_Reg_Dst_Control; 
    wire [1:0]  IDEX_Store_Control; 
    wire [1:0]  IDEX_Load_Control; 
    wire [1:0]  IDEX_Mem_To_Reg_Control;
    wire [25:0] IDEX_Instruction_25_0;
    wire [31:0] ALUMuxA_Out; 
    wire [31:0] ALUMuxB_Out; 
    wire [31:0] RegDst_Mux_Out;
    
    wire [31:0] ProgramCount_4;
    
    wire [31:0] ALU_Result; 
    wire        ALU_Zero;
    
    wire [31:0] Sign_Extension_Shift_L2; 
    
    wire [31:0] Branch_Address; 
    
    wire [31:0] Jump_Address;

    wire [31:0] EXMEM_Jump_Address; 
    wire [31:0] EXMEM_ProgramCount; 
    wire [31:0] EXMEM_Branch_Address; 
    wire [31:0] EXMEM_ALUMuxA; 
    wire [31:0] EXMEM_ALU_Result; 
    wire [31:0] EXMEM_ForwardMuxB;
    wire        EXMEM_ALU_Zero; 
    wire        EXMEM_Reg_Write;
    wire        EXMEM_Branch_Control; 
    wire        EXMEM_Mem_Write_Control; 
    wire        EXMEM_Mem_Read_Control; 
    wire        EXMEM_ProgamCounter_Mux_Src;
    wire        EXMEM_Reg_Write_Mux_Control;
    wire [4:0] EXMEM_Reg_Dst_Result;
    wire [1:0] EXMEM_Mem_To_Reg_Control; 
    wire [1:0] EXMEM_Store_Control; 
    wire [1:0] EXMEM_Load_Control;
    
    wire [31:0] DataMemory_Out;
   
    wire [31:0] MEMWB_ProgramCount; 
    wire [31:0] MEMWB_DataMemory_Out; 
    wire [31:0] MEMWB_ALU_Result;
    wire [1:0]  MEMWB_Mem_To_Reg_Control;
    wire        MEMWB_ALU_Zero;
    wire        MEMWB_Reg_Write_Mux; 
    wire        MEMWB_Reg_Write_Control;

    wire [31:0] ForwardMuxA_Out; 
    wire [31:0] ForwardMuxB_Out;
    
    wire [1:0]  Forward_MuxA_Control; 
    wire [1:0]  Forward_MuxB_Control;
    
    wire        ProgramCount_Write_Control; 
    wire        IFID_Write; 
    wire        Controller_Control;
    
    wire        WB_Forward_MuxA_Control; 
    wire        WB_Forward_MuxB_Control;
    
    wire [31:0] WB_Forward_A_Out; 
    wire [31:0] WB_Forward_B_Out;
    
    wire [4:0] ALU_CTR_OP;
    
    wire Branch_Out;
    
    wire [31:0] v0_wire1;
    wire [31:0] v1_wire1;
    
    wire [31:0] v0_wire2;
    wire [31:0] v1_wire2;
    
    wire [31:0] v0_wire3;
    wire [31:0] v1_wire3;
    
    wire [31:0] v0_wire4;
    wire [31:0] v1_wire4;
    
    wire [31:0] v0_wire5;
    wire [31:0] v1_wire5;
    
    PROGRAM_COUNTER program_counter(    Clkout,
                                        Reset,
                                        ProgramCount_Write_Control,
                                        ProgramCounterC_Src_Mux_Out, 
                                        ProgramCounter_Out
                                        );
    
    INSTRUCTION_MEMORY instruction_memory(  ProgramCounter_Out, 
                                            Instruction_Memory_Out
                                            );
    
    PCADDER pc_adder(   ProgramCounter_Out, 
                        ProgramCounter_Adder_Out
                        );
    
    IFID_REGISTER ifid_register(    Clkout,
                                    IFID_Write,
                                    (EXMEM_ProgamCounter_Mux_Src | Branch_Out),
                                    ProgramCounter_Adder_Out, 
                                    Instruction_Memory_Out, 
                                    IFID_ProgramCount, 
                                    IFID_Instruction 
                                    );
    

    SIGN_EXTENSION sign_extension(  IFID_Instruction[15:0], 
                                    Sign_Extension_Out 
                                    );
    
    REGISTER_FILE register_file(    Clkout,
                                    Reset,
                                    Reg_Write_Mux_Out[0], 
                                    IFID_Instruction[25:21], 
                                    IFID_Instruction[20:16], 
                                    MEMWB_Reg_Dst, 
                                    Output, 
                                    Read_Data_1, 
                                    Read_Data_2,
                                    v0_wire1,
                                    v1_wire1
                                    );
    
    CONTROLLER controller(  IFID_Instruction, 
                            Controller_Control,
                            Controller_Reg_Write, 
                            Controller_ALUMuxA_Src, 
                            Controller_ALUMuxB_Src,
                            Controller_Branch, 
                            Controller_Mem_Write, 
                            Controller_Mem_Read,
                            Controller_ProgramCounter_Src, 
                            Controller_Reg_Write_Mux_Src,
                            Controller_Reg_Dst, 
                            Controller_Store_Control, 
                            Controller_Load_Control, 
                            Controller_Mem_To_Reg,
                            Controller_ALU_Op                     
                            );
    

     IDEX_REGISTER idex_resister(Clkout,
                                (EXMEM_ProgamCounter_Mux_Src | Branch_Out),
                                Controller_Reg_Write,
                                Controller_ALUMuxA_Src,
                                Controller_ALUMuxB_Src,
                                Controller_Branch,
                                Controller_Mem_Write,
                                Controller_Mem_Read,
                                Controller_ProgramCounter_Src,
                                Controller_Reg_Write_Mux_Src,
                                Controller_Reg_Dst,
                                Controller_Mem_To_Reg,
                                Controller_Store_Control,
                                Controller_Load_Control,
                                Controller_ALU_Op,
                                IFID_Instruction[20:16],
                                IFID_Instruction[15:11],
                                IFID_Instruction[10:6],
                                IFID_Instruction[25:0],
                                IFID_ProgramCount,
                                WB_Forward_A_Out,
                                WB_Forward_B_Out,
                                Sign_Extension_Out,
                                IDEX_Reg_Write,
                                IDEX_ALUMuxA_Control,
                                IDEX_ALUMuxB_Control,
                                IDEX_Branch_Control,
                                IDEX_Mem_Write_Control,
                                IDEX_Mem_Read_Control,
                                IDEX_ProgramCounter_Src,
                                IDEX_Reg_Write_Mux_Control,
                                IDEX_Reg_Dst_Control,
                                IDEX_Mem_To_Reg_Control,
                                IDEX_Store_Control,
                                IDEX_Load_Control,
                                IDEX_ALU_Op_Code,
                                IDEX_Rt_Reg,
                                IDEX_Rd_Reg,
                                IDEX_Shamt,
                                IDEX_Instruction_25_0,
                                IDEX_ProgramCount,
                                IDEX_Read_Data_1_out,
                                IDEX_Read_Data_2_out,
                                IDEX_Sign_Extension_Out,
                                v0_wire1,
                                v1_wire1,
                                v0_wire2,
                                v1_wire2     
                                );
    
    Mux32Bit2to1 alu_mux_A( ForwardMuxA_Out, 
                            {27'b0, IDEX_Shamt}, 
                            ALUMuxA_Out, 
                            IDEX_ALUMuxA_Control
                            );
    
    Mux32Bit2to1 alu_mux_B( ForwardMuxB_Out, 
                            IDEX_Sign_Extension_Out, 
                            ALUMuxB_Out, 
                            IDEX_ALUMuxB_Control
                            );
    
    Mux32Bit3to1 reg_dst_mux(   {27'b0, IDEX_Rt_Reg},
                                {27'b0, IDEX_Rd_Reg}, 
                                32'd31, 
                                RegDst_Mux_Out, 
                                IDEX_Reg_Dst_Control
                                );
    
    ALU32 alu32(    ALU_CTR_OP, 
                    ALUMuxA_Out, 
                    ALUMuxB_Out, 
                    ALU_Result,       
                    ALU_Zero
                    );
                 
    ALU_CONTROL alu_control(IDEX_Sign_Extension_Out[5:0],
                            IDEX_ALU_Op_Code,
                            ALU_CTR_OP
                            );

    SHIFT_LEFT_2 shift_left_2(  IDEX_Sign_Extension_Out, 
                                Sign_Extension_Shift_L2
                                );
    
    ADDER adder(IDEX_ProgramCount, 
                Sign_Extension_Shift_L2, 
                Branch_Address
                );
    
    JUMP_ADDRESS jump_address(  IDEX_Instruction_25_0, 
                                IDEX_ProgramCount, 
                                Jump_Address
                                );
    
    PCADDER pc_adder_2( IDEX_ProgramCount, 
                        ProgramCount_4
                        );
    
    EXMEM_REGISTER exmem_register(  Clkout,
                                    (EXMEM_ProgamCounter_Mux_Src | Branch_Out),
                                    ALU_Zero,
                                    IDEX_ProgramCounter_Src,
                                    IDEX_Reg_Write_Mux_Control,
                                    IDEX_Reg_Write,
                                    IDEX_Branch_Control,
                                    IDEX_Mem_Write_Control,
                                    IDEX_Mem_Read_Control,
                                    IDEX_Store_Control,
                                    IDEX_Load_Control,
                                    IDEX_Mem_To_Reg_Control,
                                    RegDst_Mux_Out[4:0],
                                    ProgramCount_4,
                                    Jump_Address,
                                    Branch_Address,
                                    ALUMuxA_Out,
                                    ForwardMuxB_Out,
                                    ALU_Result,
                                    EXMEM_ALU_Zero,
                                    EXMEM_Reg_Write,
                                    EXMEM_Branch_Control,
                                    EXMEM_Mem_Write_Control,
                                    EXMEM_Mem_Read_Control,
                                    EXMEM_ProgamCounter_Mux_Src,
                                    EXMEM_Reg_Write_Mux_Control,
                                    EXMEM_Store_Control,
                                    EXMEM_Load_Control,
                                    EXMEM_Mem_To_Reg_Control,
                                    EXMEM_Reg_Dst_Result,
                                    EXMEM_ProgramCount,
                                    EXMEM_Jump_Address,
                                    EXMEM_Branch_Address,
                                    EXMEM_ALUMuxA,
                                    EXMEM_ForwardMuxB,
                                    EXMEM_ALU_Result,
                                    v0_wire2,
                                    v1_wire2,
                                    v0_wire3,
                                    v1_wire3
                                    );
    
    BRANCH branch(  EXMEM_Branch_Control,
                    EXMEM_ALU_Zero,
                    Branch_Out
                    );
    
    
    DATA_MEMORY data_memory( Clkout, 
                            EXMEM_Mem_Write_Control, 
                            EXMEM_Mem_Read_Control,
                            EXMEM_Store_Control, 
                            EXMEM_Load_Control,
                            EXMEM_ALU_Result, 
                            EXMEM_ForwardMuxB, 
                            DataMemory_Out 
                            );
    
    Mux32Bit4to1 pc_src_mux(    ProgramCounter_Adder_Out, 
                                EXMEM_Branch_Address, 
                                EXMEM_ALUMuxA, 
                                EXMEM_Jump_Address, 
                                ProgramCounterC_Src_Mux_Out, 
                                EXMEM_ProgamCounter_Mux_Src, 
                                Branch_Out
                                );
    

    MEMWB_REGISTER memwb_register(   Clkout,
                                    EXMEM_ALU_Zero,
                                    EXMEM_Reg_Write_Mux_Control,
                                    EXMEM_Reg_Write,
                                    EXMEM_Mem_To_Reg_Control,
                                    EXMEM_Reg_Dst_Result,
                                    EXMEM_ProgramCount,
                                    EXMEM_ALU_Result,
                                    DataMemory_Out,
                                    MEMWB_ALU_Zero,
                                    MEMWB_Reg_Write_Mux,
                                    MEMWB_Reg_Write_Control,
                                    MEMWB_Mem_To_Reg_Control,
                                    MEMWB_Reg_Dst,
                                    MEMWB_ProgramCount,
                                    MEMWB_ALU_Result,
                                    MEMWB_DataMemory_Out,
                                    v0_wire3,
                                    v1_wire3,
                                    v0_wire4,
                                    v1_wire4
                                    );
    

    Mux32Bit3to1 mem_to_reg_mux(    MEMWB_DataMemory_Out, 
                                    MEMWB_ALU_Result, 
                                    MEMWB_ProgramCount, 
                                    Output, 
                                    MEMWB_Mem_To_Reg_Control
                                    );
    
    Mux32Bit2to1 reg_write_mux( {31'b0, MEMWB_Reg_Write_Control}, 
                                {31'b0, MEMWB_ALU_Zero}, 
                                Reg_Write_Mux_Out, 
                                MEMWB_Reg_Write_Mux
                                );
    

    FORWARD forward(    EXMEM_Reg_Write, 
                        Reg_Write_Mux_Out[0],
                        EXMEM_Reg_Dst_Result, 
                        MEMWB_Reg_Dst, 
                        IDEX_Rt_Reg, 
                        IDEX_Instruction_25_0[25:21], 
                        Forward_MuxA_Control, 
                        Forward_MuxB_Control
                        );
    
    Mux32Bit3to1 forward_mux_A( IDEX_Read_Data_1_out, 
                                EXMEM_ALU_Result, 
                                Output, 
                                ForwardMuxA_Out, 
                                Forward_MuxA_Control
                                );
    
    Mux32Bit3to1 forward_mux_B( IDEX_Read_Data_2_out, 
                                EXMEM_ALU_Result, 
                                Output, 
                                ForwardMuxB_Out, 
                                Forward_MuxB_Control
                                );
    
    HAZARD hazard(  IDEX_Mem_Read_Control, 
                    IDEX_Reg_Write_Mux_Control,
                    IFID_Instruction[25:21], 
                    IFID_Instruction[20:16], 
                    IDEX_Rt_Reg, 
                    IDEX_Rd_Reg,
                    Controller_Control, 
                    IFID_Write, 
                    ProgramCount_Write_Control 
                    );
    
    WB_FORWARD forward_unit_wb( Reg_Write_Mux_Out[0], 
                                MEMWB_Reg_Dst, 
                                IFID_Instruction[25:21], 
                                IFID_Instruction[20:16], 
                                WB_Forward_MuxA_Control, 
                                WB_Forward_MuxB_Control
                                );
    
    Mux32Bit2to1 forward_wb_mux_A(  Read_Data_1, 
                                    Output, 
                                    WB_Forward_A_Out, 
                                    WB_Forward_MuxA_Control
                                    );
    
    Mux32Bit2to1 forward_wb_mux_B(  Read_Data_2, 
                                    Output, 
                                    WB_Forward_B_Out, 
                                    WB_Forward_MuxB_Control
                                    );
    
    Two4DigitDisplay t4dd(  Clk, 
                            v0_wire4[15:0], 
                            v1_wire4[15:0], 
                            out7, 
                            en_out
                            );
    
    ClkDiv c_div(   Clk, 
                    1'b0, 
                    Clkout
                    );
endmodule
