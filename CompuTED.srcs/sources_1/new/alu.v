`timescale 1ns / 1ps

// takes 3 control signals and 2 32bit inputs
// outputs 32bit result
// ALU_CONTROL[0] determines wheater to perform ADDITION or SUBTRACTION
// ALU_CONTROL[1] determines wheater to perform AND or OR
// ALU_CONTROL[2] determines wheater to return the result of ARITHMATIC (result of ALU_CONTROL[0]) or LOGICAL (result of ALU_CONTROL[1]) operation

module alu(
    input[31:0] A,
    input[31:0] B,
    input[2:0] ALU_CONTROL,
    
    output[31:0] RESULT
    );
    
    wire[31:0] a_and_b;
    wire[31:0] a_or_b;
    wire[31:0] not_b;
    wire[31:0] mux;
    
    wire[31:0] arithmatic;
    wire[31:0] logical;
    
    wire add_or_sub             = ALU_CONTROL[0];
    wire and_or_or              = ALU_CONTROL[1];
    wire arithmatic_or_logical  = ALU_CONTROL[2];
    
    assign a_and_b      = A & B;
    assign a_or_b       = A | B;
    assign not_b        = ~B;
    assign mux          = (add_or_sub  == 1'b0) ? B : not_b;
    
    // when sub is being performed mux becomes ~B,
    // because of the nature of 2's compliment ~B equals -B - 1
    // thus subtraction can be written as A - B => A + (-B) => A + (~B + 1) => A + ~B + 1
    assign arithmatic   = A + mux + add_or_sub ;
    assign logical      = (and_or_or == 1'b0) ? a_and_b : a_or_b;
    
    assign RESULT = (arithmatic_or_logical == 1'b0) ? arithmatic : logical;
    
endmodule
