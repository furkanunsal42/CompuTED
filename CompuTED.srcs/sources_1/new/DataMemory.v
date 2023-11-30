module DataMemory #(parameter MEMORY_SIZE = 8192)(RD, A, WD, WE, clk);
    
    output reg[31:0] RD;
    input[31:0] A;
    input[31:0] WD;
    input WE;
    input clk;
    
    reg[7:0] Memory[MEMORY_SIZE-1:0];
    
    always @(posedge clk) begin
        if(WE == 1'b1) begin
            Memory[A+0] = WD[7:0];
            Memory[A+1] = WD[15:8];
            Memory[A+2] = WD[23:16];
            Memory[A+3] = WD[31:24];
        end
        
        RD = {Memory[A+3], Memory[A+2], Memory[A+1], Memory[A+0]};
    end
    
endmodule 