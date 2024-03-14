`timescale 100ns / 1ns

// Testbench for GETPC & SETPC & CHGPC
module T_P_Qian ();

  reg doubleClk;
  reg rst;
  reg [15:0] inputLine;
  wire [15:0] outputLine;


  P_Liu_Clock_Mod Processor (
      .doubleClk(doubleClk),
      .rst(rst),
      .inputLine(inputLine),
      .outputLine(outputLine)

  );

  parameter CYCLE_TIME = 2;
  parameter DELAY_PER_CYCLE = (CYCLE_TIME * 10);
  integer failures = 0;
  reg [16*8-1:0] current_test_item = "NONE";

  task assert_equal(input integer expected, input integer actual);
    begin
      if (expected != actual) begin
        $display(
            "[Processor Test] ERROR, Testing '%s', [expected: %0d actual: %0d], Time: %t",
            current_test_item, expected, actual, $time);
        failures = failures + 1;
      end
    end
  endtask

  initial begin
    doubleClk = 0;
    forever begin
      #2 doubleClk = ~doubleClk;
    end
  end

  initial begin

    current_test_item = "GETPC & SETPC & CHGPC";

    rst = 1;
    inputLine = 4;
    #(CYCLE_TIME * 5);
    rst = 0;
    while (outputLine <= 0) begin
      #(CYCLE_TIME * 2);
    end
    assert_equal(inputLine, outputLine);

	#(CYCLE_TIME*6);
    rst = 1;
    inputLine = 35;
    #(CYCLE_TIME * 5);
    rst = 0;
    while (outputLine <= 0) begin
      #(CYCLE_TIME * 2);
    end
    assert_equal(inputLine, outputLine);

	#(CYCLE_TIME*6);
    rst = 1;
    inputLine = 765;
    #(CYCLE_TIME * 5);
    rst = 0;
    while (outputLine <= 0) begin
      #(CYCLE_TIME * 2);
    end
    assert_equal(inputLine, outputLine);

	#(CYCLE_TIME*6);
    rst = 1;
    inputLine = 2345;
    #(CYCLE_TIME * 5);
    rst = 0;
    while (outputLine <= 0) begin
      #(CYCLE_TIME * 2);
    end
    assert_equal(inputLine, outputLine);

	$display("\n\n[Processor Test] TESTS COMPLETE. Failures = %d", failures);
	if(failures == 0) begin
		$display("[Processor Test] TESTS PASSED\n\n");
	end


  end
endmodule


















