module key_scheduler 
(
    input logic clk, reset
    input logic go, 
    input logic [127:0] key_in,
    output logic [8:0] [127:0] keys_out,
    output logic aes_go
);
    logic [3:0] round_num;
    schedule scheduler( .round_num, .key_in, .key_out);
    always_ff @(posedge clk, posedge reset) begin
        if(reset) begin
            aes_go <= 1'b0;
            keys_out <= 'b0;
            round_num <= 1;
        end
        else if (go && round_num <= 10) begin
            round_num <= round_num + 1;
            case(round_num)
                4'd1: keys_out[0] <= key_out;
                4'd2: keys_out[1] <= key_out;
                4'd3: keys_out[2] <= key_out;
                4'd4: keys_out[3] <= key_out;
                4'd5: keys_out[4] <= key_out;
                4'd6: keys_out[5] <= key_out;
                4'd7: keys_out[6] <= key_out;
                4'd8: keys_out[7] <= key_out;
                4'd9: keys_out[8] <= key_out;
                4'd10: keys_out[9] <= key_out;
            endcase
            key_in <= key_out;
        end
        else if (round_num == 11) begin
            aes_go <= 1'b1;
        end
    end
endmodule