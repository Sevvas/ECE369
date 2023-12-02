`timescale 1ns / 1ps

module DATA_MEMORY(  input Clk,
                    input Mem_Write,		
                    input Mem_Read,
                    input [1:0] Store_Control, 
                    input [1:0] Load_Control,
                    input [31:0] Address,
                    input [31:0] Write_Data,		
                    output reg[31:0] Read_Data	
                    ); 
    
    reg [31:0] memory_d [4095:0];
    integer Index;
    (*keep = "true"*)reg [31:0] mem;
    initial begin
        $readmemh("data_memory.mem", memory_d);
    end

	always @(posedge Clk) begin
        if (Mem_Write == 1'b1) begin
            mem = memory_d[Address[15:2]];
            if(Store_Control == 2'b10)begin //sb
                if(Address[1:0] == 2'b11)begin 
                    mem[7:0] = Write_Data[7:0];
                end
                if(Address[1:0] == 2'b10)begin
                    mem[15:8] = Write_Data[7:0];
                end
                if(Address[1:0] == 2'b01)begin
                    mem[23:16] = Write_Data[7:0];
                end
                if(Address[1:0] == 2'b00)begin
                    mem[31:24] = Write_Data[7:0];
                end
            end
            if(Store_Control == 2'b11)begin //sh
                if(Address[1:0] == 2'b01)begin
                    mem[15:0] = Write_Data[15:0];
                end
                if(Address[1:0] == 2'b00)begin
                    mem[31:16] = Write_Data[15:0];
                end
            end
            if(Store_Control == 2'b00)begin //sw
                mem = Write_Data;
            end
            memory_d[Address[15:2]] <= mem;
        end
    end    
    
    always @(*) begin
        if (Mem_Read == 1'b1) begin //lw
            Read_Data <= 32'b0;
            if(Load_Control == 2'b00)begin
                Read_Data <= memory_d[Address[15:2]];
            end
            if(Load_Control == 2'b10)begin //lb
                if(Address[1:0] == 2'b11)begin
                    if(memory_d[Address[15:2]][7] == 1'b1)begin
                        Read_Data <= {24'b111111111111111111111111, memory_d[Address[15:2]][7:0]};
                    end
                    else begin
                        Read_Data <= {24'b0, memory_d[Address[15:2]][7:0]};
                    end
                end
                if(Address[1:0] == 2'b10)begin
                    if(memory_d[Address[15:2]][15] == 1'b1)begin
                        Read_Data <= {24'b111111111111111111111111, memory_d[Address[15:2]][15:8]};
                    end
                    else begin
                        Read_Data <= {24'b0, memory_d[Address[15:2]][15:8]};
                    end
                end
                if(Address[1:0] == 2'b01)begin
                    if(memory_d[Address[15:2]][23] == 1'b1)begin
                        Read_Data <= {24'b111111111111111111111111, memory_d[Address[15:2]][23:16]};
                    end
                    else begin
                        Read_Data <= {24'b0, memory_d[Address[15:2]][23:16]};
                    end
                end
                if(Address[1:0] == 2'b00)begin
                    if(memory_d[Address[15:2]][31] == 1'b1)begin
                        Read_Data <= {24'b111111111111111111111111, memory_d[Address[15:2]][31:24]};
                    end
                    else begin
                        Read_Data <= {24'b0, memory_d[Address[15:2]][31:24]};
                    end
                end
            end
            
            if(Load_Control == 2'b11)begin //lh
                if(Address[1:0] == 2'b01)begin
                    if(memory_d[Address[15:2]][15] == 1'b1)begin
                        Read_Data <= {16'b1111111111111111, memory_d[Address[15:2]][15:0]};
                    end
                    else begin
                        Read_Data <= {16'b0, memory_d[Address[15:2]][15:0]};
                    end
                end
                if(Address[1:0] == 2'b00)begin
                if(memory_d[Address[15:2]][31] == 1'b1)begin
                        Read_Data <= {16'b1111111111111111, memory_d[Address[15:2]][31:16]};
                    end
                    else begin
                        Read_Data <= {16'b0, memory_d[Address[15:2]][31:16]};
                    end
                end
            end
        end
        else
            Read_Data <= 32'h0;    
    end    
endmodule
