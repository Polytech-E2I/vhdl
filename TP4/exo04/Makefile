program = condition

all: build

$(program): $(program).vhdl
	ghdl -a $(program).vhdl

$(program)_tb: $(program) $(program)_tb.vhdl
	ghdl -a $(program)_tb.vhdl
	ghdl -e -fsynopsys $(program)_tb
#	ghdl -e $(program)_cfg1


build: $(program)_tb

sim: build
	./$(program)_tb --vcd=$(program)_tb.vcd --stop-time=10ps
#	./$(program)_cfg1 --vcd=$(program)_tb.vcd --stop-time=10ps
	gtkwave $(program)_tb.vcd $(program)_tb.gtkw

clean:
	rm -rf *.o *.cf *.vcd *_tb
