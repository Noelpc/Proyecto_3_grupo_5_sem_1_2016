`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:57:21 05/24/2016 
// Design Name: 
// Module Name:    Data_Register 
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
module Data_Register(
	 input wire clk,
	 input wire reset,
	 input wire [8:0] en,
    input wire [7:0] data_in,
    output wire [71:0] data_out
    );

/////////////////////////////////////////////
wire [7:0] data_out_date_day;

reg_data date_day_reg (
    .data_in(data_in), 
    .clk(clk), 
    .en(en[0]), 
    .reset(reset), 
    .data_out(data_out_date_day)
    );

/////////////////////////////////////////////
wire [7:0] data_out_date_month;

reg_data date_month_reg (
    .data_in(data_in), 
    .clk(clk), 
    .en(en[1]), 
    .reset(reset), 
    .data_out(data_out_date_month)
    );

/////////////////////////////////////////////
wire [7:0] data_out_date_year;

reg_data date_year_reg (
    .data_in(data_in), 
    .clk(clk), 
    .en(en[2]), 
    .reset(reset), 
    .data_out(data_out_date_year)
    );

/////////////////////////////////////////////
wire [7:0] data_out_hour_hour;

reg_data hour_hour_reg (
    .data_in(data_in), 
    .clk(clk), 
    .en(en[3]), 
    .reset(reset), 
    .data_out(data_out_hour_hour)
    );

/////////////////////////////////////////////
wire [7:0] data_out_hour_min;

reg_data hour_min_reg (
    .data_in(data_in), 
    .clk(clk), 
    .en(en[4]), 
    .reset(reset), 
    .data_out(data_out_hour_min)
    );

/////////////////////////////////////////////
wire [7:0] data_out_hour_sec;

reg_data hour_sec_reg (
    .data_in(data_in), 
    .clk(clk), 
    .en(en[5]), 
    .reset(reset), 
    .data_out(data_out_hour_sec)
    );

/////////////////////////////////////////////
wire [7:0] data_out_cron_hour;

reg_data cron_hour_reg (
    .data_in(data_in), 
    .clk(clk), 
    .en(en[6]), 
    .reset(reset), 
    .data_out(data_out_cron_hour)
    );

/////////////////////////////////////////////
wire [7:0] data_out_cron_min;

reg_data cron_min_reg (
    .data_in(data_in), 
    .clk(clk), 
    .en(en[7]), 
    .reset(reset), 
    .data_out(data_out_cron_min)
    );

/////////////////////////////////////////////
wire [7:0] data_out_cron_sec;

reg_data cron_sec_reg (
    .data_in(data_in), 
    .clk(clk), 
    .en(en[8]), 
    .reset(reset), 
    .data_out(data_out_cron_sec)
    );

assign data_out[7:0] = data_out_date_day;
assign data_out[15:8] = data_out_date_month;
assign data_out[23:16] = data_out_date_year;

assign data_out[31:24] = data_out_hour_hour;
assign data_out[39:32] = data_out_hour_min;
assign data_out[47:40] = data_out_hour_sec;

assign data_out[55:48] = data_out_cron_hour;
assign data_out[63:56] = data_out_cron_min;
assign data_out[71:64] = data_out_cron_sec;

endmodule
