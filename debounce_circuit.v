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
module debounce_circuit(
    input inp,
    input clk,
    output outp
    );

reg FF1;       
reg FF2;       
reg FF3; 
reg FF4; 
     

always @(posedge clk) 
begin    
      FF1<=inp;		//el siguiente valor de FF1 sera elevelr
      FF2<=FF1;   	//el siguiente valor de FF2 sera FF1
      FF3<=FF2;   	//el siguiente valor de FF3 sera FF2
		FF4<=FF3;
end

assign outp = FF1 & FF2 & FF3 & FF4 & !inp;   //outp sera 1 si FF1, FF2, FF3 y FF4 son 1 .


endmodule
