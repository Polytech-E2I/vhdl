library ieee;
use ieee.std_logic_1164.all;

entity aiguilleur_tb is
end aiguilleur_tb;

architecture arch_aiguilleur_tb of aiguilleur_tb is
	component aiguilleur
		port(
			Ain, Bin: in integer;
			C: in std_logic;
			Aout, Bout: out integer
		);
	end component;

	signal sAin, sBin, sAout, sBout: integer;
	signal sc: std_logic;
begin

DUT : aiguilleur
	port map (
		Ain => sAin,
		Bin => sBin,
		C => sC,
 		Aout => sAout,
		Bout => sBout
	);

	sAin <= 7, 5 after 10 ns;
	sBin <= 12, 32 after 10 ns;
	sc <= '0', '1' after 10 ns, '0' after 20 ns;

end architecture;
