`timescale 1ns / 1ps

module TopLevel_tb();

    reg Clk;
    reg Reset;
    wire [31:0] Output;

    Datapath Toplevel_tb(.Clk(Clk), 
                        .Reset(Reset),
                        .Output(Output));

    initial begin
        Clk <= 1'b0;
        forever #10 Clk <= ~Clk;  // Adjust the time here to change the clock frequency
    end

    always @(posedge Clk or negedge Clk) begin
        $display("Time: %t, CLK: %b", $time, Clk);  // Added to print the clock value
    end

    initial begin 
        Reset <= 1'b1;
        #10;
        Reset <= 1'b0;
        Reset <= 1'b1;
        #10;
        Reset <= 1'b0;

        #20;
    end
endmodule