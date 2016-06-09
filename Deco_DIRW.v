`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:23:37 04/26/2016 
// Design Name: 
// Module Name:    Deco_DIRW 
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
module Deco_DIRW(
   input [3:0] binary_in, //  
	output reg [7:0] decoder_out,  //  
	//output reg band_Fin,
	input EN

);


always@*
begin
	if (EN)  begin
	case (binary_in) 
						
							4'b0000 : decoder_out = 8'h20;//Segundos
							4'b0001 : decoder_out = 8'h21;//Minutos
							4'b0010 : decoder_out = 8'h22;//Horas
							4'b0011 : decoder_out = 8'h23;//Dia
							4'b0100 : decoder_out = 8'h24;//Mes
							4'b0101	: decoder_out = 8'h25;//Año
							4'b0110  : decoder_out = 8'h26;//seg_timer
							4'b0111  : decoder_out = 8'h41;//min_timer
							4'b1000  : decoder_out = 8'h42;//hora_timer	
							4'b1001  : decoder_out = 8'h43;
							4'b1010 : decoder_out = 8'b11110000;
							default: decoder_out = 8'h0; 
			endcase
		end
		else 
		decoder_out = 8'h0;
	end
 
endmodule
