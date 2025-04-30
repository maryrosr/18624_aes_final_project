module my_chip
(
    input logic clk, reset,
    input logic [11:0] io_in,
    output logic [11:0] io_out,
);
    logic go;
    logic go_btn, key_btn, ciphertext_btn;
    assign go_btn = io_in[11];
    assign key_btn = io_in[10];
    assign ciphertext_btn = io_in[9];
    logic [127:0] key_in, ciphertext_in, plaintext_out;
    InputHandler input_handler_inst(.clk, .reset, .index_pins(io_in[8:4]), .info_pins(io_in[3:0]), .go_btn, .key_btn, .ciphertext_btn, .go, .key_in, .ciphertext_in);
    aes aes_inst(.clk(clk), .ready(io_out[11]), .reset(reset), .go(go), .plaintext(plaintext_out), .key(key_in), .ciphertext(ciphertext_in));
    OutputHandler output_handler_inst(.clk, .reset, .index_pins(io_in[8:5]), .go_btn, .plaintext_out .out_pins(io_out[7:0]));

endmodule