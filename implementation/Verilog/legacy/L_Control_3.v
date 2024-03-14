module L_Control_2 (in, ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ);

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
		
		
		
		case (in [15:13])
			3'b000:
				case (in [12])
					1'b0:
						case (in [11:9])
							3'b000 : {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h80000000;
							3'b001 : {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h40000000;
							3'b010 : {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h20000000;
							3'b011 : {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h10000000;
							3'b100 : {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h08000000;
							3'b101 : {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h04000000;
							3'b110 : {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h02000000;
							3'b111 : {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h01000000;
						endcase
					1'b1:
						case (in [11])
							1'b0: {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00800000;
							1'b1: {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00400000;
						endcase
				endcase
			3'b001:
				case (in [12])
					1'b0: {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00200000;
					1'b1:
						case (in [11])
							1'b0: {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00100000;
							1'b1:
								case (in [10])
									1'b0: {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00080000;
									1'b1: {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00040000;
								endcase
						endcase
				endcase
			3'b010:
				case (in [12])
					1'b0: {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00020000;
					1'b1: {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00010000;
				endcase
			3'b011:
				case (in [12:10])
					3'b100 :
						case (in [9:6])
							4'b0010: {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00008000;
							4'b0011: {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00004000;
							4'b0100 :
								case (in [5:3])
									3'b000: {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00002000;
									3'b001: {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00001000;
								endcase
							
							
						endcase
					3'b101 :
						case (in [9:3])
							7'b0000000: {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00000800;
							7'b0100000: {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00000400;
							7'b0100001: {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00000200;
							7'b1000000: {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00000100;
							7'b1100000: {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00000080;
							7'b1100001: {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00000040;
						endcase
					3'b110 : {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00000020;
					3'b111 : {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00000010;
				endcase
			3'b100: {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00000008;
			3'b101: {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00000004;
			3'b110: {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00000002;
			3'b111: {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ} = 32'h00000001;
		endcase
	end
endmodule
