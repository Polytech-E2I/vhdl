program = unitcont

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
alu: modifin addnbit
	ghdl -a alu.vhdl
registre: registre.vhdl
	ghdl -a registre.vhdl
ram: ram.vhdl
	ghdl -a -fsynopsys ram.vhdl
memreg: ram registre
	ghdl -a memreg.vhdl
instdecodeur: instdecodeur.vhdl
	ghdl -a instdecodeur.vhdl

$(program): $(program).vhdl instdecodeur memreg mux2v1 alu
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
