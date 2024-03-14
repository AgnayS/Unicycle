`timescale 1ns / 10ps

module top_level (
	input [17:0] SW,
	input CLOCK_50,
	output [17:0] LEDR,
	output [6:0] HEX0,
	output [6:0] HEX1,
	output [6:0] HEX2,
	output [6:0] HEX3,
	output [6:0] HEX4,
	output [6:0] HEX5,
	output [6:0] HEX6,
	output [6:0] HEX7
);
	
	wire [15:0] outVal;
	reg [15:0] outValPos;
	
	assign LEDR = 18'b000001000100010001;
	
	BCD H4BCD (
		.val({1'b0, SW[3:0]}),
		.hex(HEX4)
	);
	
	BCD H5BCD (
		.val({1'b0, SW[7:4]}),
		.hex(HEX5)
	);
	
	BCD H6BCD (
		.val({1'b0, SW[11:8]}),
		.hex(HEX6)
	);
	
	BCD H7BCD (
		.val({1'b0, SW[15:12]}),
		.hex(HEX7)
	);
	
	

	BCD H0BCD (
		.val({SW[17], outValPos[3:0]}),
		.hex(HEX0)
	);

	BCD H1BCD (
		.val({SW[17], outValPos[7:4]}),
		.hex(HEX1)
	);

	BCD H2BCD (
		.val({SW[17], outValPos[11:8]}),
		.hex(HEX2)
	);

	BCD H3BCD (    
		.val({SW[17], outValPos[15:12]}),
		.hex(HEX3)
	);

	wire outputLineWrite;
	
	P_Liu_Clock_Mod Processor (
		.doubleClk(CLOCK_50),
		.rst(SW[17]),
		.inputLine(SW[15:0]),
		.outputLine(outVal),
		.outputLineWrite(outputLineWrite)
	);
	
	
	
	always @ (outVal or outputLineWrite) begin
		if (outputLineWrite)
			outValPos = outVal;
	end
	
endmodule
