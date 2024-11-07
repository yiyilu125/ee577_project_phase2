
 module alu ( //this alu may contains SFU
      input  [5:0]opcode,
      input [0:63]data1,
      input [0:63]data2,
	  output reg [0:63]result,
	  input [1:0] ww
     
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
	
	
	
	
	
   
	
	
	
	
	
	
	
	


	
	
	
	
	
	
	
	
	
	reg divide_by_0;
	
//----------------------------------------------------------------------------------- Division Define
	 // Intermediate signals for each segment
    wire [0:7] quotient_8bit_0, quotient_8bit_1, quotient_8bit_2, quotient_8bit_3, quotient_8bit_4, quotient_8bit_5, quotient_8bit_6, quotient_8bit_7;
    wire [0:15] quotient_16bit_0, quotient_16bit_1, quotient_16bit_2, quotient_16bit_3;
    wire [0:31] quotient_32bit_0, quotient_32bit_1;
    wire [0:63] quotient_64bit;
	
	
	   // Intermediate signals for each segment's remainder and divide_by_0
    wire [0:7] remainder_8bit_0, remainder_8bit_1, remainder_8bit_2, remainder_8bit_3, remainder_8bit_4, remainder_8bit_5, remainder_8bit_6, remainder_8bit_7;
    wire [0:15] remainder_16bit_0, remainder_16bit_1, remainder_16bit_2, remainder_16bit_3;
    wire [0:31] remainder_32bit_0, remainder_32bit_1;
    wire [0:63] remainder_64bit;
	
	
	
	
    wire div_by_0_8bit_0, div_by_0_8bit_1, div_by_0_8bit_2, div_by_0_8bit_3,div_by_0_8bit_4, div_by_0_8bit_5, div_by_0_8bit_6, div_by_0_8bit_7;
    wire div_by_0_16bit_0, div_by_0_16bit_1, div_by_0_16bit_2, div_by_0_16bit_3;
    wire div_by_0_32bit_0, div_by_0_32bit_1;
    wire div_by_0_64bit;
	
	
	
	
	
	
    // 8-bit division instances for each 8-bit segment
    DW_div #(.a_width(8), .b_width(8), .tc_mode(0), .rem_mode(1)) div_8bit_0 (
        .a(data1[0:7]), .b(data2[0:7]), .quotient(quotient_8bit_0), .remainder(remainder_8bit_0), .divide_by_0(div_by_0_8bit_0)
    );
    DW_div #(.a_width(8), .b_width(8), .tc_mode(0), .rem_mode(1)) div_8bit_1 (
        .a(data1[8:15]), .b(data2[8:15]), .quotient(quotient_8bit_1), .remainder(remainder_8bit_1), .divide_by_0(div_by_0_8bit_1)
    );
    DW_div #(.a_width(8), .b_width(8), .tc_mode(0), .rem_mode(1)) div_8bit_2 (
        .a(data1[16:23]), .b(data2[16:23]), .quotient(quotient_8bit_2), .remainder(remainder_8bit_2), .divide_by_0(div_by_0_8bit_2)
    );
    DW_div #(.a_width(8), .b_width(8), .tc_mode(0), .rem_mode(1)) div_8bit_3 (
        .a(data1[24:31]), .b(data2[24:31]), .quotient(quotient_8bit_3), .remainder(remainder_8bit_3), .divide_by_0(div_by_0_8bit_3)
    );
    DW_div #(.a_width(8), .b_width(8), .tc_mode(0), .rem_mode(1)) div_8bit_4 (
        .a(data1[32:39]), .b(data2[32:39]), .quotient(quotient_8bit_4), .remainder(remainder_8bit_4), .divide_by_0(div_by_0_8bit_4)
    );
    DW_div #(.a_width(8), .b_width(8), .tc_mode(0), .rem_mode(1)) div_8bit_5 (
        .a(data1[40:47]), .b(data2[40:47]), .quotient(quotient_8bit_5), .remainder(remainder_8bit_5), .divide_by_0(div_by_0_8bit_5)
    );
    DW_div #(.a_width(8), .b_width(8), .tc_mode(0), .rem_mode(1)) div_8bit_6 (
        .a(data1[48:55]), .b(data2[48:55]), .quotient(quotient_8bit_6), .remainder(remainder_8bit_6), .divide_by_0(div_by_0_8bit_6)
    );
    DW_div #(.a_width(8), .b_width(8), .tc_mode(0), .rem_mode(1)) div_8bit_7 (
        .a(data1[56:63]), .b(data2[56:63]), .quotient(quotient_8bit_7), .remainder(remainder_8bit_7), .divide_by_0(div_by_0_8bit_7)
    );

    // 16-bit division instances for each 16-bit segment
    DW_div #(.a_width(16), .b_width(16), .tc_mode(0), .rem_mode(1)) div_16bit_0 (
        .a(data1[0:15]), .b(data2[0:15]), .quotient(quotient_16bit_0), .remainder(remainder_16bit_0), .divide_by_0(div_by_0_16bit_0)
    );
    DW_div #(.a_width(16), .b_width(16), .tc_mode(0), .rem_mode(1)) div_16bit_1 (
        .a(data1[16:31]), .b(data2[16:31]), .quotient(quotient_16bit_1), .remainder(remainder_16bit_1), .divide_by_0(div_by_0_16bit_1)
    );
    DW_div #(.a_width(16), .b_width(16), .tc_mode(0), .rem_mode(1)) div_16bit_2 (
        .a(data1[32:47]), .b(data2[32:47]), .quotient(quotient_16bit_2), .remainder(remainder_16bit_2), .divide_by_0(div_by_0_16bit_2)
    );
    DW_div #(.a_width(16), .b_width(16), .tc_mode(0), .rem_mode(1)) div_16bit_3 (
        .a(data1[48:63]), .b(data2[48:63]), .quotient(quotient_16bit_3), .remainder(remainder_16bit_3), .divide_by_0(div_by_0_16bit_3)
    );

    // 32-bit division instances for each 32-bit segment
    DW_div #(.a_width(32), .b_width(32), .tc_mode(0), .rem_mode(1)) div_32bit_0 (
        .a(data1[0:31]), .b(data2[0:31]), .quotient(quotient_32bit_0), .remainder(remainder_32bit_0), .divide_by_0(div_by_0_32bit_0)
    );
    DW_div #(.a_width(32), .b_width(32), .tc_mode(0), .rem_mode(1)) div_32bit_1 (
        .a(data1[32:63]), .b(data2[32:63]), .quotient(quotient_32bit_1), .remainder(remainder_32bit_1), .divide_by_0(div_by_0_32bit_1)
    );

    // 64-bit division instance
    DW_div #(.a_width(64), .b_width(64), .tc_mode(0), .rem_mode(1)) div_64bit (
        .a(data1[0:63]), .b(data2[0:63]), .quotient(quotient_64bit), .remainder(remainder_64bit), .divide_by_0(div_by_0_64bit)
    );
	
	
//-----------------------------------------------------------------------------------	

// sqaure design ware 
   // Intermediate signals for each segment's square result
    wire [0:15] square_8bit_0, square_8bit_2, square_8bit_4, square_8bit_6;
    wire [0:31] square_16bit_0, square_16bit_2;
    wire [0:63] square_32bit_0;

    // 8-bit square instances for each even 8-bit segment
    DW_square #(.width(8)) square_8bit_0_u (
        .a(data1[0:7]), .tc(1'b0), .square(square_8bit_0)
    );
    DW_square #(.width(8)) square_8bit_2_u (
        .a(data1[16:23]), .tc(1'b0), .square(square_8bit_2)
    );
    DW_square #(.width(8)) square_8bit_4_u (
        .a(data1[32:39]), .tc(1'b0), .square(square_8bit_4)
    );
    DW_square #(.width(8)) square_8bit_6_u (
        .a(data1[48:55]), .tc(1'b0), .square(square_8bit_6)
    );

    // 16-bit square instances for each even 16-bit segment
    DW_square #(.width(16)) square_16bit_0_u (
        .a(data1[0:15]), .tc(1'b0), .square(square_16bit_0)
    );
    DW_square #(.width(16)) square_16bit_2_u (
        .a(data1[32:47]), .tc(1'b0), .square(square_16bit_2)
    );

    // 32-bit square instance for the even 32-bit segment
    DW_square #(.width(32)) square_32bit_0_u (
        .a(data1[0:31]), .tc(1'b0), .square(square_32bit_0)
    );
	
	
	
	
	

	
	 // 8-bit square instances for each odd 8-bit segment
	 
	wire [0:15] square_8bit_1, square_8bit_3, square_8bit_5, square_8bit_7;
    wire [0:31] square_16bit_1, square_16bit_3;
    wire [0:63] square_32bit_1;
	
	
	
    DW_square #(.width(8)) square_8bit_1_u (
        .a(data1[8:15]), .tc(1'b0), .square(square_8bit_1)
    );
    DW_square #(.width(8)) square_8bit_3_u (
        .a(data1[24:31]), .tc(1'b0), .square(square_8bit_3)
    );
    DW_square #(.width(8)) square_8bit_5_u (
        .a(data1[40:47]), .tc(1'b0), .square(square_8bit_5)
    );
    DW_square #(.width(8)) square_8bit_7_u (
        .a(data1[56:63]), .tc(1'b0), .square(square_8bit_7)
    );

    // 16-bit square instances for each odd 16-bit segment
    DW_square #(.width(16)) square_16bit_1_u (
        .a(data1[16:31]), .tc(1'b0), .square(square_16bit_1)
    );
    DW_square #(.width(16)) square_16bit_3_u (
        .a(data1[48:63]), .tc(1'b0), .square(square_16bit_3)
    );

    // 32-bit square instance for the odd 32-bit segment
    DW_square #(.width(32)) square_32bit_1_u (
        .a(data1[32:63]), .tc(1'b0), .square(square_32bit_1)
    );
	
//--------------------------------------------------------------------------------------

// sqaure root design ware
	wire [0:3] root_8bit_0, root_8bit_1, root_8bit_2, root_8bit_3,root_8bit_4, root_8bit_5, root_8bit_6, root_8bit_7;
    wire [0:7] root_16bit_0, root_16bit_1, root_16bit_2, root_16bit_3;
    wire [0:15] root_32bit_0, root_32bit_1;
    wire [0:31] root_64bit;

    // 8-bit square root instances for each 8-bit segment
    DW_sqrt #(.width(8)) sqrt_8bit_0 (
        .a(data1[0:7]), .root(root_8bit_0)
    );
    DW_sqrt #(.width(8)) sqrt_8bit_1 (
        .a(data1[8:15]), .root(root_8bit_1)
    );
    DW_sqrt #(.width(8)) sqrt_8bit_2 (
        .a(data1[16:23]), .root(root_8bit_2)
    );
    DW_sqrt #(.width(8)) sqrt_8bit_3 (
        .a(data1[24:31]), .root(root_8bit_3)
    );
    DW_sqrt #(.width(8)) sqrt_8bit_4 (
        .a(data1[32:39]), .root(root_8bit_4)
    );
    DW_sqrt #(.width(8)) sqrt_8bit_5 (
        .a(data1[40:47]), .root(root_8bit_5)
    );
    DW_sqrt #(.width(8)) sqrt_8bit_6 (
        .a(data1[48:55]), .root(root_8bit_6)
    );
    DW_sqrt #(.width(8)) sqrt_8bit_7 (
        .a(data1[56:63]), .root(root_8bit_7)
    );

    // 16-bit square root instances for each 16-bit segment
    DW_sqrt #(.width(16)) sqrt_16bit_0 (
        .a(data1[0:15]), .root(root_16bit_0)
    );
    DW_sqrt #(.width(16)) sqrt_16bit_1 (
        .a(data1[16:31]), .root(root_16bit_1)
    );
    DW_sqrt #(.width(16)) sqrt_16bit_2 (
        .a(data1[32:47]), .root(root_16bit_2)
    );
    DW_sqrt #(.width(16)) sqrt_16bit_3 (
        .a(data1[48:63]), .root(root_16bit_3)
    );

    // 32-bit square root instances for each 32-bit segment
    DW_sqrt #(.width(32)) sqrt_32bit_0 (
        .a(data1[0:31]), .root(root_32bit_0)
    );
    DW_sqrt #(.width(32)) sqrt_32bit_1 (
        .a(data1[32:63]), .root(root_32bit_1)
    );

    // 64-bit square root instance
    DW_sqrt #(.width(64)) sqrt_64bit (
        .a(data1[0:63]), .root(root_64bit)
    );	
	
	
//------------------------------------------------------------------------------------	
	always @(*) 
	begin
        result = 64'b0; // Default result to 0
		
		 if (opcode == VAND) 
		 begin
            case (ww)
                2'b00: 
				begin // 8-bit AND, each segment is 8 bits
                    result[0:7]    = data1[0:7] & data2[0:7];
                    result[8:15]   = data1[8:15] & data2[8:15];
                    result[16:23]  = data1[16:23] & data2[16:23];
                    result[24:31]  = data1[24:31] & data2[24:31];
                    result[32:39]  = data1[32:39] & data2[32:39];
                    result[40:47]  = data1[40:47] & data2[40:47];
                    result[48:55]  = data1[48:55] & data2[48:55];
                    result[55:63]  = data1[55:63] & data2[55:63];
					//$display("8bit current data1=%b:,current data2=%b:, result=%h",data1,data2,result);
                end
                2'b01: 
				begin // 16-bit AND, each segment is 16 bits
                    result[0:15]   = data1[0:15] & data2[0:15];
                    result[16:31]  = data1[16:31] & data2[16:31];
                    result[32:47]  = data1[32:47] & data2[32:47];
                    result[48:63]  = data1[48:63] & data2[48:63];
					//$display("16 bit current data1=%b:,current data2=%b, result=%h:",data1,data2,result);
                end
                2'b10: 
				begin // 32-bit AND, each segment is 32 bits
                    result[0:31]   = data1[0:31] & data2[0:31];
                    result[32:63]  = data1[32:63] & data2[32:63];
					//$display("32 bit current data1=%b:,current data2=%b:, result=%h",data1,data2,result);
                end
                2'b11: 
				begin // 64-bit AND, entire 64-bit word
                    result = data1 & data2;
					//$display("64 bit current data1=%b:,current data2=%b:, result=%h",data1,data2,result);
                end
                default: result = 64'b0; // Handle invalid ww values
            endcase
		end
		
		 else if (opcode == VOR) 
		 begin
            case (ww)
                2'b00: begin // 8-bit OR, each segment is 8 bits
                    result[0:7]    = data1[0:7] | data2[0:7];
                    result[8:15]   = data1[8:15] | data2[8:15];
                    result[16:23]  = data1[16:23] | data2[16:23];
                    result[24:31]  = data1[24:31] | data2[24:31];
                    result[32:39]  = data1[32:39] | data2[32:39];
                    result[40:47]  = data1[40:47] | data2[40:47];
                    result[48:55]  = data1[48:55] | data2[48:55];
                    result[55:63]  = data1[55:63] | data2[55:63];
                end
                2'b01: begin // 16-bit OR, each segment is 16 bits
                    result[0:15]   = data1[0:15] | data2[0:15];
                    result[16:31]  = data1[16:31] | data2[16:31];
                    result[32:47]  = data1[32:47] | data2[32:47];
                    result[48:63]  = data1[48:63] | data2[48:63];
                end
                2'b10: begin // 32-bit OR, each segment is 32 bits
                    result[0:31]   = data1[0:31] | data2[0:31];
                    result[32:63]  = data1[32:63] | data2[32:63];
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
                    result[0:7]    = data1[0:7] ^ data2[0:7];
                    result[8:15]   = data1[8:15] ^ data2[8:15];
                    result[16:23]  = data1[16:23] ^ data2[16:23];
                    result[24:31]  = data1[24:31] ^ data2[24:31];
                    result[32:39]  = data1[32:39] ^ data2[32:39];
                    result[40:47]  = data1[40:47] ^ data2[40:47];
                    result[48:55]  = data1[48:55] ^ data2[48:55];
                    result[55:63]  = data1[55:63] ^ data2[55:63];
                end
                2'b01: 
				begin // 16-bit XOR, each segment is 16 bits
                    result[0:15]   = data1[0:15] ^ data2[0:15];
                    result[16:31]  = data1[16:31] ^ data2[16:31];
                    result[32:47]  = data1[32:47] ^ data2[32:47];
                    result[48:63]  = data1[48:63] ^ data2[48:63];
                end
                2'b10:
				begin // 32-bit XOR, each segment is 32 bits
                    result[0:31]   = data1[0:31] ^ data2[0:31];
                    result[32:63]  = data1[32:63] ^ data2[32:63];
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
                    result[0:7]    = ~data1[0:7];
                    result[8:15]   = ~data1[8:15];
                    result[16:23]  = ~data1[16:23];
                    result[24:31]  = ~data1[24:31];
                    result[32:39]  = ~data1[32:39];
                    result[40:47]  = ~data1[40:47];
                    result[48:55]  = ~data1[48:55];
                    result[55:63]  = ~data1[55:63];
                end
                2'b01: 
				begin // 16-bit NOT, each segment is 16 bits
                    result[0:15]   = ~data1[0:15];
                    result[16:31]  = ~data1[16:31];
                    result[32:47]  = ~data1[32:47];
                    result[48:63]  = ~data1[48:63];
                end
                2'b10: 
				begin // 32-bit NOT, each segment is 32 bits
                    result[0:31]   = ~data1[0:31];
                    result[32:63]  = ~data1[32:63];
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
                    result[0:7]    = data1[0:7];
                    result[8:15]   = data1[8:15];
                    result[16:23]  = data1[16:23];
                    result[24:31]  = data1[24:31];
                    result[32:39]  = data1[32:39];
                    result[40:47]  = data1[40:47];
                    result[48:55]  = data1[48:55];
                    result[55:63]  = data1[55:63];
                end
                2'b01: 
				begin // 16-bit MOVE, each segment is 16 bits
                    result[0:15]   = data1[0:15];
                    result[16:31]  = data1[16:31];
                    result[32:47]  = data1[32:47];
                    result[48:63]  = data1[48:63];
                end
                2'b10: 
				begin // 32-bit MOVE, each segment is 32 bits
                    result[0:31]   = data1[0:31];
                    result[32:63]  = data1[32:63];
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
                    result[0:7]    = data1[0:7] + data2[0:7];
                    result[8:15]   = data1[8:15] + data2[8:15];
                    result[16:23]  = data1[16:23] + data2[16:23];
                    result[24:31]  = data1[24:31] + data2[24:31];
                    result[32:39]  = data1[32:39] + data2[32:39];
                    result[40:47]  = data1[40:47] + data2[40:47];
                    result[48:55]  = data1[48:55] + data2[48:55];
                    result[56:63]  = data1[56:63] + data2[56:63];
                end
                2'b01: 
				begin // 16-bit addition
                    result[0:15]   = data1[0:15] + data2[0:15];
                    result[16:31]  = data1[16:31] + data2[16:31];
                    result[32:47]  = data1[32:47] + data2[32:47];
                    result[48:63]  = data1[48:63] + data2[48:63];
                end
                2'b10: 
				begin // 32-bit addition
                    result[0:31]   = data1[0:31] + data2[0:31];
                    result[32:63]  = data1[32:63] + data2[32:63];
                end
                2'b11: 
				begin // 64-bit addition
                    result[0:63]   = data1[0:63] + data2[0:63];
                end
                default: result = 65'b0; // Default case to avoid latches
            endcase
        end
		
		else if (opcode == VSUB) 
		begin
            case (ww)
                2'b00: 
				begin // 8-bit subtraction
                    result[0:7]    = data1[0:7] - data2[0:7];
                    result[8:15]   = data1[8:15] - data2[8:15];
                    result[16:23]  = data1[16:23] - data2[16:23];
                    result[24:31]  = data1[24:31] - data2[24:31];
                    result[32:39]  = data1[32:39] - data2[32:39];
                    result[40:47]  = data1[40:47] - data2[40:47];
                    result[48:55]  = data1[48:55] - data2[48:55];
                    result[56:63]  = data1[56:63] - data2[56:63];
                end
                2'b01: 
				begin // 16-bit subtraction
                    result[0:15]   = data1[0:15] - data2[0:15];
                    result[16:31]  = data1[16:31] - data2[16:31];
                    result[32:47]  = data1[32:47] - data2[32:47];
                    result[48:63]  = data1[48:63] - data2[48:63];
                end
                2'b10: 
				begin // 32-bit subtraction
                    result[0:31]   = data1[0:31] - data2[0:31];
                    result[32:63]  = data1[32:63] - data2[32:63];
                end
                2'b11: 
				begin // 64-bit subtraction
                    result[0:63]   = data1[0:63] - data2[0:63];
                end
                default: result = 65'b0; // Default case to avoid latches
            endcase
	
        end
		 else if (opcode == VMULEU) 
		 begin
            case (ww)
                2'b00: 
				begin // 8-bit segments, result is 16-bit per segment
                    result[0:15]   = data1[0:7] * data2[0:7];
                    result[16:31]  = data1[16:23] * data2[16:23];
                    result[32:47]  = data1[32:39] * data2[32:39];
                    result[48:63]  = data1[48:55] * data2[48:55];
                end
                2'b01: 
				begin // 16-bit segments, result is 32-bit per segment
                    result[0:31]   = data1[0:15] * data2[0:15];
                    result[32:63]  = data1[32:47] * data2[32:47];
                end
                2'b10: 
				begin // 32-bit segments, result is 64-bit
                    result[0:63]   = data1[0:31] * data2[0:31];
                end
                default: result = 64'b0; // Default case to avoid latches
            endcase
        end
		
		 else if (opcode == VMULOU) 
		 begin
            case (ww)
                2'b00: 
				begin // 8位段，每段结果为16位
                    result[0:15]   = data1[8:15] * data2[8:15];
                    result[16:31]  = data1[24:31] * data2[24:31];
                    result[32:47]  = data1[40:47] * data2[40:47];
                    result[48:63]  = data1[56:63] * data2[56:63];
                end
                2'b01: 
				begin // 16位段，每段结果为32位
                    result[0:31]   = data1[16:31] * data2[16:31];
                    result[32:63]  = data1[48:63] * data2[48:63];
                end
                2'b10: 
				begin // 32位段，结果为64位
                    result[0:63]   = data1[32:63] * data2[32:63];
                end
                default: result = 64'b0; 
            endcase
        end
		else if (opcode == VSLL) 
		begin
            case (ww)
                2'b00: 
				begin // 8-bit shift, shift amount is 3 bits
                    result[0:7]   = data1[0:7]   << data2[5:7];
                    result[8:15]  = data1[8:15]  << data2[13:15];
                    result[16:23] = data1[16:23] << data2[21:23];
                    result[24:31] = data1[24:31] << data2[29:31];
                    result[32:39] = data1[32:39] << data2[37:39];
                    result[40:47] = data1[40:47] << data2[45:47];
                    result[48:55] = data1[48:55] << data2[53:55];
                    result[56:63] = data1[56:63] << data2[61:63];
                end
                2'b01: 
				begin // 16-bit shift, shift amount is 4 bits
                    result[0:15]  = data1[0:15]  << data2[12:15];
                    result[16:31] = data1[16:31] << data2[28:31];
                    result[32:47] = data1[32:47] << data2[44:47];
                    result[48:63] = data1[48:63] << data2[60:63];
                end
                2'b10: 
				begin // 32-bit shift, shift amount is 5 bits
                    result[0:31]  = data1[0:31]  << data2[27:31];
                    result[32:63] = data1[32:63] << data2[59:63];
                end
                2'b11: 
				begin // 64-bit shift, shift amount is 6 bits
                    result[0:63]  = data1[0:63]  << data2[58:63];
                end
                default: result = 64'b0; // Default case to avoid latches
            endcase
        end
		else if (opcode == VSRL) 
		begin
            case (ww)
                2'b00: 
				begin // 8-bit shift, shift amount is 3 bits
                    result[0:7]   = data1[0:7]   >> data2[5:7];
                    result[8:15]  = data1[8:15]  >> data2[13:15];
                    result[16:23] = data1[16:23] >> data2[21:23];
                    result[24:31] = data1[24:31] >> data2[29:31];
                    result[32:39] = data1[32:39] >> data2[37:39];
                    result[40:47] = data1[40:47] >> data2[45:47];
                    result[48:55] = data1[48:55] >> data2[53:55];
                    result[56:63] = data1[56:63] >> data2[61:63];
                end
                2'b01: 
				begin // 16-bit shift, shift amount is 4 bits
                    result[0:15]  = data1[0:15]  >> data2[12:15];
                    result[16:31] = data1[16:31] >> data2[28:31];
                    result[32:47] = data1[32:47] >> data2[44:47];
                    result[48:63] = data1[48:63] >> data2[60:63];
                end
                2'b10: 
				begin // 32-bit shift, shift amount is 5 bits
                    result[0:31]  = data1[0:31]  >> data2[27:31];
                    result[32:63] = data1[32:63] >> data2[59:63];
                end
                2'b11: 
				begin // 64-bit shift, shift amount is 6 bits
                    result[0:63]  = data1[0:63]  >> data2[58:63];
                end
                default: result = 64'b0; // Default case to avoid latches
            endcase
        end
		
		else if (opcode == VSRA)
		begin
			case (ww)
				2'b00: 
					begin
						result[0:7]   = $signed(data1[0:7]) >>> data2[5:7];
						result[8:15]  = $signed(data1[8:15]) >>> data2[13:15];
						result[16:23] = $signed(data1[16:23]) >>> data2[21:23];
						result[24:31] = $signed(data1[24:31]) >>> data2[29:31];
						result[32:39] = $signed(data1[32:39]) >>> data2[37:39];
						result[40:47] = $signed(data1[40:47]) >>> data2[45:47];
						result[48:55] = $signed(data1[48:55]) >>> data2[53:55];
						result[56:63] = $signed(data1[56:63]) >>> data2[61:63];
						
					end
				2'b01: 
					begin
						result[0:15]  = $signed(data1[0:15]) >>> data2[12:15];
						result[16:31] = $signed(data1[16:31]) >>> data2[28:31];
						result[32:47] = $signed(data1[32:47]) >>> data2[44:47];
						result[48:63] = $signed(data1[48:63]) >>> data2[60:63];
					end
				2'b10:
					begin
						result[0:31]  = $signed(data1[0:31]) >>> data2[27:31];
						result[32:63] = $signed(data1[32:63]) >>> data2[59:63];
					end
				2'b11: 
					begin
						result[0:63]  = $signed(data1[0:63]) >>> data2[58:63];
					end
				default: result = 64'b0;
			endcase
		end
		
	

		else if (opcode == VRTTTH)
		begin
			case (ww)
				2'b00:
					begin // 8-bit segments, swap nibbles
						result[0:7]   = {data1[4:7], data1[0:3]};
						result[8:15]  = {data1[12:15], data1[8:11]};
						result[16:23] = {data1[20:23], data1[16:19]};
						result[24:31] = {data1[28:31], data1[24:27]};
						result[32:39] = {data1[36:39], data1[32:35]};
						result[40:47] = {data1[44:47], data1[40:43]};
						result[48:55] = {data1[52:55], data1[48:51]};
						result[56:63] = {data1[60:63], data1[56:59]};
					end
			2'b01:
					begin // 16-bit segments, swap bytes
						result[0:15]  = {data1[8:15], data1[0:7]};
						result[16:31] = {data1[24:31], data1[16:23]};
						result[32:47] = {data1[40:47], data1[32:39]};
						result[48:63] = {data1[56:63], data1[48:55]};
					end
			2'b10:
					begin // 32-bit segments, swap half-words
						result[0:31]  = {data1[16:31], data1[0:15]};
						result[32:63] = {data1[48:63], data1[32:47]};
					end
			2'b11:
					begin // 64-bit segment, swap words
					result[0:63]  = {data1[32:63], data1[0:31]};
					end
					default: result = 64'b0; // Default case to avoid latches
		    endcase
		end

		
		else if (opcode == VDIV) 
		begin
            case (ww)
                2'b00: 
				begin // 8-bit division, segment each 8-bit field
                    result[0:7]    = quotient_8bit_0;
                    result[8:15]   = quotient_8bit_1;
                    result[16:23]  = quotient_8bit_2;
                    result[24:31]  = quotient_8bit_3;
                    result[32:39]  = quotient_8bit_4;
                    result[40:47]  = quotient_8bit_5;
                    result[48:55]  = quotient_8bit_6;
                    result[56:63]  = quotient_8bit_7;
                    divide_by_0 = div_by_0_8bit_0 | div_by_0_8bit_1 | div_by_0_8bit_2 | div_by_0_8bit_3 | div_by_0_8bit_4 | div_by_0_8bit_5 | div_by_0_8bit_6 | div_by_0_8bit_7;
                end
                2'b01: 
				begin // 16-bit division, segment each 16-bit field
                    result[0:15]   = quotient_16bit_0;
                    result[16:31]  = quotient_16bit_1;
                    result[32:47]  = quotient_16bit_2;
                    result[48:63]  = quotient_16bit_3;
                    divide_by_0 = div_by_0_16bit_0 | div_by_0_16bit_1 | div_by_0_16bit_2 | div_by_0_16bit_3;
                end
                2'b10: 
				begin // 32-bit division, segment each 32-bit field
                    result[0:31]   = quotient_32bit_0;
                    result[32:63]  = quotient_32bit_1;
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
                    result[0:7]    = remainder_8bit_0;
                    result[8:15]   = remainder_8bit_1;
                    result[16:23]  = remainder_8bit_2;
                    result[24:31]  = remainder_8bit_3;
                    result[32:39]  = remainder_8bit_4;
                    result[40:47]  = remainder_8bit_5;
                    result[48:55]  = remainder_8bit_6;
                    result[56:63]  = remainder_8bit_7;
                    divide_by_0 = div_by_0_8bit_0 | div_by_0_8bit_1 | div_by_0_8bit_2 | div_by_0_8bit_3 | div_by_0_8bit_4 | div_by_0_8bit_5 | div_by_0_8bit_6 | div_by_0_8bit_7;
                end
                2'b01: 
				begin // 16-bit division, segment each 16-bit field
                    result[0:15]   = remainder_16bit_0;
                    result[16:31]  = remainder_16bit_1;
                    result[32:47]  = remainder_16bit_2;
                    result[48:63]  = remainder_16bit_3;
                    divide_by_0 = div_by_0_16bit_0 | div_by_0_16bit_1 | div_by_0_16bit_2 | div_by_0_16bit_3;
                end
                2'b10: 
				begin // 32-bit division, segment each 32-bit field
                    result[0:31]   =remainder_32bit_0;
                    result[32:63]  = remainder_32bit_1;
                    divide_by_0 = div_by_0_32bit_0 | div_by_0_32bit_1;
                end
                2'b11: 
				begin // 64-bit division, entire 64-bit field
                    result = remainder_64bit;
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
                    result[0:15]   = square_8bit_0;
                    result[16:31]  = square_8bit_2;
                    result[32:47]  = square_8bit_4;
                    result[48:63]  = square_8bit_6;
                end
                2'b01: 
				begin // 16-bit square, for each even 16-bit segment
                    result[0:31]   = square_16bit_0;
                    result[32:63]  = square_16bit_2;
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
                    result[0:15]   = square_8bit_1;
                    result[16:31]  = square_8bit_3;
                    result[32:47]  = square_8bit_5;
                    result[48:63]  = square_8bit_7;
                end
                2'b01: 
				begin // 16-bit square, for each odd 16-bit segment
                    result[0:31]   = square_16bit_1;
                    result[32:63]  = square_16bit_3;
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
                    result[0:7]    = root_8bit_0;
                    result[8:15]    = root_8bit_1;
                    result[16:23]   = root_8bit_2;
                    result[24:31]  = root_8bit_3;
                    result[32:39]  = root_8bit_4;
                    result[40:47]  = root_8bit_5;
                    result[48:55]  = root_8bit_6;
                    result[56:63]  = root_8bit_7;
                end
                2'b01: 
				begin // 16-bit square root, segment each 16-bit field
                    result[0:15]   = root_16bit_0;
                    result[16:31]  = root_16bit_1;
                    result[32:47] = root_16bit_2;
                    result[48:63] = root_16bit_3;
                end
                2'b10:
				begin // 32-bit square root, segment each 32-bit field
                    result[0:31]  = root_32bit_0;
                    result[32:63] = root_32bit_1;
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