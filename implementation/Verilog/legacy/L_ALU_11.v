module L_ALU_11 (control, in0, in1, dout);

// Handles ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR
// Control bits: instruction[12:10]
// Immediate bits: None
// Each ALU is responsible for sign extending their own immediate

	input [2:0] control;
	
	input [15:0] in0;
	input [15:0] in1;
	
	output reg [15:0] dout;
	
	
	always @(in0, in1, control) begin
	case(control)
		//add
		3'b000:
			dout = in0+in1;
		//and
		3'b001:
			dout = in0&in1;
		//or
		3'b010:
			dout = in0|in1;
		//xor
		3'b011:
			dout = in0^in1;
		//sub
		3'b100:
			dout = in0-in1;
		//nand
		3'b101:
			dout = ~(in0&in1);
		//nor
		3'b110:
			dout = ~(in0|in1);
		//xnor
		3'b111:
			dout = ~(in0^in1);
	endcase
	end
	
endmodule