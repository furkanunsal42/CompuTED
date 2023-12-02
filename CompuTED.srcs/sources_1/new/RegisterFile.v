module RegisterFile(RD1, RD2, A1, A2, A3, WD3, clk, WE3);
output [31:0] RD1;
output [31:0] RD2;

input[5:0] A1;
input[5:0] A2;
input[5:0] A3;

input clk;
input[31:0] WD3;
input WE3;

reg[31:0] registers[31:0];

integer i;
initial begin
    for (i = 0; i <= 5'd31; i = i + 1)
        registers[i] = 0;
end

assign RD1 = registers[A1];
assign RD2 = registers[A2];

always @(posedge clk) begin
    registers[0] = 0;
    
    if (WE3 == 1'b1) begin
        registers[A3] = WD3;
    end
end

    
    
endmodule