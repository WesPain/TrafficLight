`timescale 1us / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:25:29 06/01/2018 
// Design Name: 
// Module Name:    FsmModule 
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
module FsmModule(
    input i_clk,
    input i_nreset,
    input i_newState,
	 input i_nextLight,
    output reg o_countEnable,
    output reg[2:0] o_NSlights,
    output reg[2:0] o_EWlights
    );
	 
	 //parameter SIZE =2;
	 parameter NSLIGHT=1'b0,EWLIGHT=1'b1;
	 parameter RED = 3'b100, YELLOW = 3'b010, GREEN = 3'b001;
	 //Registers
	 //reg [SIZE-1:0] state;
	 reg state;
    
	 always@(posedge i_clk) begin :FSM_LOGIC
	    if(i_nreset == 1'b1) begin
			  o_countEnable <= 0;
			  o_EWlights <=RED;
			  o_NSlights <=RED;
			  //state <= NSLIGHT;
		 end else if (i_newState && state==NSLIGHT)begin
			  o_EWlights <=RED;
			  o_NSlights <=RED;
			  state <= EWLIGHT;
		 end else if (i_newState && state==EWLIGHT) begin
			  o_EWlights <=RED;
			  o_NSlights <=RED;
			  state <= NSLIGHT;
		 end else
		 case (state)
			NSLIGHT: if(i_newState) begin
				o_countEnable <= 0;
				o_NSlights <=RED;
				o_EWlights <=RED;
				state <=EWLIGHT;
		   end 
			else if(i_nextLight) begin
				o_countEnable <=1;
				o_NSlights <=YELLOW;
				o_EWlights <=RED;
				state<=NSLIGHT;
			end else begin
				o_countEnable <= 1;
				o_NSlights <=GREEN;
				o_EWlights <=RED;
				state <=NSLIGHT;
		   end
			EWLIGHT: if(i_newState) begin
				o_countEnable <= 0;
				o_EWlights <=RED;
				o_NSlights <=RED;
				state <=NSLIGHT;
			end else if(i_nextLight) begin
				o_countEnable <= 1;
				o_EWlights <=YELLOW;
				o_NSlights <=RED;
				state <= EWLIGHT;
			end else begin
				o_countEnable <= 1;
				o_EWlights <=GREEN;
				o_NSlights <=RED;
				state <= EWLIGHT;
			end
			default : state <=NSLIGHT;
			
		 endcase
		
	 end

endmodule
