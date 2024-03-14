`timescale 1 ns / 100 ps

module T_C_Comparator ();

  reg  [1:0] op;
  reg  [15:0] in0;
  reg  [15:0] in1;
  wire dout;

  parameter CYCLE_TIME = 1;
  parameter DELAY_PER_CYCLE = (CYCLE_TIME * 2);

  integer failures = 0;

  C_ALU UUT (
      .op(op),
      .in0(in0),
      .in1(in1),
      .out(dout)
  );
  
  task test_lt;
    input [15:0] a, b, result;
    reg correct_result;

    begin
      correct_result = (a < b);

      if (result != correct_result) begin
        failures = failures + 1;
        $display("ERROR, Time: %t Testing ' %b < %b', incorrect result",
                 $time, a, b);
      end
    end
  endtask
  
   task test_lt_all;
    begin
      op = 2'b01;
      // Test ADD

      // poritive + positive
      in0  = 16'b0000000000000001;
      in1  = 16'b0000000000000011;
      #(DELAY_PER_CYCLE);
      test_lt(in0, in1, dout);

      // negative + negative
      in0 = 16'b1111111111111111;
      in1 = 16'b1111111111110000;
      #(DELAY_PER_CYCLE);
      test_lt(in0, in1, dout);

      // positive + negative
      in0 = 16'b0000000000000001;
      in1 = 16'b1111111111111100;
      #(DELAY_PER_CYCLE);
      test_lt(in0, in1, dout);

    end
  endtask
  
  
  task test_eq;
    input [15:0] a, b, result;
    reg correct_result;

    begin
      correct_result = (a == b);

      if (result != correct_result) begin
        failures = failures + 1;
        $display("ERROR, Time: %t Testing ' %b = %b', incorrect result",
                 $time, a, b);
      end
    end
  endtask
  
   task test_eq_all;
	
    begin
      op = 2'b00;
      // Test ADD

      // poritive + positive
      in0  = 16'b0000000000000001;
      in1  = 16'b0000000000000011;
      #(DELAY_PER_CYCLE);
      test_eq(in0, in1, dout);

      // negative + negative
      in0 = 16'b1111111111111111;
      in1 = 16'b1111111111110000;
      #(DELAY_PER_CYCLE);
      test_eq(in0, in1, dout);

      // positive + negative
      in0 = 16'b0000000000000001;
      in1 = 16'b1111111111111100;
      #(DELAY_PER_CYCLE);
      test_eq(in0, in1, dout);

    end
  endtask
  
 task test_neq;
    input [15:0] a, b, result;
    reg correct_result;

    begin
      correct_result = (a != b);

      if (result != correct_result) begin
        failures = failures + 1;
        $display("ERROR, Time: %t Testing ' %b != %b', incorrect result",
                 $time, a, b);
      end
    end
  endtask
  
   task test_neq_all;
	
    begin
      op = 2'b10;
      // Test ADD

      // poritive + positive
      in0  = 16'b0000000000000001;
      in1  = 16'b0000000000000011;
      #(DELAY_PER_CYCLE);
      test_eq(in0, in1, dout);

      // negative + negative
      in0 = 16'b1111111111111111;
      in1 = 16'b1111111111110000;
      #(DELAY_PER_CYCLE);
      test_eq(in0, in1, dout);

      // positive + negative
      in0 = 16'b0000000000000001;
      in1 = 16'b1111111111111100;
      #(DELAY_PER_CYCLE);
      test_eq(in0, in1, dout);

    end
  endtask
 
 task test_geq;
    input [15:0] a, b, result;
    reg correct_result;

    begin
      correct_result = (a >= b);

      if (result != correct_result) begin
        failures = failures + 1;
        $display("ERROR, Time: %t Testing ' %b != %b', incorrect result",
                 $time, a, b);
      end
    end
  endtask
  
   task test_geq_all;
	
    begin
      op = 2'b11;
      // Test ADD

      // poritive + positive
      in0  = 16'b0000000000000001;
      in1  = 16'b0000000000000011;
      #(DELAY_PER_CYCLE);
      test_geq(in0, in1, dout);

      // negative + negative
      in0 = 16'b1111111111111111;
      in1 = 16'b1111111111110000;
      #(DELAY_PER_CYCLE);
      test_geq(in0, in1, dout);

      // positive + negative
      in0 = 16'b0000000000000001;
      in1 = 16'b1111111111111100;
      #(DELAY_PER_CYCLE);
      test_geq(in0, in1, dout);

    end
  endtask
  
  initial begin

    //---------- Test Comparator ----------//
    test_lt_all();
    test_eq_all();
	 test_geq_all();
	 test_neq_all();

    $display("[Comparator Test] TESTS COMPLETE. \n Failures = %d\n\n", failures);
    $stop;

  end


endmodule