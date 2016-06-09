`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:45:32 04/26/2016 
// Design Name: 
// Module Name:    MUX_FINAL 
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
module MUX_FINAL(
    input [7:0] In_inicio,
    input [7:0] In_lectura,//IIinp
	 input [7:0] In_escritura,
	 output reg [7:0] a_buffer,///entrada y salida RTC
	// output [7:0] RTC_LEER,
	 input Selin,
	 input Selrd,
	 input Selwr
	 //input SelLeer
    );
/*	 
reg   a;
reg   b;

assign RTC = Z ? a : 8'bZ ;
assign outRd  = b;

// Always Construct

always @ (posedge clk)
begin
if(Selin=1)begin
		dato_temp=In_inicio;end
		else if(Selwr=1)begin
				dato_temp=In_escritura;end
				else if(Selrd==1)begin
					dato_temp=In_lectura; end
    b = RTC;
	 
	 
	 b <= RTC;
    a <=In_lectura;
end
*/
	 
	 always@*
	 begin 
		if(Selin==1 || Selrd==1 || Selwr==1) begin
					if(Selin) begin
						a_buffer = In_inicio;///Deja pasar datos de inicializacion a RTC
						end
					else if(Selrd)begin
						a_buffer = In_lectura;///Deja pasar datos de lectura a RTC
						end
					else if(Selwr) begin
						a_buffer = In_escritura; ///Deja pasar datos de escritura a RTC
						end
					//else if (SelLeer)begin
						//RTC = RTC_LEER;end
						
					else begin
						a_buffer =8'b0;end
					
		end
		else
			begin 
				a_buffer =8'b0;end
		
	end
	
	
endmodule
	 