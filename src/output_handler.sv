module OutputHandler 
(
    input logic clock, reset,
    input logic [3:0] index_pins,
    input logic go_btn,
    input logic [127:0]plaintext_out,
    output logic [7:0] out_pins
);

    always_ff @(posedge clock, posedge reset) begin
        if(reset) begin
            out_pins <= 12'b0;
            
        end
        else if (go_btn) begin
            case(index_pins) 
                4'h0: out_pins <= plaintext_out[7:0];
                4'h1: out_pins <= plaintext_out[15:8]; 
                4'h2: out_pins <= plaintext_out[23:16];
                4'h3: out_pins <= plaintext_out[31:24];
                4'h4: out_pins <= plaintext_out[39:32];
                4'h5: out_pins <= plaintext_out[47:40];
                4'h6: out_pins <= plaintext_out[55:48];
                4'h7: out_pins <= plaintext_out[63:56];
                4'h8: out_pins <= plaintext_out[71:64];
                4'h9: out_pins <= plaintext_out[79:72];
                4'hA: out_pins <= plaintext_out[87:80];
                4'hB: out_pins <= plaintext_out[95:88];
                4'hC: out_pins <= plaintext_out[103:96];
                4'hD: out_pins <= plaintext_out[111:104];
                4'hE: out_pins <= plaintext_out[119:112];
                4'hF: out_pins <= plaintext_out[127:120];
            endcase  
        end
    end
endmodule