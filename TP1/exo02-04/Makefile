all: build

add1bit:
	ghdl -a add1bit.vhdl

addnbit:
	ghdl -a addnbit.vhdl

add1bit_tb: add1bit add1bit_tb.vhdl
	ghdl -a add1bit_tb.vhdl
	ghdl -e add1bit_tb

addnbit_tb: addnbit addnbit_tb.vhdl
	ghdl -a addnbit_tb.vhdl
	ghdl -e addnbit_tb

build: add1bit_tb addnbit_tb

sim: build
	./add1bit_tb --vcd=add1bit_tb.vcd --stop-time=10ps
	./addnbit_tb --vcd=addnbit_tb.vcd --stop-time=10ps
#	gtkwave add1bit_tb.vcd
	gtkwave addnbit_tb.vcd

clean:
	rm -rf *.o *.cf *.vcd *_tb