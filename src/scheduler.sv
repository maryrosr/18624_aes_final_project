module RotWord
(
    input logic [3:0] key_in,
    output logic [3:0] key_out
);
    assign key_out[3] = key_in[2];
	assign key_out[2] = key_in[1];
	assign key_out[1]  = key_in[0];
	assign key_out[0]   = key_in[3];
endmodule

module SubWord
(
    input logic [3:0] key_in,
    output logic [3:0] key_out
);

    genvar i;
    generate
        for (i = 0; i < 4; i++) begin : subbytes_gen
            sbox sbox_inst (.in(key_in[i]), .out(key_out[i]));
        end
    endgenerate


endmodule

module Rcon
(
    input logic [3:0] key_in,
    input logic [3:0] round_num,
    output logic [3:0] key_out
);
    logic [3:0] or_val;
    
    assign key_out = key_in ^ round_num;

endmodule

module schedule
(
  input logic [3:0] round_num,
  input logic [15:0] key_in,
  output logic [15:0] key_out
);

    logic [3:0] rot_word_out, sub_word_out, rcon_out;

    RotWord rot_word_inst (.key_in(key_in[3:0]), .key_out(rot_word_out));
    SubWord sub_word_inst (.key_in(rot_word_out), .key_out(sub_word_out));
    Rcon rcon_inst (.round_num, .key_in(sub_word_out), .key_out(rcon_out));

    always_comb begin
        key_out[15:12] = key_in[15:12] ^ rcon_out;
        key_out[11:8] = key_in[11:8] ^ key_out[15:12];
        key_out[7:4] = key_in[7:4] ^ key_out[11:8];
        key_out[3:0] = key_in[3:0] ^ key_out[7:4];
    end

endmodule
