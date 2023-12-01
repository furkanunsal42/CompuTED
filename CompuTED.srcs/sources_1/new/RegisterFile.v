module RegisterFile(RD1, RD2, A1, A2, A3, WD3, clk, WE3);
output reg[31:0] RD1;
output reg[31:0] RD2;

input[5:0] A1;
input[5:0] A2;
input[5:0] A3;

input clk;
input[31:0] WD3;
input WE3;

reg[31:0] registers[31:0];

always @(posedge clk) begin
    registers[0] = 0;
    RD1 = registers[A1];
    RD2 = registers[A2];
    
    if (WE3 == 1'b1) begin
        registers[A3] = WD3;
    end
end

    
    
endmodule