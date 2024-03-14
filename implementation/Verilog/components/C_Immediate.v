module C_Immediate (instruction, immediate);

// Handles ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR
// Control bits: instruction[12:10]
// Immediate bits: None
// Each ALU is responsible for sign extending their own immediate

	input [15:0] instruction;
	output reg [15:0] immediate;
	
	always @ instruction begin
		case (instruction [15:13])
			3'b000:
				immediate = {{8{instruction[10]}}, instruction[10:3]}; // LU, LL
			3'b001:
				case (instruction [12])
					1'b0: immediate = {{10{instruction[11]}}, instruction[11:6]}; // ADDI
					default: immediate = {{5{instruction[9]}}, instruction[9:0], 1'b0}; // RETURN, JUMP
				endcase
			3'b010:
				immediate = {{6{instruction[11]}}, instruction[11:3], 1'b0}; // STRSP, RTVSP
			3'b011:
				immediate = {{5{instruction[9]}}, instruction[9:0], 1'b0}; // CHGSPI, CHGPCI
			default: immediate = {{8{instruction[12]}}, instruction[12:6], 1'b0}; // GEQ, NEQ, LT, EQ
		endcase
	end
	
endmodule