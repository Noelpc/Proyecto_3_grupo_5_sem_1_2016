`timescale 1ns / 1ps

module vga_control(
	input wire dclk,			//pixel clock: 25MHz
	input wire clr,			//asynchronous reset
	output wire hsync,		//horizontal sync out
	output wire vsync,		//vertical sync out
	output reg [9:0] hc,
	output reg [9:0] vc

	);

// video structure constants
parameter hpixels = 800;// horizontal pixels per line
parameter vlines = 521; // vertical lines per frame
parameter hpulse = 96; 	// hsync pulse length
parameter vpulse = 2; 	// vsync pulse length


always @(posedge dclk or posedge clr)
begin
	// reset condition
	if (clr == 1)
	begin
		hc <= 0;
		vc <= 0;
	end
	else
	begin
		// keep counting until the end of the line
		if (hc < hpixels - 1)
			hc <= hc + 10'b1;
		else
		// When we hit the end of the line, reset the horizontal
		// counter and increment the vertical counter.
		// If vertical counter is at the end of the frame, then
		// reset that one too.
		begin
			hc <= 0;
			if (vc < vlines - 1)
				vc <= vc + 10'b1;
			else
				vc <= 0;
		end
		
	end
end


assign hsync = (hc < hpulse) ? 1'b0:1'b1;
assign vsync = (vc < vpulse) ? 1'b0:1'b1;
 /*
if (hc < hpulse) begin hsync = 1'b0; end else hsync = 1'b1;
if(vc < vpulse) begin vsync = 1'b0; end else vsync = 1'b1;
*/ 
endmodule
