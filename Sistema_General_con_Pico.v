`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:44:32 05/31/2016 
// Design Name: 
// Module Name:    Sistema_General_con_Pico 
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
module Sistema_General_con_Pico(
input EN_G,
input [7:0] Port_ID,
input [7:0] Out_Port,
input RST_G,
input CLK_G,
inout [7:0] D,
output [7:0] VGA,
output [8:0] band_vga,
output  AD,
output  CS,
output  RD,
output  WR
    );


//wire UP;
//wire DOWN;
wire READ;
wire WRR;
wire ADin;
wire CSin;
wire WRin;
wire RDin;

wire ADwr;
wire CSwr;
wire WRwr;
wire RDwr;

wire ADrd;
wire CSrd;
wire WRrd;
wire RDrd;

wire bandi;
//wire Centro;
//wire [7:0] Data_VGA, data_vga_wr;
//wire ban_r_vga, band_vga;
wire [7:0] datain;
wire inicia_in;
wire band_z;
//wire [7:0] inicializacion;
wire [7:0] lectura;
wire [7:0] Datos_a_lectura;
wire [7:0] Datos_MUX_buff;
wire [7:0] escritura;
wire selin;
wire fin_wr;
wire inicio_fsmg;
wire Sw;
wire imprime_rtc;
wire [7:0] direcciones;
wire [7:0] dato_a_wr;
wire [7:0] dir_a_wr;
wire [8:0] band_dir_vga;
wire [7:0] wr_deco_reg;
///////////Interfaz entre PICOBLAZE y RTC/////////////////
////
DECO_PICO Direcciones (
    .Port_Id(Port_ID), 
    .ADD(direcciones),
	 .Sw(Sw),
    .clk(CLK_G),
	 .en_progra(imprime_rtc),//programa en rtc
	 .fin_wr(fin_wr),////bandera_fin_wr
	 .data_wr(Out_Port),
	 .out_data_wr(wr_deco_reg)
    );

REG_Id_port DATA_PICO (
    .dir_in(direcciones), 
    .data_in(wr_deco_reg), 
    .clk(CLK_G), 
    .en(EN_G), 
    .reset(fin_wr),//bandera tambien resetea registro 
    .dir_out(dir_a_wr), 
    .data_out(dato_a_wr) 
    );

///////////////////////////////////////////////////////////



	
FSM_GENERAL Control_General (
    .Iniciar(EN_G), 
    .Inicio_Lectura(READ), 
    .Inicio_Escritura(WRR), 
    .CLK(CLK_G), 
    .BandFin(bandi), //fin de inicializacion
    .reset(RST_G), 
	 .Buttom_SW(Sw),
	 .Bandfin_wr(fin_wr),
    .inicializacion(inicia_in)
	  
     );
	  
	  

INICIAR INICIO (
    .EN(inicia_in), 
    .Clk(CLK_G), 
    .Rst(RST_G), 
    .ban_fin(bandi), 
    .ADI(ADin), 
    .CSI(CSin), 
    .WRI(WRin), 
    .RDI (RDin),
	 .datos(datain)
    );
	 
	 
	 
/*	 control_alarma Alarma (
    .en_sav_swr(dir_a_wr), 
    .dataWr(dato_a_wr), 
    .dataRd(VGA), 
    .en_rd(lectura), 
    .reset(RST_G), 
    .clk(CLK_G), 
    .en(en),////quita alarma 
    .alarma(alarma), 
    .data_vga(data_vga)
    );
	
*/



Lectura_actual CONTROL_LECTURA (
    .reset(RST_G), 
    .clk(CLK_G), 
    .en(READ), 
    .data_de_RTC(Datos_a_lectura), ///VER
    .data_vga(VGA), 
  //  .ban_r_vga(ban_r_vga), 
    .band_z(band_z), 
    .Dir(lectura), 
    .AD(ADrd), 
    .CS(CSrd), 
    .RD(RDrd), 
    .WR(WRrd),
	 .band_dir_vga(band_vga)/////////////aqui banderas a vga//////
    );

	 
	 MUX_FINAL MUX_GENERAL(
    .In_inicio(datain), 
    .In_lectura(lectura), 
    .In_escritura(escritura), 
    .a_buffer(Datos_MUX_buff),//Datos_MUX_buff 
    .Selin(inicia_in), 
    .Selrd(READ), 
    .Selwr(WRR)
    );
	 
//wire [7:0] alarma_a_vga;
wire count_reg_wr;
wire count_fs_wr;
contador_FSM_WR wrfsm(
    .En(WRR), 
    .clk(CLK_G), 
    .reset(RST_G), 
    .wr(count_ac_wr)
    );
	 
	 contador_FSM_WR wrreg(
    .En(imprime_rtc), 
    .clk(CLK_G), 
    .reset(RST_G), 
    .wr(count_reg_wr)
    );



	 Escritura_actual Escribe (
    .clk(CLK_G), 
    .en(count_ac_wr), 
    .rst(RST_G), 
    .Bu_c(count_reg_wr), 
    .ADW(ADwr), 
    .CSW(CSwr), 
    .RDW(RDwr), 
    .WRW(WRwr), 
    .direccion_pico(dir_a_wr), 
    //.en_fsm(WRR), 
    .data_pico(dato_a_wr), 
    .fin_wr(fin_wr), //bandera reset_deco 
    .datos(escritura)
    );


Buffer Mux_entrada_salida (
    .IN(band_z), 
    .clk(CLK_G), 
    .inp(Datos_MUX_buff), 
    .outp(Datos_a_lectura), 
    .bidir(D)
    );
	

Mux_General_ADD  Mux_add_GEN(
    .ADi(ADin), 
    .RDi(RDin), 
    .CSi(CSin), 
    .WRi(WRin), 
    .seli(inicia_in),	 
    .ADr(ADrd), 
    .RDr(RDrd), 
    .CSr(CSrd), 
    .WRr(WRrd), 
    .selr(READ), 
    .ADw(ADwr), 
    .RDw(RDwr), 
    .CSw(CSwr), 
    .WRw(WRwr),
	 .selw(WRR),
    .AD(AD), 
    .RD(RD), 
    .CS(CS), 
    .WR(WR)
    );
	 
endmodule




