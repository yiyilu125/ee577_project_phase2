module pipeline #(
    parameter INSTRUCTION_WIDTH = 32,
    parameter DATA_WIDTH = 64,
    parameter REG_ADDRESS_LENGTH = 5,
    parameter OPCODE_LENGTH = 6,
    parameter IMMEDIATE_ADDRESS_LENGTH = 16,
    parameter DMEM_ADDRESS_LENGTH = 16
)(
    input clk, rst,
    input [INSTRUCTION_WIDTH-1:0] imem_instruction,
    input [DATA_WIDTH-1:0] dmem_dataOut,
    output [INSTRUCTION_WIDTH-1:0] imem_address,
    output [INSTRUCTION_WIDTH-1:0] dmem_address,
    output [DATA_WIDTH-1:0] dmem_dataIn,
    output store_enable,
    output mem_enable
);
    /*stage 1: IF reg, wire*/
    //stage register
    reg [INSTRUCTION_WIDTH-1:0] s1_reg_instruction;
    //wire
    wire flush_sig;
    wire [IMMEDIATE_ADDRESS_LENGTH-1:0] target_address;
    wire taken_sig;

    /*stage 2: ID, wire*/
    /*stage register*/
    reg s2_reg_writen_en;
    reg [REG_ADDRESS_LENGTH-1:0] s2_reg_rd_address;
    reg [DATA_WIDTH-1:0] s2_reg_data1, s2_reg_data2;
    reg [5:0] s2_opcode; 
	reg [1:0] s2_ww;	// width of arithmatic operation at S2
    reg s2_reg_dmem_load_signal;
    reg [2:0] s2_reg_ppp;
    /*wire*/
	wire [1:0] ww; //width of arithmatic operation at S2
    wire [2:0] ppp;
    wire wire_writen_en;
    wire [REG_ADDRESS_LENGTH-1:0] wire_rd_address;
    wire [REG_ADDRESS_LENGTH-1:0] read_address1, read_address2; // change 31bit to 5bit
	
    wire [REG_ADDRESS_LENGTH-1:0] read_address1_HDU, read_address2_HDU; // rg addrss use 
    wire [1:0] BR; // branch kinds identifier
    wire [IMMEDIATE_ADDRESS_LENGTH-1:0] Branch_immediate; // immediate adder of BR Instruction
	
    wire [DATA_WIDTH-1:0] reg_data1, reg_data2;
    wire [DATA_WIDTH-1:0] mux_rA_data, mux_rB_data;
    wire [5:0] opcode;  // fix 31->4
   // wire [OPCODE_LENGTH-1:0] opcode; 
    wire [DMEM_ADDRESS_LENGTH-1:0] datamem_address;
    wire mux_ctrl_rA;
    wire mux_ctrl_rB;
    wire store_en, load_en;
    wire dmem_load_signal;

    /*stage 3: EXE & MEM reg, wire*/
    //stage register
    reg s3_reg_write_en;
    reg [REG_ADDRESS_LENGTH-1:0] s3_reg_rd_address;
    reg [DATA_WIDTH-1:0] s3_reg_result;
    reg [2:0] s3_reg_ppp;
    //wire
    wire [DATA_WIDTH-1:0] alu_result;
    wire [DATA_WIDTH-1:0] mux_result;

    /******************************stage 1: Instruction Fetch******************************/
    //PC module & IMEM module
    program_counter pc(
        .clk(clk),
        .reset(rst),
        .branch_en(taken_sig),
        .branch_target(target_address),
        .ins_address(imem_address)
    );

    //IF/ID register
    always@(posedge clk)begin
        if (flush_sig==1) begin
            s1_reg_instruction <= 0;
        end else begin
            s1_reg_instruction <= imem_instruction; 
        end
    end

  


  /******************************stage 2: Instruction Decode and Register Fetch******************************/
    /*Decode module & DHU module & Register File module*/
    instruction_decoder uut(
        //input
        .instruction(s1_reg_instruction), 

        //output
        .RegisterA(read_address1), // output：   for RA
        .RegisterB(read_address2), // output : for RB
        .HDU_A(read_address1_HDU),  // output :RA used to send to HDU
        .HDU_B(read_address2_HDU),    // output: RB used to send to HDU   
		.arithmatic_RD(wire_rd_address), // ouptut: destination address for arithmatic operation
		
        //branch
		.BR(BR), // ouput : to send to branch to indicate Branch kinds
        .Branch_immediate(Branch_immediate), //output : branch immediate address

        .MEM_addr(datamem_address),// need to work ?
		.writen_en(wire_writen_en),
		
        .WW(ww),  // output: port for width of arithmatic operation
        .operation(opcode), // output: port for operation kinds
        .ppp(ppp),

        .store_Enable(store_enable),
        .mem_Enable(mem_enable),
        .load_signal(dmem_load_signal)
    );
	
	
    //Harzard_detection_unit
    hdu hdu_uut(
        .current_RA(read_address1_HDU),
        .current_RB(read_address2_HDU),
        .Lasttime_RD(s2_reg_rd_address),
        .mux_ctrl_rA(mux_ctrl_rA),
        .mux_ctrl_rB(mux_ctrl_rB)
    );

    //register file
    register_file reg_file( //a register module with async read and sync write
        .clk(clk),
        .reset(rst),
        .writen_en(s3_reg_write_en), //signal come from the register in the 4th stage
        .write_address(s3_reg_rd_address), //signal come from the register in the 4th stage
        .data_in(s3_reg_result),  //signal come from the register in the 4th stage
        .read_address1(read_address1),
        .read_address2(read_address2),
        .data_out1(reg_data1),
        .data_out2(reg_data2)
    );

    //forwarding unit mux
    mux_2 mux_ra (
        .in0(reg_data1),
        .in1(s3_reg_result),     //forwarding from stage 3
        .select(mux_ctrl_rA),
        .out(mux_rA_data)
    );
    mux_2 mux_rb(
        .in0(reg_data2),
        .in1(s3_reg_result),     //forwarding from stage 3
        .select(mux_ctrl_rB),
        .out(mux_rB_data)
    );

    //communication to the dmem
    assign dmem_dataIn = mux_rA_data;
    assign dmem_address = datamem_address;

    //Branch module
    branch branch_uut(
        .clk(clk),
        .reset(rst),
		
        .branch(BR),   
        .branch_target(Branch_immediate),  
        .data_branch(reg_data1),    
		
        //output
        .target_address(target_address),
        .taken(taken_sig),               
        .flush(flush_sig) 
    );

    //ID/EXE,MEM register
    always@(posedge clk)begin
        s2_reg_rd_address <= wire_rd_address;
        s2_reg_writen_en <= wire_writen_en;
        s2_reg_data1 <= mux_rA_data;
        s2_reg_data2 <= mux_rB_data;
        s2_opcode <= opcode;
		s2_ww <= ww; //Width of operation	
        s2_reg_ppp <= ppp;
        s2_reg_dmem_load_signal <= dmem_load_signal;
    end

    /***************stage 3: Execution or Memory Access***************/
    //mux module & ALU module & SFU module
    alu alu_module( //this alu may contains SFU
        .opcode(s2_opcode),
        .data1(s2_reg_data1),
        .data2(s2_reg_data2),
		.ww(s2_ww),   // fix
        .result(alu_result)
    );

    mux_2 mux_module(
        .in0(alu_result),
        .in1(dmem_dataOut),
        .select(s2_reg_dmem_load_signal),
        .out(mux_result)
    ); 

    //EXE,MEM/WB register
    always@(posedge clk)begin
        s3_reg_write_en <= s2_reg_writen_en;
        s3_reg_rd_address <= s2_reg_rd_address;
        s3_reg_result <= mux_result;
        s3_reg_ppp <= s2_reg_ppp;
    end

    /******************************stage 4: WB******************************/
endmodule