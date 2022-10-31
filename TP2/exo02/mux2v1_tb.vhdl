library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2v1_tb is
end;

architecture tb of mux2v1_tb is
    constant N: natural := 4;

    -- UUT component
    component mux2v1 is
        generic(
            N:  natural
        );

        port(
            D0: in std_logic_vector(N-1 downto 0);
            D1: in std_logic_vector(N-1 downto 0);
            S:  in std_logic;
            Y:  out std_logic_vector(N-1 downto 0)
        );
    end component;

    -- UUT input signals
    signal D0:  std_logic_vector(N-1 downto 0) := (others => 'U');
    signal D1:  std_logic_vector(N-1 downto 0) := (others => 'U');
    signal S:   std_logic := '0';
    -- UUT output signals
    signal Y:   std_logic_vector(N-1 downto 0);

    constant clock_period: time := 1 fs;

begin
    UUT: mux2v1
        generic map(
            N => N
        )
        port map(
            D0 => D0,
            D1 => D1,
            S => S,
            Y => Y
        );
    D0 <= std_logic_vector(to_unsigned(7, D0'length));
    D1 <= std_logic_vector(to_unsigned(13, D1'length));

    S <= not S after clock_period;
end;