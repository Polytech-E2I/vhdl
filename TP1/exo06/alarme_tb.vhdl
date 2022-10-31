library ieee;
use ieee.std_logic_1164.all;

entity alarme_tb is
end;

architecture tb of alarme_tb is
    -- UUT component
    component alarme is
        port(
            V, P, F:    in std_logic;
            S:          out std_logic
        );
    end component;

    -- UUT input signals
    signal V, P, F: std_logic := '0';
    signal S:       std_logic := 'U';

    constant clock_period: time := 1 fs;

begin
    UUT: alarme port map(
        V => V,
        P => P,
        F => F,
        S => S
    );

    F <= not F after clock_period;
    P <= not P after clock_period * 2;
    V <= not V after clock_period * 4;
end;
