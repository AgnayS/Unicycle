`timescale 100ns / 1ns

module T_P_Liu_2 ();

	reg doubleClk;
	reg rst;
	reg [15:0] inputLine;
	wire [15:0] outputLine;
	

	P_Liu_Clock_Mod Processor (
		.doubleClk(doubleClk),
		.rst(rst),	
		.inputLine(inputLine),
		.outputLine(outputLine)

	);
	
	initial begin
		doubleClk = 0;
		forever begin
			#2 doubleClk = ~doubleClk;
		end
	end
	
	initial begin
		
		// =======================================================================================================
		
		rst = 1;
		inputLine = 5040;
		#10;
		rst = 0;
		$display("The processor started initialization at time %d", $time);
		while (outputLine <= 0) begin
			#4;
		end
		$display("The processor ouputted %d for input %d at time %d", outputLine, inputLine, $time);
		
		// =======================================================================================================
		
		#12;
		rst = 1;
		inputLine = 30030;
		#12;
		rst = 0;
		$display("The processor started initialization at time %d", $time);
		while (outputLine <= 0) begin
			#4;
		end
		$display("The processor ouputted %d for input %d at time %d", outputLine, inputLine, $time);
		
		// =======================================================================================================
		
		#12;
		rst = 1;
		inputLine = 360;
		#12;
		rst = 0;
		$display("The processor started initialization at time %d", $time);
		while (outputLine <= 0) begin
			#4;
		end
		$display("The processor ouputted %d for input %d at time %d", outputLine, inputLine, $time);
		
		// =======================================================================================================
		
		#12;
		rst = 1;
		inputLine = 154;
		#12;
		rst = 0;
		$display("The processor started initialization at time %d", $time);
		while (outputLine <= 0) begin
			#4;
		end
		$display("The processor ouputted %d for input %d at time %d", outputLine, inputLine, $time);
		
		// =======================================================================================================
		
		#12;
		rst = 1;
		inputLine = 210;
		#12;
		rst = 0;
		$display("The processor started initialization at time %d", $time);
		while (outputLine <= 0) begin
			#4;
		end
		$display("The processor ouputted %d for input %d at time %d", outputLine, inputLine, $time);
		
		// =======================================================================================================
		
		#12;
		rst = 1;
		inputLine = 561;
		#12;
		rst = 0;
		$display("The processor started initialization at time %d", $time);
		while (outputLine <= 0) begin
			#4;
		end
		$display("The processor ouputted %d for input %d at time %d", outputLine, inputLine, $time);
		
		// =======================================================================================================
		
		#12;
		rst = 1;
		inputLine = 2310;
		#12;
		rst = 0;
		$display("The processor started initialization at time %d", $time);
		while (outputLine <= 0) begin
			#4;
		end
		$display("The processor ouputted %d for input %d at time %d", outputLine, inputLine, $time);
	end
endmodule


















