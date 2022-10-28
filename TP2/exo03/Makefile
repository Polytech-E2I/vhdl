all: build

registre: registre.vhdl
	ghdl -a registre.vhdl

registre_tb: registre registre_tb.vhdl
	ghdl -a registre_tb.vhdl
	ghdl -e registre_tb


build: registre_tb

sim: build
	./registre_tb --vcd=registre_tb.vcd --stop-time=10ps
	gtkwave registre_tb.vcd

clean:
	rm -rf *.o *.cf *.vcd *_tb