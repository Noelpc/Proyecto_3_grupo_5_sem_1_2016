`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:45:32 05/29/2016 
// Design Name: 
// Module Name:    Proyecto_TOP 
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
module Proyecto_TOP(
    input wire CLK,
    input wire Reset,
    input wire PS2d,
    input wire PS2c,
    input wire EN_General,
    output wire hsync,
    output wire vsync,
    output wire [2:0] RGB_Out,
	 inout [7:0] D,
	 output wire CLK_Out,
	 output wire AD,
	 output wire CS,
	 output wire RD,
	 output wire WR
    );

assign CLK_Out = CLK;

//////////////////////////////////////////////////////////////////////////////////
wire Rs;

debounce_circuit Rs_Unit (
    .inp(Reset), 
    .clk(CLK), 
    .outp(Rs)
    );

//////////////////////////////////////////////////////////////////////////////////
wire	[11:0]	address;
wire	[17:0]	instruction;
wire			bram_enable;
wire	[7:0]		port_id;
wire	[7:0]		out_port;
wire	[7:0]		in_port;
wire			write_strobe;
wire			k_write_strobe;
wire			read_strobe;
wire			interrupt;            //See note above
wire			interrupt_ack;
wire			kcpsm6_sleep;         //See note above
wire			kcpsm6_reset;         //See note above


  kcpsm6 #(
	.interrupt_vector	(12'h3FF),
	.scratch_pad_memory_size(64),
	.hwbuild		(8'h00))
  processor (
	.address 		(address),
	.instruction 	(instruction),
	.bram_enable 	(bram_enable),
	.port_id 		(port_id),
	.write_strobe 	(write_strobe),
	.k_write_strobe 	(k_write_strobe),
	.out_port 		(out_port),
	.read_strobe 	(read_strobe),
	.in_port 		(in_port),
	.interrupt 		(interrupt),
	.interrupt_ack 	(interrupt_ack),
	.reset 		(kcpsm6_reset),
	.sleep		(kcpsm6_sleep),
	.clk 			(CLK)); 

  assign kcpsm6_sleep = 1'b0;
  assign kcpsm6_reset = 1'b0;
  assign interrupt = 1'b0;


  control #(
	.C_FAMILY		   ("7S"),   	//Family 'S6' or 'V6'
	.C_RAM_SIZE_KWORDS	(1),  	//Program size '1', '2' or '4'
	.C_JTAG_LOADER_ENABLE	(0))  	//Include JTAG Loader when set to '1' 
  program_rom (    				//Name to match your PSM file
 	.rdl 			(kcpsm6_reset),
	.enable 		(bram_enable),
	.address 		(address),
	.instruction 	(instruction),
	.clk 			(CLK));

//////////////////////////////////////////////////////////////////////////////////
wire [7:0] Out_PBlaze_BCD;

Deco_Bin_Bcd BintoBcd_Unit (
    .clk(CLK), 
    .In_Bin(out_port), 
    .Out_BCD(Out_PBlaze_BCD)
    );

//////////////////////////////////////////////////////////////////////////////////
wire [7:0] Out_RTC_VGA;

wire [8:0] En_Reg_RTC;

Sistema_General_con_Pico RTC_Unit (
    .EN_G(EN_General), 
    .Port_ID(port_id), 
    .Out_Port(Out_PBlaze_BCD), 
    .RST_G(Rs), 
    .CLK_G(CLK), 
    .D(D), 
    .VGA(Out_RTC_VGA), 
    .band_vga(En_Reg_RTC), 
    .AD(AD), 
    .CS(CS), 
    .RD(RD), 
    .WR(WR)
    );

//////////////////////////////////////////////////////////////////////////////////

Driver_PS2 PS2_Unit (
    .CLK(CLK), 
    .Reset(Rs), 
    .PS2d(PS2d), 
    .PS2c(PS2c), 
    .RX_En(EN_General), 
    .ID_Port(port_id), 
    .Data_Out(in_port)
    );

//////////////////////////////////////////////////////////////////////////////////

vga_top VGA_Unit (
    .clk(CLK), 
    .reset(Rs),
    .write_strobe(write_strobe), 	 
    .IN_PBlaze(Out_PBlaze_BCD), 
    .IN_RTC(Out_RTC_VGA), 
    .Port_ID(port_id), 
    .EN_Reg_RTC(En_Reg_RTC), 	 
    .hsync(hsync), 
    .vsync(vsync), 
    .RGB_Out(RGB_Out)
    );

endmodule
