module register_file (
    input clk,
    input reset,
    input [4:0] read_address1,
    input [4:0] read_address2,    
    input writen_en,               // write back enable
    input [4:0] write_address,     // 5-bit address for 32 registers
    input [63:0] data_in,
    input [2:0] ppp,                // participation bits
    output reg [63:0] data_out1,
    output reg [63:0] data_out2
);

    integer i;                    // loop variable
    reg [63:0] regfile [0:31];    // 32 x 64-bit register file

    // Read logic (combinational)
    always @(*) begin
        if (writen_en && (write_address == read_address1)) begin
            data_out1 = data_in;
        end else begin
            data_out1 = regfile[read_address1];
        end

        if (writen_en && (write_address == read_address2)) begin
            data_out2 = data_in;
        end else begin 
            data_out2 = regfile[read_address2];
        end
    end

    // Write logic (sequential with sync reset)
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                regfile[i] <= 64'b0;
            end
        end else if (writen_en && write_address != 5'b00000) begin
			case (ppp) 
                3'b000: begin 
					$display("test");
                    regfile[write_address] <= data_in;
                end
                3'b001: begin
                    regfile[write_address][63:32] <= data_in[63:32];
                end
                3'b010: begin
                    regfile[write_address][31:0] <= data_in[31:0];
                end
                3'b011: begin
                    regfile[write_address][63:56] <= data_in[63:56];
                    regfile[write_address][47:40] <= data_in[47:40];
                    regfile[write_address][31:24] <= data_in[31:24];
                    regfile[write_address][15:8 ] <= data_in[15:8 ];
                end
                3'b100: begin
                    regfile[write_address][55:48] <= data_in[55:48];
                    regfile[write_address][39:32] <= data_in[39:32];
                    regfile[write_address][23:16] <= data_in[23:16];
                    regfile[write_address][7 :0 ] <= data_in[7 :0 ];
                end
            endcase
        end 
    end

endmodule
