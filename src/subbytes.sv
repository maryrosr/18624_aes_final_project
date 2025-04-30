module InvSubBytes 
#(parameter WIDTH = 128, parameter num_gen = WIDTH/8)
(
    input logic [WIDTH-1:0] state_in,
    output logic [WIDTH-1:0] state_out
);

    genvar i;
    // creates 16 instances of inv_sbox -> may need to add pipelining if area is an issue
    generate
        for (i = 0; i < 16; i++) begin : subbytes_gen
            InvSbox inv_sbox_inst (.in(state_in[8*i+(8-1):i*8]), .out(state_out[8*i+(8 -1):i*8]));
        end
    endgenerate

endmodule