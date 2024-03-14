`timescale 1 ns / 100 ps

module T_L_ALU_Complex ();

  reg  [15:0] inst;
  reg  [15:0] in0;
  reg  [15:0] in1;
  reg  [15:0] in2;
  wire [15:0] dout;

  parameter CYCLE_TIME = 1;
  parameter DELAY_PER_CYCLE = (CYCLE_TIME * 2);

  integer failures = 0;

  L_ALU_Complex UUT (
      .instruction(inst),
      .in0(in0),
      .in1(in1),
      .in2(in2),
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
      inst = 16'b0000000100101110;
      in2  = 16'b0000000000000000;

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


  task test_addi;
    input [15:0] a, b, result;
    reg [15:0] correct_result;

    begin
      correct_result = (a + b);

      if (result != correct_result) begin
        failures = failures + 1;
        $display("ERROR, Time: %t [ALU 4 Test] Testing 'addi %b + %b', expected: %b, actual: %b",
                 $time, a, b, correct_result, result);
      end
    end
  endtask

  task test_addi_all;
    begin
      in1  = 16'b0000000000000000;
      in2  = 16'b0000000000000000;

      // Test ADD

      // poritive + positive
      inst = 16'b0010000010000000;
      in0  = 16'b0000000000000001;

      #(DELAY_PER_CYCLE);
      test_addi(in0, 2, dout);

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
      inst = 16'b0000010100101110;
      in2  = 16'b0000001000000000;

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




  initial begin

    //---------- Test ALU 4  ----------//
    test_addi_all();

    //---------- Test ALU 11 ----------//
    test_add_all();
    test_and_all();
    

    $display("[ALU 11 Test] TESTS COMPLETE. \n Failures = %d\n\n", failures);
    $stop;

  end


endmodule
