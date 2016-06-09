`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:33:08 05/11/2016 
// Design Name: 
// Module Name:    cuenta_registro 
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
module cuenta_registro(
input En,
input clk,
input reset,
//output reg fin_wr,
output [8:0] salida 
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
		if(salida <= 9'd290) 
				begin
					q_next = q_act + 8'b1;
				
				end
		else begin
		q_next = q_act;
		end
		
	end
	else 
		q_next =9'b0;
	

end

assign salida = q_act;

endmodule
