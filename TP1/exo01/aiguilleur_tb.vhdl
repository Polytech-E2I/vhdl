library ieee;
use ieee.std_logic_1164.all;

entity aiguilleur_tb is
end;

architecture tb of aiguilleur_tb is
    -- UUT component
    component aiguilleur is
        port(
            Ain, Bin:   in integer;
            C:          in std_logic;
            Aout, Bout: out integer
        );
    end component;

    -- UUT input signals
    signal Ain, Bin:    integer := 0;
    signal C:           std_logic := '0';
    -- UUT output signals
    signal Aout, Bout:  integer;

    constant clock_period: time := 1 fs;

begin
    UUT: aiguilleur port map(
        Ain => Ain,
        Bin => Bin,
        C => C,
        Aout => Aout,
        Bout => Bout
    );

    Ain <= 5;
    Bin <= 7;
    C <= not C after clock_period;
end;