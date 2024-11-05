module cardinal_cmp (
    input wire clk,
    input wire reset,

    // Core 0
    input wire [31:0] node0_inst_in,   // IMEM -> IF/ID
    input wire [63:0] node0_d_in,      // DMEM -> ALU_MUX
    output wire [31:0] node0_pc_out,   // pc -> IMEM
    output wire [63:0] node0_d_out,    // regfile -> DMEM
    output wire [31:0] node0_addr_out, // decoder -> DMEM, valid when store word
    output wire node0_memWrEn,         // decoder -> DMEM, active when store word
    output wire node0_memEn,           // memory enable

    // Core 1
    input wire [31:0] node1_inst_in,
    input wire [63:0] node1_d_in,
    output wire [31:0] node1_pc_out,
    output wire [63:0] node1_d_out,
    output wire [31:0] node1_addr_out,
    output wire node1_memWrEn,
    output wire node1_memEn,

    // Core 2
    input wire [31:0] node2_inst_in,
    input wire [63:0] node2_d_in,
    output wire [31:0] node2_pc_out,
    output wire [63:0] node2_d_out,
    output wire [31:0] node2_addr_out,
    output wire node2_memWrEn,
    output wire node2_memEn,

    // Core 3
    input wire [31:0] node3_inst_in,
    input wire [63:0] node3_d_in,
    output wire [31:0] node3_pc_out,
    output wire [63:0] node3_d_out,
    output wire [31:0] node3_addr_out,
    output wire node3_memWrEn,
    output wire node3_memEn
);



// Instantiate Core0
pipeline #(
    .INSTRUCTION_WIDTH(32),
    .DATA_WIDTH(64),
    .REG_ADDRESS_LENGTH(5),
    .OPCODE_LENGTH(5),
    .IMMEDIATE_ADDRESS_LENGTH(16)
) Core0 (
    .clk(clk),
    .rst(reset),
    .imem_instruction(node0_inst_in),
    .dmem_dataOut(node0_d_in),
    .imem_address(node0_pc_out),
    .dmem_address(node0_addr_out),
    .dmem_dataIn(node0_d_out),
    .store_enable(node0_memWrEn),
    .mem_enable(node0_memEn)
);

// Instantiate Core1
pipeline #(
    .INSTRUCTION_WIDTH(32),
    .DATA_WIDTH(64),
    .REG_ADDRESS_LENGTH(5),
    .OPCODE_LENGTH(5),
    .IMMEDIATE_ADDRESS_LENGTH(16)
) Core1 (
    .clk(clk),
    .rst(reset),
    .imem_instruction(node1_inst_in),
    .dmem_dataOut(node1_d_in),
    .imem_address(node1_pc_out),
    .dmem_address(node1_addr_out),
    .dmem_dataIn(node1_d_out),
    .store_enable(node1_memWrEn),
    .mem_enable(node1_memEn)
);

// Instantiate Core2
pipeline #(
    .INSTRUCTION_WIDTH(32),
    .DATA_WIDTH(64),
    .REG_ADDRESS_LENGTH(5),
    .OPCODE_LENGTH(5),
    .IMMEDIATE_ADDRESS_LENGTH(16)
) Core2 (
    .clk(clk),
    .rst(reset),
    .imem_instruction(node2_inst_in),
    .dmem_dataOut(node2_d_in),
    .imem_address(node2_pc_out),
    .dmem_address(node2_addr_out),
    .dmem_dataIn(node2_d_out),
    .store_enable(node2_memWrEn),
    .mem_enable(node2_memEn)
);

// Instantiate Core3
pipeline #(
    .INSTRUCTION_WIDTH(32),
    .DATA_WIDTH(64),
    .REG_ADDRESS_LENGTH(5),
    .OPCODE_LENGTH(5),
    .IMMEDIATE_ADDRESS_LENGTH(16)
) Core3 (
    .clk(clk),
    .rst(reset),
    .imem_instruction(node3_inst_in),
    .dmem_dataOut(node3_d_in),
    .imem_address(node3_pc_out),
    .dmem_address(node3_addr_out),
    .dmem_dataIn(node3_d_out),
    .store_enable(node3_memWrEn),
    .mem_enable(node3_memEn)
);





endmodule
