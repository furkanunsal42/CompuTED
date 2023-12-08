`timescale 1ns / 1ps

module CoreTest();
    
    reg clk = 0;
    wire [31:0] PC;
    wire PCSrc;
    wire [31:0] Instruction;
    wire[31:0] SignImm; 
    assign SignImm = {{16{Instruction[15]}}, Instruction[15:0]};

    wire Branch;   // ControlUnit
    wire Jump;     // ControlUnit
    wire ZeroFlag;
    wire[31:0] PCBranch;
    assign PCBranch = Jump ? {{6{Instruction[25]}}, Instruction[25:0]} : SignImm;
    assign PCSrc = ZeroFlag & Branch;
    
    PC program_counter(PC, Jump, PCBranch, clk, PCSrc);

    InstructionMemory instruction_memory(Instruction, PC);
    
    wire  MemToReg;
    wire  MemWrite;
    wire [1:0] ALUControl;
    wire  AluSrc;
    wire  RegDst;
    wire  RegWrite;
    
    wire [5:0] Opcode;
    wire [5:0] Function;
    assign Opcode = Instruction[31:26];
    assign Function = Instruction[5:0];
    
    ControlUnit control_unit(MemToReg, MemWrite, Branch, ALUControl, AluSrc, RegDst, RegWrite, Jump, Opcode, Function);
    
    wire[31:0] ALUResult;
    wire[31:0] MemoryWrite;
    wire[31:0] MemoryRead;

    Core dut(ALUResult, MemoryWrite, ZeroFlag, Instruction, SignImm, MemoryRead, MemToReg, MemWrite, ALUControl, AluSrc, RegDst, RegWrite, clk);
    
    Memory #(.MEMORY_SIZE(128)) memory(MemoryRead, ALUResult, MemoryWrite, MemWrite, clk);
    
    always begin
        #5 clk = ~clk;
    end
    
endmodule
