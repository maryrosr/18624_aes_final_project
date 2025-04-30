TOPLEVEL_LANG = verilog
VERILOG_SOURCES = ../src/aes.sv ../src/round.sv ../src/sbox.sv ../src/subbytes.sv ../src/scheduler.sv ../src/inv_mixcolums.sv ../src/inv_shiftrows.sv
TOPLEVEL = aes
MODULE = aes_tb
SIM = verilator
EXTRA_ARGS += --trace -Wno-WIDTHTRUNC -Wno-UNOPTFLAT -Wno-fatal
include $(shell cocotb-config --makefiles)/Makefile.sim
