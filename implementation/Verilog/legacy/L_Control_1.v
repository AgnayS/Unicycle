module L_Control (in, ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, SETPC, CHGPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ);

	input [15:0] in;
	output reg ADD;
	output reg AND;
	output reg OR;
	output reg XOR;
	output reg SUB;
	output reg NAND;
	output reg NOR;
	output reg XNOR;
	output reg LU;
	output reg LL;
	output reg ADDI;
	output reg SHIFT;
	output reg RETURN;
	output reg JUMP;
	output reg STRSP;
	output reg RTVSP;
	output reg STR;
	output reg RTV;
	output reg READ;
	output reg WRITE;
	output reg GETSP;
	output reg CHGSP;
	output reg SETSP;
	output reg GETPC;
	output reg SETPC;
	output reg CHGPC;
	output reg CHGSPI;
	output reg CHGPCI;
	output reg EQ;
	output reg LT;
	output reg NEQ;
	output reg GEQ;

	always @ in
	begin
		
		{ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, SETPC, CHGPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'b0;
		
		case (in [15:13])
			3'b000:
				case (in [12])
					1'b0:
						case (in [11:9])
							3'b000 : ADD = 1'b1;
							3'b001 : AND = 1'b1;
							3'b010 : OR = 1'b1;
							3'b011 : XOR = 1'b1;
							3'b100 : SUB = 1'b1;
							3'b101 : NAND = 1'b1;
							3'b110 : NOR = 1'b1;
							3'b111 : XNOR = 1'b1;
							default: ;
						endcase
					1'b1:
						case (in [11])
							1'b0: LU = 1'b1;
							1'b1: LL = 1'b1;
							default: ;
						endcase
					default: ;
				endcase
			3'b001:
				case (in [12])
					1'b0: ADDI = 1'b1;
					1'b1:
						case (in [11])
							1'b0: SHIFT = 1'b1;
							1'b1:
								case (in [10])
									1'b0: RETURN = 1'b1;
									1'b1: JUMP = 1'b1;
									default: ;
								endcase
							default: ;
						endcase
					default: ;
				endcase
			3'b010:
				case (in [12])
					1'b0: STRSP = 1'b1;
					1'b1: RTVSP = 1'b1;
					default: ;
				endcase
			3'b011:
				case (in [12:10])
					3'b100 :
						case (in [9:6])
							4'b0010: STR = 1'b1;
							4'b0011: RTV = 1'b1;
							4'b0100 :
								case (in [5:3])
									3'b000: READ = 1'b1;
									3'b001: WRITE = 1'b1;
									default: ;
								endcase
							default: ;
						endcase
					3'b101 :
						case (in [9:3])
							7'b0000000: GETSP = 1'b1;
							7'b0100000: CHGSP = 1'b1;
							7'b0100001: SETSP = 1'b1;
							7'b1000000: GETPC = 1'b1;
							7'b1100000: CHGPC = 1'b1;
							7'b1100001: SETPC = 1'b1;
							default: ;
						endcase
					3'b110 : CHGSPI = 1'b1;
					3'b111 : CHGPCI = 1'b1;
					default: ;
				endcase
			3'b100: EQ = 1'b1;
			3'b101: LT = 1'b1;
			3'b110: NEQ = 1'b1;
			3'b111: GEQ = 1'b1;
			default: ;
		endcase
	end
endmodule
