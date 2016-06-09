`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:43:38 05/11/2016 
// Design Name: 
// Module Name:    FSM_GENERAL_ESCRITURA 
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
module FSM_GENERAL_ESCRITURA(
clock , // Clock
reset , // Active high reset
//Buttom_UP , // Active high request from agent 0
//Buttom_RIGHT , // Active high request from agent 2
//Buttom_LEFT ,
//Buttom_DOWN ,
En,
 band_fin,
B_C,
In,
en_progra
//Band,
//formato,
//set_hora,
//set_fecha,
//set_timer,
//Control_timeDir
);
                                                                                           
input clock ; // Clock
input En;	//Este permititrá habilitar todala máquina de estados!! 
//output reg Control_timeDir;
input reset ;
input  band_fin;
input B_C;//Boton de programacion
output reg In;
output reg en_progra;

//************ ESTADOS **************//

parameter  [2:0]  Espera  = 		3'b000;
parameter  [2:0]  Set_time	  = 	   3'b001;
parameter  [2:0]  Programa	  = 		3'b010;
//parameter  [2:0]  Timer  = 		3'b011;

reg [2:0] state, next_state;


always @ (state or En or B_C or band_fin)
begin  
				if (En) begin
				  next_state = 0;
				  
				  case(state)
					 Espera : 
						if (En== 1'b1) begin//switch
						  next_state= Set_time;
						  end 
					else begin
							next_state = Espera;end
				
					Set_time:		
					  if ( B_C== 1'b1) begin
						  next_state = Programa;
							  end 
						else
							next_state = Set_time;//WR
							
					Programa:		
					  if (band_fin == 1'b1) begin
						  next_state = Espera;
							  end 
						else
							next_state =Programa;//WR
						
							
						default:  next_state = Espera;
					endcase
				end
			else next_state = Espera;
end
		
always @ (posedge clock)
			begin : OUTPUT_LOGIC
			  if (reset) begin
				In <=1'b0;
				en_progra<=1'b0;
		
			  end 
			  else begin
				 state <=  next_state;
				 case(state)
				Espera : begin
							  In <=1'b0;
							  en_progra  <=1'b0;
							  
						 end
		
								
				Set_time : begin
								 en_progra  <=1'b0;
								 In <=1'b1;
								//  state <= Inicio;

								end
								
				Programa : begin
								   In <=1'b0;
									 en_progra  <=1'b1;
								  end 
								  
				  default : begin
								     In <=1'b0;
									 en_progra  <=1'b0;
								end
				 endcase
			  end
end		




endmodule 

