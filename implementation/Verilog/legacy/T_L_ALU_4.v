`timescale 1 ns/100 ps

module T_L_ALU_4 ();
	reg signed [15:0] in0;
	reg signed [8:0] immediate;
	reg [15:0] success;
	reg [15:0] fail;
	wire signed [15:0] out;
	
	L_ALU_4 UUT (.immediate(immediate), .in0(in0), .out(out));
	
	initial begin
		in0 = 16'h0000;
		immediate = 9'h000;
		success = 16'h0000;
		fail = 16'h0000;
		
		repeat (300) begin
			repeat (200) begin
				#100;
				if(out != in0 + immediate) begin
					$display("Incorrect Add Result. Register Input: %d, Immediate: %d, Output: %d", in0, immediate, out);
					fail = fail + 1;
				end else begin 
					success = success + 1;
				end
				immediate = immediate + 1;
			end
			in0 = in0 + 171;
		end
		$display("Success: %d, Fail: %d", success, fail);
	end
	
	
endmodule
