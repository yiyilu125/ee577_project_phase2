
module hdu # (
    parameter REG_ADDRESS_LENGTH = 5;
    parameter OPCODE_LENGTH = 5;
)(
    input [REG_ADDRESS_LENGTH-1:0] current_RA, current_RB, Lasttime_RD,
    // input [OPCODE_LENGTH-1:0] opcode,
    // output stall,
    output mux_ctrl_rA,
    output mux_ctrl_rB
);
    assign mux_ctrl_rA = (current_RA == Lasttime_RD) ? 1 : 0;
    assign mux_ctrl_rB = (current_RB == Lasttime_RD) ? 1 : 0;
endmodule
