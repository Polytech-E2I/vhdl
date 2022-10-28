all: build

mux2v1: mux2v1.vhdl
	ghdl -a mux2v1.vhdl

mux2v1_tb: mux2v1 mux2v1_tb.vhdl
	ghdl -a mux2v1_tb.vhdl
	ghdl -e mux2v1_tb


build: mux2v1_tb

sim: build
	./mux2v1_tb --vcd=mux2v1_tb.vcd --stop-time=10ps
	gtkwave mux2v1_tb.vcd

clean:
	rm -rf *.o *.cf *.vcd *_tb