`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:42:16 04/10/2016 
// Design Name: 
// Module Name:    FSM_GENERAL 
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

module FSM_GENERAL(
Iniciar, //Dará inicio al sistema
Inicio_Lectura,
Inicio_Escritura,
CLK,
BandFin,
Bandfin_wr,
reset,
Buttom_SW,
inicializacion
);
//input En; ///se puso un enable
input Iniciar;
input Buttom_SW;
input Bandfin_wr;
input BandFin;//Estara dada por el 
input CLK;
input reset;
output reg Inicio_Lectura;
output reg Inicio_Escritura;
//output reg Sel_Hora;//Habilitacion para contador de formato 12 o 24
output reg inicializacion; 


// Internal Variables
parameter  [2:0]   Inicio =  3'b000;
parameter [2:0] Inicializacion= 3'b0001;
parameter  [2:0]  Decide  =  3'b010;
parameter  [2:0]  ESCRITURA =3'b011;
parameter  [2:0]  LECTURA  =  3'b100;
reg [2:0] state, next_state;
reg c;

/*
always(posedge clk)begin
if(Buttom_SW == 1'b0 && Bandfin_wr==1) begin 
c=c+1;end if(c==20) 
end


*/
always @ (state or  Iniciar or Buttom_SW or BandFin or Bandfin_wr)//Buttom_RIGHT  or Buttom_LEFT  or BandFin or UP or DOWN)
begin  
  next_state = 0;
  if(Iniciar) begin
		  case(state)
			 Inicio : 
			 if (Iniciar == 1'b1) begin //coreccion de estado siguiente
				  next_state = Inicializacion;
					  end else begin
				  next_state= Inicio; end
				  
				  			
			 Inicializacion : 
						if (BandFin == 1'b1 ) begin
						  next_state = Decide;
							  end 
						else begin
						  next_state = Inicializacion; end
						
				Decide:  
						if (Buttom_SW == 1'b0) begin
								next_state = LECTURA;end
											
						else if(Buttom_SW == 1'b1) begin
										next_state = ESCRITURA; end 
						else 
								next_state = Decide;
			
						
				ESCRITURA:
							if(Buttom_SW == 1'b0 && Bandfin_wr==1) begin
								next_state = LECTURA;end//CAMBIO DE DECIDE
								
							else begin next_state = ESCRITURA;end
								
								
				LECTURA: 
							if(Buttom_SW == 1'b1 && Bandfin_wr==0) begin
								next_state = ESCRITURA; end
										
							else begin
								next_state = LECTURA; end
							
			default : next_state = Inicio; 
		  endcase 
		end
	else  next_state = Inicio; 
		
end
always @ (posedge CLK)
			begin : OUTPUT_LOGIC
			  if (reset) begin
				Inicio_Lectura <=1'b0;
				Inicio_Escritura <=1'b0;
				inicializacion <=1'b0;
			  end 
			  else begin
				 state <=  next_state;
				 case(state)
				Inicio : begin
							  inicializacion<=1'b0;//INICIALIZACION 
							   Inicio_Escritura <=1'b0;
								  	 Inicio_Lectura<=1'b0;	
									 
							end
				Inicializacion: begin
								inicializacion<=1'b1;//INICIALIZACION 
							   Inicio_Escritura <=1'b0;
								  	Inicio_Lectura<=1'b0;end	
					
								
				ESCRITURA : begin
								  Inicio_Escritura <=1'b1;///probando con 0 y lectura 1
								  	 Inicio_Lectura<=1'b0;							  
									inicializacion<=1'b0;
								  //state <= Inicio;

								end
								
				LECTURA : begin
									Inicio_Escritura <=1'b0;////probando con 1
								  	 Inicio_Lectura<=1'b1;							  
									inicializacion<=1'b0;
								  end
								  
				  default : begin
								 Inicio_Escritura <=1'b0;//
								  	 Inicio_Lectura<=1'b0;							  
									inicializacion<=1'b0;
								end
				 endcase
			  end
end

endmodule
