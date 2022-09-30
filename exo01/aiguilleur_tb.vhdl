library ieee;
use ieee.std_logic_1164.all;

entity aiguilleur_tb is
end aiguilleur_tb;

architecture tb of aiguilleur_tb is
    signal Ain, Bin : integer;
    signal C : std_logic;
    signal Aout, Bout : integer;
begin

    AIGUILLEUR: entity work.aiguilleur port map (Ain => Ain, Bin => Bin, C => C, Aout => Aout, Bout => Bout);

    Ain <= 5;
    Bin <= 3;

    C <= '0', '1' after 10 ms, '0' after 20 ms, '1' after 30 ms;
end tb;