module program_counter (
    input clk,
    input reset,
    input branch_en,
    input [15:0] branch_target,
    output reg [31:0] ins_address
);

    always @(posedge clk) begin 
        if (reset) begin
            ins_address <= 32'b0;
        end else if (branch_en) begin
            ins_address <= branch_target;
        end else begin
            ins_address <= ins_address + 4;
        end
    end

endmodule
