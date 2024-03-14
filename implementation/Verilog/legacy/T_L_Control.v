`timescale 1 ns/100 ps

module T_L_Control ();

// Inputs
	reg [15:0] in;
	wire ADD;
	wire AND;
	wire OR;
	wire XOR;
	wire SUB;
	wire NAND;
	wire NOR;
	wire XNOR;
	wire LU;
	wire LL;
	wire ADDI;
	wire SHIFT;
	wire RETURN;
	wire JUMP;
	wire STRSP;
	wire RTVSP;
	wire STR;
	wire RTV;
	wire READ;
	wire WRITE;
	wire GETSP;
	wire CHGSP;
	wire SETSP;
	wire GETPC;
	wire SETPC;
	wire CHGPC;
	wire CHGSPI;
	wire CHGPCI;
	wire EQ;
	wire LT;
	wire NEQ;
	wire GEQ;
	
	wire ADD2;
	wire AND2;
	wire OR2;
	wire XOR2;
	wire SUB2;
	wire NAND2;
	wire NOR2;
	wire XNOR2;
	wire LU2;
	wire LL2;
	wire ADDI2;
	wire SHIFT2;
	wire RETURN2;
	wire JUMP2;
	wire STRSP2;
	wire RTVSP2;
	wire STR2;
	wire RTV2;
	wire READ2;
	wire WRITE2;
	wire GETSP2;
	wire CHGSP2;
	wire SETSP2;
	wire GETPC2;
	wire SETPC2;
	wire CHGPC2;
	wire CHGSPI2;
	wire CHGPCI2;
	wire EQ2;
	wire LT2;
	wire NEQ2;
	wire GEQ2;
	
	reg [15:0] inputs [159:0];
	wire [31:0] outputs = {ADD, AND, OR, XOR, SUB, NAND, NOR, XNOR, LU, LL, ADDI, SHIFT, RETURN, JUMP, STRSP, RTVSP, STR, RTV, READ, WRITE, GETSP, CHGSP, SETSP, GETPC, CHGPC, SETPC, CHGSPI, CHGPCI, EQ, LT, NEQ, GEQ};
	wire [31:0] outputs2 = {ADD2, AND2, OR2, XOR2, SUB2, NAND2, NOR2, XNOR2, LU2, LL2, ADDI2, SHIFT2, RETURN2, JUMP2, STRSP2, RTVSP2, STR2, RTV2, READ2, WRITE2, GETSP2, CHGSP2, SETSP2, GETPC2, CHGPC2, SETPC2, CHGSPI2, CHGPCI2, EQ2, LT2, NEQ2, GEQ2};
	reg [31:0] index;
	
   L_Control UUT1 (
		.in(in),
		.ADD(ADD),
		.AND(AND),
		.OR(OR),
		.XOR(XOR),
		.SUB(SUB),
		.NAND(NAND),
		.NOR(NOR),
		.XNOR(XNOR),
		.LU(LU),
		.LL(LL),
		.ADDI(ADDI),
		.SHIFT(SHIFT),
		.RETURN(RETURN),
		.JUMP(JUMP),
		.STRSP(STRSP),
		.RTVSP(RTVSP),
		.STR(STR),
		.RTV(RTV),
		.READ(READ),
		.WRITE(WRITE),
		.GETSP(GETSP),
		.CHGSP(CHGSP),
		.SETSP(SETSP),
		.GETPC(GETPC),
		.SETPC(SETPC),
		.CHGPC(CHGPC),
		.CHGSPI(CHGSPI),
		.CHGPCI(CHGPCI),
		.EQ(EQ),
		.LT(LT),
		.NEQ(NEQ),
		.GEQ(GEQ)
   );
	
   L_Control_2 UUT2 (
		.in(in),
		.ADD(ADD2),
		.AND(AND2),
		.OR(OR2),
		.XOR(XOR2),
		.SUB(SUB2),
		.NAND(NAND2),
		.NOR(NOR2),
		.XNOR(XNOR2),
		.LU(LU2),
		.LL(LL2),
		.ADDI(ADDI2),
		.SHIFT(SHIFT2),
		.RETURN(RETURN2),
		.JUMP(JUMP2),
		.STRSP(STRSP2),
		.RTVSP(RTVSP2),
		.STR(STR2),
		.RTV(RTV2),
		.READ(READ2),
		.WRITE(WRITE2),
		.GETSP(GETSP2),
		.CHGSP(CHGSP2),
		.SETSP(SETSP2),
		.GETPC(GETPC2),
		.SETPC(SETPC2),
		.CHGPC(CHGPC2),
		.CHGSPI(CHGSPI2),
		.CHGPCI(CHGPCI2),
		.EQ(EQ2),
		.LT(LT2),
		.NEQ(NEQ2),
		.GEQ(GEQ2)
   );
	
// Initialize Inputs
	initial begin
	
		index = 0;

		inputs[0] = 16'h0199;
		inputs[1] = 16'h013f;
		inputs[2] = 16'h0002;
		inputs[3] = 16'h01f0;
		inputs[4] = 16'h00da;
		inputs[5] = 16'h0399;
		inputs[6] = 16'h033f;
		inputs[7] = 16'h0202;
		inputs[8] = 16'h03f0;
		inputs[9] = 16'h02da;
		inputs[10] = 16'h0599;
		inputs[11] = 16'h053f;
		inputs[12] = 16'h0402;
		inputs[13] = 16'h05f0;
		inputs[14] = 16'h04da;
		inputs[15] = 16'h0799;
		inputs[16] = 16'h073f;
		inputs[17] = 16'h0602;
		inputs[18] = 16'h07f0;
		inputs[19] = 16'h06da;
		inputs[20] = 16'h0999;
		inputs[21] = 16'h093f;
		inputs[22] = 16'h0802;
		inputs[23] = 16'h09f0;
		inputs[24] = 16'h08da;

		repeat (32) begin
			repeat (5) begin
			
				in = inputs[index];
				#10;
				$display("Input: %h, Output 1: %h, Output 2: %h)", in, outputs, outputs2);
				index = index + 1;
			end
		end
	end
  
endmodule