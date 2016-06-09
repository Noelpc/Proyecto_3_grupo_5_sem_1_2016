`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:05:37 06/04/2016 
// Design Name: 
// Module Name:    Control_tiempos 
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
module Control_tiempos(
input en_dir,
input en_wr,
input en_rd,
input clk,
input rst,
output C_AD,
output C_CS,
output C_RD,
output C_WR
);

wire [4:0]count;

contador_control_tiempos Cuenta(
    .En_dir(en_dir), 
	 .En_rd(en_rd),
	 .En_wr(en_wr),
    .clk(clk), 
    .rst(rst), 
    .salida(count)
    );

reg AD;
reg CS;
reg RD;
reg WR;


always@(posedge clk)
begin
if(rst)begin
		AD <= 1'b0;
		CS <= 1'b0;
		RD <= 1'b0;
		WR <= 1'b0;end
	else if(en_dir)begin
		case(count)
		5'd0: begin 
		AD <= 1'b0;
		CS <= 1'b1;
		RD <= 1'b1;
		WR <= 1'b1;
			end
							
		5'd1: begin 
		AD <= 1'b0;
		CS <= 1'b1;
		RD<= 1'b1;
		WR <= 1'b1;					
			end	

							
		5'd2: begin 
		AD <= 1'b0;
		CS <= 1'b0;
		RD<= 1'b1;
		WR <= 1'b0;					
			end	
							
		5'd3: begin 
		AD <= 1'b0;
		CS <= 1'b0;
		RD<= 1'b1;
		WR <= 1'b0;	
		end	


									
		5'd20: begin 
		AD <= 1'b0;
		CS <= 1'b0;
		RD<= 1'b1;
		WR <= 1'b0;		
			end
			
			
										
		5'd21: begin 
		AD <= 1'b1;
		CS <= 1'b1;
		RD<= 1'b1;
		WR <= 1'b1;		
			end
			
	default: begin AD <= AD;
				CS <= CS;
				RD<= RD;
				WR <= WR;end	
	endcase
end
/////////////////////////////Escritura////////////////////////////7	
else if(en_wr)begin
		case(count)
		5'd0: begin 
		AD <= 1'b1;
		CS <= 1'b1;
		RD <= 1'b1;
		WR <= 1'b1;
			end
							
		5'd1: begin 

		AD <= 1'b1;
		CS <= 1'b1;
		RD<= 1'b1;
		WR <= 1'b1;					
			end	

							
		5'd2: begin 

		AD <= 1'b1;
		CS <= 1'b0;
		RD<= 1'b1;
		WR <= 1'b0;					
			end	
							
		5'd3: begin 
		AD <= 1'b1;
		CS <= 1'b0;
		RD<= 1'b1;
		WR <= 1'b0;					
			end	
										
		5'd20: begin 
		AD <= 1'b1;
		CS <= 1'b0;
		RD<= 1'b1;
		WR <= 1'b0;		
			end
			
			
										
		5'd21: begin 
		AD <= 1'b1;
		CS <= 1'b1;
		RD<= 1'b1;
		WR <= 1'b1;	end
		
	default:begin
		AD <= AD;
		CS <= CS;
		RD<= RD;
		WR <= WR;
		end
	
		endcase 
	end
	
////////////////////////////lectura///////////////////////////////
	
else if(en_rd)begin
		case(count)
		5'd0: begin 
		AD <= 1'b1;
		CS <= 1'b1;
		RD <= 1'b1;
		WR <= 1'b1;
			end
							
		5'd1: begin 

		AD <= 1'b1;
		CS <= 1'b1;
		RD<= 1'b1;
		WR <= 1'b1;					
			end	

							
		5'd2: begin 

		AD <= 1'b1;
		CS <= 1'b0;
		RD<= 1'b0;
		WR <= 1'b1;					
			end	
							
		5'd3: begin 
		AD <= 1'b1;
		CS <= 1'b0;
		RD<= 1'b0;
		WR <= 1'b1;end


		5'd20: begin 
		AD <= 1'b1;
		CS <= 1'b0;
		RD<= 1'b0;
		WR <= 1'b1;		
			end
			
			
										
		5'd21: begin 
		AD <= 1'b1;
		CS <= 1'b1;
		RD<= 1'b1;
		WR <= 1'b1;	
		
			end	
	default: begin
		AD <= AD;
		CS <= CS;
		RD<= RD;
		WR <= WR;end
	endcase
end
	
	
else begin
		AD <= 1'b1;
		CS <= 1'b1;
		RD<= 1'b1;
		WR <= 1'b1;
		end
end

//////////////////////////////////////////////////////////




assign C_AD = AD;
assign C_CS = CS;	
assign C_RD = RD;
assign C_WR = WR;
	
	
endmodule
