`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:48:36 05/19/2016 
// Design Name: 
// Module Name:    Tiempos_lectura 
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
module Tiempos_lectura(
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
reg [4:0]q_actADR;
reg [4:0]q_nextADR;
//reg [4:0]q_actAD1;
reg [4:0] ad_act;
reg [4:0] ad_next;
reg [4:0] ad_actr;
reg [4:0] ad_nextr;
//reg [4:0]q_nextAD1;

always@(posedge clkW,posedge resetAD) begin
	if(resetAD) begin
		q_actAD <= 5'b0;
		ad_act <= 5'b0;
		q_actADR <=5'b0;
		ad_actr <=5'b0;
//		q_actAD1 <= 5'b0;

		end
	else  begin
		ad_act <= ad_next;
		q_actAD <= q_nextAD;
		q_actADR <=q_nextADR;
		ad_actr <=ad_nextr;
	//	q_actAD1 <= q_nextAD1;

		end
	end
		
		
always@*
begin
	if(enW) begin
			if(c_ad==1)begin //Indica que AD en bajo para direccionar
				if(ad_actr <=5'd21) begin
						ad_nextr <= ad_actr  + 5'b1;
					if (ad_actr  <= 5'd18) begin
						AD <= 1'b0;end
						
					else 	AD <= 1'b1;
				end
					else 	AD <= 1'b1;ad_nextr <=5'b0; 
			end
			else begin
						AD <= 1'b1;
						 ad_nextr <=5'b0;
			end
				
			
		end
	else begin 	AD <= 1'b1; ad_nextr <=5'b0; end
end

always@*
begin
	if(enW) begin
	if(c_ad==0) begin//conf_lectura	
		q_nextADR <= q_actADR + 5'b1;
		if (q_actADR >=5'd3 && q_actADR<=5'd16) begin
					RD<= 1'b0;end
		else 	RD <= 1'b1; 
	end
	else 	begin 
		q_nextADR <=0;
	RD <= 1'b1;
	end  //q_nextADR<=5'b0; 
	
	end
	else begin	
			RD <= 1'b1; q_nextADR<=5'b0; end

end


always@*
begin
	if(enW)
	if(c_ad==1)begin
		if(q_actAD <=5'd21) begin
			q_nextAD = q_actAD + 1'b1;
				if (q_actAD >= 5'd2 && q_actAD <= 5'd17 ) begin
					CS<= 1'b0; end	
				else
					CS<= 1'b1; 
			end
		else begin q_nextAD = 5'b0; CS<= 1'b1;end
	end
		
	else begin
				if(q_actAD <=5'd21) begin
			q_nextAD = q_actAD + 1'b1;
				if (q_actAD >= 5'd2 && q_actAD <= 5'd17 ) begin
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
	if(enW)begin
		if(c_ad==1)begin //Concdir._ad=1 se encuentra en modo de direccion
			if(ad_act <=5'd21) begin
			ad_next <= ad_act + 1'b1;
				if (ad_act >=5'd3 && ad_act <=5'd16) begin
					WR<= 1'b0; 
				end
				else 	WR<= 1'b1;
			end
			else begin WR<= 1'b1; ad_next <= 5'b0; end 
		end
		else begin 
			WR<= 1'b1;
			ad_next <= 5'b0;end
			
	end
else begin ad_next <= 5'b0;	WR <= 1'b1;end
end

endmodule

