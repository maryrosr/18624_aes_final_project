module InputHandler 
(
    input logic clk, reset,
    input logic [4:0] index_pins,
    input logic [3:0] info_pins,
    input logic go_btn, key_btn, ciphertext_btn,
    output logic go,
    output logic [127:0] key_in, ciphertext_in
);
    always_ff @(posedge clk, posedge reset) begin
        if(reset) begin
            go <= 1'b0;
            key_in = 128'b0;
            ciphertext_in = 128'b0;
        end
        else if (go_btn) begin
            go <= 1'b1;
        end
        else if (key_btn) begin
            case(index_pins) 
                5'h0: key_in[3:0] <= info_pins;
                5'h1: key_in[7:4] <= info_pins; 
                5'h2: key_in[11:8] <= info_pins;
                5'h3: key_in[15:12] <= info_pins;
                5'h4: key_in[19:16] <= info_pins;
                5'h5: key_in[23:20] <= info_pins;
                5'h6: key_in[27:24] <= info_pins;
                5'h7: key_in[31:28] <= info_pins;
                5'h8: key_in[35:32] <= info_pins;
                5'h9: key_in[39:36] <= info_pins;
                5'hA: key_in[43:40] <= info_pins;
                5'hB: key_in[47:44] <= info_pins;
                5'hC: key_in[51:48] <= info_pins;
                5'hD: key_in[55:52] <= info_pins;
                5'hE: key_in[59:56] <= info_pins;
                5'hF: key_in[63:60] <= info_pins;
                5'h10: key_in[67:64] <= info_pins;
                5'h11: key_in[71:68] <= info_pins; 
                5'h12: key_in[75:72] <= info_pins;
                5'h13: key_in[79:76] <= info_pins;
                5'h14: key_in[83:80] <= info_pins;
                5'h15: key_in[87:84] <= info_pins;
                5'h16: key_in[91:88] <= info_pins;
                5'h17: key_in[95:92] <= info_pins;
                5'h18: key_in[99:96] <= info_pins;
                5'h19: key_in[103:100] <= info_pins;
                5'h1A: key_in[107:104] <= info_pins;
                5'h1B: key_in[111:108] <= info_pins;
                5'h1C: key_in[115:112] <= info_pins;
                5'h1D: key_in[119:116] <= info_pins;
                5'h1E: key_in[123:120] <= info_pins;
                5'h1F: key_in[127:124] <= info_pins;

            endcase
        end
        else if (ciphertext_btn) begin
            case(index_pins) 
                5'h0:  ciphertext_in[3:0] <= info_pins;
                5'h1:  ciphertext_in[7:4] <= info_pins; 
                5'h2:  ciphertext_in[11:8] <= info_pins;
                5'h3:  ciphertext_in[15:12] <= info_pins;
                5'h4:  ciphertext_in[19:16] <= info_pins;
                5'h5:  ciphertext_in[23:20] <= info_pins;
                5'h6:  ciphertext_in[27:24] <= info_pins;
                5'h7:  ciphertext_in[31:28] <= info_pins;
                5'h8:  ciphertext_in[35:32] <= info_pins;
                5'h9:  ciphertext_in[39:36] <= info_pins;
                5'hA:  ciphertext_in[43:40] <= info_pins;
                5'hB:  ciphertext_in[47:44] <= info_pins;
                5'hC:  ciphertext_in[51:48] <= info_pins;
                5'hD:  ciphertext_in[55:52] <= info_pins;
                5'hE:  ciphertext_in[59:56] <= info_pins;
                5'hF:  ciphertext_in[63:60] <= info_pins;
                5'h10: ciphertext_in[67:64] <= info_pins;
                5'h11: ciphertext_in[71:68] <= info_pins; 
                5'h12: ciphertext_in[75:72] <= info_pins;
                5'h13: ciphertext_in[79:76] <= info_pins;
                5'h14: ciphertext_in[83:80] <= info_pins;
                5'h15: ciphertext_in[87:84] <= info_pins;
                5'h16: ciphertext_in[91:88] <= info_pins;
                5'h17: ciphertext_in[95:92] <= info_pins;
                5'h18: ciphertext_in[99:96] <= info_pins;
                5'h19: ciphertext_in[103:100] <= info_pins;
                5'h1A: ciphertext_in[107:104] <= info_pins;
                5'h1B: ciphertext_in[111:108] <= info_pins;
                5'h1C: ciphertext_in[115:112] <= info_pins;
                5'h1D: ciphertext_in[119:116] <= info_pins;
                5'h1E: ciphertext_in[123:120] <= info_pins;
                5'h1F: ciphertext_in[127:124] <= info_pins;
            endcase
        end
    end
endmodule
