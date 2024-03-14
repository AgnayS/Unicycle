module L_ALU_1 (control, immediate, in0, in1, pcIn, pcOut, pcWrite);

// Handles LT, EQ, NEQ, GEQ
// Control bits: instruction[14:13]
// Immediate bits: instruction[12:6]
// Each ALU is responsible for sign extending their own immediate
	
	input [1:0] control;
	input [6:0] immediate;
	
	input [15:0] in0;
	input [15:0] in1;
	input [15:0] pcIn;
	
	reg myBoolean;
	output reg pcWrite;
	output [15:0] pcOut;
	
	wire [15:0] seImmediate;
	assign seImmediate = {{9{immediate[6]}}, immediate[6:0]};
	
	always @(in0, in1, control) begin
	
		myBoolean = 1'b0;
	
		case(control)
		
			2'b01: //LT
				if(in0<in1) myBoolean = 1'b1;
					
			2'b00: //EQ
				if(in0==in1) myBoolean = 1'b1;		
			
			2'b10: //NEQ
				if(in0!=in1) myBoolean = 1'b1;
				
			2'b11: //GEQ
				if(in0>=in1) myBoolean = 1'b1;
			
		endcase
	
		if (myBoolean) begin
				pcWrite <= pcIn + (seImmediate << 1);
		end else begin
			pcWrite <= pcIn;
		end
	
	end
	
endmodule