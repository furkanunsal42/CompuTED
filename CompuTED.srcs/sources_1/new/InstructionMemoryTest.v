`timescale 1ns / 1ps

module InstructionMemoryTest();
    
    reg[31:0] PC;
    wire[31:0] instruction;
    InstructionMemory dut(PC, instruction);
    
    initial begin
    
        PC = 32'd0;
        #10
        PC = 32'd1;
        #10
        PC = 32'd2;
        #10
        PC = 32'd3;
        #10
        PC = 32'd4;
        #10
        PC = 32'd5;
        #10
        PC = 32'd6;
        #10
        PC = 32'd7;
        #10
        PC = 32'd8;
        
    end
    
endmodule