
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:05:09 04/09/2016 
// Design Name: 
// Module Name:    Tiempo_escrituravb 
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
module Tiempo_escrituravb(
		input wire clkW,
		input wire enW,
		input resetAD,
		input c_ad,
		output reg CS,
		output reg RD,
		output reg WR,
		output reg AD
		
		
    );

reg [4:0]q_actAD;
reg [4:0]q_nextAD;
//reg [4:0]q_actAD1;
reg [4:0] ad_act;
reg [4:0] ad_next;
//reg [4:0]q_nextAD1;

always@(posedge clkW,posedge resetAD) begin
	if(resetAD) begin
		q_actAD <= 5'b0;
		ad_act <= 5'b0;
//		q_actAD1 <= 5'b0;

		end
	else  begin
		ad_act <= ad_next;
		q_actAD <= q_nextAD;
	//	q_actAD1 <= q_nextAD1;

		end
	end
		
		
always@*
begin
	if(enW) begin
			if(c_ad==1)begin //Indica que AD en bajo para direccionar
					if(ad_act <=5'd21) begin
						ad_next = ad_act  + 1'b1;
						if (ad_act  <= 5'd18) begin
						
							AD <= 1'b1;end
							
						else 	AD <= 1'b0; 
					end
					else 		ad_next = 5'b0;	AD <= 1'b0; 
			end
			else begin
				if(ad_act  <=5'd21) begin
					ad_next = ad_act  + 1'b1;
					if (ad_act  <= 5'd18) begin
						AD <= 1'b0;end
					else 	AD <= 1'b0;
				end
					else 		ad_next = 5'b0;	AD <= 1'b1; 
			end
		end
	else begin ad_next = 5'b0;	AD <= 1'b1;end
end

always@*
begin
	if(enW) begin
		if(q_actAD <= 5'd21) begin
			q_nextAD = q_actAD + 1'b1;
			if (q_actAD <= 5'd19) begin
				RD<= 1'b0;end
			else 	RD <= 1'b1; 
		end
		else 		q_nextAD = 5'b0; RD <= 1'b1;
	end
	else begin q_nextAD = 5'b0;	
			RD <= 1'b1;end
end


always@*
begin
		if(enW)
		begin 
		if(q_actAD <=5'd21) begin
			q_nextAD = q_actAD + 1'b1;
				if (q_actAD >= 5'd2 && q_actAD <= 5'd16 ) begin
					CS<= 1'b0; end	
				else
					CS<= 1'b1; 
			end
		else begin q_nextAD = 5'b0; CS<= 1'b1;end
	end
	else begin q_nextAD = 5'b0; 	CS <= 1'b1; end
end

always@*
begin
	if(enW)
		begin 
		if(q_actAD <=5'd21) begin
			q_nextAD = q_actAD + 1'b1;
				if (q_actAD >=5'd3 && q_actAD <=5'd16) begin
					WR<= 1'b0; 
				end
				else 	WR<= 1'b1;
			end
			else begin q_nextAD = 5'b0;WR<= 1'b1; end  //caMbio 0 por 1
	end
	else begin q_nextAD = 5'b0;	WR <= 1'b1;end
end
/*
always@*
begin
		if(enW)
		begin 
		if(q_actAD1 <=5'd21) begin
				q_nextAD1 = q_actAD1 + 1'b1;
				if (q_actAD1 >= 4'd9) begin
					data<= 1'b1; 
				end
				else 	begin data<= 1'b0;end
			end
		else
		begin q_nextAD1 = 0; data<= 1'b0;end
	end
	else begin  q_nextAD1 = 0; 	data <= 1'b0; end
end
*/
endmodule

