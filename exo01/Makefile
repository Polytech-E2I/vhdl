all: build

aiguilleur:
	ghdl -a aiguilleur.vhdl

aiguilleur_tb: aiguilleur aiguilleur_tb.vhdl
	ghdl -a aiguilleur_tb.vhdl
	ghdl -r aiguilleur_tb

sim:
	ghdl -r aiguilleur_tb --vcd=aiguilleur.vcd
	gtkwave aiguilleur.vcd

build: aiguilleur_tb