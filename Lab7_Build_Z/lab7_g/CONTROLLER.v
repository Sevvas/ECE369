`timescale 1ns / 1ps

module CONTROLLER(  input [31:0]    Instruction, 
                    input           control,
                    output reg          Reg_Write, 
                    output reg          ALU_MuxA, 
                    output reg          ALU_MuxB, 
                    output reg          Branch,
                    output reg          Mem_Write, 
                    output reg          Mem_Read,
                    output reg          PCSrc, 
                    output reg          Reg_Write_Mux,
                    output reg [1:0]    Reg_Dst, 
                    output reg [1:0]    Store_Control, 
                    output reg [1:0]    Load_Control,
                    output reg [1:0]    Mem_To_Reg,
                    output reg [4:0]    ALU_Op
                    );
    
    always @* begin
        Reg_Write    <= 1'b0;
        ALU_MuxA     <= 1'b0;
        ALU_MuxB     <= 1'b0;
        Branch      <= 1'b0;
        Mem_Write    <= 1'b0;
        Mem_Read     <= 1'b0;
        PCSrc       <= 1'b0;
        Reg_Write_Mux <= 1'b0;
        Reg_Dst      <= 2'b00;
        Mem_To_Reg    <= 2'b00;
        Load_Control    <= 2'b00;
        Store_Control    <= 2'b00;
        ALU_Op       <= 5'b00000;

        if(control == 1'b1)begin
        end
        else begin
            if(Instruction[31:26] == 6'b000000)begin
                ALU_Op       <= 5'b11111;

                //add
                if(Instruction[5:0] == 6'b100000)begin
                    //ALU_Op       <= 5'b00000;
                    Reg_Write    <= 1'b1;
                    Reg_Dst      <= 2'b01;
                    Mem_To_Reg    <= 2'b01;
                end

                //sub
                if(Instruction[5:0] == 6'b100010)begin
                    //ALU_Op       <= 5'b00001;
                    Reg_Write    <= 1'b1;
                    Reg_Dst      <= 2'b01;
                    Mem_To_Reg    <= 2'b01;
                end

                //j
                if(Instruction[5:0] == 6'b001000)begin
                    //ALU_Op       <= 5'b00000;
                    PCSrc       <= 1'b1;
                end
                
                //and
                if(Instruction[5:0] == 6'b100100)begin
                    //ALU_Op       <= 5'b00011;
                    Reg_Write    <= 1'b1;
                    Reg_Dst      <= 2'b01;
                    Mem_To_Reg    <= 2'b01;
                end
                
                //or
                if(Instruction[5:0] == 6'b100101)begin
                    //ALU_Op       <= 5'b00100;
                    Reg_Write    <= 1'b1;
                    Reg_Dst      <= 2'b01;
                    Mem_To_Reg    <= 2'b01;
                end
                
                //nor
                if(Instruction[5:0] == 6'b100111)begin
                    //ALU_Op       <= 5'b10000;
                    Reg_Write    <= 1'b1;
                    Reg_Dst      <= 2'b01;
                    Mem_To_Reg    <= 2'b01;
                end
                
                //xor
                if(Instruction[5:0] == 6'b100110)begin
                    //ALU_Op       <= 5'b10001;
                    Reg_Write    <= 1'b1;
                    Reg_Dst      <= 2'b01;
                    Mem_To_Reg    <= 2'b01;
                end
                
                //sll
                if(Instruction[5:0] == 6'b000000)begin
                    //ALU_Op       <= 5'b01010;
                    Reg_Write    <= 1'b1;
                    ALU_MuxA     <= 1'b1;
                    Reg_Dst      <= 2'b01;
                    Mem_To_Reg    <= 2'b01;
                end
                
                //srl
                if(Instruction[5:0] == 6'b000010)begin
                    //ALU_Op       <= 5'b01011;
                    Reg_Write    <= 1'b1;
                    ALU_MuxA     <= 1'b1;
                    Reg_Dst      <= 2'b01;
                    Mem_To_Reg    <= 2'b01;
                end

                //slt
                if(Instruction[5:0] == 6'b101010)begin
                    //ALU_Op       <= 5'b00101;
                    Reg_Write    <= 1'b1;
                    Reg_Dst      <= 2'b01;
                    Mem_To_Reg    <= 2'b01;
                end

            end
            
            if(Instruction[31:26] == 6'b011100)begin
            
                //mul
                if(Instruction[5:0] == 6'b000010)begin
                    ALU_Op       <= 5'b00010;
                    Reg_Write    <= 1'b1;
                    Reg_Dst      <= 2'b01;
                    Mem_To_Reg    <= 2'b01;
                end
                
            end

            //addi
            if(Instruction[31:26] == 6'b001000)begin
                ALU_Op       <= 5'b00000;
                Reg_Write    <= 1'b1; 
                ALU_MuxB     <= 1'b1; 
                Mem_To_Reg    <= 2'b01;
            end
            
            //andi
            if(Instruction[31:26] == 6'b001100)begin
                ALU_Op       <= 5'b00011; 
                Reg_Write    <= 1'b1; 
                ALU_MuxB     <= 1'b1; 
                Mem_To_Reg    <= 2'b01; 
            end
            
            //ori
            if(Instruction[31:26] == 6'b001101)begin
                ALU_Op       <= 5'b00100;
                Reg_Write    <= 1'b1; 
                ALU_MuxB     <= 1'b1; 
                Mem_To_Reg    <= 2'b01; 
            end
            
            //xori
            if(Instruction[31:26] == 6'b001110)begin
                ALU_Op       <= 5'b10001;
                Reg_Write    <= 1'b1; 
                ALU_MuxB     <= 1'b1; 
                Mem_To_Reg    <= 2'b01; 
            end
            
            //slti
            if(Instruction[31:26] == 6'b001010)begin
                ALU_Op       <= 5'b00101;
                Reg_Write    <= 1'b1; 
                ALU_MuxB     <= 1'b1;  
                Mem_To_Reg    <= 2'b01;
            end

            //sb
            if(Instruction[31:26] == 6'b101000)begin
                ALU_Op       <= 5'b00000;
                ALU_MuxB     <= 1'b1; 
                Mem_Write    <= 1'b1; 
                Store_Control    <= 2'b10;
            end

            //sh
            if(Instruction[31:26] == 6'b101001)begin
                ALU_Op       <= 5'b00000;
                ALU_MuxB     <= 1'b1; 
                Mem_Write    <= 1'b1; 
                Store_Control    <= 2'b11;
            end

            //sw
            if(Instruction[31:26] == 6'b101011)begin
                ALU_Op       <= 5'b00000;
                ALU_MuxB     <= 1'b1; 
                Mem_Write    <= 1'b1; 
                Store_Control    <= 2'b00;
            end

            //lb
            if(Instruction[31:26] == 6'b100000)begin
                ALU_Op       <= 5'b00000;
                Reg_Write    <= 1'b1; 
                ALU_MuxB     <= 1'b1; 
                Mem_Read     <= 1'b1; 
                Load_Control    <= 2'b10;
            end

            //lh
            if(Instruction[31:26] == 6'b100001)begin
                ALU_Op       <= 5'b00000;
                Reg_Write    <= 1'b1; 
                ALU_MuxB     <= 1'b1; 
                Mem_Read     <= 1'b1; 
                Load_Control    <= 2'b11;
            end

            //lw
            if(Instruction[31:26] == 6'b100011)begin
                ALU_Op       <= 5'b00000;
                Reg_Write    <= 1'b1; 
                ALU_MuxB     <= 1'b1; 
                Mem_Read     <= 1'b1;
            end

            //beq
            if(Instruction[31:26] == 6'b000100)begin
                ALU_Op   <= 5'b00001; 
                Branch  <= 1'b1; 
            end
            
            //bne
            if(Instruction[31:26] == 6'b000101)begin
                ALU_Op   <= 5'b00111; 
                Branch  <= 1'b1; 
            end

            //bgez, bltz
            if(Instruction[31:26] == 6'b000001)begin
                Branch  <= 1'b1; 
                if(Instruction[20:16] == 5'b00001)begin
                    ALU_Op   <= 5'b01100;
                end
                if(Instruction[20:16] == 5'b00000)begin
                    ALU_Op   <= 5'b01111;
                end
            end

            //bgtz
            if(Instruction[31:26] == 6'b000111)begin
                ALU_Op   <= 5'b01101; 
                Branch  <= 1'b1; 
            end
            
            //blez
            if(Instruction[31:26] == 6'b000110)begin
                ALU_Op   <= 5'b01110; 
                Branch  <= 1'b1; 
            end
            
            //j
            if(Instruction[31:26] == 6'b000010)begin
                ALU_Op   <= 5'b10110; 
                Branch  <= 1'b1; 
                PCSrc   <= 1'b1;
            end
            
            //jal
            if(Instruction[31:26] == 6'b000011)begin
                ALU_Op       <= 5'b10110;
                Reg_Write    <= 1'b1; 
                Branch       <= 1'b1; 
                PCSrc        <= 1'b1;
                Reg_Dst      <= 2'b10; 
                Mem_To_Reg   <= 2'b10; 
                 
            end

        end
    end
endmodule

