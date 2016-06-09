`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:21:04 04/19/2016 
// Design Name: 
// Module Name:    reg_data 
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
module reg_data_clr(
    input wire [7:0] data_in,
    input wire clk,
	 input wire en,
    input wire reset,
	 input wire clear,
    output wire [7:0] data_out
    );

reg [7:0] data_next;
wire Rs;
assign Rs = reset || clear;

always @(posedge clk or posedge Rs)
	begin
		if (Rs) data_next <= 8'b0;
		else if (en) data_next <= data_in;
		else data_next <= data_next;
	end

assign data_out = data_next;

endmodule
