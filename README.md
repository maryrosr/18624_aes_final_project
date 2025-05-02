# 18-224/624 S25 Tapeout Template


1. Add your verilog source files to `source_files` in `info.yaml`. The top level of your chip should remain in `chip.sv` and be named `my_chip`

  
  

2. Optionally add other details about your project to `info.yaml` as well (this is only for GitHub - your final project submission will involve submitting these in a different format)

3. Do NOT edit `toplevel_chip.v`  `config.tcl` or `pin_order.cfg`

 # Final Project Submission Details 
  
1. Your design must synthesize at 30MHz but you can run it at any arbitrarily-slow frequency (including single-stepping the clock) on the manufactured chip. If your design must run at an exact frequency, it is safest to choose a lower frequency (i.e. 5MHz)

  

2. For your final project, we will ask you to submit some sort of testbench to verify your design. Include all relevant testing files inside the `testbench` repository

  
  

3. For your final project, we will ask you to submit documentation on how to run/test your design, as well as include your project proposal and progress reports. Include all these files inside the `docs` repository

  
  

4. Optionally, if you use any images in your documentation (diagrams, waveforms, etc) please include them in a separate `img` repository

  

5. Feel free to edit this file and include some basic information about your project (short description, inputs and outputs, diagrams, how to run, etc). An outline is provided below

# Final Project

## Mini AES

I chose to implement "mini" AES decryption. My AES decryption module will take in a 16-bit key and a 16 bit ciphertext and output a 16 bit plaintext. In order for AES to function on 16 bit inputs, I simplified some of the traditional AES algorithms to work on bits instead of bytes. However, my implementation is reversible - given a decrypted plaintext and key, if encrypted using the inverse of my module, it will generate the same ciphertext the plaintext was decrypted from. 

## IO

| Input/Output	| Description|																
|-------------|--------------------------------------------------|
| io_in[7:0]  | input 8 bits of ciphertext or key                |
| io_in[8]    | index pin, 1 to select upper 8 bit chunk, 0 to select lower|
| io_in[9]    | 1 to enter a cipher text value                   |
| io_in[10]   | 1 to enter a key value                           |
| io_in[11]   | 1 to start AES, also used to read output bits    |
| io_out[7:0] | 8 bits of plaintext, selected by index pin       |
| io_out[10:8]| unused                                           |
| io_out[11]  | LED lights up when done                          |

## How to Test

In order to test post tapeout, connect the 12 io_in pins to a simple breadboard circuit. The 8 info pins could be connected to 8 simple switch circuits to drive the pins. io_in[11:8] should be connected to buttons. In order to check if the resulting plaintext is correct, connect each of the 8 output pins to 8 LEDs, then connect the ready output pin to another LED. Run the provided system verilog test bench using your favorite open-source tool. This test bench contains the golden model, so it will print an input key, an input ciphertext, and an output plaintext. Check against the output shown on the LEDs. 

To test the RTL implementations, generate a ciphertext, key, and decrypted plaintext using the same test bench, then ensure all assertions pass. 
