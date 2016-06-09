`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:40:02 05/24/2016 
// Design Name: 
// Module Name:    Ctrl_Interface 
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
module Ctrl_Interface(
    input wire clk,
    input wire reset,
	 input wire write_strobe,
    input wire [7:0] port_id,
    output wire sel_rtc_pb,
    output wire [8:0] flag_pointer,
    output wire [8:0] en_reg_pb
    );

reg [8:0] flag_pointer_next, en_reg_pb_next;
reg sel_rtc_pb_next;

//--------------------------------------------------------------------
/*write_gen Write_Gen (
    .inp(write_strobe), 
    .clk(clk), 
    .write(Write)
    );*/
//--------------------------------------------------------------------

always @(posedge clk)
begin
   if (reset)
		begin
		sel_rtc_pb_next <= 1'b0;
      flag_pointer_next <= 9'b000000000;
		en_reg_pb_next <= 9'b000000000;
		end
   else
		begin
      case (port_id)
			8'h00:begin
					if (write_strobe) begin
							sel_rtc_pb_next <= 1'b0;
							flag_pointer_next <= 9'h000;
							en_reg_pb_next <= 9'h000;
							end
					else	begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= en_reg_pb_next;
							end
					end
			8'h01:begin
					if (write_strobe) begin
							sel_rtc_pb_next <= 1'b1;//sel_rtc_pb_next <= 1'b0;
							flag_pointer_next <= 9'h001;
							en_reg_pb_next <= 9'h000;
							end
					else	begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= en_reg_pb_next;
							end
					end
			8'h02:begin
					if (write_strobe) begin
							sel_rtc_pb_next <= sel_rtc_pb_next;//sel_rtc_pb_next <= 1'b0;
							flag_pointer_next <= 9'h002;
							en_reg_pb_next <= 9'h000;
							end
					else	begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= en_reg_pb_next;
							end
					end
			8'h03:begin
					if (write_strobe) begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= 9'h004;
							en_reg_pb_next <= 9'h000;
							end
					else	begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= en_reg_pb_next;
							end
					end
			8'h04:begin
					if (write_strobe) begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= 9'h008;
							en_reg_pb_next <= 9'h000;
							end
					else	begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= en_reg_pb_next;
							end
					end
			8'h05:begin
					if (write_strobe) begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= 9'h010;
							en_reg_pb_next <= 9'h000;
							end
					else	begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= en_reg_pb_next;
							end
					end
			8'h06:begin
					if (write_strobe) begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= 9'h020;
							en_reg_pb_next <= 9'h000;
							end
					else	begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= en_reg_pb_next;
							end
					end
			8'h07:begin
					if (write_strobe) begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= 9'h040;
							en_reg_pb_next <= 9'h000;
							end
					else	begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= en_reg_pb_next;
							end
					end
			8'h08:begin
					if (write_strobe) begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= 9'h080;
							en_reg_pb_next <= 9'h000;
							end
					else	begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= en_reg_pb_next;
							end
					end
			8'h09:begin
					if (write_strobe) begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= 9'h100;
							en_reg_pb_next <= 9'h000;
							end
					else	begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= en_reg_pb_next;
							end
					end
			8'h0a:begin
					if (write_strobe) begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= 9'h001;
							end
					else	begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= en_reg_pb_next;
							end
					end
			8'h0b:begin
					if (write_strobe) begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= 9'h002;
							end
					else	begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= en_reg_pb_next;
							end
					end
			8'h0c:begin
					if (write_strobe) begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= 9'h004;
							end
					else	begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= en_reg_pb_next;
							end
					end
			8'h0d:begin
					if (write_strobe) begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= 9'h008;
							end
					else	begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= en_reg_pb_next;
							end
					end
			8'h0e:begin
					if (write_strobe) begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= 9'h010;
							end
					else	begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= en_reg_pb_next;
							end
					end
			8'h0f:begin
					if (write_strobe) begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= 9'h020;
							end
					else	begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= en_reg_pb_next;
							end
					end
			8'h10:begin
					if (write_strobe) begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= 9'h040;
							end
					else	begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= en_reg_pb_next;
							end
					end
			8'h11:begin
					if (write_strobe) begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= 9'h080;
							end
					else	begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= en_reg_pb_next;
							end
					end
			8'h12:begin
					if (write_strobe) begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= 9'h100;
							end
					else	begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= en_reg_pb_next;
							end
					end
			default:begin
					if (write_strobe) begin										//Prueba, si no funciona se debe cambiar el if por lo que hay en el else
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= en_reg_pb_next;
							end
					else	begin
							sel_rtc_pb_next <= sel_rtc_pb_next;
							flag_pointer_next <= flag_pointer_next;
							en_reg_pb_next <= 9'h000;
							end
					end
      endcase
		end
end

assign flag_pointer = flag_pointer_next;
assign en_reg_pb = en_reg_pb_next;
assign sel_rtc_pb = sel_rtc_pb_next;

endmodule
