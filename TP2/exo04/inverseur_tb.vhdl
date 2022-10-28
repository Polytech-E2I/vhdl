library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity inverseur_tb is
end;

architecture tb of inverseur_tb is
    constant N: natural := 4;

    -- UUT component
    component inverseur is
        generic(
            N:  natural
        );

        port(
            X:      in std_logic_vector(N-1 downto 0);
            Xinv:   out std_logic_vector(N-1 downto 0)
        );
    end component;

    -- UUT input signals
    signal X:       std_logic_vector(N-1 downto 0) := (others => 'U');
    -- UUT output signals
    signal Xinv:    std_logic_vector(N-1 downto 0) := (others => 'U');

begin
    UUT: inverseur
        generic map(
            N => N
        )
        port map(
            X => X,
            Xinv => Xinv
        );

    CASES: process
    begin
        for i in 0 to 10 loop
            X <= std_logic_vector(to_unsigned(i, X'length));
            wait for 1 fs;
        end loop;
    end process;
end;
