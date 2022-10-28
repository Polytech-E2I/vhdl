library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity addnbit_tb is
end;

architecture tb of addnbit_tb is
    --- UUT component
    component addnbit
        generic(
            N:          natural
        );
        port(
            Ain, Bin:   in std_logic_vector(N-1 downto 0);
            S:          out std_logic_vector(N-1 downto 0);
            C:          out std_logic
        );
    end component;


    constant N:     natural := 4;
    --- UUT input signals
    signal Ain:     std_logic_vector(N-1 downto 0) := (others => 'U');
    signal Bin:     std_logic_vector(N-1 downto 0) := (others => 'U');
    --- UUT output signals
    signal S:       std_logic_vector(N-1 downto 0);
    signal C:       std_logic;

begin
    ADDN: addnbit
    generic map(
        N => N
    )
    port map(
        Ain     => Ain,
        Bin     => Bin,
        S       => S,
        C       => C
    );

    Ain <=
        std_logic_vector(to_unsigned(9, Ain'length)),
        std_logic_vector(to_unsigned(3, Ain'length)) after 1 fs,
        std_logic_vector(to_unsigned(0, Ain'length)) after 2 fs;
    Bin <=
        std_logic_vector(to_unsigned(9, Bin'length)),
        std_logic_vector(to_unsigned(7, Bin'length)) after 1 fs,
        std_logic_vector(to_unsigned(0, Bin'length)) after 2 fs;
end tb;
