program = dp_sumn

all: build

$(program): $(program).vhdl
#	ghdl -a $(program).vhdl
	ghdl -a *.vhdl

$(program)_tb: $(program) $(program)_tb.vhdl
	ghdl -a $(program)_tb.vhdl
	ghdl -e $(program)_tb


build: $(program)_tb

sim: build
#	./$(program)_tb --vcd=$(program)_tb.vcd --stop-time=10ps
#	gtkwave $(program)_tb.vcd
	./$(program)_tb --wave=$(program)_tb.ghw --stop-time=10ps
	gtkwave $(program)_tb.ghw $(program)_tb.gtkw

clean:
	rm -rf *.o *.cf *.vcd *_tb