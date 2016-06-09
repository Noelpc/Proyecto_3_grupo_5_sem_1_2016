`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:45:53 04/17/2016 
// Design Name: 
// Module Name:    freq_div 
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
module freq_div(
    input wire clk,
    input wire reset,
    output wire DivCLK
    );

   // mod-2 counter
   reg mod2_reg;
   wire mod2_next;
	
	// body
	always @(posedge clk or posedge reset)
	begin
      if (reset) mod2_reg <= 1'b0;
      else mod2_reg <= mod2_next;
	end
	
	// mod-2 circuit to generate 25 MHz enable tick
   assign mod2_next = ~mod2_reg;
   assign DivCLK = mod2_reg;

endmodule
