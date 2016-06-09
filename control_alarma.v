`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:23:54 06/07/2016 
// Design Name: 
// Module Name:    control_alarma 
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
module control_alarma(
input [7:0] en_sav_swr,
input [7:0] dataWr,
input [7:0] dataRd,
input [7:0] en_rd,
input reset,
input clk,
input en,
output reg alarma,
output reg [7:0] data_vga
    );
reg [7:0]seg_timerW;
reg [7:0]min_timerW;
reg [7:0]hour_timerW;

reg [7:0]seg_timerR;
reg [7:0]min_timerR;
reg [7:0]hour_timerR;



////////////////////////captura los datos de escritura y los deja estaticos/////////////////////////
always@(posedge clk) begin
if(reset) begin seg_timer <=0; min_timer<=0; hour_timer <=0;end
else if(en_sav_swr==8'h43) begin hour_timerW<=dataWr;end
else if(en_sav_swr==8'h42) begin min_timerW<=dataWr;end
else if(en_sav_swr==8'h41) begin seg_timerW<=dataWr;end
else begin seg_timerW <=seg_timerW; min_timerW <=min_timerW; hour_timerW <=hour_timerW;end
end
 
 ////////////////////////////////////////////////////////////////////////////////



///////////////registros variables////////////////

always@(posedge clk)begin
if(reset) begin seg_timer <=0; min_timer<=0; hour_timer <=0;end
else if(en_rd==8'h43) begin hour_timerR<=dataRr;end
else if(en_rd==8'h42) begin min_timerR<=dataRr;end
else if(en_rd==8'h41) begin seg_timerR<=dataRr;end
else begin seg_timerR <=seg_timerR; min_timerR <=min_timerR; hour_timerR <=hour_timerR;end
end

always@(posedge clk)begin
	if(en)
	case(en_rd) 
		8'h43: data_vga = hour_timerR - hour_timerW;
				//	if(data_vga<=8'b0)begin alarma<=1'b1;end
		
		
		8'h42: data_vga= min_timerR - min_timerW;
				//if(data_vga<=8'b0)begin alarma<=1'b1;end
		
		8'h41: data_vga= seg_timerR- seg_timerW;
		//		if(data_vga<=8'b0)begin alarma<=1'b1;end
		
		default: data_vga<= dataRd;
		endcase
		
		
end

endmodule
