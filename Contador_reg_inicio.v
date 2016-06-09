`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:16:27 05/12/2016 
// Design Name: 
// Module Name:    cONTADOR 
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
module cONTADOR(
input En,
input clk,
input reset,
output [8:0] salida,
output reg fin
    );

reg [8:0]q_act, q_next;


//Body of "state" registers
always@(posedge clk,posedge reset)
	if(reset) begin
		q_act<= 0;end
	else
		q_act <= q_next;

//Specified functions of the counter 		
always@*
begin
	if(En)
	begin
		if(q_act  < 9'd350)///se le quito 50ns po quitar el turning  
				begin
				
				fin <= 1'b0;
					q_next = q_act + 1'b1;
				end
				
		else begin 
			fin <= 1'b1;
			q_next = q_act;
		end
	end
	else begin
		fin <=1'b0;
		q_next = 0;
		end
		
end

assign salida = q_act;
endmodule
