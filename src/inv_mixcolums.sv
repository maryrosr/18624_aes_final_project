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
    input logic [127:0] A_in,
    output logic [127:0] C_out
);

    logic [7:0]a1_a, a2_a, a3_a, a4_a;
    logic [7:0]a1_b, a2_b, a3_b, a4_b;
    logic [7:0]a1_c, a2_c, a3_c, a4_c;
    logic [7:0]a1_d, a2_d, a3_d, a4_d;

    logic [7:0]c1_a, c2_a, c3_a, c4_a;
    logic [7:0]c1_b, c2_b, c3_b, c4_b;
    logic [7:0]c1_c, c2_c, c3_c, c4_c;
    logic [7:0]c1_d, c2_d, c3_d, c4_d;



    // maps input matrix to byte chunks
    assign a4_d = A_in[7:0];
    assign a4_c = A_in[15:8];
    assign a4_b = A_in[23:16];
    assign a4_a = A_in[31:24];
    assign a3_d = A_in[39:32];
    assign a3_c = A_in[47:40];
    assign a3_b = A_in[55:48];
    assign a3_a = A_in[63:56];
    assign a2_d = A_in[71:64];
    assign a2_c = A_in[79:72];
    assign a2_b = A_in[87:80];
    assign a2_a = A_in[95:88];
    assign a1_d = A_in[103:96];
    assign a1_c = A_in[111:104];
    assign a1_b = A_in[119:112];
    assign a1_a = A_in[127:120];



    // First row of output matrix:
    first_row first_row_inst1 (.a_in1(a1_a), .a_in2(a1_b), .a_in3(a1_c), .a_in4(a1_d), .a_out(c1_a));
    first_row first_row_inst2 (.a_in1(a2_a), .a_in2(a2_b), .a_in3(a2_c), .a_in4(a2_d), .a_out(c2_a));
    first_row first_row_inst3 (.a_in1(a3_a), .a_in2(a3_b), .a_in3(a3_c), .a_in4(a3_d), .a_out(c3_a));
    first_row first_row_inst4 (.a_in1(a4_a), .a_in2(a4_b), .a_in3(a4_c), .a_in4(a4_d), .a_out(c4_a));


    // Second row of output matrix:
    second_row second_row_inst1 (.a_in1(a1_a), .a_in2(a1_b), .a_in3(a1_c), .a_in4(a1_d), .a_out(c1_b));
    second_row second_row_inst2 (.a_in1(a2_a), .a_in2(a2_b), .a_in3(a2_c), .a_in4(a2_d), .a_out(c2_b));
    second_row second_row_inst3 (.a_in1(a3_a), .a_in2(a3_b), .a_in3(a3_c), .a_in4(a3_d), .a_out(c3_b));
    second_row second_row_inst4 (.a_in1(a4_a), .a_in2(a4_b), .a_in3(a4_c), .a_in4(a4_d), .a_out(c4_b));
      
    // Third row of output matrix:
    third_row third_row_inst1 (.a_in1(a1_a), .a_in2(a1_b), .a_in3(a1_c), .a_in4(a1_d), .a_out(c1_c));
    third_row third_row_inst2 (.a_in1(a2_a), .a_in2(a2_b), .a_in3(a2_c), .a_in4(a2_d), .a_out(c2_c));
    third_row third_row_inst3 (.a_in1(a3_a), .a_in2(a3_b), .a_in3(a3_c), .a_in4(a3_d), .a_out(c3_c));
    third_row third_row_inst4 (.a_in1(a4_a), .a_in2(a4_b), .a_in3(a4_c), .a_in4(a4_d), .a_out(c4_c));

    // Fourth row of output matrix:
    fourth_row fourth_row_inst1 (.a_in1(a1_a), .a_in2(a1_b), .a_in3(a1_c), .a_in4(a1_d), .a_out(c1_d));
    fourth_row fourth_row_inst2 (.a_in1(a2_a), .a_in2(a2_b), .a_in3(a2_c), .a_in4(a2_d), .a_out(c2_d));
    fourth_row fourth_row_inst3 (.a_in1(a3_a), .a_in2(a3_b), .a_in3(a3_c), .a_in4(a3_d), .a_out(c3_d));
    fourth_row fourth_row_inst4 (.a_in1(a4_a), .a_in2(a4_b), .a_in3(a4_c), .a_in4(a4_d), .a_out(c4_d));
    
    assign C_out[7:0] = c4_d;
    assign C_out[15:8] = c4_c;
    assign C_out[23:16] = c4_b;
    assign C_out[31:24] = c4_a;

    assign C_out[39:32] = c3_d;
    assign C_out[47:40] = c3_c;
    assign C_out[55:48] = c3_b;
    assign C_out[63:56] = c3_a;

    assign C_out[71:64] = c2_d;
    assign C_out[79:72] = c2_c;
    assign C_out[87:80] = c2_b;
    assign C_out[95:88] = c2_a;

    assign C_out[103:96] = c1_d;
    assign C_out[111:104] = c1_c;
    assign C_out[119:112] = c1_b;
    assign C_out[127:120] = c1_a;



endmodule

