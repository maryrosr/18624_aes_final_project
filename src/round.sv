module Round
#(parameter WIDTH = 128)
(
    input logic [3:0] round_num, 
    input logic [10:0] [WIDTH-1:0] round_keys_in,
    input logic [WIDTH-1:0] state_in,
    output logic [WIDTH-1:0] state_out
    //output logic [WIDTH-1:0] next_key
);
    
    
    logic [127:0] addRoundKey_out, subbytes_out, shiftrows_out, mixcols_out, round_key;
    InvShiftRows shiftrows_inst (.state_in(state_in), .state_out(shiftrows_out));

    InvSubBytes subbytes_inst (.state_in(shiftrows_out), .state_out(subbytes_out));
    
    always_comb begin
        round_key = 128'hDEADBEEF;
        case(round_num)
            4'd1: round_key = round_keys_in[0];
            4'd2: round_key = round_keys_in[1];
            4'd3: round_key = round_keys_in[2];
            4'd4: round_key = round_keys_in[3];
            4'd5: round_key = round_keys_in[4];
            4'd6: round_key = round_keys_in[5];
            4'd7: round_key = round_keys_in[6];
            4'd8: round_key = round_keys_in[7];
            4'd9: round_key = round_keys_in[8];
            4'd10:round_key = round_keys_in[9];
        endcase
    end
    assign addRoundKey_out = subbytes_out ^ round_key;

    InvMixColumns mixcolumns_inst (.A_in(addRoundKey_out), .C_out(mixcols_out));


    //InvSchedule schedule_inst (.round_num(round_num), .key_in(round_key_in), .key_out(round_key));
    assign state_out = (round_num == 1) ? addRoundKey_out: mixcols_out;
    //assign next_key = round_key;
endmodule