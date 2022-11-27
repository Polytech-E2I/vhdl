program = alu

all: build

add1bit: add1bit.vhdl
	ghdl -a add1bit.vhdl
addnbit: addnbit.vhdl add1bit
	ghdl -a addnbit.vhdl
inverseur: inverseur.vhdl
	ghdl -a inverseur.vhdl
mux2v1: mux2v1.vhdl
	ghdl -a mux2v1.vhdl
modifin: modifin.vhdl inverseur mux2v1
	ghdl -a modifin.vhdl

$(program): $(program).vhdl modifin addnbit
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
