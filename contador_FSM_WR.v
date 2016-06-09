`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:16:35 06/03/2016 
// Design Name: 
// Module Name:    contador_FSM_WR 
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
module contador_FSM_WR(
input En,
input clk,
input reset,
//output reg fin_wr,
output wr
    );
reg activo;
reg [7:0]q_act, q_next;

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
		if(q_act<= 8'd20) 
				begin
					q_next <= q_act + 7'b1;
					activo<=1'b0;
				
				end
		else begin
		q_next <= q_act;
		activo<=1'b1;
		end
		
		
	end
else begin
	q_next <=8'b0; activo<=1'b0;end
end
assign wr = activo;

endmodule
