`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:34:12 04/27/2016 
// Design Name: 
// Module Name:    Mux_General_ADD 
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
module Mux_General_ADD(
	input  ADi, RDi, CSi, WRi, seli, ADr, RDr, CSr, WRr,selr,ADw,RDw,CSw, WRw,selw,
	output reg AD, RD, CS ,WR
	);
	
		always@*
		begin
		if (seli)
				begin
				//Para activar tiempos de lectura
				AD = ADi;// 
				RD = RDi;//
				CS = CSi;//
				WR = WRi;
				end
				
		else if(selr)
			//Para activar tiempos de direccionamiento
				begin
				AD = ADr;//
				RD = RDr;//
				CS = CSr;//
				WR = WRr;
				end		
		else if(selw) begin
			AD = ADw;//
			RD = RDw;//
			CS = CSw;//
			WR = WRw;end
		
		else 
			begin
				AD = 1'b1;//
				RD = 1'b1;//
				CS = 1'b1;//
				WR = 1'b1;
				end	
		end
		
endmodule
