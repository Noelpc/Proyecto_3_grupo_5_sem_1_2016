`timescale 1ns / 1ps

module Main (
		output wire [7:0] rgb,
		input wire clk_i, clr,
		output wire hsync, vsync,
		input wire [71:0] info,
		input wire [8:0] Pointer
	);

	wire [9:0] pixel_x, pixel_y;
	wire clk1;

	parameter XxY = 10'd999;	//overall there are 999 pixels
	parameter sizeX = 9'd27;
	parameter sizeY = 9'd37;
	parameter sizeYPointer = 9'd15;
	parameter sizeTitlesX = 9'd189;

	//reg	[47:0] info; // ESTO SOLO ESTA SIMULANDO EL DATO ENTRANTE DESDE EL RTC->LUEGO SE DEBE CONECTAR COMO INPUT
	
	parameter	hora1_X = 210; // PARAMETROS QUE DEFINEN POSICIONES DE LOS DIGITOS
	parameter	hora2_X = 237; // UNIDADES DE LA HORA
	parameter	min1_X = 291; // DECENAS DE LOS MINUTOS
	parameter	min2_X = 318; // UNIDADES DE LOS MINUTOS
	parameter	seg1_X = 372; // ETC ETC ETC
	parameter	seg2_X = 399;
	parameter   c_hora1_X = 450;
	parameter   c_hora2_X = 477;
	parameter   c_min1_X = 531;
	parameter   c_min2_X = 558;
	parameter   c_seg1_X = 612;
	parameter   c_seg2_X = 639;
	parameter	dia1_X = 245;
	parameter	dia2_X = 272;
	parameter	mes1_X = 326;
	parameter	mes2_X = 353;
	parameter	ano1_X = 407;
	parameter	ano2_X = 434;
	// POSICIONES EN Y
	parameter	horatitulo_Y = 50;
	parameter	fechatitulo_Y = 300;
	parameter	hora_Y = 100;	// POSICION DE HORA, MINUTO, SEGUNDO EN Y
	parameter	fecha_Y= 350;	// POSICION DE DIA MES AÑO EN Y

	wire 			[31:0] STATE;	// PUNTEROS A LOS REGISTROS EN LOS QUE SE CARGARON LAS IMAGENES (POR EJEMPLO: CERO_DATA)
	wire			[31:0] STATE1;
	wire			[31:0] STATE2; ////eran de 10-0
	wire			[31:0] STATE3;
	wire 			[31:0] STATE4;
	wire			[31:0] STATE5;
	wire 			[31:0] STATE6;
	wire			[31:0] STATE7;
	wire 			[31:0] STATE8;
	wire			[31:0] STATE9;
	wire 			[31:0] STATE10;
	wire			[31:0] STATE11;
	wire			[31:0] STATE12;
	wire			[31:0] STATE13;
	wire			[31:0] STATE14;
	wire			[31:0] STATE15;
	wire			[31:0] STATE16;
	wire			[31:0] STATE17;
	reg			[31:0] STATEPOINTER;
	wire			[31:0] STATEFECHA;
	wire 			[31:0] STATEHORA;
	wire			[31:0] STATECRONOMETRO;

	reg 	[7:0] CERO_DATA [0:XxY-1];	// REGISTRO DONDE CARGO Y ALMACENO MI IMAGEN, AUN NO SE LE CARGA NADA
	reg 	[7:0] UNO_DATA [0:XxY-1];
	reg 	[7:0] DOS_DATA [0:XxY-1];
	reg 	[7:0] TRES_DATA [0:XxY-1];
	reg 	[7:0] CUATRO_DATA [0:XxY-1];
	reg 	[7:0] CINCO_DATA [0:XxY-1];
	reg 	[7:0] SEIS_DATA [0:XxY-1];
	reg 	[7:0] SIETE_DATA [0:XxY-1];
	reg 	[7:0] OCHO_DATA [0:XxY-1];
	reg 	[7:0] NUEVE_DATA [0:XxY-1];
	reg 	[7:0] POINTER_DATA [0:XxY-1];
	reg 	[7:0] FECHA_DATA [0:XxY-1];
	reg 	[7:0] HORA_DATA [0:XxY-1];
	reg 	[7:0] CRONOMETRO_DATA [0:XxY-1];

	reg	[7:0] rg;// registro máscara de la salida de rgb

	initial begin
			$readmemh ("uno.list"	, UNO_DATA);//Lee la imagen en hexadecimal
			$readmemh ("dos.list"	, DOS_DATA);	// AQUI CARGAMOS LOS REGISTROS CON LAS IMAGENES CORRESPONDIENTES
			$readmemh ("tres.list"	, TRES_DATA);
			$readmemh ("cuatro.list", CUATRO_DATA);
			$readmemh ("cinco.list"	, CINCO_DATA);
			$readmemh ("seis.list"	, SEIS_DATA);
			$readmemh ("siete.list"	, SIETE_DATA);
			$readmemh ("ocho.list"	, OCHO_DATA);
			$readmemh ("nueve.list"	, NUEVE_DATA);
			$readmemh ("cero.list"	, CERO_DATA);
			$readmemh ("pointer.list"	, POINTER_DATA);
			$readmemh ("fecha.list"	, FECHA_DATA);
			$readmemh ("hora.list"	, HORA_DATA);
			$readmemh ("cronometro.list"	, CRONOMETRO_DATA);
	end
	
		
	//always@*begin
	//info = 48'h987654321016;	// DATO INVENTADO PARA VER LA PRUEBA. ESTE DATO INDICA QUE 
	//end										// HORA 93/MINUTO 76/SEGUNDO 54/DIA 32/MES 10/AÑO 16

	//LA PICHUDEZ//assign STATE = (pixel_x  - X) /*+ XxY*/ * (pixel_y - Y);//	IGNORAR ;D
	assign STATE  = (pixel_x - hora1_X) * sizeY + pixel_y - hora_Y;	// ASIGNA LA DIRECCIÓN QUE LEERA DE CADA REGISTRO DE IMAGEN
	assign STATE1 = (pixel_x - hora2_X) * sizeY + pixel_y - hora_Y;	// NOTESE QUE VARIA SEGUN LA POSICION DE PANTALLA SOBRE LA
	assign STATE2 = (pixel_x - min1_X) * sizeY + pixel_y - hora_Y;		// QUE SE ENCUENTRE
	assign STATE3 = (pixel_x - min2_X) * sizeY + pixel_y - hora_Y;
	assign STATE4 = (pixel_x - seg1_X) * sizeY + pixel_y - hora_Y;
	assign STATE5 = (pixel_x - seg2_X) * sizeY + pixel_y - hora_Y;
	assign STATE6 = (pixel_x - dia1_X) * sizeY + pixel_y - fecha_Y;
	assign STATE7 = (pixel_x - dia2_X) * sizeY + pixel_y - fecha_Y;
	assign STATE8 = (pixel_x - mes1_X) * sizeY + pixel_y - fecha_Y;
	assign STATE9 = (pixel_x - mes2_X) * sizeY + pixel_y - fecha_Y;
	assign STATE10= (pixel_x - ano1_X) * sizeY + pixel_y - fecha_Y;
	assign STATE11= (pixel_x - ano2_X) * sizeY + pixel_y - fecha_Y;
	assign STATE12= (pixel_x - c_hora1_X) * sizeY + pixel_y - hora_Y;
	assign STATE13= (pixel_x - c_hora2_X) * sizeY + pixel_y - hora_Y;
	assign STATE14= (pixel_x - c_min1_X) * sizeY + pixel_y - hora_Y;
	assign STATE15= (pixel_x - c_min2_X) * sizeY + pixel_y - hora_Y;
	assign STATE16= (pixel_x - c_seg1_X) * sizeY + pixel_y - hora_Y;
	assign STATE17= (pixel_x - c_seg2_X) * sizeY + pixel_y - hora_Y;
	assign STATEFECHA= (pixel_x - dia1_X) * sizeY + pixel_y - fechatitulo_Y;
	assign STATEHORA= (pixel_x - hora1_X) * sizeY + pixel_y - horatitulo_Y;
	assign STATECRONOMETRO= (pixel_x - c_hora1_X) * sizeY + pixel_y - horatitulo_Y;

	always @(posedge clk1) begin//Muestra la imagen si esta se encuentra dentro del margen definido en el if()

		// HORA

		if (pixel_x >= hora1_X && pixel_x < hora1_X + sizeX && pixel_y >= hora_Y && pixel_y < hora_Y + sizeY)

			case(info[31:28]) // SECCION DE INFO QUE CONTIENE LAS DECENAS DE LA HORA
				4'h0: rg <= CERO_DATA[{STATE}];	// SI EL VALOR ES 0, LEE LA IMAGN 0 EN LA POSICION POR LA QUE VAYA
				4'h1: rg <= UNO_DATA[{STATE}];	// POR EJEMPLO: LA IMAGEN DEBE MOSTRARSE A PARTIR DE pixel_x = 200
				4'h2: rg <= DOS_DATA[{STATE}];	// POR LO QUE CUANDO pixel_x == 200 LA ASIGANCION DE "STATE" SERA
				4'h3: rg <= TRES_DATA[{STATE}];	// assign STATE  = (pixel_x - hora1_X) * sizeY + pixel_y - hora_Y;
				4'h4: rg <= CUATRO_DATA[{STATE}];// QUE ES LO MISMO QUE
				4'h5: rg <= CINCO_DATA[{STATE}]; // assign STATE  = (200 - 200) * 37 + 50 - 50 = 0 ==> LEE EL PRIMER PIXEL
				4'h6: rg <= SEIS_DATA[{STATE}];	//	ASI CONTINUA EL PROCEDIMIENTO CON LOS DEMAS
				4'h7: rg <= SIETE_DATA[{STATE}];
				4'h8: rg <= OCHO_DATA[{STATE}];
				4'h9: rg <= NUEVE_DATA[{STATE}];
				default: rg <= 8'b00000000;
			endcase
		
		else if (pixel_x >= hora1_X && pixel_x < hora1_X + sizeX && pixel_y >= hora_Y + sizeY && pixel_y < hora_Y + sizeY + sizeYPointer && Pointer[3])
			begin	
				STATEPOINTER <= (pixel_x - hora1_X) * sizeYPointer + pixel_y - hora_Y;
				rg <= POINTER_DATA[{STATEPOINTER}];
			end
		
		// TITULO HORA
		
		else if (pixel_x >= hora1_X && pixel_x < hora1_X + sizeTitlesX && pixel_y >= horatitulo_Y + sizeY && pixel_y < horatitulo_Y + sizeY)
			begin
				rg <= HORA_DATA[{STATEHORA}];
			end
		
		else if (pixel_x >= hora2_X && pixel_x < hora2_X + sizeX && pixel_y >= hora_Y && pixel_y < hora_Y + sizeY)

			case(info[27:24]) // SECCION DE INFO QUE CONTIENE LAS UNIDADES DE LA HORA
				4'h0: rg <= CERO_DATA[{STATE1}];
				4'h1: rg <= UNO_DATA[{STATE1}];
				4'h2: rg <= DOS_DATA[{STATE1}];
				4'h3: rg <= TRES_DATA[{STATE1}];
				4'h4: rg <= CUATRO_DATA[{STATE1}];
				4'h5: rg <= CINCO_DATA[{STATE1}];
				4'h6: rg <= SEIS_DATA[{STATE1}];
				4'h7: rg <= SIETE_DATA[{STATE1}];
				4'h8: rg <= OCHO_DATA[{STATE1}];
				4'h9: rg <= NUEVE_DATA[{STATE1}];
				default: rg <= 8'b00000000;
			endcase

		else if (pixel_x >= hora2_X && pixel_x < hora2_X + sizeX && pixel_y >= hora_Y + sizeY && pixel_y < hora_Y + sizeY + sizeYPointer && Pointer[3])
			begin	
				STATEPOINTER <= (pixel_x - hora2_X) * sizeYPointer + pixel_y - hora_Y;
				rg <= POINTER_DATA[{STATEPOINTER}];
			end	
			
		// MINUTOS

		else if (pixel_x >= min1_X && pixel_x < min1_X + sizeX && pixel_y >= hora_Y && pixel_y < hora_Y + sizeY)
		
			case(info[39:36])
				4'h0: rg <= CERO_DATA[{STATE2}];
				4'h1: rg <= UNO_DATA[{STATE2}];
				4'h2: rg <= DOS_DATA[{STATE2}];
				4'h3: rg <= TRES_DATA[{STATE2}];
				4'h4: rg <= CUATRO_DATA[{STATE2}];
				4'h5: rg <= CINCO_DATA[{STATE2}];
				4'h6: rg <= SEIS_DATA[{STATE2}];
				4'h7: rg <= SIETE_DATA[{STATE2}];
				4'h8: rg <= OCHO_DATA[{STATE2}];
				4'h9: rg <= NUEVE_DATA[{STATE2}];
				default: rg <= 8'b00000000;
			endcase

		else if (pixel_x >= min1_X && pixel_x < min1_X + sizeX && pixel_y >= hora_Y + sizeY && pixel_y < hora_Y + sizeY + sizeYPointer && Pointer[4])
			begin	
				STATEPOINTER <= (pixel_x - min1_X) * sizeYPointer + pixel_y - hora_Y;
				rg <= POINTER_DATA[{STATEPOINTER}];
			end

		else if (pixel_x >= min2_X && pixel_x < min2_X + sizeX && pixel_y >= hora_Y && pixel_y < hora_Y + sizeY)

			case(info[35:32])
				4'h0: rg <= CERO_DATA[{STATE3}];
				4'h1: rg <= UNO_DATA[{STATE3}];
				4'h2: rg <= DOS_DATA[{STATE3}];
				4'h3: rg <= TRES_DATA[{STATE3}];
				4'h4: rg <= CUATRO_DATA[{STATE3}];
				4'h5: rg <= CINCO_DATA[{STATE3}];
				4'h6: rg <= SEIS_DATA[{STATE3}];
				4'h7: rg <= SIETE_DATA[{STATE3}];
				4'h8: rg <= OCHO_DATA[{STATE3}];
				4'h9: rg <= NUEVE_DATA[{STATE3}];
				default: rg <= 8'b00000000;
			endcase

		else if (pixel_x >= min2_X && pixel_x < min2_X + sizeX && pixel_y >= hora_Y + sizeY && pixel_y < hora_Y + sizeY + sizeYPointer && Pointer[4])
			begin	
				STATEPOINTER <= (pixel_x - min2_X) * sizeYPointer + pixel_y - hora_Y;
				rg <= POINTER_DATA[{STATEPOINTER}];
			end

		// SEGUNDOS

		else if (pixel_x >= seg1_X && pixel_x < seg1_X + sizeX && pixel_y >= hora_Y && pixel_y < hora_Y + sizeY)
			
			case(info[47:44])
				4'h0: rg <= CERO_DATA[{STATE4}];
				4'h1: rg <= UNO_DATA[{STATE4}];
				4'h2: rg <= DOS_DATA[{STATE4}];
				4'h3: rg <= TRES_DATA[{STATE4}];
				4'h4: rg <= CUATRO_DATA[{STATE4}];
				4'h5: rg <= CINCO_DATA[{STATE4}];
				4'h6: rg <= SEIS_DATA[{STATE4}];
				4'h7: rg <= SIETE_DATA[{STATE4}];
				4'h8: rg <= OCHO_DATA[{STATE4}];
				4'h9: rg <= NUEVE_DATA[{STATE4}];
				default: rg <= 8'b00000000;
			endcase


			else if (pixel_x >= hora1_X && pixel_x < hora1_X + sizeTitlesX && pixel_y >= horatitulo_Y + sizeY && pixel_y < horatitulo_Y + sizeY)
			begin
				rg <= HORA_DATA[{STATEHORA}];
			end
		
		else if (pixel_x >= seg1_X && pixel_x < seg1_X + sizeX && pixel_y >= hora_Y + sizeY && pixel_y < hora_Y + sizeY + sizeYPointer && Pointer[5])
			begin	
				STATEPOINTER <= (pixel_x - seg1_X) * sizeYPointer + pixel_y - hora_Y;
				rg <= POINTER_DATA[{STATEPOINTER}];
			end

		else if (pixel_x >= seg2_X && pixel_x < seg2_X + sizeX && pixel_y >= hora_Y && pixel_y < hora_Y + sizeY)

			case(info[43:40])
				4'h0: rg <= CERO_DATA[{STATE5}];
				4'h1: rg <= UNO_DATA[{STATE5}];
				4'h2: rg <= DOS_DATA[{STATE5}];
				4'h3: rg <= TRES_DATA[{STATE5}];
				4'h4: rg <= CUATRO_DATA[{STATE5}];
				4'h5: rg <= CINCO_DATA[{STATE5}];
				4'h6: rg <= SEIS_DATA[{STATE5}];
				4'h7: rg <= SIETE_DATA[{STATE5}];
				4'h8: rg <= OCHO_DATA[{STATE5}];
				4'h9: rg <= NUEVE_DATA[{STATE5}];
				default: rg <= 8'b00000000;
			endcase

		else if (pixel_x >= seg2_X && pixel_x < seg2_X + sizeX && pixel_y >= hora_Y + sizeY && pixel_y < hora_Y + sizeY + sizeYPointer && Pointer[5])
			begin	
				STATEPOINTER <= (pixel_x - seg2_X) * sizeYPointer + pixel_y - hora_Y;
				rg <= POINTER_DATA[{STATEPOINTER}];
			end

		// HORA CRONOMETRO

		else if (pixel_x >= c_hora1_X && pixel_x < c_hora1_X + sizeX && pixel_y >= hora_Y && pixel_y < hora_Y + sizeY)

			case(info[55:52]) 
				4'h0: rg <= CERO_DATA[{STATE12}];	
				4'h1: rg <= UNO_DATA[{STATE12}];	
				4'h2: rg <= DOS_DATA[{STATE12}];	
				4'h3: rg <= TRES_DATA[{STATE12}];	
				4'h4: rg <= CUATRO_DATA[{STATE12}];
				4'h5: rg <= CINCO_DATA[{STATE12}]; 
				4'h6: rg <= SEIS_DATA[{STATE12}];	
				4'h7: rg <= SIETE_DATA[{STATE12}];
				4'h8: rg <= OCHO_DATA[{STATE12}];
				4'h9: rg <= NUEVE_DATA[{STATE12}];
				default: rg <= 8'b00000000;
			endcase
		
		else if (pixel_x >= c_hora1_X && pixel_x < c_hora1_X + sizeX && pixel_y >= hora_Y + sizeY && pixel_y < hora_Y + sizeY + sizeYPointer && Pointer[6])
			begin	
				STATEPOINTER <= (pixel_x - c_hora1_X) * sizeYPointer + pixel_y - hora_Y;
				rg <= POINTER_DATA[{STATEPOINTER}];
			end
		
				// TITULO CRONOMETRO
		
		else if (pixel_x >= c_hora1_X && pixel_x < c_hora1_X + sizeTitlesX && pixel_y >= horatitulo_Y + sizeY && pixel_y < horatitulo_Y + sizeY)
			begin
				rg <= CRONOMETRO_DATA[{STATECRONOMETRO}];
			end
		
		else if (pixel_x >= c_hora2_X && pixel_x < c_hora2_X + sizeX && pixel_y >= hora_Y && pixel_y < hora_Y + sizeY)

			case(info[51:48]) 
				4'h0: rg <= CERO_DATA[{STATE13}];
				4'h1: rg <= UNO_DATA[{STATE13}];
				4'h2: rg <= DOS_DATA[{STATE13}];
				4'h3: rg <= TRES_DATA[{STATE13}];
				4'h4: rg <= CUATRO_DATA[{STATE13}];
				4'h5: rg <= CINCO_DATA[{STATE13}];
				4'h6: rg <= SEIS_DATA[{STATE13}];
				4'h7: rg <= SIETE_DATA[{STATE13}];
				4'h8: rg <= OCHO_DATA[{STATE13}];
				4'h9: rg <= NUEVE_DATA[{STATE13}];
				default: rg <= 8'b00000000;
			endcase

		else if (pixel_x >= c_hora2_X && pixel_x < c_hora2_X + sizeX && pixel_y >= hora_Y + sizeY && pixel_y < hora_Y + sizeY + sizeYPointer && Pointer[6])
			begin	
				STATEPOINTER <= (pixel_x - c_hora2_X) * sizeYPointer + pixel_y - hora_Y;
				rg <= POINTER_DATA[{STATEPOINTER}];
			end	
			
		// MINUTOS CRONOMETRO

		else if (pixel_x >= c_min1_X && pixel_x < c_min1_X + sizeX && pixel_y >= hora_Y && pixel_y < hora_Y + sizeY)
		
			case(info[63:60])
				4'h0: rg <= CERO_DATA[{STATE14}];
				4'h1: rg <= UNO_DATA[{STATE14}];
				4'h2: rg <= DOS_DATA[{STATE14}];
				4'h3: rg <= TRES_DATA[{STATE14}];
				4'h4: rg <= CUATRO_DATA[{STATE14}];
				4'h5: rg <= CINCO_DATA[{STATE14}];
				4'h6: rg <= SEIS_DATA[{STATE14}];
				4'h7: rg <= SIETE_DATA[{STATE14}];
				4'h8: rg <= OCHO_DATA[{STATE14}];
				4'h9: rg <= NUEVE_DATA[{STATE14}];
				default: rg <= 8'b00000000;
			endcase

		else if (pixel_x >= c_min1_X && pixel_x < c_min1_X + sizeX && pixel_y >= hora_Y + sizeY && pixel_y < hora_Y + sizeY + sizeYPointer && Pointer[7])
			begin	
				STATEPOINTER <= (pixel_x - c_min1_X) * sizeYPointer + pixel_y - hora_Y;
				rg <= POINTER_DATA[{STATEPOINTER}];
			end

		else if (pixel_x >= c_min2_X && pixel_x < c_min2_X + sizeX && pixel_y >= hora_Y && pixel_y < hora_Y + sizeY)

			case(info[59:56])
				4'h0: rg <= CERO_DATA[{STATE15}];
				4'h1: rg <= UNO_DATA[{STATE15}];
				4'h2: rg <= DOS_DATA[{STATE15}];
				4'h3: rg <= TRES_DATA[{STATE15}];
				4'h4: rg <= CUATRO_DATA[{STATE15}];
				4'h5: rg <= CINCO_DATA[{STATE15}];
				4'h6: rg <= SEIS_DATA[{STATE15}];
				4'h7: rg <= SIETE_DATA[{STATE15}];
				4'h8: rg <= OCHO_DATA[{STATE15}];
				4'h9: rg <= NUEVE_DATA[{STATE15}];
				default: rg <= 8'b00000000;
			endcase

		else if (pixel_x >= c_min2_X && pixel_x < c_min2_X + sizeX && pixel_y >= hora_Y + sizeY && pixel_y < hora_Y + sizeY + sizeYPointer && Pointer[7])
			begin	
				STATEPOINTER <= (pixel_x - c_min2_X) * sizeYPointer + pixel_y - hora_Y;
				rg <= POINTER_DATA[{STATEPOINTER}];
			end

		// SEGUNDOS CRONOMETRO

		else if (pixel_x >= c_seg1_X && pixel_x < c_seg1_X + sizeX && pixel_y >= hora_Y && pixel_y < hora_Y + sizeY)
			
			case(info[71:68])
				4'h0: rg <= CERO_DATA[{STATE16}];
				4'h1: rg <= UNO_DATA[{STATE16}];
				4'h2: rg <= DOS_DATA[{STATE16}];
				4'h3: rg <= TRES_DATA[{STATE16}];
				4'h4: rg <= CUATRO_DATA[{STATE16}];
				4'h5: rg <= CINCO_DATA[{STATE16}];
				4'h6: rg <= SEIS_DATA[{STATE16}];
				4'h7: rg <= SIETE_DATA[{STATE16}];
				4'h8: rg <= OCHO_DATA[{STATE16}];
				4'h9: rg <= NUEVE_DATA[{STATE16}];
				default: rg <= 8'b00000000;
			endcase
			else if (pixel_x >= c_hora1_X && pixel_x < c_hora1_X + sizeTitlesX && pixel_y >= horatitulo_Y + sizeY && pixel_y < horatitulo_Y + sizeY)
			begin
				rg <= CRONOMETRO_DATA[{STATECRONOMETRO}];
			end
		
		else if (pixel_x >= c_seg1_X && pixel_x < c_seg1_X + sizeX && pixel_y >= hora_Y + sizeY && pixel_y < hora_Y + sizeY + sizeYPointer && Pointer[8])
			begin	
				STATEPOINTER <= (pixel_x - c_seg1_X) * sizeYPointer + pixel_y - hora_Y;
				rg <= POINTER_DATA[{STATEPOINTER}];
			end

		else if (pixel_x >= c_seg2_X && pixel_x < c_seg2_X + sizeX && pixel_y >= hora_Y && pixel_y < hora_Y + sizeY)

			case(info[67:64])
				4'h0: rg <= CERO_DATA[{STATE17}];
				4'h1: rg <= UNO_DATA[{STATE17}];
				4'h2: rg <= DOS_DATA[{STATE17}];
				4'h3: rg <= TRES_DATA[{STATE17}];
				4'h4: rg <= CUATRO_DATA[{STATE17}];
				4'h5: rg <= CINCO_DATA[{STATE17}];
				4'h6: rg <= SEIS_DATA[{STATE17}];
				4'h7: rg <= SIETE_DATA[{STATE17}];
				4'h8: rg <= OCHO_DATA[{STATE17}];
				4'h9: rg <= NUEVE_DATA[{STATE17}];
				default: rg <= 8'b00000000;
			endcase

		else if (pixel_x >= c_seg2_X && pixel_x < c_seg2_X + sizeX && pixel_y >= hora_Y + sizeY && pixel_y < hora_Y + sizeY + sizeYPointer && Pointer[8])
			begin	
				STATEPOINTER <= (pixel_x - c_seg2_X) * sizeYPointer + pixel_y - hora_Y;
				rg <= POINTER_DATA[{STATEPOINTER}];
			end

		// DIA

		else if (pixel_x >= dia1_X && pixel_x < dia1_X + sizeX && pixel_y >= fecha_Y && pixel_y < fecha_Y + sizeY)
			
			case(info[7:4])
				4'h0: rg <= CERO_DATA[{STATE6}];
				4'h1: rg <= UNO_DATA[{STATE6}];
				4'h2: rg <= DOS_DATA[{STATE6}];
				4'h3: rg <= TRES_DATA[{STATE6}];
				4'h4: rg <= CUATRO_DATA[{STATE6}];
				4'h5: rg <= CINCO_DATA[{STATE6}];
				4'h6: rg <= SEIS_DATA[{STATE6}];
				4'h7: rg <= SIETE_DATA[{STATE6}];
				4'h8: rg <= OCHO_DATA[{STATE6}];
				4'h9: rg <= NUEVE_DATA[{STATE6}];
				default: rg <= 8'b00000000;
			endcase
		
		// TITULO FECHA
		
		else if (pixel_x >= dia1_X && pixel_x < dia1_X + sizeTitlesX && pixel_y >= fechatitulo_Y + sizeY && pixel_y < fechatitulo_Y + sizeY)
			begin
				rg <= FECHA_DATA[{STATEFECHA}];
			end
		
		else if (pixel_x >= dia1_X && pixel_x < dia1_X + sizeX && pixel_y >= fecha_Y + sizeY && pixel_y < fecha_Y + sizeY + sizeYPointer && Pointer[0])
			begin	
				STATEPOINTER <= (pixel_x - dia1_X) * sizeYPointer + pixel_y - fecha_Y;
				rg <= POINTER_DATA[{STATEPOINTER}];
			end

		else if (pixel_x >= dia2_X && pixel_x < dia2_X + sizeX && pixel_y >= fecha_Y && pixel_y < fecha_Y + sizeY)

			case(info[3:0])
				4'h0: rg <= CERO_DATA[{STATE7}];
				4'h1: rg <= UNO_DATA[{STATE7}];
				4'h2: rg <= DOS_DATA[{STATE7}];
				4'h3: rg <= TRES_DATA[{STATE7}];
				4'h4: rg <= CUATRO_DATA[{STATE7}];
				4'h5: rg <= CINCO_DATA[{STATE7}];
				4'h6: rg <= SEIS_DATA[{STATE7}];
				4'h7: rg <= SIETE_DATA[{STATE7}];
				4'h8: rg <= OCHO_DATA[{STATE7}];
				4'h9: rg <= NUEVE_DATA[{STATE7}];
				default: rg <= 8'b00000000;
			endcase
		
		else if (pixel_x >= dia2_X && pixel_x < dia2_X + sizeX && pixel_y >= fecha_Y + sizeY && pixel_y < fecha_Y + sizeY + sizeYPointer && Pointer[0])
			begin	
				STATEPOINTER <= (pixel_x - dia2_X) * sizeYPointer + pixel_y - fecha_Y;
				rg <= POINTER_DATA[{STATEPOINTER}];
			end
		
		//MES
		
		else if (pixel_x >= mes1_X && pixel_x < mes1_X + sizeX && pixel_y >= fecha_Y && pixel_y < fecha_Y + sizeY)

			case(info[15:12])
				4'h0: rg <= CERO_DATA[{STATE8}];
				4'h1: rg <= UNO_DATA[{STATE8}];
				4'h2: rg <= DOS_DATA[{STATE8}];
				4'h3: rg <= TRES_DATA[{STATE8}];
				4'h4: rg <= CUATRO_DATA[{STATE8}];
				4'h5: rg <= CINCO_DATA[{STATE8}];
				4'h6: rg <= SEIS_DATA[{STATE8}];
				4'h7: rg <= SIETE_DATA[{STATE8}];
				4'h8: rg <= OCHO_DATA[{STATE8}];
				4'h9: rg <= NUEVE_DATA[{STATE8}];
				default: rg <= 8'b00000000;
			endcase

		else if (pixel_x >= mes1_X && pixel_x < mes1_X + sizeX && pixel_y >= fecha_Y + sizeY && pixel_y < fecha_Y + sizeY + sizeYPointer && Pointer[1])
			begin	
				STATEPOINTER <= (pixel_x - mes1_X) * sizeYPointer + pixel_y - fecha_Y;
				rg <= POINTER_DATA[{STATEPOINTER}];
			end

		else if (pixel_x >= mes2_X && pixel_x < mes2_X + sizeX && pixel_y >= fecha_Y && pixel_y < fecha_Y + sizeY)
			
			case(info[11:8])
				4'h0: rg <= CERO_DATA[{STATE9}];
				4'h1: rg <= UNO_DATA[{STATE9}];
				4'h2: rg <= DOS_DATA[{STATE9}];
				4'h3: rg <= TRES_DATA[{STATE9}];
				4'h4: rg <= CUATRO_DATA[{STATE9}];
				4'h5: rg <= CINCO_DATA[{STATE9}];
				4'h6: rg <= SEIS_DATA[{STATE9}];
				4'h7: rg <= SIETE_DATA[{STATE9}];
				4'h8: rg <= OCHO_DATA[{STATE9}];
				4'h9: rg <= NUEVE_DATA[{STATE9}];
				default: rg <= 8'b00000000;
			endcase

		else if (pixel_x >= mes2_X && pixel_x < mes2_X + sizeX && pixel_y >= fecha_Y + sizeY && pixel_y < fecha_Y + sizeY + sizeYPointer && Pointer[1])
			begin	
				STATEPOINTER <= (pixel_x - mes2_X) * sizeYPointer + pixel_y - fecha_Y;
				rg <= POINTER_DATA[{STATEPOINTER}];
			end
		else if (pixel_x >= dia1_X && pixel_x < dia1_X + sizeTitlesX && pixel_y >= fechatitulo_Y + sizeY && pixel_y < fechatitulo_Y + sizeY)
			begin
				rg <= FECHA_DATA[{STATEFECHA}];
			end
		// AÑO
		
		else if (pixel_x >= ano1_X && pixel_x < ano1_X + sizeX && pixel_y >= fecha_Y && pixel_y < fecha_Y + sizeY)
			
			case(info[23:20])
				4'h0: rg <= CERO_DATA[{STATE10}];
				4'h1: rg <= UNO_DATA[{STATE10}];
				4'h2: rg <= DOS_DATA[{STATE10}];
				4'h3: rg <= TRES_DATA[{STATE10}];
				4'h4: rg <= CUATRO_DATA[{STATE10}];
				4'h5: rg <= CINCO_DATA[{STATE10}];
				4'h6: rg <= SEIS_DATA[{STATE10}];
				4'h7: rg <= SIETE_DATA[{STATE10}];
				4'h8: rg <= OCHO_DATA[{STATE10}];
				4'h9: rg <= NUEVE_DATA[{STATE10}];
				default: rg <= 8'b00000000;
			endcase

		else if (pixel_x >= ano1_X && pixel_x < ano1_X + sizeX && pixel_y >= fecha_Y + sizeY && pixel_y < fecha_Y + sizeY + sizeYPointer && Pointer[2])
			begin	
				STATEPOINTER <= (pixel_x - ano1_X) * sizeYPointer + pixel_y - fecha_Y;
				rg <= POINTER_DATA[{STATEPOINTER}];
			end
			
			else if (pixel_x >= dia1_X && pixel_x < dia1_X + sizeTitlesX && pixel_y >= fechatitulo_Y + sizeY && pixel_y < fechatitulo_Y + sizeY)
			begin
				rg <= FECHA_DATA[{STATEFECHA}];
			end

		else if (pixel_x >= ano2_X && pixel_x < ano2_X + sizeX && pixel_y >= fecha_Y && pixel_y < fecha_Y + sizeY)

			case(info[19:16])
				4'h0: rg <= CERO_DATA[{STATE11}];
				4'h1: rg <= UNO_DATA[{STATE11}];
				4'h2: rg <= DOS_DATA[{STATE11}];
				4'h3: rg <= TRES_DATA[{STATE11}];
				4'h4: rg <= CUATRO_DATA[{STATE11}];
				4'h5: rg <= CINCO_DATA[{STATE11}];
				4'h6: rg <= SEIS_DATA[{STATE11}];
				4'h7: rg <= SIETE_DATA[{STATE11}];
				4'h8: rg <= OCHO_DATA[{STATE11}];
				4'h9: rg <= NUEVE_DATA[{STATE11}];
				default: rg <= 8'b00000000;
			endcase
	
		else if (pixel_x >= dia1_X && pixel_x < dia1_X + sizeTitlesX && pixel_y >= fechatitulo_Y + sizeY && pixel_y < fechatitulo_Y + sizeY)
			begin
				rg <= FECHA_DATA[{STATEFECHA}];
			end
			
			
		else if (pixel_x >= ano2_X && pixel_x < ano2_X + sizeX && pixel_y >= fecha_Y + sizeY && pixel_y < fecha_Y + sizeY + sizeYPointer && Pointer[2])
			begin	
				STATEPOINTER <= (pixel_x - ano2_X) * sizeYPointer + pixel_y - fecha_Y;
				rg <= POINTER_DATA[{STATEPOINTER}];
			end

		else
			rg <= 8'b00000000;	// SI NO SE ESTA DENTRO EL RANGO DESEADO PARA NINGUNA IMAGEN, PINTAR NEGRO
	end

assign rgb=rg;	// ASIGNACION DEL COLOR AL OUTPUT

vga_control vga(
	.dclk(clk1),
	.clr(clr),
	.hsync(hsync),
	.vsync(vsync),
	.hc(pixel_x),
	.vc(pixel_y)
	);

clk_div clk_25 (
   .original_clk(clk_i),
   .reset(clr),
   .new_clk(clk1)
   );

endmodule
