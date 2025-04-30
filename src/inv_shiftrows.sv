module InvShiftRows 
(
    input logic [15:0] state_in,
    output logic [15:0] state_out
);

    assign state_out[0] = state_in[12]; 
    assign state_out[1] = state_in[9]; 
    assign state_out[2] = state_in[6]; 
    assign state_out[3] = state_in[3];

    assign state_out[4] = state_in[0]; 
    assign state_out[5] = state_in[13];
    assign state_out[6] = state_in[10];
    assign state_out[7] = state_in[7];

    assign state_out[8] = state_in[4]; 
    assign state_out[9] = state_in[1]; 
    assign state_out[10] = state_in[14]; 
    assign state_out[11] = state_in[11]; 

    assign state_out[12] = state_in[8]; 
    assign state_out[13] = state_in[5]; 
    assign state_out[14] = state_in[2]; 
    assign state_out[15] = state_in[15];


endmodule