library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registre_tb is
end;

architecture tb of registre_tb is
    constant N: natural := 4;

    -- UUT component
    component registre is
        generic(
            N: natural
        );
        port(
            D:      in std_logic_vector(N-1 downto 0);
            load:   in std_logic;
            nrst:   in std_logic;
            clk:    in std_logic;
            Q:      out std_logic_vector(N-1 downto 0)
        );
    end component;

    -- UUT input signals
    signal D: std_logic_vector(N-1 downto 0) := (others => 'U');
    signal load:    std_logic := '0';
    signal nrst:    std_logic := '0';
    signal clk:     std_logic := '0';
    -- UUT output signals
    signal Q: std_logic_vector(N-1 downto 0) := (others => 'U');

    constant clock_period: time := 1 fs;

begin
    UUT: registre
        generic map(
            N => N
        )
        port map(
            D => D,
            load => load,
            nrst => nrst,
            clk => clk,
            Q => Q
        );

    D <= std_logic_vector(to_unsigned(13, D'length));
    clk <= not clk after clock_period;
    load <= not load after clock_period * 2;
    nrst <= '1', '0' after 7 fs;
end;