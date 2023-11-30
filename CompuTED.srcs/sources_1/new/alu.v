module ALU(ALUResult, ZeroFlag, SRCA, SRCB, ALUControl);
    
    output[31:0] ALUResult;
    output ZeroFlag;
    
    input[31:0] SRCA;
    input[31:0] SRCB;
    
    // ALU_CONTROL[0] determines wheater to perform ADDITION or SUBTRACTION if Arithmatic, AND or OR if Logical
    // ALU_CONTROL[1] determines wheater to perform Arithmatic or Logical operation
    input[1:0] ALUControl;
    
    wire[31:0] A_and_B;
    wire[31:0] A_or_B;
    wire[31:0] not_B;
    wire[31:0] mux;
    
    wire[31:0] arithmatic;
    wire[31:0] logical;
    
    wire add_or_sub             = ALUControl[0];
    wire and_or_or              = ALUControl[0];
    wire arithmatic_or_logical  = ALUControl[1];

    
    assign A_and_B      = SRCA & SRCB;
    assign A_or_B       = SRCA | SRCB;
    assign not_B        = ~SRCB;
    assign mux          = (add_or_sub  == 1'b0) ? SRCB : not_B;
    
    // when sub is being performed mux becomes ~B,
    // because of the nature of 2's compliment ~B equals -B - 1
    // thus subtraction can be written as A - B => A + (-B) => A + (~B + 1) => A + ~B + 1
    assign arithmatic   = SRCA + mux + add_or_sub;
    assign logical      = (and_or_or == 1'b0) ? A_and_B : A_or_B;
    
    assign ALUResult = (arithmatic_or_logical == 1'b0) ? arithmatic : logical;
    assign ZeroFlag = ALUResult == 32'b0;
    
endmodule