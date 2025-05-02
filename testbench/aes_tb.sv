module aes_tb();

    logic clock, reset;
    logic [15:0] key_in;
    
    logic [15:0] plaintext, ciphertext_in, plaintext_check, temp_key, round_out, round_in, addKey, initial_addKey, temp1_key;
    logic [3:0] rot;
    logic [11:0] io_in, io_out;
  logic [10:0] [15:0] keys_out;
    my_chip DUT (.clock, .reset, .io_in, .io_out);
initial begin
  $dumpfile("dump.vcd");
  $dumpvars(0, aes_tb);
end
task golden_model(output logic [15:0] key_in, output logic [15:0] ciphertext_in, output logic [15:0] plaintext_check);
    
    // generating keys:
    keys_out = 0;
    key_in = $urandom % 65536; // can choose a value as well
    keys_out[0] = key_in;
    temp1_key = key_in;
    
    for (int i = 1; i < 11; i++) begin
        // rotate:
        rot[3] = key_in[2];
        rot[2] = key_in[1];
        rot[1] = key_in[0];
        rot[0] = key_in[3];
        //subword:
        rot = ~rot;
        rot = rot ^ i;
        temp_key[15:12] = key_in[15:12] ^ rot;
        temp_key[11:8] = key_in[11:8] ^ temp_key[15:12];
        temp_key[7:4] = key_in[7:4] ^ temp_key[11:8];
        temp_key[3:0] = key_in[3:0] ^ temp_key[7:4];
        keys_out[i] = temp_key;
        key_in = temp_key;
      $display("key %d %h", i, key_in);
    end
    // AES:
    ciphertext_in = $urandom % 65536; // can also choose value
  $display("Cipher %h", ciphertext_in);
	key_in = temp1_key;

  round_in = ciphertext_in ^ keys_out[10];
  $display("round_in %h %h", round_in, keys_out[10]);

    for (int i = 10; i > 0; i-- ) begin
        // InvShift
        round_out[0] = round_in[12]; 
        round_out[1] = round_in[9]; 
        round_out[2] = round_in[6]; 
        round_out[3] = round_in[3];

        round_out[4] = round_in[0]; 
        round_out[5] = round_in[13];
        round_out[6] = round_in[10];
        round_out[7] = round_in[7];

        round_out[8] = round_in[4]; 
        round_out[9] = round_in[1]; 
        round_out[10] = round_in[14]; 
        round_out[11] = round_in[11]; 

        round_out[12] = round_in[8]; 
        round_out[13] = round_in[5]; 
        round_out[14] = round_in[2]; 
        round_out[15] = round_in[15];
        $display("shift %d %h", i , round_out);

        // subbytes:
        round_out = ~round_out;
        $display("sub %d %h", i , round_out);

        addKey = round_out ^ keys_out[i-1];
        $display("addKey %d %h", i , addKey);

        initial_addKey = addKey;
        // mix cols:
        // Multiply upper half by 9:
        if(~addKey[15]) // mult 1
            addKey[15:8] = addKey[15:8] << 1;
        else 
            addKey[15:8] = (addKey[15:8] << 1) ^ 8'b00011011;
        if(~addKey[15]) // mult2
            addKey[15:8] = addKey[15:8] << 1;
        else 
            addKey[15:8] = (addKey[15:8] << 1) ^ 8'b00011011;
        if(~addKey[15]) // mult3
            addKey[15:8] = addKey[15:8] << 1;
        else 
            addKey[15:8] = (addKey[15:8] << 1) ^ 8'b00011011;
      addKey[15:8] = addKey[15:8] ^ initial_addKey[15:8];
        
        // 14:
        if(~addKey[7]) // mult 1
            addKey[7:0] = addKey[7:0] << 1;
        else 
            addKey[7:0] = (addKey[7:0] << 1) ^ 8'b00011011;

      addKey[7:0] = addKey[7:0] ^ initial_addKey[7:0];
        if(~addKey[7]) // mult 1
            addKey[7:0] = addKey[7:0] << 1;
        else 
            addKey[7:0] = (addKey[7:0] << 1) ^ 8'b00011011;

      addKey[7:0] = addKey[7:0] ^ initial_addKey[7:0];
        if(~addKey[7]) // mult 1
            addKey[7:0] = addKey[7:0] << 1;
        else 
            addKey[7:0] = (addKey[7:0] << 1) ^ 8'b00011011;
        
        $display("mix cols %d %h", i, addKey);


      round_out = (i == 1) ? initial_addKey: addKey;
        round_in = round_out;
        $display("Out: %d %h", i, round_out);
    end
    
    plaintext_check = round_out;



endtask


initial begin
    // actual top level tb:
    clock = 0;
	reset = 1;

    //
    golden_model(key_in, ciphertext_in, plaintext_check);
    
    @(posedge clock);
	reset = 0;
    @(posedge clock);
    // setting key:
    io_in = 0;

    io_in[7:0] = key_in[15:8];
    io_in[8] = 1;
    io_in[10] = 1'b1;
    @(posedge clock);
    

  io_in[7:0] = key_in[7:0];
    io_in[8] = 0;
    io_in[10] = 1'b1;
    @(posedge clock);


    io_in = 0;
    // setting ciphertext:
    
    io_in[7:0] = ciphertext_in[15:8];
    io_in[8] = 1;
    io_in[9] = 1'b1;
    @(posedge clock);

    io_in[7:0] = ciphertext_in[7:0];
    io_in[8] = 0;
    io_in[9] = 1'b1;
    @(posedge clock);
    

    io_in = 0;
    @(posedge clock);

    io_in[11] = 1'b1;

    @(posedge clock);

    io_in[11] = 1'b0;

    wait (io_out[11] == 1'b1);

    @(posedge clock);
    io_in[11] = 1'b1;
    io_in[8:5] = 0;
    @(posedge clock);

    for (int i = 0; i < 2; i++) begin
        //@(posedge clock);
        io_in[11] = 1'b1;
        io_in[8] = i;
        @(posedge clock);
      plaintext[i*8+7-:8] = io_out[7:0];
        $display("current %h", io_out[7:0]);
    end
    @(posedge clock);
  
    plaintext[15:8] = io_out[7:0];

  $display("Ciphertext out %h %h", plaintext, plaintext_check);
  
  assert(plaintext_check == plaintext);
		
	$finish();
end

always begin
	clock = #10 ~clock;
end
endmodule