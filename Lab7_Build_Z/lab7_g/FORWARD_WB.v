`timescale 1ns / 1ps

module WB_FORWARD(      input Reg_Write, 
                        input [4:0] reg_Dst, 
                        input [4:0] Rs, 
                        input [4:0] Rt, 
                        output reg control_1, 
                        output reg control_2
                        );
    
    always @* begin
        control_1 <= 1'b0; 
        control_2 <= 1'b0;
        if(Reg_Write == 1'b1)begin
            if(reg_Dst == Rs)begin
                control_1 <= 1'b1;
            end
            if(reg_Dst == Rt)begin
                control_2 <= 1'b1;
            end
        end
    end
endmodule
