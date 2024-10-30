
 module alu ( //this alu may contains SFU
      input  opcode,
      input [64:0]data1,
      input [64:0]data2,
	  input [1:0] ww,
      output reg [64:0]result,
	  output reg divide_by_0
 );


	parameter VAND   = 6'b000001; // AND
	parameter VOR    = 6'b000010; // OR
	parameter VXOR   = 6'b000011; // XOR
	parameter VNOT   = 6'b000100; // NOT
	parameter VMOV   = 6'b000101; // MOV
	parameter VADD   = 6'b000110; // ADD
	parameter VSUB   = 6'b000111; // SUB
	parameter VMULEU = 6'b001000; // MUL 
	parameter VMULOU = 6'b001001; // MUL 
	parameter VSLL   = 6'b001010; // Shift Left Logical
	parameter VSRL   = 6'b001011; // Shift Right Logical
	parameter VSRA   = 6'b001100; // Shift Right Arithmetic
	parameter VRTTTH = 6'b001101; // Rotate Three Half
	parameter VDIV   = 6'b001110; // Division
	parameter VMOD   = 6'b001111; // Modulus
	parameter VSQEU  = 6'b010000; // Square 
	parameter VSQOU  = 6'b010001; // Square
	parameter VSQRT  = 6'b010010; // Square Root
	parameter VLD    = 6'b010011; // Load
	parameter VSD    = 6'b010100; // Store
	parameter VBEZ   = 6'b010101; // Branch if Equal to Zero
	parameter VBNEZ  = 6'b010110; // Branch if Not Equal to Zero
	parameter VNOP   = 6'b010111; // No Operation
	
//----------------------------------------------------------------------------------- Division Define
	 // Intermediate signals for each segment
    wire [7:0] quotient_8bit_0, quotient_8bit_1, quotient_8bit_2, quotient_8bit_3, quotient_8bit_4, quotient_8bit_5, quotient_8bit_6, quotient_8bit_7;
    wire [15:0] quotient_16bit_0, quotient_16bit_1, quotient_16bit_2, quotient_16bit_3;
    wire [31:0] quotient_32bit_0, quotient_32bit_1;
    wire [63:0] quotient_64bit;
	
	
	
	   // Intermediate signals for each segment's remainder and divide_by_0
    wire [7:0] remainder_8bit_0, remainder_8bit_1, remainder_8bit_2, remainder_8bit_3, remainder_8bit_4, remainder_8bit_5, remainder_8bit_6, remainder_8bit_7;
    wire [15:0] remainder_16bit_0, remainder_16bit_1, remainder_16bit_2, remainder_16bit_3;
    wire [31:0] remainder_32bit_0, remainder_32bit_1;
    wire [63:0] remainder_64bit;
	
	
	
	
    wire div_by_0_8bit_0, div_by_0_8bit_1, div_by_0_8bit_2, div_by_0_8bit_3,div_by_0_8bit_4, div_by_0_8bit_5, div_by_0_8bit_6, div_by_0_8bit_7;
    wire div_by_0_16bit_0, div_by_0_16bit_1, div_by_0_16bit_2, div_by_0_16bit_3;
    wire div_by_0_32bit_0, div_by_0_32bit_1;
    wire div_by_0_64bit;
	
	
	
	
	
	
    // 8-bit division instances for each 8-bit segment
    DW_div #(.a_width(8), .b_width(8), .tc_mode(0), .rem_mode(1)) div_8bit_0 (
        .a(data1[7:0]), .b(data2[7:0]), .quotient(quotient_8bit_0), .remainder(remainder_8bit_0), .divide_by_0(div_by_0_8bit_0)
    );
    DW_div #(.a_width(8), .b_width(8), .tc_mode(0), .rem_mode(1)) div_8bit_1 (
        .a(data1[15:8]), .b(data2[15:8]), .quotient(quotient_8bit_1), .remainder(remainder_8bit_1), .divide_by_0(div_by_0_8bit_1)
    );
    DW_div #(.a_width(8), .b_width(8), .tc_mode(0), .rem_mode(1)) div_8bit_2 (
        .a(data1[23:16]), .b(data2[23:16]), .quotient(quotient_8bit_2), .remainder(remainder_8bit_2), .divide_by_0(div_by_0_8bit_2)
    );
    DW_div #(.a_width(8), .b_width(8), .tc_mode(0), .rem_mode(1)) div_8bit_3 (
        .a(data1[31:24]), .b(data2[31:24]), .quotient(quotient_8bit_3), .remainder(remainder_8bit_3), .divide_by_0(div_by_0_8bit_3)
    );
    DW_div #(.a_width(8), .b_width(8), .tc_mode(0), .rem_mode(1)) div_8bit_4 (
        .a(data1[39:32]), .b(data2[39:32]), .quotient(quotient_8bit_4), .remainder(remainder_8bit_4), .divide_by_0(div_by_0_8bit_4)
    );
    DW_div #(.a_width(8), .b_width(8), .tc_mode(0), .rem_mode(1)) div_8bit_5 (
        .a(data1[47:40]), .b(data2[47:40]), .quotient(quotient_8bit_5), .remainder(remainder_8bit_5), .divide_by_0(div_by_0_8bit_5)
    );
    DW_div #(.a_width(8), .b_width(8), .tc_mode(0), .rem_mode(1)) div_8bit_6 (
        .a(data1[55:48]), .b(data2[55:48]), .quotient(quotient_8bit_6), .remainder(remainder_8bit_6), .divide_by_0(div_by_0_8bit_6)
    );
    DW_div #(.a_width(8), .b_width(8), .tc_mode(0), .rem_mode(1)) div_8bit_7 (
        .a(data1[63:56]), .b(data2[63:56]), .quotient(quotient_8bit_7), .remainder(remainder_8bit_7), .divide_by_0(div_by_0_8bit_7)
    );

    // 16-bit division instances for each 16-bit segment
    DW_div #(.a_width(16), .b_width(16), .tc_mode(0), .rem_mode(1)) div_16bit_0 (
        .a(data1[15:0]), .b(data2[15:0]), .quotient(quotient_16bit_0), .remainder(remainder_16bit_0), .divide_by_0(div_by_0_16bit_0)
    );
    DW_div #(.a_width(16), .b_width(16), .tc_mode(0), .rem_mode(1)) div_16bit_1 (
        .a(data1[31:16]), .b(data2[31:16]), .quotient(quotient_16bit_1), .remainder(remainder_16bit_1), .divide_by_0(div_by_0_16bit_1)
    );
    DW_div #(.a_width(16), .b_width(16), .tc_mode(0), .rem_mode(1)) div_16bit_2 (
        .a(data1[47:32]), .b(data2[47:32]), .quotient(quotient_16bit_2), .remainder(remainder_16bit_2), .divide_by_0(div_by_0_16bit_2)
    );
    DW_div #(.a_width(16), .b_width(16), .tc_mode(0), .rem_mode(1)) div_16bit_3 (
        .a(data1[63:48]), .b(data2[63:48]), .quotient(quotient_16bit_3), .remainder(remainder_16bit_3), .divide_by_0(div_by_0_16bit_3)
    );

    // 32-bit division instances for each 32-bit segment
    DW_div #(.a_width(32), .b_width(32), .tc_mode(0), .rem_mode(1)) div_32bit_0 (
        .a(data1[31:0]), .b(data2[31:0]), .quotient(quotient_32bit_0), .remainder(remainder_32bit_0), .divide_by_0(div_by_0_32bit_0)
    );
    DW_div #(.a_width(32), .b_width(32), .tc_mode(0), .rem_mode(1)) div_32bit_1 (
        .a(data1[63:32]), .b(data2[63:32]), .quotient(quotient_32bit_1), .remainder(remainder_32bit_1), .divide_by_0(div_by_0_32bit_1)
    );

    // 64-bit division instance
    DW_div #(.a_width(64), .b_width(64), .tc_mode(0), .rem_mode(1)) div_64bit (
        .a(data1[63:0]), .b(data2[63:0]), .quotient(quotient_64bit), .remainder(remainder_64bit), .divide_by_0(div_by_0_64bit)
    );
	
	
//-----------------------------------------------------------------------------------	

// sqaure design ware 
   // Intermediate signals for each segment's square result
    wire [15:0] square_8bit_0, square_8bit_2, square_8bit_4, square_8bit_6;
    wire [31:0] square_16bit_0, square_16bit_2;
    wire [63:0] square_32bit_0;

    // 8-bit square instances for each even 8-bit segment
    DW_square #(.width(8)) square_8bit_0_u (
        .a(data1[7:0]), .tc(0), .square(square_8bit_0)
    );
    DW_square #(.width(8)) square_8bit_2_u (
        .a(data1[23:16]), .tc(0), .square(square_8bit_2)
    );
    DW_square #(.width(8)) square_8bit_4_u (
        .a(data1[39:32]), .tc(0), .square(square_8bit_4)
    );
    DW_square #(.width(8)) square_8bit_6_u (
        .a(data1[55:48]), .tc(0), .square(square_8bit_6)
    );

    // 16-bit square instances for each even 16-bit segment
    DW_square #(.width(16)) square_16bit_0_u (
        .a(data1[15:0]), .tc(0), .square(square_16bit_0)
    );
    DW_square #(.width(16)) square_16bit_2_u (
        .a(data1[47:32]), .tc(0), .square(square_16bit_2)
    );

    // 32-bit square instance for the even 32-bit segment
    DW_square #(.width(32)) square_32bit_0_u (
        .a(data1[31:0]), .tc(0), .square(square_32bit_0)
    );
	
	
	
	
	

	
	 // 8-bit square instances for each odd 8-bit segment
	 
	wire [15:0] square_8bit_1, square_8bit_3, square_8bit_5, square_8bit_7;
    wire [31:0] square_16bit_1, square_16bit_3;
    wire [63:0] square_32bit_1;
	
	
	
    DW_square #(.width(8)) square_8bit_1_u (
        .a(data1[15:8]), .tc(0), .square(square_8bit_1)
    );
    DW_square #(.width(8)) square_8bit_3_u (
        .a(data1[31:24]), .tc(0), .square(square_8bit_3)
    );
    DW_square #(.width(8)) square_8bit_5_u (
        .a(data1[47:40]), .tc(0), .square(square_8bit_5)
    );
    DW_square #(.width(8)) square_8bit_7_u (
        .a(data1[63:56]), .tc(0), .square(square_8bit_7)
    );

    // 16-bit square instances for each odd 16-bit segment
    DW_square #(.width(16)) square_16bit_1_u (
        .a(data1[31:16]), .tc(0), .square(square_16bit_1)
    );
    DW_square #(.width(16)) square_16bit_3_u (
        .a(data1[63:48]), .tc(0), .square(square_16bit_3)
    );

    // 32-bit square instance for the odd 32-bit segment
    DW_square #(.width(32)) square_32bit_1_u (
        .a(data1[63:32]), .tc(0), .square(square_32bit_1)
    );
	
//--------------------------------------------------------------------------------------

// sqaure root design ware
	wire [3:0] root_8bit_0, root_8bit_1, root_8bit_2, root_8bit_3,root_8bit_4, root_8bit_5, root_8bit_6, root_8bit_7;
    wire [7:0] root_16bit_0, root_16bit_1, root_16bit_2, root_16bit_3;
    wire [15:0] root_32bit_0, root_32bit_1;
    wire [31:0] root_64bit;

    // 8-bit square root instances for each 8-bit segment
    DW_sqrt #(.width(8)) sqrt_8bit_0 (
        .a(data1[7:0]), .root(root_8bit_0)
    );
    DW_sqrt #(.width(8)) sqrt_8bit_1 (
        .a(data1[15:8]), .root(root_8bit_1)
    );
    DW_sqrt #(.width(8)) sqrt_8bit_2 (
        .a(data1[23:16]), .root(root_8bit_2)
    );
    DW_sqrt #(.width(8)) sqrt_8bit_3 (
        .a(data1[31:24]), .root(root_8bit_3)
    );
    DW_sqrt #(.width(8)) sqrt_8bit_4 (
        .a(data1[39:32]), .root(root_8bit_4)
    );
    DW_sqrt #(.width(8)) sqrt_8bit_5 (
        .a(data1[47:40]), .root(root_8bit_5)
    );
    DW_sqrt #(.width(8)) sqrt_8bit_6 (
        .a(data1[55:48]), .root(root_8bit_6)
    );
    DW_sqrt #(.width(8)) sqrt_8bit_7 (
        .a(data1[63:56]), .root(root_8bit_7)
    );

    // 16-bit square root instances for each 16-bit segment
    DW_sqrt #(.width(16)) sqrt_16bit_0 (
        .a(data1[15:0]), .root(root_16bit_0)
    );
    DW_sqrt #(.width(16)) sqrt_16bit_1 (
        .a(data1[31:16]), .root(root_16bit_1)
    );
    DW_sqrt #(.width(16)) sqrt_16bit_2 (
        .a(data1[47:32]), .root(root_16bit_2)
    );
    DW_sqrt #(.width(16)) sqrt_16bit_3 (
        .a(data1[63:48]), .root(root_16bit_3)
    );

    // 32-bit square root instances for each 32-bit segment
    DW_sqrt #(.width(32)) sqrt_32bit_0 (
        .a(data1[31:0]), .root(root_32bit_0)
    );
    DW_sqrt #(.width(32)) sqrt_32bit_1 (
        .a(data1[63:32]), .root(root_32bit_1)
    );

    // 64-bit square root instance
    DW_sqrt #(.width(64)) sqrt_64bit (
        .a(data1[63:0]), .root(root_64bit)
    );	
//------------------------------------------------------------------------------------	
	always @(*) 
	begin
        result = 65'b0; // Default result to 0
		
		 if (opcode == VAND) begin
            case (ww)
                2'b00: 
				begin // 8-bit AND, each segment is 8 bits
                    result[7:0]    = data1[7:0] & data2[7:0];
                    result[15:8]   = data1[15:8] & data2[15:8];
                    result[23:16]  = data1[23:16] & data2[23:16];
                    result[31:24]  = data1[31:24] & data2[31:24];
                    result[39:32]  = data1[39:32] & data2[39:32];
                    result[47:40]  = data1[47:40] & data2[47:40];
                    result[55:48]  = data1[55:48] & data2[55:48];
                    result[63:56]  = data1[63:56] & data2[63:56];
                end
                2'b01: 
				begin // 16-bit AND, each segment is 16 bits
                    result[15:0]   = data1[15:0] & data2[15:0];
                    result[31:16]  = data1[31:16] & data2[31:16];
                    result[47:32]  = data1[47:32] & data2[47:32];
                    result[63:48]  = data1[63:48] & data2[63:48];
                end
                2'b10: 
				begin // 32-bit AND, each segment is 32 bits
                    result[31:0]   = data1[31:0] & data2[31:0];
                    result[63:32]  = data1[63:32] & data2[63:32];
                end
                2'b11: 
				begin // 64-bit AND, entire 64-bit word
                    result = data1 & data2;
                end
                default: result = 64'b0; // Handle invalid ww values
            endcase
		end
		
		 else if (opcode == VOR) 
		 begin
            case (ww)
                2'b00: begin // 8-bit OR, each segment is 8 bits
                    result[7:0]    = data1[7:0] | data2[7:0];
                    result[15:8]   = data1[15:8] | data2[15:8];
                    result[23:16]  = data1[23:16] | data2[23:16];
                    result[31:24]  = data1[31:24] | data2[31:24];
                    result[39:32]  = data1[39:32] | data2[39:32];
                    result[47:40]  = data1[47:40] | data2[47:40];
                    result[55:48]  = data1[55:48] | data2[55:48];
                    result[63:56]  = data1[63:56] | data2[63:56];
                end
                2'b01: begin // 16-bit OR, each segment is 16 bits
                    result[15:0]   = data1[15:0] | data2[15:0];
                    result[31:16]  = data1[31:16] | data2[31:16];
                    result[47:32]  = data1[47:32] | data2[47:32];
                    result[63:48]  = data1[63:48] | data2[63:48];
                end
                2'b10: begin // 32-bit OR, each segment is 32 bits
                    result[31:0]   = data1[31:0] | data2[31:0];
                    result[63:32]  = data1[63:32] | data2[63:32];
                end
                2'b11: begin // 64-bit OR, entire 64-bit word
                    result = data1 | data2;
                end
                default: result = 64'b0; // Handle invalid ww values
            endcase
		end
		
		 else if (opcode == VXOR) 
		 begin
            case (ww)
                2'b00: 
				begin // 8-bit XOR, each segment is 8 bits
                    result[7:0]    = data1[7:0] ^ data2[7:0];
                    result[15:8]   = data1[15:8] ^ data2[15:8];
                    result[23:16]  = data1[23:16] ^ data2[23:16];
                    result[31:24]  = data1[31:24] ^ data2[31:24];
                    result[39:32]  = data1[39:32] ^ data2[39:32];
                    result[47:40]  = data1[47:40] ^ data2[47:40];
                    result[55:48]  = data1[55:48] ^ data2[55:48];
                    result[63:56]  = data1[63:56] ^ data2[63:56];
                end
                2'b01: 
				begin // 16-bit XOR, each segment is 16 bits
                    result[15:0]   = data1[15:0] ^ data2[15:0];
                    result[31:16]  = data1[31:16] ^ data2[31:16];
                    result[47:32]  = data1[47:32] ^ data2[47:32];
                    result[63:48]  = data1[63:48] ^ data2[63:48];
                end
                2'b10:
				begin // 32-bit XOR, each segment is 32 bits
                    result[31:0]   = data1[31:0] ^ data2[31:0];
                    result[63:32]  = data1[63:32] ^ data2[63:32];
                end
                2'b11: 
				begin // 64-bit XOR, entire 64-bit word
                    result = data1 ^ data2;
                end
                default: result = 64'b0; // Handle invalid ww values
            endcase
		end
		
		else if (opcode == VNOT) 
		begin
            case (ww)
                2'b00: 
				begin // 8-bit NOT, each segment is 8 bits
                    result[7:0]    = ~data1[7:0];
                    result[15:8]   = ~data1[15:8];
                    result[23:16]  = ~data1[23:16];
                    result[31:24]  = ~data1[31:24];
                    result[39:32]  = ~data1[39:32];
                    result[47:40]  = ~data1[47:40];
                    result[55:48]  = ~data1[55:48];
                    result[63:56]  = ~data1[63:56];
                end
                2'b01: 
				begin // 16-bit NOT, each segment is 16 bits
                    result[15:0]   = ~data1[15:0];
                    result[31:16]  = ~data1[31:16];
                    result[47:32]  = ~data1[47:32];
                    result[63:48]  = ~data1[63:48];
                end
                2'b10: 
				begin // 32-bit NOT, each segment is 32 bits
                    result[31:0]   = ~data1[31:0];
                    result[63:32]  = ~data1[63:32];
                end
                2'b11: 
				begin // 64-bit NOT, entire 64-bit word
                    result = ~data1;
                end
                default: result = 64'b0; // Handle invalid ww values
            endcase
		
		end
		else if (opcode == VMOV) 
		begin
            case (ww)
                2'b00: 
				begin // 8-bit MOVE, each segment is 8 bits
                    result[7:0]    = data1[7:0];
                    result[15:8]   = data1[15:8];
                    result[23:16]  = data1[23:16];
                    result[31:24]  = data1[31:24];
                    result[39:32]  = data1[39:32];
                    result[47:40]  = data1[47:40];
                    result[55:48]  = data1[55:48];
                    result[63:56]  = data1[63:56];
                end
                2'b01: 
				begin // 16-bit MOVE, each segment is 16 bits
                    result[15:0]   = data1[15:0];
                    result[31:16]  = data1[31:16];
                    result[47:32]  = data1[47:32];
                    result[63:48]  = data1[63:48];
                end
                2'b10: 
				begin // 32-bit MOVE, each segment is 32 bits
                    result[31:0]   = data1[31:0];
                    result[63:32]  = data1[63:32];
                end
                2'b11: 
				begin // 64-bit MOVE, entire 64-bit word
                    result = data1;
                end
                default: result = 64'b0; // Handle invalid ww values
            endcase
		end
		
        else if (opcode == VADD) 
		begin
            case (ww)
                2'b00: 
				begin // 8-bit addition
                    result[7:0]    = data1[7:0] + data2[7:0];
                    result[15:8]   = data1[15:8] + data2[15:8];
                    result[23:16]  = data1[23:16] + data2[23:16];
                    result[31:24]  = data1[31:24] + data2[31:24];
                    result[39:32]  = data1[39:32] + data2[39:32];
                    result[47:40]  = data1[47:40] + data2[47:40];
                    result[55:48]  = data1[55:48] + data2[55:48];
                    result[63:56]  = data1[63:56] + data2[63:56];
                end
                2'b01: 
				begin // 16-bit addition
                    result[15:0]   = data1[15:0] + data2[15:0];
                    result[31:16]  = data1[31:16] + data2[31:16];
                    result[47:32]  = data1[47:32] + data2[47:32];
                    result[63:48]  = data1[63:48] + data2[63:48];
                end
                2'b10: 
				begin // 32-bit addition
                    result[31:0]   = data1[31:0] + data2[31:0];
                    result[63:32]  = data1[63:32] + data2[63:32];
                end
                2'b11: 
				begin // 64-bit addition
                    result[63:0]   = data1[63:0] + data2[63:0];
                end
                default: result = 65'b0; // Default case to avoid latches
            endcase
        end
		
		else if (opcode == VSUB) 
		begin
            case (ww)
                2'b00: 
				begin // 8-bit subtraction
                    result[7:0]    = data1[7:0] - data2[7:0];
                    result[15:8]   = data1[15:8] - data2[15:8];
                    result[23:16]  = data1[23:16] - data2[23:16];
                    result[31:24]  = data1[31:24] - data2[31:24];
                    result[39:32]  = data1[39:32] - data2[39:32];
                    result[47:40]  = data1[47:40] - data2[47:40];
                    result[55:48]  = data1[55:48] - data2[55:48];
                    result[63:56]  = data1[63:56] - data2[63:56];
                end
                2'b01: 
				begin // 16-bit subtraction
                    result[15:0]   = data1[15:0] - data2[15:0];
                    result[31:16]  = data1[31:16] - data2[31:16];
                    result[47:32]  = data1[47:32] - data2[47:32];
                    result[63:48]  = data1[63:48] - data2[63:48];
                end
                2'b10: 
				begin // 32-bit subtraction
                    result[31:0]   = data1[31:0] - data2[31:0];
                    result[63:32]  = data1[63:32] - data2[63:32];
                end
                2'b11: 
				begin // 64-bit subtraction
                    result[63:0]   = data1[63:0] - data2[63:0];
                end
                default: result = 65'b0; // Default case to avoid latches
            endcase
	
        end
		 else if (opcode == VMULEU) 
		 begin
            case (ww)
                2'b00: 
				begin // 8-bit segments, result is 16-bit per segment
                    result[15:0]   = data1[7:0] * data2[7:0];
                    result[31:16]  = data1[23:16] * data2[23:16];
                    result[47:32]  = data1[39:32] * data2[39:32];
                    result[63:48]  = data1[55:48] * data2[55:48];
                end
                2'b01: 
				begin // 16-bit segments, result is 32-bit per segment
                    result[31:0]   = data1[15:0] * data2[15:0];
                    result[63:32]  = data1[47:32] * data2[47:32];
                end
                2'b10: 
				begin // 32-bit segments, result is 64-bit
                    result[63:0]   = data1[31:0] * data2[31:0];
                end
                default: result = 64'b0; // Default case to avoid latches
            endcase
        end
		
		 else if (opcode == VMULOU) 
		 begin
            case (ww)
                2'b00: 
				begin // 8位段，每段结果为16位
                    result[15:0]   = data1[15:8] * data2[15:8];
                    result[31:16]  = data1[31:24] * data2[31:24];
                    result[47:32]  = data1[47:40] * data2[47:40];
                    result[63:48]  = data1[63:56] * data2[63:56];
                end
                2'b01: 
				begin // 16位段，每段结果为32位
                    result[31:0]   = data1[31:16] * data2[31:16];
                    result[63:32]  = data1[63:48] * data2[63:48];
                end
                2'b10: 
				begin // 32位段，结果为64位
                    result[63:0]   = data1[63:32] * data2[63:32];
                end
                default: result = 64'b0; // 默认情况，避免产生锁存器
            endcase
        end
		else if (opcode == VSLL) 
		begin
            case (ww)
                2'b00: 
				begin // 8-bit shift, shift amount is 3 bits
                    result[7:0]   = data1[7:0]   << data2[2:0];
                    result[15:8]  = data1[15:8]  << data2[10:8];
                    result[23:16] = data1[23:16] << data2[18:16];
                    result[31:24] = data1[31:24] << data2[26:24];
                    result[39:32] = data1[39:32] << data2[34:32];
                    result[47:40] = data1[47:40] << data2[42:40];
                    result[55:48] = data1[55:48] << data2[50:48];
                    result[63:56] = data1[63:56] << data2[58:56];
                end
                2'b01: 
				begin // 16-bit shift, shift amount is 4 bits
                    result[15:0]  = data1[15:0]  << data2[3:0];
                    result[31:16] = data1[31:16] << data2[19:16];
                    result[47:32] = data1[47:32] << data2[35:32];
                    result[63:48] = data1[63:48] << data2[51:48];
                end
                2'b10: 
				begin // 32-bit shift, shift amount is 5 bits
                    result[31:0]  = data1[31:0]  << data2[4:0];
                    result[63:32] = data1[63:32] << data2[36:32];
                end
                2'b11: 
				begin // 64-bit shift, shift amount is 6 bits
                    result[63:0]  = data1[63:0]  << data2[5:0];
                end
                default: result = 64'b0; // Default case to avoid latches
            endcase
        end
		else if (opcode == VSRL) 
		begin
            case (ww)
                2'b00: 
				begin // 8-bit shift, shift amount is 3 bits
                    result[7:0]   = data1[7:0]   >> data2[2:0];
                    result[15:8]  = data1[15:8]  >> data2[10:8];
                    result[23:16] = data1[23:16] >> data2[18:16];
                    result[31:24] = data1[31:24] >> data2[26:24];
                    result[39:32] = data1[39:32] >> data2[34:32];
                    result[47:40] = data1[47:40] >> data2[42:40];
                    result[55:48] = data1[55:48] >> data2[50:48];
                    result[63:56] = data1[63:56] >> data2[58:56];
                end
                2'b01: 
				begin // 16-bit shift, shift amount is 4 bits
                    result[15:0]  = data1[15:0]  >> data2[3:0];
                    result[31:16] = data1[31:16] >> data2[19:16];
                    result[47:32] = data1[47:32] >> data2[35:32];
                    result[63:48] = data1[63:48] >> data2[51:48];
                end
                2'b10: 
				begin // 32-bit shift, shift amount is 5 bits
                    result[31:0]  = data1[31:0]  >> data2[4:0];
                    result[63:32] = data1[63:32] >> data2[36:32];
                end
                2'b11: 
				begin // 64-bit shift, shift amount is 6 bits
                    result[63:0]  = data1[63:0]  >> data2[5:0];
                end
                default: result = 64'b0; // Default case to avoid latches
            endcase
        end
		
		 else if (opcode == VSRA) 
		 begin
            case (ww)
                2'b00: 
				begin // 8-bit shift, shift amount is 3 bits
                    result[7:0]   = { {3{data1[7]}}, data1[7:3] >> data2[2:0] };
                    result[15:8]  = { {3{data1[15]}}, data1[15:8] >> data2[10:8] };
                    result[23:16] = { {3{data1[23]}}, data1[23:16] >> data2[18:16] };
                    result[31:24] = { {3{data1[31]}}, data1[31:24] >> data2[26:24] };
                    result[39:32] = { {3{data1[39]}}, data1[39:32] >> data2[34:32] };
                    result[47:40] = { {3{data1[47]}}, data1[47:40] >> data2[42:40] };
                    result[55:48] = { {3{data1[55]}}, data1[55:48] >> data2[50:48] };
                    result[63:56] = { {3{data1[63]}}, data1[63:56] >> data2[58:56] };
                end
                2'b01: 
				begin // 16-bit shift, shift amount is 4 bits
                    result[15:0]  = { {4{data1[15]}}, data1[15:4] >> data2[3:0] };
                    result[31:16] = { {4{data1[31]}}, data1[31:16] >> data2[19:16] };
                    result[47:32] = { {4{data1[47]}}, data1[47:32] >> data2[35:32] };
                    result[63:48] = { {4{data1[63]}}, data1[63:48] >> data2[51:48] };
                end
                2'b10: 
				begin // 32-bit shift, shift amount is 5 bits
                    result[31:0]  = { {5{data1[31]}}, data1[31:5] >> data2[4:0] };
                    result[63:32] = { {5{data1[63]}}, data1[63:32] >> data2[36:32] };
                end
                2'b11: 
				begin // 64-bit shift, shift amount is 6 bits
                    result[63:0]  = { {6{data1[63]}}, data1[63:6] >> data2[5:0] };
                end
                default: result = 64'b0; // Default case to avoid latches
            endcase
        end
		
		else if (opcode == VRTTTH) 
		begin
            case (ww)
                2'b00: 
				begin // 8-bit segments, swap nibbles
                    result[7:0]   = {data1[3:0], data1[7:4]};
                    result[15:8]  = {data1[11:8], data1[15:12]};
                    result[23:16] = {data1[19:16], data1[23:20]};
                    result[31:24] = {data1[27:24], data1[31:28]};
                    result[39:32] = {data1[35:32], data1[39:36]};
                    result[47:40] = {data1[43:40], data1[47:44]};
                    result[55:48] = {data1[51:48], data1[55:52]};
                    result[63:56] = {data1[59:56], data1[63:60]};
                end
                2'b01: 
				begin // 16-bit segments, swap bytes
                    result[15:0]  = {data1[7:0], data1[15:8]};
                    result[31:16] = {data1[23:16], data1[31:24]};
                    result[47:32] = {data1[39:32], data1[47:40]};
                    result[63:48] = {data1[55:48], data1[63:56]};
                end
                2'b10: 
				begin // 32-bit segments, swap half-words
                    result[31:0]  = {data1[15:0], data1[31:16]};
                    result[63:32] = {data1[47:32], data1[63:48]};
                end
                2'b11: 
				begin // 64-bit segment, swap words
                    result[63:0]  = {data1[31:0], data1[63:32]};
                end
                default: result = 64'b0; // Default case to avoid latches
            endcase
        end
		
		else if (opcode == VDIV) 
		begin
            case (ww)
                2'b00: 
				begin // 8-bit division, segment each 8-bit field
                    result[7:0]    = quotient_8bit_0;
                    result[15:8]   = quotient_8bit_1;
                    result[23:16]  = quotient_8bit_2;
                    result[31:24]  = quotient_8bit_3;
                    result[39:32]  = quotient_8bit_4;
                    result[47:40]  = quotient_8bit_5;
                    result[55:48]  = quotient_8bit_6;
                    result[63:56]  = quotient_8bit_7;
                    divide_by_0 = div_by_0_8bit_0 | div_by_0_8bit_1 | div_by_0_8bit_2 | div_by_0_8bit_3 | div_by_0_8bit_4 | div_by_0_8bit_5 | div_by_0_8bit_6 | div_by_0_8bit_7;
                end
                2'b01: 
				begin // 16-bit division, segment each 16-bit field
                    result[15:0]   = quotient_16bit_0;
                    result[31:16]  = quotient_16bit_1;
                    result[47:32]  = quotient_16bit_2;
                    result[63:48]  = quotient_16bit_3;
                    divide_by_0 = div_by_0_16bit_0 | div_by_0_16bit_1 | div_by_0_16bit_2 | div_by_0_16bit_3;
                end
                2'b10: 
				begin // 32-bit division, segment each 32-bit field
                    result[31:0]   = quotient_32bit_0;
                    result[63:32]  = quotient_32bit_1;
                    divide_by_0 = div_by_0_32bit_0 | div_by_0_32bit_1;
                end
                2'b11: 
				begin // 64-bit division, entire 64-bit field
                    result = quotient_64bit;
                    divide_by_0 = div_by_0_64bit;
                end
                default: 
				begin
                    result = 64'b0;
                    divide_by_0 = 1'b0;
                end
            endcase
		end
		else if (opcode == VMOD) 
		begin
            case (ww)
                2'b00: 
				begin // 8-bit division, segment each 8-bit field
                    result[7:0]    = remainder_8bit_0;
                    result[15:8]   = remainder_8bit_1;
                    result[23:16]  = remainder_8bit_2;
                    result[31:24]  = remainder_8bit_3;
                    result[39:32]  = remainder_8bit_4;
                    result[47:40]  = remainder_8bit_5;
                    result[55:48]  = remainder_8bit_6;
                    result[63:56]  = remainder_8bit_7;
                    divide_by_0 = div_by_0_8bit_0 | div_by_0_8bit_1 | div_by_0_8bit_2 | div_by_0_8bit_3 | div_by_0_8bit_4 | div_by_0_8bit_5 | div_by_0_8bit_6 | div_by_0_8bit_7;
                end
                2'b01: 
				begin // 16-bit division, segment each 16-bit field
                    result[15:0]   = remainder_16bit_0;
                    result[31:16]  = remainder_16bit_1;
                    result[47:32]  = remainder_16bit_2;
                    result[63:48]  = remainder_16bit_3;
                    divide_by_0 = div_by_0_16bit_0 | div_by_0_16bit_1 | div_by_0_16bit_2 | div_by_0_16bit_3;
                end
                2'b10: 
				begin // 32-bit division, segment each 32-bit field
                    result[31:0]   = quotient_32bit_0;
                    result[63:32]  = quotient_32bit_1;
                    divide_by_0 = div_by_0_32bit_0 | div_by_0_32bit_1;
                end
                2'b11: 
				begin // 64-bit division, entire 64-bit field
                    result = quotient_64bit;
                    divide_by_0 = div_by_0_64bit;
                end
                default: 
				begin
                    result = 64'b0;
                    divide_by_0 = 1'b0;
                end					
            endcase

        end
		
		else if (opcode == VSQEU) 
		begin
            case (ww)
                2'b00: 
				begin // 8-bit square, for each even 8-bit segment
                    result[15:0]   = square_8bit_0;
                    result[31:16]  = square_8bit_2;
                    result[47:32]  = square_8bit_4;
                    result[63:48]  = square_8bit_6;
                end
                2'b01: 
				begin // 16-bit square, for each even 16-bit segment
                    result[31:0]   = square_16bit_0;
                    result[63:32]  = square_16bit_2;
                end
                2'b10: 
				begin // 32-bit square, only one 32-bit segment
                    result = square_32bit_0;
                end
                default: result = 64'b0; // Handle invalid ww values
           endcase   
        end
		
		else if (opcode == VSQOU) 
		begin
            case (ww)
                2'b00: 
				begin // 8-bit square, for each odd 8-bit segment
                    result[15:0]   = square_8bit_1;
                    result[31:16]  = square_8bit_3;
                    result[47:32]  = square_8bit_5;
                    result[63:48]  = square_8bit_7;
                end
                2'b01: 
				begin // 16-bit square, for each odd 16-bit segment
                    result[31:0]   = square_16bit_1;
                    result[63:32]  = square_16bit_3;
                end
                2'b10: 
				begin // 32-bit square, only one 32-bit odd segment
                    result = square_32bit_1;
                end
                default: result = 64'b0; // Handle invalid ww values
            endcase
        end 
		
		
		else  if (opcode == VSQRT) 
		 begin
            case (ww)
                2'b00: 
				begin // 8-bit square root, segment each 8-bit field
                    result[3:0]    = root_8bit_0;
                    result[7:4]    = root_8bit_1;
                    result[11:8]   = root_8bit_2;
                    result[15:12]  = root_8bit_3;
                    result[19:16]  = root_8bit_4;
                    result[23:20]  = root_8bit_5;
                    result[27:24]  = root_8bit_6;
                    result[31:28]  = root_8bit_7;
                end
                2'b01: 
				begin // 16-bit square root, segment each 16-bit field
                    result[7:0]   = root_16bit_0;
                    result[15:8]  = root_16bit_1;
                    result[23:16] = root_16bit_2;
                    result[31:24] = root_16bit_3;
                end
                2'b10:
				begin // 32-bit square root, segment each 32-bit field
                    result[15:0]  = root_32bit_0;
                    result[31:16] = root_32bit_1;
                end
                2'b11: 
				begin // 64-bit square root, entire 64-bit field
                    result = root_64bit;
                end
                default: result = 64'b0; // Handle invalid ww values
            endcase		
		end
		
		
		
		
		
		
		
    end


	



endmodule 