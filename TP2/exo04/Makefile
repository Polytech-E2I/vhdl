all: build

inverseur: inverseur.vhdl
	ghdl -a inverseur.vhdl

inverseur_tb: inverseur inverseur_tb.vhdl
	ghdl -a inverseur_tb.vhdl
	ghdl -e inverseur_tb


build: inverseur_tb

sim: build
	./inverseur_tb --vcd=inverseur_tb.vcd --stop-time=10ps
	gtkwave inverseur_tb.vcd

clean:
	rm -rf *.o *.cf *.vcd *_tb