`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:13:22 04/17/2016 
// Design Name: 
// Module Name:    debounce_circuit 
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
module clear_gen(
    input inp,
    input clk,
    output clear
    );

reg FF1;       
reg FF2;         

always @(posedge clk) 
begin    
      FF1<=inp;		//el siguiente valor de FF1 sera inp
      FF2<=FF1;   	//el siguiente valor de FF2 sera FF1
end

assign clear = FF1 & FF2 & !inp;   //outp sera 1 si FF1 y FF2 son 1.

endmodule
