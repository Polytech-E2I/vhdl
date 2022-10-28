all: build

add1bit:
	ghdl -a add1bit.vhdl

addnbit: add1bit
	ghdl -a addnbit.vhdl

increment: addnbit
	ghdl -a increment.vhdl

increment_tb: increment increment_tb.vhdl
	ghdl -a increment_tb.vhdl
	ghdl -e increment_tb


build: increment_tb

sim: build
	./increment_tb --vcd=increment_tb.vcd --stop-time=10ps
	gtkwave increment_tb.vcd

clean:
	rm -rf *.o *.cf *.vcd *_tb