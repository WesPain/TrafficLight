`timescale 1us / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:26:31 06/01/2018 
// Design Name: 
// Module Name:    TimerController 
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
module TimerController(
   input i_clk,
	input i_nreset,
   input i_countEnable,
   output reg o_newState,
	output reg o_nextLight
   );
	
	//Registers
	//reg o_newState;
	//Internals
	parameter GOYELLOW = 4'b0110;
	parameter GORED =GOYELLOW + 4'b0010;
	reg [3:0] lightCounter = 4'b0000;
	reg downSampler =1'b0;
	integer downSamplercounter = 0;
	
	always@(posedge i_clk) begin : Downsampler
		if(downSamplercounter < 50000000) begin
			downSampler <= 1'b0;
			downSamplercounter <= downSamplercounter +1;
		end else begin
			downSampler <=1'b1;
			downSamplercounter <= 0;
		end
	end
	 
	always@(posedge i_clk) begin :Counter_logic
		if(i_nreset ==1) begin
			lightCounter <= 4'b0000;
			o_newState <= 1'b0;
			o_nextLight <= 1'b0;
		end else if(i_countEnable && downSampler)begin
			o_newState <= 1'b0;
			lightCounter <= lightCounter +1;
			if(lightCounter==GOYELLOW) begin
				o_nextLight <=1'b1;
			end
			if(lightCounter==GORED) begin
				o_nextLight <=1'b0;
				o_newState <=1'b1;
				lightCounter<= 4'b0000;
			end
		
		end
	end
	 


endmodule
