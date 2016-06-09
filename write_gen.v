`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:13:06 05/31/2016 
// Design Name: 
// Module Name:    write_gen 
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
module write_gen(
    input inp,
    input clk,
    output write
    );

reg FF1;       
reg FF2;         

always @(posedge clk) 
begin    
      FF1<=inp;		//el siguiente valor de FF1 sera inp
      FF2<=FF1;   	//el siguiente valor de FF2 sera FF1
end

assign write = !FF1 & FF2 & !inp;   //outp sera 1 si FF1 y FF2 son 1.

endmodule
