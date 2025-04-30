module Round
#(parameter WIDTH = 128)
(
    input logic [3:0] round_num, 
    input logic [WIDTH-1:0] round_key_in,
    input logic [WIDTH-1:0] state_in,
    output logic [WIDTH-1:0] state_out,
    output logic [WIDTH-1:0] next_key
);
    
    
    logic [127:0] addRoundKey_out, subbytes_out, shiftrows_out, mixcols_out, round_key;
    InvShiftRows shiftrows_inst (.state_in(state_in), .state_out(shiftrows_out));

    InvSubBytes subbytes_inst (.state_in(shiftrows_out), .state_out(subbytes_out));
    
    assign addRoundKey_out = subbytes_out ^ round_key;

    InvMixColumns mixcolumns_inst (.A_in(addRoundKey_out), .C_out(mixcols_out));


    InvSchedule schedule_inst (.round_num(round_num), .key_in(round_key_in), .key_out(round_key));
    assign state_out = (round_num == 1) ? addRoundKey_out: mixcols_out;
    assign next_key = round_key;
endmodule