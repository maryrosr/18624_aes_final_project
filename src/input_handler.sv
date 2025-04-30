module InputHandler 
(
    input logic clock, reset,
    input logic index_pins,
    input logic [7:0] info_pins,
    input logic go_btn, key_btn, ciphertext_btn,
    output logic go,
    output logic [15:0] key_in, ciphertext_in
);
    always_ff @(posedge clock, posedge reset) begin
        if(reset) begin
            go <= 1'b0;
            key_in = 16'b0;
            ciphertext_in = 16'b0;
        end
        else if (go_btn) begin
            go <= 1'b1;
        end
        else if (key_btn) begin
            case(index_pins) 
                2'h0: key_in[7:0] <= info_pins;
                2'h1: key_in[15:8] <= info_pins; 
            endcase
        end
        else if (ciphertext_btn) begin
            case(index_pins) 
                5'h0:  ciphertext_in[7:0] <= info_pins;
                5'h1:  ciphertext_in[15:8] <= info_pins; 
            endcase
        end
    end
endmodule
