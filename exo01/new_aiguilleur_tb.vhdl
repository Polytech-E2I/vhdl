library ieee;
use ieee.std_logic_1164.all;

entity new_aiguilleur_tb is
end entity;

architecture beh of new_aiguilleur_tb is
    component AIG is
        port (Ain, Bin : in integer;
        C : in std_logic;
        Aout, Bout: out integer);
    end component;

    signal SAin, SBin, SAout, SBout : integer;
    signal SC : std_logic;

    begin

    AIGTEST: AIG port map(SAin, SBin, SC, SAout, SBout);

    SAin <= 5, 7 after 10 ns, 12 after 20 ns;
    SBin <= 7, 9 after 10 ns, 3 after 20 ns;
    SC <= '0' after 2 ns, '1' after 10 ns, '0' after 20 ns;
end architecture;