`timescale 1ns / 1ps

module alu_tb;

    // Testbench signals
    reg [5:0] opcode;
    reg [0:63] data1, data2;
    reg [1:0] ww;
    wire [63:0] result;
    wire divide_by_0;
    reg [0:63] expected_result;
    reg expected_divide_by_0;

    // Instantiate the ALU module
    alu uut (
        .opcode(opcode),
        .data1(data1),
        .data2(data2),
        .ww(ww),
        .result(result)
    );

    // Test sequence
    initial begin
        // Set time format for readability
        $timeformat(-9, 1, " ns", 6);

        // Test VAND operation
        opcode = 6'b001000; // VAND
        data1 = 64'h1211edee1211edee;
        data2 = 64'h0f0f0f0f0f0f0f0f;

        ww = 2'b00; 
		
		
		
		#10
	    ww = 2'b01; // 16-bit segments
       expected_result[0:31]   = data1[0:15] * data2[0:15];
       expected_result[32:63]  = data1[32:47] * data2[32:47];
        #10;
        if (result[63:0] !== expected_result[0:63])
            $display("Time: %t, Opcode: MULE, WW: 16-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else
            $display("Time: %t, Opcode: MULE, WW: 16-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		// 8-bit
     /*   expected_result = {data1[63:56] & data2[63:56], data1[55:48] & data2[55:48], data1[47:40] & data2[47:40], data1[39:32] & data2[39:32], data1[31:24] & data2[31:24], data1[23:16] & data2[23:16], data1[15:8] & data2[15:8], data1[7:0] & data2[7:0]};
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VAND, WW: 8-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else 
            $display("Time: %t, Opcode: VAND, WW: 8-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);

        ww = 5'b00001; // 16-bit
        expected_result = {data1[15:0] & data2[15:0], data1[31:16] & data2[31:16], data1[47:32] & data2[47:32], data1[63:48] & data2[63:48]};
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VAND, WW: 16-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else 
            $display("Time: %t, Opcode: VAND, WW: 16-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);

        ww = 5'b00010; // 32-bit
        expected_result = {data1[31:0] & data2[31:0], data1[63:32] & data2[63:32]};
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VAND, WW: 32-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else 
            $display("Time: %t, Opcode: VAND, WW: 32-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);

        ww = 5'b00011; // 64-bit
        expected_result = data1 & data2;
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VAND, WW: 64-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else 
            $display("Time: %t, Opcode: VAND, WW: 64-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);

        // Test VOR operation
        opcode = 6'b000010; // VOR

        ww = 5'b00000; // 8-bit
        expected_result = {data1[63:56] | data2[63:56], data1[55:48] | data2[55:48], data1[47:40] | data2[47:40], data1[39:32] | data2[39:32], data1[31:24] | data2[31:24], data1[23:16] | data2[23:16], data1[15:8] | data2[15:8], data1[7:0] | data2[7:0]};
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VOR, WW: 8-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else 
            $display("Time: %t, Opcode: VOR, WW: 8-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);

        ww = 5'b00001; // 16-bit
        expected_result = {data1[15:0] | data2[15:0], data1[31:16] | data2[31:16], data1[47:32] | data2[47:32], data1[63:48] | data2[63:48]};
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VOR, WW: 16-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else 
            $display("Time: %t, Opcode: VOR, WW: 16-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);

        ww = 5'b00010; // 32-bit
        expected_result = {data1[31:0] | data2[31:0], data1[63:32] | data2[63:32]};
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VOR, WW: 32-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else 
            $display("Time: %t, Opcode: VOR, WW: 32-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);

        ww = 5'b00011; // 64-bit
        expected_result = data1 | data2;
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VOR, WW: 64-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else 
            $display("Time: %t, Opcode: VOR, WW: 64-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);













        // Add similar tests for VXOR, VNOT, VADD, VSUB, VDIV, VMOD...
		   // Test VXOR operation
          ww = 5'b00000; // 8-bit
		  opcode = 6'b000011; // VXOR
        expected_result = {data1[63:56] ^ data2[63:56], data1[55:48] ^ data2[55:48], data1[47:40] ^ data2[47:40], data1[39:32] ^ data2[39:32], data1[31:24] ^ data2[31:24], data1[23:16] ^ data2[23:16], data1[15:8] ^ data2[15:8], data1[7:0] ^ data2[7:0]};
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VXOR, WW: 8-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else 
            $display("Time: %t, Opcode: VXOR, WW: 8-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);

        ww = 5'b00001; // 16-bit
        expected_result = {data1[63:48] ^ data2[63:48], data1[47:32] ^ data2[47:32], data1[31:16] ^ data2[31:16], data1[15:0] ^ data2[15:0]};
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VXOR, WW: 16-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else 
            $display("Time: %t, Opcode: VXOR, WW: 16-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);

        ww = 5'b00010; // 32-bit
        expected_result = {data1[63:32] ^ data2[63:32], data1[31:0] ^ data2[31:0]};
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VXOR, WW: 32-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else 
            $display("Time: %t, Opcode: VXOR, WW: 32-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);

        ww = 5'b00011; // 64-bit
        expected_result = data1 ^ data2;
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VXOR, WW: 64-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else 
            $display("Time: %t, Opcode: VXOR, WW: 64-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);

       
	   
	   
	     // Test VNOT operation
        opcode = 6'b000100; // VNOT
        data1 = 65'hAAAAAAAAAAAAAAAA;

        ww = 5'b00000; // 8-bit
        expected_result = {~data1[63:56], ~data1[55:48], ~data1[47:40], ~data1[39:32], ~data1[31:24], ~data1[23:16], ~data1[15:8], ~data1[7:0]};
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VNOT, WW: 8-bit, Data1: %h, Result: %h, Expected: %h [FAIL]", $time, data1, result, expected_result);
        else 
            $display("Time: %t, Opcode: VNOT, WW: 8-bit, Data1: %h, Result: %h [PASS]", $time, data1, result);

        ww = 5'b00001; // 16-bit
        expected_result = {~data1[63:48], ~data1[47:32], ~data1[31:16], ~data1[15:0]};
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VNOT, WW: 16-bit, Data1: %h, Result: %h, Expected: %h [FAIL]", $time, data1, result, expected_result);
        else 
            $display("Time: %t, Opcode: VNOT, WW: 16-bit, Data1: %h, Result: %h [PASS]", $time, data1, result);

        ww = 5'b00010; // 32-bit
        expected_result = {~data1[63:32], ~data1[31:0]};
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VNOT, WW: 32-bit, Data1: %h, Result: %h, Expected: %h [FAIL]", $time, data1, result, expected_result);
        else 
            $display("Time: %t, Opcode: VNOT, WW: 32-bit, Data1: %h, Result: %h [PASS]", $time, data1, result);

        ww = 5'b00011; // 64-bit
        expected_result = ~data1;
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VNOT, WW: 64-bit, Data1: %h, Result: %h, Expected: %h [FAIL]", $time, data1, result, expected_result);
        else 
            $display("Time: %t, Opcode: VNOT, WW: 64-bit, Data1: %h, Result: %h [PASS]", $time, data1, result);
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	     // Test MOV operation
	    opcode = 6'b000101; // VMOV
        data1 = 65'h123456789ABCDEF0;

        ww = 5'b00000; // 8-bit
        expected_result = {data1[63:56], data1[55:48], data1[47:40], data1[39:32], data1[31:24], data1[23:16], data1[15:8], data1[7:0]};
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VMOV, WW: 8-bit, Data1: %h, Result: %h, Expected: %h [FAIL]", $time, data1, result, expected_result);
        else 
            $display("Time: %t, Opcode: VMOV, WW: 8-bit, Data1: %h, Result: %h [PASS]", $time, data1, result);

        ww = 5'b00001; // 16-bit
        expected_result = {data1[63:48], data1[47:32], data1[31:16], data1[15:0]};
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VMOV, WW: 16-bit, Data1: %h, Result: %h, Expected: %h [FAIL]", $time, data1, result, expected_result);
        else 
            $display("Time: %t, Opcode: VMOV, WW: 16-bit, Data1: %h, Result: %h [PASS]", $time, data1, result);

        ww = 5'b00010; // 32-bit
        expected_result = {data1[63:32], data1[31:0]};
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VMOV, WW: 32-bit, Data1: %h, Result: %h, Expected: %h [FAIL]", $time, data1, result, expected_result);
        else 
            $display("Time: %t, Opcode: VMOV, WW: 32-bit, Data1: %h, Result: %h [PASS]", $time, data1, result);

        ww = 5'b00011; // 64-bit
        expected_result = data1;
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VMOV, WW: 64-bit, Data1: %h, Result: %h, Expected: %h [FAIL]", $time, data1, result, expected_result);
        else 
            $display("Time: %t, Opcode: VMOV, WW: 64-bit, Data1: %h, Result: %h [PASS]", $time, data1, result);
	   
	   
	   
	   
	   
	   
	   
	   
	     opcode = 6'b000110; // VADD
        data1 = 65'h123456789ABCDEF0;
        data2 = 65'h0FEDCBA987654321;

        ww = 5'b00000; // 8-bit
        expected_result = {data1[63:56] + data2[63:56], data1[55:48] + data2[55:48], data1[47:40] + data2[47:40], data1[39:32] + data2[39:32], data1[31:24] + data2[31:24], data1[23:16] + data2[23:16], data1[15:8] + data2[15:8], data1[7:0] + data2[7:0]};
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VADD, WW: 8-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else 
            $display("Time: %t, Opcode: VADD, WW: 8-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);

        ww = 5'b00001; // 16-bit
        expected_result = {data1[63:48] + data2[63:48], data1[47:32] + data2[47:32], data1[31:16] + data2[31:16], data1[15:0] + data2[15:0]};
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VADD, WW: 16-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else 
            $display("Time: %t, Opcode: VADD, WW: 16-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);

        ww = 5'b00010; // 32-bit
        expected_result = {data1[63:32] + data2[63:32], data1[31:0] + data2[31:0]};
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VADD, WW: 32-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else 
            $display("Time: %t, Opcode: VADD, WW: 32-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);

        ww = 5'b00011; // 64-bit
        expected_result = data1 + data2;
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VADD, WW: 64-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else 
            $display("Time: %t, Opcode: VADD, WW: 64-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);

       
	   
	   
	   
	   
	    opcode = 6'b000111; // VSUB
        data1 = 65'h123456789ABCDEF0;
        data2 = 65'h0FEDCBA987654321;

        ww = 5'b00000; // 8-bit
        expected_result = {data1[63:56] - data2[63:56], data1[55:48] - data2[55:48], data1[47:40] - data2[47:40], data1[39:32] - data2[39:32], data1[31:24] - data2[31:24], data1[23:16] - data2[23:16], data1[15:8] - data2[15:8], data1[7:0] - data2[7:0]};
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VSUB, WW: 8-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else 
            $display("Time: %t, Opcode: VSUB, WW: 8-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);

        ww = 5'b00001; // 16-bit
        expected_result = {data1[63:48] - data2[63:48], data1[47:32] - data2[47:32], data1[31:16] - data2[31:16], data1[15:0] - data2[15:0]};
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VSUB, WW: 16-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else 
            $display("Time: %t, Opcode: VSUB, WW: 16-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);

        ww = 5'b00010; // 32-bit
        expected_result = {data1[63:32] - data2[63:32], data1[31:0] - data2[31:0]};
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VSUB, WW: 32-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else 
            $display("Time: %t, Opcode: VSUB, WW: 32-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);

        ww = 5'b00011; // 64-bit
        expected_result = data1 - data2;
        #10;
        if (result !== expected_result) 
            $display("Time: %t, Opcode: VSUB, WW: 64-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else 
            $display("Time: %t, Opcode: VSUB, WW: 64-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);
	   
	   
	   
	//I just directly test the design ware component ------------------------------------------------------------------------------------------------------------
	
	   opcode = 6'b001110; // VDIV
        data1 = 65'h123456789ABCDEF0;
        data2 = 65'h2222222222222222; // Divisor values
			//data2 = 65'h0; 
        ww = 5'b00000; // 8-bit segments
        expected_result[63:56] =  data1[63:56] / data2[63:56];
        expected_result[55:48] = data1[55:48] / data2[55:48]; 
        expected_result[47:40] =  data1[47:40] / data2[47:40];
        expected_result[39:32] =  data1[39:32] / data2[39:32]; 
        expected_result[31:24] =  data1[31:24] / data2[31:24];
        expected_result[23:16] =  data1[23:16] / data2[23:16];
        expected_result[15:8]  =  data1[15:8] / data2[15:8];
        expected_result[7:0]   =  data1[7:0] / data2[7:0];
        #10;
        if (result[63:0] !== expected_result[63:0])
            $display("Time: %t, Opcode: VDIV, WW: 8-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else
            $display("Time: %t, Opcode: VDIV, WW: 8-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);

        ww = 5'b00001; // 16-bit segments
        expected_result[63:48] =  data1[63:48] / data2[63:48];
        expected_result[47:32] =  data1[47:32] / data2[47:32];
        expected_result[31:16] =  data1[31:16] / data2[31:16];
        expected_result[15:0]  =  data1[15:0] / data2[15:0];
        #10;
        if (result[63:0] !== expected_result[63:0])
            $display("Time: %t, Opcode: VDIV, WW: 16-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else
            $display("Time: %t, Opcode: VDIV, WW: 16-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);
	
	
	
		   ww = 5'b00010; // 32-bit segments
        expected_result[63:32] = data1[63:32] / data2[63:32];
        expected_result[31:0]  = data1[31:0] / data2[31:0];
        #10;
        if (result[63:0] !== expected_result[63:0])
            $display("Time: %t, Opcode: VDIV, WW: 32-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else;
            $display("Time: %t, Opcode: VDIV, WW: 32-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);
			
			
			
        ww = 5'b00011; // 64-bit segment
        expected_result = data1[63:0] / data2[63:0];
        #10;
        if (result[63:0] !== expected_result[63:0])
            $display("Time: %t, Opcode: VDIV, WW: 64-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else
            $display("Time: %t, Opcode: VDIV, WW: 64-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);

       
	
	
	
	
	
		  // Test VMOD operation (Modulo)
        opcode = 6'b001111; // VMOD
        data1 = 65'h123456789ABCDEF0;
        data2 = 65'h0101010101010101; // Divisor values

        ww = 5'b00000; // 8-bit segments
        expected_result[63:56] = data1[63:56] % data2[63:56];
        expected_result[55:48] = data1[55:48] % data2[55:48];
        expected_result[47:40] = data1[47:40] % data2[47:40];
        expected_result[39:32] = data1[39:32] % data2[39:32];
        expected_result[31:24] = data1[31:24] % data2[31:24];
        expected_result[23:16] = data1[23:16] % data2[23:16];
        expected_result[15:8]  = data1[15:8] % data2[15:8];
        expected_result[7:0]   = data1[7:0] % data2[7:0];
        #10;
        if (result[63:0] !== expected_result[63:0])
            $display("Time: %t, Opcode: VMOD, WW: 8-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else
            $display("Time: %t, Opcode: VMOD, WW: 8-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);

        ww = 5'b00001; // 16-bit segments
        expected_result[63:48] = data1[63:48] % data2[63:48];
        expected_result[47:32] = data1[47:32] % data2[47:32];
        expected_result[31:16] = data1[31:16] % data2[31:16];
        expected_result[15:0]  = data1[15:0] % data2[15:0];
        #10;
        if (result[63:0] !== expected_result[63:0])
            $display("Time: %t, Opcode: VMOD, WW: 16-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else
            $display("Time: %t, Opcode: VMOD, WW: 16-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);
	
		   ww = 5'b00010; // 32-bit segments
        expected_result[63:32] = data1[63:32] % data2[63:32];
        expected_result[31:0]  = data1[31:0] % data2[31:0];
        #10;
        if (result[63:0] !== expected_result[63:0])
            $display("Time: %t, Opcode: VMOD, WW: 32-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else
            $display("Time: %t, Opcode: VMOD, WW: 32-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);

        ww = 5'b00011; // 64-bit segment
        expected_result = data1[63:0] % data2[63:0];
        #10;
        if (result[63:0] !== expected_result[63:0])
            $display("Time: %t, Opcode: VMOD, WW: 64-bit, Data1: %h, Data2: %h, Result: %h, Expected: %h [FAIL]", $time, data1, data2, result, expected_result);
        else
            $display("Time: %t, Opcode: VMOD, WW: 64-bit, Data1: %h, Data2: %h, Result: %h [PASS]", $time, data1, data2, result);

	
	
	
	
	
		 // Test VSQEU operation (Square Even Segments)
        opcode = 6'b010000; // VSQEU
        data1 = 65'h123456789ABCDEF0;

        // 8-bit segments
        ww = 5'b00000;
        expected_result[15:0]  = data1[7:0] * data1[7:0];
        expected_result[31:16] = data1[23:16] * data1[23:16];
        expected_result[47:32] = data1[39:32] * data1[39:32];
        expected_result[63:48] = data1[55:48] * data1[55:48];
        #10;
        if (result[63:0] !== expected_result[63:0])
            $display("Time: %t, Opcode: VSQEU, WW: 8-bit, Data1: %h, Result: %h, Expected: %h [FAIL]", $time, data1, result, expected_result);
        else
            $display("Time: %t, Opcode: VSQEU, WW: 8-bit, Data1: %h, Result: %h [PASS]", $time, data1, result);

        // 16-bit segments
        ww = 5'b00001;
        expected_result[31:0]  = data1[15:0] * data1[15:0];
        expected_result[63:32] = data1[47:32] * data1[47:32];
        #10;
        if (result[63:0] !== expected_result[63:0])
            $display("Time: %t, Opcode: VSQEU, WW: 16-bit, Data1: %h, Result: %h, Expected: %h [FAIL]", $time, data1, result, expected_result);
        else
            $display("Time: %t, Opcode: VSQEU, WW: 16-bit, Data1: %h, Result: %h [PASS]", $time, data1, result);

	
		 // 32-bit segments
        ww = 5'b00010;
        expected_result[63:0] = data1[31:0] * data1[31:0];
        #10;
        if (result[63:0] !== expected_result[63:0])
            $display("Time: %t, Opcode: VSQEU, WW: 32-bit, Data1: %h, Result: %h, Expected: %h [FAIL]", $time, data1, result, expected_result);
        else
            $display("Time: %t, Opcode: VSQEU, WW: 32-bit, Data1: %h, Result: %h [PASS]", $time, data1, result);

      
	
		opcode = 6'b010001; // VSQOU
        data1 = 65'h123456789ABCDEF0;

        // 8-bit segments
        ww = 5'b00000;
        expected_result[15:0]  = data1[15:8] * data1[15:8];
        expected_result[31:16] = data1[31:24] * data1[31:24];
        expected_result[47:32] = data1[47:40] * data1[47:40];
        expected_result[63:48] = data1[63:56] * data1[63:56];
        #10;
        if (result[63:0] !== expected_result[63:0])
            $display("Time: %t, Opcode: VSQOU, WW: 8-bit, Data1: %h, Result: %h, Expected: %h [FAIL]", $time, data1, result, expected_result);
        else
            $display("Time: %t, Opcode: VSQOU, WW: 8-bit, Data1: %h, Result: %h [PASS]", $time, data1, result);

        // 16-bit segments
        ww = 5'b00001;
        expected_result[31:0]  = data1[31:16] * data1[31:16];
        expected_result[63:32] = data1[63:48] * data1[63:48];
        #10;
        if (result[63:0] !== expected_result[63:0])
            $display("Time: %t, Opcode: VSQOU, WW: 16-bit, Data1: %h, Result: %h, Expected: %h [FAIL]", $time, data1, result, expected_result);
        else
            $display("Time: %t, Opcode: VSQOU, WW: 16-bit, Data1: %h, Result: %h [PASS]", $time, data1, result);

        // 32-bit segments
        ww = 5'b00010;
        expected_result[63:0] = data1[63:32] * data1[63:32];
        #10;
        if (result[63:0] !== expected_result[63:0])
            $display("Time: %t, Opcode: VSQOU, WW: 32-bit, Data1: %h, Result: %h, Expected: %h [FAIL]", $time, data1, result, expected_result);
        else
            $display("Time: %t, Opcode: VSQOU, WW: 32-bit, Data1: %h, Result: %h [PASS]", $time, data1, result);
	
	
		

        // End simulation*/
    
	   
	   
	   
	   
	   
	   
	   
    end

endmodule
