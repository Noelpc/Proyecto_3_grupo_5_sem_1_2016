`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:45:29 05/31/2016 
// Design Name: 
// Module Name:    DECO_PICO 
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
module DECO_PICO(
input [7:0] Port_Id,
output [7:0] ADD,
input clk,
output Sw,
input fin_wr,//bandera que resetea
output en_progra,
input [7:0] data_wr,
output [7:0] out_data_wr
    );
	 
reg progra;	 
reg [7:0] Data_progra;//direcciones
reg sw;
reg [7:0] wr;

always@(posedge clk or posedge fin_wr)
begin
if(fin_wr)
		begin Data_progra <= 8'h0;sw<=1'b0; progra <= 1'b0;end
else begin
case(Port_Id)

		8'h13	:  /// ADD DIA
				begin Data_progra <= 8'h24;sw<=1'b1; progra <= 1'b1; wr<=data_wr; end//
			
		8'h14	://ADD MES
				begin Data_progra <= 8'h25;sw<=1'b1; progra <= 1'b1; wr<=data_wr; end
			
		8'h15	://AD AÑO
				begin Data_progra <= 8'h26;sw<=1'b1;  progra <= 1'b1; wr<=data_wr; end
			
		8'h16	://AD HORA
				begin Data_progra <= 8'h23;sw<=1'b1; progra <= 1'b1; wr<=data_wr; end
			
		8'h17	://AD MINUTOS
				begin Data_progra <= 8'h22;sw<=1'b1; progra <= 1'b1;  wr<=data_wr;  end
			
		8'h18	://AD SEGUNDOS
				begin Data_progra <= 8'h21;sw<=1'b1; progra <= 1'b1; wr<=data_wr;  end
			
		8'h19	://AD HORAS_TIMER
				begin Data_progra <= 8'h41;sw<=1'b1; progra <= 1'b1;  wr<=data_wr; end
			
		8'h1a	://AD MINUTOS_TIMER
				begin Data_progra <= 8'h42;sw<=1'b1; progra <= 1'b1; wr<=data_wr; end
				
		8'h1b	://AD HORA_TIMER
				begin Data_progra <= 8'h43;sw<=1'b1; progra <= 1'b1; wr<=data_wr;  end
				
			default: begin if(!fin_wr) begin Data_progra <= Data_progra; sw<=sw; progra<=progra; wr<=wr;  end 
								else begin Data_progra <=0;sw<=0; progra<=0; wr<=0;  end
						end
			
			endcase
	
	end
end
assign ADD = Data_progra;
assign Sw = sw;
assign en_progra = progra;
assign out_data_wr = wr;
endmodule
