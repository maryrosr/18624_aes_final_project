module RotWord
(
    input logic [31:0] key_in,
    output logic [31:0] key_out
);
    assign key_out[31:24] = key_in[23:16];
	assign key_out[23:16] = key_in[15:8];
	assign key_out[15:8]  = key_in[7:0];
	assign key_out[7:0]   = key_in[31:24];
endmodule

module SubWord
(
    input logic [31:0] key_in,
    output logic [31:0] key_out
);

    genvar i;
    generate
        for (i = 0; i < 4; i++) begin : subbytes_gen
            sbox sbox_inst (.in(key_in[8*i+(8-1):i*8]), .out(key_out[8*i+(8-1):i*8]));
        end
    endgenerate


endmodule

module Rcon
(
    input logic [31:0] key_in,
    input logic [3:0] round_num,
    output logic [31:0] key_out
);
    logic [7:0] or_val;
    // assign or_val = (round_num < 4'd9) ? (8'b1 << (round_num-1)) : 
    //                             (round_num == 9) ? 8'h1b : 8'h36;
    assign key_out[31:24] = key_in[31:24] ^ or_val;
    assign key_out[23:0] = key_in[23:0];

    always_comb begin
        or_val = 8'b0;
        case(round_num) 
         4'd1: or_val = 8'h1;
         4'd2: or_val = 8'h2;
         4'd3: or_val = 8'h4;
         4'd4: or_val = 8'h8;
         4'd5: or_val = 8'h10;
         4'd6: or_val = 8'h20;
         4'd7: or_val = 8'h40;
         4'd8: or_val = 8'h80;
         4'd9: or_val = 8'h1b;
         4'd10: or_val = 8'h36;
        endcase
    end

endmodule

module schedule
(
  input logic [3:0] round_num,
  input logic [127:0] key_in,
  output logic [127:0] key_out
);

    logic [31:0] rot_word_out, sub_word_out, rcon_out;

    RotWord rot_word_inst (.key_in(key_in[31:0]), .key_out(rot_word_out));
    SubWord sub_word_inst (.key_in(rot_word_out), .key_out(sub_word_out));
    Rcon rcon_inst (.round_num, .key_in(sub_word_out), .key_out(rcon_out));

    always_comb begin
        key_out[127:96] = key_in[127:96] ^ rcon_out;
        key_out[95:64] = key_in[95:64] ^ key_out[127:96];
        key_out[63:32] = key_in[63:32] ^ key_out[95:64];
        key_out[31:0] = key_in[31:0] ^ key_out[63:32];
    end

endmodule

module InvSchedule
(
  input logic [3:0] round_num,
  input logic [127:0] key_in,
  output logic [127:0] key_out
);

    logic [31:0] rot_word_out, sub_word_out, rcon_out;

    RotWord rot_word_inst (.key_in(key_out[31:0]), .key_out(rot_word_out));
    SubWord sub_word_inst (.key_in(rot_word_out), .key_out(sub_word_out));
    Rcon rcon_inst (.round_num, .key_in(sub_word_out), .key_out(rcon_out));

    assign key_out[95:64] = key_in[95:64] ^ key_in[127:96];
    assign key_out[63:32] = key_in[63:32] ^ key_in[95:64];
    assign key_out[31:0] = key_in[31:0] ^ key_in[63:32];
    // always_comb begin
    //     //key_out[127:96] = key_in[127:96] ^ rcon_out;
    //     key_out[95:64] = key_in[95:64] ^ key_in[127:96];
    //     key_out[63:32] = key_in[63:32] ^ key_in[95:64];
    //     key_out[31:0] = key_in[31:0] ^ key_in[63:32];
    // end

    assign key_out[127:96] = rcon_out ^ key_in[127:96];

endmodule