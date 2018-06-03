`timescale 1us / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:42:16 05/31/2018 
// Design Name: 
// Module Name:    TrafficInterface 
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
module TrafficInterface(
    input clk,
	 input i_nreset,
	// input i_carEW,
   // input i_carNS,
    output[2:0]  o_NSlights,
	 output[2:0]  o_EWlights
    );
	 
	// reg [1:0] state;
	// reg [3:0] count;
	// reg nextLights;
	 wire io_newState;
	 wire io_countEnable;
	 wire io_nextLight;
	 
	 TimerController U1 (
		.i_clk(clk), 
		.i_nreset(i_nreset), 
		.i_countEnable(io_countEnable), 
		.o_newState(io_newState),
		.o_nextLight(io_nextLight)
    );
	
	 FsmModule U2 (
		.i_clk(clk), 
		.i_nreset(i_nreset), 
		.i_newState(io_newState),
		.i_nextLight(io_nextLight),
		.o_countEnable(io_countEnable), 
		.o_NSlights(o_NSlights), 
		.o_EWlights(o_EWlights)
	 );
	 //Test variables
	 /*always@(posedge i_clk) begin
		state = U2.state;
		count = U1.lightCounter;
		nextLights = U1.o_nextLight;
	end*/


endmodule
