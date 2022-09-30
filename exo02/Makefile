all: build

add1bit:
	ghdl -a add1bit.vhdl

addnbit:
	ghdl -a addnbit.vhdl

add1bit_tb: add1bit add1bit_tb.vhdl
	ghdl -a add1bit_tb.vhdl
	ghdl -e add1bit_tb


build: add1bit_tb

sim: build
	./add1bit_tb --vcd=add1bit_tb.vcd
	gtkwave add1bit_tb.vcd

clean:
	rm *.o *.cf