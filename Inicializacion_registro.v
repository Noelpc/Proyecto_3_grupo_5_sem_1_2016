// Engineer: 
// 
// Create Date:    05:11:32 05/12/2016 
// Design Name: 
// Module Name:    Inicializacion_registro 
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
module Inicializacion_registro(
count,
//pass_data,
data_rtcI,
//c_adI,
//en_contiempoI,
en,
en_dirI,
en_wrI,
clk
//reset
    );

input [8:0] count;
//input pass_data;//señal que permite pasar el dato en el tiempo correcto
//input reset;
//input EnR,
output en_dirI;
output en_wrI;
input en;
input clk;
output  [7:0] data_rtcI;
/*
output  c_adI;//cambio de ad
output  en_contiempoI;//

reg en_contiempo;
reg  c_ad;
*/
reg [7:0] data_rtc;

//reg [7:0] d;
reg en_dir;
reg en_wr;
always@(posedge clk)
begin
if(en)begin
		case(count)
			9'd0: begin //BIT INICIO
				 en_dir <=1'b1;
				 en_wr<=1'b0;
					end
					
					
			9'd24: begin
			 en_dir <=1'b0;
				 en_wr<=1'b0;
					end
					
					
					
			9'd44:begin  ///escribe
					//en_contiempo <= 1'b1;
				 en_dir <=1'b0;
				 en_wr<=1'b1;
					//	data_rtc = 8'b00001000;end //escribe 1 en direccion
					//else begin data_rtc = 8'h0;end
					end			
			
			
			9'd68: begin
				en_dir <=1'b0;
				 en_wr<=1'b0;
					end
					
			9'd92: begin
				en_dir <=1'b1;
				 en_wr<=1'b0;
					//configuracion para WR
					//if(pass_data) begin
						//data_rtc = 8'b0;end//escribe 0 en direccion
					//else begin data_rtc = 8'h0;end
					end
					
			9'd116: begin
				 en_dir <=1'b0;
				 en_wr<=1'b0;
					//data_rtc = 8'b0;
					end




			9'd140:begin
				en_dir <=1'b0;
				 en_wr<=1'b1;
					end	
					
			9'd164: begin
				 en_dir <=1'b0;
				 en_wr<=1'b0;end
							
			9'd188:begin
				en_dir <=1'b1;
				 en_wr<=1'b0;
					end	
						
			9'd212: begin
				en_dir <=1'b0;
				 en_wr<=1'b0;
				end
			
						
			9'd236:begin
				 en_dir <=1'b0;
				 en_wr<=1'b1;
			
					end
						//DIR TURNING	
			9'd260: begin
				en_dir <=1'b0;
				 en_wr<=1'b0;
					end
			
			9'd284:begin
				 en_dir <=1'b1;
				 en_wr<=1'b0;
						end
				
			9'd308: begin
				en_dir <=1'b0;
				 en_wr<=1'b0;
					end
					
			9'd332: begin
			 en_dir <=1'b0;
				 en_wr<=1'b1;end
				 
					
			9'd356: begin
			 en_dir <=1'b0;
				 en_wr<=1'b0;
					end
					
					
				
		
		/*			
		9'd300: begin
			en_contiempo <= 1'b1;
			c_ad <= 1'b1;end
			
		9'd320: begin
			en_contiempo <= 1'b0;
			c_ad <= 1'b0;
					end
					
		9'd340: begin
			en_contiempo <= 1'b1;
			c_ad <= 1'b0; end					
					
		
		9'd360: begin
		en_contiempo <= 1'b0;
			c_ad <= 1'b0;end
		*/	
			default: begin
				en_dir <=en_dir;
				 en_wr<=en_wr;
					end
	endcase
end

else begin
	en_dir <=1'b0;
	en_wr<=1'b0;
	end 
end

assign   en_dirI = en_dir;
assign	en_wrI= en_wr;
		


always@(posedge clk)
begin
if(en)begin
		case(count)
		9'd2: data_rtc <= 8'b00000010;//Bit_inicio
					
					
		9'd24: data_rtc <= 8'b0;
					
					
					
		9'd46: data_rtc <= 8'b00010000; //	
			
			
		9'd68: data_rtc <=8'b0;
					
					
		9'd94:  data_rtc <= 8'b00000010;//Bit_inicio
					
		9'd116: 	data_rtc <= 8'b0;

 		9'd142: 	data_rtc <= 8'b0;///escribe cero
		
		9'd164: 	data_rtc <= 8'b0;
							
		9'd190: data_rtc <= 8'b00010000;//DIR DIGITAL TRIMING
		
		9'd212: data_rtc <= 8'b0;
		
		9'd238: data_rtc <= 8'b11010010;
			
			
						
		9'd260: data_rtc <= 8'b0;
			//DIR TURNING	
			
		9'd286: data_rtc <= 8'b0;
		
		9'd308: data_rtc <= 8'b0;
		
		9'd334: data_rtc <= 8'b00010000;
		
		
		9'd356: data_rtc <= 8'b00000000;
		
		
		/*
					
		9'd308: 
						
				9'd212: 
			
						
			9'd225:
			
			
			9'd242: data_rtc <= 8'b1;//nada
			
			
			9'd263: data_rtc <= 8'b0;
			
			9'd278: data_rtc <= 8'b0;
			
			
			
			
				
			
	
			
				
	
			9'd164: data_rtc <= 8'b1;
			
							
			9'd153: data_rtc <= 8'b00010000;//DIR DIGITAL TRIMING
						
						
			9'd169: data_rtc <= 8'b0;
			
			9'd188:  data_rtc <= 8'b11010010;
			
			9'd212: data_rtc <= 8'b1;
			
						
			9'd225: data_rtc <= 8'b0;
			
			
			9'd242: data_rtc <= 8'b1;//nada
			
			
			9'd263: data_rtc <= 8'b0;
			
			9'd278: data_rtc <= 8'b0;*/
			
			/*
			9'd300:data_rtc <= 8'b11110000;
			
			9'd316: data_rtc <= 8'b0;
			
						
			9'd335: data_rtc <= 8'b0;//////cambio
			
			
			9'd350: data_rtc <= 8'b0;
			
			
		*/

			
			
		//DIR TURNING						
			//8'd184:begin
					//	data_rtc =8'h0 ;
			
				//	end
					
			//8'd206: begin
				//	data_rtc =8'b0;end
			
			//8'd221:begin
				//		data_rtc =8'h0 ;end 
					
			//8'd243: begin
				//	data_rtc = 8'h0;
					
					//end
						
			default: begin data_rtc <= data_rtc;end
	endcase

end
	else data_rtc <= 0;
	
end

assign data_rtcI = data_rtc;
endmodule
