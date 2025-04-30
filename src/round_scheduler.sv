module key_scheduler 
(
    input logic clock, reset,
    input logic go, 
    input logic [15:0] key_in,
    output logic  [175:0] keys_out,
    output logic aes_go
);
    logic [3:0] round_num;
    logic [15:0] key_out, new_key;
    schedule scheduler( .round_num, .key_in(new_key), .key_out);
    always_ff @(posedge clock, posedge reset) begin
        if(reset) begin
            aes_go <= 1'b0;
            round_num <= 0;
            keys_out[175:0] <= 176'b0;
            
        end
        else if (go && round_num == 0) begin
            round_num <= round_num + 1;
            new_key <= key_in;
            keys_out[15:0] <= key_in;

        end
        else if (round_num >= 1 && round_num <= 10) begin
            round_num <= round_num + 1;
            case(round_num)
                4'd1: keys_out[31:16] <= key_out;
                4'd2: keys_out[47:32] <= key_out;
                4'd3: keys_out[63:48] <= key_out;
                4'd4: keys_out[79:64] <= key_out;
                4'd5: keys_out[95:80] <= key_out;
                4'd6: keys_out[111:96] <= key_out;
                4'd7: keys_out[127:112] <= key_out;
                4'd8: keys_out[143:128] <= key_out;
                4'd9: keys_out[159:144] <= key_out;
                4'd10: keys_out[175:160] <= key_out;
            endcase
            new_key <= key_out;
        end
        else if (round_num == 11) begin
            aes_go <= 1'b1;
        end
    end
endmodule