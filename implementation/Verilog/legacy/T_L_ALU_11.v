`timescale 1 ns/100 ps

module T_L_ALU_11 ();

	reg [2:0] control;
	reg [15:0] in0;
	reg [15:0] in1;
	reg [15:0] success;
	reg [15:0] fail;
	wire signed [15:0] dout;
	
	
	L_ALU_11 UUT1 (.control(control), .in0(in0), .in1(in1), .dout(dout));
	
	initial begin
	success = 16'h0000;
	fail = 16'h0000;
	
	in0 = 16'h0000;
	in1 = 16'h0000;
	
	//add
	control = 3'b000;
	repeat(8) begin
		repeat(8) begin
			#10
			if(dout != in0+in1) begin
			$display("Incorrect addition. Input 1: %h, Input 2: %h, Output: %h)", in0, in1, dout);
			fail = fail+1;
			end else begin 
				success = success + 1;
			end
		in0 = in0 + 8195;
		end
	in1 = in1 + 8195;
	end
	
	in0 = 16'h0000;
	in1 = 16'h0000;
	
	//and
	control = 3'b001;
	repeat(8) begin
		repeat(8) begin
			#10
			if(dout != in0&in1) begin
			$display("Incorrect AND. Input 1: %h, Input 2: %h, Output: %h)", in0, in1, dout);
			fail = fail+1;
			end else begin 
				success = success + 1;
			end
		in0 = in0 + 8195;
		end
	in1 = in1 + 8195;
	end
	
	in0 = 16'h0000;
	in1 = 16'h0000;
	
	//or
	control = 3'b010;
	repeat(8) begin
		repeat(8) begin
			#10
			if(dout != in0|in1) begin
			$display("Incorrect OR. Input 1: %h, Input 2: %h, Output: %h)", in0, in1, dout);
			fail = fail+1;
			end else begin 
				success = success + 1;
			end
		in0 = in0 + 8195;
		end
	in1 = in1 + 8195;
	end
	
	in0 = 16'h0000;
	in1 = 16'h0000;
	
	//xor
	control = 3'b011;
	repeat(8) begin
		repeat(8) begin
			#10
			if(dout != in0^in1) begin
			$display("Incorrect XOR. Input 1: %h, Input 2: %h, Output: %h)", in0, in1, dout);
			fail = fail+1;
			end else begin 
				success = success + 1;
			end
		in0 = in0 + 8195;
		end
	in1 = in1 + 8195;
	end
	
	in0 = 16'h0000;
	in1 = 16'h0000;
	
	$display("Success: %d, Fail: %d", success, fail);
	$stop;
	
	//nand
	control = 3'b101;
	repeat(8) begin
		repeat(8) begin
			#10
			if(dout != ~(in0&in1)) begin
			$display("Incorrect NAND. Input 1: %h, Input 2: %h, Output: %h)", in0, in1, dout);
			fail = fail+1;
			end else begin 
				success = success + 1;
			end
		in0 = in0 + 8195;
		end
	in1 = in1 + 8195;
	end
	
	in0 = 16'h0000;
	in1 = 16'h0000;
	
	//nor
	control = 3'b110;
	repeat(8) begin
		repeat(8) begin
			#10
			if(dout != ~(in0|in1)) begin
			$display("Incorrect NOR. Input 1: %h, Input 2: %h, Output: %h)", in0, in1, dout);
			fail = fail+1;
			end else begin 
				success = success + 1;
			end
		in0 = in0 + 8195;
		end
	in1 = in1 + 8195;
	end
	
	in0 = 16'h0000;
	in1 = 16'h0000;
		
	//xnor
	control = 3'b111;
	repeat(8) begin
		repeat(8) begin
			#10
			if(dout != ~(in0^in1)) begin
			$display("Incorrect XNOR. Input 1: %h, Input 2: %h, Output: %h)", in0, in1, dout);
			fail = fail+1;
			end else begin 
				success = success + 1;
			end
		in0 = in0 + 8195;
		end
	in1 = in1 + 8195;
	end
	
	in0 = 16'h0000;
	in1 = 16'h0000;
	
	//sub
	control = 3'b100;
	repeat(8) begin
		repeat(8) begin
			#10
			if(dout != in0-in1) begin
			$display("Incorrect SUB. Input 1: %h, Input 2: %h, Output: %h)", in0, in1, dout);
			fail = fail+1;
			end else begin 
				success = success + 1;
			end
		in0 = in0 + 8195;
		end
	in1 = in1 + 8195;
	end
	
	in0 = 16'h0000;
	in1 = 16'h0000;
	
	$display("Success: %d, Fail: %d", success, fail);
	$stop;
	
	
	
	end
	
endmodule	