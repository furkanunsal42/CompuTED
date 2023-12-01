`timescale 1ns / 1ps

module InstructionMemory(Instruction, PC);
    input[31:0] PC;
    output reg[31:0] Instruction;
    
    reg[31:0] Memory[1023:0];
    
    always @(PC) begin
       Instruction = Memory[PC];
    end

endmodule
