module datapath(
    input clk, reset,
    input memtoreg, pcsrc,
    input alusrc, regdst,
    input regwrite, jump,
    input [2:0] alucontrol,
    output zero,
    output [31:0] pc,
    input [31:0] instr,
    output [31:0] aluout, writedata,
    input [31:0] readdata);
    
    wire[31:0] SignImm; 
    assign SignImm = {{16{instr[15]}}, instr[15:0]};
    
    wire[31:0] PCBranch;
    
    assign PCBranch = jump ? {{6{instr[25]}}, instr[25:0]} : SignImm;

    PC program_counter(pc, jump, PCBranch, clk, pcsrc);

    reg [1:0] ALUControl;
    
    always @(alucontrol)begin
        case(alucontrol)
            3'b010 : ALUControl = 2'b00; //add
            3'b110 : ALUControl = 2'b01; //sub
            3'b000 : ALUControl = 2'b10; //and
            3'b001 : ALUControl = 2'b11; //or
        endcase
    end
    
    wire [31:0] RD1;
    wire [31:0] RD2;
    wire [5:0] A1;
    wire [5:0] A2;
    wire [5:0] A3;
    wire [31:0] WD3;
    wire  WE3;
    assign A1 = instr[25:21];
    assign A2 = instr[20:16];
    assign A3 = regdst ? instr[15:11] : instr[20:16];
    assign WE3 = regwrite;
    
    assign WD3 = memtoreg ? readdata : aluout;
    
    RegisterFile register_file(RD1, RD2, A1, A2, A3, WD3, clk, WE3);

    wire [31:0] SRCA, SRCB;
    assign SRCA = RD1;
    assign SRCB = alusrc ? {{16{instr[15]}}, instr[15:0]} : RD2;
    
    ALU alu(aluout, zero, SRCA, SRCB, ALUControl);
    assign writedata = RD2;
    
endmodule
