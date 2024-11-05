module instruction_decoder (
    input [31:0] instruction,
    output reg [4:0] RegisterA, // address of oprA
    output reg [4:0] RegisterB, // address of oprB
    output reg [4:0] WW, // Write Width field from instruction
    output reg [5:0] operation, // Operation code from instruction
    output reg [4:0] arithmatic_RD, // Arithmetic result destination register
	
	output reg [4:0] HDU_A, // Hazard Detection Unit address for oprA
    output reg [4:0] HDU_B, // Hazard Detection Unit address for oprB
    
    output reg [1:0] BR, // Branch control signal
    output reg [15:0] Branch_immediate, // Immediate value for branch
    
    output reg [15:0] MEM_addr, // Memory address for M-type instructions
	output reg store_Enable,
	output reg mem_Enable,
	
	output reg writen_en,	
	output reg load_signal
	
);

always @(*) begin
    case (instruction[31:26])
        6'b101010: 
        begin // R-type instructions (not branch)
            RegisterA = instruction[20:16]; // Extract Register A address from bits 20-16
            RegisterB = instruction[15:11]; // Extract Register B address from bits 15-11
            HDU_A = instruction[20:16]; // Set Hazard Detection Unit input A to Register A
            HDU_B = instruction[15:11]; // Set Hazard Detection Unit input B to Register B
			arithmatic_RD = instruction[25:21]; // Set destination register for arithmetic result
			
			
			BR = 2'b00; // No branch          
            Branch_immediate = 5'b0; // No immediate value for branch
			
			MEM_addr = 0; // Not applicable for R-type
			writen_en=1'b1;
			
            WW = instruction[10:6]; // Extract Write Width from bits 10-6
            operation = instruction[5:0]; // Extract operation code from bits 5-0
           
            
        
			store_Enable=0;
			mem_Enable=0;
			load_signal=0;
			
			
			
        end
        6'b100010: 
        begin // VBNZ (branch)
            RegisterA = instruction[25:21]; // Extract Register A address from bits 25-21
            RegisterB = 0; // Extract Register B 0
            HDU_A = instruction[25:21]; // Set Hazard Detection Unit input A to Register A
            HDU_B = 0; // Set Hazard Detection Unit input B to Register B
			arithmatic_RD = 0; // Set destination register for arithmetic result
			
			
			BR = 2'b10; // No branch          
            Branch_immediate = instruction[15:0]; // No immediate value for branch
			
			MEM_addr = 0; // Not applicable for R-type
			writen_en=1'b1;
			
            WW =0; // Extract Write Width from bits 10-6
            operation = 0; // Extract operation code from bits 5-0
                   
        
			store_Enable=0;
			mem_Enable=0;
			load_signal=0;
        end
        6'b100011:
        begin // VBENZ (branch)
            RegisterA = instruction[25:21]; // Extract Register A address from bits 25-21
            RegisterB = 0; // Extract Register B 0
            HDU_A = instruction[25:21]; // Set Hazard Detection Unit input A to Register A
            HDU_B = 0; // Set Hazard Detection Unit input B to Register B
			arithmatic_RD = 0; // Set destination register for arithmetic result
			
			
			BR = 2'b11; // No branch          
            Branch_immediate = instruction[15:0]; // No immediate value for branch
			
			MEM_addr = 0; // Not applicable for R-type
			writen_en=1'b1;
			
            WW =0; // Extract Write Width from bits 10-6
            operation = 0; // Extract operation code from bits 5-0
                   
        
			store_Enable=0;
			mem_Enable=0;
			load_signal=0;
        end
        6'b100000: 
        begin // LD
            RegisterA = 0; // Extract Register A address from bits 25-21
            RegisterB = 0; // Extract Register B 0
            HDU_A = instruction[25:21]; // Set Hazard Detection Unit input A to Register A
            HDU_B = 0; // Set Hazard Detection Unit input B to Register B
			arithmatic_RD =  instruction[25:21]; // Set destination register for arithmetic result
			
			
			BR = 0; // No branch          
            Branch_immediate = 0; // No immediate value for branch
			
			MEM_addr = instruction[15:0]; // Not applicable for R-type
			writen_en=1;
			
            WW =0; // Extract Write Width from bits 10-6
            operation = 0; // Extract operation code from bits 5-0
                   
        
			store_Enable=0;
			mem_Enable=1;
			load_signal=1;
			
        end
        6'b100001: 
        begin // M-type instructions SW
            RegisterA = instruction[25:21]; // Extract Register A address from bits 25-21
            RegisterB = 0; // Extract Register B 0
            HDU_A = instruction[25:21]; // Set Hazard Detection Unit input A to Register A
            HDU_B = 0; // Set Hazard Detection Unit input B to Register B
			arithmatic_RD = 0; // Set destination register for arithmetic result
			
			
			BR = 0; // No branch          
            Branch_immediate = 0; // No immediate value for branch
			
			MEM_addr = instruction[15:0]; // Not applicable for R-type
			writen_en=0;
			
            WW =0; // Extract Write Width from bits 10-6
            operation = 0; // Extract operation code from bits 5-0
                   
        
			store_Enable=1;
			mem_Enable=1;
			load_signal=0;
        end
        6'b111100:
        begin // NOP instruction
            RegisterA = 0; // Extract Register A address from bits 25-21
            RegisterB = 0; // Extract Register B 0
            HDU_A = 0; // Set Hazard Detection Unit input A to Register A
            HDU_B = 0; // Set Hazard Detection Unit input B to Register B
			arithmatic_RD = 0; // Set destination register for arithmetic result
			
			
			BR = 0; // No branch          
            Branch_immediate = 0; // No immediate value for branch
			
			MEM_addr = 0; // Not applicable for R-type
			writen_en=0;
			
            WW =0; // Extract Write Width from bits 10-6
            operation = 0; // Extract operation code from bits 5-0
                   
        
			store_Enable=0;
			mem_Enable=0;
			load_signal=0;
        end
    endcase
end

endmodule
