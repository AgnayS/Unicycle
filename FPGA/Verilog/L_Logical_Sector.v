module L_Logical_Sector (

	input [15:0] instruction,
	
	input [15:0] inputLine,
	output reg [15:0] outputLine,
	output outputLineWrite,
	
	input [15:0] in0,
	input [15:0] in1,
	input [15:0] in2,
	input [15:0] spIn,
	input [15:0] pcIn,
	input [15:0] raIn,
	input [15:0] memoryIn,

	output [15:0] out,
	output [15:0] spOut,
	output [15:0] pcOut,
	output [15:0] raOut,
	output [15:0] memoryAddress,
	output [15:0] memoryOut,
	
	output registerWrite,
	output spWrite,
	output raWrite,
	output memoryWrite
);



	wire [1:0] ALUInput1Select;
	wire [1:0] ALUInput2Select;
	wire [2:0] ALUOp;
	wire [1:0] CompOp;
	wire [1:0] PCOutSelect;
	wire [0:0] SPOutSelect;
	wire [0:0] RAOutSelect;
	wire [1:0] MemoryAddrSelect;
	wire [0:0] MemoryOutSelect;
	wire [2:0] RegisterOutSelect;
	wire [4:0] shiftAmount;

	wire [15:0] immediate;

	wire forcePCAlternate;



	L_Value_Selection VALUE_ROUTING (

		.inputLine(inputLine),
		
		.in0(in0),
		.in1(in1),
		.in2(in2),
		.spIn(spIn),
		.pcIn(pcIn),
		.raIn(raIn),
		.memoryIn(memoryIn),
		.immediate(immediate),

		.out(out),
		.spOut(spOut),
		.pcOut(pcOut),
		.raOut(raOut),
		.memoryAddress(memoryAddress),
		.memoryOut(memoryOut),
		
		.ALUInput1Select(ALUInput1Select),
		.ALUInput2Select(ALUInput2Select),
		.ALUOp(ALUOp),
		.CompOp(instruction[14:13]),
		.PCOutSelect(PCOutSelect),
		.SPOutSelect(SPOutSelect),
		.RAOutSelect(RAOutSelect),
		.MemoryAddrSelect(MemoryAddrSelect),
		.MemoryOutSelect(MemoryOutSelect),
		.RegisterOutSelect(RegisterOutSelect),
		.shiftAmount(shiftAmount),
		
		.forcePCAlternate(forcePCAlternate)
		// This is here so that no additional case needs bne added to PCOut. This is disabled if the instruction is a branching statement, otherwise it's enabled.
		
	);

	L_Control CONTROL_GENERATOR (
		
		.in(instruction),

		.ALUInput1Select(ALUInput1Select),
		.ALUInput2Select(ALUInput2Select),
		.ALUOp(ALUOp),
		.PCOutSelect(PCOutSelect),
		.SPOutSelect(SPOutSelect),
		.RAOutSelect(RAOutSelect),
		.MemoryAddrSelect(MemoryAddrSelect),
		.MemoryOutSelect(MemoryOutSelect),
		.RegisterOutSelect(RegisterOutSelect),
		.shiftAmount(shiftAmount),
		
		.registerWrite(registerWrite),
		.spWrite(spWrite),
		.raWrite(raWrite),
		.memoryWrite(memoryWrite),
		.outputLineWrite(outputLineWrite),
		
		.forcePCAlternate(forcePCAlternate)

	);

	C_Immediate IMMEDIATE_GENERATOR (
		.instruction(instruction),
		.immediate(immediate)
	);
	
	// assign outputLine = in0 & {16{outputLineWrite}};
	
	always @ outputLineWrite begin
		case (outputLineWrite)
			1'b0: outputLine = 0;
			default: outputLine = in0;
		endcase
	end

endmodule
