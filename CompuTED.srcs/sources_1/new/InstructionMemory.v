`timescale 1ns / 1ps

module InstructionMemory(Instruction, PC);
    input[31:0] PC;
    output reg[31:0] Instruction;
    
    reg[31:0] Memory[1023:0];
    
    always @(PC) begin
       Instruction = Memory[PC >> 2];
    end
    
    initial begin
        Memory[10'd0]   = 32'h2010000a;   //addi $s0,$0,10  
        Memory[10'd1]   = 32'h2011000f;   //addi $sl,$0,15  
        Memory[10'd2]   = 32'h02114020;   //add $t0, $s0,$s1
        Memory[10'd3]   = 32'h02304022;   //sub $t0,$s1,$s0
        Memory[10'd4]   = 32'h02114024;   //and $t0, $s0,$s1
        Memory[10'd5]   = 32'h02114025;   //or $t0, $s0,$s1
        Memory[10'd6]   = 32'h8e09000a;   //back: lw $t1, 10($s0) 100011,10000,01001,0000000000001010
        Memory[10'd7]   = 32'hae29000a;   //next: sw $t1, 10($s1)
        Memory[10'd9]   = 32'h1211fffd;   //beq $s0,$s1,back
        Memory[10'd8]   = 32'h2010000f;   //addi $s0, $0,15
        Memory[10'd9]   = 32'h1211fffb;   //beq $s0,$s1,back
        Memory[10'd10]  = 32'h08100007;   //j next
    end
    
endmodule
