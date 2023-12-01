`timescale 1ns / 1ps

module CPU();

    reg clk = 0;
    wire[31:0] PC;
    wire[31:0] PCBranch;
    wire[31:0] PCSrc;
    PC pc(PC, PCBranch, clk, PCSrc);
    
    wire[31:0] Instruction;
    InstructionMemory instruction_memory(Instruction, PC);
    
    wire MemToReg;
    wire MemWrite;
    wire Branch;
    wire[1:0] ALUControl;
    wire AluSrc;
    wire RegDst;
    wire RegWrite;
    
    wire[5:0] Opcode;
    wire[5:0] Function;
    assign Opcode = Instruction[31:26];
    assign Function = Instruction[5:0];
    
    ControlUnit control_unit(MemToReg, MemWrite, Branch, ALUControl, AluSrc, RegDst, RegWrite, Opcode, Function);
    
    wire[31:0] RD1;
    wire[31:0] RD2;
    wire[5:0] A1;
    wire[5:0] A2;
    wire[5:0] A3;
    wire[31:0] WD3;
    wire WE3;
    assign A1 = Instruction[25:21];
    assign A2 = Instruction[20:16];
    assign A3 = RegDst ? Instruction[15:11] : Instruction[20:16];
    assign WE3 = RegWrite;
    
    wire[31:0] ALUResult;
    wire[31:0] MemoryOut;
    assign WD3 = MemToReg ? MemoryOut : ALUResult;
    
    RegisterFile register_file(RD1, RD2, A1, A2, A3, WD3, clk, WE3);

    wire ZeroFlag;
    wire[31:0] SRCA, SRCB;
    assign SRCA = RD1;
    assign SRCB = AluSrc ? {{16{Instruction[15]}}, Instruction[15:0]} : RD2;
    
    ALU alu(ALUResult, ZeroFlag, SRCA, SRCB, ALUControl);
    
    Memory #(.MEMORY_SIZE(512)) memory(MemoryOut, ALUResult, RD2, MemWrite, clk);
    
    always begin
        #1
        clk = ~clk;
    end
    
    
    
endmodule
