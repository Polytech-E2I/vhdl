program = addnbit

all: build

add1bit:
	ghdl -a add1bit.vhdl

$(program): $(program).vhdl add1bit
	ghdl -a $(program).vhdl

$(program)_tb: $(program) $(program)_tb.vhdl
	ghdl -a $(program)_tb.vhdl
	ghdl -e $(program)_tb


build: $(program)_tb

sim: build
	./$(program)_tb --vcd=$(program)_tb.vcd --stop-time=10ps
	gtkwave $(program)_tb.vcd

clean:
	rm -rf *.o *.cf *.vcd *_tb