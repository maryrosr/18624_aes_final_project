module InvSubBytes 
#(parameter WIDTH = 16)
(
    input logic [WIDTH-1:0] state_in,
    output logic [WIDTH-1:0] state_out
);

    genvar i;
    // creates 16 instances of inv_sbox -> may need to add pipelining if area is an issue
    generate
        for (i = 0; i < 16; i++) begin : subbytes_gen
            InvSbox inv_sbox_inst (.in(state_in[i]), .out(state_out[i]));
        end
    endgenerate

endmodule