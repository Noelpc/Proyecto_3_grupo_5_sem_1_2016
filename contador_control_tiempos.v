`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:59:02 06/04/2016 
// Design Name: 
// Module Name:    contador_control_tiempos 
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
module contador_control_tiempos(
input En_dir,
input En_rd,
input En_wr,
input clk,
input rst,
output [4:0] salida
    );

reg [4:0]q_act, q_next;


//Body of "state" registers
always@(posedge clk,posedge rst)
	if(rst) begin
		q_act<= 0;end
	else
		q_act <= q_next;

//Specified functions of the counter 		
always@*
begin
	if(En_dir ||En_rd||En_wr)
	begin
		if(q_act  <= 5'd22) 
				begin
					q_next = q_act + 1'b1;
				end
		else begin 
			q_next = q_act;
		end
	end
	else begin
		q_next = 0;
		end
		
end
assign salida = q_act;

endmodule
