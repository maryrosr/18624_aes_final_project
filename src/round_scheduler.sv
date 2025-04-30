module key_scheduler 
(
    input logic clock, reset,
    input logic go, 
    input logic [127:0] key_in,
    output logic  [1407:0] keys_out,
    output logic aes_go
);
    logic [3:0] round_num;
    logic [127:0] key_out, new_key;
    schedule scheduler( .round_num, .key_in(new_key), .key_out);
    always_ff @(posedge clock, posedge reset) begin
        if(reset) begin
            aes_go <= 1'b0;
            round_num <= 0;
            keys_out[127:0] <= 128'b0;
            keys_out[255:128] <= 128'b0;
            keys_out[383:256] <= 128'b0;
            keys_out[511:384] <= 128'b0;
            keys_out[639:512] <= 128'b0;
            keys_out[767:640] <= 128'b0;
            keys_out[895:768] <= 128'b0;
            keys_out[1023:896] <= 128'b0;
            keys_out[1151:1024] <= 128'b0;
            keys_out[1279:1152] <= 128'b0;
            keys_out[1407:1280] <= 128'b0;
        end
        else if (go && round_num == 0) begin
            round_num <= round_num + 1;
            new_key <= key_in;
            keys_out[127:0] <= key_in;

        end
        else if (round_num >= 1 && round_num <= 10) begin
            round_num <= round_num + 1;
            case(round_num)
                4'd1: keys_out[255:128] <= key_out;
                4'd2: keys_out[383:256] <= key_out;
                4'd3: keys_out[511:384] <= key_out;
                4'd4: keys_out[639:512] <= key_out;
                4'd5: keys_out[767:640] <= key_out;
                4'd6: keys_out[895:768] <= key_out;
                4'd7: keys_out[1023:896] <= key_out;
                4'd8: keys_out[1151:1024] <= key_out;
                4'd9: keys_out[1279:1152] <= key_out;
                4'd10: keys_out[1407:1280] <= key_out;
            endcase
            new_key <= key_out;
        end
        else if (round_num == 11) begin
            aes_go <= 1'b1;
        end
    end
endmodule