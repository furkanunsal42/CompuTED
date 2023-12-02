module PC (PC, SignImm, clk, PCSrc);
input clk;
input PCSrc;
input[31:0] SignImm;
output reg[31:0] PC;

wire[31:0] PCBranch;
assign PCBranch = (SignImm << 2) + PC + 4;

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

