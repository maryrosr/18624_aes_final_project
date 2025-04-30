module OutputHandler 
(
    input logic clock, reset,
    input logic index_pins,
    input logic go_btn,
    input logic [15:0]plaintext_out,
    output logic [7:0] out_pins
);

    always_ff @(posedge clock, posedge reset) begin
        if(reset) begin
            out_pins <= 8'b0;
            
        end
        else if (go_btn) begin
            case(index_pins) 
                2'h0: out_pins <= plaintext_out[7:0];
                2'h1: out_pins <= plaintext_out[15:8]; 
            endcase  
        end
    end
endmodule