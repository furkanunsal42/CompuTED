`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.12.2023 23:16:02
// Design Name: 
// Module Name: IntegerMultiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module IntegerMultiplier(
input [31:0] a,b,
output [63:0] p);

wire [31:0] m0;
wire [32:0] m1;
wire [33:0] m2;
wire [34:0] m3;
wire [35:0] m4;
wire [36:0] m5;
wire [37:0] m6;
wire [38:0] m7;
wire [39:0] m8;
wire [40:0] m9;
wire [41:0] m10;
wire [42:0] m11;
wire [43:0] m12;
wire [44:0] m13;
wire [45:0] m14;
wire [46:0] m15;
wire [47:0] m16;
wire [48:0] m17;
wire [49:0] m18;
wire [50:0] m19;
wire [51:0] m20;
wire [52:0] m21;
wire [53:0] m22;
wire [54:0] m23;
wire [55:0] m24;
wire [56:0] m25;
wire [57:0] m26;
wire [58:0] m27;
wire [59:0] m28;
wire [60:0] m29;
wire [61:0] m30;
wire [62:0] m31;



wire [63:0] s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21,s22,s23,s24,s25,s26,s27,s28,s29,s30;
wire[63:0] s31;


assign m0= {32{a[0]}} & b[31:0];
assign m1= {32{a[1]}} & b[31:0];
assign m2= {32{a[2]}} & b[31:0];
assign m3= {32{a[3]}} & b[31:0];
assign m4= {32{a[4]}} & b[31:0];
assign m5= {32{a[5]}} & b[31:0];
assign m6= {32{a[6]}} & b[31:0];
assign m7= {32{a[7]}} & b[31:0];
assign m8= {32{a[8]}} & b[31:0];
assign m9= {32{a[9]}} & b[31:0];
assign m10= {32{a[10]}} & b[31:0];
assign m11= {32{a[11]}} & b[31:0];
assign m12= {32{a[12]}} & b[31:0];
assign m13= {32{a[13]}} & b[31:0];
assign m14= {32{a[14]}} & b[31:0];
assign m15= {32{a[15]}} & b[31:0];
assign m16= {32{a[16]}} & b[31:0];
assign m17= {32{a[17]}} & b[31:0];
assign m18= {32{a[18]}} & b[31:0];
assign m19= {32{a[19]}} & b[31:0];
assign m20= {32{a[20]}} & b[31:0];
assign m21= {32{a[21]}} & b[31:0];
assign m22= {32{a[22]}} & b[31:0];
assign m23= {32{a[23]}} & b[31:0];
assign m24= {32{a[24]}} & b[31:0];
assign m25= {32{a[25]}} & b[31:0];
assign m26= {32{a[26]}} & b[31:0];
assign m27= {32{a[27]}} & b[31:0];
assign m28= {32{a[28]}} & b[31:0];
assign m29= {32{a[29]}} & b[31:0];
assign m30= {32{a[30]}} & b[31:0];
assign m31= {32{a[31]}} & b[31:0];


assign s1= m0 + (m1<<1);
assign s2= s1 + (m2<<2);
assign s3= s2 + (m3<<3);
assign s4= s3 + (m4<<4);
assign s5= s4 + (m5<<5);
assign s6= s5 + (m6<<6);
assign s7= s6 + (m7<<7);
assign s8= s7 + (m8<<8);
assign s9= s8 + (m9<<9);
assign s10= s9 + (m10<<10);
assign s11= s10 + (m11<<11);
assign s12= s11 + (m12<<12);
assign s13= s12 + (m13<<13);
assign s14= s13 + (m14<<14);
assign s15= s14 + (m15<<15);
assign s16= s15 + (m16<<16);
assign s17= s16 + (m17<<17);
assign s18= s17 + (m18<<18);
assign s19= s18 + (m19<<19);
assign s20= s19 + (m20<<20);
assign s21= s20 + (m21<<21);
assign s22= s21 + (m22<<22);
assign s23= s22 + (m23<<23);
assign s24= s23 + (m24<<24);
assign s25= s24 + (m25<<25);
assign s26= s25 + (m26<<26);
assign s27= s26 + (m27<<27);
assign s28= s27 + (m28<<28);
assign s29= s28 + (m29<<29);
assign s30= s29 + (m30<<30);
assign s31= s30 + (m31<<31);
assign p=s31;
    
endmodule
