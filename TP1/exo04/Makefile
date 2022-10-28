all: build

addnbit:
	ghdl -a addnbit.vhdl

addnbit_tb: addnbit addnbit_tb.vhdl
	ghdl -a addnbit_tb.vhdl
	ghdl -e addnbit_tb


build: addnbit_tb

sim: build
	./addnbit_tb --vcd=addnbit_tb.vcd --stop-time=10ps
	gtkwave addnbit_tb.vcd

clean:
	rm -rf *.o *.cf *.vcd *_tb