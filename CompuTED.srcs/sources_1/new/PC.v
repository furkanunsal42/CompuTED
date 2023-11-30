module PC (clk, PCSrc, PCBranch, PC);
input clk;
input PCSrc;
input[31:0] PCBranch;
output reg[31:0] PC;

initial begin
    PC = 32'd0;
end 

always @(posedge clk) begin
    if (PCSrc == 1'd1) begin
        PC = PCBranch;
    end
    else begin
        PC = PC + 32'd4;
    end
end

endmodule

