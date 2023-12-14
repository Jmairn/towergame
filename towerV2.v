  
			
			//Sw[7:0] data_in

//KEY[0] synchronous reset when pressed
//KEY[1] go signal

//LEDR displays result
//HEX0 & HEX1 also displays result

module towerV2(
    input [9:0] SW,
    input [3:0] KEY,
    input CLOCK_50,
    output [17:0] LEDR,
    output [6:0] HEX0, HEX1, HEX2, HEX3,

    output VGA_CLK, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N,
    output [9:0] VGA_R, VGA_G, VGA_B
    );
	 
	 assign HEX3 = 7'b0000011;
	 assign HEX2 = 7'b0000000;
	 assign HEX1 = 7'b0000000;
	 assign HEX0 = 7'b0000011;
	 
	 
	 wire [7:0] x,y;
	 
	 wire [3:0]colour;

    wire endgame;

    assign resetn = KEY[0];
    assign grav = SW[0];
    assign go = SW[1];
	 
	 wire [5:0] curr;
	 wire [11999:0] vwall;
	 wire [119:0] hwall;
	 wire [7:0] vdude, hdude;
	 wire enable, o, menu, physics, setup, display, sclock;
	 
	 //assign LEDR[3:0] = curr; // debugging
	 
	 /*vga_adapter VGA(
                             .resetn(resetn),
                             .clock(CLOCK_50),
                             .colour(colour),
                             .x(x),
                             .y(y),
                             .plot(1'b1),
                             // Signals for the DAC to drive the monitor. 
                             .VGA_R(VGA_R),
                             .VGA_G(VGA_G),
                             .VGA_B(VGA_B),
                             .VGA_HS(VGA_HS),
                             .VGA_VS(VGA_VS),
                             .VGA_BLANK(VGA_BLANK_N),
                             .VGA_SYNC(VGA_SYNC_N),
                             .VGA_CLK(VGA_CLK));
        defparam VGA.RESOLUTION = "160x120";
        defparam VGA.MONOCHROME = "FALSE";
        defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
    */
	 vga_controller controller(
			.vga_clock(CLOCK_50),
			.resetn(resetn),
			.pixel_colour(to_ctrl_colour),
			.memory_address(controller_to_video_memory_addr), 
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK),
			.VGA_SYNC(VGA_SYNC),
			.VGA_CLK(CLOCK_50)
	);
	 
	 
endmodule 