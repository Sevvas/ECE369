`timescale 1ns / 1ps

module REGISTER_FILE(   input           Clk,
                        input           Reset,
                        input           Reg_Write,
                        input [4:0]     Read_Reg_1, 
                        input [4:0]     Read_Reg_2, 
                        input [4:0]     Write_Reg, 
                        input [31:0]    Write_Data, 

                        output reg [31:0] Read_Data_1, 
                        output reg [31:0] Read_Data_2,
                        output [31:0] v0,
                        output [31:0] v1
                        );
	
	reg [31:0] Reg_File [0:31];
	
    always @(posedge Clk) begin 
           if(Reset == 1) begin
            Reg_File[0]  <= 32'h0;   Reg_File[1]  <= 32'h0;   Reg_File[2]  <= 32'h0;   Reg_File[3]  <= 32'h0;   Reg_File[4]  <= 32'h0;   Reg_File[5]  <= 32'h0; 
            Reg_File[6]  <= 32'h0;   Reg_File[7]  <= 32'h0;   Reg_File[8]  <= 32'h0;   Reg_File[9]  <= 32'h0;   Reg_File[10] <= 32'h0;   Reg_File[11] <= 32'h0; 
            Reg_File[12] <= 32'h0;   Reg_File[13] <= 32'h0;   Reg_File[14] <= 32'h0;   Reg_File[15] <= 32'h0;   Reg_File[16] <= 32'h0;   Reg_File[17] <= 32'h0; 
            Reg_File[18] <= 32'h0;   Reg_File[19] <= 32'h0;   Reg_File[20] <= 32'h0;   Reg_File[21] <= 32'h0;   Reg_File[22] <= 32'h0;   Reg_File[23] <= 32'h0; 
            Reg_File[24] <= 32'h0;   Reg_File[25] <= 32'h0;   Reg_File[26] <= 32'h0;   Reg_File[27] <= 32'h0;   Reg_File[28] <= 32'h0;   Reg_File[29] <= 32'h0; 
            Reg_File[30] <= 32'h0;   Reg_File[31] <= 32'h0;
           end
           else begin
               if(Reg_Write == 1)begin
                   Reg_File[Write_Reg] <= Write_Data;
                   Reg_File[0] <= 32'h0;
               end
           end
           
    end
        
    always @(negedge Clk) begin 
        Read_Data_1 <= Reg_File[Read_Reg_1];
        Read_Data_2 <= Reg_File[Read_Reg_2];
    end
    assign v0 = Reg_File[2];
    assign v1 = Reg_File[3];
endmodule


