library ieee;
use ieee.std_logic_1164.all;

entity aiguilleur_tb is
end entity;

architecture beh of aiguilleur_tb is
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
    signal C:           std_logic := 'U';
    -- UUT output signals
    signal Aout, Bout:  integer := 0;

begin

    UUT: aiguilleur port map(
        Ain => Ain,
        Bin => Bin,
        C => C,
        Aout => Aout,
        Bout => Bout
    );

    Ain <= 5, 7 after 1 fs, 12 after 2 fs;
    Bin <= 7, 9 after 1 fs, 3 after 2 fs;
    C <= '0', '1' after 1 fs, '0' after 2 fs;
end architecture;