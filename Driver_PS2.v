`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:37:50 05/24/2016 
// Design Name: 
// Module Name:    Driver_PS2 
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
module Driver_PS2(
    input wire CLK,
    input wire Reset,
    input wire PS2d,
    input wire PS2c,
    input wire RX_En,
    input wire [7:0] ID_Port,
    output wire [7:0] Data_Out
    );

/////////////////////////-----------Señales----------/////////////////////////////
wire Lectura;
wire clear;
wire rx_done_tick;
wire [7:0] PS2_data;

///////////////--------Generador de la bandera "Lectura"-------///////////////////
assign Lectura = (ID_Port == 8'h70) ? 1'b1: 1'b0;

////////////////////-----------Generador "Clear"----------////////////////////////
clear_gen Clear_Gen (
    .inp(Lectura), 
    .clk(CLK), 
    .clear(clear)
    );

//////////////////////-----------Recibidor PS2----------//////////////////////////
ps2_rx PS2_Receiver (
    .clk(CLK), 
    .reset(Reset), 
    .ps2d(PS2d), 
    .ps2c(PS2c), 
    .rx_en(RX_En), 
    .rx_done_tick(rx_done_tick), 
    .dout(PS2_data)
    );

////////////////////-----------Registro de Salida----------///////////////////////
reg_data_clr Reg_Data_Out (
    .data_in(PS2_data), 
    .clk(CLK), 
    .en(rx_done_tick), 
    .reset(Reset), 
    .clear(clear), 
    .data_out(Data_Out)
    );

endmodule
