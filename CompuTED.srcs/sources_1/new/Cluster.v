
module Cluster #(parameter CORE_COUNT = 2) (clk);
    input clk;
    
    
    wire[31:0] MemoryRead;
    wire[31:0] MemoryWrite;
    wire[31:0] MemoryAddress;
    wire MemoryWriteFlag;
    Memory memory_L1(MemoryRead, MemoryAddress, MemoryWrite, MemoryWriteFlag, clk);
    memory_L1(.MEMORY_SIZE(128));
    
    generate 
        genvar i;
        for (i = 0; i <= CORE_COUNT-1; i = i + 1) begin
            Core i_core();
        end
    endgenerate

endmodule
