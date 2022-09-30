all: build

aiguilleur:
	ghdl -a aiguilleur.vhdl

aiguilleur_tb: aiguilleur aiguilleur_tb.vhdl
	ghdl -a aiguilleur_tb.vhdl
	ghdl -e aiguilleur_tb

reseau:
	ghdl -a -fsynopsys reseau.vhdl

reseau_tb: reseau reseau_tb.vhdl
	ghdl -a -fsynopsys reseau_tb.vhdl
	ghdl -e -fsynopsys reseau_tb

build: aiguilleur_tb reseau_tb

sim: build
	./aiguilleur_tb --vcd=aiguilleur_tb.vcd
	./reseau_tb --vcd=reseau_tb.vcd
#	gtkwave aiguilleur_tb.vcd
	gtkwave reseau_tb.vcd

clean:
	rm *.o *.cf