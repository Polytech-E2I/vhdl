all: build

aiguilleur:
	ghdl -a aiguilleur.vhdl

new_aiguilleur_tb: aiguilleur new_aiguilleur_tb.vhdl
	ghdl -a new_aiguilleur_tb.vhdl
	ghdl -e new_aiguilleur_tb

reseau:
	ghdl -a -fsynopsys reseau.vhdl

reseau_tb: reseau reseau_tb.vhdl
	ghdl -a -fsynopsys reseau_tb.vhdl
	ghdl -e -fsynopsys reseau_tb

build: new_aiguilleur_tb reseau_tb

sim: build
	./new_aiguilleur_tb --vcd=new_aiguilleur_tb.vcd
	./reseau_tb --vcd=reseau_tb.vcd
	gtkwave new_aiguilleur_tb.vcd
	# gtkwave reseau_tb.vcd

clean:
	rm -rf *.o *.cf *.vcd *_tb
