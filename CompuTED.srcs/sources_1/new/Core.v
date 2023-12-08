`timescale 1ns / 1ps

module Core(ALUResult, MemoryWrite, ZeroFlag, Instruction, SignImm, MemoryRead, MemToReg, MemWrite, ALUControl, AluSrc, RegDst, RegWrite, clk);
    output[31:0] ALUResult;
    output[31:0] MemoryWrite;
    output ZeroFlag;
    input[31:0] Instruction;
    input[31:0] SignImm; 
    input[31:0] MemoryRead;
    input MemToReg;
    input MemWrite;
    input[1:0] ALUControl;
    input AluSrc;
    input RegDst;
    input RegWrite;
    input clk;
        
    wire [5:0] Opcode;
    wire [5:0] Function;
    assign Opcode = Instruction[31:26];
    assign Function = Instruction[5:0];
    
    wire [31:0] RD1;
    wire [31:0] RD2;
    wire [5:0] A1;
    wire [5:0] A2;
    wire [5:0] A3;
    wire [31:0] WD3;
    wire  WE3;
    assign A1 = Instruction[25:21];
    assign A2 = Instruction[20:16];
    assign A3 = RegDst ? Instruction[15:11] : Instruction[20:16];
    assign WE3 = RegWrite;
    
    wire [31:0] ALUResult;
    assign WD3 = MemToReg ? MemoryRead : ALUResult;
    assign MemoryWrite = RD2;
    
    RegisterFile register_file(RD1, RD2, A1, A2, A3, WD3, clk, WE3);

    wire [31:0] SRCA, SRCB;
    assign SRCA = RD1;
    assign SRCB = AluSrc ? {{16{Instruction[15]}}, Instruction[15:0]} : RD2;

    ALU alu(ALUResult, ZeroFlag, SRCA, SRCB, ALUControl);

endmodule
