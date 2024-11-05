module instruction_decoder_tb;

    // Inputs
    reg [31:0] instruction;

    // Outputs
    wire [4:0] RegisterA;
    wire [4:0] RegisterB;
    wire [4:0] WW;
    wire [5:0] operation;
    wire [4:0] arithmatic_RD;
    wire [4:0] HDU_A;
    wire [4:0] HDU_B;
    wire [1:0] BR;
    wire [15:0] Branch_immediate;
    wire [15:0] MEM_addr;
    wire store_Enable;
    wire mem_Enable;
    wire writen_en;
    wire load_signal;

    // Instantiate the instruction decoder
    instruction_decoder uut (
        .instruction(instruction),
        .RegisterA(RegisterA),
        .RegisterB(RegisterB),
        .WW(WW),
        .operation(operation),
        .arithmatic_RD(arithmatic_RD),
        .HDU_A(HDU_A),
        .HDU_B(HDU_B),
        .BR(BR),
        .Branch_immediate(Branch_immediate),
        .MEM_addr(MEM_addr),
        .store_Enable(store_Enable),
        .mem_Enable(mem_Enable),
        .writen_en(writen_en),
        .load_signal(load_signal)
    );

    initial begin
        // Test Vectors
        $display("Starting Instruction Decoder Testbench");
      

        // Test Case 1: R-type Instruction
        instruction = 32'b101010_11010_10101_00101_00011_000010; // Example R-type
        #10;
		  $display($time, " instruction=%b, RegisterA=%b, RegisterB=%b, WW=%b, operation=%b, arithmatic_RD=%b, HDU_A=%b, HDU_B=%b, BR=%b, Branch_immediate=%b, MEM_addr=%b, store_Enable=%b, mem_Enable=%b, writen_en=%b, load_signal=%b", 
                instruction, RegisterA, RegisterB, WW, operation, arithmatic_RD, HDU_A, HDU_B, BR, Branch_immediate, MEM_addr, store_Enable, mem_Enable, writen_en, load_signal);
        // Test Case 2: VBNZ Branch Instruction
        instruction = 32'b100010_11011_00000_10101_00011_000010; // Example R-type  // Example Branch VBNZ
        #10;
		  $display($time, " instruction=%b, RegisterA=%b, RegisterB=%b, WW=%b, operation=%b, arithmatic_RD=%b, HDU_A=%b, HDU_B=%b, BR=%b, Branch_immediate=%b, MEM_addr=%b, store_Enable=%b, mem_Enable=%b, writen_en=%b, load_signal=%b", 
                instruction, RegisterA, RegisterB, WW, operation, arithmatic_RD, HDU_A, HDU_B, BR, Branch_immediate, MEM_addr, store_Enable, mem_Enable, writen_en, load_signal);
        // Test Case 3: VBENZ Branch Instruction
          instruction =  32'b100011_11001_00000_11101_00011_000010; // Example R-type; // Example Branch VBNZ
        #10;
			  $display($time, " instruction=%b, RegisterA=%b, RegisterB=%b, WW=%b, operation=%b, arithmatic_RD=%b, HDU_A=%b, HDU_B=%b, BR=%b, Branch_immediate=%b, MEM_addr=%b, store_Enable=%b, mem_Enable=%b, writen_en=%b, load_signal=%b", 
                instruction, RegisterA, RegisterB, WW, operation, arithmatic_RD, HDU_A, HDU_B, BR, Branch_immediate, MEM_addr, store_Enable, mem_Enable, writen_en, load_signal);
        // Test Case 4: SW (Store Word) Instruction
         instruction =  32'b100001_11111_00000_11101_00011_000010;  // Example SW
        #10;
			  $display($time, " instruction=%b, RegisterA=%b, RegisterB=%b, WW=%b, operation=%b, arithmatic_RD=%b, HDU_A=%b, HDU_B=%b, BR=%b, Branch_immediate=%b, MEM_addr=%b, store_Enable=%b, mem_Enable=%b, writen_en=%b, load_signal=%b", 
                instruction, RegisterA, RegisterB, WW, operation, arithmatic_RD, HDU_A, HDU_B, BR, Branch_immediate, MEM_addr, store_Enable, mem_Enable, writen_en, load_signal);
        // Test Case 5: LW (Load Word) Instruction
        instruction = 32'b100000_11110_00000_11101_00011_000010; // Example LW
        #10;
		  $display($time, " instruction=%b, RegisterA=%b, RegisterB=%b, WW=%b, operation=%b, arithmatic_RD=%b, HDU_A=%b, HDU_B=%b, BR=%b, Branch_immediate=%b, MEM_addr=%b, store_Enable=%b, mem_Enable=%b, writen_en=%b, load_signal=%b", 
                instruction, RegisterA, RegisterB, WW, operation, arithmatic_RD, HDU_A, HDU_B, BR, Branch_immediate, MEM_addr, store_Enable, mem_Enable, writen_en, load_signal);
        // Test Case 6: NOP Instruction
         instruction = 32'b111100_00000_00000_00000_00000_000000; // Example NOP
        #10;
		  $display($time, " instruction=%b, RegisterA=%b, RegisterB=%b, WW=%b, operation=%b, arithmatic_RD=%b, HDU_A=%b, HDU_B=%b, BR=%b, Branch_immediate=%b, MEM_addr=%b, store_Enable=%b, mem_Enable=%b, writen_en=%b, load_signal=%b", 
                instruction, RegisterA, RegisterB, WW, operation, arithmatic_RD, HDU_A, HDU_B, BR, Branch_immediate, MEM_addr, store_Enable, mem_Enable, writen_en, load_signal);
        // Testbench finished
        $display("Testbench finished");
        $finish;
    end
endmodule
