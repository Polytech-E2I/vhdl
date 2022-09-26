all: build

add1bit:
	ghdl -a add1bit.vhdl

add1bit_tb: add1bit add1bit_tb.vhdl
	ghdl -a add1bit_tb.vhdl
	ghdl -r add1bit_tb


build: add1bit_tb

sim: build
	ghdl -r add1bit_tb --vcd=aiguilleur.vcd

clean:
	rm *.o *.cf