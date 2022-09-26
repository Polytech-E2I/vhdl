library ieee;
use ieee.std_logic_1164.all;

entity add1bit_tb is
end;

architecture tb of add1bit_tb is
    signal Ain, Bin, Cin: std_logic;
    signal Cout, S: std_logic;
begin
    ADD1BIT: entity work.add1bit port map (Ain, Bin, Cin, Cout, S);

    Ain <= '1';
    Bin <= '1';
    Cin <= '0';
end tb;