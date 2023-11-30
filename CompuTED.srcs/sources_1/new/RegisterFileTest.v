`timescale 1ns / 1ps

module RegisterFileTest();
        
    wire[31:0] RD1, RD2;
    reg[31:0] A1, A2, A3, WD3;
    reg clk = 0, WE3; 

    RegisterFile dut(RD1, RD2,A1, A2, A3, WD3, clk, WE3);
    
    always begin
        #10
        clk = ~clk;
    end
    
    initial begin
        A1 = 5'd1;
        A2 = 5'd2;
        A3 = 5'd3;
        WD3 = 32'd128;
        WE3 = 1'b0;
        
        #100
        WE3 = 1'b1;
        
        #100
        A1 = 5'd3;
        
    end
endmodule
