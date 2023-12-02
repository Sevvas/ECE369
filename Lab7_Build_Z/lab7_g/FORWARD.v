`timescale 1ns / 1ps

module FORWARD( input EXMEM_Reg_Write,
                input MEMWB_Reg_Write, 
                input [4:0] EXMEM_Rd, 
                input [4:0] MEMWB_Rd, 
                input [4:0] IDEX_Rt, 
                input [4:0] IDEX_Rs, 
                output reg [1:0] F_Mux_A_Ctr, 
                output reg [1:0] F_Mux_B_Ctr
                );
    
    always @* begin
        F_Mux_A_Ctr <= 2'b0;
        F_Mux_B_Ctr <= 2'b0;
        
        if(EXMEM_Reg_Write && (EXMEM_Rd != 0) && (EXMEM_Rd == IDEX_Rs))begin
            F_Mux_A_Ctr <= 2'b01;
        end
        else if(MEMWB_Reg_Write && (MEMWB_Rd != 0) && (MEMWB_Rd == IDEX_Rs))begin
            F_Mux_A_Ctr <= 2'b10;
        end
        
        if(EXMEM_Reg_Write && (EXMEM_Rd != 0) && (EXMEM_Rd == IDEX_Rt))begin
            F_Mux_B_Ctr <= 2'b01;
        end
        else if(MEMWB_Reg_Write && (MEMWB_Rd != 0) && (MEMWB_Rd == IDEX_Rt))begin
            F_Mux_B_Ctr <= 2'b10;
        end  
    end
endmodule
