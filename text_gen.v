`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:09:18 04/16/2016 
// Design Name: 
// Module Name:    text_gen 
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
module vga_text
   (
    input wire CLK, 
    input wire [9:0] pix_x,
	 input wire [9:0] pix_y,
    input wire [71:0] data_in,
	 input wire [8:0] pointer,
    output wire [7:0] text_on,
    output reg [2:0] text_rgb
   );

   // signal declaration
	
	wire [7:0] data_in_date_d, data_in_date_m, data_in_date_y;
	wire [7:0] data_in_hour_sec, data_in_hour_min, data_in_hour_h;
	wire [7:0] data_in_cron_sec, data_in_cron_min, data_in_cron_h;
	
   wire [10:0] rom_addr;
   reg [6:0] char_addr, char_addr_date, char_addr_actualdate, char_addr_hour,
            char_addr_actualhour, char_addr_cron, char_addr_actualcron, char_addr_alarm, char_addr_alert;
   
	reg [3:0] row_addr;
	wire [3:0] row_addr_date, row_addr_actualdate, row_addr_hour, row_addr_actualhour,
				row_addr_cron, row_addr_actualcron, row_addr_alarm, row_addr_alert;
   
	reg [2:0] bit_addr;
	wire [2:0] bit_addr_date, bit_addr_actualdate, bit_addr_hour, bit_addr_actualhour, 
				bit_addr_cron, bit_addr_actualcron, bit_addr_alarm, bit_addr_alert;
   
	wire [7:0] font_word;
   
	wire font_bit, date_on, actualdate_on, hour_on, actualhour_on, cron_on, actualcron_on, alarm_on, alert_on;
	wire pointer_date_d, pointer_date_m, pointer_date_y, pointer_hour_h, pointer_hour_min, pointer_hour_sec,
			pointer_cron_h, pointer_cron_min, pointer_cron_sec;
	
	wire day, month, year, h_hour, h_min, h_sec, c_hour, c_min, c_sec;
	
	// assignments
	
	assign data_in_date_d = data_in[7:0];
	assign data_in_date_m = data_in[15:8];
	assign data_in_date_y = data_in[23:16];
	
	assign data_in_hour_h = data_in[31:24];
	assign data_in_hour_min = data_in[39:32];
	assign data_in_hour_sec = data_in[47:40];
	
	assign data_in_cron_h = data_in[55:48];
	assign data_in_cron_min = data_in[63:56];
	assign data_in_cron_sec = data_in[71:64];
	
	assign pointer_date_d = pointer[0];
	assign pointer_date_m = pointer[1];
	assign pointer_date_y = pointer[2];
	
	assign pointer_hour_h = pointer[3];
	assign pointer_hour_min = pointer[4];
	assign pointer_hour_sec = pointer[5];
	
	assign pointer_cron_h = pointer[6];
	assign pointer_cron_min = pointer[7];
	assign pointer_cron_sec = pointer[8];
	
   // instantiate font ROM
   font_rom font_unit
      (.clk(CLK),
		 .addr(rom_addr), 
		 .data(font_word)
		 );

	//-------------------------------------------
   // date region
   //  - scale to 16-by-32 font
   //  - line 2, 16 chars: "__DIA_MES_AÑO___"
   //-------------------------------------------
   assign date_on = (pix_y[9:5]==2) && (pix_x[9:4]<16);
   assign row_addr_date = pix_y[4:1];
   assign bit_addr_date = pix_x[3:1];
   always @*
      case (pix_x[7:4])
         4'h0: char_addr_date = 7'h00; // 
         4'h1: char_addr_date = 7'h00; // 
         4'h2: char_addr_date = 7'h44; // D
         4'h3: char_addr_date = 7'h49; // I
         4'h4: char_addr_date = 7'h41; // A
         4'h5: char_addr_date = 7'h00; // 
         4'h6: char_addr_date = 7'h4d; // M
         4'h7: char_addr_date = 7'h45; // E
         4'h8: char_addr_date = 7'h53; // S
         4'h9: char_addr_date = 7'h00; //
         4'ha: char_addr_date = 7'h41; // A
         4'hb: char_addr_date = 7'h7f; // Ñ
         4'hc: char_addr_date = 7'h4f; // O
         4'hd: char_addr_date = 7'h00; // 
         4'he: char_addr_date = 7'h00; // 
         4'hf: char_addr_date = 7'h00; //
      endcase

   //-------------------------------------------
   // actual date region
   //  - scale to 16-by-32 font
   //  - line 3, 16 chars: "___16__04_2016__"
   //-------------------------------------------
   assign actualdate_on = (pix_y[9:5]==3) && (pix_x[9:4]<16);
	assign day = (pix_y[9:5]==3) && (3<=pix_x[9:4]) && (pix_x[9:4]<=4);
	assign month = (pix_y[9:5]==3) && (7<=pix_x[9:4]) && (pix_x[9:4]<=8);
	assign year = (pix_y[9:5]==3) && (12<=pix_x[9:4]) && (pix_x[9:4]<=13);
   assign row_addr_actualdate = pix_y[4:1];
   assign bit_addr_actualdate = pix_x[3:1];
   always @*
      case (pix_x[7:4])
         4'h0: char_addr_actualdate = 7'h00; // 
         4'h1: char_addr_actualdate = 7'h00; // 
         4'h2: char_addr_actualdate = 7'h00; // 
         4'h3: char_addr_actualdate = {3'b011, data_in_date_d[7:4]}; // 1	= 7'h31= {3'b011, data_in_date_d[3:0]}
         4'h4: char_addr_actualdate = {3'b011, data_in_date_d[3:0]}; // 6	= 7'h36= {3'b011, data_in_date_d[7:4]}
         4'h5: char_addr_actualdate = 7'h00; // 
         4'h6: char_addr_actualdate = 7'h00; // 
         4'h7: char_addr_actualdate = {3'b011, data_in_date_m[7:4]}; // 0	= 7'h30= {3'b011, data_in_date_m[3:0]}
         4'h8: char_addr_actualdate = {3'b011, data_in_date_m[3:0]}; // 4	= 7'h34= {3'b011, data_in_date_m[7:4]}
         4'h9: char_addr_actualdate = 7'h00; // 
         4'ha: char_addr_actualdate = 7'h32; // 2
         4'hb: char_addr_actualdate = 7'h30; // 0
         4'hc: char_addr_actualdate = {3'b011, data_in_date_y[7:4]}; // 1	= 7'h31= {3'b011, data_in_date_y[3:0]}
         4'hd: char_addr_actualdate = {3'b011, data_in_date_y[3:0]}; // 6	= 7'h36= {3'b011, data_in_date_y[7:4]}
         4'he: char_addr_actualdate = 7'h00; // 
         4'hf: char_addr_actualdate = 7'h00; //
      endcase

	//-------------------------------------------
   // hour region
   //  - scale to 16-by-32 font
   //  - line 9, 16 chars: "__HORA__AM/PM___"
   //-------------------------------------------
   assign hour_on = (pix_y[9:5]==9) && (pix_x[9:4]<16);
   assign row_addr_hour = pix_y[4:1];
   assign bit_addr_hour = pix_x[3:1];
   always @*
      case (pix_x[7:4])
         4'h0: char_addr_hour = 7'h00; // 
         4'h1: char_addr_hour = 7'h00; // 
         4'h2: char_addr_hour = 7'h48; // H
         4'h3: char_addr_hour = 7'h4f; // O
         4'h4: char_addr_hour = 7'h52; // R
         4'h5: char_addr_hour = 7'h41; // A
         4'h6: char_addr_hour = 7'h00; // 
         4'h7: char_addr_hour = 7'h00; // 
         4'h8: char_addr_hour = 7'h41; // A
         4'h9: char_addr_hour = 7'h4d; // M
         4'ha: char_addr_hour = 7'h2f; // /
         4'hb: char_addr_hour = 7'h50; // P
         4'hc: char_addr_hour = 7'h4d; // M
         4'hd: char_addr_hour = 7'h00; // 
         4'he: char_addr_hour = 7'h00; // 
         4'hf: char_addr_hour = 7'h00; //
      endcase

   //-------------------------------------------
   // actual hour region
   //  - scale to 16-by-32 font
   //  - line 11, 16 chars: "___07:45:39_____"
   //-------------------------------------------
   assign actualhour_on = (pix_y[9:5]==11) && (pix_x[9:4]<16);
	assign h_hour = (pix_y[9:5]==11) && (3<=pix_x[9:4]) && (pix_x[9:4]<=4);
	assign h_min = (pix_y[9:5]==11) && (6<=pix_x[9:4]) && (pix_x[9:4]<=7);
	assign h_sec = (pix_y[9:5]==11) && (9<=pix_x[9:4]) && (pix_x[9:4]<=10);
   assign row_addr_actualhour = pix_y[4:1];
   assign bit_addr_actualhour = pix_x[3:1];
   always @*
      case (pix_x[7:4])
         4'h0: char_addr_actualhour = 7'h00; // 
         4'h1: char_addr_actualhour = 7'h00; // 
         4'h2: char_addr_actualhour = 7'h00; // 
         4'h3: char_addr_actualhour = {3'b011, data_in_hour_h[7:4]}; // 0	= 7'h30= {3'b011, data_in_hour_h[3:0]}
         4'h4: char_addr_actualhour = {3'b011, data_in_hour_h[3:0]}; // 7	= 7'h37= {3'b011, data_in_hour_h[7:4]}
         4'h5: char_addr_actualhour = 7'h3a; // :
         4'h6: char_addr_actualhour = {3'b011, data_in_hour_min[7:4]}; // 4	= 7'h34= {3'b011, data_in_hour_min[3:0]}
         4'h7: char_addr_actualhour = {3'b011, data_in_hour_min[3:0]}; // 5	= 7'h35= {3'b011, data_in_hour_min[7:4]}
         4'h8: char_addr_actualhour = 7'h3a; // :
         4'h9: char_addr_actualhour = {3'b011, data_in_hour_sec[7:4]}; // 3	= 7'h33= {3'b011, data_in_hour_sec[3:0]}
         4'ha: char_addr_actualhour = {3'b011, data_in_hour_sec[3:0]}; // 9	= 7'h39= {3'b011, data_in_hour_sec[7:4]}
         4'hb: char_addr_actualhour = 7'h00; // 
         4'hc: char_addr_actualhour = 7'h00; // 
         4'hd: char_addr_actualhour = 7'h00; // 
         4'he: char_addr_actualhour = 7'h00; // 
         4'hf: char_addr_actualhour = 7'h00; //
      endcase

	//-------------------------------------------
   // cronom region
   //  - scale to 16-by-32 font
   //  - line 2, 16 chars: "___CRONOMETRO___"
   //-------------------------------------------
   assign cron_on = (pix_y[9:5]==2) && (19<=pix_x[9:4]) && (pix_x[9:4]<=34);
   assign row_addr_cron = pix_y[4:1];
   assign bit_addr_cron = pix_x[3:1];
   always @*
      case (pix_x[7:4])
         4'h0: char_addr_cron = 7'h00; // 
         4'h1: char_addr_cron = 7'h00; // 
         4'h2: char_addr_cron = 7'h00; // 
         4'h3: char_addr_cron = 7'h43; // C
         4'h4: char_addr_cron = 7'h52; // R
         4'h5: char_addr_cron = 7'h4f; // O
         4'h6: char_addr_cron = 7'h4e; // N
         4'h7: char_addr_cron = 7'h4f; // O
         4'h8: char_addr_cron = 7'h4d; // M
         4'h9: char_addr_cron = 7'h45; // E
         4'ha: char_addr_cron = 7'h54; // T
         4'hb: char_addr_cron = 7'h52; // R
         4'hc: char_addr_cron = 7'h4f; // O
         4'hd: char_addr_cron = 7'h00; // 
         4'he: char_addr_cron = 7'h00; // 
         4'hf: char_addr_cron = 7'h00; // 
      endcase

   //-------------------------------------------
   // actual cronom region
   //  - scale to 16-by-32 font
   //  - line 4, 16 chars: "___08:02:27_____"
   //-------------------------------------------
   assign actualcron_on = (pix_y[9:5]==4) && (19<=pix_x[9:4]) && (pix_x[9:4]<=34);
	assign c_hour = (pix_y[9:5]==4) && (19<=pix_x[9:4]) && (pix_x[9:4]<=20);
	assign c_min = (pix_y[9:5]==4) && (22<=pix_x[9:4]) && (pix_x[9:4]<=23);
	assign c_sec = (pix_y[9:5]==4) && (25<=pix_x[9:4]) && (pix_x[9:4]<=26);	
   assign row_addr_actualcron = pix_y[4:1];
   assign bit_addr_actualcron = pix_x[3:1];
   always @*
      case (pix_x[7:4])
         4'h0: char_addr_actualcron = 7'h00; // 
         4'h1: char_addr_actualcron = 7'h00; // 
         4'h2: char_addr_actualcron = 7'h00; // 
         4'h3: char_addr_actualcron = {3'b011, data_in_cron_h[7:4]}; // 0	= 7'h30= {3'b011, data_in_cron_h[3:0]}
         4'h4: char_addr_actualcron = {3'b011, data_in_cron_h[3:0]}; // 8	= 7'h38= {3'b011, data_in_cron_h[7:4]}
         4'h5: char_addr_actualcron = 7'h3a; // :
         4'h6: char_addr_actualcron = {3'b011, data_in_cron_min[7:4]}; // 0	= 7'h30= {3'b011, data_in_cron_min[3:0]}
         4'h7: char_addr_actualcron = {3'b011, data_in_cron_min[3:0]}; // 2	= 7'h32= {3'b011, data_in_cron_min[7:4]}
         4'h8: char_addr_actualcron = 7'h3a; // :
         4'h9: char_addr_actualcron = {3'b011, data_in_cron_sec[7:4]}; // 2	= 7'h32= {3'b011, data_in_cron_sec[3:0]}
         4'ha: char_addr_actualcron = {3'b011, data_in_cron_sec[3:0]}; // 7	= 7'h37= {3'b011, data_in_cron_sec[7:4]}
         4'hb: char_addr_actualcron = 7'h00; // 
         4'hc: char_addr_actualcron = 7'h00; // 
         4'hd: char_addr_actualcron = 7'h00; // 
         4'he: char_addr_actualcron = 7'h00; // 
         4'hf: char_addr_actualcron = 7'h00; //
      endcase

	//-------------------------------------------
   // alarm region
   //  - scale to 16-by-32 font
   //  - line 9, 16 chars: "_____ALARMA_____"
   //-------------------------------------------
   assign alarm_on = (pix_y[9:5]==9) && (20<=pix_x[9:4]) && (pix_x[9:4]<=35);
   assign row_addr_alarm = pix_y[4:1];
   assign bit_addr_alarm = pix_x[3:1];
   always @*
      case (pix_x[7:4])
         4'h0: char_addr_alarm = 7'h00; // 
         4'h1: char_addr_alarm = 7'h00; // 
         4'h2: char_addr_alarm = 7'h00; // 
         4'h3: char_addr_alarm = 7'h00; // 
         4'h4: char_addr_alarm = 7'h00; // 
         4'h5: char_addr_alarm = 7'h41; // A
         4'h6: char_addr_alarm = 7'h4c; // L
         4'h7: char_addr_alarm = 7'h41; // A
         4'h8: char_addr_alarm = 7'h52; // R
         4'h9: char_addr_alarm = 7'h4d; // M
         4'ha: char_addr_alarm = 7'h41; // A
         4'hb: char_addr_alarm = 7'h00; // 
         4'hc: char_addr_alarm = 7'h00; // 
         4'hd: char_addr_alarm = 7'h00; // 
         4'he: char_addr_alarm = 7'h00; // 
         4'hf: char_addr_alarm = 7'h00; // 
      endcase

   //-------------------------------------------
   // alert region
   //  - scale to 16-by-32 font
   //  - lines 11 and 12, 16 chars: "_______**_________"
   //-------------------------------------------
   assign alert_on = (pix_y[9:5]==11) && (pix_y[9:5]==12) && (20<=pix_x[9:4]) && (pix_x[9:4]<=35);
   assign row_addr_alert = pix_y[4:1];
   assign bit_addr_alert = pix_x[3:1];
   always @*
      case (pix_x[7:4])
         4'h0: char_addr_alert = 7'h00; // 
         4'h1: char_addr_alert = 7'h00; // 
         4'h2: char_addr_alert = 7'h00; // 
         4'h3: char_addr_alert = 7'h00; // 
         4'h4: char_addr_alert = 7'h00; // 
         4'h5: char_addr_alert = 7'h00; // 
         4'h6: char_addr_alert = 7'h00; // 
         4'h7: char_addr_alert = 7'h04; // rombo
         4'h8: char_addr_alert = 7'h04; // rombo
         4'h9: char_addr_alert = 7'h00; // 
         4'ha: char_addr_alert = 7'h00; // 
         4'hb: char_addr_alert = 7'h00; // 
         4'hc: char_addr_alert = 7'h00; // 
         4'hd: char_addr_alert = 7'h00; // 
         4'he: char_addr_alert = 7'h00; // 
         4'hf: char_addr_alert = 7'h00; // 
      endcase

   //-------------------------------------------
   // mux for font ROM addresses and rgb
   //-------------------------------------------
   always @*
   begin
      text_rgb = 3'b111;  // background, white
      if (date_on)
         begin
            char_addr = char_addr_date;
            row_addr = row_addr_date;
            bit_addr = bit_addr_date;
            if (font_bit)
               text_rgb = 3'b001;
         end
		else if (actualdate_on)
         begin
            char_addr = char_addr_actualdate;
            row_addr = row_addr_actualdate;
            bit_addr = bit_addr_actualdate;
            if (font_bit)
               text_rgb = 3'b001;
				else if ((day&&pointer_date_d) || (month&&pointer_date_m) || (year&&pointer_date_y))
					text_rgb = 3'b000;
         end
		else if (hour_on)
         begin
            char_addr = char_addr_hour;
            row_addr = row_addr_hour;
            bit_addr = bit_addr_hour;
            if (font_bit)
               text_rgb = 3'b001;
         end
		else if (actualhour_on)
         begin
            char_addr = char_addr_actualhour;
            row_addr = row_addr_actualhour;
            bit_addr = bit_addr_actualhour;
            if (font_bit)
               text_rgb = 3'b001;
				else if ((h_hour&&pointer_hour_h) || (h_min&&pointer_hour_min) || (h_sec&&pointer_hour_sec))
					text_rgb = 3'b000;
         end
      else if (cron_on)
         begin
            char_addr = char_addr_cron;
            row_addr = row_addr_cron;
            bit_addr = bit_addr_cron;
            if (font_bit)
               text_rgb = 3'b001;
         end
		else if (actualcron_on)
         begin
            char_addr = char_addr_actualcron;
            row_addr = row_addr_actualcron;
            bit_addr = bit_addr_actualcron;
            if (font_bit)
               text_rgb = 3'b001;
				else if ((c_hour&&pointer_cron_h) || (c_min&&pointer_cron_min) || (c_sec&&pointer_cron_sec))
					text_rgb = 3'b000;
         end
		else if (alarm_on)
         begin
            char_addr = char_addr_alarm;
            row_addr = row_addr_alarm;
            bit_addr = bit_addr_alarm;
            if (font_bit)
               text_rgb = 3'b001;
         end
      else //alert_on
         begin
            char_addr = char_addr_alert;
            row_addr = row_addr_alert;
            bit_addr = bit_addr_alert;
            if (font_bit)
               text_rgb = 3'b001;
         end
		//else text_rgb = 3'b111;
   end

   assign text_on = {date_on, actualdate_on, hour_on, actualhour_on, cron_on, actualcron_on, alarm_on, alert_on};
   //-------------------------------------------
   // font rom interface
   //-------------------------------------------
   assign rom_addr = {char_addr, row_addr};
   assign font_bit = font_word[~bit_addr];

endmodule

