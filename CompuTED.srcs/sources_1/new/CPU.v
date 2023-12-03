`timescale 1ns / 1ps

module CPU();

    reg clk = 0;
    wire [31:0] PC;
    wire PCSrc;
    wire [31:0] Instruction;
    wire[31:0] SignImm; 
    
    assign SignImm = {{16{Instruction[15]}}, Instruction[15:0]};
    
    wire  ZeroFlag; // ALU
    wire  Branch;   // ControlUnit
    wire  Jump;     // ControlUnit

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
    wire [31:0] MemoryOut;
    assign WD3 = MemToReg ? MemoryOut : ALUResult;
    
    RegisterFile register_file(RD1, RD2, A1, A2, A3, WD3, clk, WE3);

    wire [31:0] SRCA, SRCB;
    assign SRCA = RD1;
    assign SRCB = AluSrc ? {{16{Instruction[15]}}, Instruction[15:0]} : RD2;
    
    ALU alu(ALUResult, ZeroFlag, SRCA, SRCB, ALUControl);
    
    Memory #(.MEMORY_SIZE(128)) memory(MemoryOut, ALUResult, RD2, MemWrite, clk);
    
    reg reset;
    always begin
        #5 clk = ~clk;
    end
    
    initial
    begin
    clk=0; reset=1; 
    clk=0; reset=0; 
    /*Instruction=32'h2010000a; //{RegWrite,RegDst,AluSrc,MemToReg,PCSrc,ALUControl,jump}=8'b10100000; //addi $s0,$0,10  
    #5 clk=0; Instruction=32'h2011000f; //{RegWrite,RegDst,AluSrc,MemToReg,PCSrc,ALUControl,jump}=8'b10100000; //addi $l,$0,15  
    #5 clk=0; Instruction=32'h02114020; //{RegWrite,RegDst,AluSrc,MemToReg,PCSrc,ALUControl,jump}=8'b11000000; //add $t0, $s0,$s1
    #5 clk=0; Instruction=32'h02304022; //{RegWrite,RegDst,AluSrc,MemToReg,PCSrc,ALUControl,jump}=8'b11000100;//sub $t0,$s1,$s0
    #5 clk=0; Instruction=32'h02114024; //{RegWrite,RegDst,AluSrc,MemToReg,PCSrc,ALUControl,jump}=8'b11000010;//and $t0, $s0,$s1
    #5 clk=0; Instruction=32'h02114025; //{RegWrite,RegDst,AluSrc,MemToReg,PCSrc,ALUControl,jump}=8'b11000110;//or $t0, $s0,$s1
    #5 clk=0; Instruction=32'h8e09000a; //{RegWrite,RegDst,AluSrc,MemToReg,PCSrc,ALUControl,jump}=8'b10110000;//back: lw $t1, 10($s0) 100011,10000,01001,0000000000001010
    #5 clk=0; Instruction=32'hae29000a; //{RegWrite,RegDst,AluSrc,MemToReg,PCSrc,ALUControl,jump}=8'b00100000;//next: sw $t1, 10($s1)
    #5 clk=0; Instruction=32'h1211fffd; //{RegWrite,RegDst,AluSrc,MemToReg,PCSrc,ALUControl,jump}=8'b00000010;//beq $s0,$s1,back
    #5 clk=0; Instruction=32'h2010000f; //{RegWrite,RegDst,AluSrc,MemToReg,PCSrc,ALUControl,jump}=8'b10100000;//addi $s0, $0,15
    #5 clk=0; Instruction=32'h1211fffd; //{RegWrite,RegDst,AluSrc,MemToReg,PCSrc,ALUControl,jump}=8'b00001010;//beq $s0,$s1,back
    #5 clk=0; 
    #5 clk=0; Instruction=32'h08100007; //{RegWrite,RegDst,AluSrc,MemToReg,PCSrc,ALUControl,jump}=8'b00001101;//j next
    */
    end
    
endmodule
