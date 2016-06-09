`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:53:17 05/18/2016 
// Design Name: 
// Module Name:    Lectura_actual 
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
module Lectura_actual(
input reset,
input clk,
input en,
input [7:0] data_de_RTC,
output [7:0] data_vga,
//output ban_r_vga,
output band_z,
output [7:0] Dir,
output AD,
output CS,
output RD,
output WR,
output [8:0] band_dir_vga
    );
wire [7:0] count;
wire con_dir_rd;
//wire c_ad;
//wire en_contiempoR;
wire [3:0]dir;
wire en_dir;
wire en_rd;
reg_lectura Registro (
    .count(count), 
    .Dir(Dir), 
    //.c_ad_wr(c_ad),
  //  .en_contiempoR(en_contiempoR), 
    .en(en), 
	 .reset(reset),
    .clk(clk),
	 .en_dirl(en_dir),
	 .en_rdl(en_rd),
    .data_de_RTC(data_de_RTC), 
    .data_vga(data_vga), 
    //.ban_r_vga(ban_r_vga), 
    .band_z(band_z),
	 .band_dir_vga(band_dir_vga),
	 .cuenta_dir(dir)
    );
	 
	 
	 
cuenta_reg_lectura Cuenta (
    .En(en), 
    .clk(clk), 
    .reset(reset), 
    .salida(count),
	 .dir(dir)
    );
	 
	 
	 wire en_wr;
	 assign en_wr = 1'b0;

Control_tiempos Tiempos (
    .en_dir(en_dir), 
    .en_wr(en_wr), 
    .en_rd(en_rd), 
    .clk(clk), 
    .rst(reset), 
    .C_AD(AD), 
    .C_CS(CS), 
    .C_RD(RD), 
    .C_WR(WR)
    );




/*
Tiempos_lectura Tiempos (
    .clkW(clk), 
    .enW(en_contiempoR), 
    .resetAD(reset), 
    .c_ad(c_ad), 
    .CS(CS), 
    .RD(RD), 
    .WR(WR), 
    .AD(AD)
    );
*/
/*

Tiempos_ADDR Set_times (
    .clkW(clk), 
    .enW(en_contiempoR), 
    .resetAD(reset), 
    .c_ad(c_ad), 
    .CS(CS), 
    .RD(RD), 
    .WR(WR), 
    .AD(AD)
    );
*/



endmodule
