`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:33:51 05/12/2016 
// Design Name: 
// Module Name:    INICIAR 
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
module INICIAR(
input EN,
input Clk,
input Rst,
output ban_fin,
output ADI,
output CSI,
output WRI,
output RDI,
output [7:0] datos
    );
wire [8:0] reg_cont;
//wire c;
//wire inicia_count;
//wire d;
wire en_dir;
wire en_wr;
cONTADOR Recorrido_registro (
    .En(EN), 
    .clk(Clk), 
    .reset(Rst), 
    .salida(reg_cont), 
    .fin(ban_fin)
    );

Inicializacion_registro Registro_inicio(
    .count(reg_cont), 
	 .en_dirI(en_dir),
	 .en_wrI(en_wr),
    //.pass_data(d), 
    .data_rtcI(datos), 
    //.c_adI(c), 
    //.en_contiempoI(inicia_count),
	 .en(EN),
	 .clk(Clk)
	 //.reset(Rst)
    );
	 
	 wire en_rd;
	 assign en_rd=1'b0;
	 Control_tiempos Tiempos (
    .en_dir(en_dir), 
    .en_wr(en_wr), 
    .en_rd(en_rd), 
    .clk(Clk), 
    .rst(Rst), 
    .C_AD(ADI), 
    .C_CS(CSI), 
    .C_RD(RDI), 
    .C_WR(WRI)
    );
	 /*
	 Tiempo_escrituravb Set_time(
    .clkW(Clk), 
    .enW(inicia_count), 
    .resetAD(Rst), 
    .c_ad(c), 	
    .CS(CSI), 
    .RD(RDI), 
    .WR(WRI), 
    .AD(ADI)
    );
*/
endmodule
