`timescale 1ns / 1ps

module ALU32(   input [4:0] Op_Code, 
                input [31:0] A, 
                input [31:0] B, 
                output reg [31:0] ALU_Result, 
                output reg Zero
                );	    
    
    always@* begin

        ALU_Result = 32'b0;
        case(Op_Code)
            5'b00000: ALU_Result = $signed(A) + $signed(B);         // add, addi, lw, sw, sb, lh, lb, sh
            5'b00001: ALU_Result = $signed(A) - $signed(B);         // beq, sub
            5'b00010: ALU_Result = $signed(A) * $signed(B);         // mul
            5'b00011: ALU_Result = $signed(A) & $signed(B);         //and 
            5'b00100: ALU_Result = $signed(A) | $signed(B);         //or, ori
            5'b00101: ALU_Result = ($signed(A) < $signed(B));       //slt, slti

            5'b00111: ALU_Result = $signed(A) == $signed(B);        //bne

            5'b01010: ALU_Result = B << {27'b0, A[4:0]};            //sll
            5'b01011: ALU_Result = B >> {27'b0, A[4:0]};            //srl
            5'b01100: ALU_Result = $signed(A) < 0;                  // bgez
            5'b01101: ALU_Result = $signed(A) <= 0;                 // bgtz
            5'b01110: ALU_Result = $signed(A) > 0;                  // blez
            5'b01111: ALU_Result = $signed(A) >= 0;                 // bltz
            5'b10000: ALU_Result = ~($signed(A) | $signed(B));      // nor
            5'b10001: ALU_Result = $signed(A) ^ $signed(B);         // xor

            5'b10110: ALU_Result = 32'b0;                           //j, JAL

        endcase
    end
    
    always@(*)begin
        if(ALU_Result == 0)begin
            Zero = 1'b1;
        end
        else begin
            Zero = 1'b0;
        end

    end
endmodule