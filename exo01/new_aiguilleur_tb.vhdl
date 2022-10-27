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

    SAin <= 5, 7 after 1 fs, 12 after 2 fs;
    SBin <= 7, 9 after 1 fs, 3 after 2 fs;
    SC <= '0', '1' after 1 fs, '0' after 2 fs;
end architecture;