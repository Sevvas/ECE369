`timescale 1ns / 1ps

module PCADDER( input [31:0] inp_res, 
                output reg [31:0] Result
                );

    always @ (inp_res)begin
        Result <= inp_res + 3'b100;
    end

endmodule