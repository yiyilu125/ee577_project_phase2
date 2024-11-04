module mux_2 #(
    parameter LENGTH = 32
)(
    input [LENGTH-1:0] in0, in1,
    input select,
    output [LENGTH-1:0] out
);
    assign out = (select == 0) ? in0 : in1;
endmodule
