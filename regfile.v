module register_file (
    input clk,
    input reset,
    input [4:0] read_address1,
    input [4:0] read_address2,    
    input write_en,               // write back enable
    input [4:0] write_address,     // 5-bit address for 32 registers
    input [63:0] data_in,
    output reg [63:0] data_out1,
    output reg [63:0] data_out2
);

    integer i;                    // loop variable
    reg [63:0] regfile [0:31];    // 32 x 64-bit register file

    // Read logic (combinational)
    always @(*) begin
        data_out1 = regfile[read_address1];
        data_out2 = regfile[read_address2];
    end

    // Write logic (sequential with sync reset)
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                regfile[i] <= 64'b0;
            end
        end else if (write_en && write_address != 5'b00000) begin
            regfile[write_address] <= data_in;
        end 
    end

endmodule