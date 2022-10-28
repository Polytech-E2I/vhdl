all: build

sous1bit:
	ghdl -a sous1bit.vhdl

addnbit:
	ghdl -a addnbit.vhdl

sous1bit_tb: sous1bit sous1bit_tb.vhdl
	ghdl -a sous1bit_tb.vhdl
	ghdl -e sous1bit_tb


build: sous1bit_tb

sim: build
	./sous1bit_tb --vcd=sous1bit_tb.vcd --stop-time=10ps
	gtkwave sous1bit_tb.vcd

clean:
	rm -rf *.o *.cf *.vcd *_tb