module aes 
#(parameter WIDTH = 128)
(
    input logic clk,
    input logic reset,
    input logic go,
    input logic [WIDTH-1:0] ciphertext,
    input logic [WIDTH*11-1:0] keys,
    output logic [WIDTH-1:0] plaintext,
    output logic ready
);

    logic [127:0] state_out, round_key_out, state_in;
    logic [127:0] round_key_in;
    logic [3:0] round_num;    
    
    Round round_key_inst (.round_keys_in(keys), .state_in(plaintext), .state_out(state_out), .round_num(round_num));
    logic going;
    always_ff @(posedge clk, posedge reset) begin
        if(reset) begin
            plaintext <= 128'b0;
            round_num <= 4'd10;
            round_key_in <= 128'b0;
            ready <= 1'b0;
            going <= 1'b0;
        end
        
        else if(go && ~going) begin
            plaintext <= ciphertext ^ keys[1407:1280];
            ready <= 1'b0;
            going <= 1'b1;
        end
        else if(going && round_num > 4'd0 && plaintext != 128'b0) begin
            plaintext <= state_out;
            round_num <= round_num - 1;
        end
        else if(round_num == 4'b0) begin
            ready <= 1'b1;
        end
    end

endmodule

