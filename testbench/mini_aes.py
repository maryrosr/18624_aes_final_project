# This script generates an input ciphertext, input key, and the associated
# output plaintext.

r_con = (
    0x00, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40,
    0x80, 0x1B, 0x36
)

def scheduler(key_in, round_num):
    msb = key_in[:4]
    rot_word = ""
    rot_word = msb[1] + msb[2] + msb[3] + msb[0]
    




def round_scheduler(key_in):
    key_in = format(key_in, '016b')
    keys_out = list()
    keys_out.append(key_in)
    for round_num in range(0, 11):
        new_key = scheduler(key_in, round_num)
        keys_out.append(new_key)
        key_in = new_key

    return keys_out