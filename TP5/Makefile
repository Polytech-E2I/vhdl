program = unitcont

GHDLFLAGS=-fsynopsys
#GHDLFLAGS=--ieee=synopsys -fexplicit
COMPIL1 = ghdl -a $(GHDLFLAGS)
COMPIL2 = ghdl -e $(GHDLFLAGS)
SIM = gtkwave $(program)_tb.vcd $(program)_tb.gtkw

#COMPIL1 = ncvhdl -V93 -WORK tp_lib -MESSAGES -NOCOPYRIGHT -LINE
#COMPIL2 = ncelab -access rw -messages TP_LIB_.$(program):UUT -nowarn CUDEFB
#SIM = ncsim -gui TP_LIB.$(program)_TB:UUT

all: build

add1bit: add1bit.vhdl
	$(COMPIL1) add1bit.vhdl
addnbit: addnbit.vhdl add1bit
	$(COMPIL1) addnbit.vhdl
inverseur: inverseur.vhdl
	$(COMPIL1) inverseur.vhdl
mux2v1: mux2v1.vhdl
	$(COMPIL1) mux2v1.vhdl
modifin: modifin.vhdl inverseur mux2v1
	$(COMPIL1) modifin.vhdl
alu: modifin addnbit
	$(COMPIL1) alu.vhdl
registre: registre.vhdl
	$(COMPIL1) registre.vhdl
ram: ram.vhdl
	$(COMPIL1) ram.vhdl
memreg: ram registre
	$(COMPIL1) memreg.vhdl
instdecodeur: instdecodeur.vhdl
	$(COMPIL1) instdecodeur.vhdl
registre: registre.vhdl
	$(COMPIL1) registre.vhdl
increment: increment.vhdl addnbit
	$(COMPIL1) increment.vhdl
loadcount: loadcount.vhdl addnbit increment mux2v1 registre
	$(COMPIL1) loadcount.vhdl
pgcounter: pgcounter.vhdl loadcount ram
	$(COMPIL1) pgcounter.vhdl
condition: condition.vhdl
	$(COMPIL1) condition.vhdl

$(program): $(program).vhdl instdecodeur memreg mux2v1 alu condition
	$(COMPIL1) $(program).vhdl

$(program)_tb: $(program) $(program)_tb.vhdl pgcounter ram
	$(COMPIL1) $(program)_tb.vhdl
	$(COMPIL2) $(program)_tb
#	$(COMPIL2) $(program)_cfg1


build: $(program)_tb

sim: build
	./$(program)_tb --vcd=$(program)_tb.vcd --stop-time=10ps
#	./$(program)_cfg1 --vcd=$(program)_tb.vcd --stop-time=10ps
	$(SIM)

clean:
	rm -rf *.o *.cf *.vcd *_tb
