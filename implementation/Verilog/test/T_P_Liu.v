`timescale 100ns / 10ns

module T_P_Liu ();

	reg doubleClk;
	
	reg clk;
	initial clk = 0;
	always @ (negedge doubleClk) clk = ~clk;
	
	reg rst;
	reg [15:0] inputLine;
	reg [15:0] outputLine;
	
	wire [15:0] instruction;
	
	wire [15:0] RegisterOut0;
	wire [15:0] RegisterOut1;
	wire [15:0] RegisterOut2;
	
	wire [15:0] spValue;
	wire [15:0] pcValue;
	wire [15:0] raValue;
	wire [15:0] memoryValue;
	
	
	wire GPRegisterWriteEnable;
	wire spWriteEnable;
	wire raWriteEnable;
	wire memoryWriteEnable;
	
	// PC Write is always enabled
	
	wire [15:0] registerDataInBus;
	wire [15:0] spDataInBus;
	wire [15:0] pcDataInBus;
	wire [15:0] raDataInBus;
	wire [15:0] memoryAddress;
	wire [15:0] memoryDataInBus;
	
	
	
	wire x0WriteEnable;
	wire x1WriteEnable;
	wire x2WriteEnable;
	wire x3WriteEnable;
	wire x4WriteEnable;
	wire x5WriteEnable;
	wire x6WriteEnable;
	wire x7WriteEnable;
	
	wire [15:0] x0Value;
	wire [15:0] x1Value;
	wire [15:0] x2Value;
	wire [15:0] x3Value;
	wire [15:0] x4Value;
	wire [15:0] x5Value;
	wire [15:0] x6Value;
	wire [15:0] x7Value;
	
	C_Decoder_3 REGISTER_WRITE_SELECT (.dis(~GPRegisterWriteEnable), .sel(instruction[2:0]), .out0(x0WriteEnable), .out1(x1WriteEnable), .out2(x2WriteEnable), .out3(x3WriteEnable), .out4(x4WriteEnable), .out5(x5WriteEnable), .out6(x6WriteEnable), .out7(x7WriteEnable));
	
	C_Register # (.BITS(16)) REGISTER_x0 (.clk(clk), .rst(rst), .save(x0WriteEnable), .in(registerDataInBus), .out(x0Value));
	C_Register # (.BITS(16)) REGISTER_x1 (.clk(clk), .rst(rst), .save(x1WriteEnable), .in(registerDataInBus), .out(x1Value));
	C_Register # (.BITS(16)) REGISTER_x2 (.clk(clk), .rst(rst), .save(x2WriteEnable), .in(registerDataInBus), .out(x2Value));
	C_Register # (.BITS(16)) REGISTER_x3 (.clk(clk), .rst(rst), .save(x3WriteEnable), .in(registerDataInBus), .out(x3Value));
	C_Register # (.BITS(16)) REGISTER_x4 (.clk(clk), .rst(rst), .save(x4WriteEnable), .in(registerDataInBus), .out(x4Value));
	C_Register # (.BITS(16)) REGISTER_x5 (.clk(clk), .rst(rst), .save(x5WriteEnable), .in(registerDataInBus), .out(x5Value));
	C_Register # (.BITS(16)) REGISTER_x6 (.clk(clk), .rst(rst), .save(x6WriteEnable), .in(registerDataInBus), .out(x6Value));
	C_Register # (.BITS(16)) REGISTER_x7 (.clk(clk), .rst(rst), .save(x7WriteEnable), .in(registerDataInBus), .out(x7Value));
	
	C_Mux_3 # (.BITS(16)) REGISTER_MUX_0 (.sel(instruction[2:0]), .in0(x0Value), .in1(x1Value), .in2(x2Value), .in3(x3Value), .in4(x4Value), .in5(x5Value), .in6(x6Value), .in7(x7Value), .out(RegisterOut0));
	C_Mux_3 # (.BITS(16)) REGISTER_MUX_1 (.sel(instruction[5:3]), .in0(x0Value), .in1(x1Value), .in2(x2Value), .in3(x3Value), .in4(x4Value), .in5(x5Value), .in6(x6Value), .in7(x7Value), .out(RegisterOut1));
	C_Mux_3 # (.BITS(16)) REGISTER_MUX_2 (.sel(instruction[8:6]), .in0(x0Value), .in1(x1Value), .in2(x2Value), .in3(x3Value), .in4(x4Value), .in5(x5Value), .in6(x6Value), .in7(x7Value), .out(RegisterOut2));
	
	
	
	
	
	
	
	C_Register # (.BITS(16)) REGISTER_sp (
		.clk(clk),
		.rst(rst),
		.save(spWriteEnable),
		.in(spDataInBus),
		.out(spValue)
	);
	
	C_Register # (.BITS(16)) REGISTER_pc (
		.clk(clk),
		.rst(rst),
		.save(1'b1),
		.in(pcDataInBus),
		.out(pcValue)
	);
	
	C_Register # (.BITS(16)) REGISTER_ra (
		.clk(clk),
		.rst(rst),
		.save(raWriteEnable),
		.in(raDataInBus),
		.out(raValue)
	);
	
	C_Memory MEMORY (
		.in(memoryDataInBus),
		.addr_inst({1'b0, pcDataInBus[15:1]}),
		.addr_data({1'b0, memoryAddress[15:1]}),
		.save(memoryWriteEnable & (~clk)),
		.clk_inst(clk),
		.clk_data(doubleClk),
		.out_inst(instruction),
		.out_data(memoryValue)
	);
	
	
	
	wire [1:0] ALUInput1Select;
	wire [1:0] ALUInput2Select;
	wire [2:0] ALUOp;
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
		
		.in0(RegisterOut0),
		.in1(RegisterOut1),
		.in2(RegisterOut2),
		.spIn(spValue),
		.pcIn(pcValue),
		.raIn(raValue),
		.memoryIn(memoryValue),
		.immediate(immediate),

		.out(registerDataInBus),
		.spOut(spDataInBus),
		.pcOut(pcDataInBus),
		.raOut(raDataInBus),
		.memoryAddress(memoryAddress),
		.memoryOut(memoryDataInBus),
		
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

	wire outputLineWrite;

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
		
		
		.registerWrite(GPRegisterWriteEnable),
		.spWrite(spWriteEnable),
		.raWrite(raWriteEnable),
		.memoryWrite(memoryWriteEnable),
		.outputLineWrite(outputLineWrite),
		
		.forcePCAlternate(forcePCAlternate)

	);

	C_Immediate IMMEDIATE_GENERATOR (
		.instruction(instruction),
		.immediate(immediate)
	);
	
	// assign outputLine = RegisterOut0 & {16{outputLineWrite}};
	
	always @ outputLineWrite begin
		case (outputLineWrite)
			1'b0: outputLine = 0;
			default: outputLine = RegisterOut0;
		endcase
	end
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	initial begin
		doubleClk = 0;
		forever begin
			#5 doubleClk = ~doubleClk;
		end
	end
	
	initial begin
		rst = 1;
		inputLine = 5040;
		
		#70;  
		
		rst = 0;
	end

endmodule


















