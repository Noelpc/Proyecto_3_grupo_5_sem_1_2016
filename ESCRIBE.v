`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:02:57 05/12/2016 
// Design Name: 
// Module Name:    ESCRITURA_GENERAL 
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
module ESCRITURA_GENERAL(
input clk,
input wire rst,
input wire en,
input wire LOAD,
input wire B_UP,
input wire B_DOWN,
//input wire B_LEFT,
//input wire B_RIGHT,
input wire B_C,
output wire [7:0] data_escrito,
output wire AD,
output wire CS,
output wire WR,
output  band_vga,
output  [7:0] a_vga,

input wire [7:0]load,
output wire RD 
//output wire [3:0]wr_flags,
//input wire formato_hora
    );
	 
	 wire fin_progra;
		wire carga;
		wire set_data;
	 Data_Wr  Control_datos(
    .clk(clk), 
    .en(en), 
    .rst(rst), 
    .B_U(B_UP), 
    .B_D(B_DOWN), 
	 .LOAD(LOAD),
    //.B_L(B_LEFT), 
  //  .B_R(B_RIGHT), 
  //  .format(formato_hora), 
    .Bu_c(carga), //Estado de programacion en RTC
    .ADW(AD), 
    .CSW(CS), 
    .RDW(RD), 
    .WRW(WR), 
	 .load(load),
	 .fin_wr(fin_progra),
    .datos(data_escrito),
	 .a_vga(a_vga),
	 .band_vga(band_vga),
	// .wr_flags(wr_flags),
	 .programa(set_data)//establece estado de WR
    );

//Control
FSM_GENERAL_ESCRITURA Controlador (
    .clock(clk), 
    .reset(rst), 
    .En(en), 
    .band_fin(fin_progra), 
    .B_C(B_C),
	 .In(set_data),
	 .en_progra(carga)
    );



endmodule
