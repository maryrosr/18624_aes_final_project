module key_tb();

    logic clock, reset;
    logic [15:0] key_in;
    
  logic [15:0] plaintext, ciphertext_in, plaintext_check, temp_key, temp1_key;
    logic [3:0] rot;
    logic [11:0] io_in, io_out;
    logic [15:0] [15:0] keys_out;
    my_chip DUT (.clock, .reset, .io_in, .io_out);

task golden_model(output logic [15:0] key_in, output logic [15:0] ciphertext_in, output logic [15:0] plaintext_out);
    
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
        
    end

    // AES:
    ciphertext_in = $urandom % 65536; // can also choose value
	key_in = temp1_key;
    //round_in = ciphertext_in ^ keys_out[15];




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
        io_in[8:5] = i;
        @(posedge clock);
      plaintext[i*8+7-:8] = io_out[7:0];
       
    end
    @(posedge clock);
    plaintext[15:8] = io_out[7:0];

    //$display("Ciphertext out %h", plaintext);
  
  for(int i = 0; i < 11; i ++) begin
    $display("%d, %h", i, DUT.keys_out[i*16+15-:16]);
    assert(DUT.keys_out[i*16+15-:16] == keys_out[i]);
  end
	
		
	$finish();
end

always begin
	clock = #10 ~clock;
  
end
endmodule