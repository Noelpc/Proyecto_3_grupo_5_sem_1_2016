`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:53:51 05/18/2016 
// Design Name: 
// Module Name:    cuenta_reg_lectura 
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
module cuenta_reg_lectura(
input En,
input clk,
input reset,
output [7:0] salida,
output [3:0] dir
    );

reg [7:0]q_act, q_next;
reg [3:0]dira, dirn;

//Body of "state" registers
always@(posedge clk,posedge reset)
	if(reset) begin
		q_act<= 0;
		dira<=0;
		end
	else
		begin q_act <= q_next; dira<= dirn;end

//Specified functions of the counter 		
always@*
begin
	if(En)
	begin
		if(q_act  < 8'd180) 
				begin
					q_next = q_act + 1'b1;
					if(q_act == 8'd0) begin 
							if(dira >= 4'd8)begin
								dirn=0;end
							else 	dirn = dira+ 1'b1;
					end
					else dirn=dira;
				end
			else begin 
				q_next =0;dirn=dira;
		end
	end
	else begin
		q_next = 0;dirn=0;
		end
end

assign salida = q_act;
assign dir = dira;
endmodule
