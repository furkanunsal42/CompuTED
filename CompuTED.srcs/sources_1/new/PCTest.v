`timescale 1ns / 1ps


module PCTest();
    
    reg clk = 0, PCSrc;
    reg[31:0] PCBranch;
    wire[31:0] PC;
    PC dut(clk, PCSrc, PCBranch, PC);
    
    always begin
        #10
        clk = ~clk;
    end
    
    initial begin
        PCSrc = 0;
        
        #100
        PCSrc = 1;
        PCBranch = 32'd321321;
        #20
        PCSrc = 0;
        PCBranch = 32'd0;
        #100
        PCSrc = 0;
             
    end
endmodule
