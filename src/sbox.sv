module InvSbox
(  
    input  logic in,
    output logic out
);

    assign out = ~in;

endmodule

module sbox
( 
    input  logic in,
    output logic  out
);
    
    assign out = ~in;
endmodule