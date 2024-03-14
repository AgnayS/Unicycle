`timescale 1 ns / 100 ps

module T_L_Control_Flag ();

  // For L_Control Module
  reg  [15:0] in;

  wire [ 1:0] ALUInput1Select;
  wire [ 1:0] ALUInput2Select;
  wire [ 2:0] ALUOp;
  wire [ 1:0] PCOutSelect;
  wire [ 0:0] SPOutSelect;
  wire [ 0:0] RAOutSelect;
  wire [ 1:0] MemoryAddrSelect;
  wire [ 0:0] MemoryOutSelect;
  wire [ 2:0] RegisterOutSelect;
  wire [ 4:0] shiftAmount;

  wire [ 0:0] registerWrite;
  wire [ 0:0] spWrite;
  wire [ 0:0] raWrite;
  wire [ 0:0] memoryWrite;

  wire [ 0:0] forcePCAlternate;  // Should PC force the alternate value (ignore comparator)?

  // For Testing Module
  parameter CYCLE_TIME = 1;
  parameter DELAY_PER_CYCLE = (CYCLE_TIME * 10);
  integer failures = 0;
  integer current_failures = 0;

  integer test_count_ALUInput1Select = 0;
  integer test_count_ALUInput2Select = 0;
  integer test_count_ALUOp = 0;
  integer test_count_PCOutSelect = 0;
  integer test_count_SPOutSelect = 0;
  integer test_count_RAOutSelect = 0;
  integer test_count_MemoryAddrSelect = 0;
  integer test_count_MemoryOutSelect = 0;
  integer test_count_RegisterOutSelect = 0;
  integer test_count_shiftAmount = 0;
  integer test_count_registerWrite = 0;
  integer test_count_spWrite = 0;
  integer test_count_raWrite = 0;
  integer test_count_memoryWrite = 0;
  integer test_count_forcePCAlternate = 0;

  reg [17*8-1:0] current_test_flag = "NONE";
  reg [16*8-1:0] current_test_item = "NONE";

  L_Control UUT (
      .in(in),
      .ALUInput1Select(ALUInput1Select),
      .ALUInput2Select(ALUInput2Select),
      .ALUOp(ALUOp),
      .PCOutSelect(PCOutSelect),
      .SPOutSelect(SPOutSelect),
      .RAOutSelect(RAOutSelect),
      .MemoryAddrSelect(MemoryAddrSelect),
      .MemoryOutSelect(MemoryOutSelect),
      .RegisterOutSelect(RegisterOutSelect),
      .shiftAmount(shiftAmount),

      .registerWrite(registerWrite),
      .spWrite(spWrite),
      .raWrite(raWrite),
      .memoryWrite(memoryWrite),

      .forcePCAlternate(forcePCAlternate) // Should PC force the alternate value (ignore comparator)?
  );

  task assert_equal(input integer expected, input integer actual);
    begin
      if (expected != actual) begin
        $display(
            "[L_Control Flag Test] ERROR, Testing '%s', [%s expected: %0d actual: %0d], Time: %t",
            current_test_item, current_test_flag, expected, actual, $time);
        failures = failures + 1;
      end
    end

  endtask

  task assert_or_equal(input integer expected1, input integer expected2, input integer actual);
    begin
      if (expected1 != actual && expected2 != actual) begin
        $display(
            "[L_Control Flag Test] ERROR, Testing '%s', [%s expected: %0d or %0d actual: %0d], Time: %t",
            current_test_item, current_test_flag, expected1, expected2, actual, $time);
        failures = failures + 1;
      end
    end
  endtask

  // if expected is negative, then we check if it is the defauult value, which is 0.
  task assert_ALUInput1Select(input integer signed expected);
    begin
      current_test_flag = "ALUInput1Select";
      test_count_ALUInput1Select = 1;

      if (expected >= 0) begin
        assert_equal(expected, ALUInput1Select);
      end else begin
        assert_equal(0, ALUInput1Select);
      end
    end
  endtask

  task assert_ALUInput2Select(input integer signed expected);
    begin
      current_test_flag = "ALUInput2Select";
      test_count_ALUInput2Select = 1;

      if (expected >= 0) begin
        assert_equal(expected, ALUInput2Select);
      end else begin
        assert_equal(0, ALUInput2Select);
      end
    end
  endtask

  task assert_ALUOp(input integer signed expected);
    begin
      current_test_flag = "ALUOp";
      test_count_ALUOp  = 1;

      if (expected >= 0) begin
        assert_equal(expected, ALUOp);
      end else begin
        assert_equal(0, ALUOp);
      end
    end
  endtask

  task assert_PCOutSelect(input integer signed expected);
    begin
      current_test_flag = "PCOutSelect";
      test_count_PCOutSelect = 1;

      if (expected >= 0) begin
        assert_equal(expected, PCOutSelect);
      end else begin
        assert_equal(0, PCOutSelect);
      end
    end
  endtask

  task assert_SPOutSelect(input integer signed expected);
    begin
      current_test_flag = "SPOutSelect";
      test_count_SPOutSelect = 1;

      if (expected >= 0) begin
        assert_equal(expected, SPOutSelect);
      end else begin
        assert_equal(0, SPOutSelect);
      end
    end
  endtask

  task assert_RAOutSelect(input integer signed expected);
    begin
      current_test_flag = "RAOutSelect";
      test_count_RAOutSelect = 1;

      if (expected >= 0) begin
        assert_equal(expected, RAOutSelect);
      end else begin
        assert_equal(0, RAOutSelect);
      end
    end
  endtask

  task assert_MemoryAddrSelect(input integer signed expected);
    begin
      current_test_flag = "MemoryAddrSelect";
      test_count_MemoryAddrSelect = 1;

      if (expected >= 0) begin
        assert_equal(expected, MemoryAddrSelect);
      end else begin
        assert_equal(0, MemoryAddrSelect);
      end
    end
  endtask

  task assert_MemoryOutSelect(input integer signed expected);
    begin
      current_test_flag = "MemoryOutSelect";
      test_count_MemoryOutSelect = 1;

      if (expected >= 0) begin
        assert_equal(expected, MemoryOutSelect);
      end else begin
        assert_equal(0, MemoryOutSelect);
      end
    end
  endtask

  task assert_RegisterOutSelect(input integer signed expected);
    begin
      current_test_flag = "RegisterOutSelect";
      test_count_RegisterOutSelect = 1;

      if (expected >= 0) begin
        assert_equal(expected, RegisterOutSelect);
      end else begin
        assert_equal(0, RegisterOutSelect);
      end
    end
  endtask

  task assert_shiftAmount(input integer signed expected);
    begin
      current_test_flag = "shiftAmount";
      test_count_shiftAmount = 1;

      if (expected >= 0) begin
        assert_equal(expected, shiftAmount);
      end else begin
        assert_equal(0, shiftAmount);
      end
    end
  endtask

  task assert_registerWrite(input integer signed expected);
    begin
      current_test_flag = "registerWrite";
      test_count_registerWrite = 1;

      if (expected >= 0) begin
        assert_equal(expected, registerWrite);
      end else begin
        assert_equal(0, registerWrite);
      end
    end
  endtask

  task assert_spWrite(input integer signed expected);
    begin
      current_test_flag  = "spWrite";
      test_count_spWrite = 1;

      if (expected >= 0) begin
        assert_equal(expected, spWrite);
      end else begin
        assert_equal(0, spWrite);
      end
    end
  endtask

  task assert_raWrite(input integer signed expected);
    begin
      current_test_flag  = "raWrite";
      test_count_raWrite = 1;

      if (expected >= 0) begin
        assert_equal(expected, raWrite);
      end else begin
        assert_equal(0, raWrite);
      end
    end
  endtask

  task assert_memoryWrite(input integer signed expected);
    begin
      current_test_flag = "memoryWrite";
      test_count_memoryWrite = 1;

      if (expected >= 0) begin
        assert_equal(expected, memoryWrite);
      end else begin
        assert_equal(0, memoryWrite);
      end
    end
  endtask

  task assert_forcePCAlternate(input integer signed expected);
    begin
      current_test_flag = "forcePCAlternate";
      test_count_forcePCAlternate = 1;

      if (expected >= 0) begin
        assert_equal(expected, forcePCAlternate);
      end else begin
        assert_equal(0, forcePCAlternate);
      end
    end
  endtask


  task prepare_testing;
    begin
      current_failures = failures;
    end

  endtask

  task begin_testing;
    begin
      in <= 16'b0000000000000000;
      #(DELAY_PER_CYCLE);

      
      test_count_ALUInput1Select = 0;
      test_count_ALUInput2Select = 0;
      test_count_ALUOp = 0;
      test_count_PCOutSelect = 0;
      test_count_SPOutSelect = 0;
      test_count_RAOutSelect = 0;
      test_count_MemoryAddrSelect = 0;
      test_count_MemoryOutSelect = 0;
      test_count_RegisterOutSelect = 0;
      test_count_shiftAmount = 0;
      test_count_registerWrite = 0;
      test_count_spWrite = 0;
      test_count_raWrite = 0;
      test_count_memoryWrite = 0;
      test_count_forcePCAlternate = 0;

    end
  endtask

  task end_test;
    begin
      if (test_count_ALUInput1Select == 0) begin
        assert_ALUInput1Select(-1);
      end
      if (test_count_ALUInput2Select == 0) begin
        assert_ALUInput2Select(-1);
      end
      if (test_count_ALUOp == 0) begin
        assert_ALUOp(-1);
      end
      if (test_count_PCOutSelect == 0) begin
        assert_PCOutSelect(-1);
      end
      if (test_count_SPOutSelect == 0) begin
        assert_SPOutSelect(-1);
      end
      if (test_count_RAOutSelect == 0) begin
        assert_RAOutSelect(-1);
      end
      if (test_count_MemoryAddrSelect == 0) begin
        assert_MemoryAddrSelect(-1);
      end
      if (test_count_MemoryOutSelect == 0) begin
        assert_MemoryOutSelect(-1);
      end
      if (test_count_RegisterOutSelect == 0) begin
        assert_RegisterOutSelect(-1);
      end
      if (test_count_shiftAmount == 0) begin
        assert_shiftAmount(-1);
      end
      if (test_count_registerWrite == 0) begin
        assert_registerWrite(-1);
      end
      if (test_count_spWrite == 0) begin
        assert_spWrite(-1);
      end
      if (test_count_raWrite == 0) begin
        assert_raWrite(-1);
      end
      if (test_count_memoryWrite == 0) begin
        assert_memoryWrite(-1);
      end
      if (test_count_forcePCAlternate == 0) begin
        assert_forcePCAlternate(-1);
      end

    end
  endtask

  task summary_testing;
    begin
      if (failures == current_failures) begin
        $display("[L_Control Flag Test] Testing '%0s' PASSED\n", current_test_item);
      end else begin
        $display("[L_Control Flag Test] Testing '%0s' FAILED\n", current_test_item);
      end
    end

  endtask

  // GEQ, NEQ, LT, EQ
  task test_type_1;

    integer index;

    reg [15:0] insts[4:0];

    begin

      prepare_testing();

      // geq x1 x2 4
      insts[0] <= 16'b1110000100010001;

      // neq x1 x2 4
      insts[1] <= 16'b1100000100010001;

      // lt x1 x2 4
      insts[2] <= 16'b1010000100010001;

      // eq x1 x2 4
      insts[3] <= 16'b1000000100010001;

      index = 0;
      current_test_item = "Type 1: Branch";

      repeat (4) begin

        begin_testing();

        in <= insts[index];
        #(DELAY_PER_CYCLE);

        assert_ALUInput1Select(0);
        assert_ALUInput2Select(0);
        assert_ALUOp(0);
        assert_PCOutSelect(1);

        index = index + 1;

        end_test();
      end

      summary_testing();
    end
  endtask



  // STRSP
  task test_type_2;

    integer index;

    reg [15:0] insts[2:0];

    begin
      prepare_testing();

      // strsp x1 3
      insts[0] <= 16'b0100000000011001;

      // strsp x2 -8
      insts[1] <= 16'b0100111111000010;

      index = 0;
      current_test_item = "Type 2: STRSP";

      repeat (2) begin

        begin_testing();

        in <= insts[index];
        #(DELAY_PER_CYCLE);

        assert_ALUInput1Select(1);
        assert_ALUInput2Select(0);
        assert_ALUOp(0);
        assert_PCOutSelect(0);
        assert_MemoryOutSelect(0);
        assert_MemoryAddrSelect(1);

        assert_memoryWrite(1);

        index = index + 1;

        end_test();

      end

      summary_testing();
    end
  endtask


  // RTVSP
  task test_type_3;

    integer index;

    reg [15:0] insts[2:0];

    begin
      prepare_testing();

      // rtvsp x1 3
      insts[0] <= 16'b0101000000011001;

      // rtvsp x2 -8
      insts[1] <= 16'b0101111111000010;

      index = 0;
      current_test_item = "Type 3: RTVSP";

      repeat (2) begin

        begin_testing();

        in <= insts[index];
        #(DELAY_PER_CYCLE);

        assert_ALUInput1Select(1);
        assert_ALUInput2Select(0);
        assert_ALUOp(0);
        assert_PCOutSelect(0);
        assert_RegisterOutSelect(0);

        assert_registerWrite(1);

        index = index + 1;

        end_test();
      end

      summary_testing();
    end
  endtask


  // ADDI
  task test_type_4;

    integer index;

    reg [15:0] insts[2:0];

    begin
      prepare_testing();

      // addi x1 x2 10
      insts[0] <= 16'b0010001010010001;

      // addi x2 x3 -10
      insts[1] <= 16'b0010110110011010;

      index = 0;
      current_test_item = "Type 4: ADDI";

      repeat (2) begin

        begin_testing();

        in <= insts[index];
        #(DELAY_PER_CYCLE);

        assert_ALUInput1Select(2);
        assert_ALUInput2Select(0);
        assert_ALUOp(0);
        assert_PCOutSelect(0);
        assert_RegisterOutSelect(1);

        assert_registerWrite(1);

        index = index + 1;

        end_test();
      end

      summary_testing();
    end
  endtask

  // LL
  task test_type_5;

    integer index;

    reg [15:0] insts[2:0];

    begin
      prepare_testing();

      // ll x1 12
      insts[0] <= 16'b0001100001100001;

      // ll x2 23
      insts[1] <= 16'b0001100010111010;

      index = 0;
      current_test_item = "Type 5: LL";

      repeat (2) begin

        begin_testing();

        in <= insts[index];
        #(DELAY_PER_CYCLE);

        current_test_flag = "registerWrite";
        assert_equal(1, registerWrite);

        assert_PCOutSelect(0);
        assert_RegisterOutSelect(3);

        assert_registerWrite(1);

        index = index + 1;

        end_test();
      end

      summary_testing();
    end
  endtask

  // LU
  task test_type_6;

    integer index;

    reg [15:0] insts[2:0];

    begin
      prepare_testing();

      // lu x1 12
      insts[0] <= 16'b0001000001100001;

      // lu x2 23
      insts[1] <= 16'b0001000010111010;

      index = 0;
      current_test_item = "Type 6: LU";

      repeat (2) begin

        begin_testing();

        in <= insts[index];
        #(DELAY_PER_CYCLE);

        assert_PCOutSelect(0);
        assert_RegisterOutSelect(2);

        assert_registerWrite(1);

        index = index + 1;

        end_test();
      end

      summary_testing();
    end
  endtask




  // SHIFT
  task test_type_7;

    integer index;

    reg [15:0] insts[2:0];

    begin
      prepare_testing();

      index = 0;
      current_test_item = "Type 7: SHIFT";

      // Test inst 0
      begin_testing();
      // shift x1 x2 2
      in <= 16'b0011000010010001;
      #(DELAY_PER_CYCLE);

      assert_PCOutSelect(0);
      assert_RegisterOutSelect(4);
      assert_shiftAmount(2);

      assert_registerWrite(1);


      end_test();



      begin_testing();
      // shift x3 x4 16
      in <= 16'b0011010000100011;
      #(DELAY_PER_CYCLE);

      assert_PCOutSelect(0);
      assert_RegisterOutSelect(4);
      assert_shiftAmount(16);

      assert_registerWrite(1);

      end_test();


      summary_testing();
    end
  endtask


  // CHGSPI
  task test_type_8A;

    integer index;

    reg [15:0] insts[2:0];

    begin
      prepare_testing();

      // chgspi 3
      insts[0] <= 16'b0111100000000011;

      // chgspi -5
      insts[1] <= 16'b0111101111111011;

      index = 0;
      current_test_item = "Type 8A: CHGSPI";

      repeat (2) begin
        begin_testing();

        in <= insts[index];
        #(DELAY_PER_CYCLE);

        assert_ALUInput1Select(1);
        assert_ALUInput2Select(0);
        assert_ALUOp(0);
        assert_PCOutSelect(0);
        assert_SPOutSelect(0);

        assert_spWrite(1);

        index = index + 1;

        end_test();
      end

      summary_testing();
    end
  endtask

  // CHGPCI
  task test_type_8B;

    integer index;

    reg [15:0] insts[2:0];

    begin
      prepare_testing();

      // chgpci 3
      insts[0] <= 16'b0111110000000011;

      // chgpci -5
      insts[1] <= 16'b0111111111111011;

      index = 0;
      current_test_item = "Type 8B: CHGPCI";

      repeat (2) begin

        begin_testing();

        in <= insts[index];
        #(DELAY_PER_CYCLE);

        assert_ALUInput1Select(0);
        assert_ALUInput2Select(0);
        assert_ALUOp(0);
        assert_PCOutSelect(1);

        assert_forcePCAlternate(1);

        index = index + 1;

        end_test();
      end

      summary_testing();
    end
  endtask

  // JUMP
  task test_type_9;

    integer index;

    reg [15:0] insts[2:0];

    begin
      prepare_testing();

      // jump 3
      insts[0] <= 16'b0011110000000011;

      // jump -5
      insts[1] <= 16'b0011111111111011;

      index = 0;
      current_test_item = "Type 9: JUMP";

      repeat (2) begin

        begin_testing();

        in <= insts[index];
        #(DELAY_PER_CYCLE);

        assert_ALUInput1Select(0);
        assert_ALUInput2Select(0);
        assert_ALUOp(0);
        assert_PCOutSelect(1);
        assert_RAOutSelect(1);
        assert_MemoryOutSelect(1);
        assert_MemoryAddrSelect(1);

        assert_raWrite(1);
        assert_memoryWrite(1);
        assert_forcePCAlternate(1);

        index = index + 1;

        end_test();
      end

      summary_testing();
    end
  endtask

  // RETURN
  task test_type_10;

    integer index;

    reg [15:0] insts[2:0];

    begin
      prepare_testing();

      // return 3
      insts[0] <= 16'b0011100000000011;

      // return -5
      insts[1] <= 16'b0011101111111011;

      index = 0;
      current_test_item = "Type 10: RETURN";

      repeat (2) begin

        begin_testing();

        in <= insts[index];
        #(DELAY_PER_CYCLE);

        assert_ALUInput1Select(1);
        assert_ALUInput2Select(0);
        assert_ALUOp(0);
        assert_PCOutSelect(2);
        assert_SPOutSelect(0);
        assert_RAOutSelect(0);
        assert_MemoryAddrSelect(2);

        assert_spWrite(1);
        assert_raWrite(1);
        assert_memoryWrite(0);
        assert_forcePCAlternate(1);

        index = index + 1;

        end_test();
      end

      summary_testing();
    end
  endtask

  // AND ADD XOR OR NOR SUB NAND XNOR
  task test_type_11;

    integer index;

    begin
      prepare_testing();


      // and x1 x2 x3
      begin_testing();
        current_test_item = "Type 11: AND";
        in <= 16'b0000001011010001;
        #(DELAY_PER_CYCLE);

        assert_ALUInput1Select(2);
        assert_ALUInput2Select(1);
        assert_ALUOp(1);
        assert_PCOutSelect(0);
        assert_RegisterOutSelect(1);
        assert_registerWrite(1);
        
      end_test();

      // add x1 x2 x3
      begin_testing();
        current_test_item = "Type 11: ADD";
        in <= 16'b0000000011010001;
        #(DELAY_PER_CYCLE);

        assert_ALUInput1Select(2);
        assert_ALUInput2Select(1);
        assert_ALUOp(0);
        assert_PCOutSelect(0);
        assert_RegisterOutSelect(1);
        assert_registerWrite(1);
      end_test();

      // xor x1 x2 x3
      begin_testing();
        current_test_item = "Type 11: XOR";
        in <= 16'b0000011011010001;
        #(DELAY_PER_CYCLE);

        assert_ALUInput1Select(2);
        assert_ALUInput2Select(1);
        assert_ALUOp(3);
        assert_PCOutSelect(0);
        assert_RegisterOutSelect(1);
        assert_registerWrite(1);
      end_test();

      // or x1 x2 x3
      begin_testing();
        current_test_item = "Type 11: OR";
        in <= 16'b0000010011010001;
        #(DELAY_PER_CYCLE);

        assert_ALUInput1Select(2);
        assert_ALUInput2Select(1);
        assert_ALUOp(2);
        assert_PCOutSelect(0);
        assert_RegisterOutSelect(1);
        assert_registerWrite(1);
      end_test();

      // nor x1 x2 x3
      begin_testing();
        current_test_item = "Type 11: NOR";
        in <= 16'b0000110011010001;
        #(DELAY_PER_CYCLE);

        assert_ALUInput1Select(2);
        assert_ALUInput2Select(1);
        assert_ALUOp(6);
        assert_PCOutSelect(0);
        assert_RegisterOutSelect(1);
        assert_registerWrite(1);
      end_test();

      // sub x1 x2 x3
      begin_testing();
        current_test_item = "Type 11: SUB";
        in <= 16'b0000100011010001;
        #(DELAY_PER_CYCLE);

        assert_ALUInput1Select(2);
        assert_ALUInput2Select(1);
        assert_ALUOp(4);
        assert_PCOutSelect(0);
        assert_RegisterOutSelect(1);
        assert_registerWrite(1);
      end_test();

      // nand x1 x2 x3
      begin_testing();
        current_test_item = "Type 11: NAND";
        in <= 16'b0000101011010001;
        #(DELAY_PER_CYCLE);

        assert_ALUInput1Select(2);
        assert_ALUInput2Select(1);
        assert_ALUOp(5);
        assert_PCOutSelect(0);
        assert_RegisterOutSelect(1);
        assert_registerWrite(1);
      end_test();

      // xnor x1 x2 x3
      begin_testing();
        current_test_item = "Type 11: XNOR";
        in <= 16'b0000111011010001;
        #(DELAY_PER_CYCLE);

        assert_ALUInput1Select(2);
        assert_ALUInput2Select(1);
        assert_ALUOp(7);
        assert_PCOutSelect(0);
        assert_RegisterOutSelect(1);
        assert_registerWrite(1);
      end_test();

      summary_testing();
    end
  endtask


  // STR
  task test_type_12;

    integer index;

    reg [15:0] insts[2:0];

    begin
      prepare_testing();

      // str x1 x2
      insts[0] <= 16'b0111000010010001;
      // str x2 x3
      insts[1] <= 16'b0111000010011010;

      index = 0;
      current_test_item = "Type 12: STR";

      repeat (2) begin

        begin_testing();

        in <= insts[index];
        #(DELAY_PER_CYCLE);

        assert_PCOutSelect(0);
        assert_MemoryAddrSelect(0);
        assert_MemoryOutSelect(0);

        assert_memoryWrite(1);

        index = index + 1;

        end_test();
      end

      summary_testing();
    end
  endtask


  // RTV
  task test_type_13;

    integer index;

    reg [15:0] insts[2:0];

    begin
      prepare_testing();

      // rtv x1 x2
      insts[0] <= 16'b0111000011010001;
      // rtv x2 x3
      insts[1] <= 16'b0111000011011010;

      index = 0;
      current_test_item = "Type 13: RTV";

      repeat (2) begin

        begin_testing();

        in <= insts[index];
        #(DELAY_PER_CYCLE);

        assert_PCOutSelect(0);
        assert_MemoryAddrSelect(0);
        assert_RegisterOutSelect(0);

        assert_registerWrite(1);

        index = index + 1;

        end_test();
      end

      summary_testing();
    end
  endtask

  // READ
  task test_type_14;

    integer index;

    reg [15:0] insts[2:0];

    begin
      prepare_testing();

      // read x1
      insts[0] <= 16'b0111000100000001;
      // read x2
      insts[1] <= 16'b0111000100000010;

      index = 0;
      current_test_item = "Type 14: READ";

      repeat (2) begin

        begin_testing();

        in <= insts[index];
        #(DELAY_PER_CYCLE);

        assert_PCOutSelect(0);
        assert_RegisterOutSelect(7);

        assert_registerWrite(1);

        index = index + 1;

        end_test();
      end

      summary_testing();
    end
  endtask

  // CHGSP
  task test_type_15A;

    integer index;

    reg [15:0] insts[2:0];

    begin
      prepare_testing();

      // chgsp x1 3
      insts[0] <= 16'b0111010100000001;
      // chgsp x2 -5
      insts[1] <= 16'b0111010100000010;

      index = 0;
      current_test_item = "Type 15A: CHGSP";

      repeat (2) begin

        begin_testing();

        in <= insts[index];
        #(DELAY_PER_CYCLE);

        assert_ALUInput1Select(1);
        assert_ALUInput2Select(2);
        assert_ALUOp(0);
        assert_PCOutSelect(0);
        assert_SPOutSelect(0);

        assert_spWrite(1);

        index = index + 1;

        end_test();
      end

      summary_testing();
    end
  endtask


  // SETSP
  task test_type_15B;

    integer index;

    reg [15:0] insts[2:0];

    begin
      prepare_testing();

      // setsp x1
      insts[0] <= 16'b0111010100001001;
      // setsp x2
      insts[1] <= 16'b0111010100001010;

      index = 0;
      current_test_item = "Type 15B: SETSP";

      repeat (2) begin

        begin_testing();

        in <= insts[index];
        #(DELAY_PER_CYCLE);

        assert_PCOutSelect(0);
        assert_SPOutSelect(1);

        assert_spWrite(1);

        index = index + 1;

        end_test();
      end

      summary_testing();
    end
  endtask

  // CHGPC
  task test_type_15C;

    integer index;

    reg [15:0] insts[2:0];

    begin
      prepare_testing();

      // chgpc x1 3
      insts[0] <= 16'b0111011100000001;
      // chgpc x2 -5
      insts[1] <= 16'b0111011100000010;

      index = 0;
      current_test_item = "Type 15C: CHGPC";

      repeat (2) begin

        begin_testing();

        in <= insts[index];
        #(DELAY_PER_CYCLE);

        assert_ALUInput1Select(0);
        assert_ALUInput2Select(2);
        assert_ALUOp(0);
        assert_PCOutSelect(1);

        assert_forcePCAlternate(1);

        index = index + 1;

        end_test();
      end

      summary_testing();
    end
  endtask

  // SETPC
  task test_type_15D;

    integer index;

    reg [15:0] insts[2:0];

    begin
      prepare_testing();

      // setpc x1
      insts[0] <= 16'b0111011100001001;
      // setpc x2
      insts[1] <= 16'b0111011100001010;

      index = 0;
      current_test_item = "Type 15D: SETPC";

      repeat (2) begin

        begin_testing();

        in <= insts[index];
        #(DELAY_PER_CYCLE);

        assert_PCOutSelect(3);

        assert_forcePCAlternate(1);

        index = index + 1;

        end_test();
      end

      summary_testing();
    end
  endtask



  // WRITE
  task test_type_16;

    integer index;

    reg [15:0] insts[2:0];

    begin
      prepare_testing();

      // write x1
      insts[0] <= 16'b0111000100001001;
      // write x2
      insts[1] <= 16'b0111000100001010;

      index = 0;
      current_test_item = "Type 16: WRITE";

      repeat (2) begin

        begin_testing();

        in <= insts[index];
        #(DELAY_PER_CYCLE);

        assert_PCOutSelect(0);

        index = index + 1;

        end_test();
      end

      summary_testing();
    end
  endtask

  // GETSP
  task test_type_17A;

    integer index;

    reg [15:0] insts[2:0];

    begin
      prepare_testing();

      // getsp x1
      insts[0] <= 16'b0111010000000001;
      // getsp x2
      insts[1] <= 16'b0111010000000010;

      index = 0;
      current_test_item = "Type 17A: GETSP";

      repeat (2) begin

        begin_testing();

        in <= insts[index];
        #(DELAY_PER_CYCLE);

        assert_PCOutSelect(0);
        assert_RegisterOutSelect(5);

        assert_registerWrite(1);

        index = index + 1;

        end_test();
      end

      summary_testing();
    end
  endtask

  // GETPC
  task test_type_17B;

    integer index;

    reg [15:0] insts[2:0];

    begin
      prepare_testing();

      // getsp x1
      insts[0] <= 16'b0111011000000001;
      // getsp x2
      insts[1] <= 16'b0111011000000010;

      index = 0;
      current_test_item = "Type 17B: GETPC";

      repeat (2) begin

        begin_testing();

        in <= insts[index];
        #(DELAY_PER_CYCLE);

        assert_PCOutSelect(0);
        assert_RegisterOutSelect(6);

        assert_registerWrite(1);

        index = index + 1;

        end_test();
      end

      summary_testing();
    end
  endtask

  //---------- Test All Types  ----------//

  initial begin

    test_type_1();
    test_type_2();
    test_type_3();
    test_type_4();
    test_type_5();
    test_type_6();
    test_type_7();
    test_type_8A();
    test_type_8B();
    test_type_9();
    test_type_10();
    test_type_11();
    test_type_12();
    test_type_13();
    test_type_14();
    test_type_15A();
    test_type_15B();
    test_type_15C();
    test_type_15D();
    test_type_16();
    test_type_17A();
    test_type_17B();

    $display("\n\n[L_Control Flag Test] TESTS COMPLETE. Failures = %d\n\n", failures);

  end


endmodule


