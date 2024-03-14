module C_Comparator (op, in0, in1, out);

	input [1:0] op;
	
	input [15:0] in0;
	input [15:0] in1;
	
	output reg out;
	
	
	always @ * begin
		
		out = 0;
	
		case (op)
					
			default: if(in0 == in1) out = 1'b1;		
		
			2'b01: if(in0 < in1) out = 1'b1;
			
			2'b10: if (in0 != in1) out = 1'b1;
				
			2'b11: if (in0 >= in1) out = 1'b1;
			
		endcase
	
	end
	
endmodule




