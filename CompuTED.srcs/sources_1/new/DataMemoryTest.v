`timescale 1ns / 1ps

module DataMemoryTest();
    
    wire[31:0] RD; 
    reg[31:0] A, WD; 
    reg WE, clk = 0;
    
    DataMemory #(.MEMORY_SIZE(512)) dut (RD, A, WD, WE, clk);
    
    always begin
        #10
        clk = ~clk;
    end
    
    initial begin
        A = 32'd0;
        WD = 32'd20;
        #100
        WE = 1;
        
        #30
        WE = 0;
        A = 32'd1;
        WD = 32'd32;
        #10
        WE = 1;
        
    end
    
endmodule
