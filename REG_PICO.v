`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:21:22 05/31/2016 
// Design Name: 
// Module Name:    REG_PICO 
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
module REG_Id_port(
    input wire [7:0] dir_in,
	 input wire [7:0] data_in,
    input wire clk,
	 input wire en,
    input wire reset,
    output wire [7:0] dir_out,
	  output wire [7:0] data_out
    );

reg [7:0] dir;
reg [7:0] data;
always @(posedge clk or posedge reset)
	begin
		if (reset) begin dir <= 8'b0; data<=8'b0;end
		else if (en) begin  if(!reset) begin dir <= dir_in; data<= data_in;end 
						else begin dir <= dir; data<= data;end
		end
		else  begin dir <= 0; data<= 0;end

end

assign dir_out = dir;
assign data_out = data;
endmodule


