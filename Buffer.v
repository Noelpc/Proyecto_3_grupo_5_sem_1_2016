`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:28:12 04/26/2016 
// Design Name: 
// Module Name:    Buffer 
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
module Buffer (IN, clk, inp, outp, bidir);


input   IN;//selector
input   clk;
input   [7:0] inp;//entrada_datos, dato q quiero enviar
output  [7:0] outp;//salida, dato q se recibe de rtc
inout   [7:0] bidir;//IN_OUT_RTC
//output  [7:0] x;
reg     [7:0] a;
reg     [7:0] b;

assign bidir = IN ? 8'bz : a;
assign outp  = b;

// Always Construct

always @ (posedge clk)
begin
    b <= bidir;
    a <= inp;
end

endmodule


/*

module BUS_IO2(
    input wire clk,      // The standard clock
    input wire Dato_1, Dato_2,  // señal para leer o escribir
    input wire [7:0]data_in,    // Data to send out when direction is 1
    output wire [7:0]data_out,   // Result of input pin when direction is 0
    inout  [7:0]io_port     // The i/o port to send data through
    );

    reg [7:0]a, b;    

    assign io_port  = Dato_2 ? a : 8'bz;
    assign data_out = b;

    always @ (posedge clk)
    begin
	 a <= data_in;
	 if (Dato_1)
       b <= io_port;
    end

endmodule
*/