module C_ALU (op, in0, in1, dout);

	input [2:0] op;
	
	input [15:0] in0;
	input [15:0] in1;
	
	output reg [15:0] dout;
	
	
	always @ * begin
		case(op)
			3'b000: dout = in0+in1;
			3'b001: dout = in0&in1;
			3'b010: dout = in0|in1;
			3'b011: dout = in0^in1;
			3'b100: dout = in0-in1;
			3'b101: dout = ~(in0&in1);
			3'b110: dout = ~(in0|in1);
			3'b111: dout = ~(in0^in1);
		endcase
	end
	
endmodule