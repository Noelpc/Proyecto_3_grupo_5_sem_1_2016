`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:44:30 05/08/2016 
// Design Name: 
// Module Name:    Data_Wr 
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
module Data_Wr(
input clk,
input en,
input rst,
input B_U,
input B_D,
//input B_L,
//input B_R,
//input format,
input Bu_c,//activarael contador del registro
//input bandera,
output ADW,
output CSW,
output RDW,
output WRW,
//output [3:0]wr_flags,
output fin_wr,
input programa,
output band_vga,
input LOAD,
output [7:0] a_vga,
output [7:0] datos,
input [7:0]load
    );
	 
wire [6:0]reg_data;
wire [6:0] count_reg;
wire [6:0]reg_dataO;

wire [6:0] cont_deco;	 
wire [7:0]deco_reg;
	 
//wire control_time;
wire [7:0] recorrer_reg;

wire [3:0] q;
//assign wr_flags = q;
wire en_dir;
wire ad;
wire progra;
wire [6:0]carga;
Contador_General_data_WR Cuenta_DATOS(
    .clkA(clk), 
    .resetA(rst), 
    .enA(en), //señal de FSM_G
    .upA(B_U), 
    .downA(B_D), 
	 .band_vga(band_vga), 
    //.formato(format), 
    .qA(cont_deco),
	 .LOAD(LOAD),
		.load(carga)
  //  .band(q)
    );
	 
	 conversor_hexa_bin Deco (
    .hexa_in(load), 
    .EN(en), 
    .bin_out(carga)
    );


	 
	
/*
	 
	 registro_wr_transicion reg_dato(
    .clk(reg_data), 
    .din(count_reg ), 
    .dout(reg_dataO)
    );

*/
	 
	 Deco_General_data_WR DATOS(
    .binary_in(cont_deco), 
    .EN(en), 
    .decoder_out(deco_reg)
    );
	
	
	cuenta_registro Recorre_Registro (
    .En(Bu_c),//Habilitado cuando botoN central se active 
    .clk(clk), 
    .reset(rst), 
	 //.fin_wr(fin_wr),
    .salida(recorrer_reg)
    );



	 Registro_Gen__WR Registro (
   // .band(q),
	 .clk(clk),
    .EN(programa),//establece los datos  
	 .cambio_ad_W(ad),
    .wr_rtc_W(datos), 
    //.flag1(flag1), 
   // .flag(control_time), 
    .data(deco_reg), 
    .cuenta(recorrer_reg),//contador general
    //.en_timeAdd(en_ti), 
    .en_timeWR_W(en_dir),
	 .a_vga(a_vga),
	 .senal_fsm(Bu_c),
	 .fin_wr(fin_wr)
	 //.band_vga(band_vga)
    );


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
/*
Cuenta_DIR_WR Cuenta_data_reg(
    .clkADD(clk), 
    .resetADD(rst), 
    .enADD(programa), 
    .upADD(B_L), 
    .downADD(B_R), 
    .qADD(q)
    );
	 */
	 /*
	 Tiempos_ADDW Set_time_dir (
    .clkAD(clk), 
    .resetAD(rst), 
    .enAD(en), 
    .CS(CSW), 
    .RD(RDW), 
    .WR(WRW), 
    .AD(ADW), 
    .DIR(en_dir)
    );
*/






endmodule
