`timescale 1ns / 100ps

module T_L_Logical_Sector();

    // Inputs, Outputs and flags declared Below
    reg [15:0] instruction;
    reg [15:0] inputLine;  
    reg [15:0] in0;
    reg [15:0] in1;
    reg [15:0] in2;        
    reg [15:0] spIn;       
    reg [15:0] pcIn;       
    reg [15:0] raIn;       
    reg [15:0] memoryIn;   

    wire [15:0] outputLine; 
    wire [15:0] out;
    wire [15:0] spOut;
    wire [15:0] pcOut;
    wire [15:0] raOut;
    wire [15:0] memoryAddress;
    wire [15:0] memoryOut;

    wire registerWrite;
    wire spWrite;
    wire raWrite;
    wire memoryWrite;

    //Stuff we need for running tests
    parameter CYCLE_TIME = 1;
    parameter DELAY_PER_CYCLE = (CYCLE_TIME * 10);
    integer total_failures = 0;
    integer current_failures = 0;


    reg [16*8-1:0] current_test_item = "NONE";


     // Instantiate the Unit Under Test (UUT)
    L_Logical_Sector UUT (
        .instruction(instruction),
        .inputLine(inputLine),
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .spIn(spIn),
        .pcIn(pcIn),
        .raIn(raIn),
        .memoryIn(memoryIn),
        .out(out),
        .spOut(spOut),
        .pcOut(pcOut),
        .raOut(raOut),
        .memoryAddress(memoryAddress),
        .memoryOut(memoryOut),
        .registerWrite(registerWrite),
        .spWrite(spWrite),
        .raWrite(raWrite),
        .memoryWrite(memoryWrite),
        .outputLine(outputLine)
    );

   
  task assert_equal(input integer expected, input integer actual);
    begin
      if (expected != actual) begin
        $display(
            "Error While Testing %s, [Expected: %0d VS Actual: %0d], @ Time: %t",
                  current_test_item, expected,         actual,         $time);
        current_failures = current_failures + 1;
      end
    end
  endtask

  task reset_everything;
    begin
      instruction <= 16'b0;
      inputLine <= 16'b0;
      in0 <= 16'b0;
      in1 <= 16'b0;
      in2 <= 16'b0;
      spIn <= 16'b0;
      pcIn <= 16'b0;
      raIn <= 16'b0;
      memoryIn <= 16'b0;

      current_failures = 0;

      #(DELAY_PER_CYCLE);
    
    end
  endtask

  task update_failures;
    begin
      total_failures = total_failures + current_failures;
    end
  endtask

  task instruction_reset;  //no time delay
    begin
      instruction <= 16'b0;  
    end
  endtask

  //TESTS FOR TYPE 1: GEQ, NEQ, LT, EQ, note: imm*2 gets added

  task test_type_1_geq;
    begin
      // GEQ -> 3 Cases
      instruction = 16'b1110001001010001; // geq x1 x2 9

      //10>=10 -> True
      pcIn <= 100;
      in0 <= 10;
      in1 <= 10;
      #(DELAY_PER_CYCLE); //wait for results
      assert_equal(118, pcOut);

      //10>=9 -> True
      pcIn <= 100;
      in0 <= 10;
      in1 <= 9;
      #(DELAY_PER_CYCLE); //wait for results
      assert_equal(118, pcOut);

      //9>=10 -> False
      pcIn <= 100;
      in0 <= 9;
      in1 <= 10;
      #(DELAY_PER_CYCLE); //wait for results
      assert_equal(102, pcOut);
    end
  endtask
      
  task test_type_1_neq;   
    begin
      // NEQ -> 2 Cases
      instruction = 16'b1100001001010001; // neq x1 x2 9

      //9!=10 -> True
      pcIn <= 100;
      in0 <= 9;
      in1 <= 10;
      #(DELAY_PER_CYCLE); //wait for results
      assert_equal(118, pcOut);

      //10!=10 -> False
      pcIn <= 100;
      in0 <= 10;
      in1 <= 10;
      #(DELAY_PER_CYCLE); //wait for results
      assert_equal(102, pcOut);
    end
  endtask

  task test_type_1_lt;
    begin
      // lt -> 2 Cases
      instruction = 16'b1010001001010001; // lt  x1 x2 9

      //9<10 -> True
      pcIn <= 100;
      in0 <= 9;
      in1 <= 10;
      #(DELAY_PER_CYCLE); //wait for results
      assert_equal(118, pcOut);

      //10<9 -> False
      pcIn <= 100;
      in0 <= 10;
      in1 <= 9;
      #(DELAY_PER_CYCLE); //wait for results
      assert_equal(102, pcOut);
    end
  endtask

  task test_type_1_eq;   
    begin
      // EQ -> 2 Cases
      instruction = 16'b1000001001010001; // eq  x1 x2 9

      //10==10 -> True
      pcIn <= 100;
      in0 <= 10;
      in1 <= 10;
      #(DELAY_PER_CYCLE); //wait for results
      assert_equal(118, pcOut);

      //9==10 -> False
      pcIn <= 100;
      in0 <= 9;
      in1 <= 10;
      #(DELAY_PER_CYCLE); //wait for results
      assert_equal(102, pcOut);
    end
  endtask

  // RUNNER For Test 1
  task test_type_1;
    begin
      current_test_item = "Type 1: Branch";
      reset_everything();
      test_type_1_geq();
      update_failures();

      reset_everything();
      test_type_1_neq();
      update_failures();

      reset_everything();
      test_type_1_lt();

      reset_everything();
      test_type_1_eq();
      update_failures();

      if (current_failures == 0) begin
        $display("[%s] Test Passed.", current_test_item);
      end else begin
        $display("[%s] Test Failed.", current_test_item);
      end
    end
  endtask

  // TESTS FOR TYPE 2 : STRSP
  task test_type_2;
    begin
      current_test_item = "Type 3: STRSP";
      reset_everything();
      // strsp x1 3
      spIn <= 16'd200;
      instruction <= 16'b0100000000011001;
      #(DELAY_PER_CYCLE);  //wait for inst
      assert_equal(1'b1, memoryWrite);  //Make sure memory  write is enabled
      assert_equal(spIn + 3*2, spOut);  //We store items at spIn + offset*2
      update_failures();

      // strsp x2 -8
      spIn <= 16'd200;
      instruction <= 16'b0100111111000010;
      #(DELAY_PER_CYCLE); //wait for inst
      assert_equal(1'b1, memoryWrite);  //Make sure memory  write is enabled
      assert_equal(spIn - 16 , spOut);  //We store items at spIn - offset*2
      update_failures();

      if (current_failures == 0) begin
        $display("[%s] Test Passed.", current_test_item);
      end else begin
        $display("[%s] Test Failed.", current_test_item);
      end
    end
  endtask

  // Tests for Type 3: RTVSP
  task test_type_3;
    begin
      current_test_item = "Type 3: RTVSP";
      reset_everything();
      // rtvsp x1 3
      spIn <= 16'd200;
      memoryIn <= 16'd123;  //fake the value we got from memory
      instruction <= 16'b0101000000011001;
      #(DELAY_PER_CYCLE);                 //wait for inst
      assert_equal(1'b1, registerWrite); //Make sure register  write is enabled
      assert_equal(16'd123, out);        //Check whether we got the right value from memory
      assert_equal(spIn + 6, spOut);  //We fetch items from spIn + offset*2
      update_failures();

      instruction_reset();
      
      // rtvsp x2 -8
      spIn <= 16'd200;
      memoryIn <= 16'd345;  //fake the value we got from memory
      instruction <= 16'b0101111111000010;  
      #(DELAY_PER_CYCLE);                 //wait for inst
      assert_equal(1'b1, registerWrite); //Make sure register  write is enabled
      assert_equal(16'd345, out);        //Check whether we got the right value from memory
      assert_equal(spIn - 16 , spOut);  //We fetch items from spIn - offset*2
      update_failures();

      if (current_failures == 0) begin
        $display("[%s] Test Passed.", current_test_item);
      end else begin
        $display("[%s] Test Failed.", current_test_item);
      end
    end
  endtask

  // Tests for Type 4: ADDI
  task test_type_4;
    begin
      current_test_item = "Type 4: ADDI";
      reset_everything();

      in1 <= 16'd15; 
      instruction <= 16'b0010001010010001; // addi x1 x2 10; 
      #(DELAY_PER_CYCLE);  
      assert_equal(1'b1, registerWrite);  // Make sure register write is enabled
      assert_equal(16'd25, out);  // Check whether the result of x2 + 10 is correct
      update_failures();

      instruction_reset();  // Clear instruction to avoid repeated execution

      in1 <= 16'd30;  
      instruction <= 16'b0010110110011010;  // addi x2 x3 -10
      #(DELAY_PER_CYCLE);  // Wait for the operation to complete
      assert_equal(1'b1, registerWrite);  // Make sure register write is enabled
      assert_equal(16'd20, out);  // Check whether the result of x3 - 10 is correct

      update_failures();
      if (current_failures == 0) begin
        $display("[%s] Test Passed.", current_test_item);
      end else begin
        $display("[%s] Test Failed.", current_test_item);
      end
    end
  endtask

  //Type 5: LL
  task test_type_5;
    begin
    current_test_item = "Type 5: LL";
    reset_everything();

    // ll x1 12
    instruction = 16'b0001100001100001; // Load lower 12 into x1
    #(DELAY_PER_CYCLE);  
    assert_equal(1'b1, registerWrite);  
    assert_equal(16'd12, out);
    update_failures();  

    reset_everything();   //for some reason, resetting only instruction doesn't work

    // ll x2 23
    instruction = 16'b0001100010111010; // Load lower 23 into x2
    #(DELAY_PER_CYCLE);  
    assert_equal(1'b1, registerWrite);  
    assert_equal(16'd23, out);  

    update_failures();
      if (current_failures == 0) begin
        $display("[%s] Test Passed.", current_test_item);
      end else begin
        $display("[%s] Test Failed.", current_test_item);
      end
    end
  endtask

  //"Type 6: LU"
  task test_type_6;
    begin
    current_test_item = "Type 6: LU";
    reset_everything();

    // lu x1 12
    instruction = 16'b0001000001100001; // Load upper 12 into x1
    #(DELAY_PER_CYCLE);  
    assert_equal(1'b1, registerWrite);  
    assert_equal(16'd3072, out);  // 12 << 8
    update_failures();

    reset_everything();

    // lu x2 23
    instruction = 16'b0001000010111010; // Load upper 23 into x2
    #(DELAY_PER_CYCLE);  
    assert_equal(1'b1, registerWrite);  
    assert_equal(16'd5888, out);  // 23 << 8

    update_failures();
      if (current_failures == 0) begin
        $display("[%s] Test Passed.", current_test_item);
      end else begin
        $display("[%s] Test Failed.", current_test_item);
      end    
    end
  endtask

  //Type 7: SHIFT
  task test_type_7;
    begin
      current_test_item = "Type 7: SHIFT";
      reset_everything();

      // shift x1 x2 2
      in1 = 16'd3; // Initial value for x2
      instruction = 16'b0011000010010001; // Shift x2 left by 2
      #(DELAY_PER_CYCLE);  
      assert_equal(1'b1, registerWrite);  
      assert_equal(16'd12, out);  // 3 << 2
      update_failures();

      reset_everything();

      // shift x3 x4 16
      in1 = 16'd1; // Initial value for x4
      instruction = 16'b0011010000100011; // Shift x4 left by 16
      #(DELAY_PER_CYCLE);  
      assert_equal(1'b1, registerWrite);  
      assert_equal(16'd65536, out);  // 1 << 16
      update_failures();

      if (current_failures == 0) begin
        $display("[%s] Test Passed.", current_test_item);
      end else begin
        $display("[%s] Test Failed.", current_test_item);
      end    
    end
  endtask

  //Type 8A: CHGSPI
  task test_type_8A;
    begin
      current_test_item = "Type 8A: CHGSPI";
      reset_everything();

      // chgspi 3
      spIn = 16'd100; // Initial stack pointer value
      instruction = 16'b0111100000000011; // CHGSPI with +3
      #(DELAY_PER_CYCLE);
      assert_equal(1'b1, spWrite);
      assert_equal(16'd106, spOut); // SP incremented by 3 * 2

      reset_everything();

      // chgspi -5
      spIn = 16'd100; // Reset stack pointer value
      instruction = 16'b0111101111111011; // CHGSPI with -5
      #(DELAY_PER_CYCLE);
      assert_equal(1'b1, spWrite);
      assert_equal(16'd90, spOut); // SP decremented by 5 * 2

      update_failures();

      if (current_failures == 0) begin
        $display("[%s] Test Passed.", current_test_item);
      end else begin
        $display("[%s] Test Failed.", current_test_item);
      end    
    end
  endtask

  //Type 8B: CHGPCI
  task test_type_8B;
    begin
      current_test_item = "Type 8B: CHGPCI";
      reset_everything();

      // chgpci 3
      pcIn = 16'd100; // Initial program counter value
      instruction = 16'b0111110000000011; // CHGPCI with +3
      #(DELAY_PER_CYCLE);
      assert_equal(16'd106, pcOut); // PC incremented by 3 * 2

      reset_everything();

      // chgpci -5
      pcIn = 16'd100; // Reset program counter value
      instruction = 16'b0111111111111011; // CHGPCI with -5
      #(DELAY_PER_CYCLE);
      assert_equal(16'd90, pcOut); // PC decremented by 5 * 2

      update_failures();

      if (current_failures == 0) begin
        $display("[%s] Test Passed.", current_test_item);
      end else begin
        $display("[%s] Test Failed.", current_test_item);
      end    
    end
  endtask

  //Type 9: JUMP
  task test_type_9;
    begin
      current_test_item = "Type 9: JUMP";
      reset_everything();

      // jump 3
      pcIn = 16'd100; // Initial program counter value
      raIn = 16'd200; // Initial return address value
      spIn = 16'd50;  
      instruction = 16'b0011110000000011; // JUMP with +3
      #(DELAY_PER_CYCLE);
      assert_equal(1'b1, raWrite);   
      assert_equal(16'd102, raOut);
      assert_equal(16'd200, memoryOut); // Memory out should hold RA value
      assert_equal(16'd50, memoryAddress);
      assert_equal(16'd106, pcOut); // PC incremented by 3 * 2

      reset_everything();

      // jump -5
      pcIn = 16'd100; // Reset program counter value
      raIn = 16'd200; // Reset return address value
      spIn = 16'd46;  
      instruction = 16'b0011111111111011; // JUMP with -5
      #(DELAY_PER_CYCLE);
      assert_equal(1'b1, raWrite);
      assert_equal(16'd102, raOut);
      assert_equal(16'd200, memoryOut); // Memory out should still hold RA value
      assert_equal(16'd46, memoryAddress);
      assert_equal(16'd90, pcOut); // PC decremented by 5 * 2

      update_failures();

      if (current_failures == 0) begin
        $display("[%s] Test Passed.", current_test_item);
      end else begin
        $display("[%s] Test Failed.", current_test_item);
      end    
    end
  endtask

  //Type 10: RETURN
  task test_type_10;
    begin
      current_test_item = "Type 10: RETURN";
      reset_everything();

      // return 3
      spIn = 16'd100; // Initial stack pointer value
      raIn = 16'd300; // Initial return address value
      memoryIn = 16'd200; // Simulated address to return to, fetched from memory
      instruction = 16'b0011100000000011; // RETURN with +3
      #(DELAY_PER_CYCLE);
      assert_equal(1'b1, raWrite);   
      assert_equal(16'd200, raOut); // RA should be memory in
      assert_equal(16'd300, pcOut); // PC should = RA
      assert_equal(16'd106, spOut); // SP incremented by 3 * 2, simulating pop from stack

      reset_everything();

      // return -5
      spIn = 16'd100; // Reset stack pointer value
      raIn = 16'd300; // Reset return address value
      memoryIn = 16'd250; // Simulated address to return to, fetched from memory
      instruction = 16'b0011101111111011; // RETURN with -5
      #(DELAY_PER_CYCLE);
      assert_equal(1'b1, raWrite);
      assert_equal(16'd250, raOut); // RA should be unchanged
      assert_equal(16'd300, pcOut); // PC should jump to the address fetched from memory (simulate memory fetch)
      assert_equal(16'd90, spOut); // SP decremented by 5 * 2, simulating pop from stack

      update_failures();

      if (current_failures == 0) begin
        $display("[%s] Test Passed.", current_test_item);
      end else begin
        $display("[%s] Test Failed.", current_test_item);
      end    
    end
  endtask

  //Type 11 -> Logical
  task test_type_11;
    begin
      current_test_item = "Type 11 -> Logical";
      reset_everything();

      // Set up inputs for the operations
      in1 = 16'd15; // Example value for in1
      in2 = 16'd10; // Example value for in2

      // AND x1 x2 x3
      instruction = 16'b0000001011010001;
      #(DELAY_PER_CYCLE); // Wait for the operation to complete
      assert_equal(1'b1, registerWrite); // Make sure register write is enabled
      assert_equal(unsigned'(in1 & in2), out); // Check the AND operation result

      reset_everything();

      // ADD x1 x2 x3
      instruction = 16'b0000000011010001;
      #(DELAY_PER_CYCLE); // Wait for the operation to complete
      assert_equal(1'b1, registerWrite); // Make sure register write is enabled
      assert_equal(unsigned'(in1 + in2), out); // Check the ADD operation result

      reset_everything();

      // XOR x1 x2 x3
      instruction = 16'b0000011011010001;
      #(DELAY_PER_CYCLE); // Wait for the operation to complete
      assert_equal(1'b1, registerWrite); // Make sure register write is enabled
      assert_equal(unsigned'(in1 ^ in2) , out); // Check the XOR operation result

      reset_everything();

      // OR x1 x2 x3
      instruction = 16'b0000010011010001;
      #(DELAY_PER_CYCLE); // Wait for the operation to complete
      assert_equal(1'b1, registerWrite); // Make sure register write is enabled
      assert_equal(unsigned'(in1 | in2), out); // Check the OR operation result

      reset_everything();

      // NOR x1 x2 x3
      instruction = 16'b0000110011010001;
      #(DELAY_PER_CYCLE); // Wait for the operation to complete
      assert_equal(1'b1, registerWrite); // Make sure register write is enabled
      assert_equal(unsigned'(~(in1 | in2)), out); // Check the NOR operation result

      reset_everything();

      // SUB x1 x2 x3
      instruction = 16'b0000100011010001;
      #(DELAY_PER_CYCLE); // Wait for the operation to complete
      assert_equal(1'b1, registerWrite); // Make sure register write is enabled
      assert_equal((unsigned'(in1 - in2)), out); // Check the SUB operation result

      reset_everything();

      // NAND x1 x2 x3
      instruction = 16'b0000101011010001;
      #(DELAY_PER_CYCLE); // Wait for the operation to complete
      assert_equal(1'b1, registerWrite); // Make sure register write is enabled
      assert_equal(unsigned'(~(in1 & in2)), out); // Check the NAND operation result

      reset_everything();

      // XNOR x1 x2 x3
      instruction = 16'b0000111011010001;
      #(DELAY_PER_CYCLE); // Wait for the operation to complete
      assert_equal(1'b1, registerWrite); // Make sure register write is enabled
      assert_equal(unsigned'(~(in1 ^ in2)), out); // Check the XNOR operation result

      update_failures();

      if (current_failures == 0) begin
        $display("[%s] Test Passed.", current_test_item);
      end else begin
        $display("[%s] Test Failed.", current_test_item);
      end
    end
  endtask

  // Tests for Type 12: STR
  task test_type_12;
    begin
      current_test_item = "Type 12: STR";
      reset_everything();

      // str x1 x2 - Store value of x1 at address pointed by x2
      in0 = 16'd123; // Value to store
      in1 = 16'd200; // Address
      instruction = 16'b0111000010010001; // str x1 x2
      #(DELAY_PER_CYCLE); // Wait for operation to complete
      assert_equal(1'b1, memoryWrite); // Make sure memory write is enabled
      assert_equal(in0, memoryOut); // Check if in0 is ready to be written to memory
      assert_equal(in1, memoryAddress); // Check if address is correctly taken from in1

      reset_everything(); 

      // str x2 x3 - Store value of x2 at address pointed by x3
      in0 = 16'd456; // New value to store
      in1 = 16'd300; // New address
      instruction = 16'b0111000010011010; // str x2 x3
      #(DELAY_PER_CYCLE); // Wait for operation to complete
      assert_equal(1'b1, memoryWrite); // Make sure memory write is enabled
      assert_equal(in0, memoryOut); // Check if in1 is ready to be written to memory
      assert_equal(in1, memoryAddress); // Check if address is correctly taken from in2

      update_failures();

      if (current_failures == 0) begin
        $display("[%s] Test Passed.", current_test_item);
      end else begin
        $display("[%s] Test Failed.", current_test_item);
      end
    end
  endtask

  // Tests for Type 13: RTV
  task test_type_13;
    begin
      current_test_item = "Type 13: RTV";
      reset_everything();

      // rtv x1 x2 - Load value to x1 from address pointed by x2
      in1 = 16'd200; // Address
      memoryIn = 16'd123; // Value at memory address
      instruction = 16'b0111000011010001; // rtv x1 x2
      #(DELAY_PER_CYCLE); // Wait for operation to complete
      assert_equal(1'b1, registerWrite); // Make sure register write is enabled
      assert_equal(memoryIn, out); // Check if value loaded into x1 matches memoryIn
      assert_equal(in1, memoryAddress); // Check if memory address is correctly taken from in1

      reset_everything(); // Reset everything for next test case

      // rtv x2 x3 - Load value to x2 from address pointed by x3
      in1 = 16'd300; // New address
      memoryIn = 16'd456; // New value at memory address
      instruction = 16'b0111000011011010; // rtv x2 x3
      #(DELAY_PER_CYCLE); // Wait for operation to complete
      assert_equal(1'b1, registerWrite); // Make sure register write is enabled
      assert_equal(memoryIn, out); // Check if value loaded into x2 matches memoryIn
      assert_equal(in1, memoryAddress); // Check if memory address is correctly taken from in2

      update_failures();

      if (current_failures == 0) begin
        $display("[%s] Test Passed.", current_test_item);
      end else begin
        $display("[%s] Test Failed.", current_test_item);
      end    
    end
  endtask

  // Tests for Type 14: READ
  task test_type_14;
    begin
      current_test_item = "Type 14: READ";
      reset_everything();
      
      inputLine = 16'd321; // Value at input line
      instruction = 16'b0111000100000010; // read x2
      #(DELAY_PER_CYCLE); // Wait for operation to complete
      assert_equal(1'b1, registerWrite); // Make sure register write is enabled
      assert_equal(inputLine, out); // Check if value read into x2 matches inputLine

      #(DELAY_PER_CYCLE); //don't mess with any sort of reset

      inputLine = 16'd745; // Value at input line
      instruction = 16'b0111000100000010; // read x2
      #(DELAY_PER_CYCLE); // Wait for operation to complete
      assert_equal(1'b1, registerWrite); // Make sure register write is enabled
      assert_equal(inputLine, out); 

      update_failures();

      if (current_failures == 0) begin
        $display("[%s] Test Passed.", current_test_item);
      end else begin
        $display("[%s] Test Failed.", current_test_item);
      end    
    end
  endtask

  // Tests for Type 15A: CHGSP
  task test_type_15A;
    begin
      current_test_item = "Type 15A: CHGSP";
      reset_everything();

      // chgsp x1 3 - Change SP based on the value in x1
      in0 = 16'd100; // Initial value in x1
      spIn = 16'd200; // Initial stack pointer value
      instruction = 16'b0111010100000001; // chgsp x1
      #(DELAY_PER_CYCLE); // Wait for operation to complete
      assert_equal(1'b1, spWrite); // Make sure SP write is enabled
      assert_equal(in0+spIn, spOut); // Check if SP is correctly updated

      reset_everything(); // Reset everything for next test case

      // chgsp x2 -5 - Change SP based on the value in x2
      in0 = 16'd150; // Initial value in x2
      spIn = 16'd200; // Reset stack pointer value
      instruction = 16'b0111010100000010; // chgsp x2 
      #(DELAY_PER_CYCLE); // Wait for operation to complete
      assert_equal(1'b1, spWrite); // Make sure SP write is enabled
      assert_equal(in0+spIn, spOut); // Check if SP is correctly updated

      update_failures();

      if (current_failures == 0) begin
        $display("[%s] Test Passed.", current_test_item);
      end else begin
        $display("[%s] Test Failed.", current_test_item);
      end    
    end
  endtask

  // Tests for Type 15B: SETSP
  task test_type_15B;
    begin
      current_test_item = "Type 15B: SETSP";
      reset_everything();

      // setsp x1 - Set SP to the value in x1
      in0 = 16'd300; // Initial value in x1
      spIn = 16'd200; // Initial stack pointer value
      instruction = 16'b0111010100001001; // setsp x1
      #(DELAY_PER_CYCLE); // Wait for operation to complete
      assert_equal(1'b1, spWrite); // Make sure SP write is enabled
      assert_equal(in0, spOut); // Check if SP is correctly updated to x1

      reset_everything(); // Reset everything for next test case

      // setsp x2 - Set SP to the value in x2
      in0 = 16'd400; // Initial value in x2
      spIn = 16'd200; // Reset stack pointer value
      instruction = 16'b0111010100001010; // setsp x2
      #(DELAY_PER_CYCLE); // Wait for operation to complete
      assert_equal(1'b1, spWrite); // Make sure SP write is enabled
      assert_equal(in0, spOut); // Check if SP is correctly updated to x2

      update_failures();

      if (current_failures == 0) begin
        $display("[%s] Test Passed.", current_test_item);
      end else begin
        $display("[%s] Test Failed.", current_test_item);
      end    
    end
  endtask

  // Tests for Type 15C: CHGPC
  task test_type_15C;
    begin
      current_test_item = "Type 15C: CHGPC";
      reset_everything();

      // chgpc x1 - Change PC to the value in x1
      in0 = 16'd50; // Initial value in x1 to change PC to
      pcIn = 16'd100; // Initial program counter value
      instruction = 16'b0111011100000001; // chgpc x1
      #(DELAY_PER_CYCLE); // Wait for operation to complete
      assert_equal(pcIn + in0, pcOut); // Check if PC is correctly updated to x1

      reset_everything(); // Reset everything for next test case

      // chgpc x2 - Change PC to the value in x2
      in0 = 16'd10; // Change input register to simulate x2 with new value to change PC to
      pcIn = 16'd200; // Reset program counter value
      instruction = 16'b0111011100000010; // chgpc x2
      #(DELAY_PER_CYCLE); // Wait for operation to complete
      assert_equal(pcIn + in0, pcOut); // Check if PC is correctly updated to x2

      update_failures();

      if (current_failures == 0) begin
        $display("[%s] Test Passed.", current_test_item);
      end else begin
        $display("[%s] Test Failed.", current_test_item);
      end    
    end
  endtask

  // Tests for Type 15D: SETPC
  task test_type_15D;
    begin
      current_test_item = "Type 15D: SETPC";
      reset_everything();

      // setpc x1 - Set PC to the value in x1
      in0 = 16'd300; // Initial value in x1 to set PC to
      instruction = 16'b0111011100001001; // setpc x1
      #(DELAY_PER_CYCLE); // Wait for operation to complete
      assert_equal(in0, pcOut); // Check if PC is correctly updated to x1

      reset_everything(); // Reset everything for next test case

      // setpc x2 - Set PC to the value in x2
      in0 = 16'd400; // Change input register to simulate x2 with new value to set PC to
      instruction = 16'b0111011100001010; // setpc x2
      #(DELAY_PER_CYCLE); // Wait for operation to complete
      assert_equal(in0, pcOut); // Check if PC is correctly updated to x2

      update_failures();

      if (current_failures == 0) begin
        $display("[%s] Test Passed.", current_test_item);
      end else begin
        $display("[%s] Test Failed.", current_test_item);
      end    
    end
  endtask

  // Tests for Type 16: WRITE
  task test_type_16;
    begin
      current_test_item = "Type 16: WRITE";
      reset_everything();

      // write x1 - Write the value of x1 to output line
      in0 = 16'd123; // Value to be written from x1
      instruction = 16'b0111000100001001; // write x1
      #(DELAY_PER_CYCLE); // Wait for operation to complete
      assert_equal(in0, outputLine); // Check if output line correctly received the value from x1

      reset_everything(); // here you use reset everything for some reason

      // write x2 - Write the value of x2 to output line
      in0 = 16'd456; // Change input register to simulate x2 with new value to be written
      instruction = 16'b0111000100001010; // write x2
      #(DELAY_PER_CYCLE); // Wait for operation to complete
      assert_equal(in0, outputLine); // Check if output line correctly received the value from x2

      update_failures();

      if (current_failures == 0) begin
        $display("[%s] Test Passed.", current_test_item);
      end else begin
        $display("[%s] Test Failed.", current_test_item);
      end    
    end
  endtask

  // Tests for Type 17A: GETSP
  task test_type_17A;
    begin
      current_test_item = "Type 17A: GETSP";
      reset_everything();

      // getsp x1 - Get the value of SP and store in x1
      spIn = 16'd300; // Set the SP input to a test value
      instruction = 16'b0111010000000001; // getsp x1
      #(DELAY_PER_CYCLE); // Wait for operation to complete
      assert_equal(spIn, out); // Verify x1 (through out) now holds SP value

      reset_everything(); // Reset everything for next test case

      // getsp x2 - Get the value of SP and store in x2
      spIn = 16'd400; // Change SP input to simulate new value
      instruction = 16'b0111010000000010; // getsp x2
      #(DELAY_PER_CYCLE); // Wait for operation to complete
      assert_equal(spIn, out); // Verify x2 (through out) now holds SP value

      update_failures();

      if (current_failures == 0) begin
        $display("[%s] Test Passed.", current_test_item);
      end else begin
        $display("[%s] Test Failed.", current_test_item);
      end    
    end
  endtask

  // Tests for Type 17B: GETPC
  task test_type_17B;
    begin
      current_test_item = "Type 17B: GETPC";
      reset_everything();

      // getpc x1 - Get the value of PC and store in x1
      pcIn = 16'd500; // Set the PC input to a test value
      instruction = 16'b0111011000000001; // getpc x1
      #(DELAY_PER_CYCLE); // Wait for operation to complete
      assert_equal(pcIn, out); // Verify x1 (through out) now holds PC value

      reset_everything(); // Reset everything for next test case

      // getpc x2 - Get the value of PC and store in x2
      pcIn = 16'd600; // Change PC input to simulate new value
      instruction = 16'b0111011000000010; // getpc x2
      #(DELAY_PER_CYCLE); // Wait for operation to complete
      assert_equal(pcIn, out); // Verify x2 (through out) now holds PC value

      update_failures();

      if (current_failures == 0) begin
        $display("[%s] Test Passed.", current_test_item);
      end else begin
        $display("[%s] Test Failed.", current_test_item);
      end    
    end
  endtask

  //Driver code for running all test benches
  initial begin
    test_type_1();
    test_type_2();
    test_type_3();
    test_type_4();
    test_type_5();
    test_type_6();
    test_type_7();    //-> Doesn't work
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

    $display("\n[L_Control Flag Test] TESTS COMPLETE. Total Failures = %d\n", total_failures);
  end

endmodule
