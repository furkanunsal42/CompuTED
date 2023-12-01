`timescale 1ns / 1ps

module ControlUnit(MemToReg, MemWrite, Branch, ALUControl, AluSrc, RegDst, RegWrite, Opcode, Function);
    input[5:0] Opcode;
    input[5:0] Function;
    
    output reg MemToReg;    
    output reg MemWrite;
    output reg Branch;
    output reg[1:0] ALUControl;
    output reg AluSrc;  // 0 for register, 1 for immidiate
    output reg RegDst;  // 0 for rd,       1 for rt
    output reg RegWrite;
    
    wire[5:0] instruction_id;
    assign instruction_id = Opcode == 5'b0 ? Function : Opcode;
    
    always @(Opcode, Function)begin
        case(instruction_id)
            001000:     //addi
            begin
                MemToReg = 0;
                MemWrite = 0;
                Branch = 0;
                ALUControl = 2'b00;
                AluSrc = 1;
                RegDst = 1;
                RegWrite = 1;
            end
            
            100000:     //add
            begin
                MemToReg = 0;
                MemWrite = 0;
                Branch = 0;
                ALUControl = 2'b00;
                AluSrc = 0;
                RegDst = 0;
                RegWrite = 1;
            end
            
            100010:     //sub
            begin
                MemToReg = 0;
                MemWrite = 0;
                Branch = 0;
                ALUControl = 2'b01;
                AluSrc = 0;
                RegDst = 0;
                RegWrite = 1;
            end
            
            100100:     //and
            begin
                MemToReg = 0;
                MemWrite = 0;
                Branch = 0;
                ALUControl = 2'b10;
                AluSrc = 0;
                RegDst = 0;
                RegWrite = 1;
            end
            
            100101:     //or
            begin
                MemToReg = 0;
                MemWrite = 0;
                Branch = 0;
                ALUControl = 2'b11;
                AluSrc = 0;
                RegDst = 0;
                RegWrite = 1;
            end
            
            100011:     //lw
            begin
                MemToReg = 1;
                MemWrite = 0;
                Branch = 0;
                ALUControl = 2'b00; // CHECK
                AluSrc = 0;         // CHECK
                RegDst = 0;         // CHECK
                RegWrite = 1;
            end
            
            101011:     //sw
            begin
                MemToReg = 0;
                MemWrite = 1;
                Branch = 0;
                ALUControl = 2'b00; // CHECK
                AluSrc = 0;         // CHECK                 
                RegDst = 0;         // CHECK
                RegWrite = 0;
            end
            
            000100:     //beq
            begin
                MemToReg = 0;
                MemWrite = 0;
                Branch = 1;
                ALUControl = 2'b01; // CHECK
                AluSrc = 0;         // CHECK                 
                RegDst = 0;         // CHECK
                RegWrite = 0;
            end
            
            000010:     //j
            begin
                MemToReg = 0;
                MemWrite = 0;
                Branch = 1;
                ALUControl = 2'b10; // CHECK
                AluSrc = 1;         // CHECK                 
                RegDst = 0;         // CHECK
                RegWrite = 0;
            end
            
            default:
            begin
                MemToReg = 0;
                MemWrite = 0;
                Branch = 0;
                ALUControl = 2'b00; // CHECK
                AluSrc = 0;         // CHECK                 
                RegDst = 0;         // CHECK
                RegWrite = 0;
            end
            
            
            
        endcase
    end    

endmodule
