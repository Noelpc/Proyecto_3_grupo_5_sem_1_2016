module clk_div(
	input wire original_clk,		//master clock: 100MHz
	input wire reset,		//asynchronous reset
	output wire new_clk		//pixel clock: 25MHz
	);

// 17-bit counter variable
reg [1:0] counter;

// Clock divider --
// Each bit in q is a clock signal that is
// only a fraction of the master clock.
always @(posedge original_clk or posedge reset)
begin
	// reset condition
	if (reset == 1) begin
		counter <= 0;
	end
	// increment counter by one
	else
		counter <= counter + 2'b1;
end

// 50Mhz ÷ 2^1 = 25MHz

assign new_clk = counter[1];

endmodule
