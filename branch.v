module branch (
    input clk,
    input reset,
    input [1:0] branch,             // 2-bit branch signal: 00 or 01 for No Branch, 10 for BEZ, 11 for BNEZ
    input [15:0] branch_target,     // Target address for the branch
    input [63:0] data_branch,       // Data from register to check for branch condition
    output reg [15:0] target_address, // Address to jump to if branch is taken
    output reg taken,               // Indicates if branch is taken
    output reg flush                // Flush signal if branch is taken
);

    always @(*) begin
        if (reset) begin
            taken = 0;
            flush = 0;
            target_address = 0;
        end else begin
            // Default values when no branch is taken
            taken = 0;
            flush = 0;
            target_address = 0;

            // Branch conditions
            case (branch) 
                2'b10: begin // BEZ operation
                    if (data_branch == 0) begin
                        taken = 1;
                        flush = 1;
                        target_address = branch_target;
                    end
                end
                2'b11: begin // BNEZ operation
                    if (data_branch != 0) begin
                        taken = 1;
                        flush = 1;
                        target_address = branch_target;
                    end
                end
                default: begin
                    // No branch operation (branch == 2'b00 or 2'b01)
                    // taken and flush are already set to 0 by default
                end
            endcase
        end
    end

endmodule
