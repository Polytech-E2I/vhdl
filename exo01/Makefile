all: build

aiguilleur:
	ghdl -a aiguilleur.vhdl

aiguilleur_tb: aiguilleur aiguilleur_tb.vhdl
	ghdl -a aiguilleur_tb.vhdl
	ghdl -r aiguilleur_tb

# reseau:
# 	ghdl -a reseau.vhdl

# reseau_tb: reseau reseau_tb.vhdl
# 	ghdl -a reseau_tb.vhdl
# 	ghdl -r reseau_tb

build: aiguilleur_tb

sim: build
	ghdl -r aiguilleur_tb --vcd=aiguilleur.vcd
	# ghdl -r reseau_tb --vcd=reseau.vcd
	# gtkwave aiguilleur.vcd
	# gtkwave reseau.vcd
