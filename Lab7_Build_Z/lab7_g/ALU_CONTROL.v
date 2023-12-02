`timescale 1ns / 1ps

module ALU_CONTROL( input [5:0] func, 
                    input [4:0] ALU_Op, 
                    output reg [4:0] ALU_Op_Out
                    );

    always @* begin
        if (ALU_Op == 5'b11111) begin
            if(func == 6'b100000)begin
                ALU_Op_Out <= 5'b00000;
    
            end
    
            //sub
            else if(func == 6'b100010)begin
    
                ALU_Op_Out <= 5'b00001;
    
            end
            
            //and
            else if(func == 6'b100100)begin
    
                ALU_Op_Out <= 5'b00011;
    
            end
            
            //or
            else if(func == 6'b100101)begin
    
                ALU_Op_Out <= 5'b00100;
    
            end
            
            //nor
            else if(func == 6'b100111)begin
    
                ALU_Op_Out <= 5'b10000;
    
            end
            
            //xor
            else if(func == 6'b100110)begin
    
                ALU_Op_Out <= 5'b10001;
    
            end
            
            //sll
            else if(func == 6'b000000)begin
    
                ALU_Op_Out <= 5'b01010;
    
            end
            
            //srl 
            else if(func == 6'b000010)begin
    
                ALU_Op_Out <= 5'b01011;
                
            end
    
            //slt
            else if(func == 6'b101010)begin
    
                ALU_Op_Out <= 5'b00101;
    
            end
            else begin
                ALU_Op_Out <= ALU_Op;
            end
        end
        else begin
            ALU_Op_Out <= ALU_Op;
        end
    
    end


endmodule
