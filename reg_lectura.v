`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:53:33 05/18/2016 
// Design Name: 
// Module Name:    reg_lectura 
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
module reg_lectura(
count,
//pass_data,
Dir,
//en_contiempoR,
en,
clk,
//c_ad_wr,
data_de_RTC,
data_vga,
//ban_r_vga,
band_z,
reset,
en_dirl,
en_rdl,
 cuenta_dir,
 band_dir_vga
    );


input reset;
input [7:0]count;
//pass_data,
output reg [7:0] Dir;
//output reg c_ad_wr;
//output reg en_contiempoR;
input en;
input [3:0] cuenta_dir;
input clk;
output en_dirl;
output en_rdl;
//output reg c_ad_wr;
input [7:0] data_de_RTC;
output [7:0] data_vga;///reg
//output reg ban_r_vga;
output reg band_z;
output [8:0] band_dir_vga;

reg[7:0] dir;
reg [8:0]posicion_mem;

reg [7:0] d;//registro que guarda lo que manda RTC
reg en_dir;
reg en_rd;

/////////////////////////En esta parte se controla n los tiempos de AD, CS, WR y RD////////////////////
always@(posedge clk)
begin
if(en)begin
		case(count)
			9'd0: begin //FO
				 en_dir <=1'b1;///confihuración de los tiempos para direccionar
				 en_rd <=1'b0;//configuracion de los tiempos para leer
					end
					
					
			9'd24: begin////estado donde no sahce nada
			 en_dir <=1'b0;
				 en_rd<=1'b0;
					end
					
					
					
			9'd44:begin  ///Proceso de lectura
				 en_dir <=1'b0;
				 en_rd<=1'b1;
					end			
			
			
			9'd68: begin
				en_dir <=1'b0;
				 en_rd<=1'b0;
					end
					
					
					///Direccion de memoria a leer
			9'd92: begin
				en_dir <=1'b1;
				 en_rd<=1'b0;
					end
					
			9'd116: begin
				 en_dir <=1'b0;
				 en_rd<=1'b0;
					//data_rtc = 8'b0;
					end



			////lee de direccion de memoria
			9'd140:begin
				en_dir <=1'b0;
				 en_rd<=1'b1;
					end	
					
					
			9'd164: begin
				 en_dir <=1'b0;
				 en_rd<=1'b0;end
				 
				 
				 
			/*				
			9'd188:begin
				en_dir <=1'b1;
				 en_rd<=1'b0;
					end	*/
						
				/*		
			9'd356: begin
			 en_dir <=1'b0;
				 en_wr<=1'b0;
					end
					*/
				
	
			default: begin
				en_dir <=en_dir;
				 en_rd<=en_rd;
					end
	endcase
end
else begin
				
					en_dir <=0;
				 en_rd<=0;
	end 
end


assign en_dirl = en_dir;
assign en_rdl = en_rd;




///////////////////Parte de recepcion del dato que proviene del RTC/////////////
always@(posedge clk)
begin
if (reset)begin band_z = 1'b0; d<= 0;end
else if(en) begin
	if (count >=8'd142 && count <=8'd162)begin
		//band_z = 1'b1; 
		//ban_r_vga=1'b1;
		band_z=1'b1;
		d <= data_de_RTC;
		end
	else
	begin  band_z = 1'b0; 
	//ban_r_vga=1'b0; 
	d<= 0;////d=0; estaba un cero y aun ,mostrabael tiempo y luego cero
	end
end
else 
	begin
	band_z = 1'b0; 
		//ban_r_vga=1'b0; 
	d<= 1'b0;
	end
end	



assign data_vga = d;////dato se va directamente al la VGA



//////////////En esta parte se establecen todas las direcciones donde se leerán////////
always@(posedge clk)
begin
if(en)begin
	case(cuenta_dir)
			4'd0: begin 
					if(count>= 8'd152 && count<=8'd154) begin posicion_mem<= 9'h020; end //segundos
					else if(count>= 8'd70 && count<=8'd97) begin dir<= 8'h21;end
						else begin dir<=dir ; posicion_mem<= 9'h0;end 
						end
						
			4'd1: begin if(count>= 8'd152 && count<=8'd154) begin  posicion_mem<= 9'h010;end //minuto
					else if(count>= 8'd70 && count<=8'd97) begin dir<= 8'h22;end
				else begin dir<= dir; posicion_mem<= 9'h0;end 
				end
				
			4'd2: begin if(count>= 8'd152 && count<=8'd154)begin  posicion_mem<= 9'h008;end 
					else if(count>= 8'd70 && count<=8'd90) begin dir<= 8'h23;end
					else begin dir<= dir; posicion_mem<= 9'h0;end 
					end//hora
					
			4'd3: begin if(count>= 8'd152 && count<=8'd154)begin posicion_mem<= 9'h001;end
					else if(count>= 8'd70 && count<=8'd90)begin dir<= 8'h24; end
				else begin dir<=dir; posicion_mem<= 9'h0;end
				end//dia
				
			4'd4: begin if(count>= 8'd152 && count<=8'd154) begin  posicion_mem<= 9'h002;end 
					else if(count>= 8'd70 && count<=8'd90)begin dir<= 8'h25;end
					else begin dir<= dir; posicion_mem<= 9'h0;end 
					end//mes
					
			4'd5: begin if(count>= 8'd152 && count<=8'd154)begin  posicion_mem<= 9'h004;end 
					else if(count>= 8'd70 && count<=8'd90)begin dir<= 8'h26; end
					else begin dir<= dir; posicion_mem<= 9'h0;end 
					end//año
					
			4'd6: begin if(count>= 8'd152 && count<=8'd154) begin posicion_mem<= 9'h100;end
					else if(count>= 8'd70 && count<=8'd90)begin dir<= 8'h41;end
					else begin dir<= dir; posicion_mem<= 9'h0;end 
					end//timer_seg
					
			4'd7: begin if(count>= 8'd152 && count<=8'd154) begin  posicion_mem<= 9'h080;end
					else if(count>= 8'd70 && count<=8'd90)begin dir<= 8'h42;end
					else begin dir<= dir; posicion_mem<= 9'h0;end 
					end//timer_min
					
			4'd8: begin if(count>= 8'd152 && count<=8'd154) begin posicion_mem<= 9'h040;end 
						else if(count>= 8'd70 && count<=8'd90)begin dir<= 8'h43; end
			 	else begin dir<= dir; posicion_mem<= 9'h0;end 
				end//timer_hora
				
			default: begin  dir<= dir; posicion_mem<=posicion_mem;end
			endcase
	end
	//else if(count==8'd115)begin dir<=8'h0; posicion_mem<=9'h0; end
else begin dir<= 8'h0; posicion_mem<=9'h0;end
end
	
assign band_dir_vga = posicion_mem; //////Bandera que va a la VGA






////////////////////////////En esta parte se establecen las configuraciones para recibir el dato//////////////////////
always@(posedge clk)
begin
if(en)begin
		case(count)
		////transferencia//////
			8'd2:	 begin	Dir<=8'b11110000;
								//cuenta_dir <= cuenta_dir;
								end
			
			8'd24: 	begin Dir<= 8'b0; 
								//cuenta_dir<=cuenta_dir; 
					end//dato durara 20 ns mas
								
			////proceso de lectura////		
			8'd46: 	begin Dir<=8'hdd; 
						//cuenta_dir=cuenta_dir; 
						end						//
			
			8'd68: begin Dir<=8'b0; 
						//cuenta_dir=cuenta_dir; 
						end 
					
					
					//////direcciona/////
			8'd94: begin  
			
				Dir<=dir; 
				
				end//direccion_segundos
					
					
					
					//////lee de direccion///////
			8'd116: begin Dir<=8'b0; 
			//cuenta_dir=cuenta_dir; 
			end//20 ns mas
			
			
			8'd142: begin Dir<=data_de_RTC;
					//cuenta_dir=cuenta_dir;
						end//cambio
			
			
			8'd164: begin Dir<=8'b0; 
					//cuenta_dir=cuenta_dir; 
						end
			
			
						
			default: begin Dir <= Dir;  
								//cuenta_dir<= cuenta_dir;
								end
	endcase

end
	else Dir <= 8'b0;
		//	cuenta_dir<=0;
	
	
end

endmodule
