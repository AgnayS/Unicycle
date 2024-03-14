module C_Constant(out);

    parameter BITS = 1;
    parameter value = {BITS{1'b0}};
    output [BITS-1:0] out;
    
    assign out = value;

endmodule
