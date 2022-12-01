program = pgcounter

all: build

add1bit: add1bit.vhdl
	ghdl -a add1bit.vhdl
addnbit: addnbit.vhdl add1bit
	ghdl -a addnbit.vhdl
increment: increment.vhdl addnbit
	ghdl -a increment.vhdl
mux2v1: mux2v1.vhdl
	ghdl -a mux2v1.vhdl
registre: registre.vhdl
	ghdl -a registre.vhdl
loadcount: loadcount.vhdl addnbit increment mux2v1 registre
	ghdl -a loadcount.vhdl

ram: ram.vhdl
	ghdl -a -fsynopsys ram.vhdl

$(program): $(program).vhdl loadcount ram
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
