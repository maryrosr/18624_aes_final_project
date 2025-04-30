module mult_2
(input logic [7:0] a_in, 
output logic [7:0] a_out);


    assign a_out = (~a_in[7]) ? a_in << 1 : (a_in << 1) ^ 8'b00011011;

endmodule

module mult_9
(input logic [7:0] a_in,
output logic [7:0] a_out);

    logic [7:0] out_1, out_2, out_3;
    mult_2 mult2_inst_1 (.a_in, .a_out(out_1));
    mult_2 mult2_inst_2 (.a_in(out_1), .a_out(out_2));
    mult_2 mult2_inst_3 (.a_in(out_2), .a_out(out_3));

    assign a_out = out_3 ^ a_in;

endmodule

module mult_11
(input logic [7:0] a_in,
output logic [7:0] a_out);

    logic [7:0] out_1, out_2, out_3, out_4;

    mult_2 mult2_inst_1 (.a_in, .a_out(out_1));
    mult_2 mult2_inst_2 (.a_in(out_1), .a_out(out_2));
    assign out_3 = out_2 ^ a_in;
    mult_2 mult2_inst_3 (.a_in(out_3), .a_out(out_4));
    assign a_out = out_4 ^ a_in;



endmodule

module mult_13
(input logic [7:0] a_in,
output logic [7:0] a_out);
    
    logic [7:0] out_1, out_2, out_3, out_4;

    mult_2 mult2_inst_1 (.a_in, .a_out(out_1));
    assign out_2 = out_1 ^ a_in;
    mult_2 mult2_inst_2 (.a_in(out_2), .a_out(out_3));
    mult_2 mult2_inst_3 (.a_in(out_3), .a_out(out_4));
    assign a_out = out_4 ^ a_in;
    

endmodule

module mult_14
(input logic [7:0] a_in,
output logic [7:0] a_out);

    logic [7:0] out_1, out_2, out_3, out_4;
    
    mult_2 mult2_inst_1 (.a_in, .a_out(out_1));
    assign out_2 = out_1 ^ a_in;
    mult_2 mult2_inst_2 (.a_in(out_2), .a_out(out_3));
    assign out_4 = out_3 ^ a_in;
    mult_2 mult2_inst_3 (.a_in(out_4), .a_out(a_out));
endmodule


module first_row
(
    input logic [7:0] a_in1, a_in2, a_in3, a_in4,
    output logic [7:0] a_out
);

    logic [7:0] res1, res2, res3, res4;
    mult_14 mult_14_inst (.a_in(a_in1), .a_out(res1));
    mult_11 mult_11_inst (.a_in(a_in2), .a_out(res2));
    mult_13 mult_13_inst (.a_in(a_in3), .a_out(res3));
    mult_9 mult_9_inst (.a_in(a_in4), .a_out(res4));

    assign a_out = res1 ^ res2 ^ res3 ^ res4;

endmodule

module second_row
(
    input logic [7:0] a_in1, a_in2, a_in3, a_in4,
    output logic [7:0] a_out
);

    logic [7:0] res1, res2, res3, res4;
    mult_9 mult_9_inst (.a_in(a_in1), .a_out(res1));
    mult_14 mult_14_inst (.a_in(a_in2), .a_out(res2));
    mult_11 mult_11_inst (.a_in(a_in3), .a_out(res3));
    mult_13 mult_13_inst (.a_in(a_in4), .a_out(res4));
    assign a_out = res1 ^ res2 ^ res3 ^ res4;

endmodule

module third_row
(
    input logic [7:0] a_in1, a_in2, a_in3, a_in4,
    output logic [7:0] a_out
);
    logic [7:0] res1, res2, res3, res4;
    mult_13 mult_13_inst (.a_in(a_in1), .a_out(res1));
    mult_9 mult_9_inst (.a_in(a_in2), .a_out(res2));
    mult_14 mult_14_inst (.a_in(a_in3), .a_out(res3));
    mult_11 mult_11_inst (.a_in(a_in4), .a_out(res4));
    assign a_out = res1 ^ res2 ^ res3 ^ res4;


endmodule

module fourth_row
(
    input logic [7:0] a_in1, a_in2, a_in3, a_in4,
    output logic [7:0] a_out
);
    logic [7:0] res1, res2, res3, res4;
    mult_11 mult_11_inst (.a_in(a_in1), .a_out(res1));
    mult_13 mult_13_inst (.a_in(a_in2), .a_out(res2));
    mult_9 mult_9_inst (.a_in(a_in3), .a_out(res3));
    mult_14 mult_14_inst (.a_in(a_in4), .a_out(res4));
    assign a_out = res1 ^ res2 ^ res3 ^ res4;

endmodule


module InvMixColumns 
(
    input logic [15:0] A_in,
    output logic [15:0] C_out
);

    

    mult_9 mult_inst_1 (.a_in(A_in[15:8]), .a_out(C_out[15:8]));

    mult_14 mult_inst_2 (.a_in(A_in[7:0]), .a_out(C_out[7:0]));



    
    


endmodule

