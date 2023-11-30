`timescale 1ns / 1ps

module ALUTest();

    wire[31:0] ALUResult; 
    wire ZeroFlag;
    reg[31:0] SRCA, SRCB;
    reg[1:0] ALUControl;
    ALU dut(ALUResult, ZeroFlag, SRCA, SRCB, ALUControl);
    
    initial begin
        SRCA = 32'd20;
        SRCB = 32'd10;
        ALUControl = 3'b00;    // ADD
        #25
        
        SRCA = 32'd20;
        SRCB = 32'd10;
        ALUControl = 3'b01;    // SUB
        #25
        
        SRCA = 32'd20;
        SRCB = 32'd10;
        ALUControl = 3'b10;    // AND
        #25
        
        SRCA = 32'd12;
        SRCB = 32'd28;
        ALUControl = 3'b11;    // OR
    end
endmodule
