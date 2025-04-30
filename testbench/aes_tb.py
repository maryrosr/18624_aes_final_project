
import os
import aes
import logging
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import *
from cocotb.runner import *
from cocotb.triggers import Timer


@cocotb.test()
async def aes_correctness(dut):
    # generate random input:
    key = os.urandom(16)
    plaintext = os.urandom(16)

    
    encrypted = aes.encrypt(key, plaintext)
    decrypted = aes.decrypt(key, encrypted)

    print(plaintext.hex(), key.hex(), encrypted.hex(), decrypted.hex())
    assert(plaintext == decrypted)

    #print(aes.AES(key).decrypt_ctr(encrypted, iv))  
    
    # set inputs to aes module:

    # wait for done input, print round number to make sure its running

    # check outputs







