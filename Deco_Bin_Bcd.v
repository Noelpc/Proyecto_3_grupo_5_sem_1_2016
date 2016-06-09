`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:38:36 06/01/2016 
// Design Name: 
// Module Name:    Deco_Bin_Bcd 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Deco_Bin_Bcd(
	 input wire clk,
    input wire [7:0] In_Bin,
    output wire [7:0] Out_BCD
    );

reg [7:0] Out_Bcd;

always @(posedge clk)
begin
	case (In_Bin)
		8'h00: Out_Bcd <= 8'h00;
		8'h01: Out_Bcd <= 8'h01;
		8'h02: Out_Bcd <= 8'h02;
		8'h03: Out_Bcd <= 8'h03;
		8'h04: Out_Bcd <= 8'h04;
		8'h05: Out_Bcd <= 8'h05;
		8'h06: Out_Bcd <= 8'h06;
		8'h07: Out_Bcd <= 8'h07;
		8'h08: Out_Bcd <= 8'h08;
		8'h09: Out_Bcd <= 8'h09;
		8'h0a: Out_Bcd <= 8'h10;
		8'h0b: Out_Bcd <= 8'h11;
		8'h0c: Out_Bcd <= 8'h12;
		8'h0d: Out_Bcd <= 8'h13;
		8'h0e: Out_Bcd <= 8'h14;
		8'h0f: Out_Bcd <= 8'h15;
		8'h10: Out_Bcd <= 8'h16;
		8'h11: Out_Bcd <= 8'h17;
		8'h12: Out_Bcd <= 8'h18;
		8'h13: Out_Bcd <= 8'h19;
		8'h14: Out_Bcd <= 8'h20;
		8'h15: Out_Bcd <= 8'h21;
		8'h16: Out_Bcd <= 8'h22;
		8'h17: Out_Bcd <= 8'h23;
		8'h18: Out_Bcd <= 8'h24;
		8'h19: Out_Bcd <= 8'h25;
		8'h1a: Out_Bcd <= 8'h26;
		8'h1b: Out_Bcd <= 8'h27;
		8'h1c: Out_Bcd <= 8'h28;
		8'h1d: Out_Bcd <= 8'h29;
		8'h1e: Out_Bcd <= 8'h30;
		8'h1f: Out_Bcd <= 8'h31;
		8'h20: Out_Bcd <= 8'h32;
		8'h21: Out_Bcd <= 8'h33;
		8'h22: Out_Bcd <= 8'h34;
		8'h23: Out_Bcd <= 8'h35;
		8'h24: Out_Bcd <= 8'h36;
		8'h25: Out_Bcd <= 8'h37;
		8'h26: Out_Bcd <= 8'h38;
		8'h27: Out_Bcd <= 8'h39;
		8'h28: Out_Bcd <= 8'h40;
		8'h29: Out_Bcd <= 8'h41;
		8'h2a: Out_Bcd <= 8'h42;
		8'h2b: Out_Bcd <= 8'h43;
		8'h2c: Out_Bcd <= 8'h44;
		8'h2d: Out_Bcd <= 8'h45;
		8'h2e: Out_Bcd <= 8'h46;
		8'h2f: Out_Bcd <= 8'h47;
		8'h30: Out_Bcd <= 8'h48;
		8'h31: Out_Bcd <= 8'h49;
		8'h32: Out_Bcd <= 8'h50;
		8'h33: Out_Bcd <= 8'h51;
		8'h34: Out_Bcd <= 8'h52;
		8'h35: Out_Bcd <= 8'h53;
		8'h36: Out_Bcd <= 8'h54;
		8'h37: Out_Bcd <= 8'h55;
		8'h38: Out_Bcd <= 8'h56;
		8'h39: Out_Bcd <= 8'h57;
		8'h3a: Out_Bcd <= 8'h58;
		8'h3b: Out_Bcd <= 8'h59;
		8'h3c: Out_Bcd <= 8'h60;
		8'h3d: Out_Bcd <= 8'h61;
		8'h3e: Out_Bcd <= 8'h62;
		8'h3f: Out_Bcd <= 8'h63;
		8'h40: Out_Bcd <= 8'h64;
		8'h41: Out_Bcd <= 8'h65;
		8'h42: Out_Bcd <= 8'h66;
		8'h43: Out_Bcd <= 8'h67;
		8'h44: Out_Bcd <= 8'h68;
		8'h45: Out_Bcd <= 8'h69;
		8'h46: Out_Bcd <= 8'h70;
		8'h47: Out_Bcd <= 8'h71;
		8'h48: Out_Bcd <= 8'h72;
		8'h49: Out_Bcd <= 8'h73;
		8'h4a: Out_Bcd <= 8'h74;
		8'h4b: Out_Bcd <= 8'h75;
		8'h4c: Out_Bcd <= 8'h76;
		8'h4d: Out_Bcd <= 8'h77;
		8'h4e: Out_Bcd <= 8'h78;
		8'h4f: Out_Bcd <= 8'h79;
		8'h50: Out_Bcd <= 8'h80;
		8'h51: Out_Bcd <= 8'h81;
		8'h52: Out_Bcd <= 8'h82;
		8'h53: Out_Bcd <= 8'h83;
		8'h54: Out_Bcd <= 8'h84;
		8'h55: Out_Bcd <= 8'h85;
		8'h56: Out_Bcd <= 8'h86;
		8'h57: Out_Bcd <= 8'h87;
		8'h58: Out_Bcd <= 8'h88;
		8'h59: Out_Bcd <= 8'h89;
		8'h5a: Out_Bcd <= 8'h90;
		8'h5b: Out_Bcd <= 8'h91;
		8'h5c: Out_Bcd <= 8'h92;
		8'h5d: Out_Bcd <= 8'h93;
		8'h5e: Out_Bcd <= 8'h94;
		8'h5f: Out_Bcd <= 8'h95;
		8'h60: Out_Bcd <= 8'h96;
		8'h61: Out_Bcd <= 8'h97;
		8'h62: Out_Bcd <= 8'h98;
		8'h63: Out_Bcd <= 8'h99;
		default: Out_Bcd <= 8'h00;
	endcase
end

assign Out_BCD = Out_Bcd;

endmodule
