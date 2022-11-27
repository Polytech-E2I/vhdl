program = modifin

all: build

inverseur: inverseur.vhdl
	ghdl -a inverseur.vhdl
mux2v1: mux2v1.vhdl
	ghdl -a mux2v1.vhdl

$(program): $(program).vhdl inverseur mux2v1
	ghdl -a $(program).vhdl

$(program)_tb: $(program) $(program)_tb.vhdl
	ghdl -a $(program)_tb.vhdl
	ghdl -e $(program)_tb


build: $(program)_tb

sim: build
	./$(program)_tb --vcd=$(program)_tb.vcd --stop-time=10ps
	gtkwave $(program)_tb.vcd $(program)_tb.gtkw

clean:
	rm -rf *.o *.cf *.vcd *_tb