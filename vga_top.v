`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:51:17 04/17/2016 
// Design Name: 
// Module Name:    vga_top 
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
module vga_top(
    input wire clk,
	 input wire reset,
	 input wire write_strobe,
	 input wire [7:0] IN_PBlaze, IN_RTC, Port_ID,
	 input wire [8:0] EN_Reg_RTC,
    output wire hsync,
	 output wire vsync,
    output wire [7:0] RGB_Out
    );

   // signal declaration
   wire [9:0] pixel_x, pixel_y;
   wire video_on, pixel_tick, Sel_RTC_PB;
   wire [7:0] text_on, data_in_hour_sec;
   wire [2:0] text_rgb;
   reg [2:0] rgb_reg, rgb_next;

   //=======================================================
   // instantiation
   //=======================================================
	  
	//------------------------------------------------------------------------
	
	// VGA-RTC Interface
	
	wire [7:0] data_reg;
	wire [8:0] EN_Reg, EN_Reg_PB, Pointer;
	wire [71:0] Data_VGA;
	
	Ctrl_Interface Control_Interface_Unit (
    .clk(clk), 
    .reset(reset),
    .write_strobe(write_strobe), 	 
    .port_id(Port_ID), 
    .sel_rtc_pb(Sel_RTC_PB), 
    .flag_pointer(Pointer), 
    .en_reg_pb(EN_Reg_PB)
    );

	assign data_reg = Sel_RTC_PB ? IN_PBlaze : IN_RTC;
	assign EN_Reg = Sel_RTC_PB ? EN_Reg_PB : EN_Reg_RTC;
	
	Data_Register Register_Unit (
    .clk(clk), 
    .reset(reset), 
    .en(EN_Reg), 
    .data_in(data_reg), 
    .data_out(Data_VGA)
    );

	//------------------------------------------------------------------------

	Main Main_Unit (
    .rgb(RGB_Out), 
    .clk_i(clk), 
    .clr(reset), 
    .hsync(hsync), 
    .vsync(vsync), 
    .info(Data_VGA), 
    .Pointer(Pointer)
    );
	
endmodule
