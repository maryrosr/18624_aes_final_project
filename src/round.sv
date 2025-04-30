module Round
#(parameter WIDTH = 128)
(
    input logic [3:0] round_num, 
    input logic  [WIDTH*11-1:0] round_keys_in,
    input logic [WIDTH-1:0] state_in,
    output logic [WIDTH-1:0] state_out
);
    
    
    logic [127:0] addRoundKey_out, subbytes_out, shiftrows_out, mixcols_out, round_key;
    InvShiftRows shiftrows_inst (.state_in(state_in), .state_out(shiftrows_out));

    InvSubBytes subbytes_inst (.state_in(shiftrows_out), .state_out(subbytes_out));
    
    always_comb begin
        round_key = 128'hDEADBEEF;
        case(round_num)
            4'd1: round_key = round_keys_in[127:0];
            4'd2: round_key = round_keys_in[255:128];
            4'd3: round_key = round_keys_in[383:256];
            4'd4: round_key = round_keys_in[511:384];
            4'd5: round_key = round_keys_in[639:512];
            4'd6: round_key = round_keys_in[767:640];
            4'd7: round_key = round_keys_in[895:768];
            4'd8: round_key = round_keys_in[1023:896];
            4'd9: round_key = round_keys_in[1151:1024];
            4'd10:round_key = round_keys_in[1279:1152];
        endcase
    end
    assign addRoundKey_out = subbytes_out ^ round_key;

    InvMixColumns mixcolumns_inst (.A_in(addRoundKey_out), .C_out(mixcols_out));


    assign state_out = (round_num == 1) ? addRoundKey_out: mixcols_out;
endmodule