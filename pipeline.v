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
        .branch_en(),
        .branch_target(),
        .ins_address(imem_address)
    );

    //IF/ID register
    always@(posedge clk)begin
       s1_reg_instruction <= imem_instruction; 
    end

    /***************stage 2: Instruction Decode and Register Fetch***************/
    //stage register
    reg s2_reg_writen_en;
    reg [REG_ADDRESS_LENGTH-1:0] s2_reg_rd_address;
    reg [DATA_WIDTH-1:0] s2_reg_data1, s2_reg_data2;
    reg [4:0] s2_opcode; //TODO  // fix 31->4
	
	
	
	//--------------------------------------fix 
	reg [4:0] s2_ww;	// width of arithmatic operation at S2
	reg [4:0] ww; //width of arithmatic operation at S2
	//\\------------------------------------------------------fix 
	
    //wire 
    wire wire_writen_en;
    wire [REG_ADDRESS_LENGTH-1:0] wire_rd_address;
	
	
	
	//--------------------------------------------------------------fix 
    wire [4:0] read_address1, read_address2; // change 31bit to 5bit
	//\\-------------------------------------------------------------fix  
	
	
	
	
	//------------------------------------------------------------ fix 	
	 wire [4:0] read_address1_HDU, read_address2_HDU; // rg addrss use 
	 wire [1:0] BR // branch kinds identifier
	 wire [4:0] Branch_RD;  // Branch target rg that to compare with ZERO
	 wire [15:0] Branch_immediate; // immediate adder of BR Instruction
	//\\---------------------------------------------------------- fix 
	
	
	
	
    wire [DATA_WIDTH-1:0] reg_data1, reg_data2;
    wire [DATA_WIDTH-1:0] mux_rA_data, mux_rB_data;
    wire [4:0] opcode;  // fix 31->4
    wire [31:0] dmem_ctrl;
    wire mux_ctrl_rA;
    wire mux_ctrl_rB;

    //Decode module & DHU module & Register File module
    /*decoder decode(
        .instruction(s1_reg_instruction),
        .read_address1(read_address1),
        .read_address2(read_address2),
        .write_en(wire_writen_en),
        .rd_address(wire_rd_address),
        .opcode(opcode)
        .dmem_ctrl(dmem_ctrl)
    );*/
//------------------------------------------------------------ fix 



	instruction_decoder uut (
        .instruction(instruction), 
        .RegisterA((read_address1), // output：   for RA
        .RegisterB(read_address2), // output : for RB
        .HDU_A(read_address1_HDU),  // output :RA used to send to HDU
        .HDU_B(read_address2_HDU),    // output: RB used to send to HDU   
		.arithmatic_RD(wire_rd_address), // ouptut: destination address for arithmatic operation
		
		
		.BR(BR), // ouput : to send to branch to indicate Branch kinds
        .Branch_RD(Branch_RD),  // output : branch target address
        .Branch_immediate(Branch_immediate), //output : branch immediate address


		
        .MEM_addr(),// need to work ?
		.writen_en()
		.dmem_ctrl()
		
		
        .WW(ww),  // output: port for width of arithmatic operation
        .operation(opcode) // output: port for operation kinds
		
		
		
    );
	
	
	
//\\---------------------------------------------------------- fix	
	
	
	
	
	
	
	

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
        .reset(reset),
        .writen_en(s3_reg_write_en) //signal come from the register in the 4th stage
        .write_address(s3_reg_rd_address) //signal come from the register in the 4th stage
        .data_in(s3_reg_result),   //signal come from the register in the 4th stage
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
    assign dmem_address = dmem_ctrl;

    //Branch module
    branch branch_uut(
        .clk(clk),
        .reset(reset),
		
		//---------------------------------- fix
        .branch(BR),   
        .branch_target(Branch_immediate),  
        .data_branch(Branch_RD),    
		//\\------------------------------- fix
		
        .target_address(),
        .taken(),               
        .flush() 
    );

    //ID/EXE,MEM register
	
    always@(posedge clk)begin
        s2_reg_rd_address <= wire_rd_address;
        s2_reg_writen <= wire_writen_en;
        s2_reg_data1 <= mux_rA_data;
        s2_reg_data2 <= mux_ctrl_rB;
        s2_opcode <= opcode;
		
		//------------------------------------------------------fix 
		s2_ww<=ww; //Width of operation	
		//\\------------------------------------------------------fix 	
    end








    /***************stage 3: Execution or Memory Access***************/
    //stage register
    reg s3_reg_write_en;
    reg [REG_ADDRESS_LENGTH-1:0] s3_reg_rd_address;
    reg [DATA_WIDTH-1:0] s3_reg_result;
    //wire
    wire [DATA_WIDTH-1:0] alu_result;
    wire [DATA_WIDTH-1:0] mux_result;

    //mux module & ALU module & SFU module
    alu alu_module( //this alu may contains SFU
        .opcode(s2_opcode),
        .data1(s2_reg_data1),
        .data2(s2_reg_data2),
		.WW(s2_ww),   // fix
        .result(alu_result)
    );

    mux_2 mux_module(
        .data1(dmem_dataOut),
        .data1(alu_result),
        .result(mux_result)
    ); 

    //EXE,MEM/WB register
    always@(posedge clk)begin
        s3_reg_write_en <= s2_reg_writen_en;
        s3_reg_rd_address <= s2_reg_rd_address
        s3_reg_result <= mux_result;
    end


endmodule