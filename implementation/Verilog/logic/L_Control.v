module L_Control (
	
	input [15:0] in,

	output reg [1:0] ALUInput1Select,
	output reg [1:0] ALUInput2Select,
	output reg [2:0] ALUOp,
	output reg [1:0] PCOutSelect,
	output reg [0:0] SPOutSelect,
	output reg [0:0] RAOutSelect,
	output reg [1:0] MemoryAddrSelect,
	output reg [0:0] MemoryOutSelect,
	output reg [2:0] RegisterOutSelect,
	output reg [4:0] shiftAmount,
	
	output reg registerWrite,
	output reg spWrite,
	output reg raWrite,
	output reg memoryWrite,
	output reg outputLineWrite,
	
	output reg forcePCAlternate // Should PC force the alternate value (ignore comparator)?

);



	always @ in begin
		
		ALUInput1Select = 0;
		ALUInput2Select = 0;
		ALUOp = 0;
		RegisterOutSelect = 0;
		SPOutSelect = 0;
		PCOutSelect = 0;
		RAOutSelect = 0;
		MemoryAddrSelect = 0;
		MemoryOutSelect = 0;
		shiftAmount = 0;
		registerWrite = 0;
		spWrite = 0;
		raWrite = 0;
		memoryWrite = 0;
		outputLineWrite = 0;
		forcePCAlternate = 0;
		
		// If an instruction want to force selecting the default +2 value for PC, set PCOutSelect to 0.
		// If an instruction want to force selecting the alternate value for PC, set PCOutSelect to the alternate value and enable forcePCAlternate.
										
		case (in [15:13])
			3'b000:
				case (in [12])
					1'b0:
						begin
							ALUInput1Select = 2;
							ALUInput2Select = 1;
							ALUOp	= in[11:9];
							registerWrite = 1;
							RegisterOutSelect = 1;
						end
					default:
						begin
							case (in[11])
								1'b0:
									begin
										// LU
										//ALUInput1Select = 0;
										//ALUInput2Select = 0;
										//ALUOp = 0;
										RegisterOutSelect = 2;
										//SPOutSelect = 0;
										PCOutSelect = 0;
										//RAOutSelect = 0;
										//MemoryAddrSelect = 0;
										//MemoryOutSelect = 0;
										//shiftAmount = 0;
										registerWrite = 1;
										spWrite = 0;
										raWrite = 0;
										memoryWrite = 0;
										forcePCAlternate = 0;
									end
								default:
									begin
										// LL
										//ALUInput1Select = 0;
										//ALUInput2Select = 0;
										//ALUOp = 0;
										RegisterOutSelect = 3;
										//SPOutSelect = 0;
										PCOutSelect = 0;
										//RAOutSelect = 0;
										//MemoryAddrSelect = 0;
										//MemoryOutSelect = 0;
										//shiftAmount = 0;
										registerWrite = 1;
										spWrite = 0;
										raWrite = 0;
										memoryWrite = 0;
										forcePCAlternate = 0;
									end
							endcase
						end
				endcase
			3'b001:
				case (in[12])
					1'b0:
						begin
							// ADDI
							ALUInput1Select = 2;
							ALUInput2Select = 0;
							ALUOp = 0;
							RegisterOutSelect = 1;
							//SPOutSelect = 0;
							PCOutSelect = 0;
							//RAOutSelect = 0;
							//MemoryAddrSelect = 0;
							//MemoryOutSelect = 0;
							//shiftAmount = 0;
							registerWrite = 1;
							spWrite = 0;
							raWrite = 0;
							memoryWrite = 0;
							forcePCAlternate = 0;
						end
					default:
						case (in[11])
							1'b0:
									begin
										// SHIFT
										//ALUInput1Select = 0;
										//ALUInput2Select = 0;
										//ALUOp = 0;
										RegisterOutSelect = 4;
										//SPOutSelect = 0;
										PCOutSelect = 0;
										//RAOutSelect = 0;
										//MemoryAddrSelect = 0;
										//MemoryOutSelect = 0;
										shiftAmount = in[10:6]; 
										registerWrite = 1;
										spWrite = 0;
										raWrite = 0;
										memoryWrite = 0;
										forcePCAlternate = 0;
									end
							default:
								case (in[10])
									1'b0:
										begin
											// RETURN
											ALUInput1Select = 1;
											ALUInput2Select = 0;
											ALUOp = 0;
											//RegisterOutSelect = 0;
											SPOutSelect = 0;
											PCOutSelect = 2;
											RAOutSelect = 0;
											MemoryAddrSelect = 2;
											//MemoryOutSelect = 0;
											//shiftAmount = 0;
											registerWrite = 0;
											spWrite = 1;
											raWrite = 1;
											memoryWrite = 0;
											forcePCAlternate = 1;
										end
									1'b1:
									begin
										// JUMP
										ALUInput1Select = 0;
										ALUInput2Select = 0;
										ALUOp = 0;
										//RegisterOutSelect = 0;
										//SPOutSelect = 0;
										PCOutSelect = 1;
										RAOutSelect = 1;
										MemoryAddrSelect = 1;
										MemoryOutSelect = 1;
										//shiftAmount = 0;
										registerWrite = 0;
										spWrite = 0;
										raWrite = 1;
										memoryWrite = 1;
										forcePCAlternate = 1;
									end
									default: ;
								endcase
						endcase
				endcase
			3'b010:
				case (in [12])
					1'b0:
						begin
							// STRSP
							//double check MemAddr/MemOut
							ALUInput1Select = 1;
							ALUInput2Select = 0;
							ALUOp = 0;
							RegisterOutSelect = 0;
							//SPOutSelect = 0;
							PCOutSelect = 0;
							//RAOutSelect = 0;
							MemoryAddrSelect = 1;
							MemoryOutSelect = 0;
							//shiftAmount = 0;
							registerWrite = 0;
							spWrite = 0;
							raWrite = 0;
							memoryWrite = 1;
							forcePCAlternate = 0;
						end
					default: 
						begin
							// RTVSP
							ALUInput1Select = 1;
							ALUInput2Select = 0;
							ALUOp = 0;
							RegisterOutSelect = 0;
							//SPOutSelect = 0;
							PCOutSelect = 0;
							//RAOutSelect = 0;
							//MemoryAddrSelect = 0;
							//MemoryOutSelect = 0;
							//shiftAmount = 0;
							registerWrite = 1;
							spWrite = 0;
							raWrite = 0;
							memoryWrite = 0;
							forcePCAlternate = 0;
						end
				endcase
			3'b011:
				case (in [12:10])
					3'b100 :
						case (in [9:6])
							4'b0010:
								begin
									// STR
									//ALUInput1Select = 0;
									//ALUInput2Select = 0;
									//ALUOp = 0;
									//RegisterOutSelect = 0;
									//SPOutSelect = 0;
									PCOutSelect = 0;
									//RAOutSelect = 0;
									MemoryAddrSelect = 0;
									MemoryOutSelect = 0;
									//shiftAmount = 0;
									registerWrite = 0;
									spWrite = 0;
									raWrite = 0;
									memoryWrite = 1;
									forcePCAlternate = 0;
								end
							4'b0011:
								begin
									// RTV
									//ALUInput1Select = 0;
									//ALUInput2Select = 0;
									//ALUOp = 0;
									RegisterOutSelect = 0;
									//SPOutSelect = 0;
									PCOutSelect = 0;
									//RAOutSelect = 0;
									MemoryAddrSelect = 0;
									//MemoryOutSelect = 0;
									//shiftAmount = 0;
									registerWrite = 1;
									spWrite = 0;
									raWrite = 0;
									memoryWrite = 0;
									forcePCAlternate = 0;
								end
							default :
								case (in [5:3])
									3'b000:
										begin
											// READ
											//ALUInput1Select = 0;
											//ALUInput2Select = 0;
											//ALUOp = 0;
											RegisterOutSelect = 7;
											//SPOutSelect = 0;
											PCOutSelect = 0;
											//RAOutSelect = 0;
											//MemoryAddrSelect = 0;
											//MemoryOutSelect = 0;
											//shiftAmount = 0;
											registerWrite = 1;
											spWrite = 0;
											raWrite = 0;
											memoryWrite = 0;
											forcePCAlternate = 0;

										end
									default:
										begin
											// WRITE
											//ALUInput1Select = 0;
											//ALUInput2Select = 0;
											//ALUOp = 0;
											//RegisterOutSelect = 0;
											//SPOutSelect = 0;
											PCOutSelect = 0;
											//RAOutSelect = 0;
											//MemoryAddrSelect = 0;
											//MemoryOutSelect = 0;
											//shiftAmount = 0;
											registerWrite = 0;
											spWrite = 0;
											raWrite = 0;
											memoryWrite = 0;
											outputLineWrite = 1;
											forcePCAlternate = 0;
										end
								endcase
						endcase
					3'b101 :
						case (in [9:3])
							7'b0000000:
									begin
										// GETSP
										//ALUInput1Select = 0;
										//ALUInput2Select = 0;
										//ALUOp = 0;
										RegisterOutSelect = 5;
										//SPOutSelect = 0;
										PCOutSelect = 0;
										//RAOutSelect = 0;
										//MemoryAddrSelect = 0;
										//MemoryOutSelect = 0;
										//shiftAmount = 0;
										registerWrite = 1;
										spWrite = 0;
										raWrite = 0;
										memoryWrite = 0;
										forcePCAlternate = 0;
									end
							7'b0100000:
									begin
										// CHGSP
										ALUInput1Select = 1;
										ALUInput2Select = 2;
										ALUOp = 0;
										//RegisterOutSelect = 0;
										SPOutSelect = 0;
										PCOutSelect = 0;
										//RAOutSelect = 0;
										//MemoryAddrSelect = 0;
										//MemoryOutSelect = 0;
										//shiftAmount = 0;
										registerWrite = 0;
										spWrite = 1;
										raWrite = 0;
										memoryWrite = 0;
										forcePCAlternate = 0;
									end
							7'b0100001:
									begin
										// SETSP
										//ALUInput1Select = 0;
										//ALUInput2Select = 0;
										//ALUOp = 0;
										//RegisterOutSelect = 0;
										SPOutSelect = 1;
										PCOutSelect = 0;
										//RAOutSelect = 0;
										//MemoryAddrSelect = 0;
										//MemoryOutSelect = 0;
										//shiftAmount = 0;
										registerWrite = 0;
										spWrite = 1;
										raWrite = 0;
										memoryWrite = 0;
										forcePCAlternate = 0;
									end
							7'b1000000:
									begin
										// GETPC
										//ALUInput1Select = 0;
										//ALUInput2Select = 0;
										//ALUOp = 0;
										RegisterOutSelect = 6;
										//SPOutSelect = 0;
										PCOutSelect = 0;
										//RAOutSelect = 0;
										//MemoryAddrSelect = 0;
										//MemoryOutSelect = 0;
										//shiftAmount = 0;
										registerWrite = 1;
										spWrite = 0;
										raWrite = 0;
										memoryWrite = 0;
										forcePCAlternate = 0;
									end
							7'b1100000:
									begin
										// CHGPC
										ALUInput1Select = 0;
										ALUInput2Select = 2;
										ALUOp = 0;
										//RegisterOutSelect = 0;
										//SPOutSelect = 0;
										PCOutSelect = 1;
										//RAOutSelect = 0;
										//MemoryAddrSelect = 0;
										//MemoryOutSelect = 0;
										shiftAmount = 0;
										registerWrite = 0;
										spWrite = 0;
										raWrite = 0;
										memoryWrite = 0;
										forcePCAlternate = 1;
									end
							default:
									begin
										// SETPC
										//ALUInput1Select = 0;
										//ALUInput2Select = 0;
										//ALUOp = 0;
										//RegisterOutSelect = 0;
										//SPOutSelect = 0;
										PCOutSelect = 3;
										//RAOutSelect = 0;
										//MemoryAddrSelect = 0;
										//MemoryOutSelect = 0;
										//shiftAmount = 0;
										registerWrite = 0;
										spWrite = 0;
										raWrite = 0;
										memoryWrite = 0;
										forcePCAlternate = 1;
									end
						endcase
					3'b110 :
						begin
							// CHGSPI
							ALUInput1Select = 1;
							ALUInput2Select = 0;
							ALUOp = 0;
							//RegisterOutSelect = 0;
							SPOutSelect = 0;
							PCOutSelect = 0;
							//RAOutSelect = 0;
							//MemoryAddrSelect = 0;
							//MemoryOutSelect = 0;
							//shiftAmount = 0;
							registerWrite = 0;
							spWrite = 1;
							raWrite = 0;
							memoryWrite = 0;
							forcePCAlternate = 0;
						end
					default:
						begin
							// CHGPCI
							ALUInput1Select = 0;
							ALUInput2Select = 0;
							ALUOp = 0;
							RegisterOutSelect = 0;
							SPOutSelect = 0;
							PCOutSelect = 1;
							//RAOutSelect = 0;
							//MemoryAddrSelect = 0;
							//MemoryOutSelect = 0;
							//shiftAmount = 0;
							registerWrite = 0;
							spWrite = 0;
							raWrite = 0;
							memoryWrite = 0;
							forcePCAlternate = 1;
						end
				endcase
			default:
				begin
					// EQ, NEQ, LT, GEQ
					ALUInput1Select = 0;
					ALUInput2Select = 0;
					ALUOp = 0;
					//RegisterOutSelect = 0;
					//SPOutSelect = 0;
					PCOutSelect = 1;
					//RAOutSelect = 0;
					//MemoryAddrSelect = 0;
					//MemoryOutSelect = 0;
					//shiftAmount = 0;
					registerWrite = 0;
					spWrite = 0;
					raWrite = 0;
					memoryWrite = 0;
					forcePCAlternate = 0;
				end
		endcase
	end
endmodule
