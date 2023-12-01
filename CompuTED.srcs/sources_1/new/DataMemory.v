module Memory #(parameter MEMORY_SIZE = 8192)(RD, A, WD, WE, clk);
    
    output reg[31:0] RD;
    input[31:0] A;
    input[31:0] WD;
    input WE;
    input clk;
    
    reg[7:0] MemoryData[MEMORY_SIZE-1:0];
    
    always @(posedge clk) begin
        if(WE == 1'b1) begin
            MemoryData[A+0] = WD[7:0];
            MemoryData[A+1] = WD[15:8];
            MemoryData[A+2] = WD[23:16];
            MemoryData[A+3] = WD[31:24];
        end
        
        RD = {MemoryData[A+3], MemoryData[A+2], MemoryData[A+1], MemoryData[A+0]};
    end
    
endmodule 