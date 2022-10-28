library ieee;
use ieee.std_logic_1164.all;

entity add1bit_tb is
end;

architecture tb of add1bit_tb is
    --- UUT component
    component ADD1BIT
        port(
            Ain, Bin, Cin:  in std_logic;
            Cout, S:        out std_logic
        );
    end component;

    --- UUT input signals
    signal Ain: std_logic := '0';
    signal Bin: std_logic := '0';
    signal Cin: std_logic := '0';
    --- UUT output signals
    signal Cout, S:         std_logic := 'U';

    constant clock_period1: time := 1 fs;
    constant clock_period2: time := 2 fs;
    constant clock_period3: time := 4 fs;

begin
    ADD_A: ADD1BIT port map(
        Ain     => Ain,
        Bin     => Bin,
        Cin     => Cin,
        Cout    => Cout,
        S       => S
    );

    Ain <= not Ain after clock_period1;
    Bin <= not Bin after clock_period2;
    Cin <= not Cin after clock_period3;
end tb;