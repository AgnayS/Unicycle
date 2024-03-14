`timescale 1ns / 100ps

module P_Liu_Clock_Mod_2 (
	input doubleClk,
	input clk,
	input rst,	
	input [15:0] inputLine,
	output [15:0] outputLine

);

	wire [15:0] instruction;
	
	wire [15:0] RegisterOut0;
	wire [15:0] RegisterOut1;
	wire [15:0] RegisterOut2;
	
	wire [15:0] registerDataInBus;
	wire [15:0] spDataInBus;
	wire [15:0] pcDataInBus;
	wire [15:0] raDataInBus;
	wire [15:0] memoryAddress;
	wire [15:0] memoryDataInBus;
	
	wire GPRegisterWriteDisable;
	wire GPRegisterWriteEnable;
	assign GPRegisterWriteDisable = ~GPRegisterWriteEnable;
	
	wire spWriteEnable;
	wire raWriteEnable;
	wire memoryWriteEnable;
	
	// PC Write is always enabled
	
	wire [15:0] spValue;
	wire [15:0] pcValue;
	wire [15:0] raValue;
	wire [15:0] memoryValue;
	
	
	L_Register_File REGISTER_FILE (
		.sel0(instruction[2:0]),
		.sel1(instruction[5:3]),
		.sel2(instruction[8:6]),
		.writeDisable(GPRegisterWriteDisable),
		.in(registerDataInBus),
		.clk(singleClk),
		.rst(rst),
		.out0(RegisterOut0),
		.out1(RegisterOut1),
		.out2(RegisterOut2)
	);
	
	C_Register # (.BITS(16)) REGISTER_sp (
		.clk(singleClk),
		.rst(rst),
		.save(spWriteEnable),
		.in(spDataInBus),
		.out(spValue)
	);
	
	C_Register # (.BITS(16)) REGISTER_pc (
		.clk(singleClk),
		.rst(rst),
		.save(1'b1),
		.in(pcDataInBus),
		.out(pcValue)
	);
	
	C_Register # (.BITS(16)) REGISTER_ra (
		.clk(singleClk),
		.rst(rst),
		.save(raWriteEnable),
		.in(raDataInBus),
		.out(raValue)
	);
	
	C_Memory MEMORY (
		.in(memoryDataInBus),
		.addr_inst({1'b0, pcDataInBus[15:1]}),
		.addr_data({1'b0, memoryAddress[15:1]}),
		.save(memoryWriteEnable & (~singleClk)),
		.clk_inst(singleClk),
		.clk_data(doubleClk),
		.out_inst(instruction),
		.out_data(memoryValue)
	);
	
	L_Logical_Sector Logic (
	
		.instruction(instruction),
		
		.inputLine(inputLine),
		.outputLine(outputLine),
	
		.in0(RegisterOut0),
		.in1(RegisterOut1),
		.in2(RegisterOut2),
		.spIn(spValue),
		.pcIn(pcValue),
		.raIn(raValue),
		.memoryIn(memoryValue),
		
		.out(registerDataInBus),
		.spOut(spDataInBus),
		.pcOut(pcDataInBus),
		.raOut(raDataInBus),
		.memoryAddress(memoryAddress),
		.memoryOut(memoryDataInBus),
		
		.registerWrite(GPRegisterWriteEnable),
		.spWrite(spWriteEnable),
		.raWrite(raWriteEnable),
		.memoryWrite(memoryWriteEnable)
	);
	
endmodule

