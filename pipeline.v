module pipeline #(
    parameter INSTRUCTION_WIDTH = 32;
    parameter DATA_WIDTH = 64;
)(
    input clk, rst,
    input [INSTRUCTION_WIDTH-1:0] imem_instruction,
    input [DATA_WIDTH-1:0] dmem_dataOut,
    output [INSTRUCTION_WIDTH-1:0] imem_address,
    output [INSTRUCTION_WIDTH-1:0] dmem_address,
    output reg [DATA_WIDTH-1:0] dmem_dataIn,
);
    /***************stage 1: Instruction Fetch***************/
    //stage register
    reg [INSTRUCTION_WIDTH-1:0] s1_reg_instruction;

    //PC module & IMEM module
    program_counter pc(
        .clk(clk),
        .reset(reset),
        .branch(),
        .branch_target(),
        .ins_address(imem_address)
    );

    always@(posedge clk)begin
       s1_reg_instruction <= imem_instruction; 
    end

    /***************stage 2: Instruction Decode and Register Fetch***************/
    //stage register
    reg s2_reg_writen_en;
    reg [DATA_WIDTH-1:0] s2_reg_data1, s2_reg_data2;
    reg [31:0] s2_opcode; //TODO
    //wire 
    wire wire_writen_en, wire_read_en;
    wire [31:0] read_address1, read_address2;
    wire [DATA_WIDTH-1:0] reg_data1;
    wire [DATA_WIDTH-1:0] reg_data2;
    wire [31:0] opcode;
    wire [31:0] dmem_ctrl;

    //Decode module & DHU module & Register File module
    decoder decode(
        .instruction(s1_reg_instruction),
        .read_en(wire_read_en),
        .read_address1(read_address1),
        .read_address2(read_address2),
        .write_en(wire_writen_en),
        .opcode(opcode)
        .dmem_ctrl(dmem_ctrl)
    );

    //communication to the dmem
    assign dmem_dataIn = reg_data2;
    assign dmem_address = dmem_ctrl;

    //Harzard_detection_unit HDU() TODO

    register_file reg_file( //a register module with async read and sync write
        .clk(clk),
        .reset(reset),
        // .read_en(wire_read_en),
        .writen_en(s3_reg_write_en) //signal come from the register in the 4th stage
        .data_in(s3_reg_alu_result),   //signal come from the register in the 4th stage
        .read_address1(read_address1),
        .read_address2(read_address2),
        .data_out1(reg_data1),
        .data_out2(reg_data2)
    );

    always@(posedge clk)begin
        s2_reg_writen <= wire_writen_en;
        s2_reg_data1 <= reg_data1;
        s2_reg_data2 <= reg_data2;
        s2_opcode <= opcode;
    end

    /***************stage 3: Execution or Memory Access***************/
    //stage register
    reg s3_reg_write_en;
    reg [DATA_WIDTH-1:0] s3_reg_alu_result;
    //wire
    wire [DATA_WIDTH-1:0] alu_result;
    wire [DATA_WIDTH-1:0] mux_result;

    //mux module & ALU module & SFU module
    mux mux_module(); //TODO

    alu alu_module( //this alu may contains SFU
        .opcode(s2_opcode),
        .data1(s2_reg_data1),
        .data2(s2_reg_data2),
        .result(alu_result)
    );

    mux mux_module(
        .data1(dmem_dataOut),
        .data1(alu_result),
        .result(mux_result)
    ); 

    always@(posedge clk)begin
        s3_reg_write_en <= s2_reg_writen_en;
        s3_reg_alu_result <= mux_result;
    end

    /***************stage 4: Write back***************/
    //this part is blank, HDU and Forward UNIT may used


endmodule