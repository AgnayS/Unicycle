`timescale 1 ns / 100 ps

module T_C_ALU ();

  reg  [2:0] op;
  reg  [15:0] in0;
  reg  [15:0] in1;
  wire [15:0] dout;

  parameter CYCLE_TIME = 1;
  parameter DELAY_PER_CYCLE = (CYCLE_TIME * 2);

  integer failures = 0;


  C_ALU UUT (
      .op(op),
      .in0(in0),
      .in1(in1),
      .out(dout)
  );


  task test_add;
    input [15:0] a, b, result;
    reg [15:0] correct_result;

    begin
      correct_result = (a + b);

      if (result != correct_result) begin
        failures = failures + 1;
        $display("ERROR, Time: %t [ALU 11 Test] Testing 'add %b + %b', expected: %b, actual: %b",
                 $time, a, b, correct_result, result);
      end
    end
  endtask


  task test_add_all;
    begin
      op = 3'b000;
      // Test ADD

      // poritive + positive
      in0  = 16'b0000000000000001;
      in1  = 16'b0000000000000011;
      #(DELAY_PER_CYCLE);
      test_add(in0, in1, dout);

      // negative + negative
      in0 = 16'b1111111111111111;
      in1 = 16'b1111111111110000;
      #(DELAY_PER_CYCLE);
      test_add(in0, in1, dout);

      // positive + negative
      in0 = 16'b0000000000000001;
      in1 = 16'b1111111111111100;
      #(DELAY_PER_CYCLE);
      test_add(in0, in1, dout);

    end
  endtask


  task test_and;
    input [15:0] a, b, result;
    reg [15:0] correct_result;

    begin
      correct_result = (a & b);

      if (result != correct_result) begin
        failures = failures + 1;
        $display("ERROR, Time: %t [ALU 11 Test] Testing 'and %b & %b', expected: %b, actual: %b",
                 $time, a, b, correct_result, result);
      end
    end
  endtask

  task test_and_all;
  begin
		op = 3'b001;
      // Test AND

      // poritive & positive
      in0  = 16'b0000000000000001;
      in1  = 16'b0000000000000011;
      #(DELAY_PER_CYCLE);
      test_and(in0, in1, dout);

      // negative & negative
      in0 = 16'b1111111111111111;
      in1 = 16'b1111111111110000;
      #(DELAY_PER_CYCLE);
      test_and(in0, in1, dout);

      // positive & negative
      in0 = 16'b0000000000000001;
      in1 = 16'b1111111111111100;
      #(DELAY_PER_CYCLE);
      test_and(in0, in1, dout);
    end
  endtask

 task test_or;
    input [15:0] a, b, result;
    reg [15:0] correct_result;

    begin
      correct_result = (a | b);

      if (result != correct_result) begin
        failures = failures + 1;
        $display("ERROR, Time: %t [ALU 11 Test] Testing 'or %b | %b', expected: %b, actual: %b",
                 $time, a, b, correct_result, result);
      end
    end
  endtask

  task test_or_all;
  begin
		op = 3'b010;
      // Test OR

      // poritive & positive
      in0  = 16'b0000000000000001;
      in1  = 16'b0000000000000011;
      #(DELAY_PER_CYCLE);
      test_or(in0, in1, dout);

      // negative & negative
      in0 = 16'b1111111111111111;
      in1 = 16'b1111111111110000;
      #(DELAY_PER_CYCLE);
      test_or(in0, in1, dout);

      // positive & negative
      in0 = 16'b0000000000000001;
      in1 = 16'b1111111111111100;
      #(DELAY_PER_CYCLE);
      test_or(in0, in1, dout);
   end
 endtask

 
 task test_xor;
    input [15:0] a, b, result;
    reg [15:0] correct_result;

    begin
      correct_result = (a ^ b);

      if (result != correct_result) begin
        failures = failures + 1;
        $display("ERROR, Time: %t Testing 'xor %b ^ %b', expected: %b, actual: %b",
                 $time, a, b, correct_result, result);
      end
    end
  endtask

  task test_xor_all;
  begin
		op = 3'b011;
      // Test XOR

      // poritive & positive
      in0  = 16'b0000000000000001;
      in1  = 16'b0000000000000011;
      #(DELAY_PER_CYCLE);
      test_xor(in0, in1, dout);

      // negative & negative
      in0 = 16'b1111111111111111;
      in1 = 16'b1111111111110000;
      #(DELAY_PER_CYCLE);
      test_xor(in0, in1, dout);

      // positive & negative
      in0 = 16'b0000000000000001;
      in1 = 16'b1111111111111100;
      #(DELAY_PER_CYCLE);
      test_xor(in0, in1, dout);
   end
 endtask 
 
 task test_sub;
    input [15:0] a, b, result;
    reg [15:0] correct_result;

    begin
      correct_result = (a - b);

      if (result != correct_result) begin
        failures = failures + 1;
        $display("ERROR, Time: %t Testing 'sub %b - %b', expected: %b, actual: %b",
                 $time, a, b, correct_result, result);
      end
    end
  endtask

  task test_sub_all;
  begin
		op = 3'b100;
      // Test SUB

      // poritive & positive
      in0  = 16'b0000000000000001;
      in1  = 16'b0000000000000011;
      #(DELAY_PER_CYCLE);
      test_sub(in0, in1, dout);

      // negative & negative
      in0 = 16'b1111111111111111;
      in1 = 16'b1111111111110000;
      #(DELAY_PER_CYCLE);
      test_sub(in0, in1, dout);

      // positive & negative
      in0 = 16'b0000000000000001;
      in1 = 16'b1111111111111100;
      #(DELAY_PER_CYCLE);
      test_sub(in0, in1, dout);
   end
 endtask 

 task test_nand;
    input [15:0] a, b, result;
    reg [15:0] correct_result;

    begin
      correct_result = ~(in0&in1);

      if (result != correct_result) begin
        failures = failures + 1;
        $display("ERROR, Time: %t Testing 'nand %b ~& %b', expected: %b, actual: %b",
                 $time, a, b, correct_result, result);
      end
    end
  endtask

  task test_nand_all;
  begin
		op = 3'b100;
      // Test NAND

      // poritive & positive
      in0  = 16'b0000000000000001;
      in1  = 16'b0000000000000011;
      #(DELAY_PER_CYCLE);
      test_nand(in0, in1, dout);

      // negative & negative
      in0 = 16'b1111111111111111;
      in1 = 16'b1111111111110000;
      #(DELAY_PER_CYCLE);
      test_nand(in0, in1, dout);

      // positive & negative
      in0 = 16'b0000000000000001;
      in1 = 16'b1111111111111100;
      #(DELAY_PER_CYCLE);
      test_nand(in0, in1, dout);
   end
 endtask 
 
  task test_nor;
    input [15:0] a, b, result;
    reg [15:0] correct_result;

    begin
      correct_result = ~(in0|in1);

      if (result != correct_result) begin
        failures = failures + 1;
        $display("ERROR, Time: %t Testing 'nor %b ~| %b', expected: %b, actual: %b",
                 $time, a, b, correct_result, result);
      end
    end
  endtask

  task test_nor_all;
  begin
		op = 3'b110;
      // Test NOR

      // poritive & positive
      in0  = 16'b0000000000000001;
      in1  = 16'b0000000000000011;
      #(DELAY_PER_CYCLE);
      test_nor(in0, in1, dout);

      // negative & negative
      in0 = 16'b1111111111111111;
      in1 = 16'b1111111111110000;
      #(DELAY_PER_CYCLE);
      test_nor(in0, in1, dout);

      // positive & negative
      in0 = 16'b0000000000000001;
      in1 = 16'b1111111111111100;
      #(DELAY_PER_CYCLE);
      test_nor(in0, in1, dout);
   end
 endtask 
 
   task test_xnor;
    input [15:0] a, b, result;
    reg [15:0] correct_result;

    begin
      correct_result = ~(in0^in1);

      if (result != correct_result) begin
        failures = failures + 1;
        $display("ERROR, Time: %t Testing 'xnor %b ~^ %b', expected: %b, actual: %b",
                 $time, a, b, correct_result, result);
      end
    end
  endtask

  task test_xnor_all;
  begin
		op = 3'b111;
      // Test XNOR

      // poritive & positive
      in0  = 16'b0000000000000001;
      in1  = 16'b0000000000000011;
      #(DELAY_PER_CYCLE);
      test_xnor(in0, in1, dout);

      // negative & negative
      in0 = 16'b1111111111111111;
      in1 = 16'b1111111111110000;
      #(DELAY_PER_CYCLE);
      test_xnor(in0, in1, dout);

      // positive & negative
      in0 = 16'b0000000000000001;
      in1 = 16'b1111111111111100;
      #(DELAY_PER_CYCLE);
      test_xnor(in0, in1, dout);
   end
 endtask 
 
  initial begin

    //---------- Test ALU ----------//
    test_add_all();
    test_and_all();
	 test_or_all();
	 test_xor_all();
	 test_sub_all();
	 test_nand_all();
    test_nor_all();
	 test_xnor_all();

    $display("[ALU Test] TESTS COMPLETE. \n Failures = %d\n\n", failures);
    $stop;

  end


endmodule
