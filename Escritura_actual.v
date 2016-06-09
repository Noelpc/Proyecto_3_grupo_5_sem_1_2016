`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:38:18 06/01/2016 
// Design Name: 
// Module Name:    Escritura_actual 
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
module Escritura_actual(

input clk,
input en,
input rst,
input Bu_c,//activarael contador del registro

output ADW,
output CSW,
output RDW,
output WRW,
//************DEL PICO************//
input [7:0]direccion_pico,
//input en_fsm,
input [7:0] data_pico,
////////////////////////////////////
output fin_wr,////fin_wr de deco_pico
output [7:0] datos
    );
wire [6:0]reg_data;
wire [6:0] count_reg;
wire [6:0]reg_dataO;

//wire [6:0] cont_deco;	 
wire [7:0]deco_reg;
	 
//wire control_time;
wire [8:0] recorrer_reg;

wire [3:0] q;
//assign wr_flags = q;
wire en_dir;
wire ad;
wire set_data;
wire progra;
//wire [6:0]carga;
wire en_dirW;
wire en_wrW;
	 
	
	cuenta_registro Recorre_Registro (
    .En(en),//Habilitado cuando botoN central se active 
    .clk(clk), 
    .reset(rst), 
    .salida(recorrer_reg)
    );



	 Registro_Gen__WR Registro (
	 .clk(clk),
	 .en_dirW(en_dirW),
	 .en_wrW(en_wrW),
    .EN(Bu_c),//establece los datos  
	 //.cambio_ad_W(ad),
    .wr_rtc_W(datos),//salida a rtc 
    .data(data_pico), 
    .cuenta(recorrer_reg),//contador general
    //.en_timeWR_W(en_dir),
	 //.a_vga(a_vga),
	 .direccion_pico(direccion_pico),
	 //.senal_fsm(carga),///VER
	 .fin_wr(fin_wr)
    );

wire en_rd;
assign en_rd = 1'b0;

Control_tiempos Tiempos (
    .en_dir(en_dirW), 
    .en_wr(en_wrW), 
    .en_rd(en_rd), 
    .clk(clk), 
    .rst(rst), 
    .C_AD(ADW), 
    .C_CS(CSW), 
    .C_RD(RDW), 
    .C_WR(WRW)
    );



/*
 Tiempo_escrituravb tiempos_datos (
	 .c_ad(ad),
    .clkW(clk), 
    .enW(en_dir), 
    .resetAD(rst), 
    .CS(CSW), 
    .RD(RDW), 
    .WR(WRW), 
    //.data(control_time ), 
    .AD(ADW)
    );
	*/ 
	 /*
	 FSM_GENERAL_ESCRITURA Controlador (
    .clock(clk), 
    .reset(rst), 
    .En(en), 
    .band_fin(fin_wr), 
    .B_C(Bu_c),
	 .In(set_data),
	 .en_progra(carga)
    );
*/




endmodule
