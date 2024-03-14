module L_ALU_Complex (
    in0,
    in1,
    in2,
    out,
    spIn,
    spOut,
    pcIn,
    pcOut,
    raIn,
    raOut,
    memoryAddress,
    memoryIn,
    memoryOut,
    instruction,
    registerWrite,
    spWrite,
    pcWrite,
    raWrite,
    memoryWrite,
    inputLine,
    outputLine
);

  // Handles the control of the smaller registers, patching proper connections

  input [15:0] instruction;
  output [15:0] memoryAddress;

  input [15:0] in0;
  input [15:0] in1;
  input [15:0] in2;
  input [15:0] spIn;
  input [15:0] pcIn;
  input [15:0] raIn;
  input [15:0] memoryIn;

  output [15:0] out;
  output [15:0] spOut;
  output [15:0] pcOut;
  output [15:0] raOut;
  output [15:0] memoryOut;

  output registerWrite;
  output spWrite;
  output pcWrite;
  output raWrite;
  output memoryWrite;

  input [15:0] inputLine;
  output [15:0] outputLine;

  // Need to check logic later

  parameter CYCLE_TIME = 1;

  reg  [15:0] out_reg;
  reg  [15:0] memory_out_reg;
  reg  [15:0] memory_address_reg;

  reg  [0:0] pc_write_reg;
  reg  [0:0] ra_write_reg;
  reg  [0:0] sp_write_reg;
  reg  [0:0] memory_write_reg;
  reg  [0:0] register_write_reg;
  reg  [0:0] outputLine_reg;

  reg  [15:0] pc_out_reg;
  reg  [15:0] ra_out_reg;
  reg  [15:0] sp_out_reg;

  //-------------------------------
  //
  // Create ALU Modules
  //
  //-------------------------------


  wire [15:0] ALU1_PC_out;
  wire [15:0] ALU1_PC_write;
  L_ALU_1 ALU1 (
		.control(instruction[14:13]),
		.immediate(instruction[12:6]),
		.in0(in0),
		.in1(in1),
		.pcIn(pcIn),
		.pcOut(ALU1_PC_out),
		.pcWrite(ALU1_PC_write)
  );


  wire [15:0] ALU2_memory_out;
  wire [15:0] ALU2_memory_address;
  L_ALU_2 ALU2(
	.immediate(instruction[11:3]), 
	.in0(in0), 
	.spIn(spIn), 
	.memoryAddress(ALU2_memory_address), 
	.memoryOut(ALU2_memory_out));


   wire [15:0] ALU3_out;
   wire [15:0] ALU3_memory_address;
   L_ALU_3 ALU3 (
	.immediate(instruction[11:3]), 
	.out(ALU3_out), 
	.spIn(spIn), 
	.memoryAddress(ALU3_memory_address), 
	.memoryIn(memoryIn));


  wire [15:0] ALU4_out;
  L_ALU_4 ALU4 (
		.immediate(instruction[11:3]),
		.in0(in0),
		.out(ALU4_out)
  );

  wire [15:0] ALU5_out;
  L_ALU_5 ALU5 (
	.immediate(instruction[10:3]),
	.out(ALU5_out));

  wire [15:0] ALU6_out;
  L_ALU_6 ALU6 (
	.immediate(instruction[10:3]),
	.in0(in0), 
	.out(ALU6_out));

  wire [15:0] ALU7_out;
  L_ALU_7 ALU7 (
	.immediate(instruction[10:3]),
	.in0(in0),
	.out(ALU7_out));

  wire [15:0] ALU8_SP_out;
  wire [15:0] ALU8_PC_out;
  L_ALU_8 ALU8 (
	.control(instruction[10]),
	.immediate(instruction[9:0]),
	.spIn(spIn),
	.spOut(ALU8_SP_out),
	.pcIn(pcIn),
	.pcOut(ALU8_PC_out));


  wire [15:0] ALU9_PC_out;
  wire [15:0] ALU9_RA_out;
  wire [15:0] ALU9_memory_address;
  wire [15:0] ALU9_memory_out;
  L_ALU_9 ALU9(
	.immediate(instruction[9:0]), 
	.spIn(spIn), 
	.pcIn(pcIn), 
	.pcOut(ALU9_PC_out), 
	.raIn(raIn), 
	.raOut(ALU9_RA_out), 
	.memoryAddress(ALU9_memory_address), 
	.memoryIn(memoryIn), 
	.memoryOut(ALU9_memory_out));

  wire [15:0] ALU10_PC_out;
  wire [15:0] ALU10_SP_out;
  wire [15:0] ALU10_RA_out;
  wire [15:0] ALU10_memory_out;
  wire [15:0] ALU10_memory_address;
  L_ALU_10 ALU10(
	.immediate(instruction[9:0]), 
	.spIn(spIn), 
	.spOut(ALU10_SP_out), 
	.pcIn(pcIn), 
	.pcOut(ALU10_PC_out), 
	.raIn(raIn), 
	.raOut(ALU10_RA_out), 
	.memoryIn(memoryIn));


  wire [15:0] ALU11_out;
  L_ALU_11 ALU11 (
      .control(instruction[12:10]),
      .in0(in0),
      .in1(in1),
      .dout(ALU11_out)
  );

  wire [15:0] ALU12_memory_out;
  wire [15:0] ALU12_memory_address;
  L_ALU_12 ALU12(
	.in0(in0), 
  	.in1(in1), 
	.memoryAddress(ALU12_memory_address), 
	.memoryOut(ALU12_memory_out));


  wire [15:0] ALU13_out;
  wire [15:0] ALU13_memory_address;
  L_ALU_13 ALU13(
	.in0(in0), 
  	.memoryIn(memoryIn), 
	.out(ALU13_out),
	.memoryAddress(ALU13_memory_address));

  wire [15:0] ALU14_out;
  L_ALU_14 ALU14(
  	.out(ALU14_out), 
  	.inputLine(inputLine));

  wire [15:0] ALU15_SP_out;
  wire [15:0] ALU15_PC_out;
  L_ALU_15 ALU15(
	.control({instruction[9], instruction[3]}), 
	.in0(in0), 
	.spIn(spIn), 
	.spOut(ALU15_SP_out), 
	.pcIn(pcIn), 
	.pcOut(ALU15_PC_out));

  wire [15:0] ALU16_out;
  L_ALU_16 ALU16(
	.in0(in0), 
  	.out(ALU16_out));

  wire [15:0] ALU17_out;
  L_ALU_17 ALU17(
	.control(instruction[9]), 
	.out(ALU17_out), 
	.spIn(spIn), 
	.pcIn(pcIn));



  //-------------------------------
  //
  // Implementing logic
  //
  //-------------------------------

  always begin

	pc_write_reg <= 1'b0;
	ra_write_reg <= 1'b0;
	sp_write_reg <= 1'b0;
	memory_write_reg <= 1'b0;
	register_write_reg <= 1'b0;

    #(CYCLE_TIME);

    case (instruction[15:13])

	  // ALU1
      // EQ
      3'b100,
	  // LT
	  3'b101,
	  // NEQ
      3'b110,
	  // GEQ
      3'b111: begin
		pc_out_reg <= ALU1_PC_out;
		pc_write_reg <= ALU1_PC_write;
	  end

	  // ALU2
	  // STRSP
	  3'b010: begin
		memory_out_reg <= ALU2_memory_out;
		memory_address_reg <= ALU2_memory_address;
		memory_write_reg <= 1'b1;
	  end

	  // ALU3
	  // RTVSP
	  3'b010: begin
		memory_address_reg <= ALU3_memory_address;
		out_reg <= ALU3_out;
		register_write_reg <= 1'b1;
	  end

      // ADDI
      3'b001:
	  begin
		case (instruction[12:12])
			// ALU4: ADDI
			1'b0: begin 
				out_reg <= ALU4_out;
				register_write_reg <= 1'b1;
			end

			// SHIFT, RETURN, JUMP
			1'b1: begin
				case(instruction[11:11])
					// SHIFT
					1'b0: out_reg <= ALU7_out;
					// RETURN, JUMP
					1'b1: begin 
						case(instruction[10:10])
							// RETURN
							1'b0: begin
								pc_out_reg <= ALU10_PC_out;
								pc_write_reg <= 1'b1;
								sp_out_reg <= ALU10_SP_out;
								sp_write_reg <= 1'b1;
								ra_out_reg <= ALU10_RA_out;
								ra_write_reg <= 1'b1;
								memory_out_reg <= ALU10_memory_out;
								memory_address_reg <= ALU10_memory_address;
								memory_write_reg <= 1'b1;

							end
							// JUMP
							1'b1: begin
								pc_out_reg <= ALU9_PC_out;
								pc_write_reg <= 1'b1;
								ra_out_reg <= ALU9_RA_out;
								ra_write_reg <= 1'b1;
								memory_out_reg <= ALU9_memory_out;
								memory_address_reg <= ALU9_memory_address;
								memory_write_reg <= 1'b1;
							end
						endcase
					end
				endcase
			end
	  	endcase
	  end

	  3'b011: begin
		case (instruction[12:12])

			1'b1: begin
				case(instruction[11:11])

					1'b0: begin
						case(instruction[10:10])
							1'b0: begin
								case(instruction[9:9])
									1'b0: begin
										case(instruction[8:6])
										    // STR
											3'b010: begin
												memory_out_reg <= ALU12_memory_out;
												memory_address_reg <= ALU12_memory_address;
												memory_write_reg <= 1'b1;
											end

											// RTV
											3'b011: begin
												memory_address_reg <= ALU13_memory_address;
												out_reg <= ALU13_out;
												register_write_reg <= 1'b1;
											end

											3'b100: begin
												case(instruction[5:3])
												    // READ
													3'b000: begin
														out_reg <= ALU14_out;
														register_write_reg <= 1'b1;
													end

													// WRITE
													3'b001: begin
														outputLine_reg <= ALU16_out;
													end
												endcase
											end

										endcase
									end
									1'b1: begin
									end
								endcase
							end

							// CHGSP, SETSP, CHGPC, SETPC, GETSP, GETPC
							1'b1: begin
								case(instruction[8:6])
									// CHGSP, SETSP, CHGPC, SETPC
									3'b100: begin
										sp_out_reg <= ALU15_SP_out;
										sp_write_reg <= 1'b1;
										pc_out_reg <= ALU15_PC_out;
										pc_write_reg <= 1'b1;
									end

									// GETSP, GETPC
									3'b000: begin
										out_reg <= ALU17_out;
										register_write_reg <= 1'b1;
									end

								endcase
							end
						endcase
					end

					// ALU8: CHGSPI, CHGPCI
					1'b1: begin
						sp_out_reg <= ALU8_SP_out;
						sp_write_reg <= 1'b1;
						pc_out_reg <= ALU8_PC_out;
						pc_write_reg <= 1'b1;
					end
				
				endcase
			end
		endcase
	  end

      
      3'b000: begin
		case (instruction[12:12])
			// ALU11: Arithmetic Operations
			1'b0: begin
				out_reg <= ALU11_out;
				register_write_reg <= 1'b1;
			end

			// LL and LU
			1'b1: begin
				case(instruction[11:11])
					// ALU5: LL
					1'b0: begin 
						out_reg <= ALU5_out;
						register_write_reg <= 1'b1;
					end
					// ALU6: LU
					1'b1: begin
						out_reg <= ALU6_out;
						register_write_reg <= 1'b1;
					end
				endcase
			end
	  	endcase
	  end

      // default: $display("ALU: Deafult");

    endcase

  end


  assign out = out_reg;
  assign memoryOut = memory_out_reg;
  assign memoryAddress = memory_address_reg;

  assign pcOut = pc_out_reg;
  assign raOut = ra_out_reg;
  assign spOut = sp_out_reg;

  assign pcWrite = pc_write_reg;
  assign raWrite = ra_write_reg;
  assign spWrite = sp_write_reg;
  assign memoryWrite = memory_write_reg;
  assign registerWrite = register_write_reg;
  assign outputLine = outputLine_reg;

endmodule
