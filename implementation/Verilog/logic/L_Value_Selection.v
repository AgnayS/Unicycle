module L_Value_Selection (

	input [15:0] inputLine,
	
	input [15:0] in0,
	input [15:0] in1,
	input [15:0] in2,
	input [15:0] spIn,
	input [15:0] pcIn,
	input [15:0] raIn,
	input [15:0] memoryIn,
	input [15:0] immediate,

	output reg [15:0] out,
	output reg [15:0] spOut,
	output reg [15:0] pcOut,
	output reg [15:0] raOut,
	output reg [15:0] memoryAddress,
	output reg [15:0] memoryOut,
	
	input [1:0] ALUInput1Select,
	input [1:0] ALUInput2Select,
	input [2:0] ALUOp,
	input [1:0] CompOp,
	input [1:0] PCOutSelect,
	input [0:0] SPOutSelect,
	input [0:0] RAOutSelect,
	input [1:0] MemoryAddrSelect,
	input [0:0] MemoryOutSelect,
	input [2:0] RegisterOutSelect,
	input [4:0] shiftAmount,
	
	input forcePCAlternate
	// This is here so that no additional case needs bne added to PCOut. This is disabled if the instruction is a branching statement, otherwise it's enabled.
	
);

	
	wire [15:0] pcIncrementValue;
	assign pcIncrementValue = pcIn + 2;
	
	reg [15:0] ALUInput1;
	reg [15:0] ALUInput2;
	
	wire [15:0] ALUOut;
	C_ALU ALU (.op(ALUOp), .in0(ALUInput1), .in1(ALUInput2), .dout(ALUOut));
	
	wire [15:0] shiftOut;
	C_SHIFT SHIFTER (.immediate(shiftAmount), .in0(in1), .out(shiftOut));
	
	wire comparatorSelect;
	C_Comparator COMPARE (.op(CompOp), .in0(in0), .in1(in1), .out(comparatorSelect));
	
	
	always @ * begin
		case (ALUInput1Select)
			2'b00: ALUInput1 <= pcIn;
			2'b01: ALUInput1 <= spIn;
			default: ALUInput1 <= in1;
		endcase
		
		case (ALUInput2Select)
			2'b00: ALUInput2 <= immediate;
			2'b01: ALUInput2 <= in2;
			default: ALUInput2 <= in0;
		endcase
		
		case (PCOutSelect & {2{forcePCAlternate | comparatorSelect}})
			default: pcOut <= pcIncrementValue;
			2'b01: pcOut <= ALUOut;
			2'b10: pcOut <= raIn;
			2'b11: pcOut <= in0;
		endcase
		
		case (SPOutSelect)
			1'b0: spOut <= ALUOut;
			default: spOut <= in0;
		endcase
		
		case (RAOutSelect)
			1'b0: raOut <= memoryIn;
			default: raOut <= pcIncrementValue;
		endcase
		
		case (MemoryOutSelect)
			1'b0: memoryOut <= in0;
			default: memoryOut <= raIn;
		endcase
		
		case (MemoryAddrSelect)
			2'b00: memoryAddress <= in1;
			2'b01: memoryAddress <= spIn;
			default: memoryAddress <= ALUOut;
		endcase
		
		case (RegisterOutSelect)
			3'b000: out <= memoryIn;
			3'b001: out <= ALUOut;
			3'b010: out <= {immediate[7:0], in0[7:0]};
			3'b011: out <= immediate;
			3'b100: out <= shiftOut;
			3'b101: out <= spIn;
			3'b110: out <= pcIn;
			default: out <= inputLine;
		endcase
	end

endmodule
