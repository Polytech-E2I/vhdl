library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity loadcount_tb is
end;

architecture tb of loadcount_tb is
    constant N: natural := 8;

    -- UUT component
    component loadcount is
        generic(
            N: natural
        );

        port(
            E:      in std_logic_vector(N-1 downto 0);
            st:     in std_logic;
            clk:    in std_logic;
            nrst:   in std_logic;

            S: out std_logic_vector(N-1 downto 0)
        );
    end component;

    -- UUT input signals
    signal E:       std_logic_vector(N-1 downto 0) := (others => 'U');
    signal st:      std_logic := '1';
    signal clk:     std_logic := '0';
    signal nrst:    std_logic := '0';
    --UUT output signals
    signal S1:      std_logic_vector(N-1 downto 0) := (others => 'U');
    signal S2:      std_logic_vector(N-1 downto 0) := (others => 'U');

    constant clock_period: time := 1 fs;

begin
    UUT1: loadcount
        generic map(
            N => N
        )
        port map(
            E => E,
            st => st,
            clk => clk,
            nrst => nrst,
            S => S1
        );
    UUT2: loadcount
        generic map(
            N => N
        )
        port map(
            E => E,
            st => st,
            clk => clk,
            nrst => nrst,
            S => S2
        );

    E <= std_logic_vector(to_unsigned(5, E'length));

    clk <= not clk      after clock_period;
    nrst <= '1', '0' after 32 fs, '1' after 42 fs;
    st <= '1', '0' after 20 fs, '1' after 47 fs, '0' after 52 fs;
end;

configuration loadcount_cfg1 of loadcount_tb is
    for tb
        for UUT1 : loadcount
            use entity work.loadcount(impl01);
        end for;
        for UUT2 : loadcount
            use entity work.loadcount(impl02);
        end for;
    end for;
end;